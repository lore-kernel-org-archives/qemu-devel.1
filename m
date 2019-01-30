Received: from eggs.gnu.org ([209.51.188.92]:48410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goqJH-0000cZ-BN
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goqJG-0007ya-AM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:53:47 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1goqJF-0007vx-Vr
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:53:46 -0500
References: <20190125225714.10234-1-richard.henderson@linaro.org>
	<20190125225714.10234-4-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8d66f542-5471-c161-a23a-369a71b9429a@vivier.eu>
Date: Wed, 30 Jan 2019 14:53:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190125225714.10234-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] aarch64-linux-user: Update HWCAP bits
 from linux 5.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 25/01/2019 23:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 4cff9e1a31..3c7a7c2836 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -560,6 +560,15 @@ enum {
>      ARM_HWCAP_A64_ASIMDDP       = 1 << 20,
>      ARM_HWCAP_A64_SHA512        = 1 << 21,
>      ARM_HWCAP_A64_SVE           = 1 << 22,
> +    ARM_HWCAP_A64_ASIMDFHM      = 1 << 23,
> +    ARM_HWCAP_A64_DIT           = 1 << 24,
> +    ARM_HWCAP_A64_USCAT         = 1 << 25,
> +    ARM_HWCAP_A64_ILRCPC        = 1 << 26,
> +    ARM_HWCAP_A64_FLAGM         = 1 << 27,
> +    ARM_HWCAP_A64_SSBS          = 1 << 28,
> +    ARM_HWCAP_A64_SB            = 1 << 29,
> +    ARM_HWCAP_A64_PACA          = 1 << 30,
> +    ARM_HWCAP_A64_PACG          = 1UL << 31,
>  };
>  
>  #define ELF_HWCAP get_elf_hwcap()
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
