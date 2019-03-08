Received: from eggs.gnu.org ([209.51.188.92]:37691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1h2LPC-00066F-SG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1h2LPA-0002eT-0P
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:43:42 -0500
Message-ID: <a09acf9e093c09a70896bb9886370cf7f049f941.camel@gmail.com>
From: Aarushi Mehta <mehta.aaru20@gmail.com>
Date: Sat, 09 Mar 2019 01:13:19 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] thunk: improve readability of allocation loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 thunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/thunk.c b/thunk.c
index 17f3d320bb..7f31cffe09 100644
--- a/thunk.c
+++ b/thunk.c
@@ -86,7 +86,7 @@ void thunk_register_struct(int id, const char *name, const argtype *types)
 #endif
     /* now we can alloc the data */
 
-    for(i = 0;i < 2; i++) {
+    for (i = 0; i < ARRAY_SIZE(se->field_offsets); i++) {
         offset = 0;
         max_align = 1;
         se->field_offsets[i] = g_new(int, nb_fields);
-- 
2.17.1
