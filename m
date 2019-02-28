Received: from eggs.gnu.org ([209.51.188.92]:38187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1gzLxs-0004I2-3Z
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1gzLxq-0005d6-TV
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:43:08 -0500
Message-ID: <4817f5c3b20aedba869608c06e76d11a722f4864.camel@gmail.com>
From: Aarushi Mehta <mehta.aaru20@gmail.com>
Date: Thu, 28 Feb 2019 19:12:45 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] trivial malloc to g_malloc in thunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>

Hi

This is a trivial contribution part of the BiteSizedTasks on the wiki.
I found this discussion http://git.corpit.ru/?p=qemu.git;a=commit;h=b45c03f585ea9bb1af76c73e82195418c294919d
on migrating even g_malloc to g_new, is this not appropriate for the same? 
The wiki can presumably use an update regarding this.

Signed-off-by: Aarushi <mehta.aaru20@gmail.com>
---
 thunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/thunk.c b/thunk.c
index d5d8645cd4..03fb2abab7 100644
--- a/thunk.c
+++ b/thunk.c
@@ -89,7 +89,7 @@ void thunk_register_struct(int id, const char *name, const argtype *types)
     for(i = 0;i < 2; i++) {
         offset = 0;
         max_align = 1;
-        se->field_offsets[i] = malloc(nb_fields * sizeof(int));
+        se->field_offsets[i] = g_malloc(nb_fields * sizeof(int));
         type_ptr = se->field_types;
         for(j = 0;j < nb_fields; j++) {
             size = thunk_type_size(type_ptr, i);
-- 
2.17.1
