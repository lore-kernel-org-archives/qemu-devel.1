Received: from eggs.gnu.org ([2001:4830:134:3::10]:60077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMyj-0003vy-ID
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMyi-0006IL-I3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:53:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCMyi-00066b-8g
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:53:32 -0400
Received: by mail-ot1-x341.google.com with SMTP id k9so22021184otl.10
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 03:53:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181011021931.4249-1-edgar.iglesias@gmail.com>
References: <20181011021931.4249-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 11:53:07 +0100
Message-ID: <CAFEAcA8AEakm=zU9OYmreRmA=_J5aBR-E_nHDLh+fVRpHCZQNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/12] arm: Add first models of Xilinx
 Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 11 October 2018 at 03:19, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> This patch series adds initial support for Xilinx's Versal SoC.
> Xilinx is introducing Versal, an adaptive compute acceleration platform
> (ACAP), built on 7nm FinFET process technology. Versal ACAPs combine Scalar
> Processing Engines, Adaptable Hardware Engines, and Intelligent Engines with
> leading-edge memory and interfacing technologies to deliver powerful
> heterogeneous acceleration for any application. The Versal AI Core series has
> five devices, offering 128 to 400 AI Engines. The series includes dual-core Arm
> Cortex-A72 application processors, dual-core Arm Cortex-R5 real-time
> processors, 256KB of on-chip memory with ECC, more than 1,900 DSP engines
> optimized for high-precision floating point with low latency.
>
> More info can be found here:
> https://www.xilinx.com/news/press/2018/xilinx-unveils-versal-the-first-in-a-new-category-of-platforms-delivering-rapid-innovation-with-software-programmability-and-scalable-ai-inference.html

> Edgar E. Iglesias (12):
>   net: cadence_gem: Disable TSU feature bit
>   net: cadence_gem: Announce availability of priority queues
>   net: cadence_gem: Use uint32_t for 32bit descriptor words
>   net: cadence_gem: Add macro with max number of descriptor words
>   net: cadence_gem: Add support for extended descriptors
>   net: cadence_gem: Add support for selecting the DMA MemoryRegion
>   net: cadence_gem: Implement support for 64bit descriptor addresses
>   net: cadence_gem: Announce 64bit addressing support
>   target-arm: powerctl: Enable HVC when starting CPUs to EL2
>   target/arm: Add the Cortex-A72
>   hw/arm: versal: Add a model of Xilinx Versal SoC
>   hw/arm: versal: Add a virtual Xilinx Versal board

Hi; this series is still on my to-review queue, but to start with
I'm going to apply patches 1-10 (the cadence_gem fixes and the
target/arm changes) to target-arm.next.

thanks
-- PMM
