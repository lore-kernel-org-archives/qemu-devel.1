Received: from eggs.gnu.org ([2001:4830:134:3::10]:52310)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dVj1j-0003BL-8a
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dVj1f-0004hT-Bn
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:39:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:60110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dVj1e-0004h2-VP
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:39:47 -0400
Received: from [192.168.1.3] ([185.58.161.191]) by mail.gmx.com (mrgmx102
	[212.227.17.174]) with ESMTPSA (Nemesis) id 0MM0bQ-1dbC8b16fU-007nW9
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 20:39:45 +0200
References: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <9ba88752-aec4-24dd-d285-fe537bbfabeb@gmx.com>
Date: Thu, 13 Jul 2017 20:42:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WExxL6UqClqmJ8qOtC1Tb8Dq3c2VJ5K4w"
Subject: Re: [Qemu-devel] tests/Makefile.include non-portable use of $RANDOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WExxL6UqClqmJ8qOtC1Tb8Dq3c2VJ5K4w
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Message-ID: <9ba88752-aec4-24dd-d285-fe537bbfabeb@gmx.com>
Subject: Re: [Qemu-devel] tests/Makefile.include non-portable use of $RANDOM
References: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.07.2017 19:32, Peter Maydell wrote:
> Currently our test makefile does
>=20
>    MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))}
>=20
> This works on bash, but $RANDOM is bash-specific.
> On dash, it doesn't do what we want, but it does do something:
>=20
> $ echo $((RANDOM % 255 + 1))
> 1
>=20
> On NetBSD the shell complains:
> # echo $((RANDOM % 255 + 1))
> -sh: arith: syntax error: "RANDOM % 255 + 1"
>=20
> and so 'make check' doesn't work.
>=20
> Any suggestions for something more portable?
> https://unix.stackexchange.com/questions/140750/generate-random-numbers=
-in-specific-range
> suggests
>   awk 'BEGIN{srand(); print int(1+rand()*256)}'
> and of course there are similar things possible with perl et al.
>=20
> Or we could just have the makefile check whether we have bash,
> and if not then set
>   RANDOM=3D4
>=20
> (thus putting NetBSD into the same boat as all our dash users).
>=20
> Opinions?
>=20

=46rom the NetBSD point of view, please skip it. We support $RANDOM in
NetBSD 8.0_BETA.

> thanks
> -- PMM
>=20



--WExxL6UqClqmJ8qOtC1Tb8Dq3c2VJ5K4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZ78AAAoJEEuzCOmwLnZsrLMP/jqY7avUD2UR0dZNvSrSOGtX
gNKSnkmbTpz0DZ4b5JOWU9r6q6mafTy1uFC9LyuwafOTI8R0lNPcKsCoD8Cv6E34
X5r/cKOKA2C/CrcF++gW1CPKJKP+ZHGWwBtyOePmqRkazsukILhSEddd9fgA6+YI
wwuYEjncQ3o3FATEeoKfX2XyzdoUOvHrcDwpKKXI/dpdnpKmF9q+6O/+H2TruW6j
WLm5/FhRYBd5vm+YCqe3uKZjfnTt6EOt99BcLFfQJ38zn2eieu6noD4pmwNtBG1j
5wlKKAEYraFAk3pyV1s7MjPdzk2dPIC+BOnpK5ZFbqZwc66VQ2Z6sZrZyr/H6mzK
6m4vkGD+aUK7fcQAVFxysWm+kueXsKydph8OWiZITRWH+qKxfHn86H5Dnbc7o5ZH
djEORDGgYaruOKPRwi3cvct6Zg75kFg0Dk2RDxTX7pTnhevMrosIUt9vkSzEAfgH
PcS7+8h3rNX2CIJ/IOYl9/OYQstG8OKDtM/mRLRuW8emZd1057a4/1ArL1uXMOiW
mQ/ezd3pbNPcpqvy3+POKqtxlu839JvyCiJ73GiiO7n1S3VXqk02akQDRsarhkqa
ksbHO6d2Ejt7Z3pIzyJv7etnuRDR5CYKJ4ur3CNIOvnOcnJSf1ANqRI96D7w7eiS
DoI6F6jQfmISTLBRSarb
=5rQP
-----END PGP SIGNATURE-----

--WExxL6UqClqmJ8qOtC1Tb8Dq3c2VJ5K4w--
