Received: from eggs.gnu.org ([2001:4830:134:3::10]:54263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6IM9-0006Sh-D0
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6IM5-0005nq-HP
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:12:21 -0400
References: <20180330161040.350271-1-vsementsov@virtuozzo.com>
	<b6a499bc-b5c6-7c35-e916-d63861f0c0c5@redhat.com>
	<3d0d9016-276f-c1c6-eb7e-ef78c0744f01@redhat.com>
	<47c416af-4b8e-db9a-4b4b-9b0eb060b4ff@virtuozzo.com>
	<ec4ee8f5-7a47-2e18-1fe3-d4f3859bc8ce@virtuozzo.com>
	<90b289f4-d976-1fb7-57e2-aa02d00947d1@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e8cc4fbe-4b0e-4ab8-64ff-0c12a080e09e@redhat.com>
Date: Wed, 11 Apr 2018 18:11:57 +0200
MIME-Version: 1.0
In-Reply-To: <90b289f4-d976-1fb7-57e2-aa02d00947d1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

On 2018-04-11 15:05, Vladimir Sementsov-Ogievskiy wrote:

[...]

> Hmm, first type? I'm now not sure about, did I really see sha256
> mismatch, or something like this (should be error, but found bitmap):
>=20
> --- /work/src/qemu/up-169/tests/qemu-iotests/169.out=C2=A0=C2=A0=C2=A0 =
2018-04-11
> 15:35:10.055027392 +0300
> +++ /work/src/qemu/up-169/tests/qemu-iotests/169.out.bad 2018-04-11
> 15:58:09.300450045 +0300
> @@ -1,5 +1,20 @@
> -........
> +F.......
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test__not_persistent__migbitmap__offline
> (__main__.TestDirtyBitmapMigration)
> +methodcaller(name, ...) --> methodcaller object
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +=C2=A0 File "169", line 136, in do_test_migration
> +=C2=A0=C2=A0=C2=A0 self.check_bitmap(self.vm_b, sha256 if persistent e=
lse False)
> +=C2=A0 File "169", line 77, in check_bitmap
> +=C2=A0=C2=A0=C2=A0 "Dirty bitmap 'bitmap0' not found");
> +=C2=A0 File "/work/src/qemu/up-169/tests/qemu-iotests/iotests.py", lin=
e 389,
> in assert_qmp
> +=C2=A0=C2=A0=C2=A0 result =3D self.dictpath(d, path)
> +=C2=A0 File "/work/src/qemu/up-169/tests/qemu-iotests/iotests.py", lin=
e 348,
> in dictpath
> +=C2=A0=C2=A0=C2=A0 self.fail('failed path traversal for "%s" in "%s"' =
% (path, str(d)))
> +AssertionError: failed path traversal for "error/desc" in "{u'return':
> {u'sha256':
> u'01d2ebedcb8f549a2547dbf8e231c410e3e747a9479e98909fc936e0035cf8b1'}}"
>=20
>=20
> Max, did you really seed sha256 mismatch or only something like this?

I'm pretty sure I did see mismatches.

Max
