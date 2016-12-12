Received: from eggs.gnu.org ([2001:4830:134:3::10]:42199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cGUQg-0003e7-A7
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cGUQd-0000IK-52
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:30:22 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cGUQc-0000ID-VI
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 12:30:19 -0500
Received: by mail-wj0-f194.google.com with SMTP id he10so12706801wjc.2
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 09:30:18 -0800 (PST)
Date: Mon, 12 Dec 2016 17:29:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161212172915.GP4074@stefanha-x1.localdomain>
References: <20161209203954.GW4027@thinpad.lan.raisama.net>
	<584E36CD.50405@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LfQcPIWFRhGivmDw"
Content-Disposition: inline
In-Reply-To: <584E36CD.50405@cn.fujitsu.com>
Subject: Re: [Qemu-devel] Reproducible crash on PCIe hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>


--LfQcPIWFRhGivmDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 01:34:05PM +0800, Cao jin wrote:
>=20
>=20
> On 12/10/2016 04:39 AM, Eduardo Habkost wrote:
> > Using latest qemu.git master:
> >=20
> >   $ qemu-system-x86_64 -machine q35 -readconfig docs/q35-chipset.cfg -m=
onitor stdio
> >   QEMU 2.7.93 monitor - type 'help' for more information
> >   (qemu) device_add e1000e,bus=3Dich9-pcie-port-4,addr=3D00
> >   (qemu) device_add e1000e,bus=3Dich9-pcie-port-4,addr=3D08
> >   Segmentation fault (core dumped)
> >=20
> > It crashes at:
> >=20
> >   #7  0x000055555598d7dc in do_pci_register_device (errp=3D0x7fffffffbf=
d0, devfn=3D64, name=3D0x5555565df340 "e1000e", bus=3D0x555558487380, pci_d=
ev=3D0x5555589cd000)
> >       at /home/ehabkost/rh/proj/virt/qemu/hw/pci/pci.c:983
> >   983             error_setg(errp, "PCI: slot %d function 0 already ocu=
ppied by %s,"
> >   (gdb) l
> >   978                        PCI_SLOT(devfn), PCI_FUNC(devfn), name,
> >   979                        bus->devices[devfn]->name);
> >   980             return NULL;
> >   981         } else if (dev->hotplugged &&
> >   982                    pci_get_function_0(pci_dev)) {
> >   983             error_setg(errp, "PCI: slot %d function 0 already ocu=
ppied by %s,"
> >   984                        " new func %s cannot be exposed to guest.",
> >   985                        PCI_SLOT(devfn),
> >   986                        bus->devices[PCI_DEVFN(PCI_SLOT(devfn), 0)=
]->name,
> >   987                        name);
> >=20
>=20
> Thanks for informing me. I am kind of busy for now, so I suppose I will
> investigate it after 2.8 release.

Please let me know if this should be considered a release blocker.

The proposed QEMU 2.8 release date is tomorrow (December 13th)!

Stefan

--LfQcPIWFRhGivmDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTt5rAAoJEJykq7OBq3PIIx0H/j/ORrduzyKj7VbvI8s54WaO
+RnCTURRQQeHlDuHu1c+uPBYih6wRPzNkW2Ba+/zlRm3ynZMEZxTIskmc24cZa5N
ZULk+Gg3QFuSec8LoXejhJbsW32rQzOekFOme7SniewQt+2dYSc3PF72decX/Tt3
Dco9zSXNEIYnzVxcn2P8MnjfeIL/0xPW733FW6fbGZmy0UoEMKPDOavnFR17dUsK
UjUSzQ++1zIVtnmEqen4SZYbh2NLIkewO3hiLhcGCEZuRKO+/+/DQ2+870lq6pM7
rvewG6Vak6oiCJiy4kcLEqR1ExU8ycI5/I24j8hq78PRqvgF0ZtwKf/XJVXJGxk=
=NjTG
-----END PGP SIGNATURE-----

--LfQcPIWFRhGivmDw--
