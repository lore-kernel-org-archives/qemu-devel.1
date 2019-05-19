Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B09C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF48C20644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeJ25agB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF48C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53841 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTKe-0003nn-Rj
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:27:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa0-0003xH-W7
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZz-0004t4-F0
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:48 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZz-0004s4-7E
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:47 -0400
Received: by mail-pf1-x443.google.com with SMTP id t87so6175534pfa.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=H+hAO3lCLGHX0woDMYAcESGWkiYaW7BEOcuLvxL4WTY=;
	b=QeJ25agBxzK7WHQT5PUY2JNCKaE7N/t8OMwnVfB4Jz6xK/ME4pC8V7B+D/HErzmbZY
	AGaHXD0ea/A6XBxMFg+EDYe2ch5M2bBVtCARpqGJ4Xg0UN2WSNw+Tup3xHGl0K6on85+
	KKTUezVm26GhujnhMNxL6hA57SLHUQzFTjceowQ6j+RNGE7A0gsJY+pwjQQ7KWoM3NAX
	spssYvD4E25qQcv3RCwq4n+L/sCTsJOdMD0jwCAlVxNz3Ab5/EBUqopTSV1IJnu1YFEC
	opIvh7R8FasIff62tnB2jcVPBgeqHHN96YCMYOoUfwkqL3huV3GOjUYwbn01B/mheNFh
	fDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=H+hAO3lCLGHX0woDMYAcESGWkiYaW7BEOcuLvxL4WTY=;
	b=X/znZy22DLmxwck6GuvPqOpznXC8bLFETfzzIxddoTdhxV9hwPgEe9qHJw4ZpU6Mgm
	L0cBRW+UKduUj8PcYGnqA26RuCRxOGMCLLUxQXhm/5KkLfAz/5u7KxJEDj8uKMSNg+2x
	Y6xVUlDrfxMvIWvUod+Gleq0kIWrXB3dQw2MXL3zy1yzSbfcZvnfPdPAemDPEHFcwzfe
	TAt2r3DmJei8I2mSC8353zIsG9IpGBr04COmi7OUBtqQDWna3500JS03HTCY4PTSVEaz
	IUks2qs0UIIdNpA6zzQl2NswmCs/xS09a9WHRRzogxe1ig7p+woYtmhLPVw/Gjrosz+Y
	k08Q==
X-Gm-Message-State: APjAAAVFQUgmW1dbSd+2Ey8dkVgyM4icV7HwBMsBhIIrt583OOAX4qrx
	6610ESCGCISiPIZLy4ytSvIA0a3hVKg=
X-Google-Smtp-Source: APXvYqydOrAFec0LLtyWEoAKOtxVXXSzpIDG56yM9iF+dEct/HxlYFAGucY+QMERmZQOXXBm//xEJg==
X-Received: by 2002:a63:d354:: with SMTP id u20mr23001764pgi.129.1558298325924;
	Sun, 19 May 2019 13:38:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:14 -0700
Message-Id: <20190519203726.20729-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 62/74] linux-user: Split out rt_sigqueueinfo,
 rt_tgsigqueueinfo
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does drop the (questionable) siginfo_t printing.
But since we already do not handle more important things
in this area like sigset_t, this does not feel a loss.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h    |   2 +
 linux-user/strace.c          | 138 -----------------------------------
 linux-user/syscall-sig.inc.c |  30 ++++++++
 linux-user/syscall.c         |  26 -------
 linux-user/strace.list       |   6 --
 5 files changed, 32 insertions(+), 170 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 24289ed413..11851535e1 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -196,8 +196,10 @@ SYSCALL_DEF(rt_sigaction, ARG_SIGNAL, ARG_PTR, ARG_PTR, ARG_DEC);
 #endif
 SYSCALL_DEF(rt_sigpending, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigprocmask, ARG_SIGPROCMASKHOW, ARG_PTR, ARG_PTR, ARG_DEC);
+SYSCALL_DEF(rt_sigqueueinfo, ARG_DEC, ARG_SIGNAL, ARG_PTR);
 SYSCALL_DEF(rt_sigsuspend, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(rt_sigtimedwait, ARG_PTR, ARG_PTR, ARG_PTR, ARG_DEC);
+SYSCALL_DEF(rt_tgsigqueueinfo, ARG_DEC, ARG_DEC, ARG_SIGNAL, ARG_PTR);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semctl)
 SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 886663af2e..2e70a3910c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -167,93 +167,6 @@ static void print_si_code(int arg)
     gemu_log("%s", codename);
 }
 
-static void get_target_siginfo(target_siginfo_t *tinfo,
-                                const target_siginfo_t *info)
-{
-    abi_ulong sival_ptr;
-
-    int sig;
-    int si_errno;
-    int si_code;
-    int si_type;
-
-    __get_user(sig, &info->si_signo);
-    __get_user(si_errno, &tinfo->si_errno);
-    __get_user(si_code, &info->si_code);
-
-    tinfo->si_signo = sig;
-    tinfo->si_errno = si_errno;
-    tinfo->si_code = si_code;
-
-    /* Ensure we don't leak random junk to the guest later */
-    memset(tinfo->_sifields._pad, 0, sizeof(tinfo->_sifields._pad));
-
-    /* This is awkward, because we have to use a combination of
-     * the si_code and si_signo to figure out which of the union's
-     * members are valid. (Within the host kernel it is always possible
-     * to tell, but the kernel carefully avoids giving userspace the
-     * high 16 bits of si_code, so we don't have the information to
-     * do this the easy way...) We therefore make our best guess,
-     * bearing in mind that a guest can spoof most of the si_codes
-     * via rt_sigqueueinfo() if it likes.
-     *
-     * Once we have made our guess, we record it in the top 16 bits of
-     * the si_code, so that print_siginfo() later can use it.
-     * print_siginfo() will strip these top bits out before printing
-     * the si_code.
-     */
-
-    switch (si_code) {
-    case SI_USER:
-    case SI_TKILL:
-    case SI_KERNEL:
-        /* Sent via kill(), tkill() or tgkill(), or direct from the kernel.
-         * These are the only unspoofable si_code values.
-         */
-        __get_user(tinfo->_sifields._kill._pid, &info->_sifields._kill._pid);
-        __get_user(tinfo->_sifields._kill._uid, &info->_sifields._kill._uid);
-        si_type = QEMU_SI_KILL;
-        break;
-    default:
-        /* Everything else is spoofable. Make best guess based on signal */
-        switch (sig) {
-        case TARGET_SIGCHLD:
-            __get_user(tinfo->_sifields._sigchld._pid,
-                       &info->_sifields._sigchld._pid);
-            __get_user(tinfo->_sifields._sigchld._uid,
-                       &info->_sifields._sigchld._uid);
-            __get_user(tinfo->_sifields._sigchld._status,
-                       &info->_sifields._sigchld._status);
-            __get_user(tinfo->_sifields._sigchld._utime,
-                       &info->_sifields._sigchld._utime);
-            __get_user(tinfo->_sifields._sigchld._stime,
-                       &info->_sifields._sigchld._stime);
-            si_type = QEMU_SI_CHLD;
-            break;
-        case TARGET_SIGIO:
-            __get_user(tinfo->_sifields._sigpoll._band,
-                       &info->_sifields._sigpoll._band);
-            __get_user(tinfo->_sifields._sigpoll._fd,
-                       &info->_sifields._sigpoll._fd);
-            si_type = QEMU_SI_POLL;
-            break;
-        default:
-            /* Assume a sigqueue()/mq_notify()/rt_sigqueueinfo() source. */
-            __get_user(tinfo->_sifields._rt._pid, &info->_sifields._rt._pid);
-            __get_user(tinfo->_sifields._rt._uid, &info->_sifields._rt._uid);
-            /* XXX: potential problem if 64 bit */
-            __get_user(sival_ptr, &info->_sifields._rt._sigval.sival_ptr);
-            tinfo->_sifields._rt._sigval.sival_ptr = sival_ptr;
-
-            si_type = QEMU_SI_RT;
-            break;
-        }
-        break;
-    }
-
-    tinfo->si_code = deposit32(si_code, 16, 16, si_type);
-}
-
 static void print_siginfo(const target_siginfo_t *tinfo)
 {
     /* Print a target_siginfo_t in the format desired for printing
@@ -1585,57 +1498,6 @@ print_fstat(const struct syscallname *name,
 #define print_fstat64     print_fstat
 #endif
 
-#ifdef TARGET_NR_rt_sigqueueinfo
-static void
-print_rt_sigqueueinfo(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    void *p;
-    target_siginfo_t uinfo;
-
-    print_syscall_prologue(name);
-    print_raw_param("%d", arg0, 0);
-    print_signal(arg1, 0);
-    p = lock_user(VERIFY_READ, arg2, sizeof(target_siginfo_t), 1);
-    if (p) {
-        get_target_siginfo(&uinfo, p);
-        print_siginfo(&uinfo);
-
-        unlock_user(p, arg2, 0);
-    } else {
-        print_pointer(arg2, 1);
-    }
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_rt_tgsigqueueinfo
-static void
-print_rt_tgsigqueueinfo(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    void *p;
-    target_siginfo_t uinfo;
-
-    print_syscall_prologue(name);
-    print_raw_param("%d", arg0, 0);
-    print_raw_param("%d", arg1, 0);
-    print_signal(arg2, 0);
-    p = lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
-    if (p) {
-        get_target_siginfo(&uinfo, p);
-        print_siginfo(&uinfo);
-
-        unlock_user(p, arg3, 0);
-    } else {
-        print_pointer(arg3, 1);
-    }
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_syslog
 static void
 print_syslog_action(abi_ulong arg, int last)
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index 5f2c0ba499..774346838b 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -191,6 +191,21 @@ SYSCALL_IMPL(rt_sigprocmask)
     return ret;
 }
 
+SYSCALL_IMPL(rt_sigqueueinfo)
+{
+    siginfo_t uinfo;
+    void *p;
+
+    p = lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_siginfo(&uinfo, p);
+    unlock_user(p, arg3, 0);
+
+    return get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
+}
+
 SYSCALL_IMPL(rt_sigsuspend)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
@@ -252,6 +267,21 @@ SYSCALL_IMPL(rt_sigtimedwait)
     return ret;
 }
 
+SYSCALL_IMPL(rt_tgsigqueueinfo)
+{
+    siginfo_t uinfo;
+    void *p;
+
+    p = lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_siginfo(&uinfo, p);
+    unlock_user(p, arg4, 0);
+
+    return get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &uinfo));
+}
+
 #ifdef TARGET_NR_sigaction
 SYSCALL_IMPL(sigaction)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8a05d3e32a..e489d12103 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4240,32 +4240,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_rt_sigqueueinfo:
-        {
-            siginfo_t uinfo;
-
-            p = lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
-            if (!p) {
-                return -TARGET_EFAULT;
-            }
-            target_to_host_siginfo(&uinfo, p);
-            unlock_user(p, arg3, 0);
-            ret = get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
-        }
-        return ret;
-    case TARGET_NR_rt_tgsigqueueinfo:
-        {
-            siginfo_t uinfo;
-
-            p = lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t), 1);
-            if (!p) {
-                return -TARGET_EFAULT;
-            }
-            target_to_host_siginfo(&uinfo, p);
-            unlock_user(p, arg4, 0);
-            ret = get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &uinfo));
-        }
-        return ret;
 #ifdef TARGET_NR_sigreturn
     case TARGET_NR_sigreturn:
         if (block_signals()) {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 0b2c057673..57445a8d81 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -926,15 +926,9 @@
 #ifdef TARGET_NR_rmdir
 { TARGET_NR_rmdir, "rmdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rt_sigqueueinfo
-{ TARGET_NR_rt_sigqueueinfo, "rt_sigqueueinfo" , NULL, print_rt_sigqueueinfo, NULL },
-#endif
 #ifdef TARGET_NR_rt_sigreturn
 { TARGET_NR_rt_sigreturn, "rt_sigreturn" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_rt_tgsigqueueinfo
-{ TARGET_NR_rt_tgsigqueueinfo, "rt_tgsigqueueinfo" , NULL, print_rt_tgsigqueueinfo, NULL },
-#endif
 #ifdef TARGET_NR_sched_getaffinity
 { TARGET_NR_sched_getaffinity, "sched_getaffinity" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


