Received: from eggs.gnu.org ([2001:4830:134:3::10]:55196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwEsJ-0002bf-UN
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwEsJ-0001x7-08
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:23:27 -0400
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
	<1488314205-16264-44-git-send-email-kwolf@redhat.com>
	<20170406205939.GA28584@redhat.com>
	<a010df05-e986-2142-3196-31f549558511@redhat.com>
	<20170406211537.GR30620@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <616fdb8b-2c41-9718-d5b3-e335e78745e4@redhat.com>
Date: Thu, 6 Apr 2017 16:23:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170406211537.GR30620@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fN27TnsdH3Etb3si1prOsl0TdvLCH77p1"
Subject: Re: [Qemu-devel] [PULL 43/46] block: Assertions for write
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fN27TnsdH3Etb3si1prOsl0TdvLCH77p1
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <616fdb8b-2c41-9718-d5b3-e335e78745e4@redhat.com>
Subject: Re: [Qemu-devel] [PULL 43/46] block: Assertions for write permissions
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
 <1488314205-16264-44-git-send-email-kwolf@redhat.com>
 <20170406205939.GA28584@redhat.com>
 <a010df05-e986-2142-3196-31f549558511@redhat.com>
 <20170406211537.GR30620@redhat.com>
In-Reply-To: <20170406211537.GR30620@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 04:15 PM, Richard W.M. Jones wrote:

>>>> +++ b/block/io.c
>>>> @@ -945,6 +945,8 @@ static int coroutine_fn bdrv_co_do_copy_on_readv=
(BdrvChild *child,
>>>>      size_t skip_bytes;
>>>>      int ret;
>>>> =20
>>>> +    assert(child->perm & (BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE=
));
>>>

> https://bugzilla.redhat.com/show_bug.cgi?id=3D1439922
>=20
> There is also a minimal reproducer in comment 2.

If it helps, backtrace shows:

#4  0x0000555555c09f10 in bdrv_co_do_copy_on_readv
(child=3D0x555556990180, offset=3D0, bytes=3D512, qiov=3D0x7fffffffd0c0) =
at
block/io.c:948
#5  0x0000555555c0a33d in bdrv_aligned_preadv (child=3D0x555556990180,
req=3D0x7fffb6dffec0, offset=3D0, bytes=3D512, align=3D1, qiov=3D0x7fffff=
ffd0c0,
flags=3D1)
    at block/io.c:1058
#6  0x0000555555c0a8c3 in bdrv_co_preadv (child=3D0x555556990180,
offset=3D0, bytes=3D512, qiov=3D0x7fffffffd0c0, flags=3DBDRV_REQ_COPY_ON_=
READ)
at block/io.c:1166
#7  0x0000555555bf7ccf in blk_co_preadv (blk=3D0x555556a2bc20, offset=3D0=
,
bytes=3D512, qiov=3D0x7fffffffd0c0, flags=3D0) at block/block-backend.c:9=
27
#8  0x0000555555bf7e19 in blk_read_entry (opaque=3D0x7fffffffd0e0)
    at block/block-backend.c:974
#9  0x0000555555cc3015 in coroutine_trampoline (i0=3D1485566720, i1=3D218=
45)
    at util/coroutine-ucontext.c:79

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fN27TnsdH3Etb3si1prOsl0TdvLCH77p1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5rHHAAoJEKeha0olJ0NqcSsH/1m+OdqADECbjA71La+Y79TY
XySJmSCj1m2mJz+uyM8DGCfS4SieifstQ0WviXUBFs+oVXG4xTZnOnwvjZ0tKpuc
Qzl8qExlS7XFf+sD4eMQiRpVKoWNZAxf7lZEbXuF0MBAqcPoKTk3twWa2h6hDuy1
YWn6VE/5p7XJ0VUgvz6X7dKpJdNGsCqAI1XFCsiLpJbO2Y3tkO/RZ8ZJ9so4ENX9
N6152jyZpqp8to+rMmySrhvlDG5rUtCrAD+t4LlgUvpkmFjTuKaPDY2aC+jPByWG
MhntF05figseP2o9yTHgzUbPuCZki0K3WlVW9J4SD7gdunv3UUVy6/W0Lrn8sXE=
=UBKd
-----END PGP SIGNATURE-----

--fN27TnsdH3Etb3si1prOsl0TdvLCH77p1--
