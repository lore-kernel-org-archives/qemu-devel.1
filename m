Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5D7C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA802070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K734DwgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA802070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47DX-0000j2-0M
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j4791-0004nV-GR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j478u-0003Kz-SL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:58:51 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j478u-0003KS-FV; Tue, 18 Feb 2020 12:58:44 -0500
Received: by mail-ot1-x343.google.com with SMTP id p8so20337270oth.10;
 Tue, 18 Feb 2020 09:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=gK7oQLZ8BQLHfRsCus978wUtq+/8SHWfjMDc56DlzhI=;
 b=K734DwgRu8pkAFqPwn/Bx7ip8151FRzWXiyhuIi9klWqqqWfuXVIXfF/F7U7RjJVQE
 FxjYproh+loccH5VrhyA8a0qbgx34t4cZDYEGm5gNRNuae75/N88S0L5PqLrW4LL7Ras
 cCaX454Odavb4TdteCXdFB0Jf2OnT/VRm0qG3SPEeg5dd2iRpxXxkKnMcdkbvzrW3MY4
 IMF8OOhw5IXd2KohBd+uPCGdRtiuVGHUG9/hmFHvz2QzN1FWoLApH40yyvfWIhPj8/v6
 gbU8WH2ekKUeumchf7OOyvgWkz94eiCiQr/NC1dFclpE79fYptw3XNx/YiCBmZLUzgDY
 gpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=gK7oQLZ8BQLHfRsCus978wUtq+/8SHWfjMDc56DlzhI=;
 b=etZUF2R4yN6sexRbRfG0gdTI/rHYV9u7tRD0azfoEhMcb919k/QBjDNHiMtjp2Neqc
 tGOo9FLRZTe8l9VG88hUsw1rqXZRtkzeBuJvmdGoMbvU6tzN0s+cnyGjOTDgTM7TF0jA
 1a4ggtcd7Ro8Tso7mdE/sh0x+LLz9VbIGp7IoIVmYi4CpJAbOiXG+z8VBn46yRQMnCR4
 3ymAJ3MddXLYVZwp8cp/xV4wq+CexRYw1Tu1Q8OJ158lGOfgctuiBswfeZnnoWqLkQnI
 tLcEsOt9hFYbFVAhBASgxHtGRh45jDVjaNFpGs80xHpjhOd1tI4lAfXtv28e2XFRi7LY
 Cqiw==
X-Gm-Message-State: APjAAAX5tX81t8lbQgyTJuZqcLX+5pyo0KnDlTJxY0rPPWVFC9NQRsbM
 9p1d5Lry9mRTn7pdtB8CD7g4Eyv09ULJryX1uhY=
X-Google-Smtp-Source: APXvYqwtXRLcsQ5wR1+7+3JbIB5/G6KbK3Cx1pV/7z8YcBFb/psjn1jIYoEkAvzTLc0Nvn1PuT8Clw/8copCZVtjB/4=
X-Received: by 2002:a05:6830:12c3:: with SMTP id
 a3mr17214858otq.341.1582048723577; 
 Tue, 18 Feb 2020 09:58:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 09:58:42 -0800 (PST)
In-Reply-To: <20200217223558.863199-23-laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200217223558.863199-23-laurent@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 18:58:42 +0100
Message-ID: <CAL1e-=jgUR7-P+=NiBP-VoN1ha+p3WDMY_VaV8siYkgJ=ZSddQ@mail.gmail.com>
Subject: Re: [PATCH 22/22] linux-user,mips: update syscall-args-o32.c.inc
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000002fca9f059edd6cce"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002fca9f059edd6cce
Content-Type: text/plain; charset="UTF-8"

On Monday, February 17, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> Add a script to update the file from strace github and run it
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>  linux-user/mips/syscall-args-o32.c.inc | 874 ++++++++++++-------------
>  scripts/update-mips-syscall-args.sh    |  57 ++
>  2 files changed, 493 insertions(+), 438 deletions(-)
>  create mode 100755 scripts/update-mips-syscall-args.sh
>
> diff --git a/linux-user/mips/syscall-args-o32.c.inc
> b/linux-user/mips/syscall-args-o32.c.inc
> index f060b061441a..0ad35857b4e4 100644
> --- a/linux-user/mips/syscall-args-o32.c.inc
> +++ b/linux-user/mips/syscall-args-o32.c.inc
> @@ -1,438 +1,436 @@
> -#  define MIPS_SYS(name, args) args,
> -        MIPS_SYS(sys_syscall    , 8)    /* 4000 */
> -        MIPS_SYS(sys_exit       , 1)
> -        MIPS_SYS(sys_fork       , 0)
> -        MIPS_SYS(sys_read       , 3)
> -        MIPS_SYS(sys_write      , 3)
> -        MIPS_SYS(sys_open       , 3)    /* 4005 */
> -        MIPS_SYS(sys_close      , 1)
> -        MIPS_SYS(sys_waitpid    , 3)
> -        MIPS_SYS(sys_creat      , 2)
> -        MIPS_SYS(sys_link       , 2)
> -        MIPS_SYS(sys_unlink     , 1)    /* 4010 */
> -        MIPS_SYS(sys_execve     , 0)
> -        MIPS_SYS(sys_chdir      , 1)
> -        MIPS_SYS(sys_time       , 1)
> -        MIPS_SYS(sys_mknod      , 3)
> -        MIPS_SYS(sys_chmod      , 2)    /* 4015 */
> -        MIPS_SYS(sys_lchown     , 3)
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_stat */
> -        MIPS_SYS(sys_lseek      , 3)
> -        MIPS_SYS(sys_getpid     , 0)    /* 4020 */
> -        MIPS_SYS(sys_mount      , 5)
> -        MIPS_SYS(sys_umount     , 1)
> -        MIPS_SYS(sys_setuid     , 1)
> -        MIPS_SYS(sys_getuid     , 0)
> -        MIPS_SYS(sys_stime      , 1)    /* 4025 */
> -        MIPS_SYS(sys_ptrace     , 4)
> -        MIPS_SYS(sys_alarm      , 1)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_fstat */
> -        MIPS_SYS(sys_pause      , 0)
> -        MIPS_SYS(sys_utime      , 2)    /* 4030 */
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_access     , 2)
> -        MIPS_SYS(sys_nice       , 1)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* 4035 */
> -        MIPS_SYS(sys_sync       , 0)
> -        MIPS_SYS(sys_kill       , 2)
> -        MIPS_SYS(sys_rename     , 2)
> -        MIPS_SYS(sys_mkdir      , 2)
> -        MIPS_SYS(sys_rmdir      , 1)    /* 4040 */
> -        MIPS_SYS(sys_dup                , 1)
> -        MIPS_SYS(sys_pipe       , 0)
> -        MIPS_SYS(sys_times      , 1)
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_brk                , 1)    /* 4045 */
> -        MIPS_SYS(sys_setgid     , 1)
> -        MIPS_SYS(sys_getgid     , 0)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* was signal(2) */
> -        MIPS_SYS(sys_geteuid    , 0)
> -        MIPS_SYS(sys_getegid    , 0)    /* 4050 */
> -        MIPS_SYS(sys_acct       , 0)
> -        MIPS_SYS(sys_umount2    , 2)
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_ioctl      , 3)
> -        MIPS_SYS(sys_fcntl      , 3)    /* 4055 */
> -        MIPS_SYS(sys_ni_syscall , 2)
> -        MIPS_SYS(sys_setpgid    , 2)
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_olduname   , 1)
> -        MIPS_SYS(sys_umask      , 1)    /* 4060 */
> -        MIPS_SYS(sys_chroot     , 1)
> -        MIPS_SYS(sys_ustat      , 2)
> -        MIPS_SYS(sys_dup2       , 2)
> -        MIPS_SYS(sys_getppid    , 0)
> -        MIPS_SYS(sys_getpgrp    , 0)    /* 4065 */
> -        MIPS_SYS(sys_setsid     , 0)
> -        MIPS_SYS(sys_sigaction  , 3)
> -        MIPS_SYS(sys_sgetmask   , 0)
> -        MIPS_SYS(sys_ssetmask   , 1)
> -        MIPS_SYS(sys_setreuid   , 2)    /* 4070 */
> -        MIPS_SYS(sys_setregid   , 2)
> -        MIPS_SYS(sys_sigsuspend , 0)
> -        MIPS_SYS(sys_sigpending , 1)
> -        MIPS_SYS(sys_sethostname        , 2)
> -        MIPS_SYS(sys_setrlimit  , 2)    /* 4075 */
> -        MIPS_SYS(sys_getrlimit  , 2)
> -        MIPS_SYS(sys_getrusage  , 2)
> -        MIPS_SYS(sys_gettimeofday, 2)
> -        MIPS_SYS(sys_settimeofday, 2)
> -        MIPS_SYS(sys_getgroups  , 2)    /* 4080 */
> -        MIPS_SYS(sys_setgroups  , 2)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* old_select */
> -        MIPS_SYS(sys_symlink    , 2)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_lstat */
> -        MIPS_SYS(sys_readlink   , 3)    /* 4085 */
> -        MIPS_SYS(sys_uselib     , 1)
> -        MIPS_SYS(sys_swapon     , 2)
> -        MIPS_SYS(sys_reboot     , 3)
> -        MIPS_SYS(old_readdir    , 3)
> -        MIPS_SYS(old_mmap       , 6)    /* 4090 */
> -        MIPS_SYS(sys_munmap     , 2)
> -        MIPS_SYS(sys_truncate   , 2)
> -        MIPS_SYS(sys_ftruncate  , 2)
> -        MIPS_SYS(sys_fchmod     , 2)
> -        MIPS_SYS(sys_fchown     , 3)    /* 4095 */
> -        MIPS_SYS(sys_getpriority        , 2)
> -        MIPS_SYS(sys_setpriority        , 3)
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_statfs     , 2)
> -        MIPS_SYS(sys_fstatfs    , 2)    /* 4100 */
> -        MIPS_SYS(sys_ni_syscall , 0)    /* was ioperm(2) */
> -        MIPS_SYS(sys_socketcall , 2)
> -        MIPS_SYS(sys_syslog     , 3)
> -        MIPS_SYS(sys_setitimer  , 3)
> -        MIPS_SYS(sys_getitimer  , 2)    /* 4105 */
> -        MIPS_SYS(sys_newstat    , 2)
> -        MIPS_SYS(sys_newlstat   , 2)
> -        MIPS_SYS(sys_newfstat   , 2)
> -        MIPS_SYS(sys_uname      , 1)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* 4110 was iopl(2) */
> -        MIPS_SYS(sys_vhangup    , 0)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_idle() */
> -        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_vm86 */
> -        MIPS_SYS(sys_wait4      , 4)
> -        MIPS_SYS(sys_swapoff    , 1)    /* 4115 */
> -        MIPS_SYS(sys_sysinfo    , 1)
> -        MIPS_SYS(sys_ipc                , 6)
> -        MIPS_SYS(sys_fsync      , 1)
> -        MIPS_SYS(sys_sigreturn  , 0)
> -        MIPS_SYS(sys_clone      , 6)    /* 4120 */
> -        MIPS_SYS(sys_setdomainname, 2)
> -        MIPS_SYS(sys_newuname   , 1)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* sys_modify_ldt */
> -        MIPS_SYS(sys_adjtimex   , 1)
> -        MIPS_SYS(sys_mprotect   , 3)    /* 4125 */
> -        MIPS_SYS(sys_sigprocmask        , 3)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* was create_module */
> -        MIPS_SYS(sys_init_module        , 5)
> -        MIPS_SYS(sys_delete_module, 1)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* 4130 was get_kernel_syms */
> -        MIPS_SYS(sys_quotactl   , 0)
> -        MIPS_SYS(sys_getpgid    , 1)
> -        MIPS_SYS(sys_fchdir     , 1)
> -        MIPS_SYS(sys_bdflush    , 2)
> -        MIPS_SYS(sys_sysfs      , 3)    /* 4135 */
> -        MIPS_SYS(sys_personality        , 1)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* for afs_syscall */
> -        MIPS_SYS(sys_setfsuid   , 1)
> -        MIPS_SYS(sys_setfsgid   , 1)
> -        MIPS_SYS(sys_llseek     , 5)    /* 4140 */
> -        MIPS_SYS(sys_getdents   , 3)
> -        MIPS_SYS(sys_select     , 5)
> -        MIPS_SYS(sys_flock      , 2)
> -        MIPS_SYS(sys_msync      , 3)
> -        MIPS_SYS(sys_readv      , 3)    /* 4145 */
> -        MIPS_SYS(sys_writev     , 3)
> -        MIPS_SYS(sys_cacheflush , 3)
> -        MIPS_SYS(sys_cachectl   , 3)
> -        MIPS_SYS(sys_sysmips    , 4)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* 4150 */
> -        MIPS_SYS(sys_getsid     , 1)
> -        MIPS_SYS(sys_fdatasync  , 0)
> -        MIPS_SYS(sys_sysctl     , 1)
> -        MIPS_SYS(sys_mlock      , 2)
> -        MIPS_SYS(sys_munlock    , 2)    /* 4155 */
> -        MIPS_SYS(sys_mlockall   , 1)
> -        MIPS_SYS(sys_munlockall , 0)
> -        MIPS_SYS(sys_sched_setparam, 2)
> -        MIPS_SYS(sys_sched_getparam, 2)
> -        MIPS_SYS(sys_sched_setscheduler, 3)     /* 4160 */
> -        MIPS_SYS(sys_sched_getscheduler, 1)
> -        MIPS_SYS(sys_sched_yield        , 0)
> -        MIPS_SYS(sys_sched_get_priority_max, 1)
> -        MIPS_SYS(sys_sched_get_priority_min, 1)
> -        MIPS_SYS(sys_sched_rr_get_interval, 2)  /* 4165 */
> -        MIPS_SYS(sys_nanosleep, 2)
> -        MIPS_SYS(sys_mremap     , 5)
> -        MIPS_SYS(sys_accept     , 3)
> -        MIPS_SYS(sys_bind       , 3)
> -        MIPS_SYS(sys_connect    , 3)    /* 4170 */
> -        MIPS_SYS(sys_getpeername        , 3)
> -        MIPS_SYS(sys_getsockname        , 3)
> -        MIPS_SYS(sys_getsockopt , 5)
> -        MIPS_SYS(sys_listen     , 2)
> -        MIPS_SYS(sys_recv       , 4)    /* 4175 */
> -        MIPS_SYS(sys_recvfrom   , 6)
> -        MIPS_SYS(sys_recvmsg    , 3)
> -        MIPS_SYS(sys_send       , 4)
> -        MIPS_SYS(sys_sendmsg    , 3)
> -        MIPS_SYS(sys_sendto     , 6)    /* 4180 */
> -        MIPS_SYS(sys_setsockopt , 5)
> -        MIPS_SYS(sys_shutdown   , 2)
> -        MIPS_SYS(sys_socket     , 3)
> -        MIPS_SYS(sys_socketpair , 4)
> -        MIPS_SYS(sys_setresuid  , 3)    /* 4185 */
> -        MIPS_SYS(sys_getresuid  , 3)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_query_module */
> -        MIPS_SYS(sys_poll       , 3)
> -        MIPS_SYS(sys_nfsservctl , 3)
> -        MIPS_SYS(sys_setresgid  , 3)    /* 4190 */
> -        MIPS_SYS(sys_getresgid  , 3)
> -        MIPS_SYS(sys_prctl      , 5)
> -        MIPS_SYS(sys_rt_sigreturn, 0)
> -        MIPS_SYS(sys_rt_sigaction, 4)
> -        MIPS_SYS(sys_rt_sigprocmask, 4) /* 4195 */
> -        MIPS_SYS(sys_rt_sigpending, 2)
> -        MIPS_SYS(sys_rt_sigtimedwait, 4)
> -        MIPS_SYS(sys_rt_sigqueueinfo, 3)
> -        MIPS_SYS(sys_rt_sigsuspend, 0)
> -        MIPS_SYS(sys_pread64    , 6)    /* 4200 */
> -        MIPS_SYS(sys_pwrite64   , 6)
> -        MIPS_SYS(sys_chown      , 3)
> -        MIPS_SYS(sys_getcwd     , 2)
> -        MIPS_SYS(sys_capget     , 2)
> -        MIPS_SYS(sys_capset     , 2)    /* 4205 */
> -        MIPS_SYS(sys_sigaltstack        , 2)
> -        MIPS_SYS(sys_sendfile   , 4)
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_mmap2      , 6)    /* 4210 */
> -        MIPS_SYS(sys_truncate64 , 4)
> -        MIPS_SYS(sys_ftruncate64        , 4)
> -        MIPS_SYS(sys_stat64     , 2)
> -        MIPS_SYS(sys_lstat64    , 2)
> -        MIPS_SYS(sys_fstat64    , 2)    /* 4215 */
> -        MIPS_SYS(sys_pivot_root , 2)
> -        MIPS_SYS(sys_mincore    , 3)
> -        MIPS_SYS(sys_madvise    , 3)
> -        MIPS_SYS(sys_getdents64 , 3)
> -        MIPS_SYS(sys_fcntl64    , 3)    /* 4220 */
> -        MIPS_SYS(sys_ni_syscall , 0)
> -        MIPS_SYS(sys_gettid     , 0)
> -        MIPS_SYS(sys_readahead  , 5)
> -        MIPS_SYS(sys_setxattr   , 5)
> -        MIPS_SYS(sys_lsetxattr  , 5)    /* 4225 */
> -        MIPS_SYS(sys_fsetxattr  , 5)
> -        MIPS_SYS(sys_getxattr   , 4)
> -        MIPS_SYS(sys_lgetxattr  , 4)
> -        MIPS_SYS(sys_fgetxattr  , 4)
> -        MIPS_SYS(sys_listxattr  , 3)    /* 4230 */
> -        MIPS_SYS(sys_llistxattr , 3)
> -        MIPS_SYS(sys_flistxattr , 3)
> -        MIPS_SYS(sys_removexattr        , 2)
> -        MIPS_SYS(sys_lremovexattr, 2)
> -        MIPS_SYS(sys_fremovexattr, 2)   /* 4235 */
> -        MIPS_SYS(sys_tkill      , 2)
> -        MIPS_SYS(sys_sendfile64 , 5)
> -        MIPS_SYS(sys_futex      , 6)
> -        MIPS_SYS(sys_sched_setaffinity, 3)
> -        MIPS_SYS(sys_sched_getaffinity, 3)      /* 4240 */
> -        MIPS_SYS(sys_io_setup   , 2)
> -        MIPS_SYS(sys_io_destroy , 1)
> -        MIPS_SYS(sys_io_getevents, 5)
> -        MIPS_SYS(sys_io_submit  , 3)
> -        MIPS_SYS(sys_io_cancel  , 3)    /* 4245 */
> -        MIPS_SYS(sys_exit_group , 1)
> -        MIPS_SYS(sys_lookup_dcookie, 3)
> -        MIPS_SYS(sys_epoll_create, 1)
> -        MIPS_SYS(sys_epoll_ctl  , 4)
> -        MIPS_SYS(sys_epoll_wait , 3)    /* 4250 */
> -        MIPS_SYS(sys_remap_file_pages, 5)
> -        MIPS_SYS(sys_set_tid_address, 1)
> -        MIPS_SYS(sys_restart_syscall, 0)
> -        MIPS_SYS(sys_fadvise64_64, 7)
> -        MIPS_SYS(sys_statfs64   , 3)    /* 4255 */
> -        MIPS_SYS(sys_fstatfs64  , 2)
> -        MIPS_SYS(sys_timer_create, 3)
> -        MIPS_SYS(sys_timer_settime, 4)
> -        MIPS_SYS(sys_timer_gettime, 2)
> -        MIPS_SYS(sys_timer_getoverrun, 1)       /* 4260 */
> -        MIPS_SYS(sys_timer_delete, 1)
> -        MIPS_SYS(sys_clock_settime, 2)
> -        MIPS_SYS(sys_clock_gettime, 2)
> -        MIPS_SYS(sys_clock_getres, 2)
> -        MIPS_SYS(sys_clock_nanosleep, 4)        /* 4265 */
> -        MIPS_SYS(sys_tgkill     , 3)
> -        MIPS_SYS(sys_utimes     , 2)
> -        MIPS_SYS(sys_mbind      , 4)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* sys_get_mempolicy */
> -        MIPS_SYS(sys_ni_syscall , 0)    /* 4270 sys_set_mempolicy */
> -        MIPS_SYS(sys_mq_open    , 4)
> -        MIPS_SYS(sys_mq_unlink  , 1)
> -        MIPS_SYS(sys_mq_timedsend, 5)
> -        MIPS_SYS(sys_mq_timedreceive, 5)
> -        MIPS_SYS(sys_mq_notify  , 2)    /* 4275 */
> -        MIPS_SYS(sys_mq_getsetattr, 3)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* sys_vserver */
> -        MIPS_SYS(sys_waitid     , 4)
> -        MIPS_SYS(sys_ni_syscall , 0)    /* available, was setaltroot */
> -        MIPS_SYS(sys_add_key    , 5)
> -        MIPS_SYS(sys_request_key, 4)
> -        MIPS_SYS(sys_keyctl     , 5)
> -        MIPS_SYS(sys_set_thread_area, 1)
> -        MIPS_SYS(sys_inotify_init, 0)
> -        MIPS_SYS(sys_inotify_add_watch, 3) /* 4285 */
> -        MIPS_SYS(sys_inotify_rm_watch, 2)
> -        MIPS_SYS(sys_migrate_pages, 4)
> -        MIPS_SYS(sys_openat, 4)
> -        MIPS_SYS(sys_mkdirat, 3)
> -        MIPS_SYS(sys_mknodat, 4)        /* 4290 */
> -        MIPS_SYS(sys_fchownat, 5)
> -        MIPS_SYS(sys_futimesat, 3)
> -        MIPS_SYS(sys_fstatat64, 4)
> -        MIPS_SYS(sys_unlinkat, 3)
> -        MIPS_SYS(sys_renameat, 4)       /* 4295 */
> -        MIPS_SYS(sys_linkat, 5)
> -        MIPS_SYS(sys_symlinkat, 3)
> -        MIPS_SYS(sys_readlinkat, 4)
> -        MIPS_SYS(sys_fchmodat, 3)
> -        MIPS_SYS(sys_faccessat, 3)      /* 4300 */
> -        MIPS_SYS(sys_pselect6, 6)
> -        MIPS_SYS(sys_ppoll, 5)
> -        MIPS_SYS(sys_unshare, 1)
> -        MIPS_SYS(sys_splice, 6)
> -        MIPS_SYS(sys_sync_file_range, 7) /* 4305 */
> -        MIPS_SYS(sys_tee, 4)
> -        MIPS_SYS(sys_vmsplice, 4)
> -        MIPS_SYS(sys_move_pages, 6)
> -        MIPS_SYS(sys_set_robust_list, 2)
> -        MIPS_SYS(sys_get_robust_list, 3) /* 4310 */
> -        MIPS_SYS(sys_kexec_load, 4)
> -        MIPS_SYS(sys_getcpu, 3)
> -        MIPS_SYS(sys_epoll_pwait, 6)
> -        MIPS_SYS(sys_ioprio_set, 3)
> -        MIPS_SYS(sys_ioprio_get, 2)
> -        MIPS_SYS(sys_utimensat, 4)
> -        MIPS_SYS(sys_signalfd, 3)
> -        MIPS_SYS(sys_ni_syscall, 0)     /* was timerfd */
> -        MIPS_SYS(sys_eventfd, 1)
> -        MIPS_SYS(sys_fallocate, 6)      /* 4320 */
> -        MIPS_SYS(sys_timerfd_create, 2)
> -        MIPS_SYS(sys_timerfd_gettime, 2)
> -        MIPS_SYS(sys_timerfd_settime, 4)
> -        MIPS_SYS(sys_signalfd4, 4)
> -        MIPS_SYS(sys_eventfd2, 2)       /* 4325 */
> -        MIPS_SYS(sys_epoll_create1, 1)
> -        MIPS_SYS(sys_dup3, 3)
> -        MIPS_SYS(sys_pipe2, 2)
> -        MIPS_SYS(sys_inotify_init1, 1)
> -        MIPS_SYS(sys_preadv, 5)         /* 4330 */
> -        MIPS_SYS(sys_pwritev, 5)
> -        MIPS_SYS(sys_rt_tgsigqueueinfo, 4)
> -        MIPS_SYS(sys_perf_event_open, 5)
> -        MIPS_SYS(sys_accept4, 4)
> -        MIPS_SYS(sys_recvmmsg, 5)       /* 4335 */
> -        MIPS_SYS(sys_fanotify_init, 2)
> -        MIPS_SYS(sys_fanotify_mark, 6)
> -        MIPS_SYS(sys_prlimit64, 4)
> -        MIPS_SYS(sys_name_to_handle_at, 5)
> -        MIPS_SYS(sys_open_by_handle_at, 3) /* 4340 */
> -        MIPS_SYS(sys_clock_adjtime, 2)
> -        MIPS_SYS(sys_syncfs, 1)
> -        MIPS_SYS(sys_sendmmsg, 4)
> -        MIPS_SYS(sys_setns, 2)
> -        MIPS_SYS(sys_process_vm_readv, 6) /* 345 */
> -        MIPS_SYS(sys_process_vm_writev, 6)
> -        MIPS_SYS(sys_kcmp, 5)
> -        MIPS_SYS(sys_finit_module, 3)
> -        MIPS_SYS(sys_sched_setattr, 2)
> -        MIPS_SYS(sys_sched_getattr, 3)  /* 350 */
> -        MIPS_SYS(sys_renameat2, 5)
> -        MIPS_SYS(sys_seccomp, 3)
> -        MIPS_SYS(sys_getrandom, 3)
> -        MIPS_SYS(sys_memfd_create, 2)
> -        MIPS_SYS(sys_bpf, 3)            /* 355 */
> -        MIPS_SYS(sys_execveat, 5)
> -        MIPS_SYS(sys_userfaultfd, 1)
> -        MIPS_SYS(sys_membarrier, 2)
> -        MIPS_SYS(sys_mlock2, 3)
> -        MIPS_SYS(sys_copy_file_range, 6) /* 360 */
> -        MIPS_SYS(sys_preadv2, 6)
> -        MIPS_SYS(sys_pwritev2, 6)
> -        MIPS_SYS(sys_pkey_mprotect, 4)
> -        MIPS_SYS(sys_pkey_alloc, 2)
> -        MIPS_SYS(sys_pkey_free, 1)                 /* 365 */
> -        MIPS_SYS(sys_statx, 5)
> -        MIPS_SYS(sys_rseq, 4)
> -        MIPS_SYS(sys_io_pgetevents, 6)
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,                /* 370 */
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,                /* 375 */
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,                /* 380 */
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,                /* 385 */
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,                /* 390 */
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYSCALL_NUMBER_UNUSED,
> -        MIPS_SYS(sys_semget, 3)
> -        MIPS_SYS(sys_semctl, 4)
> -        MIPS_SYS(sys_shmget, 3)                    /* 395 */
> -        MIPS_SYS(sys_shmctl, 3)
> -        MIPS_SYS(sys_shmat, 3)
> -        MIPS_SYS(sys_shmdt, 1)
> -        MIPS_SYS(sys_msgget, 2)
> -        MIPS_SYS(sys_msgsnd, 4)                    /* 400 */
> -        MIPS_SYS(sys_msgrcv, 5)
> -        MIPS_SYS(sys_msgctl, 3)
> -        MIPS_SYS(sys_clock_gettime64, 2)
> -        MIPS_SYS(sys_clock_settime64, 2)
> -        MIPS_SYS(sys_clock_adjtime64, 2)           /* 405 */
> -        MIPS_SYS(sys_clock_getres_time64, 2)
> -        MIPS_SYS(sys_clock_nanosleep_time64, 4)
> -        MIPS_SYS(sys_timer_gettime64, 2)
> -        MIPS_SYS(sys_timer_settime64, 4)
> -        MIPS_SYS(sys_timerfd_gettime64, 2)         /* 410 */
> -        MIPS_SYS(sys_timerfd_settime64, 4)
> -        MIPS_SYS(sys_utimensat_time64, 4)
> -        MIPS_SYS(sys_pselect6_time64, 6)
> -        MIPS_SYS(sys_ppoll_time64, 5)
> -        MIPS_SYSCALL_NUMBER_UNUSED,                /* 415 */
> -        MIPS_SYS(sys_io_pgetevents_time64, 6)
> -        MIPS_SYS(sys_recvmmsg_time64, 5)
> -        MIPS_SYS(sys_mq_timedsend_time64, 5)
> -        MIPS_SYS(sys_mq_timedreceive_time64, 5)
> -        MIPS_SYS(sys_semtimedop_time64, 4)         /* 420 */
> -        MIPS_SYS(sys_rt_sigtimedwait_time64, 4)
> -        MIPS_SYS(sys_futex_time64, 6)
> -        MIPS_SYS(sys_sched_rr_get_interval_time64, 2)
> -        MIPS_SYS(sys_pidfd_send_signal, 4)
> -        MIPS_SYS(sys_io_uring_setup, 2)            /* 425 */
> -        MIPS_SYS(sys_io_uring_enter, 6)
> -        MIPS_SYS(sys_io_uring_register, 4)
> -        MIPS_SYS(sys_open_tree, 3)
> -        MIPS_SYS(sys_move_mount, 5)
> -        MIPS_SYS(sys_fsopen, 2)                    /* 430 */
> -        MIPS_SYS(sys_fsconfig, 5)
> -        MIPS_SYS(sys_fsmount, 3)
> -        MIPS_SYS(sys_fspick, 3)
> -        MIPS_SYS(sys_pidfd_open, 2)
> -        MIPS_SYS(sys_clone3, 2)                    /* 435 */
> -#  undef MIPS_SYS
> +    [   0] = 7, /* syscall */
> +    [   1] = 1, /* exit */
> +    [   2] = 0, /* fork */
> +    [   3] = 3, /* read */
> +    [   4] = 3, /* write */
> +    [   5] = 3, /* open */
> +    [   6] = 1, /* close */
> +    [   7] = 3, /* waitpid */
> +    [   8] = 2, /* creat */
> +    [   9] = 2, /* link */
> +    [  10] = 1, /* unlink */
> +    [  11] = 3, /* execve */
> +    [  12] = 1, /* chdir */
> +    [  13] = 1, /* time */
> +    [  14] = 3, /* mknod */
> +    [  15] = 2, /* chmod */
> +    [  16] = 3, /* lchown */
> +    [  17] = 0, /* break */
> +    [  18] = 2, /* oldstat */
> +    [  19] = 3, /* lseek */
> +    [  20] = 0, /* getpid */
> +    [  21] = 5, /* mount */
> +    [  22] = 1, /* umount */
> +    [  23] = 1, /* setuid */
> +    [  24] = 0, /* getuid */
> +    [  25] = 1, /* stime */
> +    [  26] = 4, /* ptrace */
> +    [  27] = 1, /* alarm */
> +    [  28] = 2, /* oldfstat */
> +    [  29] = 0, /* pause */
> +    [  30] = 2, /* utime */
> +    [  31] = 0, /* stty */
> +    [  32] = 0, /* gtty */
> +    [  33] = 2, /* access */
> +    [  34] = 1, /* nice */
> +    [  35] = 1, /* ftime */
> +    [  36] = 0, /* sync */
> +    [  37] = 2, /* kill */
> +    [  38] = 2, /* rename */
> +    [  39] = 2, /* mkdir */
> +    [  40] = 1, /* rmdir */
> +    [  41] = 1, /* dup */
> +    [  42] = 0, /* pipe */
> +    [  43] = 1, /* times */
> +    [  44] = 0, /* prof */
> +    [  45] = 1, /* brk */
> +    [  46] = 1, /* setgid */
> +    [  47] = 0, /* getgid */
> +    [  48] = 2, /* signal */
> +    [  49] = 0, /* geteuid */
> +    [  50] = 0, /* getegid */
> +    [  51] = 1, /* acct */
> +    [  52] = 2, /* umount2 */
> +    [  53] = 0, /* lock */
> +    [  54] = 3, /* ioctl */
> +    [  55] = 3, /* fcntl */
> +    [  56] = 0, /* mpx */
> +    [  57] = 2, /* setpgid */
> +    [  58] = 0, /* ulimit */
> +    [  59] = 1, /* oldolduname */
> +    [  60] = 1, /* umask */
> +    [  61] = 1, /* chroot */
> +    [  62] = 2, /* ustat */
> +    [  63] = 2, /* dup2 */
> +    [  64] = 0, /* getppid */
> +    [  65] = 0, /* getpgrp */
> +    [  66] = 0, /* setsid */
> +    [  67] = 3, /* sigaction */
> +    [  68] = 0, /* sgetmask */
> +    [  69] = 1, /* ssetmask */
> +    [  70] = 2, /* setreuid */
> +    [  71] = 2, /* setregid */
> +    [  72] = 1, /* sigsuspend */
> +    [  73] = 1, /* sigpending */
> +    [  74] = 2, /* sethostname */
> +    [  75] = 2, /* setrlimit */
> +    [  76] = 2, /* getrlimit */
> +    [  77] = 2, /* getrusage */
> +    [  78] = 2, /* gettimeofday */
> +    [  79] = 2, /* settimeofday */
> +    [  80] = 2, /* getgroups */
> +    [  81] = 2, /* setgroups */
> +    [  82] = 0, /* reserved82 */
> +    [  83] = 2, /* symlink */
> +    [  84] = 2, /* oldlstat */
> +    [  85] = 3, /* readlink */
> +    [  86] = 1, /* uselib */
> +    [  87] = 2, /* swapon */
> +    [  88] = 4, /* reboot */
> +    [  89] = 3, /* readdir */
> +    [  90] = 6, /* mmap */
> +    [  91] = 2, /* munmap */
> +    [  92] = 2, /* truncate */
> +    [  93] = 2, /* ftruncate */
> +    [  94] = 2, /* fchmod */
> +    [  95] = 3, /* fchown */
> +    [  96] = 2, /* getpriority */
> +    [  97] = 3, /* setpriority */
> +    [  98] = 0, /* profil */
> +    [  99] = 2, /* statfs */
> +    [ 100] = 2, /* fstatfs */
> +    [ 101] = 3, /* ioperm */
> +    [ 102] = 2, /* socketcall */
> +    [ 103] = 3, /* syslog */
> +    [ 104] = 3, /* setitimer */
> +    [ 105] = 2, /* getitimer */
> +    [ 106] = 2, /* stat */
> +    [ 107] = 2, /* lstat */
> +    [ 108] = 2, /* fstat */
> +    [ 109] = 1, /* olduname */
> +    [ 110] = 1, /* iopl */
> +    [ 111] = 0, /* vhangup */
> +    [ 112] = 0, /* idle */
> +    [ 113] = 5, /* vm86 */
> +    [ 114] = 4, /* wait4 */
> +    [ 115] = 1, /* swapoff */
> +    [ 116] = 1, /* sysinfo */
> +    [ 117] = 6, /* ipc */
> +    [ 118] = 1, /* fsync */
> +    [ 119] = 0, /* sigreturn */
> +    [ 120] = 5, /* clone */
> +    [ 121] = 2, /* setdomainname */
> +    [ 122] = 1, /* uname */
> +    [ 123] = 0, /* modify_ldt */
> +    [ 124] = 1, /* adjtimex */
> +    [ 125] = 3, /* mprotect */
> +    [ 126] = 3, /* sigprocmask */
> +    [ 127] = 2, /* create_module */
> +    [ 128] = 3, /* init_module */
> +    [ 129] = 2, /* delete_module */
> +    [ 130] = 1, /* get_kernel_syms */
> +    [ 131] = 4, /* quotactl */
> +    [ 132] = 1, /* getpgid */
> +    [ 133] = 1, /* fchdir */
> +    [ 134] = 2, /* bdflush */
> +    [ 135] = 3, /* sysfs */
> +    [ 136] = 1, /* personality */
> +    [ 137] = 0, /* afs_syscall */
> +    [ 138] = 1, /* setfsuid */
> +    [ 139] = 1, /* setfsgid */
> +    [ 140] = 5, /* _llseek */
> +    [ 141] = 3, /* getdents */
> +    [ 142] = 5, /* _newselect */
> +    [ 143] = 2, /* flock */
> +    [ 144] = 3, /* msync */
> +    [ 145] = 3, /* readv */
> +    [ 146] = 3, /* writev */
> +    [ 147] = 3, /* cacheflush */
> +    [ 148] = 3, /* cachectl */
> +    [ 149] = 4, /* sysmips */
> +    [ 150] = 0, /* setup */
> +    [ 151] = 1, /* getsid */
> +    [ 152] = 1, /* fdatasync */
> +    [ 153] = 1, /* _sysctl */
> +    [ 154] = 2, /* mlock */
> +    [ 155] = 2, /* munlock */
> +    [ 156] = 1, /* mlockall */
> +    [ 157] = 0, /* munlockall */
> +    [ 158] = 2, /* sched_setparam */
> +    [ 159] = 2, /* sched_getparam */
> +    [ 160] = 3, /* sched_setscheduler */
> +    [ 161] = 1, /* sched_getscheduler */
> +    [ 162] = 0, /* sched_yield */
> +    [ 163] = 1, /* sched_get_priority_max */
> +    [ 164] = 1, /* sched_get_priority_min */
> +    [ 165] = 2, /* sched_rr_get_interval */
> +    [ 166] = 2, /* nanosleep */
> +    [ 167] = 5, /* mremap */
> +    [ 168] = 3, /* accept */
> +    [ 169] = 3, /* bind */
> +    [ 170] = 3, /* connect */
> +    [ 171] = 3, /* getpeername */
> +    [ 172] = 3, /* getsockname */
> +    [ 173] = 5, /* getsockopt */
> +    [ 174] = 2, /* listen */
> +    [ 175] = 4, /* recv */
> +    [ 176] = 6, /* recvfrom */
> +    [ 177] = 3, /* recvmsg */
> +    [ 178] = 4, /* send */
> +    [ 179] = 3, /* sendmsg */
> +    [ 180] = 6, /* sendto */
> +    [ 181] = 5, /* setsockopt */
> +    [ 182] = 2, /* shutdown */
> +    [ 183] = 3, /* socket */
> +    [ 184] = 4, /* socketpair */
> +    [ 185] = 3, /* setresuid */
> +    [ 186] = 3, /* getresuid */
> +    [ 187] = 5, /* query_module */
> +    [ 188] = 3, /* poll */
> +    [ 189] = 3, /* nfsservctl */
> +    [ 190] = 3, /* setresgid */
> +    [ 191] = 3, /* getresgid */
> +    [ 192] = 5, /* prctl */
> +    [ 193] = 0, /* rt_sigreturn */
> +    [ 194] = 4, /* rt_sigaction */
> +    [ 195] = 4, /* rt_sigprocmask */
> +    [ 196] = 2, /* rt_sigpending */
> +    [ 197] = 4, /* rt_sigtimedwait */
> +    [ 198] = 3, /* rt_sigqueueinfo */
> +    [ 199] = 2, /* rt_sigsuspend */
> +    [ 200] = 6, /* pread64 */
> +    [ 201] = 6, /* pwrite64 */
> +    [ 202] = 3, /* chown */
> +    [ 203] = 2, /* getcwd */
> +    [ 204] = 2, /* capget */
> +    [ 205] = 2, /* capset */
> +    [ 206] = 2, /* sigaltstack */
> +    [ 207] = 4, /* sendfile */
> +    [ 208] = 5, /* getpmsg */
> +    [ 209] = 5, /* putpmsg */
> +    [ 210] = 6, /* mmap2 */
> +    [ 211] = 4, /* truncate64 */
> +    [ 212] = 4, /* ftruncate64 */
> +    [ 213] = 2, /* stat64 */
> +    [ 214] = 2, /* lstat64 */
> +    [ 215] = 2, /* fstat64 */
> +    [ 216] = 2, /* pivot_root */
> +    [ 217] = 3, /* mincore */
> +    [ 218] = 3, /* madvise */
> +    [ 219] = 3, /* getdents64 */
> +    [ 220] = 3, /* fcntl64 */
> +    [ 221] = 0, /* reserved221 */
> +    [ 222] = 0, /* gettid */
> +    [ 223] = 5, /* readahead */
> +    [ 224] = 5, /* setxattr */
> +    [ 225] = 5, /* lsetxattr */
> +    [ 226] = 5, /* fsetxattr */
> +    [ 227] = 4, /* getxattr */
> +    [ 228] = 4, /* lgetxattr */
> +    [ 229] = 4, /* fgetxattr */
> +    [ 230] = 3, /* listxattr */
> +    [ 231] = 3, /* llistxattr */
> +    [ 232] = 3, /* flistxattr */
> +    [ 233] = 2, /* removexattr */
> +    [ 234] = 2, /* lremovexattr */
> +    [ 235] = 2, /* fremovexattr */
> +    [ 236] = 2, /* tkill */
> +    [ 237] = 4, /* sendfile64 */
> +    [ 238] = 6, /* futex */
> +    [ 239] = 3, /* sched_setaffinity */
> +    [ 240] = 3, /* sched_getaffinity */
> +    [ 241] = 2, /* io_setup */
> +    [ 242] = 1, /* io_destroy */
> +    [ 243] = 5, /* io_getevents */
> +    [ 244] = 3, /* io_submit */
> +    [ 245] = 3, /* io_cancel */
> +    [ 246] = 1, /* exit_group */
> +    [ 247] = 4, /* lookup_dcookie */
> +    [ 248] = 1, /* epoll_create */
> +    [ 249] = 4, /* epoll_ctl */
> +    [ 250] = 4, /* epoll_wait */
> +    [ 251] = 5, /* remap_file_pages */
> +    [ 252] = 1, /* set_tid_address */
> +    [ 253] = 0, /* restart_syscall */
> +    [ 254] = 7, /* fadvise64 */
> +    [ 255] = 3, /* statfs64 */
> +    [ 256] = 3, /* fstatfs64 */
> +    [ 257] = 3, /* timer_create */
> +    [ 258] = 4, /* timer_settime */
> +    [ 259] = 2, /* timer_gettime */
> +    [ 260] = 1, /* timer_getoverrun */
> +    [ 261] = 1, /* timer_delete */
> +    [ 262] = 2, /* clock_settime */
> +    [ 263] = 2, /* clock_gettime */
> +    [ 264] = 2, /* clock_getres */
> +    [ 265] = 4, /* clock_nanosleep */
> +    [ 266] = 3, /* tgkill */
> +    [ 267] = 2, /* utimes */
> +    [ 268] = 6, /* mbind */
> +    [ 269] = 5, /* get_mempolicy */
> +    [ 270] = 3, /* set_mempolicy */
> +    [ 271] = 4, /* mq_open */
> +    [ 272] = 1, /* mq_unlink */
> +    [ 273] = 5, /* mq_timedsend */
> +    [ 274] = 5, /* mq_timedreceive */
> +    [ 275] = 2, /* mq_notify */
> +    [ 276] = 3, /* mq_getsetattr */
> +    [ 277] = 5, /* vserver */
> +    [ 278] = 5, /* waitid */
> +    [ 279] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 280] = 5, /* add_key */
> +    [ 281] = 4, /* request_key */
> +    [ 282] = 5, /* keyctl */
> +    [ 283] = 1, /* set_thread_area */
> +    [ 284] = 0, /* inotify_init */
> +    [ 285] = 3, /* inotify_add_watch */
> +    [ 286] = 2, /* inotify_rm_watch */
> +    [ 287] = 4, /* migrate_pages */
> +    [ 288] = 4, /* openat */
> +    [ 289] = 3, /* mkdirat */
> +    [ 290] = 4, /* mknodat */
> +    [ 291] = 5, /* fchownat */
> +    [ 292] = 3, /* futimesat */
> +    [ 293] = 4, /* fstatat64 */
> +    [ 294] = 3, /* unlinkat */
> +    [ 295] = 4, /* renameat */
> +    [ 296] = 5, /* linkat */
> +    [ 297] = 3, /* symlinkat */
> +    [ 298] = 4, /* readlinkat */
> +    [ 299] = 3, /* fchmodat */
> +    [ 300] = 3, /* faccessat */
> +    [ 301] = 6, /* pselect6 */
> +    [ 302] = 5, /* ppoll */
> +    [ 303] = 1, /* unshare */
> +    [ 304] = 6, /* splice */
> +    [ 305] = 7, /* sync_file_range */
> +    [ 306] = 4, /* tee */
> +    [ 307] = 4, /* vmsplice */
> +    [ 308] = 6, /* move_pages */
> +    [ 309] = 2, /* set_robust_list */
> +    [ 310] = 3, /* get_robust_list */
> +    [ 311] = 4, /* kexec_load */
> +    [ 312] = 3, /* getcpu */
> +    [ 313] = 6, /* epoll_pwait */
> +    [ 314] = 3, /* ioprio_set */
> +    [ 315] = 2, /* ioprio_get */
> +    [ 316] = 4, /* utimensat */
> +    [ 317] = 3, /* signalfd */
> +    [ 318] = 4, /* timerfd */
> +    [ 319] = 1, /* eventfd */
> +    [ 320] = 6, /* fallocate */
> +    [ 321] = 2, /* timerfd_create */
> +    [ 322] = 2, /* timerfd_gettime */
> +    [ 323] = 4, /* timerfd_settime */
> +    [ 324] = 4, /* signalfd4 */
> +    [ 325] = 2, /* eventfd2 */
> +    [ 326] = 1, /* epoll_create1 */
> +    [ 327] = 3, /* dup3 */
> +    [ 328] = 2, /* pipe2 */
> +    [ 329] = 1, /* inotify_init1 */
> +    [ 330] = 5, /* preadv */
> +    [ 331] = 5, /* pwritev */
> +    [ 332] = 4, /* rt_tgsigqueueinfo */
> +    [ 333] = 5, /* perf_event_open */
> +    [ 334] = 4, /* accept4 */
> +    [ 335] = 5, /* recvmmsg */
> +    [ 336] = 2, /* fanotify_init */
> +    [ 337] = 6, /* fanotify_mark */
> +    [ 338] = 4, /* prlimit64 */
> +    [ 339] = 5, /* name_to_handle_at */
> +    [ 340] = 3, /* open_by_handle_at */
> +    [ 341] = 2, /* clock_adjtime */
> +    [ 342] = 1, /* syncfs */
> +    [ 343] = 4, /* sendmmsg */
> +    [ 344] = 2, /* setns */
> +    [ 345] = 6, /* process_vm_readv */
> +    [ 346] = 6, /* process_vm_writev */
> +    [ 347] = 5, /* kcmp */
> +    [ 348] = 3, /* finit_module */
> +    [ 349] = 3, /* sched_setattr */
> +    [ 350] = 4, /* sched_getattr */
> +    [ 351] = 5, /* renameat2 */
> +    [ 352] = 3, /* seccomp */
> +    [ 353] = 3, /* getrandom */
> +    [ 354] = 2, /* memfd_create */
> +    [ 355] = 3, /* bpf */
> +    [ 356] = 5, /* execveat */
> +    [ 357] = 1, /* userfaultfd */
> +    [ 358] = 2, /* membarrier */
> +    [ 359] = 3, /* mlock2 */
> +    [ 360] = 6, /* copy_file_range */
> +    [ 361] = 6, /* preadv2 */
> +    [ 362] = 6, /* pwritev2 */
> +    [ 363] = 4, /* pkey_mprotect */
> +    [ 364] = 2, /* pkey_alloc */
> +    [ 365] = 1, /* pkey_free */
> +    [ 366] = 5, /* statx */
> +    [ 367] = 4, /* rseq */
> +    [ 368] = 6, /* io_pgetevents */
> +    [ 369] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 370] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 371] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 372] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 373] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 374] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 375] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 376] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 377] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 378] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 379] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 380] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 381] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 382] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 383] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 384] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 385] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 386] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 387] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 388] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 389] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 390] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 391] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 392] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 393] = 3, /* semget */
> +    [ 394] = 4, /* semctl */
> +    [ 395] = 3, /* shmget */
> +    [ 396] = 3, /* shmctl */
> +    [ 397] = 3, /* shmat */
> +    [ 398] = 1, /* shmdt */
> +    [ 399] = 2, /* msgget */
> +    [ 400] = 4, /* msgsnd */
> +    [ 401] = 5, /* msgrcv */
> +    [ 402] = 3, /* msgctl */
> +    [ 403] = 2, /* clock_gettime64 */
> +    [ 404] = 2, /* clock_settime64 */
> +    [ 405] = 2, /* clock_adjtime64 */
> +    [ 406] = 2, /* clock_getres_time64 */
> +    [ 407] = 4, /* clock_nanosleep_time64 */
> +    [ 408] = 2, /* timer_gettime64 */
> +    [ 409] = 4, /* timer_settime64 */
> +    [ 410] = 2, /* timerfd_gettime64 */
> +    [ 411] = 4, /* timerfd_settime64 */
> +    [ 412] = 4, /* utimensat_time64 */
> +    [ 413] = 6, /* pselect6_time64 */
> +    [ 414] = 5, /* ppoll_time64 */
> +    [ 415] = MIPS_SYSCALL_NUMBER_UNUSED,
> +    [ 416] = 6, /* io_pgetevents_time64 */
> +    [ 417] = 5, /* recvmmsg_time64 */
> +    [ 418] = 5, /* mq_timedsend_time64 */
> +    [ 419] = 5, /* mq_timedreceive_time64 */
> +    [ 420] = 4, /* semtimedop_time64 */
> +    [ 421] = 4, /* rt_sigtimedwait_time64 */
> +    [ 422] = 6, /* futex_time64 */
> +    [ 423] = 2, /* sched_rr_get_interval_time64 */
> +    [ 424] = 4, /* pidfd_send_signal */
> +    [ 425] = 2, /* io_uring_setup */
> +    [ 426] = 6, /* io_uring_enter */
> +    [ 427] = 4, /* io_uring_register */
> +    [ 428] = 3, /* open_tree */
> +    [ 429] = 5, /* move_mount */
> +    [ 430] = 2, /* fsopen */
> +    [ 431] = 5, /* fsconfig */
> +    [ 432] = 3, /* fsmount */
> +    [ 433] = 3, /* fspick */
> +    [ 434] = 2, /* pidfd_open */
> +    [ 435] = 2, /* clone3 */
> diff --git a/scripts/update-mips-syscall-args.sh
> b/scripts/update-mips-syscall-args.sh
> new file mode 100755
> index 000000000000..4f0dda4b83bc
> --- /dev/null
> +++ b/scripts/update-mips-syscall-args.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +
> +URL=https://raw.githubusercontent.com/strace/strace/master
> +FILES="sysent.h sysent_shorthand_defs.h linux/mips/syscallent-compat.h \
> +       linux/mips/syscallent-o32.h linux/syscallent-common-32.h \
> +       linux/syscallent-common.h"
> +
> +output="$1"
> +if [ "$output" = "" ] ; then
> +    output="$PWD"
> +fi
> +
> +INC=linux-user/mips/syscall-args-o32.c.inc
> +
> +TMP=$(mktemp -d)
> +cd $TMP
> +
> +for file in $FILES; do
> +    curl -O $URL/$file
> +done
> +
> +> subcall32.h
> +
> +cat > gen_mips_o32.c <<EOF
> +#include <stdio.h>
> +
> +#define LINUX_MIPSO32
> +#define MAX_ARGS 7
> +
> +#include "sysent.h"
> +#include "sysent_shorthand_defs.h"
> +
> +#define SEN(syscall_name) 0,0
> +const struct_sysent sysent0[] = {
> +#include  "syscallent-o32.h"
> +};
> +
> +int main(void)
> +{
> +    int i;
> +
> +    for (i = 4000; i < sizeof(sysent0) / sizeof(struct_sysent); i++) {
> +        if (sysent0[i].sys_name == NULL) {
> +            printf("    [% 4d] = MIPS_SYSCALL_NUMBER_UNUSED,\n", i -
> 4000);
> +        } else {
> +            printf("    [% 4d] = %d, /* %s */\n", i - 4000,
> +                   sysent0[i].nargs, sysent0[i].sys_name);
> +        }
> +    }
> +
> +    return 0;
> +}
> +EOF
> +
> +cc -o gen_mips_o32 gen_mips_o32.c && ./gen_mips_o32 > "$output/$INC"
> +
> +rm -fr "$TMP"
> --
> 2.24.1
>
>
>

--0000000000002fca9f059edd6cce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, February 17, 2020, Laurent Vivier &lt;<a href=3D"mailto:=
laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Add a script to update the file from strace github and run it<br=
>
<br>
Signed-off-by: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laur=
ent@vivier.eu</a>&gt;<br>
---</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);font=
-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovic=
 &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:14=
px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=3D=
"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;</s=
pan></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0linux-user/mips/syscall-args-<wbr>o32.c.inc | 874 ++++++++++++-------=
------<br>
=C2=A0scripts/update-mips-syscall-<wbr>args.sh=C2=A0 =C2=A0 |=C2=A0 57 ++<b=
r>
=C2=A02 files changed, 493 insertions(+), 438 deletions(-)<br>
=C2=A0create mode 100755 scripts/update-mips-syscall-<wbr>args.sh<br>
<br>
diff --git a/linux-user/mips/syscall-<wbr>args-o32.c.inc b/linux-user/mips/=
syscall-<wbr>args-o32.c.inc<br>
index f060b061441a..0ad35857b4e4 100644<br>
--- a/linux-user/mips/syscall-<wbr>args-o32.c.inc<br>
+++ b/linux-user/mips/syscall-<wbr>args-o32.c.inc<br>
@@ -1,438 +1,436 @@<br>
-#=C2=A0 define MIPS_SYS(name, args) args,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_syscall=C2=A0 =C2=A0 , 8)=C2=A0 =
=C2=A0 /* 4000 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_exit=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fork=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_read=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_write=C2=A0 =C2=A0 =C2=A0 , 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_open=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
3)=C2=A0 =C2=A0 /* 4005 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_close=C2=A0 =C2=A0 =C2=A0 , 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_waitpid=C2=A0 =C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_creat=C2=A0 =C2=A0 =C2=A0 , 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_link=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_unlink=C2=A0 =C2=A0 =C2=A0, 1)=C2=
=A0 =C2=A0 /* 4010 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_execve=C2=A0 =C2=A0 =C2=A0, 0)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_chdir=C2=A0 =C2=A0 =C2=A0 , 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_time=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mknod=C2=A0 =C2=A0 =C2=A0 , 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_chmod=C2=A0 =C2=A0 =C2=A0 , 2)=C2=
=A0 =C2=A0 /* 4015 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_lchown=C2=A0 =C2=A0 =C2=A0, 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* w=
as sys_stat */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_lseek=C2=A0 =C2=A0 =C2=A0 , 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getpid=C2=A0 =C2=A0 =C2=A0, 0)=C2=
=A0 =C2=A0 /* 4020 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mount=C2=A0 =C2=A0 =C2=A0 , 5)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_umount=C2=A0 =C2=A0 =C2=A0, 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setuid=C2=A0 =C2=A0 =C2=A0, 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getuid=C2=A0 =C2=A0 =C2=A0, 0)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_stime=C2=A0 =C2=A0 =C2=A0 , 1)=C2=
=A0 =C2=A0 /* 4025 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ptrace=C2=A0 =C2=A0 =C2=A0, 4)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_alarm=C2=A0 =C2=A0 =C2=A0 , 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* w=
as sys_fstat */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pause=C2=A0 =C2=A0 =C2=A0 , 0)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_utime=C2=A0 =C2=A0 =C2=A0 , 2)=C2=
=A0 =C2=A0 /* 4030 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_access=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_nice=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* 4=
035 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sync=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_kill=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rename=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mkdir=C2=A0 =C2=A0 =C2=A0 , 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rmdir=C2=A0 =C2=A0 =C2=A0 , 1)=C2=
=A0 =C2=A0 /* 4040 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_dup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 , 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pipe=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_times=C2=A0 =C2=A0 =C2=A0 , 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_brk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 , 1)=C2=A0 =C2=A0 /* 4045 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setgid=C2=A0 =C2=A0 =C2=A0, 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getgid=C2=A0 =C2=A0 =C2=A0, 0)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* w=
as signal(2) */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_geteuid=C2=A0 =C2=A0 , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getegid=C2=A0 =C2=A0 , 0)=C2=A0 =
=C2=A0 /* 4050 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_acct=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_umount2=C2=A0 =C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ioctl=C2=A0 =C2=A0 =C2=A0 , 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fcntl=C2=A0 =C2=A0 =C2=A0 , 3)=C2=
=A0 =C2=A0 /* 4055 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setpgid=C2=A0 =C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_olduname=C2=A0 =C2=A0, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_umask=C2=A0 =C2=A0 =C2=A0 , 1)=C2=
=A0 =C2=A0 /* 4060 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_chroot=C2=A0 =C2=A0 =C2=A0, 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ustat=C2=A0 =C2=A0 =C2=A0 , 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_dup2=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getppid=C2=A0 =C2=A0 , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getpgrp=C2=A0 =C2=A0 , 0)=C2=A0 =
=C2=A0 /* 4065 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setsid=C2=A0 =C2=A0 =C2=A0, 0)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sigaction=C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sgetmask=C2=A0 =C2=A0, 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ssetmask=C2=A0 =C2=A0, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setreuid=C2=A0 =C2=A0, 2)=C2=A0 =
=C2=A0 /* 4070 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setregid=C2=A0 =C2=A0, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sigsuspend , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sigpending , 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sethostname=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setrlimit=C2=A0 , 2)=C2=A0 =C2=A0=
 /* 4075 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getrlimit=C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getrusage=C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_gettimeofday, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_settimeofday, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getgroups=C2=A0 , 2)=C2=A0 =C2=A0=
 /* 4080 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setgroups=C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* o=
ld_select */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_symlink=C2=A0 =C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* w=
as sys_lstat */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_readlink=C2=A0 =C2=A0, 3)=C2=A0 =
=C2=A0 /* 4085 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_uselib=C2=A0 =C2=A0 =C2=A0, 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_swapon=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_reboot=C2=A0 =C2=A0 =C2=A0, 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(old_readdir=C2=A0 =C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(old_mmap=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
6)=C2=A0 =C2=A0 /* 4090 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_munmap=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_truncate=C2=A0 =C2=A0, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ftruncate=C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fchmod=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fchown=C2=A0 =C2=A0 =C2=A0, 3)=C2=
=A0 =C2=A0 /* 4095 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getpriority=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setpriority=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_statfs=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fstatfs=C2=A0 =C2=A0 , 2)=C2=A0 =
=C2=A0 /* 4100 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* w=
as ioperm(2) */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_socketcall , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_syslog=C2=A0 =C2=A0 =C2=A0, 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setitimer=C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getitimer=C2=A0 , 2)=C2=A0 =C2=A0=
 /* 4105 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_newstat=C2=A0 =C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_newlstat=C2=A0 =C2=A0, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_newfstat=C2=A0 =C2=A0, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_uname=C2=A0 =C2=A0 =C2=A0 , 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* 4=
110 was iopl(2) */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_vhangup=C2=A0 =C2=A0 , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* w=
as sys_idle() */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* w=
as sys_vm86 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_wait4=C2=A0 =C2=A0 =C2=A0 , 4)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_swapoff=C2=A0 =C2=A0 , 1)=C2=A0 =
=C2=A0 /* 4115 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sysinfo=C2=A0 =C2=A0 , 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ipc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 , 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fsync=C2=A0 =C2=A0 =C2=A0 , 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sigreturn=C2=A0 , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clone=C2=A0 =C2=A0 =C2=A0 , 6)=C2=
=A0 =C2=A0 /* 4120 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setdomainname, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_newuname=C2=A0 =C2=A0, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* s=
ys_modify_ldt */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_adjtimex=C2=A0 =C2=A0, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mprotect=C2=A0 =C2=A0, 3)=C2=A0 =
=C2=A0 /* 4125 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sigprocmask=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* w=
as create_module */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_init_module=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_delete_module, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* 4=
130 was get_kernel_syms */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_quotactl=C2=A0 =C2=A0, 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getpgid=C2=A0 =C2=A0 , 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fchdir=C2=A0 =C2=A0 =C2=A0, 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_bdflush=C2=A0 =C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sysfs=C2=A0 =C2=A0 =C2=A0 , 3)=C2=
=A0 =C2=A0 /* 4135 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_personality=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* f=
or afs_syscall */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setfsuid=C2=A0 =C2=A0, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setfsgid=C2=A0 =C2=A0, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_llseek=C2=A0 =C2=A0 =C2=A0, 5)=C2=
=A0 =C2=A0 /* 4140 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getdents=C2=A0 =C2=A0, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_select=C2=A0 =C2=A0 =C2=A0, 5)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_flock=C2=A0 =C2=A0 =C2=A0 , 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_msync=C2=A0 =C2=A0 =C2=A0 , 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_readv=C2=A0 =C2=A0 =C2=A0 , 3)=C2=
=A0 =C2=A0 /* 4145 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_writev=C2=A0 =C2=A0 =C2=A0, 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_cacheflush , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_cachectl=C2=A0 =C2=A0, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sysmips=C2=A0 =C2=A0 , 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* 4=
150 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getsid=C2=A0 =C2=A0 =C2=A0, 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fdatasync=C2=A0 , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sysctl=C2=A0 =C2=A0 =C2=A0, 1)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mlock=C2=A0 =C2=A0 =C2=A0 , 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_munlock=C2=A0 =C2=A0 , 2)=C2=A0 =
=C2=A0 /* 4155 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mlockall=C2=A0 =C2=A0, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_munlockall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_setparam, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_getparam, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_<wbr>setscheduler, 3)=C2=A0=
 =C2=A0 =C2=A0/* 4160 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_<wbr>getscheduler, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_yield=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_get_<wbr>priority_max, 1)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_get_<wbr>priority_min, 1)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_rr_get_<wbr>interval, 2)=C2=
=A0 /* 4165 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_nanosleep, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mremap=C2=A0 =C2=A0 =C2=A0, 5)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_accept=C2=A0 =C2=A0 =C2=A0, 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_bind=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_connect=C2=A0 =C2=A0 , 3)=C2=A0 =
=C2=A0 /* 4170 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getpeername=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getsockname=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getsockopt , 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_listen=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_recv=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
4)=C2=A0 =C2=A0 /* 4175 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_recvfrom=C2=A0 =C2=A0, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_recvmsg=C2=A0 =C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_send=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sendmsg=C2=A0 =C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sendto=C2=A0 =C2=A0 =C2=A0, 6)=C2=
=A0 =C2=A0 /* 4180 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setsockopt , 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_shutdown=C2=A0 =C2=A0, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_socket=C2=A0 =C2=A0 =C2=A0, 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_socketpair , 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setresuid=C2=A0 , 3)=C2=A0 =C2=A0=
 /* 4185 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getresuid=C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* w=
as sys_query_module */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_poll=C2=A0 =C2=A0 =C2=A0 =C2=A0, =
3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_nfsservctl , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setresgid=C2=A0 , 3)=C2=A0 =C2=A0=
 /* 4190 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getresgid=C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_prctl=C2=A0 =C2=A0 =C2=A0 , 5)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rt_sigreturn, 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rt_sigaction, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rt_sigprocmask, 4) /* 4195 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rt_sigpending, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rt_sigtimedwait, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rt_sigqueueinfo, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rt_sigsuspend, 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pread64=C2=A0 =C2=A0 , 6)=C2=A0 =
=C2=A0 /* 4200 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pwrite64=C2=A0 =C2=A0, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_chown=C2=A0 =C2=A0 =C2=A0 , 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getcwd=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_capget=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_capset=C2=A0 =C2=A0 =C2=A0, 2)=C2=
=A0 =C2=A0 /* 4205 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sigaltstack=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sendfile=C2=A0 =C2=A0, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mmap2=C2=A0 =C2=A0 =C2=A0 , 6)=C2=
=A0 =C2=A0 /* 4210 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_truncate64 , 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ftruncate64=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_stat64=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_lstat64=C2=A0 =C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fstat64=C2=A0 =C2=A0 , 2)=C2=A0 =
=C2=A0 /* 4215 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pivot_root , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mincore=C2=A0 =C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_madvise=C2=A0 =C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getdents64 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fcntl64=C2=A0 =C2=A0 , 3)=C2=A0 =
=C2=A0 /* 4220 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_gettid=C2=A0 =C2=A0 =C2=A0, 0)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_readahead=C2=A0 , 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setxattr=C2=A0 =C2=A0, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_lsetxattr=C2=A0 , 5)=C2=A0 =C2=A0=
 /* 4225 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fsetxattr=C2=A0 , 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getxattr=C2=A0 =C2=A0, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_lgetxattr=C2=A0 , 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fgetxattr=C2=A0 , 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_listxattr=C2=A0 , 3)=C2=A0 =C2=A0=
 /* 4230 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_llistxattr , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_flistxattr , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_removexattr=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_lremovexattr, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fremovexattr, 2)=C2=A0 =C2=A0/* 4=
235 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_tkill=C2=A0 =C2=A0 =C2=A0 , 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sendfile64 , 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_futex=C2=A0 =C2=A0 =C2=A0 , 6)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_<wbr>setaffinity, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_<wbr>getaffinity, 3)=C2=A0 =
=C2=A0 =C2=A0 /* 4240 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_setup=C2=A0 =C2=A0, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_destroy , 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_getevents, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_submit=C2=A0 , 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_cancel=C2=A0 , 3)=C2=A0 =C2=A0=
 /* 4245 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_exit_group , 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_lookup_dcookie, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_epoll_create, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_epoll_ctl=C2=A0 , 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_epoll_wait , 3)=C2=A0 =C2=A0 /* 4=
250 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_remap_file_pages, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_set_tid_address, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_restart_syscall, 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fadvise64_64, 7)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_statfs64=C2=A0 =C2=A0, 3)=C2=A0 =
=C2=A0 /* 4255 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fstatfs64=C2=A0 , 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timer_create, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timer_settime, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timer_gettime, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timer_getoverrun, 1)=C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* 4260 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timer_delete, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_settime, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_gettime, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_getres, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_nanosleep, 4)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* 4265 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_tgkill=C2=A0 =C2=A0 =C2=A0, 3)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_utimes=C2=A0 =C2=A0 =C2=A0, 2)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mbind=C2=A0 =C2=A0 =C2=A0 , 4)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* s=
ys_get_mempolicy */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* 4=
270 sys_set_mempolicy */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mq_open=C2=A0 =C2=A0 , 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mq_unlink=C2=A0 , 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mq_timedsend, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mq_timedreceive, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mq_notify=C2=A0 , 2)=C2=A0 =C2=A0=
 /* 4275 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mq_getsetattr, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* s=
ys_vserver */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_waitid=C2=A0 =C2=A0 =C2=A0, 4)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall , 0)=C2=A0 =C2=A0 /* a=
vailable, was setaltroot */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_add_key=C2=A0 =C2=A0 , 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_request_key, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_keyctl=C2=A0 =C2=A0 =C2=A0, 5)<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_set_thread_area, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_inotify_init, 0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_inotify_add_<wbr>watch, 3) /* 428=
5 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_inotify_rm_watch, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_migrate_pages, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_openat, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mkdirat, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mknodat, 4)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* 4290 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fchownat, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_futimesat, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fstatat64, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_unlinkat, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_renameat, 4)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* 4295 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_linkat, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_symlinkat, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_readlinkat, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fchmodat, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_faccessat, 3)=C2=A0 =C2=A0 =C2=A0=
 /* 4300 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pselect6, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ppoll, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_unshare, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_splice, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sync_file_range, 7) /* 4305 */<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_tee, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_vmsplice, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_move_pages, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_set_robust_list, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_get_robust_list, 3) /* 4310 */<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_kexec_load, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getcpu, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_epoll_pwait, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ioprio_set, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ioprio_get, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_utimensat, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_signalfd, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ni_syscall, 0)=C2=A0 =C2=A0 =C2=
=A0/* was timerfd */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_eventfd, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fallocate, 6)=C2=A0 =C2=A0 =C2=A0=
 /* 4320 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timerfd_create, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timerfd_gettime, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timerfd_settime, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_signalfd4, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_eventfd2, 2)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* 4325 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_epoll_create1, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_dup3, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pipe2, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_inotify_init1, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_preadv, 5)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* 4330 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pwritev, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rt_<wbr>tgsigqueueinfo, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_perf_event_open, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_accept4, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_recvmmsg, 5)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* 4335 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fanotify_init, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fanotify_mark, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_prlimit64, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_name_to_handle_<wbr>at, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_open_by_handle_<wbr>at, 3) /* 434=
0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_adjtime, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_syncfs, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sendmmsg, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_setns, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_process_vm_readv, 6) /* 345 */<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_process_vm_<wbr>writev, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_kcmp, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_finit_module, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_setattr, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_getattr, 3)=C2=A0 /* 350 */=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_renameat2, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_seccomp, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_getrandom, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_memfd_create, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_bpf, 3)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* 355 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_execveat, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_userfaultfd, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_membarrier, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mlock2, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_copy_file_range, 6) /* 360 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_preadv2, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pwritev2, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pkey_mprotect, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pkey_alloc, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pkey_free, 1)=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 365 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_statx, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rseq, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_pgetevents, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 370 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 375 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 380 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 385 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 390 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_semget, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_semctl, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_shmget, 3)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 395 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_shmctl, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_shmat, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_shmdt, 1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_msgget, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_msgsnd, 4)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 400 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_msgrcv, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_msgctl, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_gettime64, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_settime64, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_adjtime64, 2)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 405 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_getres_<wbr>time64, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clock_nanosleep_<wbr>time64, 4)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timer_gettime64, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timer_settime64, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timerfd_<wbr>gettime64, 2)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 410 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_timerfd_<wbr>settime64, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_utimensat_time64, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pselect6_time64, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_ppoll_time64, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYSCALL_NUMBER_UNUSED,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 415 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_pgetevents_<wbr>time64, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_recvmmsg_time64, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mq_timedsend_<wbr>time64, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_mq_timedreceive_<wbr>time64, 5)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_semtimedop_<wbr>time64, 4)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 420 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rt_sigtimedwait_<wbr>time64, 4)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_futex_time64, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_sched_rr_get_<wbr>interval_time64=
, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pidfd_send_<wbr>signal, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_uring_setup, 2)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 425 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_uring_enter, 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_uring_<wbr>register, 4)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_open_tree, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_move_mount, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fsopen, 2)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 430 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fsconfig, 5)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fsmount, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_fspick, 3)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pidfd_open, 2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_clone3, 2)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 435 */<br>
-#=C2=A0 undef MIPS_SYS<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A00] =3D 7, /* syscall */<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A01] =3D 1, /* exit */<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A02] =3D 0, /* fork */<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A03] =3D 3, /* read */<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A04] =3D 3, /* write */<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A05] =3D 3, /* open */<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A06] =3D 1, /* close */<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A07] =3D 3, /* waitpid */<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A08] =3D 2, /* creat */<br>
+=C2=A0 =C2=A0 [=C2=A0 =C2=A09] =3D 2, /* link */<br>
+=C2=A0 =C2=A0 [=C2=A0 10] =3D 1, /* unlink */<br>
+=C2=A0 =C2=A0 [=C2=A0 11] =3D 3, /* execve */<br>
+=C2=A0 =C2=A0 [=C2=A0 12] =3D 1, /* chdir */<br>
+=C2=A0 =C2=A0 [=C2=A0 13] =3D 1, /* time */<br>
+=C2=A0 =C2=A0 [=C2=A0 14] =3D 3, /* mknod */<br>
+=C2=A0 =C2=A0 [=C2=A0 15] =3D 2, /* chmod */<br>
+=C2=A0 =C2=A0 [=C2=A0 16] =3D 3, /* lchown */<br>
+=C2=A0 =C2=A0 [=C2=A0 17] =3D 0, /* break */<br>
+=C2=A0 =C2=A0 [=C2=A0 18] =3D 2, /* oldstat */<br>
+=C2=A0 =C2=A0 [=C2=A0 19] =3D 3, /* lseek */<br>
+=C2=A0 =C2=A0 [=C2=A0 20] =3D 0, /* getpid */<br>
+=C2=A0 =C2=A0 [=C2=A0 21] =3D 5, /* mount */<br>
+=C2=A0 =C2=A0 [=C2=A0 22] =3D 1, /* umount */<br>
+=C2=A0 =C2=A0 [=C2=A0 23] =3D 1, /* setuid */<br>
+=C2=A0 =C2=A0 [=C2=A0 24] =3D 0, /* getuid */<br>
+=C2=A0 =C2=A0 [=C2=A0 25] =3D 1, /* stime */<br>
+=C2=A0 =C2=A0 [=C2=A0 26] =3D 4, /* ptrace */<br>
+=C2=A0 =C2=A0 [=C2=A0 27] =3D 1, /* alarm */<br>
+=C2=A0 =C2=A0 [=C2=A0 28] =3D 2, /* oldfstat */<br>
+=C2=A0 =C2=A0 [=C2=A0 29] =3D 0, /* pause */<br>
+=C2=A0 =C2=A0 [=C2=A0 30] =3D 2, /* utime */<br>
+=C2=A0 =C2=A0 [=C2=A0 31] =3D 0, /* stty */<br>
+=C2=A0 =C2=A0 [=C2=A0 32] =3D 0, /* gtty */<br>
+=C2=A0 =C2=A0 [=C2=A0 33] =3D 2, /* access */<br>
+=C2=A0 =C2=A0 [=C2=A0 34] =3D 1, /* nice */<br>
+=C2=A0 =C2=A0 [=C2=A0 35] =3D 1, /* ftime */<br>
+=C2=A0 =C2=A0 [=C2=A0 36] =3D 0, /* sync */<br>
+=C2=A0 =C2=A0 [=C2=A0 37] =3D 2, /* kill */<br>
+=C2=A0 =C2=A0 [=C2=A0 38] =3D 2, /* rename */<br>
+=C2=A0 =C2=A0 [=C2=A0 39] =3D 2, /* mkdir */<br>
+=C2=A0 =C2=A0 [=C2=A0 40] =3D 1, /* rmdir */<br>
+=C2=A0 =C2=A0 [=C2=A0 41] =3D 1, /* dup */<br>
+=C2=A0 =C2=A0 [=C2=A0 42] =3D 0, /* pipe */<br>
+=C2=A0 =C2=A0 [=C2=A0 43] =3D 1, /* times */<br>
+=C2=A0 =C2=A0 [=C2=A0 44] =3D 0, /* prof */<br>
+=C2=A0 =C2=A0 [=C2=A0 45] =3D 1, /* brk */<br>
+=C2=A0 =C2=A0 [=C2=A0 46] =3D 1, /* setgid */<br>
+=C2=A0 =C2=A0 [=C2=A0 47] =3D 0, /* getgid */<br>
+=C2=A0 =C2=A0 [=C2=A0 48] =3D 2, /* signal */<br>
+=C2=A0 =C2=A0 [=C2=A0 49] =3D 0, /* geteuid */<br>
+=C2=A0 =C2=A0 [=C2=A0 50] =3D 0, /* getegid */<br>
+=C2=A0 =C2=A0 [=C2=A0 51] =3D 1, /* acct */<br>
+=C2=A0 =C2=A0 [=C2=A0 52] =3D 2, /* umount2 */<br>
+=C2=A0 =C2=A0 [=C2=A0 53] =3D 0, /* lock */<br>
+=C2=A0 =C2=A0 [=C2=A0 54] =3D 3, /* ioctl */<br>
+=C2=A0 =C2=A0 [=C2=A0 55] =3D 3, /* fcntl */<br>
+=C2=A0 =C2=A0 [=C2=A0 56] =3D 0, /* mpx */<br>
+=C2=A0 =C2=A0 [=C2=A0 57] =3D 2, /* setpgid */<br>
+=C2=A0 =C2=A0 [=C2=A0 58] =3D 0, /* ulimit */<br>
+=C2=A0 =C2=A0 [=C2=A0 59] =3D 1, /* oldolduname */<br>
+=C2=A0 =C2=A0 [=C2=A0 60] =3D 1, /* umask */<br>
+=C2=A0 =C2=A0 [=C2=A0 61] =3D 1, /* chroot */<br>
+=C2=A0 =C2=A0 [=C2=A0 62] =3D 2, /* ustat */<br>
+=C2=A0 =C2=A0 [=C2=A0 63] =3D 2, /* dup2 */<br>
+=C2=A0 =C2=A0 [=C2=A0 64] =3D 0, /* getppid */<br>
+=C2=A0 =C2=A0 [=C2=A0 65] =3D 0, /* getpgrp */<br>
+=C2=A0 =C2=A0 [=C2=A0 66] =3D 0, /* setsid */<br>
+=C2=A0 =C2=A0 [=C2=A0 67] =3D 3, /* sigaction */<br>
+=C2=A0 =C2=A0 [=C2=A0 68] =3D 0, /* sgetmask */<br>
+=C2=A0 =C2=A0 [=C2=A0 69] =3D 1, /* ssetmask */<br>
+=C2=A0 =C2=A0 [=C2=A0 70] =3D 2, /* setreuid */<br>
+=C2=A0 =C2=A0 [=C2=A0 71] =3D 2, /* setregid */<br>
+=C2=A0 =C2=A0 [=C2=A0 72] =3D 1, /* sigsuspend */<br>
+=C2=A0 =C2=A0 [=C2=A0 73] =3D 1, /* sigpending */<br>
+=C2=A0 =C2=A0 [=C2=A0 74] =3D 2, /* sethostname */<br>
+=C2=A0 =C2=A0 [=C2=A0 75] =3D 2, /* setrlimit */<br>
+=C2=A0 =C2=A0 [=C2=A0 76] =3D 2, /* getrlimit */<br>
+=C2=A0 =C2=A0 [=C2=A0 77] =3D 2, /* getrusage */<br>
+=C2=A0 =C2=A0 [=C2=A0 78] =3D 2, /* gettimeofday */<br>
+=C2=A0 =C2=A0 [=C2=A0 79] =3D 2, /* settimeofday */<br>
+=C2=A0 =C2=A0 [=C2=A0 80] =3D 2, /* getgroups */<br>
+=C2=A0 =C2=A0 [=C2=A0 81] =3D 2, /* setgroups */<br>
+=C2=A0 =C2=A0 [=C2=A0 82] =3D 0, /* reserved82 */<br>
+=C2=A0 =C2=A0 [=C2=A0 83] =3D 2, /* symlink */<br>
+=C2=A0 =C2=A0 [=C2=A0 84] =3D 2, /* oldlstat */<br>
+=C2=A0 =C2=A0 [=C2=A0 85] =3D 3, /* readlink */<br>
+=C2=A0 =C2=A0 [=C2=A0 86] =3D 1, /* uselib */<br>
+=C2=A0 =C2=A0 [=C2=A0 87] =3D 2, /* swapon */<br>
+=C2=A0 =C2=A0 [=C2=A0 88] =3D 4, /* reboot */<br>
+=C2=A0 =C2=A0 [=C2=A0 89] =3D 3, /* readdir */<br>
+=C2=A0 =C2=A0 [=C2=A0 90] =3D 6, /* mmap */<br>
+=C2=A0 =C2=A0 [=C2=A0 91] =3D 2, /* munmap */<br>
+=C2=A0 =C2=A0 [=C2=A0 92] =3D 2, /* truncate */<br>
+=C2=A0 =C2=A0 [=C2=A0 93] =3D 2, /* ftruncate */<br>
+=C2=A0 =C2=A0 [=C2=A0 94] =3D 2, /* fchmod */<br>
+=C2=A0 =C2=A0 [=C2=A0 95] =3D 3, /* fchown */<br>
+=C2=A0 =C2=A0 [=C2=A0 96] =3D 2, /* getpriority */<br>
+=C2=A0 =C2=A0 [=C2=A0 97] =3D 3, /* setpriority */<br>
+=C2=A0 =C2=A0 [=C2=A0 98] =3D 0, /* profil */<br>
+=C2=A0 =C2=A0 [=C2=A0 99] =3D 2, /* statfs */<br>
+=C2=A0 =C2=A0 [ 100] =3D 2, /* fstatfs */<br>
+=C2=A0 =C2=A0 [ 101] =3D 3, /* ioperm */<br>
+=C2=A0 =C2=A0 [ 102] =3D 2, /* socketcall */<br>
+=C2=A0 =C2=A0 [ 103] =3D 3, /* syslog */<br>
+=C2=A0 =C2=A0 [ 104] =3D 3, /* setitimer */<br>
+=C2=A0 =C2=A0 [ 105] =3D 2, /* getitimer */<br>
+=C2=A0 =C2=A0 [ 106] =3D 2, /* stat */<br>
+=C2=A0 =C2=A0 [ 107] =3D 2, /* lstat */<br>
+=C2=A0 =C2=A0 [ 108] =3D 2, /* fstat */<br>
+=C2=A0 =C2=A0 [ 109] =3D 1, /* olduname */<br>
+=C2=A0 =C2=A0 [ 110] =3D 1, /* iopl */<br>
+=C2=A0 =C2=A0 [ 111] =3D 0, /* vhangup */<br>
+=C2=A0 =C2=A0 [ 112] =3D 0, /* idle */<br>
+=C2=A0 =C2=A0 [ 113] =3D 5, /* vm86 */<br>
+=C2=A0 =C2=A0 [ 114] =3D 4, /* wait4 */<br>
+=C2=A0 =C2=A0 [ 115] =3D 1, /* swapoff */<br>
+=C2=A0 =C2=A0 [ 116] =3D 1, /* sysinfo */<br>
+=C2=A0 =C2=A0 [ 117] =3D 6, /* ipc */<br>
+=C2=A0 =C2=A0 [ 118] =3D 1, /* fsync */<br>
+=C2=A0 =C2=A0 [ 119] =3D 0, /* sigreturn */<br>
+=C2=A0 =C2=A0 [ 120] =3D 5, /* clone */<br>
+=C2=A0 =C2=A0 [ 121] =3D 2, /* setdomainname */<br>
+=C2=A0 =C2=A0 [ 122] =3D 1, /* uname */<br>
+=C2=A0 =C2=A0 [ 123] =3D 0, /* modify_ldt */<br>
+=C2=A0 =C2=A0 [ 124] =3D 1, /* adjtimex */<br>
+=C2=A0 =C2=A0 [ 125] =3D 3, /* mprotect */<br>
+=C2=A0 =C2=A0 [ 126] =3D 3, /* sigprocmask */<br>
+=C2=A0 =C2=A0 [ 127] =3D 2, /* create_module */<br>
+=C2=A0 =C2=A0 [ 128] =3D 3, /* init_module */<br>
+=C2=A0 =C2=A0 [ 129] =3D 2, /* delete_module */<br>
+=C2=A0 =C2=A0 [ 130] =3D 1, /* get_kernel_syms */<br>
+=C2=A0 =C2=A0 [ 131] =3D 4, /* quotactl */<br>
+=C2=A0 =C2=A0 [ 132] =3D 1, /* getpgid */<br>
+=C2=A0 =C2=A0 [ 133] =3D 1, /* fchdir */<br>
+=C2=A0 =C2=A0 [ 134] =3D 2, /* bdflush */<br>
+=C2=A0 =C2=A0 [ 135] =3D 3, /* sysfs */<br>
+=C2=A0 =C2=A0 [ 136] =3D 1, /* personality */<br>
+=C2=A0 =C2=A0 [ 137] =3D 0, /* afs_syscall */<br>
+=C2=A0 =C2=A0 [ 138] =3D 1, /* setfsuid */<br>
+=C2=A0 =C2=A0 [ 139] =3D 1, /* setfsgid */<br>
+=C2=A0 =C2=A0 [ 140] =3D 5, /* _llseek */<br>
+=C2=A0 =C2=A0 [ 141] =3D 3, /* getdents */<br>
+=C2=A0 =C2=A0 [ 142] =3D 5, /* _newselect */<br>
+=C2=A0 =C2=A0 [ 143] =3D 2, /* flock */<br>
+=C2=A0 =C2=A0 [ 144] =3D 3, /* msync */<br>
+=C2=A0 =C2=A0 [ 145] =3D 3, /* readv */<br>
+=C2=A0 =C2=A0 [ 146] =3D 3, /* writev */<br>
+=C2=A0 =C2=A0 [ 147] =3D 3, /* cacheflush */<br>
+=C2=A0 =C2=A0 [ 148] =3D 3, /* cachectl */<br>
+=C2=A0 =C2=A0 [ 149] =3D 4, /* sysmips */<br>
+=C2=A0 =C2=A0 [ 150] =3D 0, /* setup */<br>
+=C2=A0 =C2=A0 [ 151] =3D 1, /* getsid */<br>
+=C2=A0 =C2=A0 [ 152] =3D 1, /* fdatasync */<br>
+=C2=A0 =C2=A0 [ 153] =3D 1, /* _sysctl */<br>
+=C2=A0 =C2=A0 [ 154] =3D 2, /* mlock */<br>
+=C2=A0 =C2=A0 [ 155] =3D 2, /* munlock */<br>
+=C2=A0 =C2=A0 [ 156] =3D 1, /* mlockall */<br>
+=C2=A0 =C2=A0 [ 157] =3D 0, /* munlockall */<br>
+=C2=A0 =C2=A0 [ 158] =3D 2, /* sched_setparam */<br>
+=C2=A0 =C2=A0 [ 159] =3D 2, /* sched_getparam */<br>
+=C2=A0 =C2=A0 [ 160] =3D 3, /* sched_setscheduler */<br>
+=C2=A0 =C2=A0 [ 161] =3D 1, /* sched_getscheduler */<br>
+=C2=A0 =C2=A0 [ 162] =3D 0, /* sched_yield */<br>
+=C2=A0 =C2=A0 [ 163] =3D 1, /* sched_get_priority_max */<br>
+=C2=A0 =C2=A0 [ 164] =3D 1, /* sched_get_priority_min */<br>
+=C2=A0 =C2=A0 [ 165] =3D 2, /* sched_rr_get_interval */<br>
+=C2=A0 =C2=A0 [ 166] =3D 2, /* nanosleep */<br>
+=C2=A0 =C2=A0 [ 167] =3D 5, /* mremap */<br>
+=C2=A0 =C2=A0 [ 168] =3D 3, /* accept */<br>
+=C2=A0 =C2=A0 [ 169] =3D 3, /* bind */<br>
+=C2=A0 =C2=A0 [ 170] =3D 3, /* connect */<br>
+=C2=A0 =C2=A0 [ 171] =3D 3, /* getpeername */<br>
+=C2=A0 =C2=A0 [ 172] =3D 3, /* getsockname */<br>
+=C2=A0 =C2=A0 [ 173] =3D 5, /* getsockopt */<br>
+=C2=A0 =C2=A0 [ 174] =3D 2, /* listen */<br>
+=C2=A0 =C2=A0 [ 175] =3D 4, /* recv */<br>
+=C2=A0 =C2=A0 [ 176] =3D 6, /* recvfrom */<br>
+=C2=A0 =C2=A0 [ 177] =3D 3, /* recvmsg */<br>
+=C2=A0 =C2=A0 [ 178] =3D 4, /* send */<br>
+=C2=A0 =C2=A0 [ 179] =3D 3, /* sendmsg */<br>
+=C2=A0 =C2=A0 [ 180] =3D 6, /* sendto */<br>
+=C2=A0 =C2=A0 [ 181] =3D 5, /* setsockopt */<br>
+=C2=A0 =C2=A0 [ 182] =3D 2, /* shutdown */<br>
+=C2=A0 =C2=A0 [ 183] =3D 3, /* socket */<br>
+=C2=A0 =C2=A0 [ 184] =3D 4, /* socketpair */<br>
+=C2=A0 =C2=A0 [ 185] =3D 3, /* setresuid */<br>
+=C2=A0 =C2=A0 [ 186] =3D 3, /* getresuid */<br>
+=C2=A0 =C2=A0 [ 187] =3D 5, /* query_module */<br>
+=C2=A0 =C2=A0 [ 188] =3D 3, /* poll */<br>
+=C2=A0 =C2=A0 [ 189] =3D 3, /* nfsservctl */<br>
+=C2=A0 =C2=A0 [ 190] =3D 3, /* setresgid */<br>
+=C2=A0 =C2=A0 [ 191] =3D 3, /* getresgid */<br>
+=C2=A0 =C2=A0 [ 192] =3D 5, /* prctl */<br>
+=C2=A0 =C2=A0 [ 193] =3D 0, /* rt_sigreturn */<br>
+=C2=A0 =C2=A0 [ 194] =3D 4, /* rt_sigaction */<br>
+=C2=A0 =C2=A0 [ 195] =3D 4, /* rt_sigprocmask */<br>
+=C2=A0 =C2=A0 [ 196] =3D 2, /* rt_sigpending */<br>
+=C2=A0 =C2=A0 [ 197] =3D 4, /* rt_sigtimedwait */<br>
+=C2=A0 =C2=A0 [ 198] =3D 3, /* rt_sigqueueinfo */<br>
+=C2=A0 =C2=A0 [ 199] =3D 2, /* rt_sigsuspend */<br>
+=C2=A0 =C2=A0 [ 200] =3D 6, /* pread64 */<br>
+=C2=A0 =C2=A0 [ 201] =3D 6, /* pwrite64 */<br>
+=C2=A0 =C2=A0 [ 202] =3D 3, /* chown */<br>
+=C2=A0 =C2=A0 [ 203] =3D 2, /* getcwd */<br>
+=C2=A0 =C2=A0 [ 204] =3D 2, /* capget */<br>
+=C2=A0 =C2=A0 [ 205] =3D 2, /* capset */<br>
+=C2=A0 =C2=A0 [ 206] =3D 2, /* sigaltstack */<br>
+=C2=A0 =C2=A0 [ 207] =3D 4, /* sendfile */<br>
+=C2=A0 =C2=A0 [ 208] =3D 5, /* getpmsg */<br>
+=C2=A0 =C2=A0 [ 209] =3D 5, /* putpmsg */<br>
+=C2=A0 =C2=A0 [ 210] =3D 6, /* mmap2 */<br>
+=C2=A0 =C2=A0 [ 211] =3D 4, /* truncate64 */<br>
+=C2=A0 =C2=A0 [ 212] =3D 4, /* ftruncate64 */<br>
+=C2=A0 =C2=A0 [ 213] =3D 2, /* stat64 */<br>
+=C2=A0 =C2=A0 [ 214] =3D 2, /* lstat64 */<br>
+=C2=A0 =C2=A0 [ 215] =3D 2, /* fstat64 */<br>
+=C2=A0 =C2=A0 [ 216] =3D 2, /* pivot_root */<br>
+=C2=A0 =C2=A0 [ 217] =3D 3, /* mincore */<br>
+=C2=A0 =C2=A0 [ 218] =3D 3, /* madvise */<br>
+=C2=A0 =C2=A0 [ 219] =3D 3, /* getdents64 */<br>
+=C2=A0 =C2=A0 [ 220] =3D 3, /* fcntl64 */<br>
+=C2=A0 =C2=A0 [ 221] =3D 0, /* reserved221 */<br>
+=C2=A0 =C2=A0 [ 222] =3D 0, /* gettid */<br>
+=C2=A0 =C2=A0 [ 223] =3D 5, /* readahead */<br>
+=C2=A0 =C2=A0 [ 224] =3D 5, /* setxattr */<br>
+=C2=A0 =C2=A0 [ 225] =3D 5, /* lsetxattr */<br>
+=C2=A0 =C2=A0 [ 226] =3D 5, /* fsetxattr */<br>
+=C2=A0 =C2=A0 [ 227] =3D 4, /* getxattr */<br>
+=C2=A0 =C2=A0 [ 228] =3D 4, /* lgetxattr */<br>
+=C2=A0 =C2=A0 [ 229] =3D 4, /* fgetxattr */<br>
+=C2=A0 =C2=A0 [ 230] =3D 3, /* listxattr */<br>
+=C2=A0 =C2=A0 [ 231] =3D 3, /* llistxattr */<br>
+=C2=A0 =C2=A0 [ 232] =3D 3, /* flistxattr */<br>
+=C2=A0 =C2=A0 [ 233] =3D 2, /* removexattr */<br>
+=C2=A0 =C2=A0 [ 234] =3D 2, /* lremovexattr */<br>
+=C2=A0 =C2=A0 [ 235] =3D 2, /* fremovexattr */<br>
+=C2=A0 =C2=A0 [ 236] =3D 2, /* tkill */<br>
+=C2=A0 =C2=A0 [ 237] =3D 4, /* sendfile64 */<br>
+=C2=A0 =C2=A0 [ 238] =3D 6, /* futex */<br>
+=C2=A0 =C2=A0 [ 239] =3D 3, /* sched_setaffinity */<br>
+=C2=A0 =C2=A0 [ 240] =3D 3, /* sched_getaffinity */<br>
+=C2=A0 =C2=A0 [ 241] =3D 2, /* io_setup */<br>
+=C2=A0 =C2=A0 [ 242] =3D 1, /* io_destroy */<br>
+=C2=A0 =C2=A0 [ 243] =3D 5, /* io_getevents */<br>
+=C2=A0 =C2=A0 [ 244] =3D 3, /* io_submit */<br>
+=C2=A0 =C2=A0 [ 245] =3D 3, /* io_cancel */<br>
+=C2=A0 =C2=A0 [ 246] =3D 1, /* exit_group */<br>
+=C2=A0 =C2=A0 [ 247] =3D 4, /* lookup_dcookie */<br>
+=C2=A0 =C2=A0 [ 248] =3D 1, /* epoll_create */<br>
+=C2=A0 =C2=A0 [ 249] =3D 4, /* epoll_ctl */<br>
+=C2=A0 =C2=A0 [ 250] =3D 4, /* epoll_wait */<br>
+=C2=A0 =C2=A0 [ 251] =3D 5, /* remap_file_pages */<br>
+=C2=A0 =C2=A0 [ 252] =3D 1, /* set_tid_address */<br>
+=C2=A0 =C2=A0 [ 253] =3D 0, /* restart_syscall */<br>
+=C2=A0 =C2=A0 [ 254] =3D 7, /* fadvise64 */<br>
+=C2=A0 =C2=A0 [ 255] =3D 3, /* statfs64 */<br>
+=C2=A0 =C2=A0 [ 256] =3D 3, /* fstatfs64 */<br>
+=C2=A0 =C2=A0 [ 257] =3D 3, /* timer_create */<br>
+=C2=A0 =C2=A0 [ 258] =3D 4, /* timer_settime */<br>
+=C2=A0 =C2=A0 [ 259] =3D 2, /* timer_gettime */<br>
+=C2=A0 =C2=A0 [ 260] =3D 1, /* timer_getoverrun */<br>
+=C2=A0 =C2=A0 [ 261] =3D 1, /* timer_delete */<br>
+=C2=A0 =C2=A0 [ 262] =3D 2, /* clock_settime */<br>
+=C2=A0 =C2=A0 [ 263] =3D 2, /* clock_gettime */<br>
+=C2=A0 =C2=A0 [ 264] =3D 2, /* clock_getres */<br>
+=C2=A0 =C2=A0 [ 265] =3D 4, /* clock_nanosleep */<br>
+=C2=A0 =C2=A0 [ 266] =3D 3, /* tgkill */<br>
+=C2=A0 =C2=A0 [ 267] =3D 2, /* utimes */<br>
+=C2=A0 =C2=A0 [ 268] =3D 6, /* mbind */<br>
+=C2=A0 =C2=A0 [ 269] =3D 5, /* get_mempolicy */<br>
+=C2=A0 =C2=A0 [ 270] =3D 3, /* set_mempolicy */<br>
+=C2=A0 =C2=A0 [ 271] =3D 4, /* mq_open */<br>
+=C2=A0 =C2=A0 [ 272] =3D 1, /* mq_unlink */<br>
+=C2=A0 =C2=A0 [ 273] =3D 5, /* mq_timedsend */<br>
+=C2=A0 =C2=A0 [ 274] =3D 5, /* mq_timedreceive */<br>
+=C2=A0 =C2=A0 [ 275] =3D 2, /* mq_notify */<br>
+=C2=A0 =C2=A0 [ 276] =3D 3, /* mq_getsetattr */<br>
+=C2=A0 =C2=A0 [ 277] =3D 5, /* vserver */<br>
+=C2=A0 =C2=A0 [ 278] =3D 5, /* waitid */<br>
+=C2=A0 =C2=A0 [ 279] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 280] =3D 5, /* add_key */<br>
+=C2=A0 =C2=A0 [ 281] =3D 4, /* request_key */<br>
+=C2=A0 =C2=A0 [ 282] =3D 5, /* keyctl */<br>
+=C2=A0 =C2=A0 [ 283] =3D 1, /* set_thread_area */<br>
+=C2=A0 =C2=A0 [ 284] =3D 0, /* inotify_init */<br>
+=C2=A0 =C2=A0 [ 285] =3D 3, /* inotify_add_watch */<br>
+=C2=A0 =C2=A0 [ 286] =3D 2, /* inotify_rm_watch */<br>
+=C2=A0 =C2=A0 [ 287] =3D 4, /* migrate_pages */<br>
+=C2=A0 =C2=A0 [ 288] =3D 4, /* openat */<br>
+=C2=A0 =C2=A0 [ 289] =3D 3, /* mkdirat */<br>
+=C2=A0 =C2=A0 [ 290] =3D 4, /* mknodat */<br>
+=C2=A0 =C2=A0 [ 291] =3D 5, /* fchownat */<br>
+=C2=A0 =C2=A0 [ 292] =3D 3, /* futimesat */<br>
+=C2=A0 =C2=A0 [ 293] =3D 4, /* fstatat64 */<br>
+=C2=A0 =C2=A0 [ 294] =3D 3, /* unlinkat */<br>
+=C2=A0 =C2=A0 [ 295] =3D 4, /* renameat */<br>
+=C2=A0 =C2=A0 [ 296] =3D 5, /* linkat */<br>
+=C2=A0 =C2=A0 [ 297] =3D 3, /* symlinkat */<br>
+=C2=A0 =C2=A0 [ 298] =3D 4, /* readlinkat */<br>
+=C2=A0 =C2=A0 [ 299] =3D 3, /* fchmodat */<br>
+=C2=A0 =C2=A0 [ 300] =3D 3, /* faccessat */<br>
+=C2=A0 =C2=A0 [ 301] =3D 6, /* pselect6 */<br>
+=C2=A0 =C2=A0 [ 302] =3D 5, /* ppoll */<br>
+=C2=A0 =C2=A0 [ 303] =3D 1, /* unshare */<br>
+=C2=A0 =C2=A0 [ 304] =3D 6, /* splice */<br>
+=C2=A0 =C2=A0 [ 305] =3D 7, /* sync_file_range */<br>
+=C2=A0 =C2=A0 [ 306] =3D 4, /* tee */<br>
+=C2=A0 =C2=A0 [ 307] =3D 4, /* vmsplice */<br>
+=C2=A0 =C2=A0 [ 308] =3D 6, /* move_pages */<br>
+=C2=A0 =C2=A0 [ 309] =3D 2, /* set_robust_list */<br>
+=C2=A0 =C2=A0 [ 310] =3D 3, /* get_robust_list */<br>
+=C2=A0 =C2=A0 [ 311] =3D 4, /* kexec_load */<br>
+=C2=A0 =C2=A0 [ 312] =3D 3, /* getcpu */<br>
+=C2=A0 =C2=A0 [ 313] =3D 6, /* epoll_pwait */<br>
+=C2=A0 =C2=A0 [ 314] =3D 3, /* ioprio_set */<br>
+=C2=A0 =C2=A0 [ 315] =3D 2, /* ioprio_get */<br>
+=C2=A0 =C2=A0 [ 316] =3D 4, /* utimensat */<br>
+=C2=A0 =C2=A0 [ 317] =3D 3, /* signalfd */<br>
+=C2=A0 =C2=A0 [ 318] =3D 4, /* timerfd */<br>
+=C2=A0 =C2=A0 [ 319] =3D 1, /* eventfd */<br>
+=C2=A0 =C2=A0 [ 320] =3D 6, /* fallocate */<br>
+=C2=A0 =C2=A0 [ 321] =3D 2, /* timerfd_create */<br>
+=C2=A0 =C2=A0 [ 322] =3D 2, /* timerfd_gettime */<br>
+=C2=A0 =C2=A0 [ 323] =3D 4, /* timerfd_settime */<br>
+=C2=A0 =C2=A0 [ 324] =3D 4, /* signalfd4 */<br>
+=C2=A0 =C2=A0 [ 325] =3D 2, /* eventfd2 */<br>
+=C2=A0 =C2=A0 [ 326] =3D 1, /* epoll_create1 */<br>
+=C2=A0 =C2=A0 [ 327] =3D 3, /* dup3 */<br>
+=C2=A0 =C2=A0 [ 328] =3D 2, /* pipe2 */<br>
+=C2=A0 =C2=A0 [ 329] =3D 1, /* inotify_init1 */<br>
+=C2=A0 =C2=A0 [ 330] =3D 5, /* preadv */<br>
+=C2=A0 =C2=A0 [ 331] =3D 5, /* pwritev */<br>
+=C2=A0 =C2=A0 [ 332] =3D 4, /* rt_tgsigqueueinfo */<br>
+=C2=A0 =C2=A0 [ 333] =3D 5, /* perf_event_open */<br>
+=C2=A0 =C2=A0 [ 334] =3D 4, /* accept4 */<br>
+=C2=A0 =C2=A0 [ 335] =3D 5, /* recvmmsg */<br>
+=C2=A0 =C2=A0 [ 336] =3D 2, /* fanotify_init */<br>
+=C2=A0 =C2=A0 [ 337] =3D 6, /* fanotify_mark */<br>
+=C2=A0 =C2=A0 [ 338] =3D 4, /* prlimit64 */<br>
+=C2=A0 =C2=A0 [ 339] =3D 5, /* name_to_handle_at */<br>
+=C2=A0 =C2=A0 [ 340] =3D 3, /* open_by_handle_at */<br>
+=C2=A0 =C2=A0 [ 341] =3D 2, /* clock_adjtime */<br>
+=C2=A0 =C2=A0 [ 342] =3D 1, /* syncfs */<br>
+=C2=A0 =C2=A0 [ 343] =3D 4, /* sendmmsg */<br>
+=C2=A0 =C2=A0 [ 344] =3D 2, /* setns */<br>
+=C2=A0 =C2=A0 [ 345] =3D 6, /* process_vm_readv */<br>
+=C2=A0 =C2=A0 [ 346] =3D 6, /* process_vm_writev */<br>
+=C2=A0 =C2=A0 [ 347] =3D 5, /* kcmp */<br>
+=C2=A0 =C2=A0 [ 348] =3D 3, /* finit_module */<br>
+=C2=A0 =C2=A0 [ 349] =3D 3, /* sched_setattr */<br>
+=C2=A0 =C2=A0 [ 350] =3D 4, /* sched_getattr */<br>
+=C2=A0 =C2=A0 [ 351] =3D 5, /* renameat2 */<br>
+=C2=A0 =C2=A0 [ 352] =3D 3, /* seccomp */<br>
+=C2=A0 =C2=A0 [ 353] =3D 3, /* getrandom */<br>
+=C2=A0 =C2=A0 [ 354] =3D 2, /* memfd_create */<br>
+=C2=A0 =C2=A0 [ 355] =3D 3, /* bpf */<br>
+=C2=A0 =C2=A0 [ 356] =3D 5, /* execveat */<br>
+=C2=A0 =C2=A0 [ 357] =3D 1, /* userfaultfd */<br>
+=C2=A0 =C2=A0 [ 358] =3D 2, /* membarrier */<br>
+=C2=A0 =C2=A0 [ 359] =3D 3, /* mlock2 */<br>
+=C2=A0 =C2=A0 [ 360] =3D 6, /* copy_file_range */<br>
+=C2=A0 =C2=A0 [ 361] =3D 6, /* preadv2 */<br>
+=C2=A0 =C2=A0 [ 362] =3D 6, /* pwritev2 */<br>
+=C2=A0 =C2=A0 [ 363] =3D 4, /* pkey_mprotect */<br>
+=C2=A0 =C2=A0 [ 364] =3D 2, /* pkey_alloc */<br>
+=C2=A0 =C2=A0 [ 365] =3D 1, /* pkey_free */<br>
+=C2=A0 =C2=A0 [ 366] =3D 5, /* statx */<br>
+=C2=A0 =C2=A0 [ 367] =3D 4, /* rseq */<br>
+=C2=A0 =C2=A0 [ 368] =3D 6, /* io_pgetevents */<br>
+=C2=A0 =C2=A0 [ 369] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 370] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 371] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 372] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 373] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 374] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 375] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 376] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 377] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 378] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 379] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 380] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 381] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 382] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 383] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 384] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 385] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 386] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 387] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 388] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 389] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 390] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 391] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 392] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 393] =3D 3, /* semget */<br>
+=C2=A0 =C2=A0 [ 394] =3D 4, /* semctl */<br>
+=C2=A0 =C2=A0 [ 395] =3D 3, /* shmget */<br>
+=C2=A0 =C2=A0 [ 396] =3D 3, /* shmctl */<br>
+=C2=A0 =C2=A0 [ 397] =3D 3, /* shmat */<br>
+=C2=A0 =C2=A0 [ 398] =3D 1, /* shmdt */<br>
+=C2=A0 =C2=A0 [ 399] =3D 2, /* msgget */<br>
+=C2=A0 =C2=A0 [ 400] =3D 4, /* msgsnd */<br>
+=C2=A0 =C2=A0 [ 401] =3D 5, /* msgrcv */<br>
+=C2=A0 =C2=A0 [ 402] =3D 3, /* msgctl */<br>
+=C2=A0 =C2=A0 [ 403] =3D 2, /* clock_gettime64 */<br>
+=C2=A0 =C2=A0 [ 404] =3D 2, /* clock_settime64 */<br>
+=C2=A0 =C2=A0 [ 405] =3D 2, /* clock_adjtime64 */<br>
+=C2=A0 =C2=A0 [ 406] =3D 2, /* clock_getres_time64 */<br>
+=C2=A0 =C2=A0 [ 407] =3D 4, /* clock_nanosleep_time64 */<br>
+=C2=A0 =C2=A0 [ 408] =3D 2, /* timer_gettime64 */<br>
+=C2=A0 =C2=A0 [ 409] =3D 4, /* timer_settime64 */<br>
+=C2=A0 =C2=A0 [ 410] =3D 2, /* timerfd_gettime64 */<br>
+=C2=A0 =C2=A0 [ 411] =3D 4, /* timerfd_settime64 */<br>
+=C2=A0 =C2=A0 [ 412] =3D 4, /* utimensat_time64 */<br>
+=C2=A0 =C2=A0 [ 413] =3D 6, /* pselect6_time64 */<br>
+=C2=A0 =C2=A0 [ 414] =3D 5, /* ppoll_time64 */<br>
+=C2=A0 =C2=A0 [ 415] =3D MIPS_SYSCALL_NUMBER_UNUSED,<br>
+=C2=A0 =C2=A0 [ 416] =3D 6, /* io_pgetevents_time64 */<br>
+=C2=A0 =C2=A0 [ 417] =3D 5, /* recvmmsg_time64 */<br>
+=C2=A0 =C2=A0 [ 418] =3D 5, /* mq_timedsend_time64 */<br>
+=C2=A0 =C2=A0 [ 419] =3D 5, /* mq_timedreceive_time64 */<br>
+=C2=A0 =C2=A0 [ 420] =3D 4, /* semtimedop_time64 */<br>
+=C2=A0 =C2=A0 [ 421] =3D 4, /* rt_sigtimedwait_time64 */<br>
+=C2=A0 =C2=A0 [ 422] =3D 6, /* futex_time64 */<br>
+=C2=A0 =C2=A0 [ 423] =3D 2, /* sched_rr_get_interval_time64 */<br>
+=C2=A0 =C2=A0 [ 424] =3D 4, /* pidfd_send_signal */<br>
+=C2=A0 =C2=A0 [ 425] =3D 2, /* io_uring_setup */<br>
+=C2=A0 =C2=A0 [ 426] =3D 6, /* io_uring_enter */<br>
+=C2=A0 =C2=A0 [ 427] =3D 4, /* io_uring_register */<br>
+=C2=A0 =C2=A0 [ 428] =3D 3, /* open_tree */<br>
+=C2=A0 =C2=A0 [ 429] =3D 5, /* move_mount */<br>
+=C2=A0 =C2=A0 [ 430] =3D 2, /* fsopen */<br>
+=C2=A0 =C2=A0 [ 431] =3D 5, /* fsconfig */<br>
+=C2=A0 =C2=A0 [ 432] =3D 3, /* fsmount */<br>
+=C2=A0 =C2=A0 [ 433] =3D 3, /* fspick */<br>
+=C2=A0 =C2=A0 [ 434] =3D 2, /* pidfd_open */<br>
+=C2=A0 =C2=A0 [ 435] =3D 2, /* clone3 */<br>
diff --git a/scripts/update-mips-syscall-<wbr>args.sh b/scripts/update-mips=
-syscall-<wbr>args.sh<br>
new file mode 100755<br>
index 000000000000..4f0dda4b83bc<br>
--- /dev/null<br>
+++ b/scripts/update-mips-syscall-<wbr>args.sh<br>
@@ -0,0 +1,57 @@<br>
+#!/bin/sh<br>
+<br>
+URL=3D<a href=3D"https://raw.githubusercontent.com/strace/strace/master" t=
arget=3D"_blank">https://raw.<wbr>githubusercontent.com/strace/<wbr>strace/=
master</a><br>
+FILES=3D&quot;sysent.h sysent_shorthand_defs.h linux/mips/syscallent-compa=
t.h \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0linux/mips/syscallent-o32.h linux/syscallent-co=
mmon-32.h \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0linux/syscallent-common.h&quot;<br>
+<br>
+output=3D&quot;$1&quot;<br>
+if [ &quot;$output&quot; =3D &quot;&quot; ] ; then<br>
+=C2=A0 =C2=A0 output=3D&quot;$PWD&quot;<br>
+fi<br>
+<br>
+INC=3Dlinux-user/mips/syscall-<wbr>args-o32.c.inc<br>
+<br>
+TMP=3D$(mktemp -d)<br>
+cd $TMP<br>
+<br>
+for file in $FILES; do<br>
+=C2=A0 =C2=A0 curl -O $URL/$file<br>
+done<br>
+<br>
+&gt; subcall32.h<br>
+<br>
+cat &gt; gen_mips_o32.c &lt;&lt;EOF<br>
+#include &lt;stdio.h&gt;<br>
+<br>
+#define LINUX_MIPSO32<br>
+#define MAX_ARGS 7<br>
+<br>
+#include &quot;sysent.h&quot;<br>
+#include &quot;sysent_shorthand_defs.h&quot;<br>
+<br>
+#define SEN(syscall_name) 0,0<br>
+const struct_sysent sysent0[] =3D {<br>
+#include=C2=A0 &quot;syscallent-o32.h&quot;<br>
+};<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 4000; i &lt; sizeof(sysent0) / sizeof(struct_syse=
nt); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sysent0[i].sys_name =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;=C2=A0 =C2=A0 [% 4d=
] =3D MIPS_SYSCALL_NUMBER_UNUSED,\n&quot;<wbr>, i - 4000);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;=C2=A0 =C2=A0 [% 4d=
] =3D %d, /* %s */\n&quot;, i - 4000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysen=
t0[i].nargs, sysent0[i].sys_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+EOF<br>
+<br>
+cc -o gen_mips_o32 gen_mips_o32.c &amp;&amp; ./gen_mips_o32 &gt; &quot;$ou=
tput/$INC&quot;<br>
+<br>
+rm -fr &quot;$TMP&quot;<br>
-- <br>
2.24.1<br>
<br>
<br>
</blockquote>

--0000000000002fca9f059edd6cce--

