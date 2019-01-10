Received: from eggs.gnu.org ([209.51.188.92]:51657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghVmG-0005E3-Lv
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghVmD-0007G8-Qq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:33:22 -0500
References: <c162ffeb1bb1cbcdeb47ea62a829294168a0ebdf.1547078463.git.alistair.francis@wdc.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e319aa13-1a43-d369-1213-060cf85b13a4@redhat.com>
Date: Thu, 10 Jan 2019 09:33:10 +0100
MIME-Version: 1.0
In-Reply-To: <c162ffeb1bb1cbcdeb47ea62a829294168a0ebdf.1547078463.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] default-configs: Enable USB support
 for RISC-V machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 2019-01-10 01:01, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  default-configs/riscv32-softmmu.mak | 1 +
>  default-configs/riscv64-softmmu.mak | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> index dbc9398284..c9c5971409 100644
> --- a/default-configs/riscv32-softmmu.mak
> +++ b/default-configs/riscv32-softmmu.mak
> @@ -1,6 +1,7 @@
>  # Default configuration for riscv-softmmu
>  
>  include pci.mak
> +include usb.mak
>  
>  CONFIG_SERIAL=y
>  CONFIG_VIRTIO_MMIO=y
> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> index dbc9398284..c9c5971409 100644
> --- a/default-configs/riscv64-softmmu.mak
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -1,6 +1,7 @@
>  # Default configuration for riscv-softmmu
>  
>  include pci.mak
> +include usb.mak
>  
>  CONFIG_SERIAL=y
>  CONFIG_VIRTIO_MMIO=y

Makes sense if the PCI HCDs are already working.

Reviewed-by: Thomas Huth <thuth@redhat.com>
