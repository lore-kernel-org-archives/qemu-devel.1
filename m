Received: from eggs.gnu.org ([2001:4830:134:3::10]:46193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-000347-7X
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKC-0001hX-RV
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKC-0001gc-Hh
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:07 +0200
Message-Id: <20180817150559.16243-9-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/60] check-qjson: Streamline
 escaped_string()'s test strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Merge a few closely related test strings, and drop a few redundant
ones.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/check-qjson.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 2f1890929d..730de46815 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -56,18 +56,8 @@ static void escaped_string(void)
         const char *utf8_out;
         int skip;
     } test_cases[] = {
-        { "\\b", "\b" },
-        { "\\f", "\f" },
-        { "\\n", "\n" },
-        { "\\r", "\r" },
-        { "\\t", "\t" },
-        { "/", "/" },
+        { "\\b\\f\\n\\r\\t\\\\\\\"", "\b\f\n\r\t\\\"" },
         { "\\/", "/", .skip = 1 },
-        { "\\\\", "\\" },
-        { "\\\"", "\"" },
-        { "hello world \\\"embedded string\\\"",
-          "hello world \"embedded string\"" },
-        { "hello world\\nwith new line", "hello world\nwith new line" },
         { "single byte utf-8 \\u0020", "single byte utf-8  ", .skip = 1 },
         { "double byte utf-8 \\u00A2", "double byte utf-8 \xc2\xa2" },
         { "triple byte utf-8 \\u20AC", "triple byte utf-8 \xe2\x82\xac" },
-- 
2.17.1
