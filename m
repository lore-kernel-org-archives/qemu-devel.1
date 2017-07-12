Received: from eggs.gnu.org ([2001:4830:134:3::10]:50947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJWp-0003f2-OB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJWm-0005cI-J1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:26:15 -0400
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-4-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9dfd3619-ca51-812b-1330-04c1559d53d4@redhat.com>
Date: Wed, 12 Jul 2017 10:25:55 -0500
MIME-Version: 1.0
In-Reply-To: <1499864249-26305-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c8gjk82mXvHda46pAUPrg878LNlbEt7Sb"
Subject: Re: [Qemu-devel] [PATCH 3/9] block: Make blk_all_next() public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c8gjk82mXvHda46pAUPrg878LNlbEt7Sb
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <9dfd3619-ca51-812b-1330-04c1559d53d4@redhat.com>
Subject: Re: [PATCH 3/9] block: Make blk_all_next() public
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
 <1499864249-26305-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c          | 2 +-
>  include/sysemu/block-backend.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

(although the commit message could mention WHY it is useful to be
public, because of a pending patch that will need it to do XYZ)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--c8gjk82mXvHda46pAUPrg878LNlbEt7Sb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZj+EAAoJEKeha0olJ0NqGasH+wY8+Gg3abhZtiSlLZgGLcKg
YEQj5rUrPeR8rDRowSbomxjvSbHVsiZMxbzqrNXOJuTMr9lC930Fh7+YffgvLnY+
fhprXlutPa1oX3wSs0Uryq89GdYBPGXU09cuw2hedNTxl5puQFcaXq8Sng0rUwwp
U1kUCbeOFu3Id+MD0Eqe/Vb+WcoTppKVsFIp7ViHmvA8CjkBKz9fAw7qSzCywdyj
/syET/RzXmCrtw6szJ8Hs+d6k0JrU284uwl2Ag48gw+AojaZNmsNpAybELlcp/8L
bdN8CWPDDDOJVjqb3WuPKIQHVEdoJZQP5VOzrLVgV5ifnX8kzbCXMKBweesbuuc=
=/GZY
-----END PGP SIGNATURE-----

--c8gjk82mXvHda46pAUPrg878LNlbEt7Sb--
