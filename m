Received: from eggs.gnu.org ([209.51.188.92]:54723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1gzOpx-0001Vx-L7
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1gzOpv-0002Sb-45
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:47:09 -0500
Message-ID: <63559cf027d4ebd95a844b73b1f20444fb72fb2c.camel@gmail.com>
From: Aarushi Mehta <mehta.aaru20@gmail.com>
Date: Thu, 28 Feb 2019 22:16:57 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3] trivial fix of malloc to g_new in thunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>, eblake@redhat.com

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>

Note that since thunking occurs throughout the lifetime of the QEMU
instance, there is no matching 'free' to correct.

---
 thunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/thunk.c b/thunk.c
index d5d8645cd4..17f3d320bb 100644
--- a/thunk.c
+++ b/thunk.c
@@ -89,7 +89,7 @@ void thunk_register_struct(int id, const char *name,
const argtype *types)
     for(i = 0;i < 2; i++) {
         offset = 0;
         max_align = 1;
-        se->field_offsets[i] = malloc(nb_fields * sizeof(int));
+        se->field_offsets[i] = g_new(int, nb_fields);
         type_ptr = se->field_types;
         for(j = 0;j < nb_fields; j++) {
             size = thunk_type_size(type_ptr, i);
-- 
2.17.1
Regards
Aarushi Mehta
