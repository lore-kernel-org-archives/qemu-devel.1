Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F66C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2AF8204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AF8204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38867 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNFg-0000bB-Ts
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:09:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNEc-00007R-8G
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNEa-0007Mf-M8
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:08:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTNEa-0007KM-Ba
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:08:28 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MNso2-1hIR1c0cW0-00OFEJ; Wed, 22 May 2019 11:08:24 +0200
To: Chen-Yu Tsai <wens@kernel.org>, qemu-devel@nongnu.org
References: <20190514145346.20758-1-wens@kernel.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <42b910fa-ca78-0231-db54-f2179fbb827c@vivier.eu>
Date: Wed, 22 May 2019 11:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190514145346.20758-1-wens@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SrRNoyBymdppbX57B1yLuOC1Jq4+l0++2VWpOjxL2S8HEjzlMD6
	kGfLFLp25hoIQhtHH43mhjhcmMZGxHjfvbvDL9xZJY/gPhWxaSi6FamEhz3CLp+WEpg4lMP
	KWB8vOZdoho8INxrXc0Pujt2Gs+Qg7ZQkSEvcqAXgIVaHtuxbFeG1T0/bwxqaJ4r2koFyvj
	tqukDXTdR52hjp38u+WOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f/Z9/8R+yLI=:KEb85anop8TCOZ+knvxi55
	WhTt3lFL5gbk1qrfYveFgxTnkFOKONFRG3xZdgU4UGi+c9ntnKe4g8d2EVo3gNTt5E3rwMmnP
	NmtNZQ0oko3cKElnqSKjkDt15Q7mRe8hQr51k/1MILQL5o3yPC9Gu7XRKGi/jof88f3L9+yVY
	Jz6qPPwyjuU9iUt32NJjaTuQKXqPdJtG/+zEuWc7QMhuPAirOE4J7cTuPUEdmcGgVd3Sqv1FB
	CT/paNi1uK3Hq4yigkaJemP8vayWsXcrfRAiDt8m31C4e7zFjk9JjguzF9/V2MIAj+6FtQ71f
	1bvcI4LR60/KcpbtLxcF9sb+5sHDMr0WvkebMaG0H0Ifz6iZQdIevbliW2o3jVUo+IkZ6zxrL
	C5afj/Vukb0kfuKgfYZf2zw6e6xXcx0v2yGHPA380zuHIRlHbZVXWlX5X5SaQR3s3Szs/F40j
	/DTicrJFIZ3I24t+/ZdUnIROrF5l0GuDCyjxszTKKndtMWd5cCP3sYN0bZZgSgro/WZmJWpM6
	tMq198HBGCm0xm8Ap2gDwbiqZ7am3XR9lflny2uLh0zHXs2ikwkPZ30Ph3xZgu9TGxHp9yv4V
	b2eYPjWlMjxxIwEdeBHUBCbY1NcC4Q+J7w0zE02L+bdqamKc190QRyT0fYOx8srVcexlGohZq
	qiIvasKEIQa8WMBLc/P9Lrp6AR65HgSAeZUtL99fjvdteyRhHZc9F5KRU2GIqlkObPSF7kdq5
	96YsAyUQJLhPljCxx5nDBE5OQs2bQUGGb9R9ffPyRbzyKJNER7abw/idoLk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH] linux-user: Pass through nanosecond
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

On 14/05/2019 16:53, Chen-Yu Tsai wrote:
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
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> ---
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

Yes, the file is entirely indented with tabs, so you can let this as-is.
Anyway, I plan to split the file in several ones so we will be able to 
swap the tabs with spaces.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> 
> Finally, I think this could be worth backporting to older versions.
> ---
>   linux-user/syscall.c      | 18 ++++++++++++++++++
>   linux-user/syscall_defs.h | 36 ++++++++++++++++++------------------
>   2 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f5ff6f5dc8..dcd6f5d806 100644
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
> @@ -8866,6 +8876,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                   __put_user(st.st_atime, &target_st->target_st_atime);
>                   __put_user(st.st_mtime, &target_st->target_st_mtime);
>                   __put_user(st.st_ctime, &target_st->target_st_ctime);
> +#if _POSIX_C_SOURCE >= 200809L || _XOPEN_SOURCE >= 700
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
> index 12c8407144..252e69b76e 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -1192,11 +1192,11 @@ struct target_stat {
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
> @@ -1228,13 +1228,13 @@ struct target_stat64 {
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
> @@ -1313,13 +1313,13 @@ struct target_stat64 {
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
> @@ -1336,14 +1336,14 @@ struct target_stat {
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
> @@ -1371,16 +1371,16 @@ struct target_stat64 {
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


