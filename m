Received: from eggs.gnu.org ([2001:4830:134:3::10]:58210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPX3n-0000OQ-RE
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <logang@deltatee.com>) id 1gPWoq-0001Qv-N9
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:01:46 -0500
References: <cover.1542819633.git.alistair.francis@wdc.com>
	<4120d0a7e4fe6f3fd6bdd6c084a40a67a48be374.1542819633.git.alistair.francis@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e3478876-09d1-121a-8c3c-850aa353449c@deltatee.com>
Date: Wed, 21 Nov 2018 11:01:29 -0700
MIME-Version: 1.0
In-Reply-To: <4120d0a7e4fe6f3fd6bdd6c084a40a67a48be374.1542819633.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 4/6] riscv: Enable VGA and
 PCIE_VGA
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
> Enable compile support for VGA devices. This allows the user to conenct
> a display by adding '-device bochs-display -display sdl' to their
> command line argument.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  default-configs/riscv32-softmmu.mak | 3 +++
>  default-configs/riscv64-softmmu.mak | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> index 3e3d195f37..05fae82f1b 100644
> --- a/default-configs/riscv32-softmmu.mak
> +++ b/default-configs/riscv32-softmmu.mak
> @@ -9,3 +9,6 @@ CONFIG_CADENCE=y
>  
>  CONFIG_PCI_GENERIC=y
>  CONFIG_PCI_XILINX=y
> +
> +CONFIG_VGA=y
> +CONFIG_VGA_PCI=y
> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> index 3e3d195f37..05fae82f1b 100644
> --- a/default-configs/riscv64-softmmu.mak
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -9,3 +9,6 @@ CONFIG_CADENCE=y
>  
>  CONFIG_PCI_GENERIC=y
>  CONFIG_PCI_XILINX=y
> +
> +CONFIG_VGA=y
> +CONFIG_VGA_PCI=y
> 
