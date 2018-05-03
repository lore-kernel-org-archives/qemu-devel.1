Received: from eggs.gnu.org ([2001:4830:134:3::10]:60376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE8k8-0002dY-Ox
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE8k5-0005LB-G5
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:33:32 -0400
Date: Thu, 3 May 2018 17:16:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503071654.GY13229@umbus.fritz.box>
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-2-david@gibson.dropbear.id.au>
	<d63a7712-8de6-15e9-acb7-4638ba834144@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P6PRkhImOxklJvkF"
Content-Disposition: inline
In-Reply-To: <d63a7712-8de6-15e9-acb7-4638ba834144@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/8] target/ppc: Add ppc_store_lpcr() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com


--P6PRkhImOxklJvkF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 09:06:42AM +0200, C=E9dric Le Goater wrote:
> On 05/03/2018 08:21 AM, David Gibson wrote:
> > There are some fields in the cpu state which need to be updated when the
> > LPCR register is changed, which is done by ppc_hash64_update_rmls() and
> > ppc_hash64_update_vrma().  Code which alters env->spr[SPR_LPCR] needs to
> > call them afterwards to make sure the state is up to date.
> >=20
> > That's easy to get wrong.  The normal way of dealing with sitautions li=
ke
> > that is to use a helper which both updates the basic register value and=
 the
> > derived state.
> >=20
> > So, do that.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Although, I am not sure mmu-hash64.c is the right file for the ppc_store_=
lpcr()
> helper. This is minor.

It really isn't.  I looked at moving it, but since the code we're
rearranging is already in that file it just made things messier.
Problem for another day.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--P6PRkhImOxklJvkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqt2MACgkQbDjKyiDZ
s5L1wRAA4Wn+p0Khhr2JjksYwqzvQW/GBvKDvFiyHVwk4KW1OLFte/m9SfpvsS8B
UUQopVX4Vf6TNDys9xk610gRF/d07UTCcafKk9aofkFQQi9dEL6fF5/mzXckqdVy
gScR0Bfp09J/AqbVDh47tnvF2rKa+sgowLy0L1SrGelysD6WnEX/B4CDZ63VmudF
Lpxi0mzQdX/tPa6m+HB8xyoUBQ3J523MiNFhff/rM8M+VGaAmq6IWh6Qhv5KrQVf
8kkZydHPoJje78dZXUBn5eu6LfHBuVnD/m/oPmCk6aLzN+Qwn/sMqXI0Q2SbalH0
1D7B3Dogg0M6Ry/MApFvPufzT0RYSP1zuKbcE/ZQHBPFZe+gWJC2Ri2OrHh0I7hE
kXcF8N4gqrmeul1sgjRz+TcYg75Wayl5hssfLqYX0WHfuJzs3B17wMgifKRD50tE
Wqiugmrx/ZwpNJ52bnkwvbs/tNfkNz3ooQZ69EaRQf7dRSGLBZfj8gbxAxI2R0kP
QA4kLr8eYabEmdf3DkIJxNz22odhpLt0rws7FUlvHfnz+DTyUbzVR+XLDzyGeCjl
p8cragaOP1+rGTV4+6qGBUG+yCbmv+9sxTme/EmK5cZgyowznWNeNuSRW+WnEAAq
RNogQ/bG49ywdcgIurFX6mpoW+DJxSneD5rVDwv+YKPqfUpSiNM=
=fDG5
-----END PGP SIGNATURE-----

--P6PRkhImOxklJvkF--
