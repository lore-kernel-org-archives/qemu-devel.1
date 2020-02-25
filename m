Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E6C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1E022464
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1E022464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ylg-0002AX-4H
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j6Yjz-00009n-IR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j6Yjv-00051I-VZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:07 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:58649)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j6Yjo-0004aT-9y; Tue, 25 Feb 2020 06:50:56 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MRmwM-1j0bPh3vhq-00TAxC; Tue, 25 Feb 2020 12:50:48 +0100
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1582586444.git.alistair.francis@wdc.com>
 <85f33856ee6f32125e5c81a9561346b28b340a3e.1582586444.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 2/2] linux-user/riscv: Update the syscall_nr's to the
 5.5 kernel
Message-ID: <24431d59-b535-97d4-95d7-fe4401e10787@vivier.eu>
Date: Tue, 25 Feb 2020 12:50:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <85f33856ee6f32125e5c81a9561346b28b340a3e.1582586444.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FIufnv1rhz7E1+H8VSn54aocjcTgXDaOpBotsU5jwu2uh7lvm8m
 lL9yiebAqYrb0ryRfwOmpVO4GR7dlJKWll/vYoLB7JMSn5XYSTWLDFEgba0u5sLajd7DrU0
 U8e3FTXpQmOdadHEzRf/rW+Smz/DE+xYhkq3ir9rshSiX4ztFS5VFkThK7v0AZpkP2vDid6
 3mR/bvp2+t82UR+NdyWSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PXXhXhA9HHc=:EYoqOO+PEUGfUhozqtRnHj
 uFtJ8A/WrNefTg8njqojVCbUKgDqlPlyPBU1BvAH7yO2IkWqOvGom5wgBMMIcOQEPVbzfWj/R
 GUKCF43xlIOmA701oinMntKi22L77z2EBRH5m5mW6ttr+Z2A2cxVCCBIac486c7b1Ao35KntX
 yqnkTlJJKlmvTIW4nwKFnJzH1pW6r1EXy/d82EtRcfKc5IVktxH1G1wGo5K9xAHw3dWvH6pn/
 RzuIZfY9NcrudIR8Y11czjs/s4m3mSkk2DIxjnaJh4oB1G/iCjL5ACSfESZc9GBX+6QK4t+9f
 gF0uzekRUl/ax1FSjuVl7DTshX8+1fFAaVXHFlTPCJy0JeLZFWeBIeTQGcK1fELNh+dMsQF2q
 cTrw3M7xzYgTNpDVCkIWbM14vBf28Scjumeuqx8WjLquP9ibv+Vm/M9sjRGZWUIEjvldn1xVV
 t/X2UNtQV9CBtPIfDdertlKbjqhKfUB6n7zVpSAgAj/bbjBzn3FmCTzCM8esg5on0hOYCqSzM
 AxA7L2BX+dyTIDXXC1Pq2tGfMDOgFWvoEHF6OKK4L6w/wvsQexW+YoC9QSJbi1KcdPJj+dSM7
 oTuM7er9WhWofIqbssDnvmnO2Tj3sX392PIXrI3TRSjb0rByVKp1li6H9nTuVZODxGxu/HsWC
 pTIc+kzV2tH3LKG+Ei45fZjIesYdDqICbJG3t3b3DxPhryGeUp1lkZhsCXHyoICbVV0K086aG
 lPsQcKAuKFlYVYOOXxBkW3Nj+xYP/0Ua9vbOPqCFDENbz7S5efwSPBmv6wqV2drDWqOuKMVgU
 mamMfsjoXXYCZX1t8/Gdyg1BESXm1/x2x17hh2jnuPHJPo1NrwCj/x+FkeGp+EpGDDxIzY+
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/02/2020 à 00:21, Alistair Francis a écrit :
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/riscv/syscall32_nr.h | 314 ++++++++++++++++++++++++++++++++
>  linux-user/riscv/syscall64_nr.h | 303 ++++++++++++++++++++++++++++++
>  linux-user/riscv/syscall_nr.h   | 294 +-----------------------------
>  3 files changed, 619 insertions(+), 292 deletions(-)
>  create mode 100644 linux-user/riscv/syscall32_nr.h
>  create mode 100644 linux-user/riscv/syscall64_nr.h
> 
> diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_nr.h
> new file mode 100644
> index 0000000000..c3bf5930d0
> --- /dev/null
> +++ b/linux-user/riscv/syscall32_nr.h
> @@ -0,0 +1,314 @@
> +/*
> + * Syscall numbers from asm-generic for RV32.
> + */
> +
> +#ifndef LINUX_USER_RISCV_SYSCALL32_NR_H
> +#define LINUX_USER_RISCV_SYSCALL32_NR_H
> +
> +#define TARGET_NR_io_setup 0
> +#define TARGET_NR_io_destroy 1
> +#define TARGET_NR_io_submit 2
> +#define TARGET_NR_io_cancel 3
> +#define TARGET_NR_setxattr 5
> +#define TARGET_NR_lsetxattr 6
> +#define TARGET_NR_fsetxattr 7
> +#define TARGET_NR_getxattr 8
> +#define TARGET_NR_lgetxattr 9
> +#define TARGET_NR_fgetxattr 10
> +#define TARGET_NR_listxattr 11
> +#define TARGET_NR_llistxattr 12
> +#define TARGET_NR_flistxattr 13
> +#define TARGET_NR_removexattr 14
> +#define TARGET_NR_lremovexattr 15
> +#define TARGET_NR_fremovexattr 16
> +#define TARGET_NR_getcwd 17
> +#define TARGET_NR_lookup_dcookie 18
> +#define TARGET_NR_eventfd2 19
> +#define TARGET_NR_epoll_create1 20
> +#define TARGET_NR_epoll_ctl 21
> +#define TARGET_NR_epoll_pwait 22
> +#define TARGET_NR_dup 23
> +#define TARGET_NR_dup3 24
> +#define TARGET_NR_fcntl64 25
> +#define TARGET_NR_inotify_init1 26
> +#define TARGET_NR_inotify_add_watch 27
> +#define TARGET_NR_inotify_rm_watch 28
> +#define TARGET_NR_ioctl 29
> +#define TARGET_NR_ioprio_set 30
> +#define TARGET_NR_ioprio_get 31
> +#define TARGET_NR_flock 32
> +#define TARGET_NR_mknodat 33
> +#define TARGET_NR_mkdirat 34
> +#define TARGET_NR_unlinkat 35
> +#define TARGET_NR_symlinkat 36
> +#define TARGET_NR_linkat 37
> +#define TARGET_NR_umount2 39
> +#define TARGET_NR_mount 40
> +#define TARGET_NR_pivot_root 41
> +#define TARGET_NR_nfsservctl 42
> +#define TARGET_NR_statfs 43
> +#define TARGET_NR_fstatfs 44
> +#define TARGET_NR_truncate 45
> +#define TARGET_NR_ftruncate 46

For riscv32, it's the 64bit version name to use:

#define TARGET_NR_statfs64 43
#define TARGET_NR_fstatfs64 44
#define TARGET_NR_truncate64 45
#define TARGET_NR_ftruncate64 46
(and below)

because:

include/uapi/asm-generic/unistd.h

#if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
...
#else
#define __NR_fcntl64 __NR3264_fcntl
#define __NR_statfs64 __NR3264_statfs
#define __NR_fstatfs64 __NR3264_fstatfs
#define __NR_truncate64 __NR3264_truncate
#define __NR_ftruncate64 __NR3264_ftruncate
#define __NR_llseek __NR3264_lseek
#define __NR_sendfile64 __NR3264_sendfile
#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
#define __NR_fstatat64 __NR3264_fstatat
#define __NR_fstat64 __NR3264_fstat
#endif
...

arch/riscv/include/uapi/asm/unistd.h
#define __ARCH_WANT_NEW_STAT

arch/riscv/include/uapi/asm/bitsperlong.h

#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)

...
> +#define TARGET_NR_getdents64 61
> +#define TARGET_NR__llseek 62

TARGET_NR_llseek

> +#define TARGET_NR_read 63
> +#define TARGET_NR_write 64
> +#define TARGET_NR_readv 65
> +#define TARGET_NR_writev 66
> +#define TARGET_NR_pread64 67
> +#define TARGET_NR_pwrite64 68
> +#define TARGET_NR_preadv 69
> +#define TARGET_NR_pwritev 70
> +#define TARGET_NR_sendfile 71

TARGET_NR_sendfile64

> +#define TARGET_NR_signalfd4 74
> +#define TARGET_NR_vmsplice 75
> +#define TARGET_NR_splice 76
> +#define TARGET_NR_tee 77
> +#define TARGET_NR_readlinkat 78
> +#define TARGET_NR_newfstatat 79
> +#define TARGET_NR_fstat 80

#define TARGET_NR_fstatat64 79
#define TARGET_NR_fstat64 80

...
> +#define TARGET_NR_sethostname 161
> +#define TARGET_NR_setdomainname 162

#define TARGET_NR_getrlimit 163
#define TARGET_NR_setrlimit 164

because

include/uapi/asm-generic/unistd.h

#ifdef __ARCH_WANT_SET_GET_RLIMIT
/* getrlimit and setrlimit are superseded with prlimit64 */
#define __NR_getrlimit 163
__SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
#define __NR_setrlimit 164
__SC_COMP(__NR_setrlimit, sys_setrlimit, compat_sys_setrlimit)
#endif

arch/riscv/include/uapi/asm/unistd.h

#define __ARCH_WANT_SET_GET_RLIMIT

...
> +#define TARGET_NR_arch_specific_syscall 244
> +#define TARGET_NR_riscv_flush_icache TARGET_NR_arch_specific_syscall + 15

It should be good to keep parenthesis around the declaration:

(TARGET_NR_arch_specific_syscall + 15)

...

I think you can remove following defintion as they should be translated
by the target glibc.

> +/*
> + * Alias some of the older pre 64-bit time_t syscalls to the 64-bit
> + * ones for RV32. This is based on the list used by glibc.
> + */
> +#define TARGET_NR_futex TARGET_NR_futex_time64
> +#define TARGET_NR_rt_sigtimedwait TARGET_NR_rt_sigtimedwait_time64
> +#define TARGET_NR_ppoll TARGET_NR_ppoll_time64
> +#define TARGET_NR_utimensat TARGET_NR_utimensat_time64
> +#define TARGET_NR_pselect6 TARGET_NR_pselect6_time64
> +#define TARGET_NR_recvmmsg TARGET_NR_recvmmsg_time64
> +#define TARGET_NR_semtimedop TARGET_NR_semtimedop_time64
> +#define TARGET_NR_mq_timedreceive TARGET_NR_mq_timedreceive_time64
> +#define TARGET_NR_mq_timedsend TARGET_NR_mq_timedsend_time64
> +#define TARGET_NR_clock_getres TARGET_NR_clock_getres_time64
> +#define TARGET_NR_timerfd_settime TARGET_NR_timerfd_settime64
> +#define TARGET_NR_timerfd_gettime TARGET_NR_timerfd_gettime64
> +#define TARGET_NR_sched_rr_get_interval TARGET_NR_sched_rr_get_interval_time64
> +#define TARGET_NR_clock_adjtime TARGET_NR_clock_adjtime64
> +
> +#endif
> diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_nr.h
> new file mode 100644
> index 0000000000..b58364b570
> --- /dev/null
> +++ b/linux-user/riscv/syscall64_nr.h

syscall64_nr.h is correct.

Thanks,
Laurent


