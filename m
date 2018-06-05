Received: from eggs.gnu.org ([2001:4830:134:3::10]:47657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQMhg-0004Uv-KH
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 20:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQMhd-00083b-IB
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 20:53:32 -0400
Date: Wed, 6 Jun 2018 09:51:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180605235149.GA17757@umbus.fritz.box>
References: <20180604172039.19427-1-clg@kaod.org>
	<20180604231033.GB5140@umbus.fritz.box>
	<aa50ba9e-03b0-5493-b41f-c72848390b9a@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <aa50ba9e-03b0-5493-b41f-c72848390b9a@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH] target/ppc: extend eieio for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Ellerman <mpe@ellerman.id.au>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 10:14:13AM +0200, C=E9dric Le Goater wrote:
> On 06/05/2018 01:10 AM, David Gibson wrote:
> > On Mon, Jun 04, 2018 at 07:20:39PM +0200, C=E9dric Le Goater wrote:
> >> POWER9 introduced a new variant of the eieio instruction using bit 6
> >> as a hint to tell the CPU it is a store-forwarding barrier.
> >>
> >> The usage of this eieio extension was recently added in Linux 4.17
> >> which activated the "support for a store forwarding barrier at kernel
> >> entry/exit".
> >>
> >> This loosen the QEMU eieio instruction mask to boot newer kernel but I
> >> think we should be adding a new *eieio* instruction specific to POWER9
> >> instead. I just don't know how to define an instruction variant with
> >> the same op code for an ISA version. Any idea ?
> >=20
> > I think you're right that this should be done slightly differently.
> > I think you can do that by adding a new instruction mask bit; say
> > PPC2_MEM_EIEIO2 or whatever.  You leave the existing GEN_HANDLER as
> > is, add another GEN_HANDLER_E with the new mask dependent on the new
> > bit, then make sure POWER9 has the new bit set, but not the old one.
>=20
> Unfortunately this doesn't work :/ QEMU considers the opcode is already
> defined. May be we could test bit6 in gen_eieio ?=20

Yeah, I guess we'll have to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXIhEACgkQbDjKyiDZ
s5K4vQ/8CdtgoVoQQNLt1ESGQLq87vpDmICQXw+QKkTzNOvaTt5gvly4er2RzTE3
mS8UK8BxVFGM4YBt/yrqRi0XDJVbF7jhPm544HClsgS87wAT9286amwkERyPIuJ6
JcZQD+WAoS2jBqAnkocSsuAEghGltHGSsS9BjXDVPiRKboS1Y8cwbQ3yRyKrkh5I
4ckipiT1rmV1YHJmeGigqlpuphVIG1dYTdTFT32GM333CQ6YhyXr7+KKcGaQ3IJI
+WlU3iAUG8NcPgMYhbzb2Gla4+yegL3MGxOiEM5xq8Em1EpzpQT7o/fvwVZ4iQuq
QNJ+lRDUqK5VQnNdg+1QpQuCVXwhSzc0C1PijFI17b3g+Jmiy3jpbkV/Lf5WqY67
qSjv0jNJosbyIUj2QmGHSX+8Gco/eFrpWdDASm0McOCCvp6m4/J4KsBIQqGp2FWn
5bVQGLeaiyMoTbYS7ZGN5KkrcRcHQ4v/a08N1ccIDwhsdDZamdTN+hJ1Ubf9+oBl
MS/VbsQTGmzwiY9nifEqotiya3+jeUSnQ7KsRPrpM1Hsgmndl/MHCkdxr8iwzkjH
jKyb7GCq5NhZDMtT+2m9vU8hPBLRrYGJyuBEIJq7Be5LDZzzL0raB+pD5SMz8V1G
1CJqtkWWnGjTSF0kNSxNXA7ZLQ3HdzXIdKwo66oZHORRwBaSsFk=
=yIpr
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
