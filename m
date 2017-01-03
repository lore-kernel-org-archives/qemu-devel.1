Received: from eggs.gnu.org ([2001:4830:134:3::10]:58426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOUS1-00047I-7Y
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOUS0-00036B-9z
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 14:08:49 -0500
References: <20170103170459.27662-1-berrange@redhat.com>
	<20170103170459.27662-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <57cafab8-cd9a-33c9-862d-8b34e811991b@redhat.com>
Date: Tue, 3 Jan 2017 13:08:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170103170459.27662-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eTTADtRGLRwhTtfNweAV0bebMjvRna8dH"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] iotests: add more LUKS hash
 combination tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eTTADtRGLRwhTtfNweAV0bebMjvRna8dH
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <57cafab8-cd9a-33c9-862d-8b34e811991b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] iotests: add more LUKS hash
 combination tests
References: <20170103170459.27662-1-berrange@redhat.com>
 <20170103170459.27662-5-berrange@redhat.com>
In-Reply-To: <20170103170459.27662-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2017 11:04 AM, Daniel P. Berrange wrote:
> Add tests for sha224, sha512, sha384 and ripemd160 hash
> algorithms.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/149     |  10 +-
>  tests/qemu-iotests/149.out | 482 +++++++++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 484 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eTTADtRGLRwhTtfNweAV0bebMjvRna8dH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa/a5AAoJEKeha0olJ0NqN8MH/AtquewNc5R8JvOkXxKCCJEY
8GUJ/ZrKUouCO63etEF9CJJLWTFBh2AQfet8S6ayGbgxhjrIRFvklV2C+6ljtbMu
3DlM1bTChIffPV5IJ/fA6vwwT0m/FDPmwwCn8PWDM+JjbIecqKe8ifwtwpG+cKeY
p0WzMKm4qtLclH7aVY1IB1pP7Y+LhQP2V7ni7NqgnKG2H+kx/NIEn3BOKgDF76Je
uGTthuC+pMuKbIMZm4nf95dGKXbdHIAGcdEI8Iw6G7VYYgMx36BwMPC/H8glZPsi
uFYuoYLYdZT3bhu/TS0RtYurKkVqdFBzFGaOMiViESZm2aVfngvLuKjlgxpXgMQ=
=o3bq
-----END PGP SIGNATURE-----

--eTTADtRGLRwhTtfNweAV0bebMjvRna8dH--
