Received: from eggs.gnu.org ([2001:4830:134:3::10]:46005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi0mY-0004DP-Ao
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi0mT-0001Oz-FL
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:07:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38487 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi0mT-0001N5-4Y
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:07:25 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:04:47 +0200
Message-Id: <1532451888-8958-10-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532451888-8958-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532451888-8958-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 09/10] linux-user: Update MIPS syscall
 numbers up to kernel 4.18 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Synchronize content of linux-user/mips/syscall_nr.h and
linux-user/mips64/syscall_nr.h with Linux kernel 4.18 headers.
This adds 9 new syscall numbers, the last being NR_io_pgetevents.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/syscall_nr.h   |  9 +++++++++
 linux-user/mips64/syscall_nr.h | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/linux-user/mips/syscall_nr.h b/linux-user/mips/syscall_nr.h
index ced3280..e70adfc 100644
--- a/linux-user/mips/syscall_nr.h
+++ b/linux-user/mips/syscall_nr.h
@@ -363,3 +363,12 @@
 #define TARGET_NR_userfaultfd           (TARGET_NR_Linux + 357)
 #define TARGET_NR_membarrier            (TARGET_NR_Linux + 358)
 #define TARGET_NR_mlock2                (TARGET_NR_Linux + 359)
+#define TARGET_NR_copy_file_range       (TARGET_NR_Linux + 360)
+#define TARGET_NR_preadv2               (TARGET_NR_Linux + 361)
+#define TARGET_NR_pwritev2              (TARGET_NR_Linux + 362)
+#define TARGET_NR_pkey_mprotect         (TARGET_NR_Linux + 363)
+#define TARGET_NR_pkey_alloc            (TARGET_NR_Linux + 364)
+#define TARGET_NR_pkey_free             (TARGET_NR_Linux + 365)
+#define TARGET_NR_statx                 (TARGET_NR_Linux + 366)
+#define TARGET_NR_rseq                  (TARGET_NR_Linux + 367)
+#define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 368)
diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_nr.h
index 746cc26..ff218a9 100644
--- a/linux-user/mips64/syscall_nr.h
+++ b/linux-user/mips64/syscall_nr.h
@@ -327,6 +327,15 @@
 #define TARGET_NR_userfaultfd           (TARGET_NR_Linux + 321)
 #define TARGET_NR_membarrier            (TARGET_NR_Linux + 322)
 #define TARGET_NR_mlock2                (TARGET_NR_Linux + 323)
+#define TARGET_NR_copy_file_range       (TARGET_NR_Linux + 324)
+#define TARGET_NR_preadv2               (TARGET_NR_Linux + 325)
+#define TARGET_NR_pwritev2              (TARGET_NR_Linux + 326)
+#define TARGET_NR_pkey_mprotect         (TARGET_NR_Linux + 327)
+#define TARGET_NR_pkey_alloc            (TARGET_NR_Linux + 328)
+#define TARGET_NR_pkey_free             (TARGET_NR_Linux + 329)
+#define TARGET_NR_statx                 (TARGET_NR_Linux + 330)
+#define TARGET_NR_rseq                  (TARGET_NR_Linux + 331)
+#define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 332)
 
 #else
 /*
@@ -653,4 +662,13 @@
 #define TARGET_NR_userfaultfd           (TARGET_NR_Linux + 317)
 #define TARGET_NR_membarrier            (TARGET_NR_Linux + 318)
 #define TARGET_NR_mlock2                (TARGET_NR_Linux + 319)
+#define TARGET_NR_copy_file_range       (TARGET_NR_Linux + 320)
+#define TARGET_NR_preadv2               (TARGET_NR_Linux + 321)
+#define TARGET_NR_pwritev2              (TARGET_NR_Linux + 322)
+#define TARGET_NR_pkey_mprotect         (TARGET_NR_Linux + 323)
+#define TARGET_NR_pkey_alloc            (TARGET_NR_Linux + 324)
+#define TARGET_NR_pkey_free             (TARGET_NR_Linux + 325)
+#define TARGET_NR_statx                 (TARGET_NR_Linux + 326)
+#define TARGET_NR_rseq                  (TARGET_NR_Linux + 327)
+#define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 328)
 #endif
-- 
2.7.4
