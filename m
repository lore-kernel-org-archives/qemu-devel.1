Received: from eggs.gnu.org ([2001:4830:134:3::10]:40847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gWqpR-0006WM-3Q
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gWqpN-0007TP-R3
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:48:36 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gWqpN-0007SQ-Fy
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:48:33 -0500
Received: by mail-pf1-x443.google.com with SMTP id b85so7850194pfc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 14:48:33 -0800 (PST)
Date: Tue, 11 Dec 2018 14:48:31 -0800 (PST)
In-Reply-To: <cover.1544567709.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-b51f090f-6ece-4e17-9527-04f73763de4d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 0/4] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com, stephen@eideticom.com

On Tue, 11 Dec 2018 14:37:07 PST (-0800), Alistair Francis wrote:
> This series is now ready to be merged, all of the patches are reviewed
> and tested.
>
> Palmer can you take this with all the other RISC-V patches sent during
> the freeze?

Yep, I'll be collecting everything this week.

Thanks!

>
> V8:
>  - Drop SiFive U support
>  - Drop legacy -nic support
>  - Small other review changes
> V7:
>  - Fix the GPEX memory mapping thanks to Bin Meng
>  - Fix the interrupt mapping thanks to Logan Gunthorpe
> V6:
>  - Fix the interrupt issue for the GPEX device
> V5:
>  - Rebase
>  - Include pci.mak in the default configs
> V4:
>  - Fix the spike device tree
>  - Don't use stdvga device
> V3:
>  - Remove Makefile config changes
>  - Connect a network adapter to the virt device
> V2:
>  - Use the gpex PCIe host for virt
>  - Add support for SiFive U PCIe
>
>
> Alistair Francis (4):
>   hw/riscv/virt: Increase the number of interrupts
>   hw/riscv/virt: Adjust memory layout spacing
>   hw/riscv/virt: Connect the gpex PCIe
>   riscv: Enable VGA and PCIE_VGA
>
>  default-configs/riscv32-softmmu.mak |   8 +-
>  default-configs/riscv64-softmmu.mak |   8 +-
>  hw/riscv/virt.c                     | 147 ++++++++++++++++++++++++++--
>  include/hw/riscv/virt.h             |  15 ++-
>  4 files changed, 165 insertions(+), 13 deletions(-)
>
> -- 
> 2.19.1
