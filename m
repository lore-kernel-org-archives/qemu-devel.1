Received: from eggs.gnu.org ([2001:4830:134:3::10]:58848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjaFg-0000u4-Qm
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjaFf-0002M4-SL
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:35:16 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dba72030-5a51-c439-ff27-9bb52430b772@redhat.com>
Date: Thu, 2 Mar 2017 17:35:08 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pgmee2o9ciA4BQwptkrgLbnENuPbXDP7F"
Subject: Re: [Qemu-devel] [PATCH 00/15] block: A bunch of fixes for Sheepdog
 and Gluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pgmee2o9ciA4BQwptkrgLbnENuPbXDP7F
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <dba72030-5a51-c439-ff27-9bb52430b772@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/15] block: A bunch of fixes for Sheepdog
 and Gluster
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:43 PM, Markus Armbruster wrote:
> Bad error handling, memory leaks, and lack of blockdev-add support.

How hard are we trying to get blockdev-add working in 2.9?  Or is this
series 2.10 material now?

>=20
> Markus Armbruster (15):
>   sheepdog: Defuse time bomb in sd_open() error handling
>   sheepdog: Fix error handling in sd_snapshot_delete()
>   sheepdog: Fix error handling sd_create()
>   sheepdog: Mark sd_snapshot_delete() lossage FIXME
>   sheepdog: Fix snapshot ID parsing in _open(), _create, _goto()
>   sheepdog: Don't truncate long VDI name in _open(), _create()
>   sheepdog: Report errors in pseudo-filename more usefully
>   sheepdog: Use SocketAddress and socket_connect()
>   sheepdog: Implement bdrv_parse_filename()
>   gluster: Drop assumptions on SocketTransport names
>   gluster: Don't duplicate qapi-util.c's qapi_enum_parse()
>   gluster: Plug memory leaks in qemu_gluster_parse_json()
>   qapi-schema: Rename GlusterServer to SocketAddressFlat
>   qapi-schema: Rename SocketAddressFlat's variant tcp to inet
>   sheepdog: Support blockdev-add
>=20
>  block/gluster.c      | 127 +++++++--------
>  block/sheepdog.c     | 436 +++++++++++++++++++++++++++++++++++++------=
--------
>  qapi-schema.json     |  38 +++++
>  qapi/block-core.json |  73 +++------
>  4 files changed, 443 insertions(+), 231 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Pgmee2o9ciA4BQwptkrgLbnENuPbXDP7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuKwsAAoJEKeha0olJ0NqClYH/irVQ4y/sDuy9d2ew8c7Wp9G
/665BrY3lGuGkghE7bZrjeIoSP5M2R7BkDpolp6xjmGniIVBiwQ5Ir9PzAQYPGA8
gykdxrRO/u1CcOyxPlsoXU9csnHq5+kkO81hcgbBjEofKUp5N/KGy89SJ64+5aLp
F73iScSiBNPpPkiITA5Oqg67+zvkHP253zaRqCLhbmCnDX7+CKEUw92qpG6RjyqS
7fCK/hIma3bbTpgxvse4QimZqJoFhkx58Daoj7EKLzFv+K+HmcEp3GqGLIdI6cU2
nKBmLHBGJwozwa3XAs5J8pI34HGPoaBoMMhmR5wPi+F8JgnK/2+IdDyGIQibBWg=
=ypDV
-----END PGP SIGNATURE-----

--Pgmee2o9ciA4BQwptkrgLbnENuPbXDP7F--
