Received: from eggs.gnu.org ([2001:4830:134:3::10]:56830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cny3U-0004QB-50
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cny3Q-0004PX-3Y
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:48:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cny3P-0004P8-Qu
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 21:48:44 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-48-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32dd1eb2-3a15-55f5-b2a2-cde8d5133250@redhat.com>
Date: Tue, 14 Mar 2017 20:48:41 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-48-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Okf3t20SFpfTOcf4Soi2WWwoVMNhA3iPS"
Subject: Re: [Qemu-devel] [PATCH for-2.9 47/47] qapi: Fix a misleading
 parser error message
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
--Okf3t20SFpfTOcf4Soi2WWwoVMNhA3iPS
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <32dd1eb2-3a15-55f5-b2a2-cde8d5133250@redhat.com>
Subject: Re: [PATCH for-2.9 47/47] qapi: Fix a misleading parser error message
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-48-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-48-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> When choking on a token where an expression is expected, we report
> 'Expected "{", "[" or string'.  Close, but no cigar.  Fix it to
> Expected '"{", "[", string, boolean or "null"'.
>=20
> Missed in commit e53188a.

Will need adjustment again if we ever start parsing numbers to provide
default values. Maybe we'll remember that time around :)

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py                           | 3 ++-
>  tests/qapi-schema/trailing-comma-list.err | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Okf3t20SFpfTOcf4Soi2WWwoVMNhA3iPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyJ15AAoJEKeha0olJ0Nqm/EH/RcE4uCzXqnFB8QNGWL/EHZY
xjfqZr2DQvB24oVLaMXVLa5sMQ/xBft9vY8ulmlTKwUqFZOpesVOd4nhD11q/mSC
Xuu9OgFyRa1Lit/3UF5Qx1GGLRjLZkTQzdiw+jCw2DiVV2q3j5Or0qCE6JG7u6RV
P9h5l8q3LtsG2b3X478cvQ8TkEl9dKkFUcIL5Q7L35Ld5/I+OOaIFjLUK0KRucNt
2E/cpXby2ht7rj6e3NNVKGZm3L8xkY8FZVeUHVsOosludx3nYzwHbhsyKA+boKMw
IMp2q9g230HO3MMRgqVejFM55rUEhYRCTwc+9dY12T2FXgyQJMJBSIg7gtOHr/c=
=kmxG
-----END PGP SIGNATURE-----

--Okf3t20SFpfTOcf4Soi2WWwoVMNhA3iPS--
