Received: from eggs.gnu.org ([2001:4830:134:3::10]:42522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dtUF6-0006NZ-Rq
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 03:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dtUF5-0002su-MV
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 03:43:52 -0400
Date: Fri, 15 Sep 2017 19:09:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915090915.GP5250@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100571083.27487.4628655387393519076.stgit@bahia>
	<20170728034925.GF3098@umbus.fritz.box>
	<20170728123035.70cdd434@bahia.lan>
	<20170731025825.GC2652@umbus.fritz.box>
	<20170906133209.0a497a2c@bahia>
	<20170913122329.GB3972@umbus.fritz.box>
	<20170913145651.4032fb99@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+W7ryvxEk4RRyt+P"
Content-Disposition: inline
In-Reply-To: <20170913145651.4032fb99@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 18/26] spapr: create DR
 connectors for PHBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--+W7ryvxEk4RRyt+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 02:56:51PM +0200, Greg Kurz wrote:
> On Wed, 13 Sep 2017 22:23:29 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> [...snip...]
> > > > > Also, if all PHBs are instanciated with index !=3D -1, we're limi=
ted to 31.
> > > > > Maybe this could be the default value for the machine property in=
stead of
> > > > > 256 then ?   =20
> > > >=20
> > > > Actually, if we're binding it back to index, which has a hard limit,
> > > > then it no longer makes sense to have it as a property and we should
> > > > go back to a constant (well, it could vary by machine type version)=
=2E =20
> >=20
> > Sorry I've taken so long to reply.
> >=20
>=20
> Oh, don't mention it. :)
>=20
> > > But I guess that the hard limit of 31 as described in the changelog of
> > > commit 357d1e3bc7d2d80e5271bc4f3ac8537e30dc8046 still holds, doesn't
> > > it ? =20
> >=20
> > That's right.  Note that that is a limit of *31* PHBs (numbered
> > 0..30), not 32 PHBs numbered 0..31.
> >=20
>=20
> Yeah I saw that.
>=20
> > >     Because some guest versions (including most current distro kernel=
s) can't
> > >     access PCI MMIO above 64 TiB, we put all the PCI windows between =
32 TiB and
> > >     64 TiB.  This is broken into 1 TiB chunks.  The first 1 TiB conta=
ins the
> > >     PIO (64 kiB) and 32-bit MMIO (2 GiB) windows for all of the PHBs.=
  Each
> > >     subsequent TiB chunk contains a naturally aligned 64-bit MMIO win=
dow for
> > >     one PHB each.
> > >    =20
> > >     This reduces the number of allowed PHBs (without full manual conf=
iguration
> > >     of all the windows) from 256 to 31, but this should still be plen=
ty in
> > >     practice.
> > >=20
> > > Not sure why a machine type version would have a different limit. Can
> > > you think of a use case ? =20
> >=20
> > Well, the older machine types had a different layout.  It allowed for
> > more indexes, but had smaller windows, which meant certain cards (e.g.
> > GPGPUs with huge BARs) didn't work properly.  It also had some weird
> > alignments that meant we were a bit wasteful of address space.
> >=20
> > But we can't change the location of PHB windows on migration, so we
> > had to maintain that old layout for old machine types.  That's why
> > there's a different limit depending on machine type version.
> >=20
>=20
> Ok, so we *just* have 2 different maximum number of PHBs:
> - 256 for pseries <=3D 2.7
> - 31 for newer machine types

Yes, at least for now.  If we ever discover that 31 PHBs *isn't*
enough, we may have to come up with yet another layout, which could
have a different limit.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+W7ryvxEk4RRyt+P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7mLoACgkQbDjKyiDZ
s5LNtw/+N5uOtJAyWnklhyOCNBX4iTmYo7zGKLX9kfmqu9+Ek9JazWfe0QHBla5c
Flt0tCZ1uoMX6CsKyzWv9gL6/IPNfb137oC20vpv4NdxK1jlg12t090rxm3C1o7Y
Hy8pRrWFO5VWVdxHyckK18zieZiIuiPFOxqVSCY4SnDp81OS+dye3fN+PBQDRfsb
PdyVqwWGEDg+Vc7hgL0i4b/IplFpF56XG8NP9EG/Y1HiZam+bKy6AEMzt9NViqLi
z123BfyhJSFVKbCzIRj3dRRPKop2ZBblTsIPFLq69bkbfdKKeOplhz0wjhFc/HrC
sNhXsjDR64XYoTUJ0pESpEB+KNZuUJXQO51oLQqfmg+CfcmH3Kn2bG7/dmZXFBNB
qH9Sz1ufrmvKqVROx/X3ISpFcpZfvIuY3l8HqTXdyA4MzuHNs/rWPNoRpP9rPhQN
6qICJQZOtbuZ1dPMSDbdsyDCLTHgr5WDzEpWmWpqDpqVqTSNDJwqPCu7ThpygDPd
5YuIR4fg68tF4GsfoGD4+tNfhQyjnbM/tQCTyX+5HJd7TA+8T+6J7cV3wNdyLm0y
oMNVSLxlNuawqI7LmezDemq+JXFzh2rIUMYm16aXAHHznZ2IX/FXCO8S7eu/1SOS
u7XAHtls4Xj16HHzoaXWhrkRiGhQ7RNHxhVgM6Y63r9fYk03shc=
=yPwH
-----END PGP SIGNATURE-----

--+W7ryvxEk4RRyt+P--
