Received: from eggs.gnu.org ([2001:4830:134:3::10]:44334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMrs-00042J-Bc
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMrr-0006Tq-FE
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:33:56 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-7-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <198caa5b-0416-845a-dcb8-0defa70f6847@redhat.com>
Date: Fri, 26 May 2017 16:33:45 -0500
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-7-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="75VNrQnaKNBUaI1RW0rI3nMouCJWCdC70"
Subject: Re: [Qemu-devel] [PATCH 06/29] qed: Make qed_read_backing_file()
 synchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--75VNrQnaKNBUaI1RW0rI3nMouCJWCdC70
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <198caa5b-0416-845a-dcb8-0defa70f6847@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/29] qed: Make qed_read_backing_file()
 synchronous
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-7-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:21 PM, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--75VNrQnaKNBUaI1RW0rI3nMouCJWCdC70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKJ85AAoJEKeha0olJ0NqDMYH/i/2PsA5UgUSLEd00YWElQUn
5300f6uS/7I0MWkXhYYL7Khl4tLgdS5UQYzcP5y1eZ5cJssvhmBiqW2EOVmJ8CVb
htNW6jn0/aOWmGx23lhEQOx3TvjjRHeQTCxV0dmqZ656Z8zK2bCDe7Syb89TyiBG
gDCEr3KoZAy4oddbWXRIEqhnP1VGuN7OaUc29MAf8jjXuXCenY4Z1dVp4qmA37N8
DXI1IKhEh+tXrNiW0m7t0KmMw10uOCwJatjBW9bN2GMirESv+rDjucInS3XIxl2y
SQJf23ujMqN5rUPnJyuUC7wXewwZivpd1GjNIx8setHqDDBN0eKoT2TGKB4LYlY=
=68yn
-----END PGP SIGNATURE-----

--75VNrQnaKNBUaI1RW0rI3nMouCJWCdC70--
