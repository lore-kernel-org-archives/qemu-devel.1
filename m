Received: from eggs.gnu.org ([2001:4830:134:3::10]:58444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIzdT-0003IP-V4
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIzdQ-0004JY-Nr
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:46:11 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:44437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIzdQ-0004J3-Gz
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:46:08 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8380E3EB2F
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 17:46:05 +0200 (CEST)
Date: Thu, 8 Jun 2017 17:45:59 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170608174559.053df142@bahia.ttt.fr.ibm.com>
In-Reply-To: <018ad85d-6b7f-53d9-e3dc-4a79fcc81767@kaod.org>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692936183.12119.5013623492394505174.stgit@bahia>
	<5022e1af-9b70-518a-ce61-cadc905e637f@kaod.org>
	<20170608163207.45ba5618@bahia.ttt.fr.ibm.com>
	<018ad85d-6b7f-53d9-e3dc-4a79fcc81767@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/_0iVP1d5ekJNC1WnIYMSIWa";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 1/6] xics: introduce macros for ICP/ICS
 link properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/_0iVP1d5ekJNC1WnIYMSIWa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2017 16:51:35 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 06/08/2017 04:32 PM, Greg Kurz wrote:
> > On Thu, 8 Jun 2017 16:04:21 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> >> On 06/08/2017 03:42 PM, Greg Kurz wrote: =20
> >>> These properties are part of the XICS API. They deserve to appear
> >>> explicitely in the XICS header file.   =20
> >>
> >> I don't see the benefits.
> >> =20
> >=20
> > The links need to be set with the appropriate name otherwise XICS bails=
 out.
> > When David asked to rename the "cs" prop to "cpu",  =20
>=20
> yes. that is better.
>=20
> > I forgot to patch pnv accordingly in the first place. :)
> >=20
> > FWIW, other people do that as well (see hw/i386/pc_q35.c for example). =
=20
>=20
> well, I don't see the benefits of changing a string constant by a=20
> define.=20
>=20

Improved semantics, especially since the "xics" string appears in many
places with different meanings. But I don't want to bikeshed more, I'll
do as David says :)

> Cheers,=20
>=20
> C.
>=20


--Sig_/_0iVP1d5ekJNC1WnIYMSIWa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk5cTcACgkQAvw66wEB28KtbACdGo1yJMhMkBHFJnTImV/lRPYT
oEkAnR5YNEzmvAq4Tp/DJWRNgwR8VhsS
=GoBI
-----END PGP SIGNATURE-----

--Sig_/_0iVP1d5ekJNC1WnIYMSIWa--
