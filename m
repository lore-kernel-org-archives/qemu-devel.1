Received: from eggs.gnu.org ([2001:4830:134:3::10]:42786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1diTcr-00083k-Jk
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 18:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1diTcq-0002lt-Q7
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 18:50:53 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1diTcq-0002kD-Kf
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 18:50:52 -0400
Received: by mail-pg0-x243.google.com with SMTP id y129so11942172pgy.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 15:50:52 -0700 (PDT)
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Thu, 17 Aug 2017 15:50:38 -0700
Message-Id: <20170817225039.28269-2-anatol.pomozov@gmail.com>
In-Reply-To: <20170817225039.28269-1-anatol.pomozov@gmail.com>
References: <20170817225039.28269-1-anatol.pomozov@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] multiboot: load any machine type of ELF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Anatol Pomozov <anatol.pomozov@gmail.com>

x86 is not the only architecture supported by multiboot.
For example GRUB supports MIPS architecture as well.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 hw/i386/multiboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 19113c0fce..a49217ac62 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -173,7 +173,7 @@ int load_multiboot(FWCfgState *fw_cfg,
         }
 
         kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
-                               &elf_low, &elf_high, 0, I386_ELF_MACHINE,
+                               &elf_low, &elf_high, 0, EM_NONE,
                                0, 0);
         if (kernel_size < 0) {
             fprintf(stderr, "Error while loading elf kernel\n");
-- 
2.14.1.480.gb18f417b89-goog
