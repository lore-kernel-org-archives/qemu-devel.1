Received: from eggs.gnu.org ([2001:4830:134:3::10]:36816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSXeL-00081q-6C
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSXeJ-0000ea-4i
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:31:21 -0500
Date: Fri, 30 Nov 2018 12:09:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181130010920.GF30479@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-9-clg@kaod.org>
	<20181127234956.GR2251@umbus.fritz.box>
	<c16b55c5-8144-82bc-37f7-70427c6460a4@kaod.org>
	<20181129004718.GJ2251@umbus.fritz.box>
	<39eb027df3340121ba9877e689e4d0a2747c5e43.camel@kernel.crashing.org>
	<caa36063-dcf6-c415-3a50-8759e4d53072@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
In-Reply-To: <caa36063-dcf6-c415-3a50-8759e4d53072@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 08/36] ppc/xive: introduce a simplified
 XIVE presenter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 06:51:53PM +0100, C=E9dric Le Goater wrote:
> On 11/29/18 4:39 AM, Benjamin Herrenschmidt wrote:
> > On Thu, 2018-11-29 at 11:47 +1100, David Gibson wrote:
> >>
> >> 1) read/write accessors which take a word number
>=20
> ok for single word updates of the structures.
>=20
> >> 2) A "get" accessor which copies the whole structure,=20
>=20
> ok
>=20
> >> but "write"
> >> accessor which takes a word number.  The asymmetry is a bit ugly, but
> >> it's the non-atomic writeback of the whole structure which I'm most
> >> uncomfortable with.
>=20
> And, how would you make the update of the whole structure in RAM look=20
> "atomic" under QEMU ?=20

So, the BQL means it actually is atomic now (at least for PAPR where
the guest doesn't have access to it), but I don't want to rely on that
always being the case - there are moves to put less stuff under the
BQL, and with KVM we might be mapping some of these things such that
real hardware can touch it.

But the real point is that we don't *need* it to be atomic.  Perhaps
the individual field updates need to be atomic, but not writes to the
END as a whole.  Writing back the whole thing is also a whole heap of
unnecessary stores.

> > It shouldn't be a big deal though, there are HW facilities to access
> > the structures "atomically" anyway, due to the caching done by the
> > XIVE.
>=20
> Are you suggesting that the PowerNV model should update the VPC, EQC,=20
> IVC in the VST accessors before updating the VSTs in RAM ?
> >> 3) A map/unmap interface which gives you / releases a pointer to the
> >> "live" structure.  For powernv that would become
> >> address_space_map()/unmap(). =20
>=20
> yes.
>=20
> >> For PAPR it would just be reutn pointer  / no-op.
>=20
> ok
>=20
> I think I will introduce these handlers progressively in the patchset.
>=20
> Thanks,
>=20
> C.=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwAjcAACgkQbDjKyiDZ
s5JD3g/+LtdKOhZuA39/6+ZZK8nHpTXJ4gXh9pHyn/9JFFiWLeeY5spycJuEo8Yo
2L4mCfoVSrMdM7Chhu/e6rkuP4FB6B93Bdpwh+TcneapiAuR5chbthmYJi6qP16M
DhuuqP8S5bnG/Dkv9PA1CN1tJGti2QQ7smnPc61QKH03FRI3EbNCWPaUgLiCuQjP
KbgONdMWwaZ6dCtzmSUUdmjWidY2sPJc/eiajLsZrquhB7sYXMF3ZSmyPSmBgNVX
3ZL6m/tdgbB9QWfMZT48SZVdkzHMQQVrzNxxlpdhS/aRWeL5A6nTk91ZKS8No6Wr
f2WTjEYX6l8StoK8L4Vc1uWJ/bGLCunEnqqODGCZ75OkbsYWROXh+u2nvfiAFUrP
Vt9uaXuN+TeJpvToKIDovY0xuNlxRpUVcqanadnIejOI6apwVZ50law8wUSm6w0R
pr46OiM+O/DPeNY9ha7NExdjnrD0Zyr6ripb//DKLFt6BfU4Yd25Vgmzg+04jtiN
mqQbWIWwUoAaQaXBjYVc84bp0oCOg/rqCl733IsJwU4ZpKBGPlYzKmIHrI7Pdixu
9+kcWrGsUeotpvwgl10howl0h7dnBtvFj/V6GroEZrBkPSUMyl/gtOxy5h0TNBiQ
cKnDiFZKtddo/4isQZNF5ZhfVqU/Qr104oHuthJ24WU85BIsXhE=
=mvNt
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
