Received: from eggs.gnu.org ([2001:4830:134:3::10]:53162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fQWCy-0000Qp-Lj
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fQWCx-0004jo-R5
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 07:02:28 -0400
References: <20180606093101.30518-1-luc.michel@greensocs.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <3c53fcca-0bf1-affc-6778-94a493e3fc08@web.de>
Date: Wed, 6 Jun 2018 13:02:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180606093101.30518-1-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] arm_gic: add virtualization extensions
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luc.michel@greensocs.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jailhouse <jailhouse-dev@googlegroups.com>

On 2018-06-06 11:30, luc.michel@greensocs.com wrote:
> From: Luc MICHEL <luc.michel@greensocs.com>
> 
> This patch series add support for the virtualization extensions in the
> ARM GICv2 interrupt controller.
> 
> The first two commits do some refactoring to prepare for the
> implementation. Commits 3 and 4 are the actual implementation. The last
> commit updates the ZynqMP implementation to support virtualization.
> 
> The current state allows to boot Xen (tested with 4.8 and 4.10) with
> Linux Dom0 guest properly.
> 
> I also tested in SMP. It does not work directly because Xen expects to
> find CPU IDs in the GIC ITARGETSR0 register. This behavior is not
> documented in the GICv2 specification, and is not implemented in QEMU.
> By hacking this register, I was able to get the whole thing to boot in
> SMP properly. This hack is not part of those patches though.
> 
> I also tested migration, it works fine AFAIK. I had to add the HYP and
> SEC timers in the ARM CPU VMState though (Xen uses the HYP one) (not
> part of those patches).
> 
> I want to thanks the Xilinx's QEMU team who sponsored this work for
> their collaboration.
> 
> Luc MICHEL (6):
>   intc/arm_gic: Refactor operations on the distributor
>   intc/arm_gic: Remove some dead code and put some functions static
>   intc/arm_gic: Add the virtualization extensions to the GIC state
>   intc/arm_gic: Add virtualization extensions logic
>   intc/arm_gic: Improve traces
>   xlnx-zynqmp: Improve GIC wiring and MMIO mapping
> 
>  hw/arm/xlnx-zynqmp.c             |  92 +++-
>  hw/intc/arm_gic.c                | 768 ++++++++++++++++++++++++-------
>  hw/intc/arm_gic_common.c         | 159 +++++--
>  hw/intc/arm_gic_kvm.c            |  31 +-
>  hw/intc/gic_internal.h           | 258 +++++++++--
>  hw/intc/trace-events             |  12 +-
>  include/hw/arm/xlnx-zynqmp.h     |   4 +-
>  include/hw/intc/arm_gic_common.h |  52 ++-
>  8 files changed, 1128 insertions(+), 248 deletions(-)
> 
> --
> 2.17.0
> 

Cool! We will give this a try with Jailhouse as well.

Jan
