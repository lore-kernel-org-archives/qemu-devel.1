Received: from eggs.gnu.org ([2001:4830:134:3::10]:46455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGQwv-0003I9-Lr
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGQwr-0008E3-Gw
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:47:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGQwr-0008Do-B3
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:47:21 -0500
Date: Mon, 12 Dec 2016 13:47:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212134718.GD4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] exec: introduce
 address_space_extend_translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 12:18:49PM +0100, Paolo Bonzini wrote:
> This extracts the common part of address_space_map and
> address_space_cache_init into a new function.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c | 50 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTqpmAAoJEJykq7OBq3PIn1oH/2Dc7Kczvyp9KG2XQE9XYctu
ngCF87Cn5RADzCTBodyBCsqu8VDWZti7waoUgGuBZkikb8SCp0NRcX5XL2PO04L/
y3m0rwFvArDuZWWKiHNaSMcG6a7bmWNi3boTB+zQqxURToF2mtW/ac5AXHq9ylHZ
0ZaIkG7oJTWkVdUS5ultyUQ+zlhgymh/B4Vn+KuWB9026O5cA/AZo895DAfhKwba
BMyCnnVl7+T/NzjOrhqHO4sdvGN2k4wGPVZM7ZGE6QAtV39WPxokY49NoSCsPo5e
xsqJjrAiltrRMdAhLmRrl/6O2GDh/pIW/ObCpgLsNdONQIw64q0KtGpHRUcbEPY=
=TuFr
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
