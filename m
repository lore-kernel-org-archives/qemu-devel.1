Received: from eggs.gnu.org ([2001:4830:134:3::10]:54056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1e2nJb-00042I-BY
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1e2nJa-0001eu-Pj
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:54:59 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:45494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1e2nJa-0001ea-K6
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:54:58 -0400
Received: by mail-pf0-x241.google.com with SMTP id d28so7232118pfe.2
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 16:54:58 -0700 (PDT)
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Thu, 12 Oct 2017 16:54:37 -0700
Message-Id: <20171012235439.19457-3-anatol.pomozov@gmail.com>
In-Reply-To: <20171012235439.19457-1-anatol.pomozov@gmail.com>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
Subject: [Qemu-devel] [PATCH 2/4] multiboot: load any machine type of ELF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, rth@twiddle.net, ehabkost@redhat.com, pbonzini@redhat.com, agraf@suse.de, Anatol Pomozov <anatol.pomozov@gmail.com>

x86 is not the only architecture supported by multiboot.
For example GRUB supports MIPS architecture as well.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 hw/i386/multiboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index c9254f313e..7dacd6d827 100644
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
2.15.0.rc0.271.g36b669edcc-goog
