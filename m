Received: from eggs.gnu.org ([2001:4830:134:3::10]:50878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cYvbc-00071C-7k
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cYvbY-0002U7-1n
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:09:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cYvbX-0002Tq-QI
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:09:47 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC8B481235
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 14:09:46 +0000 (UTC)
Message-ID: <1485958183.3484.13.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 01 Feb 2017 15:09:43 +0100
In-Reply-To: <1485894840.1076.45.camel@redhat.com>
References: <1485788877-3823-1-git-send-email-abologna@redhat.com>
	<1485894840.1076.45.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] q35: Provide improved sample configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, drjones@redhat.com

On Tue, 2017-01-31 at 21:34 +0100, Gerd Hoffmann wrote:
> >=C2=A0=C2=A0docs/q35-chipset.cfg=C2=A0=C2=A0=C2=A0| 152 --------------=
----------------------------------
>=C2=A0
> Please leave q35-chipset.cfg there.
>=C2=A0
> The purpose of q35-chipset.cfg is to document how you can build a
> virtual machine which comes as close as possible to physical hardware
> with q35 northbridge and ich9 southbridge.=C2=A0=C2=A0So it is pretty m=
uch
> fixed ;)=C2=A0=C2=A0Maybe it makes sense to add a comment at the top cl=
arifying
> this.=C2=A0=C2=A0The (currently commented out) pcie switch configuratio=
n can be
> dropped or moved to another file.=C2=A0=C2=A0And maybe we can add the e=
thernet
> device meanwhile (has the e1000e emulation a ich9 device?).
>=C2=A0
> Adding another sample config focusing on pcie and good performance is
> perfectly fine of course.

Gotcha. I'll try to get this file in line with the new ones
where it comes to structure and add comments without messing
with its purpose.

> >=C2=A0=C2=A0docs/q35-graphical.cfg | 154 +++++++++++++++++++++++++++++=
++++++++++++++++++++
> >=C2=A0=C2=A0docs/q35-serial.cfg=C2=A0=C2=A0=C2=A0=C2=A0| 110 +++++++++=
++++++++++++++++++++++++++
>=C2=A0
> Note that you can specify -readconfig multiple times, so you can split
> out common stuff and ask people to run "qemu -readconfig
> q35-paravirt-base.cfg -readconfig q35-paravirt-$style.cfg"

Oh, I didn't know that! How about

=C2=A0 q35-emulated.cfg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0# emulated guest
=C2=A0 q35-virtio-common.cfg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# shared by all=
 VirtIO guests
=C2=A0 q35-virtio-graphical.cfg=C2=A0=C2=A0# VirtIO guest, graphical cons=
ole
=C2=A0 q35-virtio-serial.cfg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# VirtIO guest,=
 serial console

> > +# PCIe controllers
> > +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +#
> > +# We create four PCIe Root Ports: the first three are used
> > +# by devices defined below, while the last one is left
> > +# unused so that one more device can be hotplugged.
> > +
> > +[device "pci.1"]
> > +=C2=A0=C2=A0driver =3D "ioh3420"
> > +=C2=A0=C2=A0bus =3D "pcie.0"
> > +=C2=A0=C2=A0addr =3D "0x2"
> > +=C2=A0=C2=A0port =3D "0x10"
> > +=C2=A0=C2=A0chassis =3D "1"
>=C2=A0
> I'd suggest to create 8 pcie root ports, as multifunction device in a
> single slot, following pcie.txt suggestions.
>=C2=A0
> And I'd pick slot 1c for that, simply because the pcie root ports are i=
n
> that slot on physical hardware, but that is just cosmetic and a matter
> of taste.

Okay.

> > +[device "usb"]
> > +=C2=A0=C2=A0driver =3D "nec-usb-xhci"
> > +=C2=A0=C2=A0bus =3D "pci.3"
> > +=C2=A0=C2=A0addr =3D "0x0"
>=C2=A0
> Good, needs promotion ;)

Eheh :)

> > +[device "keyboard"]
> > +=C2=A0=C2=A0driver =3D "usb-kbd"
> > +=C2=A0=C2=A0bus =3D "usb.0"
> > +=C2=A0=C2=A0port =3D "1"
>=C2=A0
> We have a ps/2 keyboard anyway, so this is pointless (on x86, arm is a
> different story of course).

Okay. I will add a comment about why this is the case.

> > +[device "tablet"]
> > +=C2=A0=C2=A0driver =3D "usb-tablet"
> > +=C2=A0=C2=A0bus =3D "usb.0"
> > +=C2=A0=C2=A0port =3D "2"
>=C2=A0
> There is also virtio-tablet, but for a generic config usb is probably
> the better choice as virtio-tablet is supported by modern linux only (o=
n
> x86, on arm we have only modern linux anyway so picking virtio-tablet
> should be fine).

Okay, I will keep this in mind when working on the
aarch64/virt sample configuration. We can probably use
virtio-keyboard-pci and virtio-tablet-pci there, avoiding
the need to have a USB controller at all.

> > +# Video card
> > +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +#
> > +# We plug the QXL video card directly into the PCIe Root
> > +# Bus as it is a legacy PCI device; this way, we can reduce
> > +# the number of PCIe controllers in the guest.
> > +
> > +[device "video"]
> > +=C2=A0=C2=A0driver =3D "qxl-vga"
> > +=C2=A0=C2=A0bus =3D "pcie.0"
> > +=C2=A0=C2=A0addr =3D "0x1"
>=C2=A0
> Note that you can put multiple devices into a single root port, using
> multifunction.=C2=A0=C2=A0I have a guest here which looks like this:
>=C2=A0
> root@localhost ~# lspci -vt
> -[0000:00]-+-00.0=C2=A0=C2=A0Intel Corporation 82G33/G31/P35/P31 Expres=
s DRAM
> Controller
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-02.0=C2=A0=C2=A0Device 1234:1111
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1b.0=C2=A0=C2=A0Intel Corporation 82801I (ICH9 Family) HD Audio
> Controller
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1c.0-[01]----00.0=C2=A0=C2=A0Red Hat, Inc Virtio SCSI
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1c.1-[02]----00.0=C2=A0=C2=A0Red Hat, Inc Virtio network device
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1c.2-[03]--
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1c.3-[04]--
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1c.4-[05]--+-00.0=C2=A0=C2=A0Red Hat, Inc Virtio console
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-00.1=C2=A0=C2=A0Red Hat, Inc Virtio memory balloon
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
\-00.2=C2=A0=C2=A0Red Hat, Inc Virtio input
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1c.5-[06]----00.0=C2=A0=C2=A0NEC Corporation uPD720200 USB 3.0 Host
> Controller
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1c.6-[07]--
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1c.7-[08]--
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1e.0-[09-0a]----00.0-[0a]--
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1f.0=C2=A0=C2=A0Intel Corporation 82801IB (ICH9) LPC Interface
> Controller
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
+-1f.2=C2=A0=C2=A0Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port
> SATA Controller [AHCI mode]
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
\-1f.3=C2=A0=C2=A0Intel Corporation 82801I (ICH9 Family) SMBus
> Controller

Mh, I think it's less confusing to only share a single port
between devices when the devices in question are of the same
type, ie. ioh3420s. So I'd rather leave this as it is.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
