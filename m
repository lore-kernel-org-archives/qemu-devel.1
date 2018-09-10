Received: from eggs.gnu.org ([2001:4830:134:3::10]:35000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDsz-0005zU-Ud
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDsy-0003cl-N4
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:33:17 -0400
Date: Mon, 10 Sep 2018 14:33:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180910043304.GC24181@umbus.fritz.box>
References: <20180814165954.9892-1-rka@sysgo.com>
	<20180831033540.GA29201@umbus.fritz.box>
	<bffa3ef4-4394-5f89-158d-5e3cbd597b9d@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <bffa3ef4-4394-5f89-158d-5e3cbd597b9d@sysgo.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: add external PID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <roman.kapl@sysgo.com>
Cc: Roman Kapl <rka@sysgo.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 09:25:43AM +0200, Roman Kapl wrote:
>=20
> On 08/31/2018 05:35 AM, David Gibson wrote:
> > On Tue, Aug 14, 2018 at 06:59:54PM +0200, Roman Kapl wrote:
> > > External PID is a mechanism present on BookE 2.06 that enables applic=
ation to
> > > store/load data from different address spaces. There are special vers=
ion of some
> > > instructions, which operate on alternate address space, which is desc=
ribed in
> > > the EPLC/EPSC regiser.
> > >=20
> > > This implementation uses two additional MMU modes (mmu_idx) to provid=
e the
> > > address space for the load and store instructions. The QEMU TLB fill =
code was
> > > modified to recognize these MMU modes and use the values in EPLC/EPSC=
 to find
> > > the proper entry in he PPC TLB. These two QEMU TLBs are also flushed =
on each
> > > write to EPLC/EPSC.
> > >=20
> > > Following instructions are implemented: dcbfep dcbstep dcbtep dcbtste=
p dcbzep
> > > dcbzlep icbiep lbepx ldepx lfdepx lhepx lwepx stbepx stdepx stfdepx s=
thepx
> > > stwepx.
> > >=20
> > > Following vector instructions are not: evlddepx evstddepx lvepx lvepx=
l stvepx
> > > stvepxl.
> > >=20
> > > Signed-off-by: Roman Kapl <rka@sysgo.com>
> >=20
> > Looks like a good first draft.  I have a few comments dispersed below.
> >=20
> > On a more general level, I'm not totally clear on how the new mmu
> > indices work.  AIUI these essentially index different qemu TLBs (as
> > opposed to modelled hardware TLBs).  If the EP was set to the same PID
> > as the current process you'd have two indices essentially aliased to
> > each other - in that case do we have all the necessary flushes in
> > place?
>=20
> That is a good point (i assume you mean QEMU TLB flush). The existing code
> seems to always call tlb_flush, not tlb_flush_mmuidx, so it should wipe o=
ut
> all QEMU TLBs, including the EPID ones, whenever the HW TLB changes. You
> could already have this aliasing even without EPID in the different TLB
> modes for supervisor/user etc. Can you think of any other reasons why the
> aliasing would be a problem?

Hm, no, I guess you're right.  I can't say I understand the mmuidx
stuff as well as I'd like, but I think your approach should work.

I'll await v2.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluV9AAACgkQbDjKyiDZ
s5JEzxAA0ZhE9ZGlHFi266eUohiRim8VZAwQpSwdYgmxKtvNb5FrLV9s60XRgVoU
uyTRDSn1iGoZNRzAHb8asVwUvoW2+CnQlxWRrFtLNKOgZJUH93NtPBV5BOu4r4kz
dzW3UFr9eaExOnmoEChJa56IfAhCJOMPxlrxAgtUwqb+G5Y0MEowYTtz9yRNAwfB
eZZPC7Po+/BDw9Gq6xGsMFJY1PgLZhWaZuJTOP0qi58pfplWR+QKQeDlwVfyvUub
jUo35OQgZlDqAZ05BCqG8ggk6z+xbmVRxzkdfhx8FKEWd5O8w4FSqkCgQxX0rJWR
2rEN103e6F+nktsZNKGj8Z/aMhE9zesulNH3OpG6Lt9hAZwQo3+n5AhpPwC2Fx/8
RmB4HaExXssJxScFcVhlP9vuNHpkjA1TJywATfZWv2OmV/KZ+k5cUSdytiI0BQ0O
Ppoia+fr9BToeKfXpPGG1Mwcc1bFiCymz9oTljQ+KvVrqEOa+xtMkuzh9IpCTWJl
mLHHEZsZxH+lLHJnJZVWf6UmlI3Ehtm3JtkzFWpBch9zCH0zLTDJqvHkPTRmT50U
FBZUfD/B2oAv9kzNNiu3jYuWgwqt2rixzhiYtM+jpCGSKzX0o2gD3bnFU5houaAA
/Crylu1YKzEARjmE/ShOXJWXwTn8RkIicjgcdTV0XVeXQc2zKRs=
=cdqA
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
