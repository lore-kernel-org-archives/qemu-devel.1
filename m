Received: from eggs.gnu.org ([2001:4830:134:3::10]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvNH9-0001Ve-BS
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvNH8-0007cy-Eh
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:09:31 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvNH8-0007cc-7R
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:09:30 -0400
Received: by mail-wr0-x22a.google.com with SMTP id w11so210275346wrc.3
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 05:09:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170318192509.15499-1-krzk@kernel.org>
References: <20170318192509.15499-1-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 13:09:08 +0100
Message-ID: <CAFEAcA8WGoa=DYXRH4MHfnHmUR_5-xERdmcuqrsk=bmS7GBCmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc: Add Exynos4210 Pseudo Random
 Number Generator
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

On 18 March 2017 at 19:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Add emulation for Exynos4210 Pseudo Random Number Generator which could
> work on fixed seeds or with seeds provided by True Random Number
> Generator block inside the SoC.
>
> Implement only the fixed seeds part of it in polling mode (no
> interrupts).  Simple testing:
>     # echo "exynos" > /sys/class/misc/hw_random/rng_current
>     # dd if=/dev/hwrng of=/dev/null bs=1 count=16
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Use GRand-like functions to fix build on MingW32 (this adds also
>    finalize).
> 2. Add DPRINTF macro.
> 3. Use HWADDR_PRIx and family for printing values.

Is there a data sheet that describes this RNG? I had a quick google
but couldn't find anything in the 4210 manual you can get from Samsung.

In particular I'm not sure we want to use GRand here.

thanks
-- PMM
