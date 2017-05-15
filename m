Received: from eggs.gnu.org ([2001:4830:134:3::10]:47063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAJvz-0006lc-0M
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAJvu-0007iD-VW
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAJvu-0007i1-MD
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:37:22 -0400
References: <149486383099.19357.10170962018755572073.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5fad238-40ac-7deb-e1b6-33e57c0bb117@redhat.com>
Date: Mon, 15 May 2017 12:37:08 -0500
MIME-Version: 1.0
In-Reply-To: <149486383099.19357.10170962018755572073.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NAaqQtBIbe9v3pFuNwcwWfOAqJWMxqHBi"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: local: forbid client access to
 metadata (CVE-2017-7493)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>, Prasad J Pandit <prasad@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NAaqQtBIbe9v3pFuNwcwWfOAqJWMxqHBi
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Leo Gaspard <leo@gaspard.io>, Prasad J Pandit <prasad@redhat.com>
Message-ID: <b5fad238-40ac-7deb-e1b6-33e57c0bb117@redhat.com>
Subject: Re: [PATCH] 9pfs: local: forbid client access to metadata
 (CVE-2017-7493)
References: <149486383099.19357.10170962018755572073.stgit@bahia.lan>
In-Reply-To: <149486383099.19357.10170962018755572073.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 11:07 AM, Greg Kurz wrote:
> When using the mapped-file security mode, we shouldn't let the client m=
ess
> with the metadata. The current code already tries to hide the metadata =
dir
> from the client by skipping it in local_readdir(). But the client can s=
till
> access or modify it through several other operations. This can be used =
to
> escalate privileges in the guest.
>=20
> Affected backend operations are:
> - local_mknod()
> - local_mkdir()
> - local_open2()
> - local_symlink()
> - local_link()
> - local_unlinkat()
> - local_renameat()
> - local_rename()
> - local_name_to_path()
>=20
> Other operations are safe because they are only passed a fid path, whic=
h
> is computed internally in local_name_to_path().
>=20
> This patch converts all the functions listed above to fail and return
> EINVAL when being passed the name of the metadata dir. This may look
> like a poor choice for errno, but there's no such thing as an illegal
> path name on Linux and I could not think of anything better.
>=20
> This fixes CVE-2017-7493.
>=20
> Reported-by: Leo Gaspard <leo@gaspard.io>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NAaqQtBIbe9v3pFuNwcwWfOAqJWMxqHBi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGedEAAoJEKeha0olJ0Nq+GkIAID5SSHOewQETaVyV1fd1YEw
xMmUI0dQjVQy4STKOgXeia2A6xstDykf7+PXwp+bIGamKLc5ywECZUh5XVvziZpZ
BnAldFYlHUrEra6KpORO2MGTTKirXtKGplxf0zrfclQeo3iOzO8wSD4JnkZHisxC
hjQPCCxAJQFkLVyXeDiyfj3lrBs2LY33ZkKKC1AULhp+mbDkJV5TRm2kP3vzZNnN
rPeB+fa7mDA/WGvCyXnva/CpgUb9/tdy6TQK0XlkJywDlU6CnVRVUasZcWvIZMNe
TNZFCYHUAhreFaR0ZaxEqtZHUMH8u1ok6QtO1sy6E0vy2NDoQ0S9i4cERgd9Auw=
=Vr4C
-----END PGP SIGNATURE-----

--NAaqQtBIbe9v3pFuNwcwWfOAqJWMxqHBi--
