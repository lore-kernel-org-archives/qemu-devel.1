Received: from eggs.gnu.org ([2001:4830:134:3::10]:41452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTFoh-0004gc-N4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1cTFoe-0001R1-KX
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:31:55 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:45235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1cTFoe-0001Q3-DF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:31:52 -0500
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 16 Jan 2017 23:31:40 +0100
Message-Id: <20170116223140.18634-2-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20170116223140.18634-1-glaubitz@physik.fu-berlin.de>
References: <20170116223140.18634-1-glaubitz@physik.fu-berlin.de>
Subject: [Qemu-devel] [PATCH] linux-user: Update sh4 syscall definitions to
 match Linux 4.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 linux-user/sh4/syscall_nr.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/linux-user/sh4/syscall_nr.h b/linux-user/sh4/syscall_nr.h
index e99f73589d..d6c1e059f6 100644
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
2.11.0
