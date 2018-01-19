Received: from eggs.gnu.org ([2001:4830:134:3::10]:37149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecP5S-0006IZ-4g
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecP5R-0005wo-5v
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:19:34 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:37005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ecP5Q-0005wK-QJ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 00:19:33 -0500
Date: Fri, 19 Jan 2018 16:19:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180119051926.GI30352@umbus.fritz.box>
References: <20180119050906.18930-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MKyq+TZLpK62LzFe"
Content-Disposition: inline
In-Reply-To: <20180119050906.18930-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>


--MKyq+TZLpK62LzFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 04:09:06PM +1100, Alexey Kardashevskiy wrote:
> There is already 'device-list-properties' which does most of the job,
> however it does not handle everything returned by qom-list-types such
> as machines as they inherit directly from TYPE_OBJECT and not TYPE_DEVICE.
>=20
> This adds a new qom-list-properties command which prints properties
> of a specific class and its instance. It is pretty much a simplified copy
> of the device-list-properties handler.
>=20
> Since it creates an object instance, device properties should appear
> in the output as they are copied to QOM properties at the instance_init
> hook.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I think the existing qom-list interface does this already.

This won't solve the libvirt problem we were discussing, because it
needs an existing instance of the object.  libvirt wants to know the
machine properties *without* instantiating an instance.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MKyq+TZLpK62LzFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphf9sACgkQbDjKyiDZ
s5KIFA/+NPzN48sj/XY+MwkoQEaln/kwyZI0oZdJKF89J/nI30T6A7LtR1dW5pf6
lvwLTcHIbbC1Neb9uQQLzvvH53OuhCSqF3wxzGEn4Hcs0j4UWlcN4TCyqWUtlzK3
hOlvu4NvjMu9fwc9WtFzYa4jUgcj3cMDZD9HVeLLwevL13zhs/OU1Us7BnwAIJvO
nVG81Q35ERGbYySm833wAoSDLxtRoITmuWqX79sl57Tq0o9CXQ3FTooLen/bFnzD
LWhaTA1GQaG2vlCgPL1j+8rwjhH3ndSoN8lzdmW/yFHeAgAxA6EWIj/aJK8i9T/Q
00ZB32mSSHQMwUpYazOuLFYDx/8a+wJRWdCBOroLmuoY9OBSLLgnMWZ5FbdXZI7k
X9Vj+VOZqmNXb7X7RBgwKwldarqZPamm+iBg7T/LDsKNZyRUU6Bt6qFbA8Z1C5Ym
MhS2yKKYmITBV9/fZ8aLvpLJkaVADj5fu+f+whwPP1MInnNm1zjKVpLhCxl9h5ly
YqAb9smrz4N8Zh+rUJrOxpZhPGWcHOJlkXwKn/ytUou7o3DSPM+jTLWherv9dH9c
CxSfoXT87UD/fU39ySiCzFOJQ0Xa/S7fC67yWdVMfv0ZWAth9Gt5bTim0MHQxXqD
OiTIOsDSnOF5oR/JT23177ptklkcpNNmf9+62oiSnxrzNLYvr6g=
=qSb7
-----END PGP SIGNATURE-----

--MKyq+TZLpK62LzFe--
