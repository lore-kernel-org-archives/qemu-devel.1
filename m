Received: from eggs.gnu.org ([2001:4830:134:3::10]:44342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e1iAa-0005FF-JH
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e1iAZ-0004dc-HO
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:13:12 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171008222029.GA29979@toto>
References: <cover.1505929556.git.alistair.francis@xilinx.com>
	<20171008222029.GA29979@toto>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 9 Oct 2017 17:12:39 -0700
Message-ID: <CAKmqyKMEbQ3JbqMxeeOTBV92ixRVDfw1wFi57xNKGyF82DSC_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Add the ZynqMP PMU and IPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Sun, Oct 8, 2017 at 3:20 PM, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> On Wed, Sep 20, 2017 at 03:01:31PM -0700, Alistair Francis wrote:
>>
>> This series adds the ZynqMP Power Management Unit (PMU) machine with basic
>> functionality.
>>
>> The machine only has the
>>  - CPU
>>  - Memory
>>  - Interrupt controller
>>  - IPI device
>>
>> connected, but that is enough to run some of the ROM and firmware
>> code on the machine
>>
>> The series also adds the IPI device and connects it to the ZynqMP ARM
>> side and the ZynqMP PMU. These IPI devices don't connect between the ARM
>> and MicroBlaze instances though.
>>
>> v3:
>>  - Add the interrupt controller
>>  - Replace some of the error_fatals with errp
>>  - Fix the PMU CPU name
>
> Hi Alistair,
>
>
> Sorry for the super long delay...
>
> I think this mostly looks good but I was wondering if we really need
> to have a board specific (zcu102) PMU?

It doesn't have to be board specific. What I wanted though was an SoC
and a machine so that maybe one day we could add the PMU SoC to the
ARM ZCU102 machine. After that it was hard to think of a name to
differentiate the SoC and the machine. Do you have a recommendation on
names?

Thanks,
Alistair

>
> Best regards,
> Edgar
>
>
>
>>
>>
>>
>> Alistair Francis (8):
>>   xlnx-zynqmp-pmu: Initial commit of the ZynqMP PMU
>>   xlnx-zynqmp-pmu: Add the CPU and memory
>>   aarch64-softmmu.mak: Use an ARM specific config
>>   xlnx-pmu-iomod-intc: Add the PMU Interrupt controller
>>   xlnx-zynqmp-pmu: Connect the PMU interrupt controller
>>   xlnx-zynqmp-ipi: Initial version of the Xilinx IPI device
>>   xlnx-zynqmp-pmu: Connect the IPI device to the PMU
>>   xlnx-zynqmp: Connect the IPI device to the ZynqMP SoC
>>
>>  default-configs/aarch64-softmmu.mak    |   1 +
>>  default-configs/microblaze-softmmu.mak |   1 +
>>  hw/arm/Makefile.objs                   |   2 +-
>>  hw/arm/xlnx-zynqmp.c                   |  14 +
>>  hw/display/Makefile.objs               |   2 +-
>>  hw/dma/Makefile.objs                   |   2 +-
>>  hw/intc/Makefile.objs                  |   2 +
>>  hw/intc/xlnx-pmu-iomod-intc.c          | 554 +++++++++++++++++++++++++++++++++
>>  hw/intc/xlnx-zynqmp-ipi.c              | 377 ++++++++++++++++++++++
>>  hw/microblaze/Makefile.objs            |   1 +
>>  hw/microblaze/xlnx-zynqmp-pmu.c        | 200 ++++++++++++
>>  include/hw/arm/xlnx-zynqmp.h           |   2 +
>>  include/hw/intc/xlnx-pmu-iomod-intc.h  |  58 ++++
>>  include/hw/intc/xlnx-zynqmp-ipi.h      |  57 ++++
>>  14 files changed, 1270 insertions(+), 3 deletions(-)
>>  create mode 100644 hw/intc/xlnx-pmu-iomod-intc.c
>>  create mode 100644 hw/intc/xlnx-zynqmp-ipi.c
>>  create mode 100644 hw/microblaze/xlnx-zynqmp-pmu.c
>>  create mode 100644 include/hw/intc/xlnx-pmu-iomod-intc.h
>>  create mode 100644 include/hw/intc/xlnx-zynqmp-ipi.h
>>
>> --
>> 2.11.0
>>
