Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA339C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D8D206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D8D206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKcY-00040r-03
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiKMY-0005Kv-Td
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiKMW-0007zo-Ou
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:30 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52929)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiKMU-0007rr-OO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:28 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCsDe-1hr5nP2YyW-008qRP; Tue, 02 Jul 2019 17:05:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:40 +0200
Message-Id: <20190702150545.1872-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702150545.1872-1-laurent@vivier.eu>
References: <20190702150545.1872-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0DtDsipeI5xlKBzZ5zAjkIoh/fOmHbm+Y2u1jqMhF9/ErZnybl6
 nimhTIyeJOFlqkhWenc65zY4vtN8K6PFHbp/r3RJkWKFjFgOvK0FgzmtM/XXdOxvqLIwmf1
 WqTTuDtUZ85AXOZjAnxoe//RLdy/8UqFgBru9SfwbF0lycVwoFEU1+EPSuG+MarR0ZgVSFz
 qvdESXFrxQ/SI0o60T9qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Os+IG9qFYuE=:mrU00nF2eURaZnr3yl9LZR
 e5aYe8GEJtUFxbhcsMkazkiNcSh3jT6fOhOxKaDLK91V/5XcG8TrW+MRA7Z3Cpkfg49h72GV7
 22jRsrqRXnt8TaktN7uCmSOY0Sw2WyYZmUKu5VSjobhg3VU652iejA2NNucrtSAACNgzWbXJV
 PGQEYJLBhjZswHmnDZflTIoyA63J85vWkYQgUE1zNJfcH9w3T6hPXm9fhk3qGkU2f/H4r1GFN
 qCGo+XMxx99Oqmdk2eM5VwqP8lx6oQxnof/g0MuJF10HV/iarwpHArnbs1S1XOcvipkbaiRyy
 MUSfLfcqXs80MEQs77oZBQOAnTETFDSILwdv3CTrgQKg+XPbjKLQ8KBVdEFzDRvn0pQSruTRp
 g0zGXtoRwYJhMmf7mUpHrD0eHS/kCjKIpoJgKoUbh/g+4irn9xj3FhO19uY4YeTgE+aD63b0T
 nqBjh11jAK3XuE8yH9fSxSEVgHuhilYXteAThJXtpYY8TI2TrtjlrK0JcP/uacm7ULFd56UaI
 VfkrD6nGdndD90jfm/tAMI4aNnX8BSaydZ2EonQH0DcyZFulg9MlVRvfnw8e+NHHc47XLgxR3
 u1g1y6zV4A4BcO0T7OstEId55MBzEokguaDXZ3LQQNF/RKVEFB18BBRh7MhHZ9aQPuy5J4xWl
 i6/nUMxeHABLAfOwY8sQoRGGnM2BImUPjqEqzGT2wcLjf0ZoOXB3OwqKZBcR3ek1dCMbjZ/da
 yyODuQbetmN9RRlxAI0WgugRGor4STPsERkaxg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 1/6] linux-user: Add support for translation of
 statx() syscall
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Implement support for translation of system call statx().

The implementation is based on "best effort" approach: if host
is capable of executing statx(), host statx() is used. If not,
the implementation includes invoking a more mature system call
fstatat() on the host side to achieve as close as possible
functionality.

Support for statx() in kernel and glibc was, however, introduced
at different points of time (the difference is more than a year):

  - kernel: Linux 4.11 (30 April 2017)
  - glibc: glibc 2.28 (1 Aug 2018)

In this patch, the availability of statx() support is established
via __NR_statx (if it is defined, statx() is considered available).
This coincedes with statx() introduction in kernel.

However, the structure statx definition may not be available in
any header for hosts with glibc older than 2.28 (and it is, by
design, to be defined in one of glibc headers), even though the
full statx() functionality may be supported in kernel. Hence, a
structure "target_statx" is defined in this patch, to remove that
dependency on glibc headers, and to use statx() functionality as
soon as the host kernel is capable of supporting it. Such statx
structure definition is used for both target and host structures
statx (of course, this doesn't mean the endian arrangement is
the same on target and host - the endian conversion is done in
all necessary cases).

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1561718618-20218-2-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c      | 115 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  37 ++++++++++++
 2 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d2c9817938c9..39a37496fed5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -238,6 +238,7 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_inotify_init __NR_inotify_init
 #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
 #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
+#define __NR_sys_statx __NR_statx
 
 #if defined(__alpha__) || defined(__x86_64__) || defined(__s390x__)
 #define __NR__llseek __NR_lseek
@@ -316,6 +317,14 @@ _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
           unsigned long, idx1, unsigned long, idx2)
 #endif
 
+/*
+ * It is assumed that struct statx is architecture independent.
+ */
+#if defined(TARGET_NR_statx) && defined(__NR_statx)
+_syscall5(int, sys_statx, int, dirfd, const char *, pathname, int, flags,
+          unsigned int, mask, struct target_statx *, statxbuf)
+#endif
+
 static bitmask_transtbl fcntl_flags_tbl[] = {
   { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
   { TARGET_O_ACCMODE,   TARGET_O_RDWR,      O_ACCMODE,   O_RDWR,      },
@@ -6516,6 +6525,48 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
 }
 #endif
 
+#if defined(TARGET_NR_statx) && defined(__NR_statx)
+static inline abi_long host_to_target_statx(struct target_statx *host_stx,
+                                            abi_ulong target_addr)
+{
+    struct target_statx *target_stx;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_stx, target_addr,  0)) {
+        return -TARGET_EFAULT;
+    }
+    memset(target_stx, 0, sizeof(*target_stx));
+
+    __put_user(host_stx->stx_mask, &target_stx->stx_mask);
+    __put_user(host_stx->stx_blksize, &target_stx->stx_blksize);
+    __put_user(host_stx->stx_attributes, &target_stx->stx_attributes);
+    __put_user(host_stx->stx_nlink, &target_stx->stx_nlink);
+    __put_user(host_stx->stx_uid, &target_stx->stx_uid);
+    __put_user(host_stx->stx_gid, &target_stx->stx_gid);
+    __put_user(host_stx->stx_mode, &target_stx->stx_mode);
+    __put_user(host_stx->stx_ino, &target_stx->stx_ino);
+    __put_user(host_stx->stx_size, &target_stx->stx_size);
+    __put_user(host_stx->stx_blocks, &target_stx->stx_blocks);
+    __put_user(host_stx->stx_attributes_mask, &target_stx->stx_attributes_mask);
+    __put_user(host_stx->stx_atime.tv_sec, &target_stx->stx_atime.tv_sec);
+    __put_user(host_stx->stx_atime.tv_nsec, &target_stx->stx_atime.tv_nsec);
+    __put_user(host_stx->stx_btime.tv_sec, &target_stx->stx_atime.tv_sec);
+    __put_user(host_stx->stx_btime.tv_nsec, &target_stx->stx_atime.tv_nsec);
+    __put_user(host_stx->stx_ctime.tv_sec, &target_stx->stx_atime.tv_sec);
+    __put_user(host_stx->stx_ctime.tv_nsec, &target_stx->stx_atime.tv_nsec);
+    __put_user(host_stx->stx_mtime.tv_sec, &target_stx->stx_atime.tv_sec);
+    __put_user(host_stx->stx_mtime.tv_nsec, &target_stx->stx_atime.tv_nsec);
+    __put_user(host_stx->stx_rdev_major, &target_stx->stx_rdev_major);
+    __put_user(host_stx->stx_rdev_minor, &target_stx->stx_rdev_minor);
+    __put_user(host_stx->stx_dev_major, &target_stx->stx_dev_major);
+    __put_user(host_stx->stx_dev_minor, &target_stx->stx_dev_minor);
+
+    unlock_user_struct(target_stx, target_addr, 1);
+
+    return 0;
+}
+#endif
+
+
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
    futexes locally would make futexes shared between multiple processes
@@ -7094,7 +7145,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     abi_long ret;
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) \
     || defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64) \
-    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64)
+    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64) \
+    || defined(TARGET_NR_statx)
     struct stat st;
 #endif
 #if defined(TARGET_NR_statfs) || defined(TARGET_NR_statfs64) \
@@ -10172,6 +10224,67 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             ret = host_to_target_stat64(cpu_env, arg3, &st);
         return ret;
 #endif
+#if defined(TARGET_NR_statx)
+    case TARGET_NR_statx:
+        {
+            struct target_statx *target_stx;
+            int dirfd = arg1;
+            int flags = arg3;
+
+            p = lock_user_string(arg2);
+            if (p == NULL) {
+                return -TARGET_EFAULT;
+            }
+#if defined(__NR_statx)
+            {
+                /*
+                 * It is assumed that struct statx is architecture independent.
+                 */
+                struct target_statx host_stx;
+                int mask = arg4;
+
+                ret = get_errno(sys_statx(dirfd, p, flags, mask, &host_stx));
+                if (!is_error(ret)) {
+                    if (host_to_target_statx(&host_stx, arg5) != 0) {
+                        unlock_user(p, arg2, 0);
+                        return -TARGET_EFAULT;
+                    }
+                }
+
+                if (ret != -TARGET_ENOSYS) {
+                    unlock_user(p, arg2, 0);
+                    return ret;
+                }
+            }
+#endif
+            ret = get_errno(fstatat(dirfd, path(p), &st, flags));
+            unlock_user(p, arg2, 0);
+
+            if (!is_error(ret)) {
+                if (!lock_user_struct(VERIFY_WRITE, target_stx, arg5, 0)) {
+                    return -TARGET_EFAULT;
+                }
+                memset(target_stx, 0, sizeof(*target_stx));
+                __put_user(major(st.st_dev), &target_stx->stx_dev_major);
+                __put_user(minor(st.st_dev), &target_stx->stx_dev_minor);
+                __put_user(st.st_ino, &target_stx->stx_ino);
+                __put_user(st.st_mode, &target_stx->stx_mode);
+                __put_user(st.st_uid, &target_stx->stx_uid);
+                __put_user(st.st_gid, &target_stx->stx_gid);
+                __put_user(st.st_nlink, &target_stx->stx_nlink);
+                __put_user(major(st.st_rdev), &target_stx->stx_rdev_major);
+                __put_user(minor(st.st_rdev), &target_stx->stx_rdev_minor);
+                __put_user(st.st_size, &target_stx->stx_size);
+                __put_user(st.st_blksize, &target_stx->stx_blksize);
+                __put_user(st.st_blocks, &target_stx->stx_blocks);
+                __put_user(st.st_atime, &target_stx->stx_atime.tv_sec);
+                __put_user(st.st_mtime, &target_stx->stx_mtime.tv_sec);
+                __put_user(st.st_ctime, &target_stx->stx_ctime.tv_sec);
+                unlock_user_struct(target_stx, arg5, 1);
+            }
+        }
+        return ret;
+#endif
 #ifdef TARGET_NR_lchown
     case TARGET_NR_lchown:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3175440e9dd9..fffa89f2564b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2537,4 +2537,41 @@ struct target_user_cap_data {
 /* Return size of the log buffer */
 #define TARGET_SYSLOG_ACTION_SIZE_BUFFER   10
 
+struct target_statx_timestamp {
+   int64_t tv_sec;
+   uint32_t tv_nsec;
+   int32_t __reserved;
+};
+
+struct target_statx {
+   /* 0x00 */
+   uint32_t stx_mask;       /* What results were written [uncond] */
+   uint32_t stx_blksize;    /* Preferred general I/O size [uncond] */
+   uint64_t stx_attributes; /* Flags conveying information about the file */
+   /* 0x10 */
+   uint32_t stx_nlink;      /* Number of hard links */
+   uint32_t stx_uid;        /* User ID of owner */
+   uint32_t stx_gid;        /* Group ID of owner */
+   uint16_t stx_mode;       /* File mode */
+   uint16_t __spare0[1];
+   /* 0x20 */
+   uint64_t stx_ino;        /* Inode number */
+   uint64_t stx_size;       /* File size */
+   uint64_t stx_blocks;     /* Number of 512-byte blocks allocated */
+   uint64_t stx_attributes_mask; /* Mask to show what is supported */
+   /* 0x40 */
+   struct target_statx_timestamp  stx_atime;  /* Last access time */
+   struct target_statx_timestamp  stx_btime;  /* File creation time */
+   struct target_statx_timestamp  stx_ctime;  /* Last attribute change time */
+   struct target_statx_timestamp  stx_mtime;  /* Last data modification time */
+   /* 0x80 */
+   uint32_t stx_rdev_major;   /* Device ID of special file [if bdev/cdev] */
+   uint32_t stx_rdev_minor;
+   uint32_t stx_dev_major; /* ID of device containing file [uncond] */
+   uint32_t stx_dev_minor;
+   /* 0x90 */
+   uint64_t __spare2[14];  /* Spare space for future expansion */
+   /* 0x100 */
+};
+
 #endif
-- 
2.21.0


