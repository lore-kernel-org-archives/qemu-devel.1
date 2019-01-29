Received: from eggs.gnu.org ([209.51.188.92]:44172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1goPym-0001mL-O2
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1goPyl-00069g-RI
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:46:52 -0500
Date: Tue, 29 Jan 2019 10:40:35 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190129094035.GV3382@angien.pipo.sk>
References: <20190125174653.4604-1-kwolf@redhat.com>
	<20190125174653.4604-3-kwolf@redhat.com>
	<20190128085041.GA16630@andariel.pipo.sk>
	<20190128144147.GA5756@localhost.localdomain>
	<87tvhszpql.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OFtM20PmL5gDcvsL"
Content-Disposition: inline
In-Reply-To: <87tvhszpql.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] scsi-disk: Add device_id property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com


--OFtM20PmL5gDcvsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 17:55:14 +0100, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 28.01.2019 um 09:50 hat Peter Krempa geschrieben:
> [...]
> >> 2) Is actually using 'scsi-cd'/'scsi-hd' the better option than
> >> 'scsi-disk'?
> >
> > Yes, scsi-disk is a legacy device. Maybe we should formally deprecate
> > it.
>=20
> There's an internal use in scsi_bus_legacy_add_drive(), which in turn
> powers two legacy features:
>=20
> 1. -drive if=3Dscsi
>=20
>    Creates scsi-disk frontends.
>=20
>    Only works with onboard HBAs since commit 14545097267, v2.12.0.
>=20
> 2. -device usb-storage
>=20
>    Bad magic: usb-storage pretends to be a block device, but it's really
>    a SCSI bus that can serve only a single device, which it creates
>    automatically.
>=20
> If we deprecate scsi-disk, we should deprecate these, too.  Can't say
> whether that's practical right now.

Unfortunately we did not bother replacing usb-storage yet.

scsi-disk was unused for some time (if scsi-hd was supported). I just
deleted any mentions of it from libvirt now.

>=20
> >> 3) Since upstream libvirt supports qemu-1.5 and newer and 'scsi-cd' is
> >> already supported there, can we assume that all newer versions support
> >> it? (Basically the question is whether it can be compiled out by
> >> upstream means).
> >
> > I think so.
>=20
> Compiling out scsi-hd or scsi-cd, but not scsi-disk would be silly.  All
> three devices are in scsi-disk.c.  You'd have to hack that up to be
> silly.

That would be a downstream modification of qemu thus libvirt will
not want to support that.

--OFtM20PmL5gDcvsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlxQHvQACgkQHGwCByjY
1Go6pQ/45m/tJwGrynJ4wRXrB9ZbGl4VSkowhepkpbsg73uD2rT0X53Kh4Wp75Bm
rbNZMje4L7/xwHT1fQSovEa4UQoAVCI/dDrwpisiErcSL7LpwXIyW20IdZcp700z
9doINYl5FjkcnnXcgVlbCIvitGBjxaes4exDW8rzrd/PGd6qH35Bn3iDEJRROmkB
tmNduqpgMMMpqqS7yms9xQjegfwX9TV/tNjCh228bhaq8tdvG/19OJkN05tdToj4
kpRcztA1IK7/EtqYplipT0hAVjy7SAlkjTz86EuaAkJfIK6llZT0kim04Lzee4Xl
YoezYVqxSWy4yWrHBo6wfh76MtCbueCV34LRLjN1eHdjdVNuppfrk8eB1PeKd900
Pw39hU6RUZS6mPmj/+yBwm5+tG1FKx2cz3c4jmddU049URtyKGXw008pHX7Ics7s
qTJGSBCWvaodZ3caJogJIzt3X+yjk+W8I+tIiYL/UDt/+ESxr/E2eNfSWpF23mcO
fLmFlQtOWdhUON2nCFz01cmgpG9EOsD8+HCEEWbag8omrrOrQDYe62nqeCIET4aJ
cqhZKS8lmBiZEt8NT/DU9YrP+dTHlHjHeWButxVeTnd+6xMtzorgqRVmdSolS9c4
81pC3SlTe5vn2aeKHr0LAkXumlj+EhoR/CmF6OMndPhJaquZ8Q==
=KXTq
-----END PGP SIGNATURE-----

--OFtM20PmL5gDcvsL--
