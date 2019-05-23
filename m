Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48ECC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CD520863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CD520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTjtw-0006EJ-HW
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 05:20:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTjt3-0005oa-5v
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTjt1-0007L0-G9
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:19:45 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTjt1-0007Aw-7t
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:19:43 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MPXpU-1hFvv13Vze-00MY8i; Thu, 23 May 2019 11:06:34 +0200
To: Chen-Yu Tsai <wens@kernel.org>, qemu-devel@nongnu.org
References: <20190522162147.26303-1-wens@kernel.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <59c2792c-d6a0-aeb8-c537-0bd9f8ea4553@vivier.eu>
Date: Thu, 23 May 2019 11:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190522162147.26303-1-wens@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8r77Gyv7moKqiVMSsQUHzkWdOvaeAuGX+AuYjipSWqWugYD+5Bk
	pqAgsmzZDyb0hFNHvWHDNxFp5Cyk+H7HP4EtcM/xVEa4B/b84ufahK2QSm14gl/uvZYSify
	g1cMcueu69XeHQx3vFaBIVVV9SlcENSLkLSyLS1zZJBcrg3S/K83s/Dz8Oyo120KFJxWhnO
	Nvd6oRwuelvCp0XPV0igQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E6HTmiUYVL0=:Z7GYV4Xk2f+wdY9w0MvfAU
	+IHK+g447mlw8eR4bM0J+oFxVCgugLdOjSFuNDTFOqeD9e4RKMm9ZOQpUbGOGVetiOV2ArLoP
	MLAml34OXXtGA3fa0BlZKGKM/6yJz3Usgg/3de5HWhGPB5uSEfaXcazwk18+a7L+N4Vo8Au6s
	Awo07QiEe5fiKZuNCNzBcyWuk3fvnrsURT1aFemiRW1kQVziJbW0XNKaucNyTOKVqeOgoRlV9
	mNYG2W9ulDNRUhfHl6BaEm1c7HZFMuY/x1y1c+loAhH3RkvSHLyfv5SzNKDElf+atp8Px7MWj
	cjUcJLRUuLf5agodXy+XruhWua0BEssxJgQkybdcFin6oIyJ0vWxVgr1fgfebW+8FG5c0DCp4
	uaCENIpqHy/Gp0apWl4ni4rbFpnh7EGvNtBceTG9VSB1GYAmUXoWicCg0zFY6mibmLPbbhC5t
	lQFpg018SQA7aM+8KVckcjITI3/ffZh4gQb1GtdxKT42s39H7armpwMKxgCrC8QkVHeLwv/b2
	GvxCo7n1Qh1lAuGDF2yxEYlKR2g9rn75Bt7v/Z1upvA5K8soxH6QZkYPyIu+TiBcPLNkD8+eW
	O2Hqpqg+QM5Kw1ZawttvFRr5TX6jL/nYZUe+20py6OqjnvhsZvhgEUrXLy2aaG1wzVROa5skN
	plGCCQLJWTTKNRHqQHRzXrhfyXoW/+tP+nQGhoa0cknogX55ol2DedAGNunupgFF8jn9nYdkO
	yt8R5y2Wt3Rlm20iGVIPl+RtiBHpCepdNH/tgBcGx4JiExdachV+076NRoU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: Pass through nanosecond
 timestamp components for stat syscalls
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/2019 18:21, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Since Linux 2.6 the stat syscalls have mostly supported nanosecond
> components for each of the file-related timestamps.
> 
> QEMU user mode emulation currently does not pass through the nanosecond
> portion of the timestamp, even when the host system fills in the value.
> This results in a mismatch when run on subsecond resolution filesystems
> such as ext4 or XFS.
> 
> An example of this leading to inconsistency is cross-debootstraping a
> full desktop root filesystem of Debian Buster. Recent versions of
> fontconfig store the full timestamp (instead of just the second portion)
> of the directory in its per-directory cache file, and checks this against
> the directory to see if the cache is up-to-date. With QEMU user mode
> emulation, the timestamp stored is incorrect, and upon booting the rootfs
> natively, fontconfig discovers the mismatch, and proceeds to rebuild the
> cache on the comparatively slow machine (low-power ARM vs x86). This
> stalls the first attempt to open whatever application that incorporates
> fontconfig.
> 
> This patch renames the "unused" padding trailing each timestamp element
> to its nanosecond counterpart name if such an element exists in the
> kernel sources for the given platform. Not all do. Then have the syscall
> wrapper fill in the nanosecond portion if the host supports it, as
> specified by the _POSIX_C_SOURCE and _XOPEN_SOURCE feature macros.
> 
> Recent versions of glibc only use stat64 and newfstatat syscalls on
> 32-bit and 64-bit platforms respectively. The changes in this patch
> were tested by directly calling the stat, stat64 and newfstatat syscalls
> directly, in addition to the glibc wrapper, on arm and aarch64 little
> endian targets.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> ---
> 
> Changes since v2:
> 
>    - Rename TARGET_STAT_HAS_NSEC to TARGET_STAT_HAVE_NSEC
> 
> Changes since v1:
> 
>    - Define TARGET_STAT_HAS_NSEC for targets that have the *_nsec fields
>      in their struct stat
> 
>    - Only copy the *_nsec fields in the stat (not stat64) code path if
>      TARGET_STAT_HAS_NSEC is defined
> 
>    - Picked up Reviewed-by from Laurent
> 
> As Laurent mentioned, linux-user/syscall_defs.h is indented with tabs,
> so the checkpatch.pl errors can be ignored.
> 
> Original cover letter:
> 
> This issue was found while integrating some software that uses newer
> versions of fontconfig into Raspbian images. We found that the first
> launch of said software always stalls with fontconfig regenerating its
> font cache files. Upon closer examination I found the timestamps were
> not matching. The rest is explained above. Currently we're just working
> around the problem by patching the correct timestamps into the cache
> files after the fact.
> 
> Please consider this a drive-by scratch-my-own-itch contribution, but I
> will stick around to deal with any comments raised during review. I'm
> not on the mailing lists either, so please keep me in CC.
> 
> checkpatch returns "ERROR: code indent should never use tabs" for
> linux-user/syscall_defs.h, however as far as I can tell the whole file
> is indented with tabs. I'm not sure what to make of this.
> 
> Finally, I think this could be worth backporting to older versions.
> ---
>   linux-user/syscall.c      | 19 +++++++++++++++
>   linux-user/syscall_defs.h | 49 +++++++++++++++++++++++++--------------
>   2 files changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index efa3ec2837..c83a3648c9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6408,6 +6408,11 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
>           __put_user(host_st->st_atime, &target_st->target_st_atime);
>           __put_user(host_st->st_mtime, &target_st->target_st_mtime);
>           __put_user(host_st->st_ctime, &target_st->target_st_ctime);
> +#if _POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700
> +        __put_user(host_st->st_atim.tv_nsec, &target_st->target_st_atime_nsec);
> +        __put_user(host_st->st_mtim.tv_nsec, &target_st->target_st_mtime_nsec);
> +        __put_user(host_st->st_ctim.tv_nsec, &target_st->target_st_ctime_nsec);
> +#endif
>           unlock_user_struct(target_st, target_addr, 1);
>       } else
>   #endif
> @@ -6438,6 +6443,11 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
>           __put_user(host_st->st_atime, &target_st->target_st_atime);
>           __put_user(host_st->st_mtime, &target_st->target_st_mtime);
>           __put_user(host_st->st_ctime, &target_st->target_st_ctime);
> +#if _POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700
> +        __put_user(host_st->st_atim.tv_nsec, &target_st->target_st_atime_nsec);
> +        __put_user(host_st->st_mtim.tv_nsec, &target_st->target_st_mtime_nsec);
> +        __put_user(host_st->st_ctim.tv_nsec, &target_st->target_st_ctime_nsec);
> +#endif
>           unlock_user_struct(target_st, target_addr, 1);
>       }
>   
> @@ -8866,6 +8876,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                   __put_user(st.st_atime, &target_st->target_st_atime);
>                   __put_user(st.st_mtime, &target_st->target_st_mtime);
>                   __put_user(st.st_ctime, &target_st->target_st_ctime);
> +#if (_POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700) && \
> +    defined(TARGET_STAT_HAVE_NSEC)
> +                __put_user(st.st_atim.tv_nsec,
> +                           &target_st->target_st_atime_nsec);
> +                __put_user(st.st_mtim.tv_nsec,
> +                           &target_st->target_st_mtime_nsec);
> +                __put_user(st.st_ctim.tv_nsec,
> +                           &target_st->target_st_ctime_nsec);
> +#endif
>                   unlock_user_struct(target_st, arg2, 1);
>               }
>           }
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 1f5b2d18db..0223724758 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -1179,6 +1179,7 @@ struct target_winsize {
>   #if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
>       || (defined(TARGET_ARM) && defined(TARGET_ABI32)) \
>       || defined(TARGET_CRIS)
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>   	unsigned short st_dev;
>   	unsigned short __pad1;
> @@ -1193,11 +1194,11 @@ struct target_stat {
>   	abi_ulong  st_blksize;
>   	abi_ulong  st_blocks;
>   	abi_ulong  target_st_atime;
> -	abi_ulong  __unused1;
> +	abi_ulong  target_st_atime_nsec;
>   	abi_ulong  target_st_mtime;
> -	abi_ulong  __unused2;
> +	abi_ulong  target_st_mtime_nsec;
>   	abi_ulong  target_st_ctime;
> -	abi_ulong  __unused3;
> +	abi_ulong  target_st_ctime_nsec;
>   	abi_ulong  __unused4;
>   	abi_ulong  __unused5;
>   };
> @@ -1229,13 +1230,13 @@ struct target_stat64 {
>   	abi_ulong	__pad4;		/* future possible st_blocks high bits */
>   
>   	abi_ulong	target_st_atime;
> -	abi_ulong	__pad5;
> +	abi_ulong	target_st_atime_nsec;
>   
>   	abi_ulong	target_st_mtime;
> -	abi_ulong	__pad6;
> +	abi_ulong	target_st_mtime_nsec;
>   
>   	abi_ulong	target_st_ctime;
> -	abi_ulong	__pad7;		/* will be high 32 bits of ctime someday */
> +	abi_ulong	target_st_ctime_nsec;
>   
>   	unsigned long long	st_ino;
>   } QEMU_PACKED;
> @@ -1314,19 +1315,20 @@ struct target_stat64 {
>   	unsigned int	st_blocks;
>   
>   	abi_ulong	target_st_atime;
> -	abi_ulong	__unused1;
> +	abi_ulong	target_st_atime_nsec;
>   
>   	abi_ulong	target_st_mtime;
> -	abi_ulong	__unused2;
> +	abi_ulong	target_st_mtime_nsec;
>   
>   	abi_ulong	target_st_ctime;
> -	abi_ulong	__unused3;
> +	abi_ulong	target_st_ctime_nsec;
>   
>   	abi_ulong	__unused4[3];
>   };
>   
>   #elif defined(TARGET_SPARC)
>   
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>   	unsigned short	st_dev;
>   	abi_ulong	st_ino;
> @@ -1337,14 +1339,14 @@ struct target_stat {
>   	unsigned short	st_rdev;
>   	abi_long	st_size;
>   	abi_long	target_st_atime;
> -	abi_ulong	__unused1;
> +	abi_ulong	target_st_atime_nsec;
>   	abi_long	target_st_mtime;
> -	abi_ulong	__unused2;
> +	abi_ulong	target_st_mtime_nsec;
>   	abi_long	target_st_ctime;
> -	abi_ulong	__unused3;
> +	abi_ulong	target_st_ctime_nsec;
>   	abi_long	st_blksize;
>   	abi_long	st_blocks;
> -	abi_ulong	__unused4[2];
> +	abi_ulong	__unused1[2];
>   };
>   
>   #define TARGET_HAS_STRUCT_STAT64
> @@ -1372,20 +1374,21 @@ struct target_stat64 {
>   	unsigned int	st_blocks;
>   
>   	unsigned int	target_st_atime;
> -	unsigned int	__unused1;
> +	unsigned int	target_st_atime_nsec;
>   
>   	unsigned int	target_st_mtime;
> -	unsigned int	__unused2;
> +	unsigned int	target_st_mtime_nsec;
>   
>   	unsigned int	target_st_ctime;
> -	unsigned int	__unused3;
> +	unsigned int	target_st_ctime_nsec;
>   
> -	unsigned int	__unused4;
> -	unsigned int	__unused5;
> +	unsigned int	__unused1;
> +	unsigned int	__unused2;
>   };
>   
>   #elif defined(TARGET_PPC)
>   
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>   	abi_ulong st_dev;
>   	abi_ulong st_ino;
> @@ -1443,6 +1446,7 @@ struct QEMU_PACKED target_stat64 {
>   
>   #elif defined(TARGET_MICROBLAZE)
>   
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>   	abi_ulong st_dev;
>   	abi_ulong st_ino;
> @@ -1558,6 +1562,7 @@ struct target_stat64 {
>   
>   #elif defined(TARGET_ABI_MIPSN64)
>   
> +#define TARGET_STAT_HAVE_NSEC
>   /* The memory layout is the same as of struct stat64 of the 32-bit kernel.  */
>   struct target_stat {
>   	unsigned int		st_dev;
> @@ -1597,6 +1602,7 @@ struct target_stat {
>   
>   #elif defined(TARGET_ABI_MIPSN32)
>   
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>           abi_ulong    st_dev;
>           abi_ulong    st_pad0[3]; /* Reserved for st_dev expansion */
> @@ -1621,6 +1627,7 @@ struct target_stat {
>   
>   #elif defined(TARGET_ABI_MIPSO32)
>   
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>   	unsigned	st_dev;
>   	abi_long	st_pad1[3];		/* Reserved for network id */
> @@ -1737,6 +1744,7 @@ struct target_stat64 {
>   
>   #elif defined(TARGET_SH4)
>   
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>   	abi_ulong  st_dev;
>   	abi_ulong  st_ino;
> @@ -1796,6 +1804,7 @@ struct QEMU_PACKED target_stat64 {
>   };
>   
>   #elif defined(TARGET_I386) && !defined(TARGET_ABI32)
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>   	abi_ulong	st_dev;
>   	abi_ulong	st_ino;
> @@ -1841,6 +1850,7 @@ struct target_stat {
>       abi_ulong  __unused[3];
>   };
>   #elif defined(TARGET_AARCH64)
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>       abi_ulong  st_dev;
>       abi_ulong  st_ino;
> @@ -1863,6 +1873,7 @@ struct target_stat {
>       unsigned int __unused[2];
>   };
>   #elif defined(TARGET_XTENSA)
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>       abi_ulong       st_dev;
>       abi_ulong       st_ino;
> @@ -1912,6 +1923,7 @@ struct target_stat64  {
>   
>   /* These are the asm-generic versions of the stat and stat64 structures */
>   
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>       abi_ulong st_dev;
>       abi_ulong st_ino;
> @@ -1963,6 +1975,7 @@ struct target_stat64 {
>   
>   #elif defined(TARGET_HPPA)
>   
> +#define TARGET_STAT_HAVE_NSEC
>   struct target_stat {
>       abi_uint   st_dev;
>       abi_uint   st_ino;
> 


Applied to my linux-user branch.

Thanks,
Laurent

