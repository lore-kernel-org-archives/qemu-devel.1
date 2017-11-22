Received: from eggs.gnu.org ([2001:4830:134:3::10]:48536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHKRl-0002ZX-IU
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHKRk-0006vi-OW
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 21:07:29 -0500
References: <20171122001656.12996-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1cc87e18-67f9-2ec5-a2a6-78e93dfbe462@redhat.com>
Date: Tue, 21 Nov 2017 20:07:18 -0600
MIME-Version: 1.0
In-Reply-To: <20171122001656.12996-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="73S4AMAtTn1EinovAwS5edu61Co2SH57K"
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 075 and 078
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, ldoktor@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--73S4AMAtTn1EinovAwS5edu61Co2SH57K
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, ldoktor@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <1cc87e18-67f9-2ec5-a2a6-78e93dfbe462@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 075 and 078
References: <20171122001656.12996-1-jsnow@redhat.com>
In-Reply-To: <20171122001656.12996-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 06:16 PM, John Snow wrote:
> Both of these tests are for formats which now stipulate that they are
> read-only. Adjust the tests to match.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/qemu-iotests/075 | 18 +++++++++---------
>  tests/qemu-iotests/078 | 14 +++++++-------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

Safe for 2.11, although now that -rc2 is out, it's also okay if this
slips into 2.12.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--73S4AMAtTn1EinovAwS5edu61Co2SH57K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloU29YACgkQp6FrSiUn
Q2o3gAgAmIdemXwvhcN4fvyQOW//KVAClpGN6NaBVkcWkMzoU5rzM56TtirjAFzt
ZgLcMRlE5bT8cRww4z7NMF7yhjJhtwUJRHt/K3aKPXS/QW/fv7DQ7wfHBsZoWwDR
dCTTX2eeS/yUFHPc1a7iMT1UuvwOVoZXE4af+R+PBUVQdVitegboIYNp0/d47jwy
SlRibJm9lXn3jgeIeNZcAhCgLHi++emV1NL6lLpFxdUGPG4gGtIm4/X8D8kyJaVB
TweNrOr3nfLabiQ4Dvt4V06s5Ed6PNHp15ynpgOeykMw4XeZb3/rthyzu1+GfmNH
KxLf0E5Mpe71jkc6l/8GF0VQo3wR7w==
=G4L1
-----END PGP SIGNATURE-----

--73S4AMAtTn1EinovAwS5edu61Co2SH57K--
