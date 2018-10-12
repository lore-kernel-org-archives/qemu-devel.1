Received: from eggs.gnu.org ([2001:4830:134:3::10]:47611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAmUq-0006Kq-3d
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gAmUp-0001l8-B7
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:44:08 -0400
Date: Fri, 12 Oct 2018 12:14:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181012011458.GQ7004@umbus.fritz.box>
References: <20181011234159.11496-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J19t2I20ndwispKK"
Content-Disposition: inline
In-Reply-To: <20181011234159.11496-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/7] target/ppc: Some cleanups to fp
 exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--J19t2I20ndwispKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2018 at 04:41:52PM -0700, Richard Henderson wrote:
1;5202;0c> There are a few bugs here, primarily wrt usage of GETPC().
> But there is opportunity to share more code between paths
> that operate on different floating point types.
>=20
> This is not everything that could be done, but it's a good start.
> Better for this not to hang out on a branch for another release.

Applied to ppc-for-3.1, thanks.

>=20
>=20
> r~
>=20
>=20
> Richard Henderson (7):
>   target/ppc: Split up float_invalid_op_excp
>   target/ppc: Remove float_check_status
>   target/ppc: Introduce fp number classification
>   target/ppc: Split out float_invalid_op_addsub
>   target/ppc: Split out float_invalid_op_mul
>   target/ppc: Split out float_invalid_op_div
>   target/ppc: Split out float_invalid_cvt
>=20
>  target/ppc/fpu_helper.c | 661 ++++++++++++++++++++--------------------
>  1 file changed, 327 insertions(+), 334 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J19t2I20ndwispKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu/9Y8ACgkQbDjKyiDZ
s5I1WxAAgAxh2O/VnTSEQn2rkTu8SE3+aM/PAcZcGY5/NvKGFbE8HReO0r+H9UCF
83lrOcjMBvt72YRpfpjEtb/PQjlkguZgu5kmMDA8kcEDbQDaMkSeEbB3HqxMEWvB
R9bb/F/WwaZtyvORWjMikK1Rl8/JhvKKf9nMV/qGfzOkK2bmztB6ZzYNNKJqP46L
ts8J52T7mcR3nuHoFbqL6Sl1es9sKc0Y0PkrkQrUoQ0M2UG1qif1ML+CYasdAq5P
4xli5kgs2gBLweDJfs9m50tRqd6+S3eKHMRo6vzbP34Q1Lch5JALKYHuCZ5VxBPO
OnyCiwybbHHsIi9I/y68nR+fDOPkjPIVMThXL9ptjG8Uoq4vt8LRxULDXDZHMPrB
UEp1irPXe6F3FXlh//KUS9HSsPiXVFm+AznofeiuMiOrBYjCgh+uG6ZRVYGHKVgm
mBoCBFeDjNd9OlMrapzkFkjba52e16X9t/waisPUjXPYN+3NDgg0JC2fnUMko17N
sumM0NrDfi00fE+tFUCe2JAvgCVtFjR7jIln9fH7zW6Q/2EKzpIjjdfyq/Ofj+wu
2YkJpXpF5tlpFT0P7MOrpfV9Is61y6+XeAPYqJdKHO6MUItmnsuaKe52frBFu9BK
c6d56CK9KD9ITQyhpS2DD6D09HDFUT4kmfaKFtux+nbEgXvdoUc=
=HVCx
-----END PGP SIGNATURE-----

--J19t2I20ndwispKK--
