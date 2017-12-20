Received: from eggs.gnu.org ([2001:4830:134:3::10]:57946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRgAp-000247-48
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRgAj-0002X5-7l
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:20:47 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:64972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRgAi-0002SR-Ta
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:20:41 -0500
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-3-michael.weiser@gmx.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bd78a6f5-f023-af5a-0d35-f3b29ae4e7a6@vivier.eu>
Date: Wed, 20 Dec 2017 16:20:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171219201613.7399-3-michael.weiser@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] linux-user: Add separate aarch64_be
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

Le 19/12/2017 à 21:16, Michael Weiser a écrit :
> Make big-endian aarch64 systems identify as aarch64_be as expected by
> big-endian userland and toolchains.
> 
> Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
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

For aarch64_be, I think the minimum release should be 4.9.0
(see kernel commit cfa88c79462d "arm64: Set UTS_MACHINE in the Makefile")

Thanks,
Laurent
