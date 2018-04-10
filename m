Received: from eggs.gnu.org ([2001:4830:134:3::10]:57035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5vVd-0002e5-Mm
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5vVc-0003BV-Qb
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:48:37 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5vVc-0003BL-Kf
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:48:36 -0400
Received: by mail-oi0-x242.google.com with SMTP id t16-v6so11620568oih.3
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 08:48:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 16:48:15 +0100
Message-ID: <CAFEAcA_=b_=y0Q-Go2x1Q87=pquB4qAzAegdZTBYuEPUmVst8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 10 April 2018 at 13:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> Arm patch queue for 2.12 -- a miscellaneous collection
> of bug fixes.
>
> thanks
> -- PMM
>
>
> The following changes since commit fb4fe32d5b6290deabe752b51cc1cc2a9e8573db:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20180409-xtensa' into staging (2018-04-10 10:22:45 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180410
>
> for you to fetch changes up to bd49e6027cbc207c87633c7add3ebd7d3474cd35:
>
>   fpu: Fix rounding mode for floatN_to_uintM_round_to_zero (2018-04-10 13:02:26 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * fpu: Fix rounding mode for floatN_to_uintM_round_to_zero
>  * tcg: Fix guest state corruption when running 64-bit Arm
>    guests on a 32-bit host (especially when using icount)
>  * linux-user/signal.c: Ensure AArch64 signal frame isn't too small
>  * cpus.c: ensure running CPU recalculates icount deadlines on timer expiry
>  * target/arm: Report unsupported MPU region sizes more clearly
>  * hw/arm/fsl-imx: Fix introspection problem with fsl-imx6 and fsl-imx7
>  * hw/arm/allwinner-a10: Do not use nd_table in instance_init function
>  * hw/sd/bcm2835_sdhost: Don't raise spurious interrupts
>  * hw/sd/bcm2835_sdhost: Add tracepoints
>  * target-arm: Check undefined opcodes for SWP in A32 decoder
>  * hw/arm/integratorcp: Don't do things that could be fatal in the instance_init
>  * hw/arm: Allow manually specified /psci node
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
