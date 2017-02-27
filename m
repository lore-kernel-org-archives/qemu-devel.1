Received: from eggs.gnu.org ([2001:4830:134:3::10]:50087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciLQB-0001bZ-1g
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciLQ9-0006px-RG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:32:59 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciLQ9-0006pV-KQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:32:57 -0500
Received: by mail-wr0-x22a.google.com with SMTP id u48so2522116wrc.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:32:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170226200142.31169-1-krzk@kernel.org>
References: <20170226200142.31169-1-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 13:32:35 +0000
Message-ID: <CAFEAcA8FGe3-yeDQDDqK89KDBBNzwVTGzxaEdNzE+yjBg8SbjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/arm/exynos: Fix Linux kernel
 division by zero for PLLs
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

On 26 February 2017 at 20:01, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Without any clock controller, the Linux kernel was hitting division by
> zero during boot or with clk_summary:
> [    0.000000] [<c031054c>] (unwind_backtrace) from [<c030ba6c>] (show_stack+0x10/0x14)
> [    0.000000] [<c030ba6c>] (show_stack) from [<c05b2660>] (dump_stack+0x88/0x9c)
> [    0.000000] [<c05b2660>] (dump_stack) from [<c05b11a4>] (Ldiv0+0x8/0x10)
> [    0.000000] [<c05b11a4>] (Ldiv0) from [<c06ad1e0>] (samsung_pll45xx_recalc_rate+0x58/0x74)
> [    0.000000] [<c06ad1e0>] (samsung_pll45xx_recalc_rate) from [<c0692ec0>] (clk_register+0x39c/0x63c)
> [    0.000000] [<c0692ec0>] (clk_register) from [<c125d360>] (samsung_clk_register_pll+0x2e0/0x3d4)
> [    0.000000] [<c125d360>] (samsung_clk_register_pll) from [<c125d7e8>] (exynos4_clk_init+0x1b0/0x5e4)
> [    0.000000] [<c125d7e8>] (exynos4_clk_init) from [<c12335f4>] (of_clk_init+0x17c/0x210)
> [    0.000000] [<c12335f4>] (of_clk_init) from [<c1204700>] (time_init+0x24/0x2c)
> [    0.000000] [<c1204700>] (time_init) from [<c1200b2c>] (start_kernel+0x24c/0x38c)
> [    0.000000] [<c1200b2c>] (start_kernel) from [<4020807c>] (0x4020807c)
>
> Provide stub for clock controller returning reset values for PLLs.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---



Applied both to target-arm.next, thanks.

-- PMM
