Received: from eggs.gnu.org ([2001:4830:134:3::10]:46752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csYEb-0004DH-BK
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csYEX-0003oV-9K
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:15:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csYEX-0003n1-0o
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:15:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3FE97AE90
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 17:15:07 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-11-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <405ce7e5-b356-f37e-892d-a39cb3a52fc5@redhat.com>
Date: Mon, 27 Mar 2017 12:15:05 -0500
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-11-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sN85tV9q8wJ0Osnjedr4JmWd2qBc0nNm2"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 10/11] Revert "rbd: add
 support for getting password from QCryptoSecret object"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, "Daniel P . Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sN85tV9q8wJ0Osnjedr4JmWd2qBc0nNm2
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, "Daniel P . Berrange" <berrange@redhat.com>
Message-ID: <405ce7e5-b356-f37e-892d-a39cb3a52fc5@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 10/11] Revert "rbd: add support for getting
 password from QCryptoSecret object"
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-11-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 08:26 AM, Markus Armbruster wrote:
> This reverts commit 60390a2192e7b38aee18db6ce7fb740498709737.
>=20
> The commit's rationale
>=20
>     Currently RBD passwords must be provided on the command line
>     via
>=20
>       $QEMU -drive file=3Drbd:pool/image:id=3Dmyname:\
>                    key=3DQVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE=
1RMUE=3D:\
>                    auth_supported=3Dcephx
>=20
>     This is insecure because the key is visible in the OS process
>     listing.
>=20
> is invalid.  You can easily avoid passing keys on the command line by
> using "keyfile" instead of "key".  In fact, the Ceph documentation
> calls use of key "not recommended".  But the most common way to
> provide keys is a keyring.  The default keyrings should be just fine
> for most users.  When they aren't, you can configure your own keyrings
> with "keyring" or override the key with "keyfile".
>=20
> The commit adds parameter password-secret to -drive.  Support for it
> was included in -blockdev, but reverted in the previous commit due to
> concerns about the QMP interface.  Revert it from -drive, too.
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 47 -----------------------------------------------
>  1 file changed, 47 deletions(-)

Are we sure this won't be breaking existing libvirt clients?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sN85tV9q8wJ0Osnjedr4JmWd2qBc0nNm2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2UiZAAoJEKeha0olJ0Nq+hwH/0SutHwh+XBmCGuyYiI1ta5U
3IuRSFCHfZZMjo/8hn+BZgVnP+dGymm0HsSHqJVUJLmXZmVEZwHeML8gF72eBkMo
lDqCyqEByFH9hwy9N745MCNnpvMxQv4ZMspT9aCiy6xyxI2iSXT9tspxgn7uCxTJ
QZGDEWgxfFpF0CMItWcvXTr5CkU8WGkUlMNcnzUxWQ895o3Llwr/Kuhb7SbklnRG
hqq4g+uJR8tOfPVhKDiA8JKPMWt2LJLhvbXrBdMd0OM6GmIRzH75wrlwWhUuFmHJ
Qcg45KNxukyKXWEAJd8dIZckllMrtp1Mf4cQE00BwyTVQvQw/f1QOPTiyQdmmmU=
=KmaP
-----END PGP SIGNATURE-----

--sN85tV9q8wJ0Osnjedr4JmWd2qBc0nNm2--
