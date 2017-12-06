Received: from eggs.gnu.org ([2001:4830:134:3::10]:32988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMXfP-0006Vo-8i
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMXfK-0003fQ-VO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:15:07 -0500
Date: Wed, 6 Dec 2017 22:14:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206111449.GF3057@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<f16023f8456fc137647cd6c60d5e2138d8a9afa2.1511731946.git.mdavidsaver@gmail.com>
	<20171130051315.GF3023@umbus.fritz.box>
	<b0ded63a-f654-94c4-4fef-3cdbf7764a97@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="py13wRIzy9nU46ee"
Content-Disposition: inline
In-Reply-To: <b0ded63a-f654-94c4-4fef-3cdbf7764a97@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 05/17] timer: generalize Dallas/Maxim RTC
 i2c devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--py13wRIzy9nU46ee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2017 at 03:15:10PM -0600, Michael Davidsaver wrote:
> On 11/29/2017 11:13 PM, David Gibson wrote:
> > On Sun, Nov 26, 2017 at 03:59:03PM -0600, Michael Davidsaver wrote:
> >> Support for: ds1307, ds1337, ds1338, ds1339,
> >> ds1340, ds1375, ds1388, and ds3231.
> >>
> >> Tested with ds1338 and ds1375.
> >>
> >> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> >=20
> > I certainly like the idea of consolidating this code, but reviewing to
> > see that the new code really is a generalization of the old is
> > something I won't have time for for a while.
> >=20
> > Also, hw/timer is not within my purview so it'll probably need to go
> > another path to merge.
>=20
> Could you be a bit more explicit about what, if anything, I need to do
> to move this forward?

Ugh.. that's pretty tough, since ds1338 doesn't have an activate
maintainer.  You can look at the git history for some possible
candidates of people to ask about it, but it hasn't been touched much
in quite a while.

One approach that could help is to re-order so that your testing
rework goes before the change to ds1338.  If your new generalization
can pass the same set of tests as the original ds1338 code, that's at
least a good start on being convincing that it's a true superset of
the previous functionality.

The other approach is to do the rework in a rather longer series of
patches.  Start by simply moving ds1338.c, then do a mechanical
replacement of the names within it, then start generalizing and
altering.  That's a lot of work for you, but it makes it much easier
to review each step

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--py13wRIzy9nU46ee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlon0SkACgkQbDjKyiDZ
s5Lrpw/+PXDN4d/Rd/5k3gVNRWaDpb9FbXWu/UXdex8UBMA5o8dsx0Hy6phLknc+
K/Ml54qhSQ3gepr+DQkS/DM1sHxchBwZv/nf0JLXL0rex4AKWiXWzzbn43iAi0UF
VS2nIJFj8/tuxlxQeHdqlLEmXMFSh17MqH45MW+tJ/m7ewcstTwX2VFtTbK8Z+oB
jMmFgc8PWd8qS2Ba5DzNUhv2UtaqvadBgppgneNM1L5z18GOQcZolDU8XdacjW6q
QvPTC499ZpIRT4iQwrzjxMGSNNEHJIRXtLvlo8NRUt7PAxN6EGJk8NKVaD+MYHDJ
pDVyppsmC4tpTC0zN/k69wYVyLfSrQS49NWkOg8/akr2RCtI5HcqPpkea5JnYLSS
YqxYDVsy+L5Xu1pKCnKBBR7OcM4j26xAZYq5XMtHWkeoOnF5QpkJPGir6aAjBjMr
46Qd5oIMZ3/vdKVrfUAnl3TI5Tv/CyNOGlh1/uR7UTkZbi/QQJd1FzdPd646zWlw
ZNQhlNEApyaFMhVphNCMbrS/kTOt4KyM3bzKGsxn7sG00nhcdJMHq4SXGNFnu8We
tbA5XczmtSU/kZeltQaAZ8n7G4wwTM4td64hTL2nQmZMHUZMip+ptdXwWCWgSc+K
MHLPDRYHow1igF92T2PZYNW2UMd3Rcr7IDtR8/p07YRNiq6fWl4=
=RsCO
-----END PGP SIGNATURE-----

--py13wRIzy9nU46ee--
