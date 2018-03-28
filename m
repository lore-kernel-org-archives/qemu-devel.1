Received: from eggs.gnu.org ([2001:4830:134:3::10]:56890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0z7S-0003jo-TP
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0z7P-00056I-Rv
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:39:14 -0400
Date: Wed, 28 Mar 2018 11:39:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180328003900.GF3510@umbus.fritz.box>
References: <20180326001421.0E0937456D7@zero.eik.bme.hu>
	<20180326022012.GB2104@umbus.fritz.box>
	<alpine.BSF.2.21.1803260518540.80357@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1803260518540.80357@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix reserved bit mask of dstst
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 05:24:12AM +0200, BALATON Zoltan wrote:
> On Mon, 26 Mar 2018, David Gibson wrote:
> > On Mon, Mar 26, 2018 at 01:54:28AM +0200, BALATON Zoltan wrote:
> > > According to the Vector/SIMD extension documentation bit 6 that is
> > > currently masked is valid (listed as transient bit) but bits 7 and 8
> > > should be reserved instead. Fix the mask to match this.
> >=20
> > What document can I find information on dstst in?  The ISA documents I
> > have handy are either too early (the instruction didn't exist yet) or
> > too late (the instruction was considered obsolete and no details are
> > given).
>=20
> I've found it in "PowerPC Microprocessor Family: Vector/SIMD Multimedia
> Extension Technology Programming Environments Manual" Version 2.06 which =
was
> the first one Google found. According to this document dstst should have =
the
> same reserved bits as dst.

Thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlq65CQACgkQbDjKyiDZ
s5L0fRAAguCrNkUG/SdDr/iLzYPg91j3bmuJ7TgLGDl/VEI9ZosfB98sMfGzrY22
BSLWAWlLBq5JCTfWU0O5n7KHy3gVTpDodG1sTvP0R3BGUm5eImvttcf+uKtfvDMe
ZtSpHSTOOYlAXKotjrB2d6BSr8jNV1O+NlDJ8yfDYCX4F3UaI1uvsSm2sRT8xIvf
4ldxhY4p4eIvrCHZ/CPSC83VCib2PF280mVAJAblOQbSEhKhsNnyfpqkXeuPwcxX
AF7X06373D+zDwcT7VBSLSs/FVLe9THzr/Zq8ztrGjKZdUoVzNcmC0sDTY3aUNsh
0uN1BNYZxDkk/98nUVFAEwsQjqE0wnJUFKNBACYpLaYzEngVWWeMeIQh4rVBPDax
yN4NZVOVdS9D2v/s8eo9SW3QKWOhbeGVASh2JD6Q8rUqAbSubLfdcsK1b7Qoc8iG
3iL15T/Mk2ncPI4wdl5HHjgPvbWfwotXI9oeBBnXH4V0gNp83JKE05JUB1dYJdRr
EtVDVBZqIxy2g5nUMv0g6ySwAefiD1nrJtYaYJ0Nx2fwnRDviYqxIlcznw4IPbgT
pBZKdrvrq8t4Zob8X1jkCRYdO6yB/g84eFWNdRg+PdKosmP4i+AqfRAGPxRkiGD1
oI97oRLXr6369lhk76QsF4HmnZt/wTZsci5XodQkMqBz0KCoVLI=
=Geo/
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
