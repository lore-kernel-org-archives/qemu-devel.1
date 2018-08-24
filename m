Received: from eggs.gnu.org ([2001:4830:134:3::10]:33181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoi-0002HV-19
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHoe-0001gA-LB
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHoc-0001YT-4c
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F00BA40216ED
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA6822156701
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:32:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:17 +0200
Message-Id: <20180824193206.25475-10-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 09/58] check-qjson: Streamline
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

Merge a few closely related test strings, and drop a few redundant
ones.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-10-armbru@redhat.com>
---
 tests/check-qjson.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 008b6e95e4..880453a93b 100644
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
