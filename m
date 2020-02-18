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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50EAC34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED99120679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYxmXz+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED99120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j476V-0001AD-0v
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j4758-00086P-P3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j474z-00005u-Pe
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:54:50 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j474z-00005H-BQ; Tue, 18 Feb 2020 12:54:41 -0500
Received: by mail-ot1-x343.google.com with SMTP id 59so20373200otp.12;
 Tue, 18 Feb 2020 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=QfwqEvnz2DCTPUzu/qGJKLRmXxWsdxcXGYAF4FZRlZ8=;
 b=QYxmXz+mhYRipPE7PGAVy3xMENzRDCbdVpKkYUdBbKpWat8WPtey0CyrQWfkouanvM
 bJjpmJGuTbEdXS/xRNdiMzMjStZIRerl9Rsn2kk/hWeCgIXhYYF3pqVM5Ga1Ij19HmK+
 voYubmqSTHjrZkiYOxD6BNT/FETQB/YQua86glOkrqXvDNyl+yx9037eAOMzLP7XW06m
 ELmhEzHbLgWBww5kp0Hr1BeaIEhp26yvFakamfOdXN852PjgqRYq+UGyJNHhRoPeJIlx
 iL+A+Cep1JKK4Vht27/VKom9kjCzsxnxioDl049xyiBOEiulhv84HXftnE+rJQSkU8Ap
 oBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=QfwqEvnz2DCTPUzu/qGJKLRmXxWsdxcXGYAF4FZRlZ8=;
 b=tYYKV1Ng/lFYXsGfodWcEjCX8bswHEc3DXyUfunzR26qhAx7ZgsLSJ6uSyU53lEBrt
 dH6otsqqf94Un2pUw0l2KNqGRSxYM94vI9PfPLoqlIwhSi2pAoyRqAfM21pWvwZgYz32
 /lHLqeBYghUEOzjNfOo9f6T6QbsjXOyylZjTXsoSyPFmSJDtQA626YSAVnOdKpMF35K7
 mIcvfO+z7QpjcMvrM661dwy+u9qxkYbFfPb/9+0k28EbpnCVvbgq4+hErF2msY+dxMGE
 xrIetQpopN5C2Y0ZGxPnvFhUC/g+jp8US7yKO+1J2EWHXGmXI/KhCh+bC9mm3f91VSWN
 TrcQ==
X-Gm-Message-State: APjAAAXPur6gIlkoeqQU/iOgFi91kuoD3FNil81hqYNZ4ILS86UoNt5F
 ul4fp82vGB2NsfrZS7c+SpL18YySr9+zaO/ZcCg=
X-Google-Smtp-Source: APXvYqy9k8DNO38tuIbyoISziSMcidsVKAt/zoHNSolKi0pataMjMID4YzRlPF+YO1/bgqQ6/HMuBlU5toODcr3ASyU=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr15675401otb.121.1582048480465; 
 Tue, 18 Feb 2020 09:54:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 09:54:40 -0800 (PST)
In-Reply-To: <20200217223558.863199-18-laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200217223558.863199-18-laurent@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 18:54:40 +0100
Message-ID: <CAL1e-=j5-vsRmt=h5yPoCAhHR3qk-UZGX_fpX_KPkPtqc0F9Zw@mail.gmail.com>
Subject: Re: [PATCH 17/22] linux-user,mips64: split syscall_nr.h
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000b21910059edd5daa"
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

--000000000000b21910059edd5daa
Content-Type: text/plain; charset="UTF-8"

On Monday, February 17, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> Split into syscall32_nr.h (n32) and syscall64_nr.h (n64)
>
> o32 interface is in mips/syscall_nr.h
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---



Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>  linux-user/mips64/syscall32_nr.h | 375 ++++++++++++++++
>  linux-user/mips64/syscall64_nr.h | 351 +++++++++++++++
>  linux-user/mips64/syscall_nr.h   | 719 +------------------------------
>  3 files changed, 728 insertions(+), 717 deletions(-)
>  create mode 100644 linux-user/mips64/syscall32_nr.h
>  create mode 100644 linux-user/mips64/syscall64_nr.h
>
> diff --git a/linux-user/mips64/syscall32_nr.h
> b/linux-user/mips64/syscall32_nr.h
> new file mode 100644
> index 000000000000..3244a543ba76
> --- /dev/null
> +++ b/linux-user/mips64/syscall32_nr.h
> @@ -0,0 +1,375 @@
> +#ifndef LINUX_USER_MIPS64_SYSCALL32_NR_H
> +#define LINUX_USER_MIPS64_SYSCALL32_NR_H
> +
> +/*
> + * Linux N32 syscalls are in the range from 6000 to 6999.
> + */
> +#define TARGET_NR_Linux                 6000
> +#define TARGET_NR_read                  (TARGET_NR_Linux +   0)
> +#define TARGET_NR_write                 (TARGET_NR_Linux +   1)
> +#define TARGET_NR_open                  (TARGET_NR_Linux +   2)
> +#define TARGET_NR_close                 (TARGET_NR_Linux +   3)
> +#define TARGET_NR_stat                  (TARGET_NR_Linux +   4)
> +#define TARGET_NR_fstat                 (TARGET_NR_Linux +   5)
> +#define TARGET_NR_lstat                 (TARGET_NR_Linux +   6)
> +#define TARGET_NR_poll                  (TARGET_NR_Linux +   7)
> +#define TARGET_NR_lseek                 (TARGET_NR_Linux +   8)
> +#define TARGET_NR_mmap                  (TARGET_NR_Linux +   9)
> +#define TARGET_NR_mprotect              (TARGET_NR_Linux +  10)
> +#define TARGET_NR_munmap                (TARGET_NR_Linux +  11)
> +#define TARGET_NR_brk                   (TARGET_NR_Linux +  12)
> +#define TARGET_NR_rt_sigaction          (TARGET_NR_Linux +  13)
> +#define TARGET_NR_rt_sigprocmask        (TARGET_NR_Linux +  14)
> +#define TARGET_NR_ioctl                 (TARGET_NR_Linux +  15)
> +#define TARGET_NR_pread64               (TARGET_NR_Linux +  16)
> +#define TARGET_NR_pwrite64              (TARGET_NR_Linux +  17)
> +#define TARGET_NR_readv                 (TARGET_NR_Linux +  18)
> +#define TARGET_NR_writev                (TARGET_NR_Linux +  19)
> +#define TARGET_NR_access                (TARGET_NR_Linux +  20)
> +#define TARGET_NR_pipe                  (TARGET_NR_Linux +  21)
> +#define TARGET_NR__newselect            (TARGET_NR_Linux +  22)
> +#define TARGET_NR_sched_yield           (TARGET_NR_Linux +  23)
> +#define TARGET_NR_mremap                (TARGET_NR_Linux +  24)
> +#define TARGET_NR_msync                 (TARGET_NR_Linux +  25)
> +#define TARGET_NR_mincore               (TARGET_NR_Linux +  26)
> +#define TARGET_NR_madvise               (TARGET_NR_Linux +  27)
> +#define TARGET_NR_shmget                (TARGET_NR_Linux +  28)
> +#define TARGET_NR_shmat                 (TARGET_NR_Linux +  29)
> +#define TARGET_NR_shmctl                (TARGET_NR_Linux +  30)
> +#define TARGET_NR_dup                   (TARGET_NR_Linux +  31)
> +#define TARGET_NR_dup2                  (TARGET_NR_Linux +  32)
> +#define TARGET_NR_pause                 (TARGET_NR_Linux +  33)
> +#define TARGET_NR_nanosleep             (TARGET_NR_Linux +  34)
> +#define TARGET_NR_getitimer             (TARGET_NR_Linux +  35)
> +#define TARGET_NR_setitimer             (TARGET_NR_Linux +  36)
> +#define TARGET_NR_alarm                 (TARGET_NR_Linux +  37)
> +#define TARGET_NR_getpid                (TARGET_NR_Linux +  38)
> +#define TARGET_NR_sendfile              (TARGET_NR_Linux +  39)
> +#define TARGET_NR_socket                (TARGET_NR_Linux +  40)
> +#define TARGET_NR_connect               (TARGET_NR_Linux +  41)
> +#define TARGET_NR_accept                (TARGET_NR_Linux +  42)
> +#define TARGET_NR_sendto                (TARGET_NR_Linux +  43)
> +#define TARGET_NR_recvfrom              (TARGET_NR_Linux +  44)
> +#define TARGET_NR_sendmsg               (TARGET_NR_Linux +  45)
> +#define TARGET_NR_recvmsg               (TARGET_NR_Linux +  46)
> +#define TARGET_NR_shutdown              (TARGET_NR_Linux +  47)
> +#define TARGET_NR_bind                  (TARGET_NR_Linux +  48)
> +#define TARGET_NR_listen                (TARGET_NR_Linux +  49)
> +#define TARGET_NR_getsockname           (TARGET_NR_Linux +  50)
> +#define TARGET_NR_getpeername           (TARGET_NR_Linux +  51)
> +#define TARGET_NR_socketpair            (TARGET_NR_Linux +  52)
> +#define TARGET_NR_setsockopt            (TARGET_NR_Linux +  53)
> +#define TARGET_NR_getsockopt            (TARGET_NR_Linux +  54)
> +#define TARGET_NR_clone                 (TARGET_NR_Linux +  55)
> +#define TARGET_NR_fork                  (TARGET_NR_Linux +  56)
> +#define TARGET_NR_execve                (TARGET_NR_Linux +  57)
> +#define TARGET_NR_exit                  (TARGET_NR_Linux +  58)
> +#define TARGET_NR_wait4                 (TARGET_NR_Linux +  59)
> +#define TARGET_NR_kill                  (TARGET_NR_Linux +  60)
> +#define TARGET_NR_uname                 (TARGET_NR_Linux +  61)
> +#define TARGET_NR_semget                (TARGET_NR_Linux +  62)
> +#define TARGET_NR_semop                 (TARGET_NR_Linux +  63)
> +#define TARGET_NR_semctl                (TARGET_NR_Linux +  64)
> +#define TARGET_NR_shmdt                 (TARGET_NR_Linux +  65)
> +#define TARGET_NR_msgget                (TARGET_NR_Linux +  66)
> +#define TARGET_NR_msgsnd                (TARGET_NR_Linux +  67)
> +#define TARGET_NR_msgrcv                (TARGET_NR_Linux +  68)
> +#define TARGET_NR_msgctl                (TARGET_NR_Linux +  69)
> +#define TARGET_NR_fcntl                 (TARGET_NR_Linux +  70)
> +#define TARGET_NR_flock                 (TARGET_NR_Linux +  71)
> +#define TARGET_NR_fsync                 (TARGET_NR_Linux +  72)
> +#define TARGET_NR_fdatasync             (TARGET_NR_Linux +  73)
> +#define TARGET_NR_truncate              (TARGET_NR_Linux +  74)
> +#define TARGET_NR_ftruncate             (TARGET_NR_Linux +  75)
> +#define TARGET_NR_getdents              (TARGET_NR_Linux +  76)
> +#define TARGET_NR_getcwd                (TARGET_NR_Linux +  77)
> +#define TARGET_NR_chdir                 (TARGET_NR_Linux +  78)
> +#define TARGET_NR_fchdir                (TARGET_NR_Linux +  79)
> +#define TARGET_NR_rename                (TARGET_NR_Linux +  80)
> +#define TARGET_NR_mkdir                 (TARGET_NR_Linux +  81)
> +#define TARGET_NR_rmdir                 (TARGET_NR_Linux +  82)
> +#define TARGET_NR_creat                 (TARGET_NR_Linux +  83)
> +#define TARGET_NR_link                  (TARGET_NR_Linux +  84)
> +#define TARGET_NR_unlink                (TARGET_NR_Linux +  85)
> +#define TARGET_NR_symlink               (TARGET_NR_Linux +  86)
> +#define TARGET_NR_readlink              (TARGET_NR_Linux +  87)
> +#define TARGET_NR_chmod                 (TARGET_NR_Linux +  88)
> +#define TARGET_NR_fchmod                (TARGET_NR_Linux +  89)
> +#define TARGET_NR_chown                 (TARGET_NR_Linux +  90)
> +#define TARGET_NR_fchown                (TARGET_NR_Linux +  91)
> +#define TARGET_NR_lchown                (TARGET_NR_Linux +  92)
> +#define TARGET_NR_umask                 (TARGET_NR_Linux +  93)
> +#define TARGET_NR_gettimeofday          (TARGET_NR_Linux +  94)
> +#define TARGET_NR_getrlimit             (TARGET_NR_Linux +  95)
> +#define TARGET_NR_getrusage             (TARGET_NR_Linux +  96)
> +#define TARGET_NR_sysinfo               (TARGET_NR_Linux +  97)
> +#define TARGET_NR_times                 (TARGET_NR_Linux +  98)
> +#define TARGET_NR_ptrace                (TARGET_NR_Linux +  99)
> +#define TARGET_NR_getuid                (TARGET_NR_Linux + 100)
> +#define TARGET_NR_syslog                (TARGET_NR_Linux + 101)
> +#define TARGET_NR_getgid                (TARGET_NR_Linux + 102)
> +#define TARGET_NR_setuid                (TARGET_NR_Linux + 103)
> +#define TARGET_NR_setgid                (TARGET_NR_Linux + 104)
> +#define TARGET_NR_geteuid               (TARGET_NR_Linux + 105)
> +#define TARGET_NR_getegid               (TARGET_NR_Linux + 106)
> +#define TARGET_NR_setpgid               (TARGET_NR_Linux + 107)
> +#define TARGET_NR_getppid               (TARGET_NR_Linux + 108)
> +#define TARGET_NR_getpgrp               (TARGET_NR_Linux + 109)
> +#define TARGET_NR_setsid                (TARGET_NR_Linux + 110)
> +#define TARGET_NR_setreuid              (TARGET_NR_Linux + 111)
> +#define TARGET_NR_setregid              (TARGET_NR_Linux + 112)
> +#define TARGET_NR_getgroups             (TARGET_NR_Linux + 113)
> +#define TARGET_NR_setgroups             (TARGET_NR_Linux + 114)
> +#define TARGET_NR_setresuid             (TARGET_NR_Linux + 115)
> +#define TARGET_NR_getresuid             (TARGET_NR_Linux + 116)
> +#define TARGET_NR_setresgid             (TARGET_NR_Linux + 117)
> +#define TARGET_NR_getresgid             (TARGET_NR_Linux + 118)
> +#define TARGET_NR_getpgid               (TARGET_NR_Linux + 119)
> +#define TARGET_NR_setfsuid              (TARGET_NR_Linux + 120)
> +#define TARGET_NR_setfsgid              (TARGET_NR_Linux + 121)
> +#define TARGET_NR_getsid                (TARGET_NR_Linux + 122)
> +#define TARGET_NR_capget                (TARGET_NR_Linux + 123)
> +#define TARGET_NR_capset                (TARGET_NR_Linux + 124)
> +#define TARGET_NR_rt_sigpending         (TARGET_NR_Linux + 125)
> +#define TARGET_NR_rt_sigtimedwait       (TARGET_NR_Linux + 126)
> +#define TARGET_NR_rt_sigqueueinfo       (TARGET_NR_Linux + 127)
> +#define TARGET_NR_rt_sigsuspend         (TARGET_NR_Linux + 128)
> +#define TARGET_NR_sigaltstack           (TARGET_NR_Linux + 129)
> +#define TARGET_NR_utime                 (TARGET_NR_Linux + 130)
> +#define TARGET_NR_mknod                 (TARGET_NR_Linux + 131)
> +#define TARGET_NR_personality           (TARGET_NR_Linux + 132)
> +#define TARGET_NR_ustat                 (TARGET_NR_Linux + 133)
> +#define TARGET_NR_statfs                (TARGET_NR_Linux + 134)
> +#define TARGET_NR_fstatfs               (TARGET_NR_Linux + 135)
> +#define TARGET_NR_sysfs                 (TARGET_NR_Linux + 136)
> +#define TARGET_NR_getpriority           (TARGET_NR_Linux + 137)
> +#define TARGET_NR_setpriority           (TARGET_NR_Linux + 138)
> +#define TARGET_NR_sched_setparam        (TARGET_NR_Linux + 139)
> +#define TARGET_NR_sched_getparam        (TARGET_NR_Linux + 140)
> +#define TARGET_NR_sched_setscheduler    (TARGET_NR_Linux + 141)
> +#define TARGET_NR_sched_getscheduler    (TARGET_NR_Linux + 142)
> +#define TARGET_NR_sched_get_priority_max        (TARGET_NR_Linux + 143)
> +#define TARGET_NR_sched_get_priority_min        (TARGET_NR_Linux + 144)
> +#define TARGET_NR_sched_rr_get_interval (TARGET_NR_Linux + 145)
> +#define TARGET_NR_mlock                 (TARGET_NR_Linux + 146)
> +#define TARGET_NR_munlock               (TARGET_NR_Linux + 147)
> +#define TARGET_NR_mlockall              (TARGET_NR_Linux + 148)
> +#define TARGET_NR_munlockall            (TARGET_NR_Linux + 149)
> +#define TARGET_NR_vhangup               (TARGET_NR_Linux + 150)
> +#define TARGET_NR_pivot_root            (TARGET_NR_Linux + 151)
> +#define TARGET_NR__sysctl               (TARGET_NR_Linux + 152)
> +#define TARGET_NR_prctl                 (TARGET_NR_Linux + 153)
> +#define TARGET_NR_adjtimex              (TARGET_NR_Linux + 154)
> +#define TARGET_NR_setrlimit             (TARGET_NR_Linux + 155)
> +#define TARGET_NR_chroot                (TARGET_NR_Linux + 156)
> +#define TARGET_NR_sync                  (TARGET_NR_Linux + 157)
> +#define TARGET_NR_acct                  (TARGET_NR_Linux + 158)
> +#define TARGET_NR_settimeofday          (TARGET_NR_Linux + 159)
> +#define TARGET_NR_mount                 (TARGET_NR_Linux + 160)
> +#define TARGET_NR_umount2               (TARGET_NR_Linux + 161)
> +#define TARGET_NR_swapon                (TARGET_NR_Linux + 162)
> +#define TARGET_NR_swapoff               (TARGET_NR_Linux + 163)
> +#define TARGET_NR_reboot                (TARGET_NR_Linux + 164)
> +#define TARGET_NR_sethostname           (TARGET_NR_Linux + 165)
> +#define TARGET_NR_setdomainname         (TARGET_NR_Linux + 166)
> +#define TARGET_NR_create_module         (TARGET_NR_Linux + 167)
> +#define TARGET_NR_init_module           (TARGET_NR_Linux + 168)
> +#define TARGET_NR_delete_module         (TARGET_NR_Linux + 169)
> +#define TARGET_NR_get_kernel_syms       (TARGET_NR_Linux + 170)
> +#define TARGET_NR_query_module          (TARGET_NR_Linux + 171)
> +#define TARGET_NR_quotactl              (TARGET_NR_Linux + 172)
> +#define TARGET_NR_nfsservctl            (TARGET_NR_Linux + 173)
> +#define TARGET_NR_getpmsg               (TARGET_NR_Linux + 174)
> +#define TARGET_NR_putpmsg               (TARGET_NR_Linux + 175)
> +#define TARGET_NR_afs_syscall           (TARGET_NR_Linux + 176)
> +#define TARGET_NR_reserved177           (TARGET_NR_Linux + 177)
> +#define TARGET_NR_gettid                (TARGET_NR_Linux + 178)
> +#define TARGET_NR_readahead             (TARGET_NR_Linux + 179)
> +#define TARGET_NR_setxattr              (TARGET_NR_Linux + 180)
> +#define TARGET_NR_lsetxattr             (TARGET_NR_Linux + 181)
> +#define TARGET_NR_fsetxattr             (TARGET_NR_Linux + 182)
> +#define TARGET_NR_getxattr              (TARGET_NR_Linux + 183)
> +#define TARGET_NR_lgetxattr             (TARGET_NR_Linux + 184)
> +#define TARGET_NR_fgetxattr             (TARGET_NR_Linux + 185)
> +#define TARGET_NR_listxattr             (TARGET_NR_Linux + 186)
> +#define TARGET_NR_llistxattr            (TARGET_NR_Linux + 187)
> +#define TARGET_NR_flistxattr            (TARGET_NR_Linux + 188)
> +#define TARGET_NR_removexattr           (TARGET_NR_Linux + 189)
> +#define TARGET_NR_lremovexattr          (TARGET_NR_Linux + 190)
> +#define TARGET_NR_fremovexattr          (TARGET_NR_Linux + 191)
> +#define TARGET_NR_tkill                 (TARGET_NR_Linux + 192)
> +#define TARGET_NR_reserved193           (TARGET_NR_Linux + 193)
> +#define TARGET_NR_futex                 (TARGET_NR_Linux + 194)
> +#define TARGET_NR_sched_setaffinity     (TARGET_NR_Linux + 195)
> +#define TARGET_NR_sched_getaffinity     (TARGET_NR_Linux + 196)
> +#define TARGET_NR_cacheflush            (TARGET_NR_Linux + 197)
> +#define TARGET_NR_cachectl              (TARGET_NR_Linux + 198)
> +#define TARGET_NR_sysmips               (TARGET_NR_Linux + 199)
> +#define TARGET_NR_io_setup              (TARGET_NR_Linux + 200)
> +#define TARGET_NR_io_destroy            (TARGET_NR_Linux + 201)
> +#define TARGET_NR_io_getevents          (TARGET_NR_Linux + 202)
> +#define TARGET_NR_io_submit             (TARGET_NR_Linux + 203)
> +#define TARGET_NR_io_cancel             (TARGET_NR_Linux + 204)
> +#define TARGET_NR_exit_group            (TARGET_NR_Linux + 205)
> +#define TARGET_NR_lookup_dcookie        (TARGET_NR_Linux + 206)
> +#define TARGET_NR_epoll_create          (TARGET_NR_Linux + 207)
> +#define TARGET_NR_epoll_ctl             (TARGET_NR_Linux + 208)
> +#define TARGET_NR_epoll_wait            (TARGET_NR_Linux + 209)
> +#define TARGET_NR_remap_file_pages      (TARGET_NR_Linux + 210)
> +#define TARGET_NR_rt_sigreturn          (TARGET_NR_Linux + 211)
> +#define TARGET_NR_fcntl64               (TARGET_NR_Linux + 212)
> +#define TARGET_NR_set_tid_address       (TARGET_NR_Linux + 213)
> +#define TARGET_NR_restart_syscall       (TARGET_NR_Linux + 214)
> +#define TARGET_NR_semtimedop            (TARGET_NR_Linux + 215)
> +#define TARGET_NR_fadvise64             (TARGET_NR_Linux + 216)
> +#define TARGET_NR_statfs64              (TARGET_NR_Linux + 217)
> +#define TARGET_NR_fstatfs64             (TARGET_NR_Linux + 218)
> +#define TARGET_NR_sendfile64            (TARGET_NR_Linux + 219)
> +#define TARGET_NR_timer_create          (TARGET_NR_Linux + 220)
> +#define TARGET_NR_timer_settime         (TARGET_NR_Linux + 221)
> +#define TARGET_NR_timer_gettime         (TARGET_NR_Linux + 222)
> +#define TARGET_NR_timer_getoverrun      (TARGET_NR_Linux + 223)
> +#define TARGET_NR_timer_delete          (TARGET_NR_Linux + 224)
> +#define TARGET_NR_clock_settime         (TARGET_NR_Linux + 225)
> +#define TARGET_NR_clock_gettime         (TARGET_NR_Linux + 226)
> +#define TARGET_NR_clock_getres          (TARGET_NR_Linux + 227)
> +#define TARGET_NR_clock_nanosleep       (TARGET_NR_Linux + 228)
> +#define TARGET_NR_tgkill                (TARGET_NR_Linux + 229)
> +#define TARGET_NR_utimes                (TARGET_NR_Linux + 230)
> +#define TARGET_NR_mbind                 (TARGET_NR_Linux + 231)
> +#define TARGET_NR_get_mempolicy         (TARGET_NR_Linux + 232)
> +#define TARGET_NR_set_mempolicy         (TARGET_NR_Linux + 233)
> +#define TARGET_NR_mq_open               (TARGET_NR_Linux + 234)
> +#define TARGET_NR_mq_unlink             (TARGET_NR_Linux + 235)
> +#define TARGET_NR_mq_timedsend          (TARGET_NR_Linux + 236)
> +#define TARGET_NR_mq_timedreceive       (TARGET_NR_Linux + 237)
> +#define TARGET_NR_mq_notify             (TARGET_NR_Linux + 238)
> +#define TARGET_NR_mq_getsetattr         (TARGET_NR_Linux + 239)
> +#define TARGET_NR_vserver               (TARGET_NR_Linux + 240)
> +#define TARGET_NR_waitid                (TARGET_NR_Linux + 241)
> +/* #define TARGET_NR_sys_setaltroot     (TARGET_NR_Linux + 242) */
> +#define TARGET_NR_add_key               (TARGET_NR_Linux + 243)
> +#define TARGET_NR_request_key           (TARGET_NR_Linux + 244)
> +#define TARGET_NR_keyctl                (TARGET_NR_Linux + 245)
> +#define TARGET_NR_set_thread_area       (TARGET_NR_Linux + 246)
> +#define TARGET_NR_inotify_init          (TARGET_NR_Linux + 247)
> +#define TARGET_NR_inotify_add_watch     (TARGET_NR_Linux + 248)
> +#define TARGET_NR_inotify_rm_watch      (TARGET_NR_Linux + 249)
> +#define TARGET_NR_migrate_pages         (TARGET_NR_Linux + 250)
> +#define TARGET_NR_openat                (TARGET_NR_Linux + 251)
> +#define TARGET_NR_mkdirat               (TARGET_NR_Linux + 252)
> +#define TARGET_NR_mknodat               (TARGET_NR_Linux + 253)
> +#define TARGET_NR_fchownat              (TARGET_NR_Linux + 254)
> +#define TARGET_NR_futimesat             (TARGET_NR_Linux + 255)
> +#define TARGET_NR_newfstatat            (TARGET_NR_Linux + 256)
> +#define TARGET_NR_unlinkat              (TARGET_NR_Linux + 257)
> +#define TARGET_NR_renameat              (TARGET_NR_Linux + 258)
> +#define TARGET_NR_linkat                (TARGET_NR_Linux + 259)
> +#define TARGET_NR_symlinkat             (TARGET_NR_Linux + 260)
> +#define TARGET_NR_readlinkat            (TARGET_NR_Linux + 261)
> +#define TARGET_NR_fchmodat              (TARGET_NR_Linux + 262)
> +#define TARGET_NR_faccessat             (TARGET_NR_Linux + 263)
> +#define TARGET_NR_pselect6              (TARGET_NR_Linux + 264)
> +#define TARGET_NR_ppoll                 (TARGET_NR_Linux + 265)
> +#define TARGET_NR_unshare               (TARGET_NR_Linux + 266)
> +#define TARGET_NR_splice                (TARGET_NR_Linux + 267)
> +#define TARGET_NR_sync_file_range       (TARGET_NR_Linux + 268)
> +#define TARGET_NR_tee                   (TARGET_NR_Linux + 269)
> +#define TARGET_NR_vmsplice              (TARGET_NR_Linux + 270)
> +#define TARGET_NR_move_pages            (TARGET_NR_Linux + 271)
> +#define TARGET_NR_set_robust_list       (TARGET_NR_Linux + 272)
> +#define TARGET_NR_get_robust_list       (TARGET_NR_Linux + 273)
> +#define TARGET_NR_kexec_load            (TARGET_NR_Linux + 274)
> +#define TARGET_NR_getcpu                (TARGET_NR_Linux + 275)
> +#define TARGET_NR_epoll_pwait           (TARGET_NR_Linux + 276)
> +#define TARGET_NR_ioprio_set            (TARGET_NR_Linux + 277)
> +#define TARGET_NR_ioprio_get            (TARGET_NR_Linux + 278)
> +#define TARGET_NR_utimensat             (TARGET_NR_Linux + 279)
> +#define TARGET_NR_signalfd              (TARGET_NR_Linux + 280)
> +#define TARGET_NR_timerfd               (TARGET_NR_Linux + 281)
> +#define TARGET_NR_eventfd               (TARGET_NR_Linux + 282)
> +#define TARGET_NR_fallocate             (TARGET_NR_Linux + 283)
> +#define TARGET_NR_timerfd_create        (TARGET_NR_Linux + 284)
> +#define TARGET_NR_timerfd_gettime       (TARGET_NR_Linux + 285)
> +#define TARGET_NR_timerfd_settime       (TARGET_NR_Linux + 286)
> +#define TARGET_NR_signalfd4             (TARGET_NR_Linux + 287)
> +#define TARGET_NR_eventfd2              (TARGET_NR_Linux + 288)
> +#define TARGET_NR_epoll_create1         (TARGET_NR_Linux + 289)
> +#define TARGET_NR_dup3                  (TARGET_NR_Linux + 290)
> +#define TARGET_NR_pipe2                 (TARGET_NR_Linux + 291)
> +#define TARGET_NR_inotify_init1         (TARGET_NR_Linux + 292)
> +#define TARGET_NR_preadv                (TARGET_NR_Linux + 293)
> +#define TARGET_NR_pwritev               (TARGET_NR_Linux + 294)
> +#define TARGET_NR_rt_tgsigqueueinfo     (TARGET_NR_Linux + 295)
> +#define TARGET_NR_perf_event_open       (TARGET_NR_Linux + 296)
> +#define TARGET_NR_accept4               (TARGET_NR_Linux + 297)
> +#define TARGET_NR_recvmmsg              (TARGET_NR_Linux + 298)
> +#define TARGET_NR_getdents64            (TARGET_NR_Linux + 299)
> +#define TARGET_NR_fanotify_init         (TARGET_NR_Linux + 300)
> +#define TARGET_NR_fanotify_mark         (TARGET_NR_Linux + 301)
> +#define TARGET_NR_prlimit64             (TARGET_NR_Linux + 302)
> +#define TARGET_NR_name_to_handle_at     (TARGET_NR_Linux + 303)
> +#define TARGET_NR_open_by_handle_at     (TARGET_NR_Linux + 304)
> +#define TARGET_NR_clock_adjtime         (TARGET_NR_Linux + 305)
> +#define TARGET_NR_syncfs                (TARGET_NR_Linux + 306)
> +#define TARGET_NR_sendmmsg              (TARGET_NR_Linux + 307)
> +#define TARGET_NR_setns                 (TARGET_NR_Linux + 308)
> +#define TARGET_NR_process_vm_readv      (TARGET_NR_Linux + 309)
> +#define TARGET_NR_process_vm_writev     (TARGET_NR_Linux + 310)
> +#define TARGET_NR_kcmp                  (TARGET_NR_Linux + 311)
> +#define TARGET_NR_finit_module          (TARGET_NR_Linux + 312)
> +#define TARGET_NR_sched_setattr         (TARGET_NR_Linux + 313)
> +#define TARGET_NR_sched_getattr         (TARGET_NR_Linux + 314)
> +#define TARGET_NR_renameat2             (TARGET_NR_Linux + 315)
> +#define TARGET_NR_seccomp               (TARGET_NR_Linux + 316)
> +#define TARGET_NR_getrandom             (TARGET_NR_Linux + 317)
> +#define TARGET_NR_memfd_create          (TARGET_NR_Linux + 318)
> +#define TARGET_NR_bpf                   (TARGET_NR_Linux + 319)
> +#define TARGET_NR_execveat              (TARGET_NR_Linux + 320)
> +#define TARGET_NR_userfaultfd           (TARGET_NR_Linux + 321)
> +#define TARGET_NR_membarrier            (TARGET_NR_Linux + 322)
> +#define TARGET_NR_mlock2                (TARGET_NR_Linux + 323)
> +#define TARGET_NR_copy_file_range       (TARGET_NR_Linux + 324)
> +#define TARGET_NR_preadv2               (TARGET_NR_Linux + 325)
> +#define TARGET_NR_pwritev2              (TARGET_NR_Linux + 326)
> +#define TARGET_NR_pkey_mprotect         (TARGET_NR_Linux + 327)
> +#define TARGET_NR_pkey_alloc            (TARGET_NR_Linux + 328)
> +#define TARGET_NR_pkey_free             (TARGET_NR_Linux + 329)
> +#define TARGET_NR_statx                 (TARGET_NR_Linux + 330)
> +#define TARGET_NR_rseq                  (TARGET_NR_Linux + 331)
> +#define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 332)
> +/* 333 through 402 are unassigned to sync up with generic numbers */
> +#define TARGET_NR_clock_gettime64       (TARGET_NR_Linux + 403)
> +#define TARGET_NR_clock_settime64       (TARGET_NR_Linux + 404)
> +#define TARGET_NR_clock_adjtime64       (TARGET_NR_Linux + 405)
> +#define TARGET_NR_clock_getres_time64   (TARGET_NR_Linux + 406)
> +#define TARGET_NR_clock_nanosleep_time64 (TARGET_NR_Linux + 407)
> +#define TARGET_NR_timer_gettime64       (TARGET_NR_Linux + 408)
> +#define TARGET_NR_timer_settime64       (TARGET_NR_Linux + 409)
> +#define TARGET_NR_timerfd_gettime64     (TARGET_NR_Linux + 410)
> +#define TARGET_NR_timerfd_settime64     (TARGET_NR_Linux + 411)
> +#define TARGET_NR_utimensat_time64      (TARGET_NR_Linux + 412)
> +#define TARGET_NR_pselect6_time64       (TARGET_NR_Linux + 413)
> +#define TARGET_NR_ppoll_time64          (TARGET_NR_Linux + 414)
> +#define TARGET_NR_io_pgetevents_time64  (TARGET_NR_Linux + 416)
> +#define TARGET_NR_recvmmsg_time64       (TARGET_NR_Linux + 417)
> +#define TARGET_NR_mq_timedsend_time64   (TARGET_NR_Linux + 418)
> +#define TARGET_NR_mq_timedreceive_time64 (TARGET_NR_Linux + 419)
> +#define TARGET_NR_semtimedop_time64     (TARGET_NR_Linux + 420)
> +#define TARGET_NR_rt_sigtimedwait_time64 (TARGET_NR_Linux + 421)
> +#define TARGET_NR_futex_time64          (TARGET_NR_Linux + 422)
> +#define TARGET_NR_sched_rr_get_interval_time64 (TARGET_NR_Linux + 423)
> +#define TARGET_NR_pidfd_send_signal     (TARGET_NR_Linux + 424)
> +#define TARGET_NR_io_uring_setup        (TARGET_NR_Linux + 425)
> +#define TARGET_NR_io_uring_enter        (TARGET_NR_Linux + 426)
> +#define TARGET_NR_io_uring_register     (TARGET_NR_Linux + 427)
> +#define TARGET_NR_open_tree             (TARGET_NR_Linux + 428)
> +#define TARGET_NR_move_mount            (TARGET_NR_Linux + 429)
> +#define TARGET_NR_fsopen                (TARGET_NR_Linux + 430)
> +#define TARGET_NR_fsconfig              (TARGET_NR_Linux + 431)
> +#define TARGET_NR_fsmount               (TARGET_NR_Linux + 432)
> +#define TARGET_NR_fspick                (TARGET_NR_Linux + 433)
> +#define TARGET_NR_pidfd_open            (TARGET_NR_Linux + 434)
> +#define TARGET_NR_clone3                (TARGET_NR_Linux + 435)
> +
> +#endif
> diff --git a/linux-user/mips64/syscall64_nr.h
> b/linux-user/mips64/syscall64_nr.h
> new file mode 100644
> index 000000000000..bc1a0edf125f
> --- /dev/null
> +++ b/linux-user/mips64/syscall64_nr.h
> @@ -0,0 +1,351 @@
> +#ifndef LINUX_USER_MIPS64_SYSCALL64_NR_H
> +#define LINUX_USER_MIPS64_SYSCALL64_NR_H
> +
> +/*
> + * Linux 64-bit syscalls are in the range from 5000 to 5999.
> + */
> +#define TARGET_NR_Linux                 5000
> +#define TARGET_NR_read                  (TARGET_NR_Linux +   0)
> +#define TARGET_NR_write                 (TARGET_NR_Linux +   1)
> +#define TARGET_NR_open                  (TARGET_NR_Linux +   2)
> +#define TARGET_NR_close                 (TARGET_NR_Linux +   3)
> +#define TARGET_NR_stat                  (TARGET_NR_Linux +   4)
> +#define TARGET_NR_fstat                 (TARGET_NR_Linux +   5)
> +#define TARGET_NR_lstat                 (TARGET_NR_Linux +   6)
> +#define TARGET_NR_poll                  (TARGET_NR_Linux +   7)
> +#define TARGET_NR_lseek                 (TARGET_NR_Linux +   8)
> +#define TARGET_NR_mmap                  (TARGET_NR_Linux +   9)
> +#define TARGET_NR_mprotect              (TARGET_NR_Linux +  10)
> +#define TARGET_NR_munmap                (TARGET_NR_Linux +  11)
> +#define TARGET_NR_brk                   (TARGET_NR_Linux +  12)
> +#define TARGET_NR_rt_sigaction          (TARGET_NR_Linux +  13)
> +#define TARGET_NR_rt_sigprocmask        (TARGET_NR_Linux +  14)
> +#define TARGET_NR_ioctl                 (TARGET_NR_Linux +  15)
> +#define TARGET_NR_pread64               (TARGET_NR_Linux +  16)
> +#define TARGET_NR_pwrite64              (TARGET_NR_Linux +  17)
> +#define TARGET_NR_readv                 (TARGET_NR_Linux +  18)
> +#define TARGET_NR_writev                (TARGET_NR_Linux +  19)
> +#define TARGET_NR_access                (TARGET_NR_Linux +  20)
> +#define TARGET_NR_pipe                  (TARGET_NR_Linux +  21)
> +#define TARGET_NR__newselect            (TARGET_NR_Linux +  22)
> +#define TARGET_NR_sched_yield           (TARGET_NR_Linux +  23)
> +#define TARGET_NR_mremap                (TARGET_NR_Linux +  24)
> +#define TARGET_NR_msync                 (TARGET_NR_Linux +  25)
> +#define TARGET_NR_mincore               (TARGET_NR_Linux +  26)
> +#define TARGET_NR_madvise               (TARGET_NR_Linux +  27)
> +#define TARGET_NR_shmget                (TARGET_NR_Linux +  28)
> +#define TARGET_NR_shmat                 (TARGET_NR_Linux +  29)
> +#define TARGET_NR_shmctl                (TARGET_NR_Linux +  30)
> +#define TARGET_NR_dup                   (TARGET_NR_Linux +  31)
> +#define TARGET_NR_dup2                  (TARGET_NR_Linux +  32)
> +#define TARGET_NR_pause                 (TARGET_NR_Linux +  33)
> +#define TARGET_NR_nanosleep             (TARGET_NR_Linux +  34)
> +#define TARGET_NR_getitimer             (TARGET_NR_Linux +  35)
> +#define TARGET_NR_setitimer             (TARGET_NR_Linux +  36)
> +#define TARGET_NR_alarm                 (TARGET_NR_Linux +  37)
> +#define TARGET_NR_getpid                (TARGET_NR_Linux +  38)
> +#define TARGET_NR_sendfile              (TARGET_NR_Linux +  39)
> +#define TARGET_NR_socket                (TARGET_NR_Linux +  40)
> +#define TARGET_NR_connect               (TARGET_NR_Linux +  41)
> +#define TARGET_NR_accept                (TARGET_NR_Linux +  42)
> +#define TARGET_NR_sendto                (TARGET_NR_Linux +  43)
> +#define TARGET_NR_recvfrom              (TARGET_NR_Linux +  44)
> +#define TARGET_NR_sendmsg               (TARGET_NR_Linux +  45)
> +#define TARGET_NR_recvmsg               (TARGET_NR_Linux +  46)
> +#define TARGET_NR_shutdown              (TARGET_NR_Linux +  47)
> +#define TARGET_NR_bind                  (TARGET_NR_Linux +  48)
> +#define TARGET_NR_listen                (TARGET_NR_Linux +  49)
> +#define TARGET_NR_getsockname           (TARGET_NR_Linux +  50)
> +#define TARGET_NR_getpeername           (TARGET_NR_Linux +  51)
> +#define TARGET_NR_socketpair            (TARGET_NR_Linux +  52)
> +#define TARGET_NR_setsockopt            (TARGET_NR_Linux +  53)
> +#define TARGET_NR_getsockopt            (TARGET_NR_Linux +  54)
> +#define TARGET_NR_clone                 (TARGET_NR_Linux +  55)
> +#define TARGET_NR_fork                  (TARGET_NR_Linux +  56)
> +#define TARGET_NR_execve                (TARGET_NR_Linux +  57)
> +#define TARGET_NR_exit                  (TARGET_NR_Linux +  58)
> +#define TARGET_NR_wait4                 (TARGET_NR_Linux +  59)
> +#define TARGET_NR_kill                  (TARGET_NR_Linux +  60)
> +#define TARGET_NR_uname                 (TARGET_NR_Linux +  61)
> +#define TARGET_NR_semget                (TARGET_NR_Linux +  62)
> +#define TARGET_NR_semop                 (TARGET_NR_Linux +  63)
> +#define TARGET_NR_semctl                (TARGET_NR_Linux +  64)
> +#define TARGET_NR_shmdt                 (TARGET_NR_Linux +  65)
> +#define TARGET_NR_msgget                (TARGET_NR_Linux +  66)
> +#define TARGET_NR_msgsnd                (TARGET_NR_Linux +  67)
> +#define TARGET_NR_msgrcv                (TARGET_NR_Linux +  68)
> +#define TARGET_NR_msgctl                (TARGET_NR_Linux +  69)
> +#define TARGET_NR_fcntl                 (TARGET_NR_Linux +  70)
> +#define TARGET_NR_flock                 (TARGET_NR_Linux +  71)
> +#define TARGET_NR_fsync                 (TARGET_NR_Linux +  72)
> +#define TARGET_NR_fdatasync             (TARGET_NR_Linux +  73)
> +#define TARGET_NR_truncate              (TARGET_NR_Linux +  74)
> +#define TARGET_NR_ftruncate             (TARGET_NR_Linux +  75)
> +#define TARGET_NR_getdents              (TARGET_NR_Linux +  76)
> +#define TARGET_NR_getcwd                (TARGET_NR_Linux +  77)
> +#define TARGET_NR_chdir                 (TARGET_NR_Linux +  78)
> +#define TARGET_NR_fchdir                (TARGET_NR_Linux +  79)
> +#define TARGET_NR_rename                (TARGET_NR_Linux +  80)
> +#define TARGET_NR_mkdir                 (TARGET_NR_Linux +  81)
> +#define TARGET_NR_rmdir                 (TARGET_NR_Linux +  82)
> +#define TARGET_NR_creat                 (TARGET_NR_Linux +  83)
> +#define TARGET_NR_link                  (TARGET_NR_Linux +  84)
> +#define TARGET_NR_unlink                (TARGET_NR_Linux +  85)
> +#define TARGET_NR_symlink               (TARGET_NR_Linux +  86)
> +#define TARGET_NR_readlink              (TARGET_NR_Linux +  87)
> +#define TARGET_NR_chmod                 (TARGET_NR_Linux +  88)
> +#define TARGET_NR_fchmod                (TARGET_NR_Linux +  89)
> +#define TARGET_NR_chown                 (TARGET_NR_Linux +  90)
> +#define TARGET_NR_fchown                (TARGET_NR_Linux +  91)
> +#define TARGET_NR_lchown                (TARGET_NR_Linux +  92)
> +#define TARGET_NR_umask                 (TARGET_NR_Linux +  93)
> +#define TARGET_NR_gettimeofday          (TARGET_NR_Linux +  94)
> +#define TARGET_NR_getrlimit             (TARGET_NR_Linux +  95)
> +#define TARGET_NR_getrusage             (TARGET_NR_Linux +  96)
> +#define TARGET_NR_sysinfo               (TARGET_NR_Linux +  97)
> +#define TARGET_NR_times                 (TARGET_NR_Linux +  98)
> +#define TARGET_NR_ptrace                (TARGET_NR_Linux +  99)
> +#define TARGET_NR_getuid                (TARGET_NR_Linux + 100)
> +#define TARGET_NR_syslog                (TARGET_NR_Linux + 101)
> +#define TARGET_NR_getgid                (TARGET_NR_Linux + 102)
> +#define TARGET_NR_setuid                (TARGET_NR_Linux + 103)
> +#define TARGET_NR_setgid                (TARGET_NR_Linux + 104)
> +#define TARGET_NR_geteuid               (TARGET_NR_Linux + 105)
> +#define TARGET_NR_getegid               (TARGET_NR_Linux + 106)
> +#define TARGET_NR_setpgid               (TARGET_NR_Linux + 107)
> +#define TARGET_NR_getppid               (TARGET_NR_Linux + 108)
> +#define TARGET_NR_getpgrp               (TARGET_NR_Linux + 109)
> +#define TARGET_NR_setsid                (TARGET_NR_Linux + 110)
> +#define TARGET_NR_setreuid              (TARGET_NR_Linux + 111)
> +#define TARGET_NR_setregid              (TARGET_NR_Linux + 112)
> +#define TARGET_NR_getgroups             (TARGET_NR_Linux + 113)
> +#define TARGET_NR_setgroups             (TARGET_NR_Linux + 114)
> +#define TARGET_NR_setresuid             (TARGET_NR_Linux + 115)
> +#define TARGET_NR_getresuid             (TARGET_NR_Linux + 116)
> +#define TARGET_NR_setresgid             (TARGET_NR_Linux + 117)
> +#define TARGET_NR_getresgid             (TARGET_NR_Linux + 118)
> +#define TARGET_NR_getpgid               (TARGET_NR_Linux + 119)
> +#define TARGET_NR_setfsuid              (TARGET_NR_Linux + 120)
> +#define TARGET_NR_setfsgid              (TARGET_NR_Linux + 121)
> +#define TARGET_NR_getsid                (TARGET_NR_Linux + 122)
> +#define TARGET_NR_capget                (TARGET_NR_Linux + 123)
> +#define TARGET_NR_capset                (TARGET_NR_Linux + 124)
> +#define TARGET_NR_rt_sigpending         (TARGET_NR_Linux + 125)
> +#define TARGET_NR_rt_sigtimedwait       (TARGET_NR_Linux + 126)
> +#define TARGET_NR_rt_sigqueueinfo       (TARGET_NR_Linux + 127)
> +#define TARGET_NR_rt_sigsuspend         (TARGET_NR_Linux + 128)
> +#define TARGET_NR_sigaltstack           (TARGET_NR_Linux + 129)
> +#define TARGET_NR_utime                 (TARGET_NR_Linux + 130)
> +#define TARGET_NR_mknod                 (TARGET_NR_Linux + 131)
> +#define TARGET_NR_personality           (TARGET_NR_Linux + 132)
> +#define TARGET_NR_ustat                 (TARGET_NR_Linux + 133)
> +#define TARGET_NR_statfs                (TARGET_NR_Linux + 134)
> +#define TARGET_NR_fstatfs               (TARGET_NR_Linux + 135)
> +#define TARGET_NR_sysfs                 (TARGET_NR_Linux + 136)
> +#define TARGET_NR_getpriority           (TARGET_NR_Linux + 137)
> +#define TARGET_NR_setpriority           (TARGET_NR_Linux + 138)
> +#define TARGET_NR_sched_setparam        (TARGET_NR_Linux + 139)
> +#define TARGET_NR_sched_getparam        (TARGET_NR_Linux + 140)
> +#define TARGET_NR_sched_setscheduler    (TARGET_NR_Linux + 141)
> +#define TARGET_NR_sched_getscheduler    (TARGET_NR_Linux + 142)
> +#define TARGET_NR_sched_get_priority_max (TARGET_NR_Linux + 143)
> +#define TARGET_NR_sched_get_priority_min (TARGET_NR_Linux + 144)
> +#define TARGET_NR_sched_rr_get_interval (TARGET_NR_Linux + 145)
> +#define TARGET_NR_mlock                 (TARGET_NR_Linux + 146)
> +#define TARGET_NR_munlock               (TARGET_NR_Linux + 147)
> +#define TARGET_NR_mlockall              (TARGET_NR_Linux + 148)
> +#define TARGET_NR_munlockall            (TARGET_NR_Linux + 149)
> +#define TARGET_NR_vhangup               (TARGET_NR_Linux + 150)
> +#define TARGET_NR_pivot_root            (TARGET_NR_Linux + 151)
> +#define TARGET_NR__sysctl               (TARGET_NR_Linux + 152)
> +#define TARGET_NR_prctl                 (TARGET_NR_Linux + 153)
> +#define TARGET_NR_adjtimex              (TARGET_NR_Linux + 154)
> +#define TARGET_NR_setrlimit             (TARGET_NR_Linux + 155)
> +#define TARGET_NR_chroot                (TARGET_NR_Linux + 156)
> +#define TARGET_NR_sync                  (TARGET_NR_Linux + 157)
> +#define TARGET_NR_acct                  (TARGET_NR_Linux + 158)
> +#define TARGET_NR_settimeofday          (TARGET_NR_Linux + 159)
> +#define TARGET_NR_mount                 (TARGET_NR_Linux + 160)
> +#define TARGET_NR_umount2               (TARGET_NR_Linux + 161)
> +#define TARGET_NR_swapon                (TARGET_NR_Linux + 162)
> +#define TARGET_NR_swapoff               (TARGET_NR_Linux + 163)
> +#define TARGET_NR_reboot                (TARGET_NR_Linux + 164)
> +#define TARGET_NR_sethostname           (TARGET_NR_Linux + 165)
> +#define TARGET_NR_setdomainname         (TARGET_NR_Linux + 166)
> +#define TARGET_NR_create_module         (TARGET_NR_Linux + 167)
> +#define TARGET_NR_init_module           (TARGET_NR_Linux + 168)
> +#define TARGET_NR_delete_module         (TARGET_NR_Linux + 169)
> +#define TARGET_NR_get_kernel_syms       (TARGET_NR_Linux + 170)
> +#define TARGET_NR_query_module          (TARGET_NR_Linux + 171)
> +#define TARGET_NR_quotactl              (TARGET_NR_Linux + 172)
> +#define TARGET_NR_nfsservctl            (TARGET_NR_Linux + 173)
> +#define TARGET_NR_getpmsg               (TARGET_NR_Linux + 174)
> +#define TARGET_NR_putpmsg               (TARGET_NR_Linux + 175)
> +#define TARGET_NR_afs_syscall           (TARGET_NR_Linux + 176)
> +#define TARGET_NR_reserved177           (TARGET_NR_Linux + 177)
> +#define TARGET_NR_gettid                (TARGET_NR_Linux + 178)
> +#define TARGET_NR_readahead             (TARGET_NR_Linux + 179)
> +#define TARGET_NR_setxattr              (TARGET_NR_Linux + 180)
> +#define TARGET_NR_lsetxattr             (TARGET_NR_Linux + 181)
> +#define TARGET_NR_fsetxattr             (TARGET_NR_Linux + 182)
> +#define TARGET_NR_getxattr              (TARGET_NR_Linux + 183)
> +#define TARGET_NR_lgetxattr             (TARGET_NR_Linux + 184)
> +#define TARGET_NR_fgetxattr             (TARGET_NR_Linux + 185)
> +#define TARGET_NR_listxattr             (TARGET_NR_Linux + 186)
> +#define TARGET_NR_llistxattr            (TARGET_NR_Linux + 187)
> +#define TARGET_NR_flistxattr            (TARGET_NR_Linux + 188)
> +#define TARGET_NR_removexattr           (TARGET_NR_Linux + 189)
> +#define TARGET_NR_lremovexattr          (TARGET_NR_Linux + 190)
> +#define TARGET_NR_fremovexattr          (TARGET_NR_Linux + 191)
> +#define TARGET_NR_tkill                 (TARGET_NR_Linux + 192)
> +#define TARGET_NR_reserved193           (TARGET_NR_Linux + 193)
> +#define TARGET_NR_futex                 (TARGET_NR_Linux + 194)
> +#define TARGET_NR_sched_setaffinity     (TARGET_NR_Linux + 195)
> +#define TARGET_NR_sched_getaffinity     (TARGET_NR_Linux + 196)
> +#define TARGET_NR_cacheflush            (TARGET_NR_Linux + 197)
> +#define TARGET_NR_cachectl              (TARGET_NR_Linux + 198)
> +#define TARGET_NR_sysmips               (TARGET_NR_Linux + 199)
> +#define TARGET_NR_io_setup              (TARGET_NR_Linux + 200)
> +#define TARGET_NR_io_destroy            (TARGET_NR_Linux + 201)
> +#define TARGET_NR_io_getevents          (TARGET_NR_Linux + 202)
> +#define TARGET_NR_io_submit             (TARGET_NR_Linux + 203)
> +#define TARGET_NR_io_cancel             (TARGET_NR_Linux + 204)
> +#define TARGET_NR_exit_group            (TARGET_NR_Linux + 205)
> +#define TARGET_NR_lookup_dcookie        (TARGET_NR_Linux + 206)
> +#define TARGET_NR_epoll_create          (TARGET_NR_Linux + 207)
> +#define TARGET_NR_epoll_ctl             (TARGET_NR_Linux + 208)
> +#define TARGET_NR_epoll_wait            (TARGET_NR_Linux + 209)
> +#define TARGET_NR_remap_file_pages      (TARGET_NR_Linux + 210)
> +#define TARGET_NR_rt_sigreturn          (TARGET_NR_Linux + 211)
> +#define TARGET_NR_set_tid_address       (TARGET_NR_Linux + 212)
> +#define TARGET_NR_restart_syscall       (TARGET_NR_Linux + 213)
> +#define TARGET_NR_semtimedop            (TARGET_NR_Linux + 214)
> +#define TARGET_NR_fadvise64             (TARGET_NR_Linux + 215)
> +#define TARGET_NR_timer_create          (TARGET_NR_Linux + 216)
> +#define TARGET_NR_timer_settime         (TARGET_NR_Linux + 217)
> +#define TARGET_NR_timer_gettime         (TARGET_NR_Linux + 218)
> +#define TARGET_NR_timer_getoverrun      (TARGET_NR_Linux + 219)
> +#define TARGET_NR_timer_delete          (TARGET_NR_Linux + 220)
> +#define TARGET_NR_clock_settime         (TARGET_NR_Linux + 221)
> +#define TARGET_NR_clock_gettime         (TARGET_NR_Linux + 222)
> +#define TARGET_NR_clock_getres          (TARGET_NR_Linux + 223)
> +#define TARGET_NR_clock_nanosleep       (TARGET_NR_Linux + 224)
> +#define TARGET_NR_tgkill                (TARGET_NR_Linux + 225)
> +#define TARGET_NR_utimes                (TARGET_NR_Linux + 226)
> +#define TARGET_NR_mbind                 (TARGET_NR_Linux + 227)
> +#define TARGET_NR_get_mempolicy         (TARGET_NR_Linux + 228)
> +#define TARGET_NR_set_mempolicy         (TARGET_NR_Linux + 229)
> +#define TARGET_NR_mq_open               (TARGET_NR_Linux + 230)
> +#define TARGET_NR_mq_unlink             (TARGET_NR_Linux + 231)
> +#define TARGET_NR_mq_timedsend          (TARGET_NR_Linux + 232)
> +#define TARGET_NR_mq_timedreceive       (TARGET_NR_Linux + 233)
> +#define TARGET_NR_mq_notify             (TARGET_NR_Linux + 234)
> +#define TARGET_NR_mq_getsetattr         (TARGET_NR_Linux + 235)
> +#define TARGET_NR_vserver               (TARGET_NR_Linux + 236)
> +#define TARGET_NR_waitid                (TARGET_NR_Linux + 237)
> +/* #define TARGET_NR_sys_setaltroot     (TARGET_NR_Linux + 238) */
> +#define TARGET_NR_add_key               (TARGET_NR_Linux + 239)
> +#define TARGET_NR_request_key           (TARGET_NR_Linux + 240)
> +#define TARGET_NR_keyctl                (TARGET_NR_Linux + 241)
> +#define TARGET_NR_set_thread_area       (TARGET_NR_Linux + 242)
> +#define TARGET_NR_inotify_init          (TARGET_NR_Linux + 243)
> +#define TARGET_NR_inotify_add_watch     (TARGET_NR_Linux + 244)
> +#define TARGET_NR_inotify_rm_watch      (TARGET_NR_Linux + 245)
> +#define TARGET_NR_migrate_pages         (TARGET_NR_Linux + 246)
> +#define TARGET_NR_openat                (TARGET_NR_Linux + 247)
> +#define TARGET_NR_mkdirat               (TARGET_NR_Linux + 248)
> +#define TARGET_NR_mknodat               (TARGET_NR_Linux + 249)
> +#define TARGET_NR_fchownat              (TARGET_NR_Linux + 250)
> +#define TARGET_NR_futimesat             (TARGET_NR_Linux + 251)
> +#define TARGET_NR_newfstatat            (TARGET_NR_Linux + 252)
> +#define TARGET_NR_unlinkat              (TARGET_NR_Linux + 253)
> +#define TARGET_NR_renameat              (TARGET_NR_Linux + 254)
> +#define TARGET_NR_linkat                (TARGET_NR_Linux + 255)
> +#define TARGET_NR_symlinkat             (TARGET_NR_Linux + 256)
> +#define TARGET_NR_readlinkat            (TARGET_NR_Linux + 257)
> +#define TARGET_NR_fchmodat              (TARGET_NR_Linux + 258)
> +#define TARGET_NR_faccessat             (TARGET_NR_Linux + 259)
> +#define TARGET_NR_pselect6              (TARGET_NR_Linux + 260)
> +#define TARGET_NR_ppoll                 (TARGET_NR_Linux + 261)
> +#define TARGET_NR_unshare               (TARGET_NR_Linux + 262)
> +#define TARGET_NR_splice                (TARGET_NR_Linux + 263)
> +#define TARGET_NR_sync_file_range       (TARGET_NR_Linux + 264)
> +#define TARGET_NR_tee                   (TARGET_NR_Linux + 265)
> +#define TARGET_NR_vmsplice              (TARGET_NR_Linux + 266)
> +#define TARGET_NR_move_pages            (TARGET_NR_Linux + 267)
> +#define TARGET_NR_set_robust_list       (TARGET_NR_Linux + 268)
> +#define TARGET_NR_get_robust_list       (TARGET_NR_Linux + 269)
> +#define TARGET_NR_kexec_load            (TARGET_NR_Linux + 270)
> +#define TARGET_NR_getcpu                (TARGET_NR_Linux + 271)
> +#define TARGET_NR_epoll_pwait           (TARGET_NR_Linux + 272)
> +#define TARGET_NR_ioprio_set            (TARGET_NR_Linux + 273)
> +#define TARGET_NR_ioprio_get            (TARGET_NR_Linux + 274)
> +#define TARGET_NR_utimensat             (TARGET_NR_Linux + 275)
> +#define TARGET_NR_signalfd              (TARGET_NR_Linux + 276)
> +#define TARGET_NR_timerfd               (TARGET_NR_Linux + 277)
> +#define TARGET_NR_eventfd               (TARGET_NR_Linux + 278)
> +#define TARGET_NR_fallocate             (TARGET_NR_Linux + 279)
> +#define TARGET_NR_timerfd_create        (TARGET_NR_Linux + 280)
> +#define TARGET_NR_timerfd_gettime       (TARGET_NR_Linux + 281)
> +#define TARGET_NR_timerfd_settime       (TARGET_NR_Linux + 282)
> +#define TARGET_NR_signalfd4             (TARGET_NR_Linux + 283)
> +#define TARGET_NR_eventfd2              (TARGET_NR_Linux + 284)
> +#define TARGET_NR_epoll_create1         (TARGET_NR_Linux + 285)
> +#define TARGET_NR_dup3                  (TARGET_NR_Linux + 286)
> +#define TARGET_NR_pipe2                 (TARGET_NR_Linux + 287)
> +#define TARGET_NR_inotify_init1         (TARGET_NR_Linux + 288)
> +#define TARGET_NR_preadv                (TARGET_NR_Linux + 289)
> +#define TARGET_NR_pwritev               (TARGET_NR_Linux + 290)
> +#define TARGET_NR_rt_tgsigqueueinfo     (TARGET_NR_Linux + 291)
> +#define TARGET_NR_perf_event_open       (TARGET_NR_Linux + 292)
> +#define TARGET_NR_accept4               (TARGET_NR_Linux + 293)
> +#define TARGET_NR_recvmmsg              (TARGET_NR_Linux + 294)
> +#define TARGET_NR_fanotify_init         (TARGET_NR_Linux + 295)
> +#define TARGET_NR_fanotify_mark         (TARGET_NR_Linux + 296)
> +#define TARGET_NR_prlimit64             (TARGET_NR_Linux + 297)
> +#define TARGET_NR_name_to_handle_at     (TARGET_NR_Linux + 298)
> +#define TARGET_NR_open_by_handle_at     (TARGET_NR_Linux + 299)
> +#define TARGET_NR_clock_adjtime         (TARGET_NR_Linux + 300)
> +#define TARGET_NR_syncfs                (TARGET_NR_Linux + 301)
> +#define TARGET_NR_sendmmsg              (TARGET_NR_Linux + 302)
> +#define TARGET_NR_setns                 (TARGET_NR_Linux + 303)
> +#define TARGET_NR_process_vm_readv      (TARGET_NR_Linux + 304)
> +#define TARGET_NR_process_vm_writev     (TARGET_NR_Linux + 305)
> +#define TARGET_NR_kcmp                  (TARGET_NR_Linux + 306)
> +#define TARGET_NR_finit_module          (TARGET_NR_Linux + 307)
> +#define TARGET_NR_getdents64            (TARGET_NR_Linux + 308)
> +#define TARGET_NR_sched_setattr         (TARGET_NR_Linux + 309)
> +#define TARGET_NR_sched_getattr         (TARGET_NR_Linux + 310)
> +#define TARGET_NR_renameat2             (TARGET_NR_Linux + 311)
> +#define TARGET_NR_seccomp               (TARGET_NR_Linux + 312)
> +#define TARGET_NR_getrandom             (TARGET_NR_Linux + 313)
> +#define TARGET_NR_memfd_create          (TARGET_NR_Linux + 314)
> +#define TARGET_NR_bpf                   (TARGET_NR_Linux + 315)
> +#define TARGET_NR_execveat              (TARGET_NR_Linux + 316)
> +#define TARGET_NR_userfaultfd           (TARGET_NR_Linux + 317)
> +#define TARGET_NR_membarrier            (TARGET_NR_Linux + 318)
> +#define TARGET_NR_mlock2                (TARGET_NR_Linux + 319)
> +#define TARGET_NR_copy_file_range       (TARGET_NR_Linux + 320)
> +#define TARGET_NR_preadv2               (TARGET_NR_Linux + 321)
> +#define TARGET_NR_pwritev2              (TARGET_NR_Linux + 322)
> +#define TARGET_NR_pkey_mprotect         (TARGET_NR_Linux + 323)
> +#define TARGET_NR_pkey_alloc            (TARGET_NR_Linux + 324)
> +#define TARGET_NR_pkey_free             (TARGET_NR_Linux + 325)
> +#define TARGET_NR_statx                 (TARGET_NR_Linux + 326)
> +#define TARGET_NR_rseq                  (TARGET_NR_Linux + 327)
> +#define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 328)
> +/* 329 through 423 are reserved to sync up with other architectures */
> +#define TARGET_NR_pidfd_send_signal     (TARGET_NR_Linux + 424)
> +#define TARGET_NR_io_uring_setup        (TARGET_NR_Linux + 425)
> +#define TARGET_NR_io_uring_enter        (TARGET_NR_Linux + 426)
> +#define TARGET_NR_io_uring_register     (TARGET_NR_Linux + 427)
> +#define TARGET_NR_open_tree             (TARGET_NR_Linux + 428)
> +#define TARGET_NR_move_mount            (TARGET_NR_Linux + 429)
> +#define TARGET_NR_fsopen                (TARGET_NR_Linux + 430)
> +#define TARGET_NR_fsconfig              (TARGET_NR_Linux + 431)
> +#define TARGET_NR_fsmount               (TARGET_NR_Linux + 432)
> +#define TARGET_NR_fspick                (TARGET_NR_Linux + 433)
> +#define TARGET_NR_pidfd_open            (TARGET_NR_Linux + 434)
> +#define TARGET_NR_clone3                (TARGET_NR_Linux + 435)
> +
> +#endif
> diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_
> nr.h
> index 6e23e9fcdb0c..85651dfced1b 100644
> --- a/linux-user/mips64/syscall_nr.h
> +++ b/linux-user/mips64/syscall_nr.h
> @@ -2,724 +2,9 @@
>  #define LINUX_USER_MIPS64_SYSCALL_NR_H
>
>  #ifdef TARGET_ABI32
> -/*
> - * Linux N32 syscalls are in the range from 6000 to 6999.
> - */
> -#define TARGET_NR_Linux                 6000
> -#define TARGET_NR_read                  (TARGET_NR_Linux +   0)
> -#define TARGET_NR_write                 (TARGET_NR_Linux +   1)
> -#define TARGET_NR_open                  (TARGET_NR_Linux +   2)
> -#define TARGET_NR_close                 (TARGET_NR_Linux +   3)
> -#define TARGET_NR_stat                  (TARGET_NR_Linux +   4)
> -#define TARGET_NR_fstat                 (TARGET_NR_Linux +   5)
> -#define TARGET_NR_lstat                 (TARGET_NR_Linux +   6)
> -#define TARGET_NR_poll                  (TARGET_NR_Linux +   7)
> -#define TARGET_NR_lseek                 (TARGET_NR_Linux +   8)
> -#define TARGET_NR_mmap                  (TARGET_NR_Linux +   9)
> -#define TARGET_NR_mprotect              (TARGET_NR_Linux +  10)
> -#define TARGET_NR_munmap                (TARGET_NR_Linux +  11)
> -#define TARGET_NR_brk                   (TARGET_NR_Linux +  12)
> -#define TARGET_NR_rt_sigaction          (TARGET_NR_Linux +  13)
> -#define TARGET_NR_rt_sigprocmask        (TARGET_NR_Linux +  14)
> -#define TARGET_NR_ioctl                 (TARGET_NR_Linux +  15)
> -#define TARGET_NR_pread64               (TARGET_NR_Linux +  16)
> -#define TARGET_NR_pwrite64              (TARGET_NR_Linux +  17)
> -#define TARGET_NR_readv                 (TARGET_NR_Linux +  18)
> -#define TARGET_NR_writev                (TARGET_NR_Linux +  19)
> -#define TARGET_NR_access                (TARGET_NR_Linux +  20)
> -#define TARGET_NR_pipe                  (TARGET_NR_Linux +  21)
> -#define TARGET_NR__newselect            (TARGET_NR_Linux +  22)
> -#define TARGET_NR_sched_yield           (TARGET_NR_Linux +  23)
> -#define TARGET_NR_mremap                (TARGET_NR_Linux +  24)
> -#define TARGET_NR_msync                 (TARGET_NR_Linux +  25)
> -#define TARGET_NR_mincore               (TARGET_NR_Linux +  26)
> -#define TARGET_NR_madvise               (TARGET_NR_Linux +  27)
> -#define TARGET_NR_shmget                (TARGET_NR_Linux +  28)
> -#define TARGET_NR_shmat                 (TARGET_NR_Linux +  29)
> -#define TARGET_NR_shmctl                (TARGET_NR_Linux +  30)
> -#define TARGET_NR_dup                   (TARGET_NR_Linux +  31)
> -#define TARGET_NR_dup2                  (TARGET_NR_Linux +  32)
> -#define TARGET_NR_pause                 (TARGET_NR_Linux +  33)
> -#define TARGET_NR_nanosleep             (TARGET_NR_Linux +  34)
> -#define TARGET_NR_getitimer             --
> 2.24.1
>
>
>

--000000000000b21910059edd5daa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, February 17, 2020, Laurent Vivier &lt;<a href=3D"mailto:=
laurent@vivier.eu">laurent@vivier.eu</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Split into syscall32_nr.h (n32) and syscall64_nr.h (n64)<br>
<br>
o32 interface is in mips/syscall_nr.h<br>
<br>
Signed-off-by: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" targ=
et=3D"_blank">laurent@vivier.eu</a>&gt;<br>
---</blockquote><div><br></div><div><br></div><div><span style=3D"color:rgb=
(34,34,34);font-size:14px;line-height:22.1200008392334px">Reviewed-by: Alek=
sandar Markovic &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=
=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.com</=
a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000083=
92334px">&gt;</span><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
=C2=A0linux-user/mips64/syscall32_<wbr>nr.h | 375 ++++++++++++++++<br>
=C2=A0linux-user/mips64/syscall64_<wbr>nr.h | 351 +++++++++++++++<br>
=C2=A0linux-user/mips64/syscall_nr.<wbr>h=C2=A0 =C2=A0| 719 +--------------=
---------------<wbr>-<br>
=C2=A03 files changed, 728 insertions(+), 717 deletions(-)<br>
=C2=A0create mode 100644 linux-user/mips64/syscall32_<wbr>nr.h<br>
=C2=A0create mode 100644 linux-user/mips64/syscall64_<wbr>nr.h<br>
<br>
diff --git a/linux-user/mips64/syscall32_<wbr>nr.h b/linux-user/mips64/sysc=
all32_<wbr>nr.h<br>
new file mode 100644<br>
index 000000000000..3244a543ba76<br>
--- /dev/null<br>
+++ b/linux-user/mips64/syscall32_<wbr>nr.h<br>
@@ -0,0 +1,375 @@<br>
+#ifndef LINUX_USER_MIPS64_SYSCALL32_<wbr>NR_H<br>
+#define LINUX_USER_MIPS64_SYSCALL32_<wbr>NR_H<br>
+<br>
+/*<br>
+ * Linux N32 syscalls are in the range from 6000 to 6999.<br>
+ */<br>
+#define TARGET_NR_Linux=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A06000<br>
+#define TARGET_NR_read=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A00)<br>
+#define TARGET_NR_write=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A01)<br>
+#define TARGET_NR_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A02)<br>
+#define TARGET_NR_close=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A03)<br>
+#define TARGET_NR_stat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A04)<br>
+#define TARGET_NR_fstat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A05)<br>
+#define TARGET_NR_lstat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A06)<br>
+#define TARGET_NR_poll=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A07)<br>
+#define TARGET_NR_lseek=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A08)<br>
+#define TARGET_NR_mmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A09)<br>
+#define TARGET_NR_mprotect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 10)<br>
+#define TARGET_NR_munmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 11)<br>
+#define TARGET_NR_brk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 12)<br>
+#define TARGET_NR_rt_sigaction=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux +=C2=A0 13)<br>
+#define TARGET_NR_rt_sigprocmask=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux +=C2=A0 14)<br>
+#define TARGET_NR_ioctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 15)<br>
+#define TARGET_NR_pread64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 16)<br>
+#define TARGET_NR_pwrite64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 17)<br>
+#define TARGET_NR_readv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 18)<br>
+#define TARGET_NR_writev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 19)<br>
+#define TARGET_NR_access=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 20)<br>
+#define TARGET_NR_pipe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 21)<br>
+#define TARGET_NR__newselect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux +=C2=A0 22)<br>
+#define TARGET_NR_sched_yield=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux +=C2=A0 23)<br>
+#define TARGET_NR_mremap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 24)<br>
+#define TARGET_NR_msync=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 25)<br>
+#define TARGET_NR_mincore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 26)<br>
+#define TARGET_NR_madvise=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 27)<br>
+#define TARGET_NR_shmget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 28)<br>
+#define TARGET_NR_shmat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 29)<br>
+#define TARGET_NR_shmctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 30)<br>
+#define TARGET_NR_dup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 31)<br>
+#define TARGET_NR_dup2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 32)<br>
+#define TARGET_NR_pause=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 33)<br>
+#define TARGET_NR_nanosleep=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 34)<br>
+#define TARGET_NR_getitimer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 35)<br>
+#define TARGET_NR_setitimer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 36)<br>
+#define TARGET_NR_alarm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 37)<br>
+#define TARGET_NR_getpid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 38)<br>
+#define TARGET_NR_sendfile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 39)<br>
+#define TARGET_NR_socket=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 40)<br>
+#define TARGET_NR_connect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 41)<br>
+#define TARGET_NR_accept=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 42)<br>
+#define TARGET_NR_sendto=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 43)<br>
+#define TARGET_NR_recvfrom=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 44)<br>
+#define TARGET_NR_sendmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 45)<br>
+#define TARGET_NR_recvmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 46)<br>
+#define TARGET_NR_shutdown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 47)<br>
+#define TARGET_NR_bind=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 48)<br>
+#define TARGET_NR_listen=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 49)<br>
+#define TARGET_NR_getsockname=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux +=C2=A0 50)<br>
+#define TARGET_NR_getpeername=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux +=C2=A0 51)<br>
+#define TARGET_NR_socketpair=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux +=C2=A0 52)<br>
+#define TARGET_NR_setsockopt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux +=C2=A0 53)<br>
+#define TARGET_NR_getsockopt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux +=C2=A0 54)<br>
+#define TARGET_NR_clone=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 55)<br>
+#define TARGET_NR_fork=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 56)<br>
+#define TARGET_NR_execve=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 57)<br>
+#define TARGET_NR_exit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 58)<br>
+#define TARGET_NR_wait4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 59)<br>
+#define TARGET_NR_kill=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 60)<br>
+#define TARGET_NR_uname=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 61)<br>
+#define TARGET_NR_semget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 62)<br>
+#define TARGET_NR_semop=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 63)<br>
+#define TARGET_NR_semctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 64)<br>
+#define TARGET_NR_shmdt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 65)<br>
+#define TARGET_NR_msgget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 66)<br>
+#define TARGET_NR_msgsnd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 67)<br>
+#define TARGET_NR_msgrcv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 68)<br>
+#define TARGET_NR_msgctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 69)<br>
+#define TARGET_NR_fcntl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 70)<br>
+#define TARGET_NR_flock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 71)<br>
+#define TARGET_NR_fsync=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 72)<br>
+#define TARGET_NR_fdatasync=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 73)<br>
+#define TARGET_NR_truncate=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 74)<br>
+#define TARGET_NR_ftruncate=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 75)<br>
+#define TARGET_NR_getdents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 76)<br>
+#define TARGET_NR_getcwd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 77)<br>
+#define TARGET_NR_chdir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 78)<br>
+#define TARGET_NR_fchdir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 79)<br>
+#define TARGET_NR_rename=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 80)<br>
+#define TARGET_NR_mkdir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 81)<br>
+#define TARGET_NR_rmdir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 82)<br>
+#define TARGET_NR_creat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 83)<br>
+#define TARGET_NR_link=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 84)<br>
+#define TARGET_NR_unlink=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 85)<br>
+#define TARGET_NR_symlink=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 86)<br>
+#define TARGET_NR_readlink=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 87)<br>
+#define TARGET_NR_chmod=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 88)<br>
+#define TARGET_NR_fchmod=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 89)<br>
+#define TARGET_NR_chown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 90)<br>
+#define TARGET_NR_fchown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 91)<br>
+#define TARGET_NR_lchown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 92)<br>
+#define TARGET_NR_umask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 93)<br>
+#define TARGET_NR_gettimeofday=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux +=C2=A0 94)<br>
+#define TARGET_NR_getrlimit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 95)<br>
+#define TARGET_NR_getrusage=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 96)<br>
+#define TARGET_NR_sysinfo=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 97)<br>
+#define TARGET_NR_times=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 98)<br>
+#define TARGET_NR_ptrace=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 99)<br>
+#define TARGET_NR_getuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 100)<br>
+#define TARGET_NR_syslog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 101)<br>
+#define TARGET_NR_getgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 102)<br>
+#define TARGET_NR_setuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 103)<br>
+#define TARGET_NR_setgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 104)<br>
+#define TARGET_NR_geteuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 105)<br>
+#define TARGET_NR_getegid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 106)<br>
+#define TARGET_NR_setpgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 107)<br>
+#define TARGET_NR_getppid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 108)<br>
+#define TARGET_NR_getpgrp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 109)<br>
+#define TARGET_NR_setsid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 110)<br>
+#define TARGET_NR_setreuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 111)<br>
+#define TARGET_NR_setregid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 112)<br>
+#define TARGET_NR_getgroups=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 113)<br>
+#define TARGET_NR_setgroups=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 114)<br>
+#define TARGET_NR_setresuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 115)<br>
+#define TARGET_NR_getresuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 116)<br>
+#define TARGET_NR_setresgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 117)<br>
+#define TARGET_NR_getresgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 118)<br>
+#define TARGET_NR_getpgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 119)<br>
+#define TARGET_NR_setfsuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 120)<br>
+#define TARGET_NR_setfsgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 121)<br>
+#define TARGET_NR_getsid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 122)<br>
+#define TARGET_NR_capget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 123)<br>
+#define TARGET_NR_capset=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 124)<br>
+#define TARGET_NR_rt_sigpending=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 125)<br>
+#define TARGET_NR_rt_sigtimedwait=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 126)<br>
+#define TARGET_NR_rt_sigqueueinfo=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 127)<br>
+#define TARGET_NR_rt_sigsuspend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 128)<br>
+#define TARGET_NR_sigaltstack=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 129)<br>
+#define TARGET_NR_utime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 130)<br>
+#define TARGET_NR_mknod=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 131)<br>
+#define TARGET_NR_personality=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 132)<br>
+#define TARGET_NR_ustat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 133)<br>
+#define TARGET_NR_statfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 134)<br>
+#define TARGET_NR_fstatfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 135)<br>
+#define TARGET_NR_sysfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 136)<br>
+#define TARGET_NR_getpriority=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 137)<br>
+#define TARGET_NR_setpriority=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 138)<br>
+#define TARGET_NR_sched_setparam=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 139)<br>
+#define TARGET_NR_sched_getparam=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 140)<br>
+#define TARGET_NR_sched_setscheduler=C2=A0 =C2=A0 (TARGET_NR_Linux + 141)<=
br>
+#define TARGET_NR_sched_getscheduler=C2=A0 =C2=A0 (TARGET_NR_Linux + 142)<=
br>
+#define TARGET_NR_sched_get_priority_<wbr>max=C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
TARGET_NR_Linux + 143)<br>
+#define TARGET_NR_sched_get_priority_<wbr>min=C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
TARGET_NR_Linux + 144)<br>
+#define TARGET_NR_sched_rr_get_<wbr>interval (TARGET_NR_Linux + 145)<br>
+#define TARGET_NR_mlock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 146)<br>
+#define TARGET_NR_munlock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 147)<br>
+#define TARGET_NR_mlockall=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 148)<br>
+#define TARGET_NR_munlockall=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 149)<br>
+#define TARGET_NR_vhangup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 150)<br>
+#define TARGET_NR_pivot_root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 151)<br>
+#define TARGET_NR__sysctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 152)<br>
+#define TARGET_NR_prctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 153)<br>
+#define TARGET_NR_adjtimex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 154)<br>
+#define TARGET_NR_setrlimit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 155)<br>
+#define TARGET_NR_chroot=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 156)<br>
+#define TARGET_NR_sync=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 157)<br>
+#define TARGET_NR_acct=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 158)<br>
+#define TARGET_NR_settimeofday=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 159)<br>
+#define TARGET_NR_mount=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 160)<br>
+#define TARGET_NR_umount2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 161)<br>
+#define TARGET_NR_swapon=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 162)<br>
+#define TARGET_NR_swapoff=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 163)<br>
+#define TARGET_NR_reboot=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 164)<br>
+#define TARGET_NR_sethostname=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 165)<br>
+#define TARGET_NR_setdomainname=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 166)<br>
+#define TARGET_NR_create_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 167)<br>
+#define TARGET_NR_init_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 168)<br>
+#define TARGET_NR_delete_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 169)<br>
+#define TARGET_NR_get_kernel_syms=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 170)<br>
+#define TARGET_NR_query_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 171)<br>
+#define TARGET_NR_quotactl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 172)<br>
+#define TARGET_NR_nfsservctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 173)<br>
+#define TARGET_NR_getpmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 174)<br>
+#define TARGET_NR_putpmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 175)<br>
+#define TARGET_NR_afs_syscall=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 176)<br>
+#define TARGET_NR_reserved177=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 177)<br>
+#define TARGET_NR_gettid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 178)<br>
+#define TARGET_NR_readahead=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 179)<br>
+#define TARGET_NR_setxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 180)<br>
+#define TARGET_NR_lsetxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 181)<br>
+#define TARGET_NR_fsetxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 182)<br>
+#define TARGET_NR_getxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 183)<br>
+#define TARGET_NR_lgetxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 184)<br>
+#define TARGET_NR_fgetxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 185)<br>
+#define TARGET_NR_listxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 186)<br>
+#define TARGET_NR_llistxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 187)<br>
+#define TARGET_NR_flistxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 188)<br>
+#define TARGET_NR_removexattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 189)<br>
+#define TARGET_NR_lremovexattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 190)<br>
+#define TARGET_NR_fremovexattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 191)<br>
+#define TARGET_NR_tkill=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 192)<br>
+#define TARGET_NR_reserved193=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 193)<br>
+#define TARGET_NR_futex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 194)<br>
+#define TARGET_NR_sched_setaffinity=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
195)<br>
+#define TARGET_NR_sched_getaffinity=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
196)<br>
+#define TARGET_NR_cacheflush=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 197)<br>
+#define TARGET_NR_cachectl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 198)<br>
+#define TARGET_NR_sysmips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 199)<br>
+#define TARGET_NR_io_setup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 200)<br>
+#define TARGET_NR_io_destroy=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 201)<br>
+#define TARGET_NR_io_getevents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 202)<br>
+#define TARGET_NR_io_submit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 203)<br>
+#define TARGET_NR_io_cancel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 204)<br>
+#define TARGET_NR_exit_group=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 205)<br>
+#define TARGET_NR_lookup_dcookie=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 206)<br>
+#define TARGET_NR_epoll_create=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 207)<br>
+#define TARGET_NR_epoll_ctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 208)<br>
+#define TARGET_NR_epoll_wait=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 209)<br>
+#define TARGET_NR_remap_file_pages=C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Linux + =
210)<br>
+#define TARGET_NR_rt_sigreturn=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 211)<br>
+#define TARGET_NR_fcntl64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 212)<br>
+#define TARGET_NR_set_tid_address=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 213)<br>
+#define TARGET_NR_restart_syscall=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 214)<br>
+#define TARGET_NR_semtimedop=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 215)<br>
+#define TARGET_NR_fadvise64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 216)<br>
+#define TARGET_NR_statfs64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 217)<br>
+#define TARGET_NR_fstatfs64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 218)<br>
+#define TARGET_NR_sendfile64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 219)<br>
+#define TARGET_NR_timer_create=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 220)<br>
+#define TARGET_NR_timer_settime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 221)<br>
+#define TARGET_NR_timer_gettime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 222)<br>
+#define TARGET_NR_timer_getoverrun=C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Linux + =
223)<br>
+#define TARGET_NR_timer_delete=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 224)<br>
+#define TARGET_NR_clock_settime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 225)<br>
+#define TARGET_NR_clock_gettime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 226)<br>
+#define TARGET_NR_clock_getres=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 227)<br>
+#define TARGET_NR_clock_nanosleep=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 228)<br>
+#define TARGET_NR_tgkill=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 229)<br>
+#define TARGET_NR_utimes=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 230)<br>
+#define TARGET_NR_mbind=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 231)<br>
+#define TARGET_NR_get_mempolicy=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 232)<br>
+#define TARGET_NR_set_mempolicy=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 233)<br>
+#define TARGET_NR_mq_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 234)<br>
+#define TARGET_NR_mq_unlink=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 235)<br>
+#define TARGET_NR_mq_timedsend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 236)<br>
+#define TARGET_NR_mq_timedreceive=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 237)<br>
+#define TARGET_NR_mq_notify=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 238)<br>
+#define TARGET_NR_mq_getsetattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 239)<br>
+#define TARGET_NR_vserver=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 240)<br>
+#define TARGET_NR_waitid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 241)<br>
+/* #define TARGET_NR_sys_setaltroot=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
242) */<br>
+#define TARGET_NR_add_key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 243)<br>
+#define TARGET_NR_request_key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 244)<br>
+#define TARGET_NR_keyctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 245)<br>
+#define TARGET_NR_set_thread_area=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 246)<br>
+#define TARGET_NR_inotify_init=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 247)<br>
+#define TARGET_NR_inotify_add_watch=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
248)<br>
+#define TARGET_NR_inotify_rm_watch=C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Linux + =
249)<br>
+#define TARGET_NR_migrate_pages=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 250)<br>
+#define TARGET_NR_openat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 251)<br>
+#define TARGET_NR_mkdirat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 252)<br>
+#define TARGET_NR_mknodat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 253)<br>
+#define TARGET_NR_fchownat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 254)<br>
+#define TARGET_NR_futimesat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 255)<br>
+#define TARGET_NR_newfstatat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 256)<br>
+#define TARGET_NR_unlinkat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 257)<br>
+#define TARGET_NR_renameat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 258)<br>
+#define TARGET_NR_linkat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 259)<br>
+#define TARGET_NR_symlinkat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 260)<br>
+#define TARGET_NR_readlinkat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 261)<br>
+#define TARGET_NR_fchmodat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 262)<br>
+#define TARGET_NR_faccessat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 263)<br>
+#define TARGET_NR_pselect6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 264)<br>
+#define TARGET_NR_ppoll=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 265)<br>
+#define TARGET_NR_unshare=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 266)<br>
+#define TARGET_NR_splice=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 267)<br>
+#define TARGET_NR_sync_file_range=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 268)<br>
+#define TARGET_NR_tee=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + 269)<br>
+#define TARGET_NR_vmsplice=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 270)<br>
+#define TARGET_NR_move_pages=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 271)<br>
+#define TARGET_NR_set_robust_list=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 272)<br>
+#define TARGET_NR_get_robust_list=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 273)<br>
+#define TARGET_NR_kexec_load=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 274)<br>
+#define TARGET_NR_getcpu=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 275)<br>
+#define TARGET_NR_epoll_pwait=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 276)<br>
+#define TARGET_NR_ioprio_set=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 277)<br>
+#define TARGET_NR_ioprio_get=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 278)<br>
+#define TARGET_NR_utimensat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 279)<br>
+#define TARGET_NR_signalfd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 280)<br>
+#define TARGET_NR_timerfd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 281)<br>
+#define TARGET_NR_eventfd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 282)<br>
+#define TARGET_NR_fallocate=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 283)<br>
+#define TARGET_NR_timerfd_create=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 284)<br>
+#define TARGET_NR_timerfd_gettime=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 285)<br>
+#define TARGET_NR_timerfd_settime=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 286)<br>
+#define TARGET_NR_signalfd4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 287)<br>
+#define TARGET_NR_eventfd2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 288)<br>
+#define TARGET_NR_epoll_create1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 289)<br>
+#define TARGET_NR_dup3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 290)<br>
+#define TARGET_NR_pipe2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 291)<br>
+#define TARGET_NR_inotify_init1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 292)<br>
+#define TARGET_NR_preadv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 293)<br>
+#define TARGET_NR_pwritev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 294)<br>
+#define TARGET_NR_rt_tgsigqueueinfo=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
295)<br>
+#define TARGET_NR_perf_event_open=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 296)<br>
+#define TARGET_NR_accept4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 297)<br>
+#define TARGET_NR_recvmmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 298)<br>
+#define TARGET_NR_getdents64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 299)<br>
+#define TARGET_NR_fanotify_init=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 300)<br>
+#define TARGET_NR_fanotify_mark=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 301)<br>
+#define TARGET_NR_prlimit64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 302)<br>
+#define TARGET_NR_name_to_handle_at=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
303)<br>
+#define TARGET_NR_open_by_handle_at=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
304)<br>
+#define TARGET_NR_clock_adjtime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 305)<br>
+#define TARGET_NR_syncfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 306)<br>
+#define TARGET_NR_sendmmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 307)<br>
+#define TARGET_NR_setns=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 308)<br>
+#define TARGET_NR_process_vm_readv=C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Linux + =
309)<br>
+#define TARGET_NR_process_vm_writev=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
310)<br>
+#define TARGET_NR_kcmp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 311)<br>
+#define TARGET_NR_finit_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 312)<br>
+#define TARGET_NR_sched_setattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 313)<br>
+#define TARGET_NR_sched_getattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 314)<br>
+#define TARGET_NR_renameat2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 315)<br>
+#define TARGET_NR_seccomp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 316)<br>
+#define TARGET_NR_getrandom=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 317)<br>
+#define TARGET_NR_memfd_create=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 318)<br>
+#define TARGET_NR_bpf=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + 319)<br>
+#define TARGET_NR_execveat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 320)<br>
+#define TARGET_NR_userfaultfd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 321)<br>
+#define TARGET_NR_membarrier=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 322)<br>
+#define TARGET_NR_mlock2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 323)<br>
+#define TARGET_NR_copy_file_range=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 324)<br>
+#define TARGET_NR_preadv2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 325)<br>
+#define TARGET_NR_pwritev2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 326)<br>
+#define TARGET_NR_pkey_mprotect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 327)<br>
+#define TARGET_NR_pkey_alloc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 328)<br>
+#define TARGET_NR_pkey_free=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 329)<br>
+#define TARGET_NR_statx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 330)<br>
+#define TARGET_NR_rseq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 331)<br>
+#define TARGET_NR_io_pgetevents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 332)<br>
+/* 333 through 402 are unassigned to sync up with generic numbers */<br>
+#define TARGET_NR_clock_gettime64=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 403)<br>
+#define TARGET_NR_clock_settime64=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 404)<br>
+#define TARGET_NR_clock_adjtime64=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 405)<br>
+#define TARGET_NR_clock_getres_time64=C2=A0 =C2=A0(TARGET_NR_Linux + 406)<=
br>
+#define TARGET_NR_clock_nanosleep_<wbr>time64 (TARGET_NR_Linux + 407)<br>
+#define TARGET_NR_timer_gettime64=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 408)<br>
+#define TARGET_NR_timer_settime64=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 409)<br>
+#define TARGET_NR_timerfd_gettime64=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
410)<br>
+#define TARGET_NR_timerfd_settime64=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
411)<br>
+#define TARGET_NR_utimensat_time64=C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Linux + =
412)<br>
+#define TARGET_NR_pselect6_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 413)<br>
+#define TARGET_NR_ppoll_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 414)<br>
+#define TARGET_NR_io_pgetevents_<wbr>time64=C2=A0 (TARGET_NR_Linux + 416)<=
br>
+#define TARGET_NR_recvmmsg_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 417)<br>
+#define TARGET_NR_mq_timedsend_time64=C2=A0 =C2=A0(TARGET_NR_Linux + 418)<=
br>
+#define TARGET_NR_mq_timedreceive_<wbr>time64 (TARGET_NR_Linux + 419)<br>
+#define TARGET_NR_semtimedop_time64=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
420)<br>
+#define TARGET_NR_rt_sigtimedwait_<wbr>time64 (TARGET_NR_Linux + 421)<br>
+#define TARGET_NR_futex_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 422)<br>
+#define TARGET_NR_sched_rr_get_<wbr>interval_time64 (TARGET_NR_Linux + 423=
)<br>
+#define TARGET_NR_pidfd_send_signal=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
424)<br>
+#define TARGET_NR_io_uring_setup=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 425)<br>
+#define TARGET_NR_io_uring_enter=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 426)<br>
+#define TARGET_NR_io_uring_register=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
427)<br>
+#define TARGET_NR_open_tree=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 428)<br>
+#define TARGET_NR_move_mount=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 429)<br>
+#define TARGET_NR_fsopen=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 430)<br>
+#define TARGET_NR_fsconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 431)<br>
+#define TARGET_NR_fsmount=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 432)<br>
+#define TARGET_NR_fspick=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 433)<br>
+#define TARGET_NR_pidfd_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 434)<br>
+#define TARGET_NR_clone3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 435)<br>
+<br>
+#endif<br>
diff --git a/linux-user/mips64/syscall64_<wbr>nr.h b/linux-user/mips64/sysc=
all64_<wbr>nr.h<br>
new file mode 100644<br>
index 000000000000..bc1a0edf125f<br>
--- /dev/null<br>
+++ b/linux-user/mips64/syscall64_<wbr>nr.h<br>
@@ -0,0 +1,351 @@<br>
+#ifndef LINUX_USER_MIPS64_SYSCALL64_<wbr>NR_H<br>
+#define LINUX_USER_MIPS64_SYSCALL64_<wbr>NR_H<br>
+<br>
+/*<br>
+ * Linux 64-bit syscalls are in the range from 5000 to 5999.<br>
+ */<br>
+#define TARGET_NR_Linux=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A05000<br>
+#define TARGET_NR_read=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A00)<br>
+#define TARGET_NR_write=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A01)<br>
+#define TARGET_NR_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A02)<br>
+#define TARGET_NR_close=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A03)<br>
+#define TARGET_NR_stat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A04)<br>
+#define TARGET_NR_fstat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A05)<br>
+#define TARGET_NR_lstat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A06)<br>
+#define TARGET_NR_poll=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A07)<br>
+#define TARGET_NR_lseek=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A08)<br>
+#define TARGET_NR_mmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A09)<br>
+#define TARGET_NR_mprotect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 10)<br>
+#define TARGET_NR_munmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 11)<br>
+#define TARGET_NR_brk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 12)<br>
+#define TARGET_NR_rt_sigaction=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux +=C2=A0 13)<br>
+#define TARGET_NR_rt_sigprocmask=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux +=C2=A0 14)<br>
+#define TARGET_NR_ioctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 15)<br>
+#define TARGET_NR_pread64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 16)<br>
+#define TARGET_NR_pwrite64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 17)<br>
+#define TARGET_NR_readv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 18)<br>
+#define TARGET_NR_writev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 19)<br>
+#define TARGET_NR_access=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 20)<br>
+#define TARGET_NR_pipe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 21)<br>
+#define TARGET_NR__newselect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux +=C2=A0 22)<br>
+#define TARGET_NR_sched_yield=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux +=C2=A0 23)<br>
+#define TARGET_NR_mremap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 24)<br>
+#define TARGET_NR_msync=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 25)<br>
+#define TARGET_NR_mincore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 26)<br>
+#define TARGET_NR_madvise=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 27)<br>
+#define TARGET_NR_shmget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 28)<br>
+#define TARGET_NR_shmat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 29)<br>
+#define TARGET_NR_shmctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 30)<br>
+#define TARGET_NR_dup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 31)<br>
+#define TARGET_NR_dup2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 32)<br>
+#define TARGET_NR_pause=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 33)<br>
+#define TARGET_NR_nanosleep=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 34)<br>
+#define TARGET_NR_getitimer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 35)<br>
+#define TARGET_NR_setitimer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 36)<br>
+#define TARGET_NR_alarm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 37)<br>
+#define TARGET_NR_getpid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 38)<br>
+#define TARGET_NR_sendfile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 39)<br>
+#define TARGET_NR_socket=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 40)<br>
+#define TARGET_NR_connect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 41)<br>
+#define TARGET_NR_accept=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 42)<br>
+#define TARGET_NR_sendto=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 43)<br>
+#define TARGET_NR_recvfrom=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 44)<br>
+#define TARGET_NR_sendmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 45)<br>
+#define TARGET_NR_recvmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 46)<br>
+#define TARGET_NR_shutdown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 47)<br>
+#define TARGET_NR_bind=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 48)<br>
+#define TARGET_NR_listen=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 49)<br>
+#define TARGET_NR_getsockname=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux +=C2=A0 50)<br>
+#define TARGET_NR_getpeername=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux +=C2=A0 51)<br>
+#define TARGET_NR_socketpair=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux +=C2=A0 52)<br>
+#define TARGET_NR_setsockopt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux +=C2=A0 53)<br>
+#define TARGET_NR_getsockopt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux +=C2=A0 54)<br>
+#define TARGET_NR_clone=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 55)<br>
+#define TARGET_NR_fork=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 56)<br>
+#define TARGET_NR_execve=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 57)<br>
+#define TARGET_NR_exit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 58)<br>
+#define TARGET_NR_wait4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 59)<br>
+#define TARGET_NR_kill=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 60)<br>
+#define TARGET_NR_uname=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 61)<br>
+#define TARGET_NR_semget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 62)<br>
+#define TARGET_NR_semop=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 63)<br>
+#define TARGET_NR_semctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 64)<br>
+#define TARGET_NR_shmdt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 65)<br>
+#define TARGET_NR_msgget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 66)<br>
+#define TARGET_NR_msgsnd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 67)<br>
+#define TARGET_NR_msgrcv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 68)<br>
+#define TARGET_NR_msgctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 69)<br>
+#define TARGET_NR_fcntl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 70)<br>
+#define TARGET_NR_flock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 71)<br>
+#define TARGET_NR_fsync=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 72)<br>
+#define TARGET_NR_fdatasync=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 73)<br>
+#define TARGET_NR_truncate=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 74)<br>
+#define TARGET_NR_ftruncate=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 75)<br>
+#define TARGET_NR_getdents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 76)<br>
+#define TARGET_NR_getcwd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 77)<br>
+#define TARGET_NR_chdir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 78)<br>
+#define TARGET_NR_fchdir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 79)<br>
+#define TARGET_NR_rename=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 80)<br>
+#define TARGET_NR_mkdir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 81)<br>
+#define TARGET_NR_rmdir=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 82)<br>
+#define TARGET_NR_creat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 83)<br>
+#define TARGET_NR_link=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 84)<br>
+#define TARGET_NR_unlink=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 85)<br>
+#define TARGET_NR_symlink=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 86)<br>
+#define TARGET_NR_readlink=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 87)<br>
+#define TARGET_NR_chmod=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 88)<br>
+#define TARGET_NR_fchmod=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 89)<br>
+#define TARGET_NR_chown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 90)<br>
+#define TARGET_NR_fchown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 91)<br>
+#define TARGET_NR_lchown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 92)<br>
+#define TARGET_NR_umask=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 93)<br>
+#define TARGET_NR_gettimeofday=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux +=C2=A0 94)<br>
+#define TARGET_NR_getrlimit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 95)<br>
+#define TARGET_NR_getrusage=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 96)<br>
+#define TARGET_NR_sysinfo=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 97)<br>
+#define TARGET_NR_times=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 98)<br>
+#define TARGET_NR_ptrace=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 99)<br>
+#define TARGET_NR_getuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 100)<br>
+#define TARGET_NR_syslog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 101)<br>
+#define TARGET_NR_getgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 102)<br>
+#define TARGET_NR_setuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 103)<br>
+#define TARGET_NR_setgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 104)<br>
+#define TARGET_NR_geteuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 105)<br>
+#define TARGET_NR_getegid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 106)<br>
+#define TARGET_NR_setpgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 107)<br>
+#define TARGET_NR_getppid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 108)<br>
+#define TARGET_NR_getpgrp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 109)<br>
+#define TARGET_NR_setsid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 110)<br>
+#define TARGET_NR_setreuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 111)<br>
+#define TARGET_NR_setregid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 112)<br>
+#define TARGET_NR_getgroups=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 113)<br>
+#define TARGET_NR_setgroups=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 114)<br>
+#define TARGET_NR_setresuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 115)<br>
+#define TARGET_NR_getresuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 116)<br>
+#define TARGET_NR_setresgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 117)<br>
+#define TARGET_NR_getresgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 118)<br>
+#define TARGET_NR_getpgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 119)<br>
+#define TARGET_NR_setfsuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 120)<br>
+#define TARGET_NR_setfsgid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 121)<br>
+#define TARGET_NR_getsid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 122)<br>
+#define TARGET_NR_capget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 123)<br>
+#define TARGET_NR_capset=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 124)<br>
+#define TARGET_NR_rt_sigpending=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 125)<br>
+#define TARGET_NR_rt_sigtimedwait=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 126)<br>
+#define TARGET_NR_rt_sigqueueinfo=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 127)<br>
+#define TARGET_NR_rt_sigsuspend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 128)<br>
+#define TARGET_NR_sigaltstack=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 129)<br>
+#define TARGET_NR_utime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 130)<br>
+#define TARGET_NR_mknod=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 131)<br>
+#define TARGET_NR_personality=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 132)<br>
+#define TARGET_NR_ustat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 133)<br>
+#define TARGET_NR_statfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 134)<br>
+#define TARGET_NR_fstatfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 135)<br>
+#define TARGET_NR_sysfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 136)<br>
+#define TARGET_NR_getpriority=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 137)<br>
+#define TARGET_NR_setpriority=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 138)<br>
+#define TARGET_NR_sched_setparam=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 139)<br>
+#define TARGET_NR_sched_getparam=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 140)<br>
+#define TARGET_NR_sched_setscheduler=C2=A0 =C2=A0 (TARGET_NR_Linux + 141)<=
br>
+#define TARGET_NR_sched_getscheduler=C2=A0 =C2=A0 (TARGET_NR_Linux + 142)<=
br>
+#define TARGET_NR_sched_get_priority_<wbr>max (TARGET_NR_Linux + 143)<br>
+#define TARGET_NR_sched_get_priority_<wbr>min (TARGET_NR_Linux + 144)<br>
+#define TARGET_NR_sched_rr_get_<wbr>interval (TARGET_NR_Linux + 145)<br>
+#define TARGET_NR_mlock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 146)<br>
+#define TARGET_NR_munlock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 147)<br>
+#define TARGET_NR_mlockall=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 148)<br>
+#define TARGET_NR_munlockall=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 149)<br>
+#define TARGET_NR_vhangup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 150)<br>
+#define TARGET_NR_pivot_root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 151)<br>
+#define TARGET_NR__sysctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 152)<br>
+#define TARGET_NR_prctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 153)<br>
+#define TARGET_NR_adjtimex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 154)<br>
+#define TARGET_NR_setrlimit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 155)<br>
+#define TARGET_NR_chroot=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 156)<br>
+#define TARGET_NR_sync=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 157)<br>
+#define TARGET_NR_acct=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 158)<br>
+#define TARGET_NR_settimeofday=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 159)<br>
+#define TARGET_NR_mount=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 160)<br>
+#define TARGET_NR_umount2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 161)<br>
+#define TARGET_NR_swapon=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 162)<br>
+#define TARGET_NR_swapoff=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 163)<br>
+#define TARGET_NR_reboot=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 164)<br>
+#define TARGET_NR_sethostname=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 165)<br>
+#define TARGET_NR_setdomainname=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 166)<br>
+#define TARGET_NR_create_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 167)<br>
+#define TARGET_NR_init_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 168)<br>
+#define TARGET_NR_delete_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 169)<br>
+#define TARGET_NR_get_kernel_syms=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 170)<br>
+#define TARGET_NR_query_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 171)<br>
+#define TARGET_NR_quotactl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 172)<br>
+#define TARGET_NR_nfsservctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 173)<br>
+#define TARGET_NR_getpmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 174)<br>
+#define TARGET_NR_putpmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 175)<br>
+#define TARGET_NR_afs_syscall=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 176)<br>
+#define TARGET_NR_reserved177=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 177)<br>
+#define TARGET_NR_gettid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 178)<br>
+#define TARGET_NR_readahead=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 179)<br>
+#define TARGET_NR_setxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 180)<br>
+#define TARGET_NR_lsetxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 181)<br>
+#define TARGET_NR_fsetxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 182)<br>
+#define TARGET_NR_getxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 183)<br>
+#define TARGET_NR_lgetxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 184)<br>
+#define TARGET_NR_fgetxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 185)<br>
+#define TARGET_NR_listxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 186)<br>
+#define TARGET_NR_llistxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 187)<br>
+#define TARGET_NR_flistxattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 188)<br>
+#define TARGET_NR_removexattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 189)<br>
+#define TARGET_NR_lremovexattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 190)<br>
+#define TARGET_NR_fremovexattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 191)<br>
+#define TARGET_NR_tkill=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 192)<br>
+#define TARGET_NR_reserved193=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 193)<br>
+#define TARGET_NR_futex=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 194)<br>
+#define TARGET_NR_sched_setaffinity=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
195)<br>
+#define TARGET_NR_sched_getaffinity=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
196)<br>
+#define TARGET_NR_cacheflush=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 197)<br>
+#define TARGET_NR_cachectl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 198)<br>
+#define TARGET_NR_sysmips=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 199)<br>
+#define TARGET_NR_io_setup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 200)<br>
+#define TARGET_NR_io_destroy=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 201)<br>
+#define TARGET_NR_io_getevents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 202)<br>
+#define TARGET_NR_io_submit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 203)<br>
+#define TARGET_NR_io_cancel=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 204)<br>
+#define TARGET_NR_exit_group=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 205)<br>
+#define TARGET_NR_lookup_dcookie=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 206)<br>
+#define TARGET_NR_epoll_create=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 207)<br>
+#define TARGET_NR_epoll_ctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 208)<br>
+#define TARGET_NR_epoll_wait=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 209)<br>
+#define TARGET_NR_remap_file_pages=C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Linux + =
210)<br>
+#define TARGET_NR_rt_sigreturn=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 211)<br>
+#define TARGET_NR_set_tid_address=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 212)<br>
+#define TARGET_NR_restart_syscall=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 213)<br>
+#define TARGET_NR_semtimedop=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 214)<br>
+#define TARGET_NR_fadvise64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 215)<br>
+#define TARGET_NR_timer_create=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 216)<br>
+#define TARGET_NR_timer_settime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 217)<br>
+#define TARGET_NR_timer_gettime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 218)<br>
+#define TARGET_NR_timer_getoverrun=C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Linux + =
219)<br>
+#define TARGET_NR_timer_delete=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 220)<br>
+#define TARGET_NR_clock_settime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 221)<br>
+#define TARGET_NR_clock_gettime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 222)<br>
+#define TARGET_NR_clock_getres=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 223)<br>
+#define TARGET_NR_clock_nanosleep=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 224)<br>
+#define TARGET_NR_tgkill=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 225)<br>
+#define TARGET_NR_utimes=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 226)<br>
+#define TARGET_NR_mbind=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 227)<br>
+#define TARGET_NR_get_mempolicy=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 228)<br>
+#define TARGET_NR_set_mempolicy=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 229)<br>
+#define TARGET_NR_mq_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 230)<br>
+#define TARGET_NR_mq_unlink=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 231)<br>
+#define TARGET_NR_mq_timedsend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 232)<br>
+#define TARGET_NR_mq_timedreceive=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 233)<br>
+#define TARGET_NR_mq_notify=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 234)<br>
+#define TARGET_NR_mq_getsetattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 235)<br>
+#define TARGET_NR_vserver=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 236)<br>
+#define TARGET_NR_waitid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 237)<br>
+/* #define TARGET_NR_sys_setaltroot=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
238) */<br>
+#define TARGET_NR_add_key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 239)<br>
+#define TARGET_NR_request_key=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 240)<br>
+#define TARGET_NR_keyctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 241)<br>
+#define TARGET_NR_set_thread_area=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 242)<br>
+#define TARGET_NR_inotify_init=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 243)<br>
+#define TARGET_NR_inotify_add_watch=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
244)<br>
+#define TARGET_NR_inotify_rm_watch=C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Linux + =
245)<br>
+#define TARGET_NR_migrate_pages=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 246)<br>
+#define TARGET_NR_openat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 247)<br>
+#define TARGET_NR_mkdirat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 248)<br>
+#define TARGET_NR_mknodat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 249)<br>
+#define TARGET_NR_fchownat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 250)<br>
+#define TARGET_NR_futimesat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 251)<br>
+#define TARGET_NR_newfstatat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 252)<br>
+#define TARGET_NR_unlinkat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 253)<br>
+#define TARGET_NR_renameat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 254)<br>
+#define TARGET_NR_linkat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 255)<br>
+#define TARGET_NR_symlinkat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 256)<br>
+#define TARGET_NR_readlinkat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 257)<br>
+#define TARGET_NR_fchmodat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 258)<br>
+#define TARGET_NR_faccessat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 259)<br>
+#define TARGET_NR_pselect6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 260)<br>
+#define TARGET_NR_ppoll=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 261)<br>
+#define TARGET_NR_unshare=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 262)<br>
+#define TARGET_NR_splice=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 263)<br>
+#define TARGET_NR_sync_file_range=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 264)<br>
+#define TARGET_NR_tee=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + 265)<br>
+#define TARGET_NR_vmsplice=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 266)<br>
+#define TARGET_NR_move_pages=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 267)<br>
+#define TARGET_NR_set_robust_list=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 268)<br>
+#define TARGET_NR_get_robust_list=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 269)<br>
+#define TARGET_NR_kexec_load=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 270)<br>
+#define TARGET_NR_getcpu=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 271)<br>
+#define TARGET_NR_epoll_pwait=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 272)<br>
+#define TARGET_NR_ioprio_set=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 273)<br>
+#define TARGET_NR_ioprio_get=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 274)<br>
+#define TARGET_NR_utimensat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 275)<br>
+#define TARGET_NR_signalfd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 276)<br>
+#define TARGET_NR_timerfd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 277)<br>
+#define TARGET_NR_eventfd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 278)<br>
+#define TARGET_NR_fallocate=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 279)<br>
+#define TARGET_NR_timerfd_create=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 280)<br>
+#define TARGET_NR_timerfd_gettime=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 281)<br>
+#define TARGET_NR_timerfd_settime=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 282)<br>
+#define TARGET_NR_signalfd4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 283)<br>
+#define TARGET_NR_eventfd2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 284)<br>
+#define TARGET_NR_epoll_create1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 285)<br>
+#define TARGET_NR_dup3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 286)<br>
+#define TARGET_NR_pipe2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 287)<br>
+#define TARGET_NR_inotify_init1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 288)<br>
+#define TARGET_NR_preadv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 289)<br>
+#define TARGET_NR_pwritev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 290)<br>
+#define TARGET_NR_rt_tgsigqueueinfo=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
291)<br>
+#define TARGET_NR_perf_event_open=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 292)<br>
+#define TARGET_NR_accept4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 293)<br>
+#define TARGET_NR_recvmmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 294)<br>
+#define TARGET_NR_fanotify_init=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 295)<br>
+#define TARGET_NR_fanotify_mark=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 296)<br>
+#define TARGET_NR_prlimit64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 297)<br>
+#define TARGET_NR_name_to_handle_at=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
298)<br>
+#define TARGET_NR_open_by_handle_at=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
299)<br>
+#define TARGET_NR_clock_adjtime=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 300)<br>
+#define TARGET_NR_syncfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 301)<br>
+#define TARGET_NR_sendmmsg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 302)<br>
+#define TARGET_NR_setns=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 303)<br>
+#define TARGET_NR_process_vm_readv=C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Linux + =
304)<br>
+#define TARGET_NR_process_vm_writev=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
305)<br>
+#define TARGET_NR_kcmp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 306)<br>
+#define TARGET_NR_finit_module=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 307)<br>
+#define TARGET_NR_getdents64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 308)<br>
+#define TARGET_NR_sched_setattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 309)<br>
+#define TARGET_NR_sched_getattr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 310)<br>
+#define TARGET_NR_renameat2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 311)<br>
+#define TARGET_NR_seccomp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 312)<br>
+#define TARGET_NR_getrandom=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 313)<br>
+#define TARGET_NR_memfd_create=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux + 314)<br>
+#define TARGET_NR_bpf=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + 315)<br>
+#define TARGET_NR_execveat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 316)<br>
+#define TARGET_NR_userfaultfd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux + 317)<br>
+#define TARGET_NR_membarrier=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 318)<br>
+#define TARGET_NR_mlock2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 319)<br>
+#define TARGET_NR_copy_file_range=C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_NR_Lin=
ux + 320)<br>
+#define TARGET_NR_preadv2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 321)<br>
+#define TARGET_NR_pwritev2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 322)<br>
+#define TARGET_NR_pkey_mprotect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 323)<br>
+#define TARGET_NR_pkey_alloc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 324)<br>
+#define TARGET_NR_pkey_free=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 325)<br>
+#define TARGET_NR_statx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux + 326)<br>
+#define TARGET_NR_rseq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux + 327)<br>
+#define TARGET_NR_io_pgetevents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TARGET_N=
R_Linux + 328)<br>
+/* 329 through 423 are reserved to sync up with other architectures */<br>
+#define TARGET_NR_pidfd_send_signal=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
424)<br>
+#define TARGET_NR_io_uring_setup=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 425)<br>
+#define TARGET_NR_io_uring_enter=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux + 426)<br>
+#define TARGET_NR_io_uring_register=C2=A0 =C2=A0 =C2=A0(TARGET_NR_Linux + =
427)<br>
+#define TARGET_NR_open_tree=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux + 428)<br>
+#define TARGET_NR_move_mount=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 429)<br>
+#define TARGET_NR_fsopen=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 430)<br>
+#define TARGET_NR_fsconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux + 431)<br>
+#define TARGET_NR_fsmount=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux + 432)<br>
+#define TARGET_NR_fspick=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 433)<br>
+#define TARGET_NR_pidfd_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux + 434)<br>
+#define TARGET_NR_clone3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux + 435)<br>
+<br>
+#endif<br>
diff --git a/linux-user/mips64/syscall_<wbr>nr.h b/linux-user/mips64/syscal=
l_<wbr>nr.h<br>
index 6e23e9fcdb0c..85651dfced1b 100644<br>
--- a/linux-user/mips64/syscall_<wbr>nr.h<br>
+++ b/linux-user/mips64/syscall_<wbr>nr.h<br>
@@ -2,724 +2,9 @@<br>
=C2=A0#define LINUX_USER_MIPS64_SYSCALL_NR_H<br>
<br>
=C2=A0#ifdef TARGET_ABI32<br>
-/*<br>
- * Linux N32 syscalls are in the range from 6000 to 6999.<br>
- */<br>
-#define TARGET_NR_Linux=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A06000<br>
-#define TARGET_NR_read=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A00)<br>
-#define TARGET_NR_write=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A01)<br>
-#define TARGET_NR_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A02)<br>
-#define TARGET_NR_close=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A03)<br>
-#define TARGET_NR_stat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A04)<br>
-#define TARGET_NR_fstat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A05)<br>
-#define TARGET_NR_lstat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A06)<br>
-#define TARGET_NR_poll=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A07)<br>
-#define TARGET_NR_lseek=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 =C2=A08)<br>
-#define TARGET_NR_mmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 =C2=A09)<br>
-#define TARGET_NR_mprotect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 10)<br>
-#define TARGET_NR_munmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 11)<br>
-#define TARGET_NR_brk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 12)<br>
-#define TARGET_NR_rt_sigaction=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_N=
R_Linux +=C2=A0 13)<br>
-#define TARGET_NR_rt_sigprocmask=C2=A0 =C2=A0 =C2=A0 =C2=A0 (TARGET_NR_Lin=
ux +=C2=A0 14)<br>
-#define TARGET_NR_ioctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 15)<br>
-#define TARGET_NR_pread64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 16)<br>
-#define TARGET_NR_pwrite64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (TARGET_NR_Linux +=C2=A0 17)<br>
-#define TARGET_NR_readv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 18)<br>
-#define TARGET_NR_writev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 19)<br>
-#define TARGET_NR_access=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 20)<br>
-#define TARGET_NR_pipe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 21)<br>
-#define TARGET_NR__newselect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (TAR=
GET_NR_Linux +=C2=A0 22)<br>
-#define TARGET_NR_sched_yield=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TAR=
GET_NR_Linux +=C2=A0 23)<br>
-#define TARGET_NR_mremap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 24)<br>
-#define TARGET_NR_msync=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 25)<br>
-#define TARGET_NR_mincore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 26)<br>
-#define TARGET_NR_madvise=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(TARGET_NR_Linux +=C2=A0 27)<br>
-#define TARGET_NR_shmget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 28)<br>
-#define TARGET_NR_shmat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 29)<br>
-#define TARGET_NR_shmctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (TARGET_NR_Linux +=C2=A0 30)<br>
-#define TARGET_NR_dup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 31)<br>
-#define TARGET_NR_dup2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (TARGET_NR_Linux +=C2=A0 32)<br>
-#define TARGET_NR_pause=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(TARGET_NR_Linux +=C2=A0 33)<br>
-#define TARGET_NR_nanosleep=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TARGET_NR_Linux +=C2=A0 34)<br>
-#define TARGET_NR_getitimer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-- <br>
2.24.1<br>
<br>
<br>
</blockquote>

--000000000000b21910059edd5daa--

