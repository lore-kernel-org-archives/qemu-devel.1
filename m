Received: from eggs.gnu.org ([2001:4830:134:3::10]:53734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCh-0000dv-Oq
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceNCd-0002KJ-NQ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:39 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:57600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceNCd-0002JY-Cd
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:38:35 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:38:10 +0100
Message-Id: <20170216143816.2384-9-laurent@vivier.eu>
In-Reply-To: <20170216143816.2384-1-laurent@vivier.eu>
References: <20170216143816.2384-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 08/14] linux-user: Update sh4 syscall
 definitions to match Linux 4.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20170116223140.18634-2-glaubitz@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sh4/syscall_nr.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/linux-user/sh4/syscall_nr.h b/linux-user/sh4/syscall_nr.h
index e99f735..d6c1e05 100644
--- a/linux-user/sh4/syscall_nr.h
+++ b/linux-user/sh4/syscall_nr.h
@@ -372,3 +372,17 @@
 #define TARGET_NR_process_vm_writev     366
 #define TARGET_NR_kcmp                  367
 #define TARGET_NR_finit_module          368
+#define TARGET_NR_sched_getattr         369
+#define TARGET_NR_sched_setattr         370
+#define TARGET_NR_renameat2             371
+#define TARGET_NR_seccomp               372
+#define TARGET_NR_getrandom             373
+#define TARGET_NR_memfd_create          374
+#define TARGET_NR_bpf                   375
+#define TARGET_NR_execveat              376
+#define TARGET_NR_userfaultfd           377
+#define TARGET_NR_membarrier            378
+#define TARGET_NR_mlock2                379
+#define TARGET_NR_copy_file_range       380
+#define TARGET_NR_preadv2               381
+#define TARGET_NR_pwritev2              382
-- 
2.9.3
