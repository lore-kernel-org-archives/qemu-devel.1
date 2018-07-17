Received: from eggs.gnu.org ([2001:4830:134:3::10]:43904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffLnZ-0001Hf-Pv
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 04:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffLnY-0002rt-Sk
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 04:57:33 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffLnY-0002rl-NM
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 04:57:32 -0400
Received: by mail-oi0-x242.google.com with SMTP id 13-v6so648882ois.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 01:57:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180716164300.6731-1-peter.maydell@linaro.org>
References: <20180716164300.6731-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 09:57:11 +0100
Message-ID: <CAFEAcA_kjijJ0+qSkcHcMJpomVsV1exzr+m_b0i1n0stseFOjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 16 July 2018 at 17:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue: a smallish set of patches for rc1 tomorrow.
> I've included the tcg patches because RTH has no others that
> would merit a pullreq.
>
> I haven't included Thomas Huth's 17-patch set to deal with
> the introspection crashes, to give that a little more time
> on-list for review.
>
> thanks
> -- PMM
>
> The following changes since commit 102ad0a80f5110483efd06877c29c4236be267f9:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-07-16' into staging (2018-07-16 15:34:38 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180716
>
> for you to fetch changes up to 3474c98a2a2afcefa7c665f02ad2bed2a43ab0f7:
>
>   accel/tcg: Assert that tlb fill gave us a valid TLB entry (2018-07-16 17:26:01 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * accel/tcg: Use correct test when looking in victim TLB for code
>  * bcm2835_aux: Swap RX and TX interrupt assignments
>  * hw/arm/bcm2836: Mark the bcm2836 / bcm2837 devices with user_creatable = false
>  * hw/intc/arm_gic: Fix handling of GICD_ITARGETSR
>  * hw/intc/arm_gic: Check interrupt number in gic_deactivate_irq()
>  * aspeed: Implement write-1-{set, clear} for AST2500 strapping
>  * target/arm: Fix LD1W and LDFF1W (scalar plus vector)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
