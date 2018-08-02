Received: from eggs.gnu.org ([2001:4830:134:3::10]:54805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1flJ8W-0007gh-ME
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1flJ8R-0003Pn-RL
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:19:48 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1flJ8R-0003Pc-Gs
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:19:43 -0400
Received: by mail-pg1-x541.google.com with SMTP id n7-v6so1663275pgq.4
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 12:19:43 -0700 (PDT)
Message-ID: <5b63594d.1c69fb81.60370.1c46@mx.google.com>
MIME-Version: 1.0
From: Alistair <alistair23@gmail.com>
Date: Thu, 2 Aug 2018 12:18:58 -0700
In-Reply-To: <mhng-df1b106f-72bb-4857-9acc-4095019307e4@palmer-si-x1c4>
References: <cover.1529695276.git.alistair.francis@wdc.com>
	<mhng-df1b106f-72bb-4857-9acc-4095019307e4@palmer-si-x1c4>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Connect a PCIe host and graphics
 support toRISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>

Hey,

Sorry for the top post. I=E2=80=99m on holidays at the moment and will be b=
ack next week.

I have sent a V2 to the list, I don=E2=80=99t think I CCed you as I know yo=
ur busy. Once the 3.1 merge window opens I=E2=80=99ll send a new version wi=
th all the comments I have received.

Alistair

From: Palmer Dabbelt
Sent: Thursday, 2 August 2018 10:44 AM
To: alistair.francis@wdc.com
Cc: qemu-devel@nongnu.org; alistair.francis@wdc.com; alistair23@gmail.com; =
Michael Clark
Subject: Re: [PATCH v1 0/5] Connect a PCIe host and graphics support toRISC=
-V

On Fri, 22 Jun 2018 12:28:14 PDT (-0700), alistair.francis@wdc.com wrote:
> Alistair Francis (5):
>   hw/riscv/virtio: Set the soc device tree node as a simple-bus
>   hw/riscv/virt: Increase the number of interrupts
>   hw/riscv/virt: Connect the Xilinx PCIe
>   hw/riscv/virt: Connect a VGA PCIe device
>   riscv64-softmmu.mak: Build Virtio Block support
>
>  default-configs/riscv32-softmmu.mak |  6 +++
>  default-configs/riscv64-softmmu.mak |  8 ++++
>  hw/riscv/virt.c                     | 73 ++++++++++++++++++++++++++++-
>  include/hw/riscv/virt.h             |  6 ++-
>  4 files changed, 90 insertions(+), 3 deletions(-)

Sorry I'm so slow here, I'm still chewing through my patch backlog.  It loo=
ks=20
like this hasn't made it upstream yet.  I rebased it on top of master but h=
ave=20
yet to figure out how to make it work, though I think that's on the Linux s=
ide.

I haven't yet looked at the code, but I like the functionality so I don't w=
ant=20
to lose this.  Can you submit a v2 that applies cleanly to master, or do yo=
u=20
want me to deal with it?
