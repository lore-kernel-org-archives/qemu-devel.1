Received: from eggs.gnu.org ([2001:4830:134:3::10]:55000)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gTraG-0002dg-6Y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gTraC-0001ym-VR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:00:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:36317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gTraC-0001y4-MI
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:00:32 -0500
References: <20181203160840.15115-1-richard.henderson@linaro.org>
	<20181203160840.15115-6-richard.henderson@linaro.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <58a36fe9-8a56-d949-a942-a5ca3cc243f5@gmx.com>
Date: Mon, 3 Dec 2018 18:01:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181203160840.15115-6-richard.henderson@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pt5gvEI4rgHrATxmvdsT4w1DhwzrskNKm"
Subject: Re: [Qemu-devel] [PATCH for-4.0 5/5] tcg/i386: Add
 setup_guest_base_seg for FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pt5gvEI4rgHrATxmvdsT4w1DhwzrskNKm
From: Kamil Rytarowski <n54@gmx.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org
Message-ID: <58a36fe9-8a56-d949-a942-a5ca3cc243f5@gmx.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 5/5] tcg/i386: Add
 setup_guest_base_seg for FreeBSD
References: <20181203160840.15115-1-richard.henderson@linaro.org>
 <20181203160840.15115-6-richard.henderson@linaro.org>
In-Reply-To: <20181203160840.15115-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.12.2018 17:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/i386/tcg-target.inc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index b8d2dd5ba3..3a39b51685 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -1873,6 +1873,15 @@ static inline int setup_guest_base_seg(void)
>      }
>      return 0;
>  }
> +# elif defined (__FreeBSD__) || defined (__FreeBSD_kernel__)
> +#  include <machine/sysarch.h>
> +static inline int setup_guest_base_seg(void)
> +{
> +    if (sysarch(AMD64_SET_GSBASE, &guest_base) =3D=3D 0) {
> +        return P_GS;
> +    }
> +    return 0;
> +}
>  # else
>  static inline int setup_guest_base_seg(void)
>  {
>=20

There is also X86_SET_GSBASE in <include/sysarch.h> in NetBSD. Do we
need to set it for this OS too?


--Pt5gvEI4rgHrATxmvdsT4w1DhwzrskNKm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlwFYX8MHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs2eIP/0Hp8g2Zv/kX9tvhJDECSgk56gVB5MSW6fUxlfBn
HO5Zd1pHIJuMKM+TdvnkDH1B8le7M/05+L+WYi9VgdfhGMNlK56vbmKxATjEhOE4
GDvKVZl6rcz1ev80DWJdbz+87IB7Y+ZCxjnOD0RzJahNlP4xsrRYIy1i+WdxZ+q1
xe+iQYS26pMb21cIkzBXYTCWpjLk705NWsFxRIAlKxc6LkpPiT7hFm1GE4VDjFaB
+FlWzVv9NTSanvd9wGBVaScl1vIxaNVFWbUBx8rVg1d1aKBS9zKvSx5qPkvs6eX2
vrXSv+4vgZgMgdfA8ZOW/pZ1S9zwwbGu+SCxc4EVv1/PGLyPktB4Ubl9rAttf7xJ
x5HNKaE5ERNnF9nm7dxa6FIh0LKGgiwA+/Yd9uMXPcFkbUUVhikKCNNdZqZ5mEjc
x1xoYcICFCLnx0yXatGhzKO/9sVBdUsm6Ac+da8j8xHFiroZ90eEyP8DbfnEqF9c
36b5SfbVBM2SJNjKPPh9Ofq7KNmEWVb+H7vwDfUWOAWo1568vnBA94QA+PhfIVG6
wO1OPYYivJBGPWv6NMKWt1BFpvA2jqTehuV3WycHhBsv7KlnRBbJQvolx4cqA+NF
o0OJN3xGzPB1ssJk6LMSebnKS59QYG56QR5vSSC+OSHI2TfQzm5lddnACJtBPzAJ
2QFw
=4V8v
-----END PGP SIGNATURE-----

--Pt5gvEI4rgHrATxmvdsT4w1DhwzrskNKm--
