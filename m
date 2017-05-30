Received: from eggs.gnu.org ([2001:4830:134:3::10]:50349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFfvu-0005Q7-LD
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFfvq-0001oT-Qr
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:07:30 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFfvq-0001oC-Ju
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:07:26 -0400
Received: by mail-wm0-x231.google.com with SMTP id e127so97747956wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 05:07:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170507181940.25882-1-krzk@kernel.org>
References: <20170507181940.25882-1-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 13:07:05 +0100
Message-ID: <CAFEAcA9QY253FP9mj6CfyHoxLJ8F-NrxGJOMKiM_yFN-RE2Syw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] hw/arm/exynos: QOM-ify the SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 7 May 2017 at 19:19, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> Changes since v1:
> =================
> 1. s/RAM/DRAM/ in commit msg of first patch (as suggested by Philippe).
> 2. Add Philippe's reviewed-by.
>
>
> Convert the Exynos4210 SoC driver into QOM model.
>
> No external dependencies, rebased on v2.9.0-363-g0de9191deb14.
>
> Best regards,
> Krzysztof
>
>
> Krzysztof Kozlowski (3):
>   hw/arm/exynos: Move DRAM initialization next boards
>   hw/arm/exynos: Declare local variables in some order
>   hw/arm/exynos: QOM-ify the SoC



Applied to target-arm.next, thanks.

-- PMM
