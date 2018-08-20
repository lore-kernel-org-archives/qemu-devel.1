Received: from eggs.gnu.org ([2001:4830:134:3::10]:39089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frkji-00086o-94
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frkjg-0001AW-24
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:00:48 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frkjf-0001A5-TH
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:00:47 -0400
Received: by mail-oi0-x22f.google.com with SMTP id q11-v6so25920931oic.12
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 07:00:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:00:26 +0100
Message-ID: <CAFEAcA-KLC4RaQsLD81wW7M+wRUA3Jy_K1DuWv0pScOxg1Md7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 20 August 2018 at 11:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> Some more outstanding target-arm patches; nothing terribly
> exciting. Mostly they're mine; I'm trying to reduce the
> number of patches I still have in flight, so I've picked
> out some of the reviewed patches from a couple of sets I've
> sent out and will resend v2 versions of those sets with the
> remaining patches with fixes for issues noted in review once
> this is in master.
>
> thanks
> -- PMM
>
>
> The following changes since commit adaec191bfb31e12d40af8ab1b869f5b40d61ee9:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-08-20 09:48:03 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180820
>
> for you to fetch changes up to b85fad1588e812566f897f747e38da345a7016d6:
>
>   hw/dma/pl080: Remove hw_error() if DMA is enabled (2018-08-20 11:24:33 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix crash on conditional instruction in an IT block
>  * docs/generic-loader: mention U-Boot and Intel HEX executable formats
>  * hw/intc/arm_gicv3_its: downgrade error_report to warn_report in kvm_arm_its_reset
>  * imx_serial: Generate interrupt on receive data ready if enabled
>  * Fix various minor bugs in AArch32 Hyp related coprocessor registers
>  * Permit accesses to ELR_Hyp from Hyp mode via MSR/MRS (banked)
>  * Implement AArch32 ERET instruction
>  * hw/arm/virt: Add virt-3.1 machine type
>  * sdhci: add i.MX SD Stable Clock bit
>  * Remove now-obsolete MMIO request_ptr APIs
>  * hw/timer/m48t59: Move away from old_mmio accessors
>  * hw/watchdog/cmsdk_apb_watchdog: Implement CMSDK APB watchdog module
>  * nvic: Expose NMI line
>  * hw/dma/pl080: cleanups and new features required for use in MPS boards
>

Applied, thanks.

-- PMM
