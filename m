Received: from eggs.gnu.org ([2001:4830:134:3::10]:47143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIe5r-0005HC-T7
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIe5q-0005Zd-QG
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:22:51 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIe5q-0005Pv-Gf
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 14:22:50 -0400
Received: by mail-ot1-x343.google.com with SMTP id g10so2471508otl.12
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 11:22:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181102171638.24069-1-peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 18:22:09 +0000
Message-ID: <CAFEAcA9kDVH92UQXcrDTu=iNW7tGsYwTpjwoqfBM5UxL27x4zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/10] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 2 November 2018 at 17:16, Peter Maydell <peter.maydell@linaro.org> wrote:
> This is a respin of my pull request from earlier this week:
>  * versal board compile failure fixed
>  * a few new patches:
>   - MAINTAINERS file fix
>   - use ARRAY_SIZE macro in xilinx_zynq
>   - avoid an array overrun in strongarm GPIO irq handling
>   - fix an assert running KVM on an aarch64-only host
>
> The following changes since commit 69e2d03843412b9c076515b3aa9a71db161b6a1a:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-for-master-3.1-sf1' into staging (2018-11-02 13:16:13 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181102
>
> for you to fetch changes up to 6f16da53ffe4567c0353f85055df04860eb4e6fc:
>
>   hw/arm: versal: Add a virtual Xilinx Versal board (2018-11-02 14:11:31 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * microbit: Add the UART to our nRF51 SoC model
>  * Add a virtual Xilinx Versal board "xlnx-versal-virt"
>  * hw/arm/virt: Set VIRT_COMPAT_3_0 compat
>  * MAINTAINERS: Remove bouncing email in ARM ACPI
>  * strongarm: mask off high[31:28] bits from dir and state registers
>  * target/arm: Conditionalize some asserts on aarch32 support
>  * hw/arm/xilinx_zynq: Use the ARRAY_SIZE macro
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
