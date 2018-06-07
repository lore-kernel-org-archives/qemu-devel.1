Received: from eggs.gnu.org ([2001:4830:134:3::10]:54664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQzxs-0005Vw-HV
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQzxr-0001hk-8j
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:52 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:47016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fQzxr-0001hP-3K
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:48:51 -0400
Received: by mail-pg0-x232.google.com with SMTP id d2-v6so5164781pga.13
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:48:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Jun 2018 11:48:41 -0700
Message-Id: <20180607184844.30126-2-richard.henderson@linaro.org>
In-Reply-To: <20180607184844.30126-1-richard.henderson@linaro.org>
References: <20180607184844.30126-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] linux-user/alpha: Fix epoll syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

These were named incorrectly, going so far as to invade strace.list.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/alpha/syscall_nr.h | 6 +++---
 linux-user/strace.list        | 9 ---------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.h
index 00e14bb6b3..6532376e3e 100644
--- a/linux-user/alpha/syscall_nr.h
+++ b/linux-user/alpha/syscall_nr.h
@@ -343,9 +343,9 @@
 #define TARGET_NR_io_cancel			402
 #define TARGET_NR_exit_group			405
 #define TARGET_NR_lookup_dcookie		406
-#define TARGET_NR_sys_epoll_create		407
-#define TARGET_NR_sys_epoll_ctl		408
-#define TARGET_NR_sys_epoll_wait		409
+#define TARGET_NR_epoll_create		407
+#define TARGET_NR_epoll_ctl		408
+#define TARGET_NR_epoll_wait		409
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
2.17.1
