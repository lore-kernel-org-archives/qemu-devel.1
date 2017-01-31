Received: from eggs.gnu.org ([2001:4830:134:3::10]:33953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdXT-0006Dd-JI
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYdXO-0003rO-ES
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:52:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYdXO-0003r4-50
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:52:18 -0500
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
	<1485888144-16531-7-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7b111d6-3c5c-e89c-f928-e195469b2328@redhat.com>
Date: Tue, 31 Jan 2017 12:52:11 -0600
MIME-Version: 1.0
In-Reply-To: <1485888144-16531-7-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aRtDsNkkQe4cPVtxVvUV4rbwUsiPgx6o1"
Subject: Re: [Qemu-devel] [PULL v4 06/23] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aRtDsNkkQe4cPVtxVvUV4rbwUsiPgx6o1
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <c7b111d6-3c5c-e89c-f928-e195469b2328@redhat.com>
Subject: Re: [PULL v4 06/23] QEMU_BUILD_BUG_ON: use __COUNTER__
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
 <1485888144-16531-7-git-send-email-mst@redhat.com>
In-Reply-To: <1485888144-16531-7-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 12:43 PM, Michael S. Tsirkin wrote:
> Some headers use QEMU_BUILD_BUG_ON. This causes a problem
> if the C file including that header happens to have
> QEMU_BUILD_BUG_ON at the same line number.
>=20
> Fix using a widely available extension: __COUNTER__.
> If unavailable, provide a stub.

Uhh, this isn't the right commit message.  What happened?

>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/compiler.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 057639a..e0ce9ff 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -97,6 +97,9 @@
>  #define QEMU_BUILD_BUG_ON(x)
>  #endif
> =20
> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x))=
 - \
> +                                   sizeof(QEMU_BUILD_BUG_ON_STRUCT(x))=
)
> +
>  #if defined __GNUC__
>  # if !QEMU_GNUC_PREREQ(4, 4)
>     /* gcc versions before 4.4.x don't support gnu_printf, so use print=
f. */
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--aRtDsNkkQe4cPVtxVvUV4rbwUsiPgx6o1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkNzbAAoJEKeha0olJ0NqcM8H/ivFVK4Dvc/ThlslLPo701vU
EZwUSmlO0kM1fslxO7grgBb1coj7/F3+UBGb5mB3Km56U6t/WBPiZNsplkr2wga8
Y1/Uj44Fm66+QNXl613989JOBNbXR+/chW8pZ1L7gRfqEYnR6QyJKyOMJCuVN7CS
kblkPhP6edfvUSAk9xhr7toQ9n+dFEF3U+S+6Bko6hOZF7VbYGeMWXqrxdfS+wp1
oCNmNIv9K3Xna66FsrafWKYIdotsj2erMEH+WuI9X3XYI8j7XWl00cw24UIHmfx5
POI0UcalkaIKJw35kCbVuUO9SDcvBFXv4TTJhZRhXjBpd3j0T4MX1f3Wbs8eGDM=
=O7Fi
-----END PGP SIGNATURE-----

--aRtDsNkkQe4cPVtxVvUV4rbwUsiPgx6o1--
