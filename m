Received: from eggs.gnu.org ([2001:4830:134:3::10]:58202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAIlg-0001XV-2t
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAIla-0007MU-FU
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:22:44 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:40597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAIla-0007Ld-90
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:22:38 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 9163D1D5D1
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 18:22:36 +0200 (CEST)
Date: Mon, 15 May 2017 18:22:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170515182231.7ce91bce@bahia>
In-Reply-To: <b2fe560d-e8ef-dc47-2f7a-e06092a503b6@kaod.org>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
	<20170515151602.61dc381d@bahia>
	<b2fe560d-e8ef-dc47-2f7a-e06092a503b6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/gev_.S0e8r29+PbTu2jM1lS";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/gev_.S0e8r29+PbTu2jM1lS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 May 2017 18:11:27 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> >>> +        int smt =3D kvmppc_smt_threads();
> >>> +        int nr_servers =3D DIV_ROUND_UP(max_cpus * smt, smp_threads)=
;   =20
> >>
> >> may be we should reintroduce nr_servers at the machine level ?=20
> >> =20
> >=20
> > I had reintroduced it but then I realized it was only used in this
> > function. =20
>=20
> nr_servers is also used when the device tree is populated with the=20
> interrupt controller nodes. No big deal.
>=20

Ah yes you're right. Maybe this can be factored out in a followup
patch.

> C.=20
>=20


--Sig_/gev_.S0e8r29+PbTu2jM1lS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkZ1ccACgkQAvw66wEB28K0VwCeM3m6RR7itpDMYiyuHn1NbTpR
fnUAn0Kl/x5KvQoUBuFylIUWvvcjOYdA
=A/Tm
-----END PGP SIGNATURE-----

--Sig_/gev_.S0e8r29+PbTu2jM1lS--
