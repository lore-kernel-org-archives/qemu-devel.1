Received: from eggs.gnu.org ([2001:4830:134:3::10]:58401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTms-0001gn-OM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTmr-0008V0-UE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:41:06 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjTmr-0008Uo-NF
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:41:05 -0500
Received: by mail-wm0-x22a.google.com with SMTP id n11so29341193wma.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 08:41:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301182618.22395-6-krzk@kernel.org>
References: <20170301182618.22395-1-krzk@kernel.org>
	<20170301182618.22395-6-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 16:40:44 +0000
Message-ID: <CAFEAcA8JF0vY0MOs=3MUnSUAdiYPKV6E4w611UeUD55hzV9pfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 5/5] hw/timer/exynos4210_mct: Remove unused
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>

On 1 March 2017 at 18:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove defines not used anywhere.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  hw/timer/exynos4210_mct.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index 4dd3e441e2e6..6069116942a4 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -172,13 +172,10 @@ enum LocalTimerRegCntIndexes {
>      L_REG_CNT_AMOUNT
>  };
>
> -#define MCT_NIRQ                6
>  #define MCT_SFR_SIZE            0x444
>
>  #define MCT_GT_CMP_NUM          4
>
> -#define MCT_GT_MAX_VAL          UINT64_MAX
> -
>  #define MCT_GT_COUNTER_STEP     0x100000000ULL
>  #define MCT_LT_COUNTER_STEP     0x100000000ULL
>  #define MCT_LT_CNT_LOW_LIMIT    0x100
> --
> 2.9.3

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
