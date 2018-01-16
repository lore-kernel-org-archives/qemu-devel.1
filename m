Received: from eggs.gnu.org ([2001:4830:134:3::10]:34440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebai2-0008Q9-7U
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ebai1-0004nB-6H
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:32:02 -0500
MIME-Version: 1.0
In-Reply-To: <cover.1516144891.git.alistair.francis@xilinx.com>
References: <cover.1516144891.git.alistair.francis@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jan 2018 15:31:29 -0800
Message-ID: <CAKmqyKPE6cheSsr_k9QcJaX8K-wn1iV54Ozr585NTGoBwB1VPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Add the ZynqMP PMU and IPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Tue, Jan 16, 2018 at 3:22 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
>
> This series adds the ZynqMP Power Management Unit (PMU) machine with basi=
c
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
>
> V5:
>  - Fix clang makecheck error
>  - Rebase on master
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
>
> Alistair Francis (9):
>   microblaze: boot.c: Don't try to find NULL pointer
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
>  hw/dma/Makefile.objs                   |   1 +
>  hw/intc/Makefile.objs                  |   2 +
>  hw/intc/xlnx-pmu-iomod-intc.c          | 554 +++++++++++++++++++++++++++=
++++++
>  hw/intc/xlnx-zynqmp-ipi.c              | 377 ++++++++++++++++++++++
>  hw/microblaze/Makefile.objs            |   1 +
>  hw/microblaze/boot.c                   |   2 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c        | 204 ++++++++++++
>  include/hw/arm/xlnx-zynqmp.h           |   2 +
>  include/hw/intc/xlnx-pmu-iomod-intc.h  |  58 ++++
>  include/hw/intc/xlnx-zynqmp-ipi.h      |  57 ++++
>  15 files changed, 1275 insertions(+), 3 deletions(-)
>  create mode 100644 hw/intc/xlnx-pmu-iomod-intc.c
>  create mode 100644 hw/intc/xlnx-zynqmp-ipi.c
>  create mode 100644 hw/microblaze/xlnx-zynqmp-pmu.c
>  create mode 100644 include/hw/intc/xlnx-pmu-iomod-intc.h
>  create mode 100644 include/hw/intc/xlnx-zynqmp-ipi.h
>
> --
> 2.14.1
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.

ARGH! Apparently Xilinx started this crap up again. I didn't realise
this is on all my emails. I'll work on getting it removed.

Alistair
