Received: from eggs.gnu.org ([2001:4830:134:3::10]:35193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KQ2-0007sE-05
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KQ1-0005Fk-1d
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:19:57 -0400
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
	<1493916761-32319-3-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <821add6c-1b1b-71b5-ba9e-2760d368f761@redhat.com>
Date: Thu, 4 May 2017 12:19:48 -0500
MIME-Version: 1.0
In-Reply-To: <1493916761-32319-3-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6MdTiqVwRhggoHXr5EktrodujIC6re8r7"
Subject: Re: [Qemu-devel] [PATCH 2/6] block: New BdrvChildRole.activate()
 for blk_resume_after_migration()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6MdTiqVwRhggoHXr5EktrodujIC6re8r7
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <821add6c-1b1b-71b5-ba9e-2760d368f761@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] block: New BdrvChildRole.activate() for
 blk_resume_after_migration()
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
 <1493916761-32319-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-3-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 11:52 AM, Kevin Wolf wrote:
> Instead of manually calling blk_resume_after_migration() in migration
> code after doing bdrv_invalidate_cache_all(), integrate the BlockBacken=
d
> activation with cache invalidation into a single function. This is
> achieved with a new callback in BdrvChildRole that is called by
> bdrv_invalidate_cache_all().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6MdTiqVwRhggoHXr5EktrodujIC6re8r7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC2K0AAoJEKeha0olJ0NqjqsIAIb9m8P2KeyPnSDakFuRcWUN
j9CGYo/BBmMlY7t4wLZtsAL/wRVezMaZikqkR9+nPXxzm7gsguG8Y8X02renoSzk
SduVK5p3rh3tEh8TuZRU6gEdqMqF9kUUYTXe3WowEdzvvu5+WVYFo1xFvNqo3qOx
8AP/SENWyLD2dne4J404RtSjoxgAjBg4UlvqBjJ76YbBT5mfCG0D6/F9Y5JN07Q+
ZvnbdPYviY1mLyxdSj38UEmG+lbeaMKXRG5tdy2ZIzHgGeQ6aLsP0d8vnR661H3H
/ctz3dZD3GnioIfPZJ2ZDUIy3h89eyK9HHucliSzB1tyvlEwP4xP+PGf8PlB7ms=
=JoiD
-----END PGP SIGNATURE-----

--6MdTiqVwRhggoHXr5EktrodujIC6re8r7--
