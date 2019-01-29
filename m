Received: from eggs.gnu.org ([209.51.188.92]:48149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1goSSq-0005hD-Nb
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1goSSo-0005KZ-EH
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:26:04 -0500
Date: Tue, 29 Jan 2019 13:25:49 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190129122549.GW3382@angien.pipo.sk>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-3-kwolf@redhat.com>
	<20190128085041.GA16630@andariel.pipo.sk>
	<20190128144147.GA5756@localhost.localdomain>
	<87tvhszpql.fsf@dusky.pond.sub.org>
	<20190128174919.GL5756@localhost.localdomain>
	<87womovt0k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IfhPODtivl1BCmut"
Content-Disposition: inline
In-Reply-To: <87womovt0k.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/3] scsi-disk: Add device_id
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--IfhPODtivl1BCmut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 08:10:19 +0100, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 28.01.2019 um 17:55 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >>=20
> >> > Am 28.01.2019 um 09:50 hat Peter Krempa geschrieben:
> >> [...]
> >> >> 2) Is actually using 'scsi-cd'/'scsi-hd' the better option than
> >> >> 'scsi-disk'?
> >> >
> >> > Yes, scsi-disk is a legacy device. Maybe we should formally deprecate
> >> > it.
> >>=20
> >> There's an internal use in scsi_bus_legacy_add_drive(), which in turn
> >> powers two legacy features:
> >>=20
> >> 1. -drive if=3Dscsi
> >>=20
> >>    Creates scsi-disk frontends.
> >>=20
> >>    Only works with onboard HBAs since commit 14545097267, v2.12.0.
> >>=20
> >> 2. -device usb-storage
> >>=20
> >>    Bad magic: usb-storage pretends to be a block device, but it's real=
ly
> >>    a SCSI bus that can serve only a single device, which it creates
> >>    automatically.
> >>=20
> >> If we deprecate scsi-disk, we should deprecate these, too.  Can't say
> >> whether that's practical right now.
> >
> > Most likely not worth the effort anyway. I don't think it's blocking
> > anything.
>=20
> We could also wean them off the legacy device models.

In libvirt we should get rid of usb-storage usage, but I remember there
were a few ABI-related problems so that we could not plainly switch to
uas.

> >> >> 3) Since upstream libvirt supports qemu-1.5 and newer and 'scsi-cd'=
 is
> >> >> already supported there, can we assume that all newer versions supp=
ort
> >> >> it? (Basically the question is whether it can be compiled out by
> >> >> upstream means).
> >> >
> >> > I think so.
> >>=20
> >> Compiling out scsi-hd or scsi-cd, but not scsi-disk would be silly.  A=
ll
> >> three devices are in scsi-disk.c.  You'd have to hack that up to be
> >> silly.
> >
> > I understood this as a question about libvirt, i.e. whether libvirt can
> > drop/compile out their scsi-disk code and instead assume that scsi-hd/cd
> > are always present. Maybe I misunderstood, though?
>=20
> If questions remain, I trust Peter will ask.

I in fact wanted to know whether it's possible to compile it out of qemu
somehow. Removing it from libvirt is then easy.

--IfhPODtivl1BCmut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlxQRkkACgkQHGwCByjY
1GqW9Q//YRKGY1vXqZ+dk9ne9bUaeTFIsf0RXFCbc5kWUNkSv6T5Po31FYk2kdYI
C9mqKzz3C7cTYL1dXoxaxEdKECow4Ar1dMQhjejpriFDPB7zyWfQ/Ic06c9lfxYC
o5TOLAFtDFs7tqkewkGZUiYX6hfq0dLRLJQceQrcA8+USURQrRuW59xczkPN97Me
9ZSw8pW7B7/Omw7HLSUaVpQ7alZ980Ekyg4PLc+h5sRgV/dqXv6qiuUVWp4ftHwr
v2+N5yg1xw40F+WL/APiVAErYzXyil9FUhO6Zs6ID8DJlyGn1nUPc195DVzNZzWk
D4/G7KXFKRDNcGLEAhuZ46xrsET4142+ltac7TtXOD6GJSWQD0W8MHF/WbcmC/ah
nht4ezWhUgPGWOLGajR+veun+Aig0nT6PPPOlg31joXfJ9skmsSXvr0Dm7Co0J6n
IwtSs1AN2w8B6Z+8unoUb3X3o18KHFIMHivQ4gao16493fj0JPuqJbhXCIXZQT5F
KJXqFTgxsD+W+XGiQNdOxH1+BZCw/0HdY/9xw3dVzAAjWSHBpkV1zpsgmn/6PtZN
LW6UVKDGmwoCCjpHPbcnTKVYdh7pUUQmxKNuo+fF8GFWfT3g29lQtzfEMyU4pQoy
ysJhCSEmTCU8tK+tDSkkxjSwVFMDrGw8+TnaSzUsr1dAqDskjjA=
=6DMa
-----END PGP SIGNATURE-----

--IfhPODtivl1BCmut--
