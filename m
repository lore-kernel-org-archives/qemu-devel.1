Received: from eggs.gnu.org ([2001:4830:134:3::10]:37600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dLA5L-0007RQ-GN
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dLA5I-0007JH-AM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:19:55 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:41776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dLA5I-0007IH-3i
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:19:52 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7CD7A1061F0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 17:19:50 +0200 (CEST)
Date: Wed, 14 Jun 2017 17:19:40 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170614171940.2d571c14@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170614144124.GC2614@umbus>
References: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
	<20170614144124.GC2614@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Fo9S=DwY1Bybh8r+S2ycOfw";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 0/3] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

--Sig_/Fo9S=DwY1Bybh8r+S2ycOfw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jun 2017 22:41:24 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jun 14, 2017 at 03:28:43PM +0200, Greg Kurz wrote:
> > Cc'ing Laurent because I needed to incorporate the "spapr: manage hotpl=
ugged
> > devices while the VM is not started" patch in this series to be able to
> > verify that the "CPU core unplug" part of patch 3 behaves as
> > expected. =20
>=20
> I've merged patches 2 & 3.  I haven't applied 1/3, because I think
> it's really just a bandaid for other problems with the DRC state
> management.
>=20
> If you want to expedite getting that fixed, you could start by
> reviewing my part IV DRC cleanups...
>=20

It's on my TODO list, just after the 're-run all migration tests for David's
"Clean up compatibility mode handling" series' item... Laurent's patch was =
just
the quickest path to be able to finish the work on xics migration.

I'll switch to reviewing your part IV DRC cleanups right away.

Sorry for not keeping the pace :)

Cheers.

--
Greg

--Sig_/Fo9S=DwY1Bybh8r+S2ycOfw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllBVAwACgkQAvw66wEB28I3MACfTREwuqg60sNytDCrO1LLAmwg
50QAnj0dskNHEQhMhGjM9HW6LceUGr6M
=gDB4
-----END PGP SIGNATURE-----

--Sig_/Fo9S=DwY1Bybh8r+S2ycOfw--
