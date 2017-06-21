Received: from eggs.gnu.org ([2001:4830:134:3::10]:33879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbJq-0008Kn-8S
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dNbJo-0003Jr-W1
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:48:58 -0400
Date: Wed, 21 Jun 2017 16:15:07 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170621081507.GD12089@umbus>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-3-david@gibson.dropbear.id.au>
	<20170620183249.3d67141e@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <20170620183249.3d67141e@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] spapr: Uniform DRC reset paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 06:32:49PM +0200, Greg Kurz wrote:
> On Tue, 20 Jun 2017 09:53:29 +0800
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > DRC objects have a regular device reset method.  However, it only gets
> > called in the usual way for PCI DRCs.  Because of where CPU and LMB DRCs
> > are in the QOM tree, their device reset method isn't automatically call=
ed.
> > So, the machine manually registers reset handlers to call device_reset(=
).
> >=20
> > This patch removes the device reset method, and instead always explicit=
ly
> > registers the reset handler from realize().  This means the callers don=
't
> > have to worry about the two cases, and we always get proper resets.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> This indeed simplifies the code. It also has the interesting effect that
> nobody cares for the return value of spapr_dr_connector_new()
> anymore.

True.  I think I'll leave it there for now, though, since *_new()
functions generally return the object they created.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSisLAAoJEGw4ysog2bOSFWgP/1cQbUlCd98hlutfjCVD9pRZ
6I9mREZQZvENFIt1Cc50pyK2xtv9GbpSl/gIsl1d0+XIzzZPC3efF+XJ43zoQ6YQ
MeC9oLFg6mMk1XJHv/XSkGMKMxrJVCDjHjzQP9cICoCofvXIuWz6rntwFoE1oQc7
EBos9iMyA/pwi3e2MrnkiXvUJU0ZQJNgBpQ7DTghv4hwaF+XmsyUiT05inVqjwBK
CrqVAFfkkFD5dRtquWG3hKrzoRTTK7BOsE71v+v7bVe83rts1BN/4/KgXm7gBZmN
y6oAk7zAmLiVR4OKxgSfw7T2OPwBQIuBPlhnsT7SQ40V8LSYlM70lCLWB0cdcOo4
Ysw2uSeFskWnjvPfa8rkWP47URFJEvbbMUfbhNjuOVEIdxB1OW8GFji63k2o4msJ
qLiCkN1Yx7jDPPpAHqUQ13qXJFSVcGoDxXT/GvVZudNa5Zrbw0V+UiQYDifwVrAg
HaBjdr5w3TOGPdSud5czV9sNd7tr2kGwHfBQwAahNWH9ECJVyrGQkrOptJF3aTBV
nlaT4/Pl9bSYIkizDOLflSJpTPns5aMMPbmRJXbEuvecCO/xgKo/0NN69lwt8JHr
t9w6Xy3C5jKDlBgnB+5L9GVlp1OExP1Aryh33K2gnK1qmYCyDQhcyzpMnzCHSS1h
oLXYPC8CGzVgnpEQ0XO7
=kZk8
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
