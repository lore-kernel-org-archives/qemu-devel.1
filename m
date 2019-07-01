Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAFCC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDBF208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDBF208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhrtB-0003LT-8a
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 04:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39038)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hhrsE-0002u0-Jn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hhrsC-00017P-U7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:41:18 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51567)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hhrsC-00013q-K6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:41:16 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MMGVE-1i12e10M3q-00JKVK; Mon, 01 Jul 2019 10:40:55 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561718618-20218-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1561718618-20218-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d4464212-7310-6680-4c8f-4708fea484b4@vivier.eu>
Date: Mon, 1 Jul 2019 10:40:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561718618-20218-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vOcy8SwAQnccK524RwAcSvKjmIh/h8mZsItwfLnSK8nza7dh1U8
 LGSKyPKUba9/KVAbA6bwGneL7O8ja4pQI3aJrM3dn1VTQH7abjMo0DG4+NoSP/59eR4zX37
 W0UyEZbF00bJIoAj3qgZrhrb9hYHk7FTwovGByUpN4HOsIC8iLimANGBXg8rG6jiEgyWr6R
 KfJgeAh9dMVdGiz8EJS8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cOrRp5fLC1A=:Nm96XVhtoTMp872GnxVR1P
 H1DZts0HsliOuWkAntWvqIji1h7CHNhfaDJNmG3fuoioTk+psyuGzY1lpHhc/O53KRwP5ssNG
 o6GDeu1BXhOoGRlbVFdOOO9IF8Iz6Do6hmzTgZIjRYgjRUbG/YW4r74vyDCMs7OCS5d97Z/oG
 G7XIk6Re83iN4JyKArMfa8MJOdx+vvb89yls4DoQTQiULckHnBVgAZShASgdylotvuXG1uJ5N
 /5oJ2SJt0mhCsJmr9SUlXkJcmqOmxA4afaXoQ8GO1Yyx+VmL06iLpz7Br4/5nYOto9azeblbx
 TB43B1gPs2RSjrvxhebKnKcha0R6j9HD/aHSXloG3D+vO9NNCWJMOfwQ4g/wMQnubyHSoJu7m
 RTvo+B6nSSaJAgM4cpLtnNHGFGOFXA6ki4yPLZDVlf+AAhognReF4erA126Va4tyIzKpQu1IV
 ALm+cabz+LNm+/usZIrtxj43Z602LFc2I4v7CEmbxuLxc2GgLKQl8fUZNAVhcudWZWMHNvWvh
 syNTPe86zG1if0A2XazhabQfgrNyPZKtLSUeGuRkMZBKUTqQCp5mKhtJlSxAjjHn4ye+5Cum6
 aH3WLCbdMrNJWdY9UMBuPsEXZHTpX++/0XFkHShuCy7pC72R//x2SOaD9/xIVy+bd4hYw79ln
 bJldV63J04uzjEF8NzLmLQiKzdf5UEUjrXED2A+uLb64oJYaNvx9HciLhbLNUFahg0jYTQwvG
 51Ewx6cSkDkjqsAjpEIq0P/DuRL4qnvz0n0unmrAhf03C8DnROSB4rWztmQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/06/2019 à 12:43, Aleksandar Markovic a écrit :
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Implement support for translation of system call statx().
> 
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
>  linux-user/syscall.c      | 115 +++++++++++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall_defs.h |  37 +++++++++++++++
>  2 files changed, 151 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b187c12..eeca802 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -237,6 +237,7 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
>  #define __NR_sys_inotify_init __NR_inotify_init
>  #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
>  #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
> +#define __NR_sys_statx __NR_statx
>  
>  #if defined(__alpha__) || defined(__x86_64__) || defined(__s390x__)
>  #define __NR__llseek __NR_lseek
> @@ -315,6 +316,14 @@ _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
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
> @@ -6467,6 +6476,48 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_statx) && defined(__NR_statx)
> +static inline abi_long host_to_target_statx(struct target_statx *host_stx,
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
> +    __put_user(host_stx->stx_attributes_mask, &target_stx->stx_attributes_mask);
> +    __put_user(host_stx->stx_atime.tv_sec, &target_stx->stx_atime.tv_sec);
> +    __put_user(host_stx->stx_atime.tv_nsec, &target_stx->stx_atime.tv_nsec);
> +    __put_user(host_stx->stx_btime.tv_sec, &target_stx->stx_atime.tv_sec);
> +    __put_user(host_stx->stx_btime.tv_nsec, &target_stx->stx_atime.tv_nsec);
> +    __put_user(host_stx->stx_ctime.tv_sec, &target_stx->stx_atime.tv_sec);
> +    __put_user(host_stx->stx_ctime.tv_nsec, &target_stx->stx_atime.tv_nsec);
> +    __put_user(host_stx->stx_mtime.tv_sec, &target_stx->stx_atime.tv_sec);
> +    __put_user(host_stx->stx_mtime.tv_nsec, &target_stx->stx_atime.tv_nsec);
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
> @@ -7045,7 +7096,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      abi_long ret;
>  #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) \
>      || defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64) \
> -    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64)
> +    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64) \
> +    || defined(TARGET_NR_statx)
>      struct stat st;
>  #endif
>  #if defined(TARGET_NR_statfs) || defined(TARGET_NR_statfs64) \
> @@ -10123,6 +10175,67 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
> +                 * It is assumed that struct statx is architecture independent.
> +                 */
> +                struct target_statx host_stx;
> +                int mask = arg4;
> +
> +                ret = get_errno(sys_statx(dirfd, p, flags, mask, &host_stx));
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
> +                if (!lock_user_struct(VERIFY_WRITE, target_stx, arg5, 0)) {
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
> +                __put_user(major(st.st_rdev), &target_stx->stx_rdev_major);
> +                __put_user(minor(st.st_rdev), &target_stx->stx_rdev_minor);
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
> +   uint64_t stx_attributes; /* Flags conveying information about the file */
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
> +   struct target_statx_timestamp  stx_ctime;  /* Last attribute change time */
> +   struct target_statx_timestamp  stx_mtime;  /* Last data modification time */
> +   /* 0x80 */
> +   uint32_t stx_rdev_major;   /* Device ID of special file [if bdev/cdev] */
> +   uint32_t stx_rdev_minor;
> +   uint32_t stx_dev_major; /* ID of device containing file [uncond] */
> +   uint32_t stx_dev_minor;
> +   /* 0x90 */
> +   uint64_t __spare2[14];  /* Spare space for future expansion */
> +   /* 0x100 */
> +};
> +
>  #endif
> 

Applied to my linux-user branch.

Thanks,
Laurent


