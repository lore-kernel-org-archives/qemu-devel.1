Received: from eggs.gnu.org ([2001:4830:134:3::10]:39816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f1Phc-0005lD-MW
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 01:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f1Phb-0000w1-NW
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 01:02:20 -0400
Date: Thu, 29 Mar 2018 16:02:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180329050206.GM3510@umbus.fritz.box>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-12-david@gibson.dropbear.id.au>
	<f3c7bb1c-f4b9-3ffe-aeeb-bcedba620283@kaod.org>
	<05dd7870-11ba-7be8-ce45-6c9aba653226@kaod.org>
	<20180328084720.GI3510@umbus.fritz.box>
	<1e220d03-11cf-2c8d-d3ba-b816741fa4e3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I4g3zIzscEHdx6fd"
Content-Disposition: inline
In-Reply-To: <1e220d03-11cf-2c8d-d3ba-b816741fa4e3@kaod.org>
Subject: Re: [Qemu-devel] [RFC for-2.13 11/12] target/ppc: Remove
 unnecessary POWERPC_MMU_V3 flag from mmu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, groug@kaod.org, agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com


--I4g3zIzscEHdx6fd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 12:19:37PM +0200, C=E9dric Le Goater wrote:
> On 03/28/2018 10:47 AM, David Gibson wrote:
> > On Wed, Mar 28, 2018 at 09:49:25AM +0200, C=E9dric Le Goater wrote:
> >> On 03/28/2018 09:43 AM, C=E9dric Le Goater wrote:
> >>> On 03/27/2018 06:37 AM, David Gibson wrote:
> >>>> The only place we test this flag is in conjunction with
> >>>> ppc64_use_proc_tbl().  That checks for the LPCR_UPRT bit, which we a=
lready
> >>>> ensure can't be set except on a machine with a v3 MMU (i.e. POWER9).
> >>>
> >>> hmm, ok, but what will I use for the PowerNV hash MMU support then ?=
=20
> >>
> >> That will be POWERPC_MMU_3_00.
> >=20
> > You could check for that explicitly, or you could just check for
> > presence of non-NULL hash64_opts.  The idea is that will always be the
> > case for cpus capable of using the hash MMU.
>=20
> ok. I will rebase when your patchset is merged.
> =20
> > I'm also considering adding a similar radix_opts with radix specific
> > details. =20
>=20
> yes. It looks a bit unbalanced now.

Right.  In theory it would be nice to split out hash32 / BookE /
whatever options into their own substructures as well, but I doubt
anyone will ever care enough to actually do it.

> > POWER9 would have both, since it can support either mode.
> >=20
> >> I didn't realize mmu_model was so=20
> >> crowded ..
> >=20
> > It's not so that it's short of space.  It's more that the mix of enum
> > like pieces and bitflag like pieces like bits makes it confusing to
> > know whether it should be tested with simple equality or with &.  And
> > if testing with equality which bits should be masked for a sensible
> > comparison.
> >=20
> > Additionally, I'd like to get options that are strictly related to the
> > hash mmu out of the general structures.
>=20
> which are ? vrma_slb, rmls ?

Ah.. so.. for now I'm just thinking about MMU options / capabilities
rather than MMU state.  That is, things which are set at
initialization but then don't change.  rmls and vrma_slb don't fit in
that category.  slb_nr does, though - I had a shot at moving it to
hash64_opts, but hit some complications, so I might come back to it
later.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--I4g3zIzscEHdx6fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlq8c04ACgkQbDjKyiDZ
s5JGPQ//dQoxuglNfXIfRR7AjwPk0lQmxHLOKkU4cqg6SnvOQZfOoNLpv75fRogB
tuOnWyrTXwpIhTL4lVGotvN/FggbgWF7AdWe30dih35BSPe2udORJi0Psr7GvrOJ
Mz/NP2Pl6pKvskPGFusyv+1ysdqzIO/6QEpCh6PydV97YtDp1R9xBozkLnLODpX4
HC9TjfAwbsZB2MpYDdxgtbAt58YXN8v4uWNpXm3XRf2mMhddojySV8RYpKO9WcRC
ySPB854jXt64MpOpumWek7Z0LMiA4uFX0Sp9nZB2hSI6Mt+p+QdfQOKFhSODAowS
8PgHmJuTZgUe4wBKpE4XRgjbL1P0yKKgtLRc8Ia5xWDAOCnBFWi+ecljOrWXxktj
qYelVMieXG3x0s4Ykk3tzbsQJrgo6ZI7eIRbX12Qd+k0Z3692AiYjVYQP4a/p1PJ
eykEclfdKwyMoueOB2GCXZnFBbDRCqxumx20ExN7E4qIph9AmKGsRhSbfTO2Fiwv
fLN3Tg/EjRR8nql/dtMqDcstKgL9MOd8DwyF5S4QyJ2Q+XCC2U5GkBvbwLrhNc8b
AmoDv5LwRSLBra2pK0Q64uy9GtyIeEZxcc4unODgZ7HKcLozumjd9IXd9PDrka+r
vEFBqsmLXu7l6Kc+VkK31iTdXO+FrTT0wQ/fOZj9adnyWYDRjtI=
=NWeg
-----END PGP SIGNATURE-----

--I4g3zIzscEHdx6fd--
