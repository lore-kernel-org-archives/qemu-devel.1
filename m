Received: from eggs.gnu.org ([2001:4830:134:3::10]:59215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJwl-0005Fd-V9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVJwl-0001Lz-5O
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:53:04 -0400
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-7-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b836f508-4d94-3a6a-058f-756d3d7acbc7@redhat.com>
Date: Wed, 12 Jul 2017 10:52:52 -0500
MIME-Version: 1.0
In-Reply-To: <1499864249-26305-7-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rmdVL9erGkiKDufe65S2gmM9XL9hLbuDG"
Subject: Re: [Qemu-devel] [PATCH 6/9] ide: bdrv_attach_dev() for empty CD-ROM
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
--rmdVL9erGkiKDufe65S2gmM9XL9hLbuDG
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <b836f508-4d94-3a6a-058f-756d3d7acbc7@redhat.com>
Subject: Re: [PATCH 6/9] ide: bdrv_attach_dev() for empty CD-ROM
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
 <1499864249-26305-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-7-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> If no drive=3D... option is passed (for an empty drive), we don't only
> lack the BlockBackend normally created by parse_drive(), but we also
> need to manually call blk_attach_dev().
>=20
> IDE does not support hot unplug, but if it did, qdev would take care to=

> call the matching blk_detach_dev() on unplug.
>=20
> This fixes at least the bug that such devices didn't show up in
> query-block, and probably some more problems.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/ide/qdev.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rmdVL9erGkiKDufe65S2gmM9XL9hLbuDG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZkXUAAoJEKeha0olJ0NqNnUH/jTVcfKv4N5uZrzPfXbj+Jcd
xfi7sdAeuC2lHbtAyQFjO2cFkxEJivh3Vhb5h5vRCb1jBwJcLToXBloNHweF32+P
Y06V+o+24TDzSSDJCvN0BFqCAEN+nO7XoSqh0UqtUobhAXgV7MaWpEcrimTAhesB
x4yMl9wmT0GX7qYwgXylNp6PXot9V0+JF0/BUGEADL7m4AJTJe4UvfTmfK+1nvCu
58m2Ccx5j8nCtZAcYSJqwC52y7E4Qsb+QEXYLz7K6qcOMkusp4ep80QcOFiHbktB
q8B3TwU/1tOnbT7p0m2UT4f5ZWYc1zzXnhb+RqzIu1EAMnqIxfERQqfvxnmQBeQ=
=gII0
-----END PGP SIGNATURE-----

--rmdVL9erGkiKDufe65S2gmM9XL9hLbuDG--
