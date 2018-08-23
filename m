Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssgT-0003Sq-OO
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsser-0003Wc-Ly
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsser-0003W8-Eh
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:29 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:39:31 +0200
Message-Id: <20180823164025.12553-5-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/58] check-qjson: Cover whitespace more
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/check-qjson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 4daadc272b..188f683317 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1236,7 +1236,7 @@ static void simple_whitespace(void)
                     })),
         },
         {
-            .encoded = " [ 43 , { 'h' : 'b' }, [ ], 42 ]",
+            .encoded = "\t[ 43 , { 'h' : 'b' },\r\n\t[ ], 42 ]\n",
             .decoded = QLIT_QLIST(((QLitObject[]){
                         QLIT_QNUM(43),
                         QLIT_QDICT(((QLitDictEntry[]){
-- 
2.17.1
