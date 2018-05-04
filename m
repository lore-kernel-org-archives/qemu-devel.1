Received: from eggs.gnu.org ([2001:4830:134:3::10]:33036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fER4k-0001JB-T5
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fER4j-00051j-NS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:08:02 -0400
Date: Fri, 4 May 2018 13:07:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504030748.GP13229@umbus.fritz.box>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-35-git-send-email-mst@redhat.com>
	<20180504001556.GK13229@umbus.fritz.box>
	<20180504053740-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0WzQiIesntPPsVaS"
Content-Disposition: inline
In-Reply-To: <20180504053740-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 34/67] hw/ppc: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--0WzQiIesntPPsVaS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 05:39:57AM +0300, Michael S. Tsirkin wrote:
> On Fri, May 04, 2018 at 10:15:56AM +1000, David Gibson wrote:
> > On Thu, May 03, 2018 at 10:51:12PM +0300, Michael S. Tsirkin wrote:
> > > This way they are easier to find using standard rules.
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> > I don't really understand what this is accomplishing.
>=20
> Pls see the cover letter.

The cover letter that I wasn't CCed on, and won't appear in the git
history?  Ok.. I read that and I still don't really see how this
specific patch fits into the overall picture.

> The specific headers are used outside their directory so ideally long
> term either they should move to include or split or callers refactored.
>=20
> It's up to maintainers to decide what to do, I do not want to make this
> decision.
>=20
> > > ---
> > >  include/hw/ppc/e500-ccsr.h | 1 +
> > >  include/hw/ppc/mac.h       | 1 +
> > >  2 files changed, 2 insertions(+)
> > >  create mode 100644 include/hw/ppc/e500-ccsr.h
> > >  create mode 100644 include/hw/ppc/mac.h
> > >=20
> > > diff --git a/include/hw/ppc/e500-ccsr.h b/include/hw/ppc/e500-ccsr.h
> > > new file mode 100644
> > > index 0000000..08e4ba2
> > > --- /dev/null
> > > +++ b/include/hw/ppc/e500-ccsr.h
> > > @@ -0,0 +1 @@
> > > +#include_next "../hw/ppc/e500-ccsr.h"
> > > diff --git a/include/hw/ppc/mac.h b/include/hw/ppc/mac.h
> > > new file mode 100644
> > > index 0000000..e0f0b67
> > > --- /dev/null
> > > +++ b/include/hw/ppc/mac.h
> > > @@ -0,0 +1 @@
> > > +#include_next "../hw/ppc/mac.h"
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0WzQiIesntPPsVaS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrrzoIACgkQbDjKyiDZ
s5LXRg//Z8bNzZRMGPRr7WLeTz7/KUHudY0ZpBtYVo26Kng01U0YtsjQthnJR5kJ
AhXWnt9EoASGLuxmPu8bSgcegvGV4Y8Pzz5hI8UpYZg/P1IUkRB3yGdc7b6LsrdH
5isgBUnROGML+mg5GujxIf7NGsK+LG8t64B4s3qIujCVoHGVlWw2+hvTz2xLlU8A
SrsRPCyCiSfEVd4oOBgUEpcKpfqYdJHHvYjScBWghu/6FzM4seHscYK8NCQf5XbX
2ac73+T+T/6Ma30lVxPsrYECtm/bPg3fQ94p9fvD2Z2HgN99k9NiKLbf7AqZKB13
3X0Cr/dTdMp48CJJvbpHKTytPLwLrYWKSXtKh9cJ7z4F5/l7Bd2GYRmH7sQcE40U
gGdb4HyNF/HVDADMFMRwn5GYvtP0afEV6d6De4wvUvD+pFDQuNxZf/gHBxCsixjj
Vndec4wzCO2OUDBbAQLVPeALQolUoCzZ9dUVk0TBDStB1CE8nzl6t0IHvHcmPPRj
47M6/9wJQbdMSE78Gnq9gttuQuql0ZjUeovHc+QQz8W+OFX8riecJ6faRWXlDX7m
ojeCYSkOsJQJSDQ3AXzxu5cvu/6Uqi9SHulZnKoMZxVTFlHNa5Xj7aHxTKJvZ9zf
0hJVyCLJYyiC05yDrYnso2MMy/nwFAGpa+jm+wD/Ce1nPxVZooY=
=fx7f
-----END PGP SIGNATURE-----

--0WzQiIesntPPsVaS--
