Received: from eggs.gnu.org ([2001:4830:134:3::10]:53481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fchre-0000gk-M4
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fchrd-0007mv-F5
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:54:50 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fchrd-0007mc-7X
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:54:49 -0400
Received: by mail-oi0-x242.google.com with SMTP id v8-v6so39641140oie.5
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 18:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531182400.git.alistair.francis@wdc.com>
	<93d3ddab10fa45e0fc081b7008f634b635acb204.1531182400.git.alistair.francis@wdc.com>
In-Reply-To: <93d3ddab10fa45e0fc081b7008f634b635acb204.1531182400.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 10 Jul 2018 13:54:37 +1200
Message-ID: <CAHNT7NvN42K7J+G2+PDzkb7btnGykpzrGjd9zFMx8Oh0SHHMfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] riscv64-softmmu.mak: Build Virtio
 Block support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: alistair23@gmail.com, qemu-devel@nongnu.org

On Tue, 10 Jul 2018 at 12:29 PM, Alistair Francis <alistair.francis@wdc.com=
>
wrote:

> Add build time support for the VirtIO block device. This allows us to
> attach a drive using the virtio-blk-device.


I=E2=80=99m not sure what has changed in master, but VirtIO block and net f=
or both
softmmu-riscv32 and softmmu-riscv64 were previously building by default and
working. Perhaps i=E2=80=99ve missed some patches that split up VirtIO supp=
ort into
more granular config options.

In any case, we should enable both CONFIG_VIRTIO_NET and CONFIG_VIRTIO_BLK
for both riscv32 and riscv64 as these were working in QEMU 2.12. There are
folk using the =E2=80=9Cvirt=E2=80=9D machine for riscv32 Linux.

Thanks, at least I know what to expect when I rebase my patch queue against
master and of course make a PR for the reviewed patches...

I=E2=80=99m not sure of the soft-freeze date but the bulk of the patches ar=
e the
same ones that were posted about a month ago... I also have several patches
that are not yet on the list...

Vectored interrupts. Trap tracing. More spec wording clarifications
regarding load reservations and interrupts:

-
https://github.com/riscv/riscv-qemu/commits/qemu-2.13-for-upstream

Michael

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  default-configs/riscv64-softmmu.mak | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/default-configs/riscv64-softmmu.mak
> b/default-configs/riscv64-softmmu.mak
> index 35e74bebe9..8790f3b115 100644
> --- a/default-configs/riscv64-softmmu.mak
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -12,3 +12,5 @@ CONFIG_PCI_XILINX=3Dy
>
>  CONFIG_VGA=3Dy
>  CONFIG_VGA_PCI=3Dy
> +
> +CONFIG_VIRTIO_BLK=3Dy
> --
> 2.17.1
>
>
