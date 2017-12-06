Received: from eggs.gnu.org ([2001:4830:134:3::10]:57897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1eMczk-0005Pw-Bg
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1eMczj-0004k0-Dp
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 11:56:28 -0500
Date: Wed, 6 Dec 2017 23:56:07 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20171206165607.GB1971@toto>
References: <cover.1508261326.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1508261326.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/8]  Add the ZynqMP PMU and IPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com, alistair23@gmail.com, qemu-arm@nongnu.org

On Tue, Oct 17, 2017 at 10:29:41AM -0700, Alistair Francis wrote:
> This series adds the ZynqMP Power Management Unit (PMU) machine with basic
> functionality.
> 
> The machine only has the
>  - CPU
>  - Memory
>  - Interrupt controller
>  - IPI device
> 
> connected, but that is enough to run some of the ROM and firmware
> code on the machine
> 
> The series also adds the IPI device and connects it to the ZynqMP ARM
> side and the ZynqMP PMU. These IPI devices don't connect between the ARM
> and MicroBlaze instances though.


Thanks Alistair,

I've merged this into mb-next for 2.12.
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Best regards,
Edgar


> 
> V4:
>  - Rename the ZCU102 machine to just ZynqMP
>  - Rename the PMC SoC to "xlnx,zynqmp-pmu-soc"
>  - Move the IPI device to the machine instead of the SoC
> V3:
>  - Add the interrupt controller
>  - Replace some of the error_fatals with errp
>  - Fix the PMU CPU name
> 
> 
> Alistair Francis (8):
>   xlnx-zynqmp-pmu: Initial commit of the ZynqMP PMU
>   xlnx-zynqmp-pmu: Add the CPU and memory
>   aarch64-softmmu.mak: Use an ARM specific config
>   xlnx-pmu-iomod-intc: Add the PMU Interrupt controller
>   xlnx-zynqmp-pmu: Connect the PMU interrupt controller
>   xlnx-zynqmp-ipi: Initial version of the Xilinx IPI device
>   xlnx-zynqmp-pmu: Connect the IPI device to the PMU
>   xlnx-zynqmp: Connect the IPI device to the ZynqMP SoC
> 
>  default-configs/aarch64-softmmu.mak    |   1 +
>  default-configs/microblaze-softmmu.mak |   1 +
>  hw/arm/Makefile.objs                   |   2 +-
>  hw/arm/xlnx-zynqmp.c                   |  14 +
>  hw/display/Makefile.objs               |   2 +-
>  hw/dma/Makefile.objs                   |   2 +-
>  hw/intc/Makefile.objs                  |   2 +
>  hw/intc/xlnx-pmu-iomod-intc.c          | 554 +++++++++++++++++++++++++++++++++
>  hw/intc/xlnx-zynqmp-ipi.c              | 377 ++++++++++++++++++++++
>  hw/microblaze/Makefile.objs            |   1 +
>  hw/microblaze/xlnx-zynqmp-pmu.c        | 204 ++++++++++++
>  include/hw/arm/xlnx-zynqmp.h           |   2 +
>  include/hw/intc/xlnx-pmu-iomod-intc.h  |  58 ++++
>  include/hw/intc/xlnx-zynqmp-ipi.h      |  57 ++++
>  14 files changed, 1274 insertions(+), 3 deletions(-)
>  create mode 100644 hw/intc/xlnx-pmu-iomod-intc.c
>  create mode 100644 hw/intc/xlnx-zynqmp-ipi.c
>  create mode 100644 hw/microblaze/xlnx-zynqmp-pmu.c
>  create mode 100644 include/hw/intc/xlnx-pmu-iomod-intc.h
>  create mode 100644 include/hw/intc/xlnx-zynqmp-ipi.h
> 
> -- 
> 2.11.0
> 
