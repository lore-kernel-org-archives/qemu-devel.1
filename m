Received: from eggs.gnu.org ([2001:4830:134:3::10]:36965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSic7-0000LX-P4
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSic7-0002wU-02
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:13:47 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
	<2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
	<e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
Date: Fri, 30 Nov 2018 14:13:32 +0100
MIME-Version: 1.0
In-Reply-To: <e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GVY38ggGQnLBHGc06C9oSJD6Q5Va1m3lg"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GVY38ggGQnLBHGc06C9oSJD6Q5Va1m3lg
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com"
 <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Message-ID: <abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: simple mirror test with kvm on 1G image
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
 <20181129101801.6421-3-vsementsov@virtuozzo.com>
 <2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
 <e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
In-Reply-To: <e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.11.18 14:06, Vladimir Sementsov-Ogievskiy wrote:
> 30.11.2018 15:30, Max Reitz wrote:
>> On 29.11.18 11:18, Vladimir Sementsov-Ogievskiy wrote:
>>> This test is broken without previous commit fixing dead-lock in mirro=
r.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>=

>>> ---
>>>   tests/qemu-iotests/235     | 59 +++++++++++++++++++++++++++++++++++=
+++
>>>   tests/qemu-iotests/235.out |  1 +
>>>   tests/qemu-iotests/group   |  1 +
>>>   3 files changed, 61 insertions(+)
>>>   create mode 100755 tests/qemu-iotests/235
>>>   create mode 100644 tests/qemu-iotests/235.out
>> I'll get to the first patch in a second, but first a suggestion for th=
is
>> patch: I think it's not so good to use 2 GB of space for a test (1 GB
>> for the source, 1 GB for the target).  So I tried my luck and found th=
at
>> the test works, too, if you just use preallocation=3Dmetadata for the
>> source (instead of actually writing data) and blockdev-mirror'ing the
>> data to a throttled null-co device.
>=20
> Hmm, so parsing metadata is enough for qcow2 to yield on write, yes?

Apparently so.  If you can confirm that applying those changes to the
test still make it work (i.e., fail before patch 1, pass afterwards),
then I think it is just as good.

[...]

> anyway, it's good thing to avoid 2G allocation in test, I agree.

And if for some reason the test needs to keep doing that, I'd propose
adding some new test group for tests that do use such a large amount of
disk space so it can be excluded if people don't want that to happen.

Max


--GVY38ggGQnLBHGc06C9oSJD6Q5Va1m3lg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwBN3wACgkQ9AfbAGHV
z0Birgf+IFxaCyff4DTpvAYT6cxoy1u6/2j/624K7XSpxZ3JiWSY4dyc6/Fzqnhv
JU5Ky6ixh8yCqOaGH4OBj+4+hNguJ9M7FD7iCFxIAk3FVxJKyE+sqR5ZhmnBBOOr
pjd4zGN9UhJJcC5FKd86bPC5CYQPz1O7RaKtWPhS5ABzeyWiM0srKLzTcvYX1GT6
3Kr9QmGN2tbM2WEsQ5QMXk6wXJnC/y17mW2XNqVDqZ/36q8HP4T6oElahR8RXLTa
Gvx0FDFbb8vzGFLa0Dpey7VbaN/fkDqOwTlLuaKzJiBtZN4sJooLCECV3sPzfz0n
6Q4A4YVUyoua3s6/NhnWdJ8xgDAgxQ==
=jHAs
-----END PGP SIGNATURE-----

--GVY38ggGQnLBHGc06C9oSJD6Q5Va1m3lg--
