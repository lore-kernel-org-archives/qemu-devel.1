Received: from eggs.gnu.org ([2001:4830:134:3::10]:38280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ei6QG-0005Np-0j
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 17:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ei6QD-00078d-K4
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 17:36:36 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:41893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ei6QD-00078A-BO
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 17:36:33 -0500
Received: by mail-oi0-x22a.google.com with SMTP id m83so18712364oik.8
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 14:36:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Ns_paVsu2vAn3X142FrQiyT4Yk_BhJHzwJ88iyU0Bfxtg@mail.gmail.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-22-git-send-email-mjc@sifive.com>
	<20180104200907.7232a1e131af98e25931faa5@gmail.com>
	<CAHNT7Ns_paVsu2vAn3X142FrQiyT4Yk_BhJHzwJ88iyU0Bfxtg@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Sun, 4 Feb 2018 11:36:31 +1300
Message-ID: <CAHNT7NtqucfKVGHAGENnpn83MvfaX4h44AUxS+QJ9Sgp-PZUSQ@mail.gmail.com>
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
To: Antony Pavlov <antonynpavlov@gmail.com>, Palmer Dabbelt <palmer@sifive.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org

On Fri, Jan 5, 2018 at 7:22 PM, Michael Clark <mjc@sifive.com> wrote:

>
> On Fri, 5 Jan 2018 at 5:55 AM, Antony Pavlov <antonynpavlov@gmail.com>
> wrote:
>
>> On Wed,  3 Jan 2018 13:44:25 +1300
>> Michael Clark <mjc@sifive.com> wrote:
>>
>> > This adds RISC-V into the build system enabling the following targets:
>> >
>> > - riscv32-softmmu
>> > - riscv64-softmmu
>> > - riscv32-linux-user
>> > - riscv64-linux-user
>> >
>>
>> ...
>>
>> > diff --git a/default-configs/riscv32-softmmu.mak
>> b/default-configs/riscv32-softmmu.mak
>> > new file mode 100644
>> > index 0000000..f9e7421
>> > --- /dev/null
>> > +++ b/default-configs/riscv32-softmmu.mak
>> > @@ -0,0 +1,4 @@
>> > +# Default configuration for riscv-softmmu
>> > +
>> > +CONFIG_SERIAL=3Dy
>> > +CONFIG_VIRTIO=3Dy
>> > diff --git a/default-configs/riscv64-linux-user.mak
>> b/default-configs/riscv64-linux-user.mak
>> > new file mode 100644
>> > index 0000000..865b362
>> > --- /dev/null
>> > +++ b/default-configs/riscv64-linux-user.mak
>> > @@ -0,0 +1 @@
>> > +# Default configuration for riscv-linux-user
>> > diff --git a/default-configs/riscv64-softmmu.mak
>> b/default-configs/riscv64-softmmu.mak
>> > new file mode 100644
>> > index 0000000..f9e7421
>> > --- /dev/null
>> > +++ b/default-configs/riscv64-softmmu.mak
>> > @@ -0,0 +1,4 @@
>> > +# Default configuration for riscv-softmmu
>> > +
>> > +CONFIG_SERIAL=3Dy
>> > +CONFIG_VIRTIO=3Dy
>> > diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
>> > new file mode 100644
>> > index 0000000..a0c31ae
>> > --- /dev/null
>> > +++ b/hw/riscv/Makefile.objs
>> > @@ -0,0 +1,12 @@
>> > +obj-y +=3D riscv_elf.o
>> > +obj-y +=3D riscv_htif.o
>> > +obj-y +=3D riscv_hart.o
>> > +obj-y +=3D sifive_e300.o
>> > +obj-y +=3D sifive_clint.o
>> > +obj-y +=3D sifive_prci.o
>> > +obj-y +=3D sifive_plic.o
>> > +obj-y +=3D sifive_u500.o
>> > +obj-y +=3D sifive_uart.o
>> > +obj-y +=3D spike_v1_09.o
>> > +obj-y +=3D spike_v1_10.o
>> > +obj-y +=3D virt.o
>>
>> According to https://www.sifive.com/products/freedom/
>> Freedom E300 Platform uses RV32IMAC Architecture
>> and Freedom U500 Platform uses RV64GC Architecture.
>>
>> Which means that qemu-system-riscv32 has to have E300 support but not
>> U500 support.
>> qemu-system-riscv64 has to have U500 support but not E300 support.
>>
>> However please see this log:
>>
>> riscv-qemu$ ./riscv32-softmmu/qemu-system-riscv32 -M ?
>> Supported machines are:
>> none                 empty machine
>> sifive_e300          RISC-V Board compatible with SiFive E300 SDK
>> sifive_u500          RISC-V Board compatible with SiFive U500 SDK <<<<<<
>> U500 in 32-bit mode
>> spike_v1.10          RISC-V Spike Board (Privileged ISA v1.10)
>> spike_v1.9           RISC-V Spike Board (Privileged ISA v1.9.1) (default=
)
>> virt                 RISC-V VirtIO Board (Privileged spec v1.10)
>> riscv-qemu$ ./riscv64-softmmu/qemu-system-riscv64 -M ?
>> Supported machines are:
>> none                 empty machine
>> sifive_e300          RISC-V Board compatible with SiFive E300 SDK <<<<<<
>> E300 in 64-bit mode
>> sifive_u500          RISC-V Board compatible with SiFive U500 SDK
>> spike_v1.10          RISC-V Spike Board (Privileged ISA v1.10)
>> spike_v1.9           RISC-V Spike Board (Privileged ISA v1.9.1) (default=
)
>> virt                 RISC-V VirtIO Board (Privileged spec v1.10)
>>
>> I propose at least this fixup:
>>
>> diff --git a/default-configs/riscv32-softmmu.mak
>> b/default-configs/riscv32-softmmu.mak
>> index f9e742120c..6a807f5f96 100644
>> --- a/default-configs/riscv32-softmmu.mak
>> +++ b/default-configs/riscv32-softmmu.mak
>> @@ -1,4 +1,5 @@
>> -# Default configuration for riscv-softmmu
>> +# Default configuration for riscv32-softmmu
>>
>>  CONFIG_SERIAL=3Dy
>>  CONFIG_VIRTIO=3Dy
>> +CONFIG_SIFIVE_E300=3Dy
>> diff --git a/default-configs/riscv64-softmmu.mak
>> b/default-configs/riscv64-softmmu.mak
>> index f9e742120c..1a0349fe27 100644
>> --- a/default-configs/riscv64-softmmu.mak
>> +++ b/default-configs/riscv64-softmmu.mak
>> @@ -1,4 +1,5 @@
>> -# Default configuration for riscv-softmmu
>> +# Default configuration for riscv64-softmmu
>>
>>  CONFIG_SERIAL=3Dy
>>  CONFIG_VIRTIO=3Dy
>> +CONFIG_SIFIVE_U500=3Dy
>> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
>> index a0c31ae25e..bac5faa603 100644
>> --- a/hw/riscv/Makefile.objs
>> +++ b/hw/riscv/Makefile.objs
>> @@ -1,11 +1,11 @@
>>  obj-y +=3D riscv_elf.o
>>  obj-y +=3D riscv_htif.o
>>  obj-y +=3D riscv_hart.o
>> -obj-y +=3D sifive_e300.o
>> +obj-$(CONFIG_SIFIVE_E300) +=3D sifive_e300.o
>>  obj-y +=3D sifive_clint.o
>>  obj-y +=3D sifive_prci.o
>>  obj-y +=3D sifive_plic.o
>> -obj-y +=3D sifive_u500.o
>> +obj-$(CONFIG_SIFIVE_U500) +=3D sifive_u500.o
>>  obj-y +=3D sifive_uart.o
>>  obj-y +=3D spike_v1_09.o
>>  obj-y +=3D spike_v1_10.o
>
>
> I=E2=80=99ll check whether there are 64-bit E series chips. Actually the =
key
> distinction is no MMU and we don=E2=80=99t yet disable the MMU in the mac=
hine.
>
> I=E2=80=99ll ask SiFive whether they want to restrict the =E2=80=9Cbitnes=
s=E2=80=9D. There is
> actually no reason why the machine can=E2=80=99t be invoked as 64-bit.
>
> As far as I know the RTL is parametiazable and the 32-bit cores are
> generated from the same RTL source using the rocket chip generator howeve=
r
> that=E2=80=99s something i=E2=80=99ll have to check. i.e. we may not want=
 to restrict the
> options here.
>
> The machines are deliberately called E300 and U500 to refer to a generic
> series and in future there will be a machine with the U54-MC which is a
> particular instantiation. So in that respect the =E2=80=9Cseries=E2=80=9D=
 machines are
> generic.
>
> It=E2=80=99s on our todo list to add support to disable the MMU but HiFiv=
e1
> binaries will run anyway because they don=E2=80=99t touch the =E2=80=98sa=
tp=E2=80=99 CSR and take
> the cpu out of Mbare adressing mode. I=E2=80=99d rank disabling the MMU o=
n the E
> series as a higher priority than restricting bitness.
>
> In any case i=E2=80=99ll check if SiFive can parameterize a 64-bit E seri=
es with
> no MMU, tightly coupled memory, etc. I can=E2=80=99t tell that for sure u=
ntil I ask.
>
> A HiFive1 machine of course should be 32-bit only, when we add one, but
> the generic E series machine can run 32-bit HiFive1 binaries when invoked
> using qemu-system-riscv32
>
> I=E2=80=99ll ask...
>

- E series has no MMU and can be either 32-bit or 64-bit, however, E3xx is
32-bit and E5xx is 64-bit.

There is a 64-bit E series here:

-
https://github.com/sifive/freedom-e-sdk/tree/master/bsp/env/coreplexip-e51-=
arty

We'll have to think about naming these machines. We could either add a
sifive_e500.c and add appropriate bit-width restrictions or make the boards
more generic. Also, the current port has two distinct compile time targets
for 32-bit and 64-bit, however, we may eventually handle runtime changes
to MXL/SXL/UXL as the spec allows dual bit-width machines. If we support
runtime bit-width changes, I wonder if we would still continue to have two
separate targets e.g. qemu-system-riscv32 and qemu-system-riscv64 which
also supports 32-bit mode via the misa.MXL and mstatus.SXL/UXL bits. I
guess keeping the two targets is the path of least resistance
(with qemu-system-riscv64 also supporting 32-bit) as many scripts already
depend on these names. The user-mode simulators will of course not support
runtime bit-width changes.
