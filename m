Received: from eggs.gnu.org ([2001:4830:134:3::10]:46607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5b-0005qm-VI
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5W-0002yh-2k
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:27 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gZn5U-0002eO-4S
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:21 -0500
Received: by mail-lj1-x243.google.com with SMTP id g11-v6so75895ljk.3
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 17:25:05 -0800 (PST)
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Date: Thu, 20 Dec 2018 04:24:36 +0300
Message-Id: <20181220012441.13694-2-viktor.prutyanov@phystech.edu>
In-Reply-To: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
References: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
Subject: [Qemu-devel] [PATCH v2 1/6] contrib/elf2dmp: fix elf.h including
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkagan@virtuozzo.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

Before this patch QEMU elf.h was not actually included.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 contrib/elf2dmp/qemu_elf.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index d85d6558fa..19d1299954 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -5,11 +5,11 @@
  *
  */
 
-#ifndef QEMU_ELF_H
-#define QEMU_ELF_H
+#ifndef ELF2DMP_ELF_H
+#define ELF2DMP_ELF_H
 
 #include <stdint.h>
-#include <elf.h>
+#include "elf.h"
 
 typedef struct QEMUCPUSegment {
     uint32_t selector;
@@ -48,4 +48,4 @@ void QEMU_Elf_exit(QEMU_Elf *qe);
 Elf64_Phdr *elf64_getphdr(void *map);
 Elf64_Half elf_getphdrnum(void *map);
 
-#endif /* QEMU_ELF_H */
+#endif /* ELF2DMP_ELF_H */
-- 
2.17.2
