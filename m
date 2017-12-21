Received: from eggs.gnu.org ([2001:4830:134:3::10]:57955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRxga-0003Oe-0R
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRxgU-0000zV-EU
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:02:44 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:62015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRxgU-0000yx-4z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:02:38 -0500
References: <20171220212308.12614-1-michael.weiser@gmx.de>
	<20171220212308.12614-3-michael.weiser@gmx.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c8a75a80-b090-6cb3-7f66-392d7d881cb4@vivier.eu>
Date: Thu, 21 Dec 2017 11:02:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171220212308.12614-3-michael.weiser@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/7] linux-user: Add separate aarch64_be
 uname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 20/12/2017 à 22:23, Michael Weiser a écrit :
> Make big-endian aarch64 systems identify as aarch64_be as expected by
> big-endian userland and toolchains.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_syscall.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
> index 1b62953eeb..604ab99b14 100644
> --- a/linux-user/aarch64/target_syscall.h
> +++ b/linux-user/aarch64/target_syscall.h
> @@ -8,7 +8,11 @@ struct target_pt_regs {
>      uint64_t        pstate;
>  };
>  
> +#if defined(TARGET_WORDS_BIGENDIAN)
> +#define UNAME_MACHINE "aarch64_be"
> +#else
>  #define UNAME_MACHINE "aarch64"
> +#endif
>  #define UNAME_MINIMUM_RELEASE "3.8.0"
>  #define TARGET_CLONE_BACKWARDS
>  #define TARGET_MINSIGSTKSZ       2048
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
