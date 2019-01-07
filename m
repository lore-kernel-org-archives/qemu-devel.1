Received: from eggs.gnu.org ([209.51.188.92]:38553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggZZe-00067d-VW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggZZd-0004U3-CK
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:24:30 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:46704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggZZa-0004Hs-NK
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:24:27 -0500
Received: by mail-ot1-x333.google.com with SMTP id w25so1145342otm.13
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 10:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20190107163117.16269-1-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 18:24:14 +0000
Message-ID: <CAFEAcA8FUq+ppCL+gnYr1Xa0HtCi9+bC5k-A2OP18Pf-7F00Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/37] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 7 Jan 2019 at 16:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> target-arm queue: the big things here are the new nRF51
> (microbit) devices and Luc's gdbstub multiprocess work.
>
> thanks
> -- PMM
>
> The following changes since commit a29644590f95166c8a13e5797f8e7701134b31d0:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-01-05' into staging (2019-01-07 11:55:52 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190107
>
> for you to fetch changes up to f831f955d420966471f5f8b316ba50d2523b1ff0:
>
>   Support u-boot noload images for arm as used by, NetBSD/evbarm GENERIC kernel. (2019-01-07 15:46:20 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Support u-boot 'noload' images for Arm (as used by NetBSD/evbarm GENERIC kernel)
>  * hw/misc/tz-mpc: Fix value of BLK_MAX register
>  * target/arm: Emit barriers for A32/T32 load-acquire/store-release insns
>  * nRF51 SoC: add timer, GPIO, RNG peripherals
>  * hw/arm/allwinner-a10: Add the 'A' SRAM and the SRAM controller
>  * cpus.c: Fix race condition in cpu_stop_current()
>  * hw/arm: versal: Plug memory leaks
>  * Allow M profile boards to run even if -kernel not specified
>  * gdbstub: Add multiprocess extension support for use when the
>    board has multiple CPUs of different types (like the Xilinx Zynq boards)
>  * target/arm: Don't decode S bit in SVE brk[ab] merging insns
>  * target/arm: Convert ARM_TBFLAG_* to FIELDs


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
