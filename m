Received: from eggs.gnu.org ([2001:4830:134:3::10]:55500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYuu-0000WS-RN
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 21:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYut-0002Kp-KY
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 21:20:32 -0500
Date: Mon, 6 Feb 2017 13:20:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170206022020.GG17644@umbus.fritz.box>
References: <1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <1486159277-25949-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] POWER9 TCG enablements - part 13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 03, 2017 at 08:01:13PM -0200, Jose Ricardo Ziviani wrote:
> This set contains 4 new instructions
>=20
> xsrqpi[x] - VSX Scalar Round to Quad-Precision Integer
> xsrqpxp - VSX Scalar Round Quad-Precision to Double-Extended Precision
> xssqrtqp - VSX Scalar Square Root Quad-Precision
> xssubqp - VSX Scalar Subtract Quad-Precision
>=20
> Note:
>  - xssqrtqpo and xssubqpo will be implemented when round-to-odd is
> ready.

Applied to ppc-for-2.9.

Note that I haven't reviewed these particularly closely.  Since
they're new instructions, I figure it won't cause a regression, even
if they're buggy.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYl91kAAoJEGw4ysog2bOSiMsP/jO1ACOsoAdcflm1JDDCchQp
Jy/cH5YjwjOiktrZT1AnBQaWAbidreeQFN8qjo8f4Qn9bdr67qM9ADQQhZFjC0uS
vxZOUhPc4eGFgeLdNRS71iOGOkrVbF7JvLcuU527JlKSrW5japbaJshbKdV3sCmv
JcphlaumVJOYBfS6fnFnwxOffnWNOYRnHzDMzgpPv6yst9CE8LVeYOFE/ELUXDHg
Hb4op2fJgWMhVBbHDXyN+p3EJVu9pnAW3DYP+OO0MQufDF4kkkHNYyTih8TJhiHC
UVluvC6erXk3jZbAbTTfcpURl9UM5AkQK92omCVxRPeqbamv4CPUVW9KQcRZS1Np
OCvLOpqAQz55PUN9aTrINYvfAvRIGzpisnnGX3hYuKX8PBj4CnQ7UoMU+mwoiWdZ
pcn9V+itq1vH7AeML/d7el5J/qcuUFr5aud8pxoS3tU89ESiopipiUr2E5qZM6eg
sIFmGJGHNrfFWwQ1syRS5g0riyPQqORO/igxKOHuOkPnfalmK19vhsknRi/Om1ut
l4/9iz5GSiNMlgHVINkaVyC0kJ0or+VjFVpTpItePYDcIqgeChliqC1qiaoQGke9
sxNDST96LAuaFDCJsx8+7r2AXLa9xL6Ooy+ybRgXSnikuyCkY/79eQ4Rz/m+r+Uz
lWUL7Xrzdty/rJeLA2GS
=qWOm
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
