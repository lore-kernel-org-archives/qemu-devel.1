Received: from eggs.gnu.org ([209.51.188.92]:41294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hElZ4-0004iU-Hl
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hElZ3-0001Vj-Fk
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:05:14 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:44682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hElZ3-0001Qd-2N
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:05:13 -0400
Received: by mail-yw1-xc43.google.com with SMTP id c4so2830089ywa.11
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 19:05:09 -0700 (PDT)
References: <20190409065404.9853-1-richard.henderson@linaro.org>
From: Jan Bobek <jan.bobek@gmail.com>
Message-ID: <b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
Date: Thu, 11 Apr 2019 22:05:01 -0400
MIME-Version: 1.0
In-Reply-To: <20190409065404.9853-1-richard.henderson@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="3H30j54F3fobMHA8imTWZq7pNSKzQbxrR"
Subject: Re: [Qemu-devel] [RISU v2] i386: Add avx512 state to reginfo_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3H30j54F3fobMHA8imTWZq7pNSKzQbxrR
From: Jan Bobek <jan.bobek@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Message-ID: <b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
Subject: Re: [RISU v2] i386: Add avx512 state to reginfo_t
References: <20190409065404.9853-1-richard.henderson@linaro.org>
In-Reply-To: <20190409065404.9853-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Looks fine to me. I suppose if I had written it, I would have included
more comments and/or #define's to make some bits more obvious (all the
magic constants look a bit scary until you read the Intel manual), but
nevermind that.

I guess the other remaining part now is extending risugen to actually
generate the test blobs.

-Jan

On 4/9/19 2:54 AM, Richard Henderson wrote:
> The state expected for a given test must be specifically requested
> with the --xfeatures=3Dmask command-line argument.  This is recorded
> with the saved state so that it is obvious if the apprentice is given
> a different argument.  Any features beyond what are present on the
> running cpu will read as zero.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>=20
> More fiddling.  This puts an --xfeature=3Dmask argument on the command
> line that must agree the test case being tested.  This requires somewha=
t
> deeper knowledge of the cpu than I would otherwise like, but I cannot
> disconnect this knowledge with that required for writing the test in
> the first place.
>=20
> Usual values for mask are 3 (SSE), 7 (AVX), 0xe7 (AVX512), and well
> documented in the "Managing state using the XSAVE feature set"
> chapter of the Intel architecture manual.
>=20
> Thoughts?
>=20
>=20
> r~


--3H30j54F3fobMHA8imTWZq7pNSKzQbxrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAlyv8k0ACgkQZeg2ldrj
Ns+Ipg//W5pgiR7zBQvXAuX2AK36erdCY7OMfpTfgalGTou25YWKDAJSD1raDEM0
jrhU17RM4dVy5eAExdAtCdIXAfiwgfuB4WsWWd0oCEY9lXpeyV7mQIsUJE/e6oau
JZoDPUDRrMth9II061Io5Anr/1S72ywUy5bGVcmFQ9mo2wnq0Q3Jw4tDFF1ytWgR
lB4wwjroDT3yrxdVTU0aHx6f1mFz/t0gfJp3Wwq644OknvAdOS0nvP0/77jPde6u
JlT2LELkanVuDaoP+HmnsnrgeXC8KUMgggGPF7yamvhhGjovzl2UQt8gcU41ud7r
OAWPt81ulcjdJsGSMY7GGLOjzziYayx2h9O0XcfKB8lCJkm6fw+MJXExiY/5mrG5
RCfKdLT3mB6T9pbqqKPM2OI/dDtFxgl8Kb5TXTwjF68topvPbNee1aj/7nG501rm
nisTRevBsVkA7T7L7Y6i6dxVbvUy+NVPdbgErwjvXfLGxS3rEbHBsOxRUJkk61xA
t25g15j1Clqwhf4t8pgOosYTkEtLcGuWfnEqY3X/ECzXE66tkEnhWiEdvlSNdd1u
OS6gSZ99xXq1AEkMNJAqmAZpNV2J84ySJaT1i7RUGbT/x7R3qZ9UinOLmQ5VRdop
fjHh+4tcLjlCcoT+B+pg9dNUvtKUYhxJHzSEvmLxA5jrenGRunM=
=TqXC
-----END PGP SIGNATURE-----

--3H30j54F3fobMHA8imTWZq7pNSKzQbxrR--
