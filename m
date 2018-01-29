Received: from eggs.gnu.org ([2001:4830:134:3::10]:39587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1egGHm-0002Un-BT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1egGHl-0001EA-Jy
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:44:14 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1egGHl-0001E2-Dt
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:44:13 -0500
Received: by mail-pg0-x243.google.com with SMTP id s9so5380035pgq.13
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:44:13 -0800 (PST)
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Mon, 29 Jan 2018 12:43:44 -0800
Message-Id: <20180129204344.196196-4-anatol.pomozov@gmail.com>
In-Reply-To: <20180129204344.196196-1-anatol.pomozov@gmail.com>
References: <20180129204344.196196-1-anatol.pomozov@gmail.com>
Subject: [Qemu-devel] [PATCH 4/4] multiboot: Make elf64 loading
 functionality compatible with GRUB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jack.schwartz@oracle.com, Anatol Pomozov <anatol.pomozov@gmail.com>

GRUB is a reference multiboot implementation and supports loading elf64
binaries. Make QEMU to work similar was as GRUB.
---
 hw/i386/multiboot.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 79b89e4fee..676ac7c48d 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -168,11 +168,6 @@ int load_multiboot(FWCfgState *fw_cfg,
         int kernel_size;
         fclose(f);
 
-        if (((struct elf64_hdr*)header)->e_machine == EM_X86_64) {
-            fprintf(stderr, "Cannot load x86-64 image, give a 32bit one.\n");
-            exit(1);
-        }
-
         kernel_size = load_elf_ram(kernel_filename, NULL, NULL, &elf_entry,
                                &elf_low, &elf_high, 0, I386_ELF_MACHINE,
                                0, 0, NULL, true, &sections);
-- 
2.16.0.rc1.238.g530d649a79-goog
