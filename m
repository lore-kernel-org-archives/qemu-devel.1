Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9982C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C182217D7
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C182217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40138 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hddF4-0006xi-NH
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 12:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hddC4-00052E-07
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hddBy-0000f9-C8
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:12:13 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59733)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hddBw-0000dS-Is
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:12:09 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M8hMt-1hiI1X3o5h-004hZc; Wed, 19 Jun 2019 18:11:51 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1560953834-29584-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1560953834-29584-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <75367706-a29d-605e-a3b4-0aa483b521c4@vivier.eu>
Date: Wed, 19 Jun 2019 18:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560953834-29584-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ff+Hso1Q6u/XkR1Y7wegG3VfPvBDSMqbwLThbEpayfaTqTrD/rO
 IpUM0pDlaWpJu2xbhgYFJKd9FESexkBOx+HiWGXlRscaH/7lzov4UzLmNMEjxS/IdKHfNtp
 amAgcMKs0EIy4Jax7f902ZdN9kkKQy5G4z78VGyqgRC1ISL6QgpHxHtOEWplBAMan2iXT0y
 QZz+gPvElF3QAn87rswHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z8rXu4pktgU=:R96jrWXRiT5okGERE2GQ8o
 Zc30LVMKH1TPOgL/+6R0KSFuELWHrZJCBkVMYQuyUDc2qkyKU76ZCOYn9XqJ3VqwsOXpse+cV
 xFjR5aXopTAv39A/opGwZLJH9EeFUwAAjvSLQq46MoJ9s3suFlV83bvXMDJK8GM1PnvP2ioh3
 CE72QXBVnObuGWA7hr51XmW9aNmHmampDI2pVx59bWM1D9qnhIX30R2KL+7l1ZArKRlKgD8DL
 7+by21gQC/ocElYYRJ8SAmtmOM/npBig06NY9uoPYJRZRiapZA4BPcQDA1thOZMw047L5BfCD
 0ca+mSh/v2Ouc9s/e7cCP502Qz/mrUweprx665u1eHB+gbpyC2dmW7OQ/aMQlc+5Aiy48MB8j
 6RAIFprtBZXsq9l4F6si73mIXsahvh+lXmqCSgzcMzfqiKZt0GF+uVgFdf53/seHC+LPEkA5F
 /Z6rHBRUEOx2N82olo4xlqs3RQY3NRvP0rj/O1gZXXmeT7ffCnz9p1IBgenT7tqL8K3BeLrwc
 55tkUJqTopUTBwBAWzt+yBdXNXkAYxAQXZkejcpTXY4uX8VCi17lVAGzX1UCRwvMSng2sIt9n
 9sSo3g5iz0MBJkNasq6yUlZ1SqDEFE4ZEo1LCcH5nWIspCBnLKUolAuTkiQd/TZhZ4zce3nTh
 anZH+2JoaF82o5JyiSm5yVzXJ8z/aSQQFPnZH/vdyUAhVxsaMBunw9nNBvpMI7lwXjynSQal/
 3TY9eOzwwBK0843HGlJLL3doYzW/v7HupP6Y26FOD/mFadLdJ4NoYAt3Gg8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH v12 3/5] linux-user: Add support for
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

Le 19/06/2019 à 16:17, Aleksandar Markovic a écrit :
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Implement support for translation of system call statx().
> 
> The implementation is based on "best effort" approach: if host is
> capable of executing statx(), host statx() is used. If not, the
> implementation includes invoking other (more mature) system calls
> (from the same 'stat' family) on the host side to achieve as close
> as possible functionality.
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
> However, the structure statx definition may not be available for hosts
> with glibc older than 2.28 (it is, by design, to be defined in one of
> glibc headers), even though the full statx() functionality may be
> supported in kernel, if the kernel is not older than 4.11. Hence,
> a structure "target_statx" is defined in this patch, to remove that
> dependency on glibc headers, and to use statx() functionality as soon
> as the host kernel is capable of supporting it. Such structure statx
> definition is used for both target and host structures statx (of
> course, this doesn't mean the endian arrangement is the same on
> target and host, and endian conversion is done in all necessary
> cases).
> 
> Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall.c      | 136 +++++++++++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall_defs.h |  37 +++++++++++++
>  2 files changed, 172 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d116287..e68a36c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -43,6 +43,7 @@
>  #include <sys/times.h>
>  #include <sys/shm.h>
>  #include <sys/sem.h>
> +#include <sys/stat.h>
>  #include <sys/statfs.h>
>  #include <utime.h>
>  #include <sys/sysinfo.h>
> @@ -316,6 +317,14 @@ _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
>            unsigned long, idx1, unsigned long, idx2)
>  #endif
>  
> +/*
> + * It is assumed that struct statx is architecture independent.
> + */
> +#if defined(TARGET_NR_statx) && defined(__NR_statx)
> +_syscall5(int, statx, int, dirfd, const char *, pathname, int, flags,
> +          unsigned int, mask, struct target_statx *, statxbuf)
> +#endif
> +
>  static bitmask_transtbl fcntl_flags_tbl[] = {
>    { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
>    { TARGET_O_ACCMODE,   TARGET_O_RDWR,      O_ACCMODE,   O_RDWR,      },
> @@ -6517,6 +6526,48 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
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
> @@ -7095,7 +7146,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      abi_long ret;
>  #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) \
>      || defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64) \
> -    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64)
> +    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64) \
> +    || defined(TARGET_NR_statx)
>      struct stat st;
>  #endif
>  #if defined(TARGET_NR_statfs) || defined(TARGET_NR_statfs64) \
> @@ -10173,6 +10225,88 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
> +                ret = get_errno(statx(dirfd, p, flags, mask, &host_stx));
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
> +            if (*((char *)p) == 0) {
> +                /*
> +                 * By file descriptor
> +                 */
> +                if (flags & AT_EMPTY_PATH) {
> +                    unlock_user(p, arg2, 0);
> +                    return -TARGET_ENOENT;
> +                }
> +                ret = get_errno(fstat(dirfd, &st));
> +            } else if (*((char *)p) == '/') {
> +                /*
> +                 * By absolute pathname
> +                 */
> +                ret = get_errno(stat(path(p), &st));
> +            } else {
> +                /*
> +                 * By pathname relative to the current working directory
> +                 * (if 'dirfd' is AT_FDCWD) or relative to the directory
> +                 * referred to by the file descriptor 'dirfd'.
> +                 */
> +                 ret = get_errno(fstatat(dirfd, path(p), &st, flags));
> +            }
> +            unlock_user(p, arg2, 0);

Could you explain why we can't use fstatat() for the two previous cases
"(*((char *)p) == 0)" and "(*((char *)p) == '/')"?

Thanks,
Laurent


