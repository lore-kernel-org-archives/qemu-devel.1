Received: from eggs.gnu.org ([209.51.188.92]:53186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12EW-0005Ud-0l
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12ES-0008SA-CX
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:03:14 -0500
Date: Tue, 5 Mar 2019 15:55:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190305045543.GH7877@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190228083821-mutt-send-email-mst@kernel.org>
	<20190305005332.GB7877@umbus.fritz.box>
	<20190304211210-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <20190304211210-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] Improve balloon handling of pagesizes
 other than 4kiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 09:13:03PM -0500, Michael S. Tsirkin wrote:
> On Tue, Mar 05, 2019 at 11:53:32AM +1100, David Gibson wrote:
> > On Thu, Feb 28, 2019 at 08:39:21AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Feb 14, 2019 at 03:39:11PM +1100, David Gibson wrote:
> > > > I posted some RFCs for this back in December, but didn't wrap it up=
 in
> > > > time for 3.1.  Posting again for inclusion in 4.0.
> > > >=20
> > > > The virtio-balloon devices was never really thought out for cases
> > > > other than 4kiB pagesize on both guest and host.  It works in some
> > > > cases, but in others can be ineffectual or even cause guest memory
> > > > corruption.
> > > >=20
> > > > This series makes a handful of preliminary cleanups, then makes a
> > > > change to safely, though not perfectly, handle cases with non 4kiB
> > > > pagesizes.
> > >=20
> > > I'd like to see a version of this that does not depend on patch 1 whi=
ch
> > > is not a cleanup nor a bugfix. Could you look into this please?
> >=20
> > Ok... the original series is already applied to master, so I'm not
> > exactly sure what you want me to do here.  Should I try to come up
> > with a "logical revert" of the first patch?  Or do you intend to
> > revert the whole series, and I rewrite the series without the first
> > patch?
>=20
> Whatever you prefer. Maybe the best idea is to add a flag
> that says whether to madvise or not. Default can be compatible.
> Hmm?

Ok, will do.

As I was looking at this I noticed a bug in the current code.
Extremely unlikely to hit in practice, but could result in guest
memory corruption if it does.  So, I'll fix that as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx+AUwACgkQbDjKyiDZ
s5K5xxAAjGYCHR89RSO6K8ZnRSYhN4oheP0WbkbamSp0h+M15v/JB1i2LFzcwDGq
DMMyV/cvpkZvwiQkWPnzYgVzZolQCoCt2X5efW3jldGS+G3pQgEK27gmkTFt3A1d
d8O9McF3xuNsnZjU2SqtEHX7/DDSUl2uxRdAJ866rJSJwYlAsOhDPkO6ahI2CHLc
K35A0R82TStK4SgsSwDIeFg92hzje+uCRLDLdpoclu0cnBi/euKefPDZJNYOkLfi
FAoWXWkOGK9E9RFjbL+Xc6dMplA2z6pgHVbMZsBgJd1foi7fq13wGVCRiy9eHdaB
j2+N1dlja3yHF0FZE/j12lxlfosH+1lgTsHTH+FMNUVvgoN9oYeouq05PB0b5xOS
PAQLzkpiJn/bNR2G+2nMRGZNt4dNoQgmp6gIT4pzMsZXIxH4Nycm/rVHb3cw4xE2
6lIAjg5XWwHkXDsjT3f9tFZa4aTr2ktiO/AegDt8ypGnCH4wxJXAdwkZ/XX51Ym9
n4gjitCebrStS5UqnOIdAEJVHOgxieWZgIwFXknWwr4s5ZhRUFDurFjwCij6V24W
2UC0XHLnkmoJrdrweqdilZYeHq/3/O4JYh1PZK5pDHx7mnJNplhFkIUOgZhsLHKS
8c83zsYg9wYrxyBrxAO7j0JmN3WOwl1NSrZGeTfBlvs/sbckr/I=
=q4xm
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
