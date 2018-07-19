Received: from eggs.gnu.org ([2001:4830:134:3::10]:48648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8V2-00038s-3J
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Rs-0003MP-RL
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:57:40 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54753 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Rs-0003KS-Dj
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:54:24 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:52:06 +0200
Message-Id: <1532004727-13778-11-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 10/11] linux-user: Update MIPS syscall
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
This adds 7 new syscall numbers, the last being NR_statx.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/syscall_nr.h   |  7 +++++++
 linux-user/mips64/syscall_nr.h | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/linux-user/mips/syscall_nr.h b/linux-user/mips/syscall_nr.h
index ced3280..6bbca74 100644
--- a/linux-user/mips/syscall_nr.h
+++ b/linux-user/mips/syscall_nr.h
@@ -363,3 +363,10 @@
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
diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_nr.h
index 746cc26..2e44eae 100644
--- a/linux-user/mips64/syscall_nr.h
+++ b/linux-user/mips64/syscall_nr.h
@@ -327,6 +327,13 @@
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
 
 #else
 /*
@@ -653,4 +660,11 @@
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
 #endif
-- 
2.7.4
