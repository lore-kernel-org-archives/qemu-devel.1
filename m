Received: from eggs.gnu.org ([2001:4830:134:3::10]:50236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0o-0003SU-JR
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0m-0007Dd-TO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48159)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSh0m-0007Cq-IS
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:52 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 12 Jun 2018 12:58:28 +0200
Message-Id: <20180612105831.25703-6-laurent@vivier.eu>
In-Reply-To: <20180612105831.25703-1-laurent@vivier.eu>
References: <20180612105831.25703-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 5/8] linux-user/alpha: Fix epoll syscalls
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

These were named incorrectly, going so far as to invade strace.list.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180607184844.30126-2-richard.henderson@linaro.org>
[lv: replace tabs by spaces]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/syscall_nr.h | 6 +++---
 linux-user/strace.list        | 9 ---------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.h
index 00e14bb6b3..fbb1ed288b 100644
--- a/linux-user/alpha/syscall_nr.h
+++ b/linux-user/alpha/syscall_nr.h
@@ -343,9 +343,9 @@
 #define TARGET_NR_io_cancel			402
 #define TARGET_NR_exit_group			405
 #define TARGET_NR_lookup_dcookie		406
-#define TARGET_NR_sys_epoll_create		407
-#define TARGET_NR_sys_epoll_ctl		408
-#define TARGET_NR_sys_epoll_wait		409
+#define TARGET_NR_epoll_create          407
+#define TARGET_NR_epoll_ctl             408
+#define TARGET_NR_epoll_wait            409
 #define TARGET_NR_remap_file_pages		410
 #define TARGET_NR_set_tid_address		411
 #define TARGET_NR_restart_syscall		412
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a91e33f7e5..2bc5ba04d4 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1467,15 +1467,6 @@
 #ifdef TARGET_NR__sysctl
 { TARGET_NR__sysctl, "_sysctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_sys_epoll_create
-{ TARGET_NR_sys_epoll_create, "sys_epoll_create" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_sys_epoll_ctl
-{ TARGET_NR_sys_epoll_ctl, "sys_epoll_ctl" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_sys_epoll_wait
-{ TARGET_NR_sys_epoll_wait, "sys_epoll_wait" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_sysfs
 { TARGET_NR_sysfs, "sysfs" , NULL, NULL, NULL },
 #endif
-- 
2.14.4
