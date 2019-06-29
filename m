Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394A8C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 00:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7C42083B
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 00:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWKDjfqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7C42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hh1dL-0006kM-0g
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 20:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37826)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hh1ch-0006JE-Ki
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 20:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hh1ce-0000cD-D5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 20:53:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hh1ce-0000SR-0b
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 20:53:44 -0400
Received: by mail-ot1-x344.google.com with SMTP id b7so7765314otl.11
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=FQho6QrYDa2IS9yIinBdmb551EtmRWGcopEKSFUvM98=;
 b=lWKDjfqTytgwWJF+wuGoFNWE5SwB6acD8r6HdxRNnFtOtlVdc4Hq0S/ujbdBASacX6
 watq7ufLGxe30WjuX8v4LECR4Q57DCNRHnyYEHj7QxPYHAqadpA67IWq9Ce1sptJQMC3
 GSTPkyMd52/hRTGF9/7a1zCSWG9WNp8T4eFRFYEPHr05u50bMVoddKIGq77bms255v+I
 +esD3PRGl5D66NE1PmgHPn2HIZvZ9tXtf1zKEu1evytLp0ttUi8IQkjY21zJUSJ/AQxH
 nwFL5GEFvej8ECHtPAIb7n7+n8L//821GVmTZnpCxemw5XULaq3JmHUoAmFDzVf+yQ1S
 mIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=FQho6QrYDa2IS9yIinBdmb551EtmRWGcopEKSFUvM98=;
 b=R1KDyY0O84ad/+UYiVEWHvrOuraar5rky6qyUnoFANT5h/aaOkYVL4J1NaBgOt9H4k
 jDgS1a0JwaJKKgjKHnAMepCwP/+UoUYDixEZf13YsAMLXJEZbd3htZuBtj28AFz+/sED
 lkMNSpoUl4WCJaZQalFYN3Hw3u8DhZLwbxRAK6TbwT0Xh0CBT6RwEeK/ANbig7MV+hA/
 +8QyVXlufVt7Ds8YjkI/iqE5cIIMINe6GdE54akz1U0tUeQW5+ao3S0L4giiLFmR1EkA
 79OfKgtywpeWRXqTRxwJ0EVxNc5VCTjh1zupnTKmc/UADyWyDWC4wF44duRiIOG+g0dQ
 pkJw==
X-Gm-Message-State: APjAAAWsF4p0gojL/BnMV2bq789vB0YfRgeA/m757HVKdRd3YozGbmyG
 1Ef0f86EXNwrqH6iImb42h33XO8drNGIWnKqFoM=
X-Google-Smtp-Source: APXvYqz9z5KGyuYkqfd+4Ie3wMMTiBZla5osG0EWd/nfKnxJ3gxpnfoL5RRCjx+XtjFW+GyZx7IYLlAGG6JOGP8jqrM=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr10954109otr.295.1561769611342; 
 Fri, 28 Jun 2019 17:53:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 28 Jun 2019 17:53:30
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 28 Jun 2019 17:53:30
 -0700 (PDT)
In-Reply-To: <1561718618-20218-2-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561718618-20218-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561718618-20218-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 29 Jun 2019 02:53:30 +0200
Message-ID: <CAL1e-=gMvPy9SEQicj1d=X0cSu84WuiNXbtacOS5zJoqyXQv+A@mail.gmail.com>
To: jimw@sifive.com, aleksandar.markovic@rt-rk.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v16 1/5] linux-user: Add support for
 translation of statx() syscall
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, Jim.

On Jun 28, 2019 12:51 PM, "Aleksandar Markovic" <
aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
>
> Implement support for translation of system call statx().
>

This patch went trough several transformations in last few days, and I am a
little worried that we forgot the primary reasons/scenarios why want it in
the first place. In that light, may I ask you to recheck this latest
version of the patch, v16, against your scenarios (you mentioned earlier
you have two significantly different flavors of your scenario, one with
Ubuntu 16, and another with Ubuntu 19)?

Thanks in advance,
Aleksandar M.

> The implementation is based on "best effort" approach: if host
> is capable of executing statx(), host statx() is used. If not,
> the implementation includes invoking a more mature system call
> fstatat() on the host side to achieve as close as possible
> functionality.
>
> Support for statx() in kernel and glibc was, however, introduced
> at different points of time (the difference is more than a year):
>
>   - kernel: Linux 4.11 (30 April 2017)
>   - glibc: glibc 2.28 (1 Aug 2018)
>
> In this patch, the availability of statx() support is established
> via __NR_statx (if it is defined, statx() is considered available).
> This coincedes with statx() introduction in kernel.
>
> However, the structure statx definition may not be available in
> any header for hosts with glibc older than 2.28 (and it is, by
> design, to be defined in one of glibc headers), even though the
> full statx() functionality may be supported in kernel. Hence, a
> structure "target_statx" is defined in this patch, to remove that
> dependency on glibc headers, and to use statx() functionality as
> soon as the host kernel is capable of supporting it. Such statx
> structure definition is used for both target and host structures
> statx (of course, this doesn't mean the endian arrangement is
> the same on target and host - the endian conversion is done in
> all necessary cases).
>
> Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c      | 115
+++++++++++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall_defs.h |  37 +++++++++++++++
>  2 files changed, 151 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b187c12..eeca802 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -237,6 +237,7 @@ static type name (type1 arg1,type2 arg2,type3
arg3,type4 arg4,type5 arg5,   \
>  #define __NR_sys_inotify_init __NR_inotify_init
>  #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
>  #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
> +#define __NR_sys_statx __NR_statx
>
>  #if defined(__alpha__) || defined(__x86_64__) || defined(__s390x__)
>  #define __NR__llseek __NR_lseek
> @@ -315,6 +316,14 @@ _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int,
type,
>            unsigned long, idx1, unsigned long, idx2)
>  #endif
>
> +/*
> + * It is assumed that struct statx is architecture independent.
> + */
> +#if defined(TARGET_NR_statx) && defined(__NR_statx)
> +_syscall5(int, sys_statx, int, dirfd, const char *, pathname, int, flags,
> +          unsigned int, mask, struct target_statx *, statxbuf)
> +#endif
> +
>  static bitmask_transtbl fcntl_flags_tbl[] = {
>    { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
>    { TARGET_O_ACCMODE,   TARGET_O_RDWR,      O_ACCMODE,   O_RDWR,      },
> @@ -6467,6 +6476,48 @@ static inline abi_long host_to_target_stat64(void
*cpu_env,
>  }
>  #endif
>
> +#if defined(TARGET_NR_statx) && defined(__NR_statx)
> +static inline abi_long host_to_target_statx(struct target_statx
*host_stx,
> +                                            abi_ulong target_addr)
> +{
> +    struct target_statx *target_stx;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_stx, target_addr,  0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    memset(target_stx, 0, sizeof(*target_stx));
> +
> +    __put_user(host_stx->stx_mask, &target_stx->stx_mask);
> +    __put_user(host_stx->stx_blksize, &target_stx->stx_blksize);
> +    __put_user(host_stx->stx_attributes, &target_stx->stx_attributes);
> +    __put_user(host_stx->stx_nlink, &target_stx->stx_nlink);
> +    __put_user(host_stx->stx_uid, &target_stx->stx_uid);
> +    __put_user(host_stx->stx_gid, &target_stx->stx_gid);
> +    __put_user(host_stx->stx_mode, &target_stx->stx_mode);
> +    __put_user(host_stx->stx_ino, &target_stx->stx_ino);
> +    __put_user(host_stx->stx_size, &target_stx->stx_size);
> +    __put_user(host_stx->stx_blocks, &target_stx->stx_blocks);
> +    __put_user(host_stx->stx_attributes_mask,
&target_stx->stx_attributes_mask);
> +    __put_user(host_stx->stx_atime.tv_sec,
&target_stx->stx_atime.tv_sec);
> +    __put_user(host_stx->stx_atime.tv_nsec,
&target_stx->stx_atime.tv_nsec);
> +    __put_user(host_stx->stx_btime.tv_sec,
&target_stx->stx_atime.tv_sec);
> +    __put_user(host_stx->stx_btime.tv_nsec,
&target_stx->stx_atime.tv_nsec);
> +    __put_user(host_stx->stx_ctime.tv_sec,
&target_stx->stx_atime.tv_sec);
> +    __put_user(host_stx->stx_ctime.tv_nsec,
&target_stx->stx_atime.tv_nsec);
> +    __put_user(host_stx->stx_mtime.tv_sec,
&target_stx->stx_atime.tv_sec);
> +    __put_user(host_stx->stx_mtime.tv_nsec,
&target_stx->stx_atime.tv_nsec);
> +    __put_user(host_stx->stx_rdev_major, &target_stx->stx_rdev_major);
> +    __put_user(host_stx->stx_rdev_minor, &target_stx->stx_rdev_minor);
> +    __put_user(host_stx->stx_dev_major, &target_stx->stx_dev_major);
> +    __put_user(host_stx->stx_dev_minor, &target_stx->stx_dev_minor);
> +
> +    unlock_user_struct(target_stx, target_addr, 1);
> +
> +    return 0;
> +}
> +#endif
> +
> +
>  /* ??? Using host futex calls even when target atomic operations
>     are not really atomic probably breaks things.  However implementing
>     futexes locally would make futexes shared between multiple processes
> @@ -7045,7 +7096,8 @@ static abi_long do_syscall1(void *cpu_env, int num,
abi_long arg1,
>      abi_long ret;
>  #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) \
>      || defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64) \
> -    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64)
> +    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64) \
> +    || defined(TARGET_NR_statx)
>      struct stat st;
>  #endif
>  #if defined(TARGET_NR_statfs) || defined(TARGET_NR_statfs64) \
> @@ -10123,6 +10175,67 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
>              ret = host_to_target_stat64(cpu_env, arg3, &st);
>          return ret;
>  #endif
> +#if defined(TARGET_NR_statx)
> +    case TARGET_NR_statx:
> +        {
> +            struct target_statx *target_stx;
> +            int dirfd = arg1;
> +            int flags = arg3;
> +
> +            p = lock_user_string(arg2);
> +            if (p == NULL) {
> +                return -TARGET_EFAULT;
> +            }
> +#if defined(__NR_statx)
> +            {
> +                /*
> +                 * It is assumed that struct statx is architecture
independent.
> +                 */
> +                struct target_statx host_stx;
> +                int mask = arg4;
> +
> +                ret = get_errno(sys_statx(dirfd, p, flags, mask,
&host_stx));
> +                if (!is_error(ret)) {
> +                    if (host_to_target_statx(&host_stx, arg5) != 0) {
> +                        unlock_user(p, arg2, 0);
> +                        return -TARGET_EFAULT;
> +                    }
> +                }
> +
> +                if (ret != -TARGET_ENOSYS) {
> +                    unlock_user(p, arg2, 0);
> +                    return ret;
> +                }
> +            }
> +#endif
> +            ret = get_errno(fstatat(dirfd, path(p), &st, flags));
> +            unlock_user(p, arg2, 0);
> +
> +            if (!is_error(ret)) {
> +                if (!lock_user_struct(VERIFY_WRITE, target_stx, arg5,
0)) {
> +                    return -TARGET_EFAULT;
> +                }
> +                memset(target_stx, 0, sizeof(*target_stx));
> +                __put_user(major(st.st_dev), &target_stx->stx_dev_major);
> +                __put_user(minor(st.st_dev), &target_stx->stx_dev_minor);
> +                __put_user(st.st_ino, &target_stx->stx_ino);
> +                __put_user(st.st_mode, &target_stx->stx_mode);
> +                __put_user(st.st_uid, &target_stx->stx_uid);
> +                __put_user(st.st_gid, &target_stx->stx_gid);
> +                __put_user(st.st_nlink, &target_stx->stx_nlink);
> +                __put_user(major(st.st_rdev),
&target_stx->stx_rdev_major);
> +                __put_user(minor(st.st_rdev),
&target_stx->stx_rdev_minor);
> +                __put_user(st.st_size, &target_stx->stx_size);
> +                __put_user(st.st_blksize, &target_stx->stx_blksize);
> +                __put_user(st.st_blocks, &target_stx->stx_blocks);
> +                __put_user(st.st_atime, &target_stx->stx_atime.tv_sec);
> +                __put_user(st.st_mtime, &target_stx->stx_mtime.tv_sec);
> +                __put_user(st.st_ctime, &target_stx->stx_ctime.tv_sec);
> +                unlock_user_struct(target_stx, arg5, 1);
> +            }
> +        }
> +        return ret;
> +#endif
>  #ifdef TARGET_NR_lchown
>      case TARGET_NR_lchown:
>          if (!(p = lock_user_string(arg1)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 7f141f6..170c4dd 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2536,4 +2536,41 @@ struct target_user_cap_data {
>  /* Return size of the log buffer */
>  #define TARGET_SYSLOG_ACTION_SIZE_BUFFER   10
>
> +struct target_statx_timestamp {
> +   int64_t tv_sec;
> +   uint32_t tv_nsec;
> +   int32_t __reserved;
> +};
> +
> +struct target_statx {
> +   /* 0x00 */
> +   uint32_t stx_mask;       /* What results were written [uncond] */
> +   uint32_t stx_blksize;    /* Preferred general I/O size [uncond] */
> +   uint64_t stx_attributes; /* Flags conveying information about the
file */
> +   /* 0x10 */
> +   uint32_t stx_nlink;      /* Number of hard links */
> +   uint32_t stx_uid;        /* User ID of owner */
> +   uint32_t stx_gid;        /* Group ID of owner */
> +   uint16_t stx_mode;       /* File mode */
> +   uint16_t __spare0[1];
> +   /* 0x20 */
> +   uint64_t stx_ino;        /* Inode number */
> +   uint64_t stx_size;       /* File size */
> +   uint64_t stx_blocks;     /* Number of 512-byte blocks allocated */
> +   uint64_t stx_attributes_mask; /* Mask to show what is supported */
> +   /* 0x40 */
> +   struct target_statx_timestamp  stx_atime;  /* Last access time */
> +   struct target_statx_timestamp  stx_btime;  /* File creation time */
> +   struct target_statx_timestamp  stx_ctime;  /* Last attribute change
time */
> +   struct target_statx_timestamp  stx_mtime;  /* Last data modification
time */
> +   /* 0x80 */
> +   uint32_t stx_rdev_major;   /* Device ID of special file [if
bdev/cdev] */
> +   uint32_t stx_rdev_minor;
> +   uint32_t stx_dev_major; /* ID of device containing file [uncond] */
> +   uint32_t stx_dev_minor;
> +   /* 0x90 */
> +   uint64_t __spare2[14];  /* Spare space for future expansion */
> +   /* 0x100 */
> +};
> +
>  #endif
> --
> 2.7.4
>
>
