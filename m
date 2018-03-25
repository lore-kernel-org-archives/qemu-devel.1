Received: from eggs.gnu.org ([2001:4830:134:3::10]:59688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f07CQ-0004Kh-OC
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 11:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f07CP-0003G9-SW
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 11:04:46 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:41564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f07CP-0003Fr-NU
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 11:04:45 -0400
Received: by mail-ot0-x235.google.com with SMTP id i28-v6so18049990otf.8
	for <qemu-devel@nongnu.org>; Sun, 25 Mar 2018 08:04:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323184958.14252-1-peter.maydell@linaro.org>
References: <20180323184958.14252-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Mar 2018 16:04:24 +0100
Message-ID: <CAFEAcA_SvAsFKAs5fuSvE+XJNiDHKWT7pEe7dS+W8RazH204nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 23 March 2018 at 18:49, Peter Maydell <peter.maydell@linaro.org> wrote:
> Ten arm-related bug fixes for 2.12...
>
> thanks
> -- PMM
>
> The following changes since commit 4c2c1015905fa1d616750dfe024b4c0b35875950:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20180323' into staging (2018-03-23 10:20:54 +0000)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180323
>
> for you to fetch changes up to 548f514cf89dd9ab39c0cb4c063097bccf141fdd:
>
>   target/arm: Always set FAR to a known unknown value for debug exceptions (2018-03-23 18:26:46 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * arm/translate-a64: don't lose interrupts after unmasking via write to DAIF
>  * sdhci: fix incorrect use of Error *
>  * hw/intc/arm_gicv3: Fix secure-GIC NS ICC_PMR and ICC_RPR accesses
>  * hw/arm/bcm2836: Use the Cortex-A7 instead of Cortex-A15
>  * i.MX: Support serial RS-232 break properly
>  * mach-virt: Set VM's SMBIOS system version to mc->name
>  * target/arm: Honour MDCR_EL2.TDE when routing exceptions due to BKPT/BRK
>  * target/arm: Factor out code to calculate FSR for debug exceptions
>  * target/arm: Set FSR for BKPT, BRK when raising exception
>  * target/arm: Always set FAR to a known unknown value for debug exceptions
>

Applied, thanks.

-- PMM
