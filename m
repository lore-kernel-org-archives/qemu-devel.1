Received: from eggs.gnu.org ([209.51.188.92]:49384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1ghdaO-0006IX-2C
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1ghdaM-0008Rv-4C
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:53:38 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1ghdaL-0008Fm-Qj
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:53:37 -0500
Received: by mail-pl1-x642.google.com with SMTP id e11so5427767plt.11
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:53:32 -0800 (PST)
Date: Thu, 10 Jan 2019 08:53:30 -0800 (PST)
In-Reply-To: <c162ffeb1bb1cbcdeb47ea62a829294168a0ebdf.1547078463.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-cf28bdac-e5b7-46a3-b53d-b01a329f9100@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>

On Wed, 09 Jan 2019 16:01:34 PST (-0800), Alistair Francis wrote:
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
> -- 
> 2.19.1

Does this work for you?  I tried it out but my kernel hangs in early boot if I 
enable the generic PCI controller.  This is my WIP kernel so the problem is 
probably on my end.

I'm trying to boot with

    -device usb-ehci
    -drive id=my_usb_disk,file=usbdisk.img,if=none,format=raw
    -device usb-storage,drive=my_usb_dis
