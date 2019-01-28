Received: from eggs.gnu.org ([209.51.188.92]:36956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goBEW-000396-J9
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goB2m-0002aX-Lz
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:50:01 -0500
References: <20190128173940.25813-1-alex.bennee@linaro.org>
	<20190128173940.25813-4-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1fe0a234-c951-2862-8c6e-a2da8b9d7d88@vivier.eu>
Date: Mon, 28 Jan 2019 18:49:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190128173940.25813-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/4] linux-user/elfload: enable
 HWCAP_CPUID for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

On 28/01/2019 18:39, Alex Bennée wrote:
> Userspace programs should (in theory) query the ELF HWCAP before
> probing these registers. Now we have implemented them all make it
> public.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 4cff9e1a31..e95c162097 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -571,6 +571,7 @@ static uint32_t get_elf_hwcap(void)
>  
>      hwcaps |= ARM_HWCAP_A64_FP;
>      hwcaps |= ARM_HWCAP_A64_ASIMD;
> +    hwcaps |= ARM_HWCAP_A64_CPUID;
>  
>      /* probe for the extra features */
>  #define GET_FEATURE_ID(feat, hwcap) \
> 

Acked-by: Laurent Vivier <laurent@vivier.eu>
