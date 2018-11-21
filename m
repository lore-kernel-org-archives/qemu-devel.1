Received: from eggs.gnu.org ([2001:4830:134:3::10]:58195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPX3p-0000OB-5o
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPWoW-0000z8-Dv
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:01:26 -0500
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<86e2120f18412152ed2994b72bd874120b86d749.1542819633.git.alistair.francis@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b49b54bf-2548-5a6b-1808-511b57cd33ad@deltatee.com>
Date: Wed, 21 Nov 2018 11:01:10 -0700
MIME-Version: 1.0
In-Reply-To: <86e2120f18412152ed2994b72bd874120b86d749.1542819633.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 3/6] hw/riscv/virt: Connect the
 gpex PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "abologna@redhat.com" <abologna@redhat.com>



On 2018-11-21 10:02 a.m., Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> index 7937c69e22..3e3d195f37 100644
> --- a/default-configs/riscv32-softmmu.mak
> +++ b/default-configs/riscv32-softmmu.mak
> @@ -1,7 +1,11 @@
>  # Default configuration for riscv-softmmu
>  
> +include pci.mak
> +
>  CONFIG_SERIAL=y
>  CONFIG_VIRTIO_MMIO=y
> -include virtio.mak
>  
>  CONFIG_CADENCE=y
> +
> +CONFIG_PCI_GENERIC=y
> +CONFIG_PCI_XILINX=y

Nit: should PCI_XILINX not be in patch 5? It's not used in this patch
and was a bit confusing when reviewing.

Logan
