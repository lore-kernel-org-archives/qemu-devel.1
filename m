Received: from eggs.gnu.org ([2001:4830:134:3::10]:51223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWdJc-00063O-MP
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 02:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWdJZ-0003zb-JZ
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 02:46:04 -0400
Date: Sun, 16 Jul 2017 16:45:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170716064542.GO17539@umbus.fritz.box>
References: <20170711035620.4232-1-aik@ozlabs.ru>
	<20170711035620.4232-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ugCSa1rMkiCAmd9S"
Content-Disposition: inline
In-Reply-To: <20170711035620.4232-3-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v9 2/2] memory/iommu: introduce
 IOMMUMemoryRegionClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org


--ugCSa1rMkiCAmd9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 01:56:20PM +1000, Alexey Kardashevskiy wrote:
> This finishes QOM'fication of IOMMUMemoryRegion by introducing
> a IOMMUMemoryRegionClass. This also provides a fastpath analog for
> IOMMU_MEMORY_REGION_GET_CLASS().
>=20
> This makes IOMMUMemoryRegion an abstract class.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

with the exception of one miniscule nit:

[snip]
> +/**
> + * memory_region_get_iommu_class_nocheck: returns iommu memory region cl=
ass
> + *   if an iommu or NULL if not
> + *
> + * Returns pointer to IOMMUMemoryRegioniClass if a memory region is an i=
ommu,

Typo                                      ^

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ugCSa1rMkiCAmd9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllrC5QACgkQbDjKyiDZ
s5LkzBAA5r+iH/hBvck5DDaccWrc7led5VV71oI1i20mHZmte2zFxh0uFd0xrmVT
WdKItWIp7LrlvOJoU+RV1KxTrtc7jCjSR2369tBPAnL5bI9iaBOfIM57I3lBrGzM
DdOhaifX2mUZHujuhzJZUJ3Bz/6bdTbRnnZ3OQIWBsLhofyBR/U2xEW9eLXpF/OJ
fcSe+kX+CePbQ4cHRVSRg+sXidj+Ohf/4hrozqwGXiOK9cvzkjBr4WUEkY1gcCce
G/RKWEkWBxQADLAgzeNmMGj91YQASAh3sXv/2c70ZZPaDtSLxfsX4ktWx8jY7S6C
kivFEGZQoGl6CSgs1wtiNPbNGNpm71Lqq4IGuKtptJUpVAVaF5CXw990/mHZjYuU
gj4O6NpP1SR1tQQSNS7B/NAUyrsnsC4nF/4qIBGLYhbJJnKshc1bSulqnQHYjFq+
OxHMzGsFZHpEPo7ayUeMwO+HqI8EYUlarF6gjnOpuWXxgxjeVTqW2WVr7bKyCKXQ
ptw5chUKcF5NceMGvl5cH2QMwuBScsHrosRUwQWoQvVBK3fHSMyQxUBpbecDmDJ/
jEnOy7zMcJJFFLWkP1I1PaaeR//bR1cCg9YjM1XqcpmFv4uNCJ2AqJBnhWQ+XocV
cscqyWWzOpN1dJ+4ShA3FR7DZMg3qb/+DRakv8y0nvMYkvxFxGE=
=8DDm
-----END PGP SIGNATURE-----

--ugCSa1rMkiCAmd9S--
