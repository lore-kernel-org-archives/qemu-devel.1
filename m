Received: from eggs.gnu.org ([2001:4830:134:3::10]:33462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dITmt-0004HI-J0
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 01:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dITmo-0002wJ-OG
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 01:45:47 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:51303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dITmo-0002ud-IR
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 01:45:42 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B629D3E084
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 07:45:40 +0200 (CEST)
Date: Wed, 7 Jun 2017 07:45:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170607074531.58f9c4e9@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170606234506.GF13397@umbus.fritz.box>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20170606234506.GF13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/kF24Ms.Va0HzH2LM2F8jcFe";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 0/3] ppc: fix memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org

--Sig_/kF24Ms.Va0HzH2LM2F8jcFe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Jun 2017 09:45:06 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 06, 2017 at 05:22:42PM +0200, Greg Kurz wrote:
> > Coverity just reported a memory leak introduced by this commit (QEMU 2.=
9):
> >=20
> > commit df58713396f8b2deb923e39c00b10744c5c63909
> > Author: Thomas Huth <thuth@redhat.com>
> > Date:   Wed Feb 15 10:21:44 2017 +0100
> >=20
> >     hw/ppc/spapr: Check for valid page size when hot plugging memory
> >=20
> > It boils down to the fact that object_property_get_str() returns a stri=
ng
> > allocated with g_strdup(), which must be deallocated with g_free() at s=
ome
> > point. =20
>=20
> Applied to ppc-for-2.10.  Do we need to queue this for 2.9 stable as
> well?
>=20

Yes.

--Sig_/kF24Ms.Va0HzH2LM2F8jcFe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk3kvsACgkQAvw66wEB28IRmgCdGnnYOZBLHCFM7y/p93Ngd5jV
c8QAn2y7gYk72pntn7iON7lJDvrLL/wT
=+k1k
-----END PGP SIGNATURE-----

--Sig_/kF24Ms.Va0HzH2LM2F8jcFe--
