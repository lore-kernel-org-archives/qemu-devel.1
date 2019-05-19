Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F3C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C008920657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gztWdzs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C008920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSqB-0000ZO-V2
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:55:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZH-0003MX-Mo
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZG-0003xg-Jq
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:03 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZG-0003wx-D8
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:02 -0400
Received: by mail-pg1-x542.google.com with SMTP id i21so5720909pgi.12
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=CUstonr/slKQsOp95jk6g1WJFMbRRVPH2v9t0llMUoM=;
	b=gztWdzs8chvklwyvFRigzSUIlJ58+409oA0pFmMX6kvHD9UoGLi2aYp4xSZ/QLsCT/
	i5zUc8HPJWhG/PYEU6ecEV5qVWGkWb9pbEC5/cEDUD7ZOm4u4YuFAX229/1RZSJzXlN4
	0GTMknJR+PtwwAnChPiQHqeT0Xs6g5tadTlFrvpPk/gvRDjv0c3FQnaKNrIXllJbI4ez
	Tr/8g7PLp8/nH1AKxCC95sYOPwiouWzUjTnxleY2DHDoa2zsgC9iFzkMmI2EesYmKWU8
	5udxp5Mrm2YpXNK3LNlTIPtzv5cOlfGq8nohVMkQ8oM0rrp5fsjVRaO0Qt/Dvl92AO2r
	3T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=CUstonr/slKQsOp95jk6g1WJFMbRRVPH2v9t0llMUoM=;
	b=RiFXru9AUxYSzsxWT8S9aZDK8eru46tGarQW8GY0uMhLNBB+m9iY12Gz2oqrc9aCOq
	wU2DfyE7ULReTQ30Vc6YSfwYeqckNSpLcYmKu5hjfvDfpon6CErd/BfC7FP/jlw7D+0C
	YmKoGSbGrzOefrbXI2w8WowAuTwZyso0kTlZDPG+mBgUaMYMV2AhytqkCrsbO/S6nodR
	CM/maWuUj4SvXahaP+AJ3hDbzUDH0IFwQo8OeeQvYfQa0zkAcgwulrcEpTVd5PO48eV/
	Uh06xRNuwuI36YRotM3lilCVJ6VtbXVJnNYLeUCQ1sQuzYMN5nuAzKaoQiyR4PAsVVDR
	Yssw==
X-Gm-Message-State: APjAAAUTdpwAVxoS5+QEMaUm3vdcWfZnT/9WK835ehJfAH50Jkd5Sbal
	L2D29lzdXQ9KKFlG8ENrvjytQfBsw4A=
X-Google-Smtp-Source: APXvYqwXLgCQ/UOuHmUq+tqKf1FtwWeOBoUur30aXwKUjdUx/bcyqH8mguvl6XKPWYIM9tRX7wTpQw==
X-Received: by 2002:a63:4c15:: with SMTP id z21mr27665675pga.395.1558298281198;
	Sun, 19 May 2019 13:38:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:36 -0700
Message-Id: <20190519203726.20729-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v7 24/74] linux-user: Implement execveat
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

A trivial extension to our current execve implementation
to support the new(ish) syscall.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall-proc.inc.c | 19 ++++++++++++++-----
 linux-user/syscall.c          |  3 ++-
 linux-user/strace.list        |  3 ---
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 58fef48666..392bd1579c 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -26,6 +26,7 @@ SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(exit, ARG_DEC);
 SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
+SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 66ad768551..fd114d1f03 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -269,14 +269,13 @@ SYSCALL_IMPL(clone)
     return do_clone(cpu_env, arg1, arg2, arg3, arg4, arg5);
 }
 
-SYSCALL_IMPL(execve)
+static abi_long do_execveat(int dirfd, abi_ulong guest_path,
+                            abi_ulong guest_argp, abi_ulong guest_envp,
+                            int flags)
 {
     char **argp, **envp;
     int argc, envc;
     abi_ulong gp;
-    abi_ulong guest_path = arg1;
-    abi_ulong guest_argp = arg2;
-    abi_ulong guest_envp = arg3;
     abi_ulong addr;
     char **q, *p;
     int total_size = 0;
@@ -356,7 +355,7 @@ SYSCALL_IMPL(execve)
      * before the execve completes and makes it the other
      * program's problem.
      */
-    ret = get_errno(safe_execve(p, argp, envp));
+    ret = get_errno(safe_execveat(dirfd, p, argp, envp, flags));
     unlock_user(p, guest_path, 0);
 
  execve_free:
@@ -379,6 +378,16 @@ SYSCALL_IMPL(execve)
     return ret;
 }
 
+SYSCALL_IMPL(execve)
+{
+    return do_execveat(AT_FDCWD, arg1, arg2, arg3, 0);
+}
+
+SYSCALL_IMPL(execveat)
+{
+    return do_execveat(arg1, arg2, arg3, arg4, arg5);
+}
+
 SYSCALL_IMPL(exit)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a00df1162f..affcd81273 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -672,7 +672,8 @@ safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
 safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
               int, options, struct rusage *, rusage)
-safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
+safe_syscall5(int, execveat, int, dirfd, const char *, filename,
+              char **, argv, char **, envp, int, flags)
 safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
               fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
 safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 39e5c5b1aa..c6bb475728 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -139,9 +139,6 @@
 #ifdef TARGET_NR_execv
 { TARGET_NR_execv, "execv" , NULL, print_execv, NULL },
 #endif
-#ifdef TARGET_NR_execveat
-{ TARGET_NR_execveat, "execveat" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_exec_with_loader
 { TARGET_NR_exec_with_loader, "exec_with_loader" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


