Received: from eggs.gnu.org ([2001:4830:134:3::10]:53230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqMcL-00077W-PS
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqMcG-0001RF-T6
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:26:41 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:46125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cqMcG-0001Qp-MS
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 12:26:36 -0400
Received: from player695.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2E882E1C80
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 17:26:35 +0100 (CET)
Date: Tue, 21 Mar 2017 17:26:31 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170321172631.6e780c1e@bahia.lan>
In-Reply-To: <20170321101308.48b30492@bahia.lan>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170321101308.48b30492@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/2unb=jVxWELdWLdLzU9vdbP";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/81] Patch Round-up for
 stable 2.8.1, freeze on 2017-03-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

--Sig_/2unb=jVxWELdWLdLzU9vdbP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Mar 2017 10:13:08 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Mon, 20 Mar 2017 18:07:24 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>=20
> > Hi everyone,
> >=20
> > The following new patches are queued for QEMU stable v2.8.1:
> >=20
> >   https://github.com/mdroth/qemu/commits/stable-2.8-staging
> >=20
> > The release is planned for 2017-03-30:
> >=20
> >   http://wiki.qemu.org/Planning/2.8
> >=20
> > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > think should be included in the release.
> >=20
> > Testing/feedback is greatly appreciated.
> >=20
> > Thanks!
> >=20
> >  =20
>=20
> Hi Michael,
>=20
> The 9p patches look good to me. Maybe you can consider adding:
>=20
> 0d78289c3dca 9pfs: fix off-by-one error in PDU free list
>=20
> I've already backported it to your stable-2.8-staging branch:
>=20
> https://github.com/gkurz/qemu/commit/85790d9a8b57e6710151e826053de0036ecb=
c3b1
>=20
> Cheers,
>=20
> --
> Greg

Maybe you also want this one:

d5f2af7b95b7 9pfs: don't try to flush self and avoid QEMU hang on reset

Cheers.

--
Greg

--Sig_/2unb=jVxWELdWLdLzU9vdbP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljRVDcACgkQAvw66wEB28IqXwCffq6DBw3wvawq6Dw6ddIk83/Y
WpsAnREcby3HjE2DDmGydF1QcswKH1Fe
=OaHK
-----END PGP SIGNATURE-----

--Sig_/2unb=jVxWELdWLdLzU9vdbP--
