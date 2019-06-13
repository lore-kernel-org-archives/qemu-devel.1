Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5A1C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3992082C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3992082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbNb2-0003KF-Fw
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40770)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hbNRm-00054F-Af
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hbNFe-0004HR-06
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:46:39 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40877)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hbNFc-0004EE-3p
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:46:37 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Msqpq-1iUZIZ2Hu4-00tBZ2; Thu, 13 Jun 2019 12:46:11 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559903719-7162-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1559903719-7162-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6ceaa114-887b-b060-17b2-7d801e9f266b@vivier.eu>
Date: Thu, 13 Jun 2019 12:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559903719-7162-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZgWHEyB71Q76Vw4D7++rtHsYc2eP3i2f57KytP9kdQYltz9iPV/
 5out+xw45uXwjodmRMWsynrPRm77aY+jk1h9kApV7xBnZHgdBkwvxAT5f1DWSkvXwayKUF6
 TlbcxIxYNs4POzzMzJk5uLkKv9ue+zJV6LHsRWkHT9JAt8yTxJZYhmJ/DAfK/rSkJngGX+w
 wsozVy+AjN8oZLaBGw1ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9SvsUapatVY=:RxEzgcIcRnAX1vL5AjAKKg
 IX0Q4u5vPboLbv7D6b94YCrbzxs+StnX3C84Hm5FGbpthtZXeTkvUtnggOaSRa6HYvuUGo2Fz
 UivkAqhIWAQ/czA9z8Sdzu1f3bW3Q25lD994y6PAsgBvjzhOcmGMM3Ej1yfoozUvj46erCxR6
 rjJLt7PE/1DmAQAwxWjYFOu9eG01dBvMhUE7veVOqwE6ja4EuNnBY2R0w7T9hqSEKCF+JlxQk
 Grm+BGd/85po0F+rLrusj/Rx7Uqzv2fFpncXi5wqVfdmj0d6pfHa6vAdII92dSbkTFNZSCsnh
 AHx7aZT5sQDw0ZIfot3rMq8W54SIuAuhvu9w3tvxS/RSdeGZWOgi/YvDmY83qtj3m1y2I9cwb
 Mg893UfmpwY3AKjVHEMHeQf2D+iRxOWlS+r6J6EDGyKe9/9xNnv849BeLsxwXwizj2aagurwJ
 0ODeMSuBIjx5IjkDvCQoa0VipJ8EyeX1Id+iLS6qBxqc0i3DZuSXFeEWtRbGgCUReygiAaksD
 xyFQJzicCuASEjMnILZyC8Rr2G47VaUaImZO6HVIQ82tC39HbIm9J3lAOqkh2bBdJgVE2hPnm
 Nx9/23maKnf+9ShKAjQVJ8EMUVAB45boENnByEpWX5HNt46zFaHpdy3zKj9MDIPojEdYoYPaB
 JG5rG7cEUsm0X5HVsN74bjM73f8ttGJK60BhhaeZRMXiOCAsren6ycfo6nCIBi4qwXHO1T2iJ
 9rn6rCWc8pk+x5FV6aqyhvfZw/PxiMv2Q3kxDnhseiiVhKJXDia3B02HM98=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v10 3/3] linux-user: Add support for
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
Cc: lvivier@redhat.com, Aleksandar Rikalo <arikalo@wavecomp.com>,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/06/2019 à 12:35, Aleksandar Markovic a écrit :
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
>  linux-user/syscall.c      | 135 +++++++++++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall_defs.h |  37 +++++++++++++
>  2 files changed, 171 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 82c08b6..b78ed45 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
...
> @@ -10182,6 +10226,95 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
> +                 * It is assumed that struct statx is arhitecture independent

s/arhitecture/architecture/

> +                 */
> +                struct target_statx host_stx;
> +                int mask = arg4;
> +
> +                ret = get_errno(syscall(__NR_statx, dirfd, p, flags, mask,
> +                                        &host_stx));

You should define sys_statx() using _syscall5() macro and use it.

> +                if (!is_error(ret)) {
> +                    if (host_to_target_statx(&host_stx, arg5) != 0) {
> +                        unlock_user(p, arg2, 0);
> +                        return -TARGET_EFAULT;
> +                    }
> +                }
> +
> +                if (ret != TARGET_ENOSYS) {

ret != -TARGET_ENOSYS

> +                    unlock_user(p, arg2, 0);
> +                    return ret;
> +                }
> +            }
> +#endif
> +            if ((p == NULL) || (*((char *)p) == 0)) {

You already checked above p is not NULL and exited with -TARGET_EFAULT.

BTW, do we really need to emulate the syscall if it is not available?

I think the user-space application calling statx() should be ready to
receive ENOSYS and define some kinds of fallback (like you do below). So
it should not be done by QEMU.

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
> +                if (dirfd == AT_FDCWD) {
> +                    /*
> +                     * By pathname relative to the current working directory
> +                     */
> +                    ret = get_errno(stat(path(p), &st));

Why do we divide the case in two parts, fstatat() should work here too.

> +                } else {
> +                    /*
> +                     * By pathname relative to the directory referred to by
> +                     * the file descriptor 'dirfd'
> +                     */
> +                    ret = get_errno(fstatat(dirfd, path(p), &st, flags));
> +                }
> +            }
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

Thanks,
Laurent

