Received: from eggs.gnu.org ([2001:4830:134:3::10]:38151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2yhb-00034T-4f
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2yha-0005TI-AW
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:32:15 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2yha-0005SZ-32
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:32:14 -0400
Received: by mail-wm0-x235.google.com with SMTP id r190so93361807wme.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 04:32:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170422190709.8676-1-krzk@kernel.org>
References: <20170422190709.8676-1-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 12:31:52 +0100
Message-ID: <CAFEAcA_jwtKpR7a7sHRtWmRcp+2g0Y3+UDm=5LW0o26hBBTGZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/exynos: Add generic SDHCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 April 2017 at 20:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Exynos4210 has four SD/MMC controllers supporting:
>  - SD Standard Host Specification Version 2.0,
>  - MMC Specification Version 4.3,
>  - SDIO Card Specification Version 2.0,
>  - DMA and ADMA.
>
> Add emulation of SDHCI devices which allows accessing storage through SD
> cards. Differences from real hardware:
>  - Devices are shipped with eMMC memory, not SD card.
>  - The Exynos4210 SDHCI has few more registers, e.g. for
>    controlling the clocks, additional status (0x80, 0x84, 0x8c). These
>    are not implemented.
>
> Testing on smdkc210 machine with "-drive file=FILE,if=sd,bus=0,index=2".
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to master, thanks (since this is the only thing in my
ARM to-review queue...)

-- PMM
