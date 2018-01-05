Received: from eggs.gnu.org ([2001:4830:134:3::10]:48718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXLOz-0006qi-3l
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eXLOw-0005Dd-RM
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:22:49 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:33376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eXLOw-0005DC-9N
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:22:46 -0500
Received: by mail-ot0-x229.google.com with SMTP id x15so3222725ote.0
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 22:22:46 -0800 (PST)
MIME-Version: 1.0
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-22-git-send-email-mjc@sifive.com>
	<20180104200907.7232a1e131af98e25931faa5@gmail.com>
In-Reply-To: <20180104200907.7232a1e131af98e25931faa5@gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 05 Jan 2018 06:22:34 +0000
Message-ID: <CAHNT7Ns_paVsu2vAn3X142FrQiyT4Yk_BhJHzwJ88iyU0Bfxtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 21/21] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org

On Fri, 5 Jan 2018 at 5:55 AM, Antony Pavlov <antonynpavlov@gmail.com>
wrote:

> On Wed,  3 Jan 2018 13:44:25 +1300
> Michael Clark <mjc@sifive.com> wrote:
>
> > This adds RISC-V into the build system enabling the following targets:
> >
> > - riscv32-softmmu
> > - riscv64-softmmu
> > - riscv32-linux-user
> > - riscv64-linux-user
> >
>
> ...
>
> > diff --git a/default-configs/riscv32-softmmu.mak
> b/default-configs/riscv32-softmmu.mak
> > new file mode 100644
> > index 0000000..f9e7421
> > --- /dev/null
> > +++ b/default-configs/riscv32-softmmu.mak
> > @@ -0,0 +1,4 @@
> > +# Default configuration for riscv-softmmu
> > +
> > +CONFIG_SERIAL=3Dy
> > +CONFIG_VIRTIO=3Dy
> > diff --git a/default-configs/riscv64-linux-user.mak
> b/default-configs/riscv64-linux-user.mak
> > new file mode 100644
> > index 0000000..865b362
> > --- /dev/null
> > +++ b/default-configs/riscv64-linux-user.mak
> > @@ -0,0 +1 @@
> > +# Default configuration for riscv-linux-user
> > diff --git a/default-configs/riscv64-softmmu.mak
> b/default-configs/riscv64-softmmu.mak
> > new file mode 100644
> > index 0000000..f9e7421
> > --- /dev/null
> > +++ b/default-configs/riscv64-softmmu.mak
> > @@ -0,0 +1,4 @@
> > +# Default configuration for riscv-softmmu
> > +
> > +CONFIG_SERIAL=3Dy
> > +CONFIG_VIRTIO=3Dy
> > diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> > new file mode 100644
> > index 0000000..a0c31ae
> > --- /dev/null
> > +++ b/hw/riscv/Makefile.objs
> > @@ -0,0 +1,12 @@
> > +obj-y +=3D riscv_elf.o
> > +obj-y +=3D riscv_htif.o
> > +obj-y +=3D riscv_hart.o
> > +obj-y +=3D sifive_e300.o
> > +obj-y +=3D sifive_clint.o
> > +obj-y +=3D sifive_prci.o
> > +obj-y +=3D sifive_plic.o
> > +obj-y +=3D sifive_u500.o
> > +obj-y +=3D sifive_uart.o
> > +obj-y +=3D spike_v1_09.o
> > +obj-y +=3D spike_v1_10.o
> > +obj-y +=3D virt.o
>
> According to https://www.sifive.com/products/freedom/
> Freedom E300 Platform uses RV32IMAC Architecture
> and Freedom U500 Platform uses RV64GC Architecture.
>
> Which means that qemu-system-riscv32 has to have E300 support but not U50=
0
> support.
> qemu-system-riscv64 has to have U500 support but not E300 support.
>
> However please see this log:
>
> riscv-qemu$ ./riscv32-softmmu/qemu-system-riscv32 -M ?
> Supported machines are:
> none                 empty machine
> sifive_e300          RISC-V Board compatible with SiFive E300 SDK
> sifive_u500          RISC-V Board compatible with SiFive U500 SDK <<<<<<
> U500 in 32-bit mode
> spike_v1.10          RISC-V Spike Board (Privileged ISA v1.10)
> spike_v1.9           RISC-V Spike Board (Privileged ISA v1.9.1) (default)
> virt                 RISC-V VirtIO Board (Privileged spec v1.10)
> riscv-qemu$ ./riscv64-softmmu/qemu-system-riscv64 -M ?
> Supported machines are:
> none                 empty machine
> sifive_e300          RISC-V Board compatible with SiFive E300 SDK <<<<<<
> E300 in 64-bit mode
> sifive_u500          RISC-V Board compatible with SiFive U500 SDK
> spike_v1.10          RISC-V Spike Board (Privileged ISA v1.10)
> spike_v1.9           RISC-V Spike Board (Privileged ISA v1.9.1) (default)
> virt                 RISC-V VirtIO Board (Privileged spec v1.10)
>
> I propose at least this fixup:
>
> diff --git a/default-configs/riscv32-softmmu.mak
> b/default-configs/riscv32-softmmu.mak
> index f9e742120c..6a807f5f96 100644
> --- a/default-configs/riscv32-softmmu.mak
> +++ b/default-configs/riscv32-softmmu.mak
> @@ -1,4 +1,5 @@
> -# Default configuration for riscv-softmmu
> +# Default configuration for riscv32-softmmu
>
>  CONFIG_SERIAL=3Dy
>  CONFIG_VIRTIO=3Dy
> +CONFIG_SIFIVE_E300=3Dy
> diff --git a/default-configs/riscv64-softmmu.mak
> b/default-configs/riscv64-softmmu.mak
> index f9e742120c..1a0349fe27 100644
> --- a/default-configs/riscv64-softmmu.mak
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -1,4 +1,5 @@
> -# Default configuration for riscv-softmmu
> +# Default configuration for riscv64-softmmu
>
>  CONFIG_SERIAL=3Dy
>  CONFIG_VIRTIO=3Dy
> +CONFIG_SIFIVE_U500=3Dy
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index a0c31ae25e..bac5faa603 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -1,11 +1,11 @@
>  obj-y +=3D riscv_elf.o
>  obj-y +=3D riscv_htif.o
>  obj-y +=3D riscv_hart.o
> -obj-y +=3D sifive_e300.o
> +obj-$(CONFIG_SIFIVE_E300) +=3D sifive_e300.o
>  obj-y +=3D sifive_clint.o
>  obj-y +=3D sifive_prci.o
>  obj-y +=3D sifive_plic.o
> -obj-y +=3D sifive_u500.o
> +obj-$(CONFIG_SIFIVE_U500) +=3D sifive_u500.o
>  obj-y +=3D sifive_uart.o
>  obj-y +=3D spike_v1_09.o
>  obj-y +=3D spike_v1_10.o


I=E2=80=99ll check whether there are 64-bit E series chips. Actually the ke=
y
distinction is no MMU and we don=E2=80=99t yet disable the MMU in the machi=
ne.

I=E2=80=99ll ask SiFive whether they want to restrict the =E2=80=9Cbitness=
=E2=80=9D. There is
actually no reason why the machine can=E2=80=99t be invoked as 64-bit.

As far as I know the RTL is parametiazable and the 32-bit cores are
generated from the same RTL source using the rocket chip generator however
that=E2=80=99s something i=E2=80=99ll have to check. i.e. we may not want t=
o restrict the
options here.

The machines are deliberately called E300 and U500 to refer to a generic
series and in future there will be a machine with the U54-MC which is a
particular instantiation. So in that respect the =E2=80=9Cseries=E2=80=9D m=
achines are
generic.

It=E2=80=99s on our todo list to add support to disable the MMU but HiFive1
binaries will run anyway because they don=E2=80=99t touch the =E2=80=98satp=
=E2=80=99 CSR and take
the cpu out of Mbare adressing mode. I=E2=80=99d rank disabling the MMU on =
the E
series as a higher priority than restricting bitness.

In any case i=E2=80=99ll check if SiFive can parameterize a 64-bit E series=
 with no
MMU, tightly coupled memory, etc. I can=E2=80=99t tell that for sure until =
I ask.

A HiFive1 machine of course should be 32-bit only, when we add one, but the
generic E series machine can run 32-bit HiFive1 binaries when invoked using
qemu-system-riscv32

I=E2=80=99ll ask...
