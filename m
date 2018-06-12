Received: from eggs.gnu.org ([2001:4830:134:3::10]:50262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0t-0003Wi-4v
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0p-0007FF-JK
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:59 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSh0p-0007EM-8W
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:55 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 12 Jun 2018 12:58:31 +0200
Message-Id: <20180612105831.25703-9-laurent@vivier.eu>
In-Reply-To: <20180612105831.25703-1-laurent@vivier.eu>
References: <20180612105831.25703-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 8/8] linux-user/sparc64: Add inotify_rm_watch
 and tee syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180607184844.30126-5-richard.henderson@linaro.org>
---
 linux-user/sparc64/syscall_nr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/sparc64/syscall_nr.h b/linux-user/sparc64/syscall_nr.h
index 9391645598..0b91b896da 100644
--- a/linux-user/sparc64/syscall_nr.h
+++ b/linux-user/sparc64/syscall_nr.h
@@ -154,7 +154,7 @@
 #define TARGET_NR_poll               153 /* Common                                      */
 #define TARGET_NR_getdents64		154 /* Linux specific				   */
 #define TARGET_NR_fcntl64            155 /* Linux sparc32 Specific                      */
-/* #define TARGET_NR_getdirentries   156    SunOS Specific                              */
+#define TARGET_NR_inotify_rm_watch   156 /* Linux specific                              */
 #define TARGET_NR_statfs             157 /* Common                                      */
 #define TARGET_NR_fstatfs            158 /* Common                                      */
 #define TARGET_NR_umount             159 /* Common                                      */
@@ -278,7 +278,7 @@
 #define TARGET_NR_mq_notify		277
 #define TARGET_NR_mq_getsetattr	278
 #define TARGET_NR_waitid		279
-/*#define TARGET_NR_sys_setaltroot	280 available (was setaltroot) */
+#define TARGET_NR_tee                   280
 #define TARGET_NR_add_key		281
 #define TARGET_NR_request_key	282
 #define TARGET_NR_keyctl		283
-- 
2.14.4
