Received: from eggs.gnu.org ([2001:4830:134:3::10]:37277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsLG0-00014a-CN
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 23:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsLFz-0000xn-8z
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 23:56:04 -0400
Date: Thu, 14 Sep 2017 13:54:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170914035442.GL3972@umbus.fritz.box>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911105729.GC2784@umbus.fritz.box>
	<1d0c4384-fc32-05bb-7e42-44480f51610f@ilande.co.uk>
	<20170913071955.GJ7550@umbus.fritz.box>
	<03166ac2-6209-9301-16b5-244744d3ebd5@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HLsZ5Z1opAQvdr2J"
Content-Disposition: inline
In-Reply-To: <03166ac2-6209-9301-16b5-244744d3ebd5@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 3/4] ppc: add CPU access_type into the
 migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--HLsZ5Z1opAQvdr2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 06:17:21PM +0100, Mark Cave-Ayland wrote:
> On 13/09/17 08:19, David Gibson wrote:
>=20
> >> When pausing a VM, does execution stop at the end of the current TB
> >> rather than immediately? If so, perhaps someone could confirm that
> >> guarantee is good enough for access_type?
> >=20
> > I'm pretty sure it has to; we'd have to come up out of an individual
> > TB in order to get to the main loop where we check the "please pause"
> > flag.  I'm not sure if that helps us here though - I *think* access
> > type is about carrying information from the point where we trigger an
> > exception to the point where we actually start processing the
> > exception.
> >=20
> > This code is really ugly and I've never understood it well :(. It's
> > always seemed bogus to me that we have an essentially global variable
> > to carry information over that small gap, though.  Unfortunately it's
> > unlikely that I'd be able to dive into this and work out if it's
> > really needed any time soon.
>=20
> >From my testing yesterday it does appear to be required for TCG (or
> unless this is exposing another bug in the Mac migration) so I can check
> it works here and then maybe someone else confirm it works on KVM?
>=20
> A couple of things I've noticed: the heathrow VMStateDescription looks
> good, however I can see that the OpenPIC timers won't likely migrate
> correctly without adding a few more fields - that's easy to fix.

Right.  And since OpenPIC isn't used on any platforms that have real
production use in the wild, it's fine to bump the migration stream
version for it.

> Another thing is that if we're changing the migration stream for Mac
> models Ben has some OpenPIC and other related changes in his wip queue
> that it might make sense to put those in first before properly fixing
> the Mac machine migration.

That would have something to be said for it.

It's probably not essential, though, since I don't consider the
non-pseries platforms at this stage sufficiently mature that we
guarantee a stable migration stream format.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HLsZ5Z1opAQvdr2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm5/YIACgkQbDjKyiDZ
s5JT7w//Uy4eOabAqdKchvKyvFrOxp1GlngJoENEmc+XQMZmBBuXWmxYyY5JMd7e
zdRrF12WyM1h2eVrtVgEhPhD1woHERd5LRaXrlev8Bng6ORvzQXTzl3D4pF7QGkx
CZTcJLuwdkjEXzSsUJT8rj74VYbow13rhtTN+zQ/SvxQAH7uRPT5cgXxuYvQNvUj
rx/+yRfoNx2UlxkJpk83FxF5U9E4+vXS4hD7Ltuyt1FOoQETyQNuWp+T9taROKM6
dLVO6Uz/bsG3rdx5yVBB56roOvrCGPYQkvHj73RFFqROmnhjmuZZFBknc3o1RNkr
DaqTMoy0dXKcxW8NFW55cjrwU0kQ7IHK4XbywvXQMMwhuUezqGue1X+eUM5RFBzp
iOrzHsmCJUjOiolSBW345CnCfr/zx1pYwGt6/ZvrMKzlbqlKtStvUELVNJ8wpZZc
DaPksRUsIGCwxWy5dtRJcwum5ZzjLLr/UeYK5zxA9aBvGObtpG9BSOy6EJnSvfo+
9bsERN78wTYLK2cPSndbhOlqhBu4U/i5TQNdGSOL5zM6Dd7QL52Oer5kanB6hDvQ
oeUJBP8YWv+oYYcjOL2gg1/5k2lqtfUZT/sBD6NwDJ0icWQaebOQQgkylvEuHp1/
HMwzskSiGzVCiOXNoYl1nyuXcsqY1FhFDIb09xSy6bD1a3ssd7A=
=Xpv5
-----END PGP SIGNATURE-----

--HLsZ5Z1opAQvdr2J--
