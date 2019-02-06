Received: from eggs.gnu.org ([209.51.188.92]:45452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grRiv-0002sv-8r
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grRiu-0000Vm-Fx
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:15:01 -0500
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
	<20190206165342.219192-3-vsementsov@virtuozzo.com>
	<abf6dafa-da7d-4bf5-5a21-225c2809a038@redhat.com>
	<aced9235-a3d7-e201-ce13-ff2094ac974f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <608f7ff7-7b3c-939a-7bdb-852f63f4828e@redhat.com>
Date: Wed, 6 Feb 2019 12:14:48 -0600
MIME-Version: 1.0
In-Reply-To: <aced9235-a3d7-e201-ce13-ff2094ac974f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SMU4PC2y1QiruE98BxZsdXj4b9IBfWcys"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block/io: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SMU4PC2y1QiruE98BxZsdXj4b9IBfWcys
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Message-ID: <608f7ff7-7b3c-939a-7bdb-852f63f4828e@redhat.com>
Subject: Re: [PATCH v2 2/2] block/io: use qemu_iovec_init_buf
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
 <20190206165342.219192-3-vsementsov@virtuozzo.com>
 <abf6dafa-da7d-4bf5-5a21-225c2809a038@redhat.com>
 <aced9235-a3d7-e201-ce13-ff2094ac974f@virtuozzo.com>
In-Reply-To: <aced9235-a3d7-e201-ce13-ff2094ac974f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 12:09 PM, Vladimir Sementsov-Ogievskiy wrote:
> 06.02.2019 20:32, Eric Blake wrote:
>> On 2/6/19 10:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Use new qemu_iovec_init_buf() instead of
>>> qemu_iovec_init_external( ... , 1), which simplifies the code.
>>
>> Did you just do a manual search for candidate callers?
>>
>> As you said in the cover letter, there are other files that can benefi=
t
>> as well; are you planning on making v3 of the series longer?
>=20
> git grep qemu_iovec_init_external | grep 1
>=20
> shows a lot of, exactly 34 after io.c already updated.
> They are in different subsystems, so I think it should be simpler to pu=
sh this
> one as a precedent and example, and then send separate patches (or seri=
es)
> per-maintainer.

Most are block related, so getting it in through the block maintainers
is probably the easiest - but you ARE right that one patch per one or
two files or two is going to be smartest (otherwise, it gets too big).

>=20
> hm, in other words:
> # git grep -l 'qemu_iovec_init_external.*1'
> block/backup.c
> block/block-backend.c
> block/commit.c
> block/parallels.c
> block/qcow.c
> block/qcow2.c
> block/qed-table.c
> block/qed.c
> block/stream.c
> block/vmdk.c
> hw/ide/atapi.c
> hw/ide/core.c
> hw/scsi/scsi-disk.c
> migration/block.c
> qemu-img.c
> tests/test-bdrv-drain.c

I'd group qed-table.c and qed.c; and the two hw/ide/ files; resulting in
14 more patches to go.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--SMU4PC2y1QiruE98BxZsdXj4b9IBfWcys
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbJBkACgkQp6FrSiUn
Q2oozwf/VLLU6s9kNVS5aFgA32P5ka1EB8W/yKq5SPwGlfl20kfs+w4C47XftmG3
7iFa0YFdln4afgpzUAEWrsNzUbev1oFdpXKz8f+KViKbttpeOho0GeE9qTuKPFKe
n1AZ15Lmb1aznKJ3DbQ3tjb+JibbjoS0mlIx3I/DcZ28qFXuxmoG5qIOfDRrUC7N
d0x66MXzlwu2PkUSLqBfT4vv/LcPrIcpRmI0Ss2xJ+AocQnAiFLxUmDaPiXco4Gx
KvYAueCPJ2L4SEKkoYMGhCr4ZR27aPh+f7/ZJdFsvn5TQT4o21V9jnhGrr7h7jJx
n4obuNE4nXJAwQpK2hVenE0Rqk1CQw==
=452c
-----END PGP SIGNATURE-----

--SMU4PC2y1QiruE98BxZsdXj4b9IBfWcys--
