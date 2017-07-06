Received: from eggs.gnu.org ([2001:4830:134:3::10]:39239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT9zr-0006Vf-Og
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dT9zn-0006x5-Sw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:51:19 -0400
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23f32d9e-3510-5859-9ca7-03106b67d8aa@redhat.com>
Date: Thu, 6 Jul 2017 11:51:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170706163828.24082-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uXHSXqWsExn1RTHjwfd0HGEC0XXOCiHGH"
Subject: Re: [Qemu-devel] [PATCH 01/11] block: prepare write threshold code
 for thread safety
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uXHSXqWsExn1RTHjwfd0HGEC0XXOCiHGH
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org
Message-ID: <23f32d9e-3510-5859-9ca7-03106b67d8aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/11] block: prepare write threshold code
 for thread safety
References: <20170706163828.24082-1-pbonzini@redhat.com>
 <20170706163828.24082-2-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/06/2017 11:38 AM, Paolo Bonzini wrote:
> Code refactoring only.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/write-threshold.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uXHSXqWsExn1RTHjwfd0HGEC0XXOCiHGH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXmp6AAoJEKeha0olJ0NqW18H/17vKZANfArmM1wUCUPyZo1G
UENLriSkqW2Tcb5aPXINMDUdtySnbwUw0yx7NdCjtCkNQj1MJ7vExClLeqJsYuPP
OAJz8hXxk1+7J4OtPlIEAwJlKebWL/YRo6TM3vu2KxCZuxcO3b/U8fRjQESFI1Rk
GgbveaGBYi3I17/xH0nuxh9nGsjAZBjWejwW2DBDPope7kbuGft3G31o5yE9jJTl
4vCGRDVSPb/L/TlBiIStc9xIS89yo3Bc6YjZCwvfbeOgDYboM90FM1nb9sA2pABr
lUL5fZkdTFtuAXbe9VSzG+ZQDVuQk5eTBcykFUHh0y272niNbdaAkeAdt/hU9gY=
=eAm/
-----END PGP SIGNATURE-----

--uXHSXqWsExn1RTHjwfd0HGEC0XXOCiHGH--
