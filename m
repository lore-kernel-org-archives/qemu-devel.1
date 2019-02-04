Received: from eggs.gnu.org ([209.51.188.92]:59471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6x-00059A-RT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6v-0003b1-Lz
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:51 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj6v-0003ZZ-Ez
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:49 -0500
Received: by mail-wr1-x42a.google.com with SMTP id p4so945250wrt.7
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:36:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:29 +0100
Message-Id: <1549305379-51117-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/77] contrib/elf2dmp: fix elf.h including
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Before this patch QEMU elf.h was not actually included.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-Id: <20181220012441.13694-2-viktor.prutyanov@phystech.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/elf2dmp/qemu_elf.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index 86e6e68..da70aff 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -5,10 +5,10 @@
  *
  */
 
-#ifndef QEMU_ELF_H
-#define QEMU_ELF_H
+#ifndef ELF2DMP_ELF_H
+#define ELF2DMP_ELF_H
 
-#include <elf.h>
+#include "elf.h"
 
 typedef struct QEMUCPUSegment {
     uint32_t selector;
@@ -47,4 +47,4 @@ void QEMU_Elf_exit(QEMU_Elf *qe);
 Elf64_Phdr *elf64_getphdr(void *map);
 Elf64_Half elf_getphdrnum(void *map);
 
-#endif /* QEMU_ELF_H */
+#endif /* ELF2DMP_ELF_H */
-- 
1.8.3.1
