Received: from eggs.gnu.org ([2001:4830:134:3::10]:50866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCSyC-0007vc-FO
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCSyA-0003PF-Gs
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:17:24 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCSy9-0003Ih-Dz
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:17:22 -0400
Received: by mail-oi1-x242.google.com with SMTP id e17-v6so18704026oig.12
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:17:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181016164243.13855-1-peter.maydell@linaro.org>
References: <20181016164243.13855-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 18:16:54 +0100
Message-ID: <CAFEAcA9vpWQ5T7=JyUFMZhf6D5TW6Bq6-RAuOQtaoa2haLw1aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 16 October 2018 at 17:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> v2: dropped a couple of cadence_gem changes to ID regs that
> caused new clang sanitizer warnings.
>
> -- PMM
>
> The following changes since commit dddb37495b844270088e68e3bf30b764d48d863f:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20181015.0' into staging (2018-10-15 18:44:04 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181016-1
>
> for you to fetch changes up to 2ef297af07196c29446556537861f8e7dfeeae7b:
>
>   coccinelle: new inplace-byteswaps.cocci to remove inplace-byteswapping calls (2018-10-16 17:14:55 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm/virt: add DT property /secure-chosen/stdout-path indicating secure UART
>  * target/arm: Fix aarch64_sve_change_el wrt EL0
>  * target/arm: Define fields of ISAR registers
>  * target/arm: Align cortex-r5 id_isar0
>  * target/arm: Fix cortex-a7 id_isar0
>  * net/cadence_gem: Fix various bugs, add support for new
>    features that will be used by the Xilinx Versal board
>  * target-arm: powerctl: Enable HVC when starting CPUs to EL2
>  * target/arm: Add the Cortex-A72
>  * target/arm: Mark PMINTENCLR and PMINTENCLR_EL1 accesses as possibly doing IO
>  * target/arm: Mask PMOVSR writes based on supported counters
>  * target/arm: Initialize ARMMMUFaultInfo in v7m_stack_read/write
>  * coccinelle: new inplace-byteswaps.cocci to remove inplace-byteswapping calls
>

Applied, thanks.

-- PMM
