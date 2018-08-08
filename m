Received: from eggs.gnu.org ([2001:4830:134:3::10]:52350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-0006eE-9d
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBg-0008MS-4o
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBf-0008Lo-VK
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:36 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:02:41 +0200
Message-Id: <20180808120334.10970-4-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 03/56] check-qjson: Cover whitespace more
 thoroughly
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 81b92d6b0c..0a9a054c7b 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1236,7 +1236,7 @@ static void simple_whitespace(void)
                     })),
         },
         {
-            .encoded = " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
+            .encoded = "\t[ 43 , { 'h' : 'b' },\n\t[ ], 42 ]\n",
             .decoded = QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(43),
                         QLIT_QDICT(((QLitDictEntry[]){
-- 
2.17.1
