Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F2C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B292078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B292078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDIU-000747-7z
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHl-0005Vp-7R
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHi-0002ai-9o
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:00 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSI6i-1k8VB50nZg-00Sc3g; Mon, 07 Sep 2020 11:17:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] linux-user: Add support for ppoll_time64() and
 pselect6_time64()
Date: Mon,  7 Sep 2020 11:17:44 +0200
Message-Id: <20200907091748.376101-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907091748.376101-1-laurent@vivier.eu>
References: <20200907091748.376101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N+CfROGZniiCxcSFLIRFhL9tLoK/UdLLVqM8vE7Xuu0lQiKYk6a
 JgC+RSPjkuMgKSxWuT2KHVFgWZXUNXlRhp7wr8AuC6wUeG1gc/xJKzBps9DVB3qEUqWgwF9
 tToc2ltZnc7GfGcEVUQ/RbsItAiefxQomj42QQcs6Dqm4v774lx/P+7fIypnakgfpjA1n5W
 N/6v/71mk0yg+UjfVfldw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+82GtxHO0eQ=:PZsDhtD1sI634jf1i7Ti+Q
 FLIa+7M6jWWiZYUy6idiwE9Nw6MLAniw8QHRO7VOcwhWC6T1EaGU+nIequu8GR3THoFXpSu8R
 B3gVKHznVcgXPhTvJHMe2weD8OoKzCJXxt4X+Nd/A4fHUssUUoiFFpgetA1km7M/smbrmYV8m
 xwSXrCBJQPcX9kGAI9vqHbRdm7LOLJdaUWf1x58oixIlOqRPtbJJA7LC+rQohVU9WnboHc1kn
 Bzsi+P6v0H5HyuBSmH/14dwXj86UprY3FVeavvThcY/DhD4LRU/4qxkf960oQNqldaJNB2cOw
 l4BWX7UVsHxKcUOYOksmUSyt/0GyeEUM980sYk4GkX5Ej33Nob1ru3swDJk0N79E6urqrX6YJ
 Zx47DOhrNNy4vgeSuciv//XRZMVPHDfZAzTe3lGJy4wJ58BACe4yCH1Z/gQKkZE6sdoWL1lSx
 KI8yQ2CaBtOx1hCZoxuzoAkaI7e6wm2d5y9YoGJcuk5aXA1XoH+x05Oq9CvInQko3/57Xjdi1
 VYcSqA+LJa1vBL3oKjAbDodgjuiujNeqd3i4fg6rY3x1wLYwxiER8kQ3Y0Ps02kcJ1kYwcqWf
 LSU0HpM3MRyd912mxWzYVXZtaPF9Yg/9CH6w6B3wDYvllFPFicQToy9p83mDMN7vMef6HWX/z
 SA1ORK5pib6JGlul6QQJRYaC/GVfuQ/LZFI2yL6l+au7zpgyX8fwUodhivi5lhI49a59YiByX
 Gm/50+V/anuiK6Eh7ReYa+kgtkMu71qPrd1coWiAbLmckTqABFQM4eStDTp02EgIXDH+i9uWr
 G6ZtJrEdR1uQ8EY4fhlggRhbiV3nEWEGeLfNpWRr4oLk9qDurCghTcLcMNzlLHNaDIo98fj
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:17:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch introduces functionality for following time64 syscalls:

*ppoll_time64

    This is a year 2038 safe variant of:

    int poll(struct pollfd *fds, nfds_t nfds, int timeout)
    -- wait for some event on a file descriptor --
    man page: https://man7.org/linux/man-pages/man2/ppoll.2.html

*pselect6_time64

    This is a year 2038 safe variant of:

    int pselect6(int nfds, fd_set *readfds, fd_set *writefds,
                 fd_set *exceptfds, const struct timespec *timeout,
                 const sigset_t *sigmask);
    -- synchronous I/O multiplexing --
    man page: https://man7.org/linux/man-pages/man2/pselect6.2.html

Implementation notes:

    Year 2038 safe syscalls in this patch were implemented
    with the same code as their regular variants (ppoll() and pselect()).
    This code was moved to new functions ('do_ppoll()' and 'do_pselect6()')
    that take a 'bool time64' from which a right 'struct timespec' converting
    function is called.
    (target_to_host/host_to_target_timespec() for regular and
     target_to_host/host_to_target_timespec64() for time64 variants)

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200824223050.92032-2-Filip.Bozuta@syrmia.com>
[lv: rebase and fix do_pselect6()]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 460 +++++++++++++++++++++++--------------------
 1 file changed, 250 insertions(+), 210 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 93da3b972852..07220eee40c5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -728,11 +728,11 @@ safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
               int, options, struct rusage *, rusage)
 safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
 #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
-    defined(TARGET_NR_pselect6)
+    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
 safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
               fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
 #endif
-#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_poll)
+#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_ppoll_time64)
 safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
               struct timespec *, tsp, const sigset_t *, sigmask,
               size_t, sigsetsize)
@@ -952,7 +952,7 @@ abi_long do_brk(abi_ulong new_brk)
 }
 
 #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
-    defined(TARGET_NR_pselect6)
+    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
 static inline abi_long copy_from_user_fdset(fd_set *fds,
                                             abi_ulong target_fds_addr,
                                             int n)
@@ -1250,7 +1250,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
     defined(TARGET_NR_rt_sigtimedwait_time64) || \
     defined(TARGET_NR_utimensat) || \
     defined(TARGET_NR_utimensat_time64) || \
-    defined(TARGET_NR_semtimedop_time64)
+    defined(TARGET_NR_semtimedop_time64) || \
+    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64)
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -1458,6 +1459,237 @@ static abi_long do_old_select(abi_ulong arg1)
 #endif
 #endif
 
+#if defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
+static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
+                            abi_long arg4, abi_long arg5, abi_long arg6,
+                            bool time64)
+{
+    abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    struct timespec ts, *ts_ptr;
+    abi_long ret;
+
+    /*
+     * The 6th arg is actually two args smashed together,
+     * so we cannot use the C library.
+     */
+    sigset_t set;
+    struct {
+        sigset_t *set;
+        size_t size;
+    } sig, *sig_ptr;
+
+    abi_ulong arg_sigset, arg_sigsize, *arg7;
+    target_sigset_t *target_sigset;
+
+    n = arg1;
+    rfd_addr = arg2;
+    wfd_addr = arg3;
+    efd_addr = arg4;
+    ts_addr = arg5;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (ret) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * This takes a timespec, and not a timeval, so we cannot
+     * use the do_select() helper ...
+     */
+    if (ts_addr) {
+        if (time64) {
+            if (target_to_host_timespec64(&ts, ts_addr)) {
+                return -TARGET_EFAULT;
+            }
+        } else {
+            if (target_to_host_timespec(&ts, ts_addr)) {
+                return -TARGET_EFAULT;
+            }
+        }
+            ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    /* Extract the two packed args for the sigset */
+    if (arg6) {
+        sig_ptr = &sig;
+        sig.size = SIGSET_T_SIZE;
+
+        arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
+        if (!arg7) {
+            return -TARGET_EFAULT;
+        }
+        arg_sigset = tswapal(arg7[0]);
+        arg_sigsize = tswapal(arg7[1]);
+        unlock_user(arg7, arg6, 0);
+
+        if (arg_sigset) {
+            sig.set = &set;
+            if (arg_sigsize != sizeof(*target_sigset)) {
+                /* Like the kernel, we enforce correct size sigsets */
+                return -TARGET_EINVAL;
+            }
+            target_sigset = lock_user(VERIFY_READ, arg_sigset,
+                                      sizeof(*target_sigset), 1);
+            if (!target_sigset) {
+                return -TARGET_EFAULT;
+            }
+            target_to_host_sigset(&set, target_sigset);
+            unlock_user(target_sigset, arg_sigset, 0);
+        } else {
+            sig.set = NULL;
+        }
+    } else {
+        sig_ptr = NULL;
+    }
+
+    ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
+                                  ts_ptr, sig_ptr));
+
+    if (!is_error(ret)) {
+        if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
+            return -TARGET_EFAULT;
+        }
+        if (time64) {
+            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
+                return -TARGET_EFAULT;
+            }
+        } else {
+            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
+                return -TARGET_EFAULT;
+            }
+        }
+    }
+    return ret;
+}
+#endif
+
+#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll) || \
+    defined(TARGET_NR_ppoll_time64)
+static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
+                         abi_long arg4, abi_long arg5, bool ppoll, bool time64)
+{
+    struct target_pollfd *target_pfd;
+    unsigned int nfds = arg2;
+    struct pollfd *pfd;
+    unsigned int i;
+    abi_long ret;
+
+    pfd = NULL;
+    target_pfd = NULL;
+    if (nfds) {
+        if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
+            return -TARGET_EINVAL;
+        }
+        target_pfd = lock_user(VERIFY_WRITE, arg1,
+                               sizeof(struct target_pollfd) * nfds, 1);
+        if (!target_pfd) {
+            return -TARGET_EFAULT;
+        }
+
+        pfd = alloca(sizeof(struct pollfd) * nfds);
+        for (i = 0; i < nfds; i++) {
+            pfd[i].fd = tswap32(target_pfd[i].fd);
+            pfd[i].events = tswap16(target_pfd[i].events);
+        }
+    }
+    if (ppoll) {
+        struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
+        target_sigset_t *target_set;
+        sigset_t _set, *set = &_set;
+
+        if (arg3) {
+            if (time64) {
+                if (target_to_host_timespec64(timeout_ts, arg3)) {
+                    unlock_user(target_pfd, arg1, 0);
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                if (target_to_host_timespec(timeout_ts, arg3)) {
+                    unlock_user(target_pfd, arg1, 0);
+                    return -TARGET_EFAULT;
+                }
+            }
+        } else {
+            timeout_ts = NULL;
+        }
+
+        if (arg4) {
+            if (arg5 != sizeof(target_sigset_t)) {
+                unlock_user(target_pfd, arg1, 0);
+                return -TARGET_EINVAL;
+            }
+
+            target_set = lock_user(VERIFY_READ, arg4,
+                                   sizeof(target_sigset_t), 1);
+            if (!target_set) {
+                unlock_user(target_pfd, arg1, 0);
+                return -TARGET_EFAULT;
+            }
+            target_to_host_sigset(set, target_set);
+        } else {
+            set = NULL;
+        }
+
+        ret = get_errno(safe_ppoll(pfd, nfds, timeout_ts,
+                                   set, SIGSET_T_SIZE));
+
+        if (!is_error(ret) && arg3) {
+            if (time64) {
+                if (host_to_target_timespec64(arg3, timeout_ts)) {
+                    return -TARGET_EFAULT;
+                }
+            } else {
+                if (host_to_target_timespec(arg3, timeout_ts)) {
+                    return -TARGET_EFAULT;
+                }
+            }
+        }
+        if (arg4) {
+            unlock_user(target_set, arg4, 0);
+        }
+    } else {
+          struct timespec ts, *pts;
+
+          if (arg3 >= 0) {
+              /* Convert ms to secs, ns */
+              ts.tv_sec = arg3 / 1000;
+              ts.tv_nsec = (arg3 % 1000) * 1000000LL;
+              pts = &ts;
+          } else {
+              /* -ve poll() timeout means "infinite" */
+              pts = NULL;
+          }
+          ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
+    }
+
+    if (!is_error(ret)) {
+        for (i = 0; i < nfds; i++) {
+            target_pfd[i].revents = tswap16(pfd[i].revents);
+        }
+    }
+    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
+    return ret;
+}
+#endif
+
 static abi_long do_pipe2(int host_pipe[], int flags)
 {
 #ifdef CONFIG_PIPE2
@@ -9256,106 +9488,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_pselect6
     case TARGET_NR_pselect6:
-        {
-            abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
-            fd_set rfds, wfds, efds;
-            fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
-            struct timespec ts, *ts_ptr;
-
-            /*
-             * The 6th arg is actually two args smashed together,
-             * so we cannot use the C library.
-             */
-            sigset_t set;
-            struct {
-                sigset_t *set;
-                size_t size;
-            } sig, *sig_ptr;
-
-            abi_ulong arg_sigset, arg_sigsize, *arg7;
-            target_sigset_t *target_sigset;
-
-            n = arg1;
-            rfd_addr = arg2;
-            wfd_addr = arg3;
-            efd_addr = arg4;
-            ts_addr = arg5;
-
-            ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
-            if (ret) {
-                return ret;
-            }
-            ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
-            if (ret) {
-                return ret;
-            }
-            ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
-            if (ret) {
-                return ret;
-            }
-
-            /*
-             * This takes a timespec, and not a timeval, so we cannot
-             * use the do_select() helper ...
-             */
-            if (ts_addr) {
-                if (target_to_host_timespec(&ts, ts_addr)) {
-                    return -TARGET_EFAULT;
-                }
-                ts_ptr = &ts;
-            } else {
-                ts_ptr = NULL;
-            }
-
-            /* Extract the two packed args for the sigset */
-            if (arg6) {
-                sig_ptr = &sig;
-                sig.size = SIGSET_T_SIZE;
-
-                arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
-                if (!arg7) {
-                    return -TARGET_EFAULT;
-                }
-                arg_sigset = tswapal(arg7[0]);
-                arg_sigsize = tswapal(arg7[1]);
-                unlock_user(arg7, arg6, 0);
-
-                if (arg_sigset) {
-                    sig.set = &set;
-                    if (arg_sigsize != sizeof(*target_sigset)) {
-                        /* Like the kernel, we enforce correct size sigsets */
-                        return -TARGET_EINVAL;
-                    }
-                    target_sigset = lock_user(VERIFY_READ, arg_sigset,
-                                              sizeof(*target_sigset), 1);
-                    if (!target_sigset) {
-                        return -TARGET_EFAULT;
-                    }
-                    target_to_host_sigset(&set, target_sigset);
-                    unlock_user(target_sigset, arg_sigset, 0);
-                } else {
-                    sig.set = NULL;
-                }
-            } else {
-                sig_ptr = NULL;
-            }
-
-            ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
-                                          ts_ptr, sig_ptr));
-
-            if (!is_error(ret)) {
-                if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n))
-                    return -TARGET_EFAULT;
-                if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n))
-                    return -TARGET_EFAULT;
-                if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
-                    return -TARGET_EFAULT;
-
-                if (ts_addr && host_to_target_timespec(ts_addr, &ts))
-                    return -TARGET_EFAULT;
-            }
-        }
-        return ret;
+        return do_pselect6(arg1, arg2, arg3, arg4, arg5, arg6, false);
+#endif
+#ifdef TARGET_NR_pselect6_time64
+    case TARGET_NR_pselect6_time64:
+        return do_pselect6(arg1, arg2, arg3, arg4, arg5, arg6, true);
 #endif
 #ifdef TARGET_NR_symlink
     case TARGET_NR_symlink:
@@ -10306,114 +10443,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR__newselect:
         return do_select(arg1, arg2, arg3, arg4, arg5);
 #endif
-#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
-# ifdef TARGET_NR_poll
+#ifdef TARGET_NR_poll
     case TARGET_NR_poll:
-# endif
-# ifdef TARGET_NR_ppoll
+        return do_ppoll(arg1, arg2, arg3, arg4, arg5, false, false);
+#endif
+#ifdef TARGET_NR_ppoll
     case TARGET_NR_ppoll:
-# endif
-        {
-            struct target_pollfd *target_pfd;
-            unsigned int nfds = arg2;
-            struct pollfd *pfd;
-            unsigned int i;
-
-            pfd = NULL;
-            target_pfd = NULL;
-            if (nfds) {
-                if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
-                    return -TARGET_EINVAL;
-                }
-
-                target_pfd = lock_user(VERIFY_WRITE, arg1,
-                                       sizeof(struct target_pollfd) * nfds, 1);
-                if (!target_pfd) {
-                    return -TARGET_EFAULT;
-                }
-
-                pfd = alloca(sizeof(struct pollfd) * nfds);
-                for (i = 0; i < nfds; i++) {
-                    pfd[i].fd = tswap32(target_pfd[i].fd);
-                    pfd[i].events = tswap16(target_pfd[i].events);
-                }
-            }
-
-            switch (num) {
-# ifdef TARGET_NR_ppoll
-            case TARGET_NR_ppoll:
-            {
-                struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
-                target_sigset_t *target_set;
-                sigset_t _set, *set = &_set;
-
-                if (arg3) {
-                    if (target_to_host_timespec(timeout_ts, arg3)) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EFAULT;
-                    }
-                } else {
-                    timeout_ts = NULL;
-                }
-
-                if (arg4) {
-                    if (arg5 != sizeof(target_sigset_t)) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EINVAL;
-                    }
-
-                    target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
-                    if (!target_set) {
-                        unlock_user(target_pfd, arg1, 0);
-                        return -TARGET_EFAULT;
-                    }
-                    target_to_host_sigset(set, target_set);
-                } else {
-                    set = NULL;
-                }
-
-                ret = get_errno(safe_ppoll(pfd, nfds, timeout_ts,
-                                           set, SIGSET_T_SIZE));
-
-                if (!is_error(ret) && arg3) {
-                    host_to_target_timespec(arg3, timeout_ts);
-                }
-                if (arg4) {
-                    unlock_user(target_set, arg4, 0);
-                }
-                break;
-            }
-# endif
-# ifdef TARGET_NR_poll
-            case TARGET_NR_poll:
-            {
-                struct timespec ts, *pts;
-
-                if (arg3 >= 0) {
-                    /* Convert ms to secs, ns */
-                    ts.tv_sec = arg3 / 1000;
-                    ts.tv_nsec = (arg3 % 1000) * 1000000LL;
-                    pts = &ts;
-                } else {
-                    /* -ve poll() timeout means "infinite" */
-                    pts = NULL;
-                }
-                ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
-                break;
-            }
-# endif
-            default:
-                g_assert_not_reached();
-            }
-
-            if (!is_error(ret)) {
-                for(i = 0; i < nfds; i++) {
-                    target_pfd[i].revents = tswap16(pfd[i].revents);
-                }
-            }
-            unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
-        }
-        return ret;
+        return do_ppoll(arg1, arg2, arg3, arg4, arg5, true, false);
+#endif
+#ifdef TARGET_NR_ppoll_time64
+    case TARGET_NR_ppoll_time64:
+        return do_ppoll(arg1, arg2, arg3, arg4, arg5, true, true);
 #endif
     case TARGET_NR_flock:
         /* NOTE: the flock constant seems to be the same for every
-- 
2.26.2


