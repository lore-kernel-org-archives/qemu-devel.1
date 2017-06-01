Received: from eggs.gnu.org ([2001:4830:134:3::10]:48531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGW6K-0000wk-Hr
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGW6H-0001p3-Fv
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:49:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGW6H-0001mS-7Y
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:49:41 -0400
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496330073-51338-3-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e21f44ea-a5ec-fb51-699a-b6eb06cc11b2@redhat.com>
Date: Thu, 1 Jun 2017 14:49:37 -0500
MIME-Version: 1.0
In-Reply-To: <1496330073-51338-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n5nCphDfaJS7ITHrkv8WliWtQkpmHUFmk"
Subject: Re: [Qemu-devel] [PATCH v2 02/15] file-posix: support
 BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n5nCphDfaJS7ITHrkv8WliWtQkpmHUFmk
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <e21f44ea-a5ec-fb51-699a-b6eb06cc11b2@redhat.com>
Subject: Re: [PATCH v2 02/15] file-posix: support BDRV_REQ_ALLOCATE
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1496330073-51338-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496330073-51338-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 10:14 AM, Anton Nefedov wrote:
> Current write_zeroes implementation is good enough to satisfy this flag=
 too
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/file-posix.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Are we sure that fallocate() is always fast, or are there some file
systems where it is no faster than manually writing zeroes?  I'm worried
that blindly claiming BDRV_REQ_ALLOCATE may fail if we encounter a libc
or kernel-based fallback that takes a slow patch on our behalf.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--n5nCphDfaJS7ITHrkv8WliWtQkpmHUFmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMG/RAAoJEKeha0olJ0NqBqQIAKfhfz/yUlDFunfbu+0C8UYT
DLH+bcF5/SfzLbFalctuTPKAKOsTR5xCqbuy9hnjas9Vigk1oC76cVbbtOligloe
vA/IphGhIJl+8025Th87iLycGYdBEY8kPiieiIFyPO+A5pLP3c3acOSRP/ppkPXz
dpwMO5RPw2VVCiGCI0wnfxKnECRlsiNoOuCA34kVxqezkZKkND4xyGZZZ+tp4B8p
mlrBDuqXH6eJ58ptibGVojZsi6nmShi+4dO7d41Shwpsap+RgLkJre91OmU8+3Pz
C3QRtpLGBTgwcFj7eOWHFzekqxQxJ7cg4eDyTA4b1gdWNDdIKs/ktuXgdWbr4v0=
=ZKCe
-----END PGP SIGNATURE-----

--n5nCphDfaJS7ITHrkv8WliWtQkpmHUFmk--
