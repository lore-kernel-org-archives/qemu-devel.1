Received: from eggs.gnu.org ([2001:4830:134:3::10]:50252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFK2Q-0002PR-9d
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFK2L-0002mM-Tj
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dFK2L-0002le-K2
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:44:41 -0400
Date: Mon, 29 May 2017 14:44:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170529144435.79b23666@nial.brq.redhat.com>
In-Reply-To: <CAJ+F1C+z7aizkCJOsYnzjhgU7cXGkKy3HzejE_Yv_NzoRvcmZQ@mail.gmail.com>
References: <20170424130355.31324-1-marcandre.lureau@redhat.com>
	<CABdb736pFG7yK+C_J-WWRbX+e-bk62TejQ_GtObxyFmV5t350w@mail.gmail.com>
	<CAJ+F1CJPEZNUPrYseN3JD+gAtwJ-rLQVRBLdXTQVSwaBTdNGHA@mail.gmail.com>
	<20170502091723.3a3b4e42@nial.brq.redhat.com>
	<CAJ+F1CJ-tvPdX1QLYKWg6M_cattYcBDO25Hfp+rfBpnCZbwFtA@mail.gmail.com>
	<20170504154103.69a8eaa8@nial.brq.redhat.com>
	<CAJ+F1C+z7aizkCJOsYnzjhgU7cXGkKy3HzejE_Yv_NzoRvcmZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RFC: vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ladi Prosek <lprosek@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, anderson@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, 26 May 2017 13:59:09 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Thu, May 4, 2017 at 5:41 PM Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Tue, 02 May 2017 19:03:15 +0000
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > =20
> > > Hi
> > >
> > > On Tue, May 2, 2017 at 11:17 AM Igor Mammedov <imammedo@redhat.com> =
=20
> > wrote: =20
> > > =20
> > > > On Fri, 28 Apr 2017 14:28:38 +0000
> > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > > > =20
> > > > > Hi
> > > > >
> > > > > On Fri, Apr 28, 2017 at 6:12 PM Ladi Prosek <lprosek@redhat.com> =
=20
> > wrote: =20
> > > > > =20
> > > > > > On Mon, Apr 24, 2017 at 3:03 PM, Marc-Andr=C3=A9 Lureau
> > > > > > <marcandre.lureau@redhat.com> wrote: =20
> > > > > > > The VM coreinfo (vmcoreinfo) device is an emulated device whi=
ch
> > > > > > > exposes a 4k memory range to the guest to store various =20
> > informations =20
> > > > > > > useful to debug the guest OS. (it is greatly inspired by the =
=20
> > VMGENID =20
> > > > > > > device implementation)
> > > > > > >
> > > > > > > This is an early-boot alternative to the qemu-ga VMDUMP_INFO =
=20
> > event =20
> > > > > > > proposed in "[PATCH 00/21] WIP: dump: add kaslr support".
> > > > > > >
> > > > > > > If deemed more appropriate, we can consider writing to fw_cfg=
 =20
> > > > directly =20
> > > > > > > instead of guest memory, now that qemu 2.9 supports it again.
> > > > > > >
> > > > > > > The proof-of-concept kernel module:
> > > > > > > =20
> > https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c =20
> > > > > >
> > > > > > Here's a proof-of-concept Windows driver:
> > > > > >
> > > > > > =20
> > > > =20
> > https://github.com/ladipro/kvm-guest-drivers-windows/tree/vmcoreinfo/vm=
coreinfo =20
> > > > > >
> > > > > > I just wanted to be sure that it's possible to evaluate the ADDR
> > > > > > method in Windows.
> > > > > >
> > > > > > From a practical point of view it is unfortunate that this woul=
d =20
> > be a =20
> > > > > > completely new device. For Windows guests it means another driv=
er
> > > > > > binary and all the overhead associated with deploying it on VMs=
. =20
> > Would =20
> > > > > > it be too crazy to add this functionality to the pvpanic device=
? =20
> > The =20
> > > > > > mechanics could stay the same but it would be done under the =20
> > existing =20
> > > > > > ACPI\QEMU0001 device.
> > > > > > =20
> > > > >
> > > > > pvpanic is under _SB.PCI0.ISA, that could be problematic
> > > > >
> > > > > and _STA is a name field.
> > > > >
> > > > > Someone with more experience with ACPI could tell us if that make=
 =20
> > sense =20
> > > > to =20
> > > > > merge both and how.
> > > > >
> > > > > Can't you handle 2 ACPI devices in the same windows driver instea=
d? =20
> > > > we use QEMU0001 to reserve IO ports for pvpanic device,
> > > > ASL wise there shouldn't problems with adding _ADDR method to it
> > > >
> > > > but then we probably should fold vmcoreinfo into pvpanic device
> > > > as well (QEMU and linux driver)
> > > >
> > > > =20
> > > pvpanic is x86-only afaict. =20
> > There is nothing that forces it to be x86 specific (beside being ISA
> > device),
> > ARM also can benefit from/use pvpanic if you make it pci device or just
> > plain
> > Device.
> > =20
>=20
> Could someone advise on a recommended solution here?
>=20
> Should we make a PCI variant of pvpanic and add the proposed vmcoreinfo
> ACPI/mem to it ?
>=20
> Tbh, I think I prefer to have seperate devices since they work differently
> and vmcoreinfo doesn't require any bus device.
Considering pvpanic and vmcore are closely related, I'd prefer
it being one device. But I won't insist on it.

Also instead of PCI device, I'd use plain Device as vmgenid does,
that would leave open question how to make legacy ISA based pvpanic
on top of it in case both are merged.

>=20
> thanks
>=20
> > =20
> > > While I think vmcoreinfo would work fine with
> > > any acpi-able arch. =20
> > I don't insist on it but it's worth a try, probably a lot of code could=
 be
> > shared between both (including AML part/which makes DSDT smaller little
> > bit)
> >
> > =20
> > > I think I would rather modify the windows driver to support both pvpa=
nic =20
> > & =20
> > > vmcoreinfo, even if it's not typical for driver to implement several
> > > devices.
> > > =20
> > > > =20
> > > > > > +Storage Format: =20
> > > > > > > +---------------
> > > > > > > +
> > > > > > > +The content is expected to use little-endian format.
> > > > > > > +
> > > > > > > +In order to implement an OVMF "SDT Header Probe Suppressor",=
 the =20
> > > > > > contents of =20
> > > > > > > +the vmcoreinfo blob has 40 bytes of padding:
> > > > > > > +
> > > > > > > ++-----------------------------------+
> > > > > > > +| SSDT with OEM Table ID =3D VMCOREIN |
> > > > > > > ++-----------------------------------+
> > > > > > > +| ...                               |       TOP OF PAGE
> > > > > > > +| VCIA dword object ----------------|-----> =20
> > > > > > +---------------------------+ =20
> > > > > > > +| ...                               |       | fw-allocated =
=20
> > array for =20
> > > > > > | =20
> > > > > > > +| _STA method referring to VCIA     |       | "etc/vmcoreinf=
o" =20
> > > > > > | =20
> > > > > > > +| ...                               | =20
> > > > > >  +---------------------------+ =20
> > > > > > > +| ADDR method referring to VCIA     |       |  0: OVMF SDT =
=20
> > Header =20
> > > > probe =20
> > > > > > | =20
> > > > > > > +| ...                               |       |     suppressor=
 =20
> > > > > > | =20
> > > > > > > ++-----------------------------------+       | 40: uint32 ver=
sion =20
> > > > field =20
> > > > > > | =20
> > > > > > > +                                            | 44: info conte=
nts =20
> > > > > >  | =20
> > > > > > > +                                            |     .... =20
> > > > > > | =20
> > > > > > > + =20
> > > > > > +---------------------------+ =20
> > > > > > > +                                            END OF PAGE
> > > > > > > +
> > > > > > > +Version 0 content:
> > > > > > > +
> > > > > > > + uint64 paddr:
> > > > > > > +  Physical address of the Linux vmcoreinfo ELF note. =20
> > > > > >
> > > > > > Or physical address of the Windows crash dump header :p
> > > > > > =20
> > > > >
> > > > > Is there support for Windows crash dump in qemu?
> > > > >
> > > > > =20
> > > > > > Do we want to have an additional discriminator field to tell wh=
at =20
> > kind =20
> > > > > > of information was written by the guest or would Windows use a
> > > > > > different version?
> > > > > >
> > > > > > =20
> > > > > I guess a different version would be ok.
> > > > >
> > > > > Thanks a lot for looking at it! =20
> > > >
> > > > -- =20
> > > Marc-Andr=C3=A9 Lureau =20
> >
> > -- =20
> Marc-Andr=C3=A9 Lureau
