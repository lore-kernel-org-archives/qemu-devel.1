Received: from eggs.gnu.org ([2001:4830:134:3::10]:54762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCvIg-0005dy-DB
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 19:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCvIb-000203-Vt
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 19:32:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCvIa-0001xE-Ne
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 19:32:21 -0400
References: <20181017215422.3973-1-palmer@sifive.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc39293f-9d79-a3d3-9e39-9e4680e6bbb4@redhat.com>
Date: Wed, 17 Oct 2018 18:32:10 -0500
MIME-Version: 1.0
In-Reply-To: <20181017215422.3973-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL] First RISC-V Patch Set for the 3.1 Soft
 Freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org

On 10/17/18 4:54 PM, Palmer Dabbelt wrote:
> The following changes since commit 09558375a634e17cea6cfbfec883ac2376d2dc7f:
> 
>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)
> 
> are available in the Git repository at:
> 
>    git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-sf0
> 
> for you to fetch changes up to 7c28f4da20e5585dce7d575691dac5392b7c6f78:
> 
>    RISC-V: Don't add NULL bootargs to device-tree (2018-10-17 13:02:30 -0700)
> 
> ----------------------------------------------------------------
> First RISC-V Patch Set for the 3.1 Soft Freeze
> 

> ----------------------------------------------------------------
> Michael Clark (5):
>        RISC-V: Allow setting and clearing multiple irqs
>        RISC-V: Move non-ops from op_helper to cpu_helper
>        RISC-V: Update CSR and interrupt definitions
>        RISC-V: Add missing free for plic_hart_config
>        RISC-V: Don't add NULL bootargs to device-tree
> 

Isn't this just a subset of Alistair's pull request?
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02342.html

which included:
> ----------------------------------------------------------------
> Alistair Francis (5):
>       hw/riscv/virt: Increase the number of interrupts
>       hw/riscv/virt: Connect the gpex PCIe
>       riscv: Enable VGA and PCIE_VGA
>       hw/riscv/sifive_u: Connect the Xilinx PCIe
>       hw/riscv/virt: Connect a VirtIO net PCIe device
> 
> Michael Clark (5):
>       RISC-V: Allow setting and clearing multiple irqs
>       RISC-V: Move non-ops from op_helper to cpu_helper
>       RISC-V: Update CSR and interrupt definitions
>       RISC-V: Add missing free for plic_hart_config
>       RISC-V: Don't add NULL bootargs to device-tree


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
