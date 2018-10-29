Received: from eggs.gnu.org ([2001:4830:134:3::10]:46037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH8QX-00039r-Uc
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH8QX-0005a4-2q
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:21:57 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH8QW-0005Zi-GT
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:21:56 -0400
Received: by mail-oi1-x241.google.com with SMTP id v83-v6so1237626oia.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 07:21:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181022173559.17111-1-edgar.iglesias@gmail.com>
References: <20181022173559.17111-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 14:21:31 +0000
Message-ID: <CAFEAcA_i0MHixDocr95Dhedj1jqHxA7JPg_1qbW+eAK8qQefcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/4] arm: Add first models of Xilinx
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

On 22 October 2018 at 18:35, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
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
>
>
> In QEMU we'd like to have a virtual developer board with the Versal SoC
> and a selected set of peripherals under the control of QEMU.
> We'd like to gradually extend this board as QEMU gains more support
> for Versal hardware components. QEMU will generate a device-tree
> describing only the components it supports and includes in the virtual
> dev board.
>
> Before adding Versal support, this series starts with a few fixes to the
> GEM that I ran into when running recent kernels on the Versal and ZynqMP
> models.
>
> I also noticed a problem with HVC insns not being enabled when using
> QEMU's PSCI implementation on CPU's with EL2 and EL3 enabled. This causes
> problems for Linux/KVM guests, also fixed in this series.

Applied patches 3 and 4 to target-arm.next (1 and 2 being already
in master), thanks.

-- PMM
