Received: from eggs.gnu.org ([2001:4830:134:3::10]:57667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTCuG-0006FK-Bu
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTCuB-00007C-9f
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:25:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTCuB-00006w-3s
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:25:23 -0500
Date: Mon, 16 Jan 2017 17:25:20 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170116192520.GB3491@thinpad.lan.raisama.net>
References: <1484376662-32063-1-git-send-email-thuth@redhat.com>
	<2296ffa3-8bb9-4652-ebd6-4da5b09596ca@vivier.eu>
	<1ed4fded-4468-16cd-96e2-f70c1b85ab7d@redhat.com>
	<CAKmqyKP0ejNQOd=AYYP+jNNtgMm6Mv8V7bQms2MVbDuDDAtquQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKmqyKP0ejNQOd=AYYP+jNNtgMm6Mv8V7bQms2MVbDuDDAtquQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/null-machine: Add the possibility
 to instantiate a CPU, RAM and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jan 16, 2017 at 10:53:07AM -0800, Alistair Francis wrote:
> On Sun, Jan 15, 2017 at 11:59 PM, Thomas Huth <thuth@redhat.com> wrote:
> > On 14.01.2017 12:03, Laurent Vivier wrote:
> >> Le 14/01/2017 =E0 07:51, Thomas Huth a =E9crit :
> >>> Sometimes it is useful to have just a machine with CPU and RAM, wit=
hout
> >>> any further hardware in it, e.g. if you just want to do some instru=
ction
> >>> debugging for TCG with a remote GDB attached to QEMU, or run some e=
mbedded
> >>> code with the "-semihosting" QEMU parameter. qemu-system-m68k alrea=
dy
> >>> features a "dummy" machine, and xtensa a "sim" machine for exactly =
this
> >>> purpose.
> >>> All target architectures have nowadays also a "none" machine, which=
 would
> >>> be a perfect match for this, too - but it currently does not allow =
to add
> >>> CPU, RAM or a kernel yet. Thus let's add these possibilities in a g=
eneric
> >>> way to the "none" machine, too, so that we hopefully do not need ad=
ditional
> >>> "dummy" machines in the future anymore (and maybe can also get rid =
of the
> >>> already existing "dummy"/"sim" machines one day).
> >>> Note that the default behaviour of the "none" machine is not change=
d, i.e.
> >>> no CPU and no RAM is instantiated by default. You've explicitely go=
t to
> >>> specify the CPU model with "-cpu" and the amount of RAM with "-m" t=
o get
> >>> these new features.
> >>
> >> Did you try to use the generic-loader to load the kernel?
> >>
> >> Something like "-device loader,file=3Dvmlinux" instead of adding thi=
s part
> >> in the none machine?
> >
> > It does not work by default - because we need a way to set the CPU's
> > program counter to the entry point of the ELF file.
>=20
> The -device loader logic can set the PC to the entry point of the ELF.
> You just need to specify 'cpu-num=3Dx' when loading the file.
>=20
> > But I think the users also expect the "-kernel" parameter to be worki=
ng,
> > so I think we should add the loader code in null-machine.c anyway.
>=20
> I agree that uses probably expect the '-kernel' option to work as well.

So, is it possible to write a generic load_kernel() function that
simply reuses the generic-loader code?

--=20
Eduardo
