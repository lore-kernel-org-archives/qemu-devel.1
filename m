Received: from eggs.gnu.org ([2001:4830:134:3::10]:53652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dakC1-0005Xw-Nj
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dakC0-00069s-G4
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:55:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dakC0-00068n-38
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:55:12 -0400
References: <1920BE03-56F6-4E44-B9D2-0638A86FACB2@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c3214a0-196d-fa81-dbf8-237034b445de@redhat.com>
Date: Thu, 27 Jul 2017 09:55:09 -0500
MIME-Version: 1.0
In-Reply-To: <1920BE03-56F6-4E44-B9D2-0638A86FACB2@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="53TdFjB6jDsnH2b8PKEs7FEur0CXqStr3"
Subject: Re: [Qemu-devel] [PATCH 1/2] Add more function keys to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--53TdFjB6jDsnH2b8PKEs7FEur0CXqStr3
From: Eric Blake <eblake@redhat.com>
To: Programmingkid <programmingkidx@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Message-ID: <5c3214a0-196d-fa81-dbf8-237034b445de@redhat.com>
Subject: Re: [PATCH 1/2] Add more function keys to QEMU
References: <1920BE03-56F6-4E44-B9D2-0638A86FACB2@gmail.com>
In-Reply-To: <1920BE03-56F6-4E44-B9D2-0638A86FACB2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 09:51 AM, Programmingkid wrote:

You forgot in-reply-to: and references: headers, meaning this was not
threaded with your 0/2 patch.

> There are now keyboards that have 19 function keys. This patch extends =
QEMU so these function keys can be used.=20
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  qapi-schema.json  | 6 +++++-
>  ui/input-keymap.c | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)

Conflicts with Gerd's pending UI pull; so you'll need to rebase.
Furthermore, while Gerd added keys after softfreeze (necessary to fix a
regression), your additions seem to be a new feature rather than a bug
fix, and may therefore be more appropriate for 2.11.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--53TdFjB6jDsnH2b8PKEs7FEur0CXqStr3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll5/s0ACgkQp6FrSiUn
Q2rLcgf/ahctkTF9tHmjYBkz5R9vWZ/ZtUsrw/9SeN6IvgY1vkOSHJa2E+VNGEte
1tVdLehY0bCxY739+PGIGfs5I2Eo0+zEQuOH+GshBUyzg+wSn1gwrgO95GXftM0G
rrWD9L2I1BOwE0RhQ8x94oamI7Nm7HCpc+blcl40Gy3ILIFDcEuyUGSn7HWKIfE1
uIyUUtLmSt17gTXnp7KsjtC1/r8ay3Ezr41f8ZDdGhVYX3KHlsq/5rbeJA6w9Gwa
YZiols5iQ5s/LURYAiJ/AnNb+dHWoWdSebzT1xKpkgNE6ks+FqvDVxSjE1fXjq73
tBiWloFQSi6J4Cz8KdF5DdrNfYolRw==
=/I+H
-----END PGP SIGNATURE-----

--53TdFjB6jDsnH2b8PKEs7FEur0CXqStr3--
