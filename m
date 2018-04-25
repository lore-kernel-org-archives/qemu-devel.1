Received: from eggs.gnu.org ([2001:4830:134:3::10]:47332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBE0h-0004HO-DE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBE0g-0004tc-24
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:34:35 -0400
Date: Wed, 25 Apr 2018 16:32:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180425063257.GT19804@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
	<1524584159.23669.13.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rBVNTu5JXDAWzN2S"
Content-Disposition: inline
In-Reply-To: <1524584159.23669.13.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org


--rBVNTu5JXDAWzN2S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 05:35:59PM +0200, Andrea Bolognani wrote:
> On Fri, 2018-04-20 at 20:21 +1000, David Gibson wrote:
> > On Fri, Apr 20, 2018 at 11:31:10AM +0200, Andrea Bolognani wrote:
> > > I'll have to look into it to be sure, but I think it should be
> > > possible for libvirt to convert a generic
> > >=20
> > >   <memoryBacking>
> > >     <hugepages/>
> > >   </memoryBacking>
> > >=20
> > > to a more specific
> > >=20
> > >   <memoryBacking>
> > >     <hugepages>
> > >       <page size=3D"16384" unit=3D"KiB"/>
> > >     </hugepages>
> > >   </memoryBacking>
> > >=20
> > > by figuring out the page size for the default hugepage mount,
> > > which actually sounds like a good idea regardless. Of course users
> > > user would still be able to provide the page size themselves in the
> > > first place.
> >=20
> > Sounds like a good approach.
>=20
> Unfortunately it seems like this is not going to be feasible, as
> POWER8 is apparently the only platform that enforces a strict
> relationship between host page size and guest page size: x86,
> aarch64 (and I have to assume POWER9 as well?) can reportedly all
> deal gracefully with guests migrating between hosts that have
> different hugepage mounts configured.

Yes, that's right.  As you guess POWER9 will also allow this.. at
least as long as the guest is in radix mode.  If the guest is in hash
mode (which includes but isn't limited to POWER8 compat mode guests)
then it will suffer from the same pagesize limitations as POWER8.

> I need to spend some more time digesting the rest of the
> information you provided, but as it stands right now I'm starting
> to think this might actually need to be its own, explicit opt-in
> knob at the libvirt level too after all :(

Poo.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rBVNTu5JXDAWzN2S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrgIRkACgkQbDjKyiDZ
s5KuMg//WipwgSSJFWjG+m5zERpqGuTwgunCdMfy7CoK3rFvci/7XxY7pdqaf0dv
3LkrcKCVWqWZZbFDmsa2fcUaKk7GiQdLFNncJumW4+zj4iVi5Ew2fxGb6kTB0D8g
rZCZVTbnvlNADSBvvUlX2AD9T0ZDIn4DpYkTPKU1Ud1f4CHccbwnx1ygHt1VwqyK
PGbJHn3Y+5gpAmtS3I4a0jm4r7yjNyMNYk4JXiIKQo27He+rW+Nhy8BQy5r9Z286
4M9wxq9Po5yfZFYXahAz0mVRcmf2upiTSr+/v4dApQYqLDSTca73iYWXP6+LER49
EQT7zjJzl6WYG+Sic9Ns0B6ajFY33HmPud6kgsa40+cgasbFOjIgzdZuKL5XrRIt
TTD6vyzfjIc3iJyr8J1v6LN0alxn+NlEWkpK57ysjej/01IKRChrHPD47QtSmTcB
cRNYW2cUeSq0WBgmFQ1Lxgy6THKMltLimJaGuu8jc7qRgtJmTA1GuSh1AiMeRtnj
TUDV3kHXonoDeRlIf1piuRGVJqhqdabwVYPLtqmgyTuC+BgAOn5pwE6qw2ysa1fs
VTAfdY424GSxoRofBEGtvGIAq/3u3c9DQtEkt6FIIhJx6KSfSQ5n/CxyIB6OSwKc
fcBuo5tq4GFtA8lfuUNUq2hUyCSQNnTAVWoHw/P7PP96BIjANRM=
=CHYD
-----END PGP SIGNATURE-----

--rBVNTu5JXDAWzN2S--
