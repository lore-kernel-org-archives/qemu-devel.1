Received: from eggs.gnu.org ([2001:4830:134:3::10]:44438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnrgC-0006J6-HV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnrg7-00081n-UZ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:00:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnrg7-00081Y-Oi
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:00:15 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-23-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <381e85e9-34bb-8958-2799-55a6af687368@redhat.com>
Date: Tue, 14 Mar 2017 14:00:12 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-23-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vOhsCi6W7jGS7w0bJJME6GxoDOJ7ou1fI"
Subject: Re: [Qemu-devel] [PATCH for-2.9 22/47] qapi2texi: Explain enum
 value undocumentedness more clearly
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
--vOhsCi6W7jGS7w0bJJME6GxoDOJ7ou1fI
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <381e85e9-34bb-8958-2799-55a6af687368@redhat.com>
Subject: Re: [PATCH for-2.9 22/47] qapi2texi: Explain enum value
 undocumentedness more clearly
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-23-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Instead of not saying anything when we have no documentation, say "Not
> documented".
>=20
> Example change (qemu-qmp-ref.txt):
>=20
>   -- Enum: GuestPanicAction
>=20
>       An enumeration of the actions taken when guest OS panic is detect=
ed
>=20
>       Values:
>       'pause'
>            system pauses
>       'poweroff'
> +          Not documented
>=20
>       Since: 2.1 (poweroff since 2.8)
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vOhsCi6W7jGS7w0bJJME6GxoDOJ7ou1fI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyD28AAoJEKeha0olJ0Nq5AYH/AmHZJmlP0etdZLr3H84OsMe
Qya1j5z6hS5TFQ6o9+tCgpe+8YqDP+zjnZMZ3qkFwWXP2DkThSHG2qnag0QzCYXC
xUTugJ1gGYDQUVdxob4on/fHBhwMPNOzRvxAq9RtMdNcSIp/iIwCnvBe+hRVY5vt
kZqdVAxUBgXBlTBZxtCYuyb+npGy/4v8zwt8IxQxdClB9YntVLsuDsB4QrSzJ++g
CKtXoCF/eudngQoikwtg/X3Oke9NhT8lz+XYZ2+/kBbTOZOVr+b7M8ZSWR1RJMh6
Fz1B/eqKadnFqrMUMAEIfzXRikEUIIW5M6sUmeWYgpA0ZQ5cb75Ap+LuiMjBxxk=
=q9AW
-----END PGP SIGNATURE-----

--vOhsCi6W7jGS7w0bJJME6GxoDOJ7ou1fI--
