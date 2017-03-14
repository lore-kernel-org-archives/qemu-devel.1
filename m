Received: from eggs.gnu.org ([2001:4830:134:3::10]:58972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnouo-0001Dp-RV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnouk-0007M5-UQ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnouk-0007L6-M1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:03:10 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-14-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e129b922-b5c7-8d1f-f970-aaf083073de2@redhat.com>
Date: Tue, 14 Mar 2017 11:03:08 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-14-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="arfJpTejM8cnCMviepBBx0tvowmpdf2PX"
Subject: Re: [Qemu-devel] [PATCH for-2.9 13/47] qapi: Fix
 QAPISchemaEnumType.is_implicit() for 'QType'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--arfJpTejM8cnCMviepBBx0tvowmpdf2PX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <e129b922-b5c7-8d1f-f970-aaf083073de2@redhat.com>
Subject: Re: [PATCH for-2.9 13/47] qapi: Fix QAPISchemaEnumType.is_implicit()
 for 'QType'
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-14-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Missed in commit 7264f5c.  Harmless, because nothing checks whether an
> enumeration type is implicit so far.

Obviously, a later patch will care about implicit types, and choked
without this ;)

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index e6d023f..7a2b6ab 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1148,8 +1148,8 @@ class QAPISchemaEnumType(QAPISchemaType):
>              v.check_clash(self.info, seen)
> =20
>      def is_implicit(self):
> -        # See QAPISchema._make_implicit_enum_type()
> -        return self.name.endswith('Kind')
> +        # See QAPISchema._make_implicit_enum_type() and ._def_predefin=
eds()
> +        return self.name.endswith('Kind') or self.name =3D=3D 'QType'
> =20
>      def c_type(self):
>          return c_name(self.name)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--arfJpTejM8cnCMviepBBx0tvowmpdf2PX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyBQ8AAoJEKeha0olJ0Nqh68H/juOiZhpjtv8Jxc+5l3X9uO+
yKwmaR18bMq0wwYtEecaDIKOkqgGXXXbjfCRHIJ1wK3w1+ExfTe3W0WwPmEiYKW/
cH352OjOSvZuvLZcgEcQy/oLyyHM6txo+m8hu/M7JR7oQjI51M8hECiH+xfUGTV2
MOYdH/PJIsCPYwSmcLs7FvRbTiT4+7BWfs/feolBF11F3wkkP0scwHoHKr2VVDUr
sXYPUilMHkAdnV/OGVDdYMWywnSTlF+6EW4s8fcivXdw9dJ4LoA1dQmfoe5+p8X7
HjKYfnsCyUXtivrUl9OqRQOg3x6/q0T98FG/Gq/VYCK+rsaRyTRhtWmJ6jFy+Nw=
=1mUS
-----END PGP SIGNATURE-----

--arfJpTejM8cnCMviepBBx0tvowmpdf2PX--
