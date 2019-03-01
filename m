Received: from eggs.gnu.org ([209.51.188.92]:34643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1gzoDL-0006eT-75
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1gzoDH-0002NX-GE
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:52:57 -0500
Message-ID: <5310bd5d152fa36c1828a7cbd19fc893739d1609.camel@gmail.com>
From: Aarushi Mehta <mehta.aaru20@gmail.com>
Date: Sat, 02 Mar 2019 01:22:29 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4] thunk: fix of malloc to g_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>Julia Suvorova <jusual@mail.ru>

>From 3c1cba63dc5070ab559a126e206557f27fbaea59 Mon Sep 17 00:00:00 2001
From: Aarushi Mehta <mehta.aaru20@gmail.com>
Date: Sat, 2 Mar 2019 01:11:42 +0530
Subject: [PATCH v4] thunk: fix of malloc to g_new

Note that since thunking occurs throughout the lifetime of the QEMU
instance, there is no matching 'free' to correct.

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 thunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/thunk.c b/thunk.c
index d5d8645cd4..17f3d320bb 100644
--- a/thunk.c
+++ b/thunk.c
@@ -89,7 +89,7 @@ void thunk_register_struct(int id, const char *name, const argtype *types)
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
