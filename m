Received: from eggs.gnu.org ([2001:4830:134:3::10]:58426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZjD7-0005Hi-Na
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZjD6-0001dn-CX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 14:07:53 -0500
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-17-git-send-email-vsementsov@virtuozzo.com>
	<59237595-78d7-5aa2-c38a-d986564b5ed0@redhat.com>
	<e25c6fb7-0d1f-a91a-9680-e206f6db2cd8@virtuozzo.com>
	<99233c16-4881-2fca-77f7-5cb7633d0f83@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2b918aa8-be24-c135-1336-7ea76da80d84@redhat.com>
Date: Fri, 3 Feb 2017 20:07:41 +0100
MIME-Version: 1.0
In-Reply-To: <99233c16-4881-2fca-77f7-5cb7633d0f83@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vctCcIKLTXVNNlJwoCVKarirPbxEMV24i"
Subject: Re: [Qemu-devel] [PATCH 16/17] iotests: add dirty bitmap migration
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vctCcIKLTXVNNlJwoCVKarirPbxEMV24i
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com,
 quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org,
 dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com
Message-ID: <2b918aa8-be24-c135-1336-7ea76da80d84@redhat.com>
Subject: Re: [PATCH 16/17] iotests: add dirty bitmap migration test
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
 <1479837270-79005-17-git-send-email-vsementsov@virtuozzo.com>
 <59237595-78d7-5aa2-c38a-d986564b5ed0@redhat.com>
 <e25c6fb7-0d1f-a91a-9680-e206f6db2cd8@virtuozzo.com>
 <99233c16-4881-2fca-77f7-5cb7633d0f83@virtuozzo.com>
In-Reply-To: <99233c16-4881-2fca-77f7-5cb7633d0f83@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 12:08, Vladimir Sementsov-Ogievskiy wrote:
> 03.02.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>> 02.02.2017 02:12, Max Reitz wrote:
>>> On 22.11.2016 18:54, Vladimir Sementsov-Ogievskiy wrote:
>>>> The test starts two vms (vm_a, vm_b), create dirty bitmap in
>>>> the first one, do several writes to corresponding device and
>>>> then migrate vm_a to vm_b with dirty bitmaps.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> ---
>>>>   tests/qemu-iotests/169     | 86
>>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>>   tests/qemu-iotests/169.out |  5 +++
>>>>   tests/qemu-iotests/group   |  1 +
>>>>   3 files changed, 92 insertions(+)
>>>>   create mode 100755 tests/qemu-iotests/169
>>>>   create mode 100644 tests/qemu-iotests/169.out
>>>>
>>>> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
>>>> new file mode 100755
>>>> index 0000000..58b1ab1
>>>> --- /dev/null
>>>> +++ b/tests/qemu-iotests/169
>>>> @@ -0,0 +1,86 @@
>>>> +#!/usr/bin/env python
>>>> +#
>>>> +# Tests for dirty bitmaps migration.
>>>> +#
>>>> +# Copyright (C) Vladimir Sementsov-Ogievskiy 2015-2016
>>>> +#
>>>> +# This program is free software; you can redistribute it and/or mod=
ify
>>>> +# it under the terms of the GNU General Public License as published=
 by
>>>> +# the Free Software Foundation; either version 2 of the License, or=

>>>> +# (at your option) any later version.
>>>> +#
>>>> +# This program is distributed in the hope that it will be useful,
>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> +# GNU General Public License for more details.
>>>> +#
>>>> +# You should have received a copy of the GNU General Public License=

>>>> +# along with this program.  If not, see
>>>> <http://www.gnu.org/licenses/>.
>>>> +#
>>>> +
>>>> +import os
>>>> +import iotests
>>>> +import time
>>>> +from iotests import qemu_img
>>>> +
>>>> +disk_a =3D os.path.join(iotests.test_dir, 'disk_a')
>>>> +disk_b =3D os.path.join(iotests.test_dir, 'disk_b')
>>>> +fifo =3D os.path.join(iotests.test_dir, 'mig_fifo')
>>>> +
>>>> +class TestDirtyBitmapMigration(iotests.QMPTestCase):
>>>> +
>>>> +    def setUp(self):
>>>> +        size =3D 0x400000000 # 1G
>>> I can already see someone on macOS complaining that this test eats th=
eir
>>> hard drive when running it for raw images... But we can still amend i=
t
>>> once somebody complains. O:-)
>>>
>>> I think 1 GB is not overly large, but it's reasonable to use such a
>>> rather large value for this test.
>>>
>>>> +        os.mkfifo(fifo)
>>>> +        qemu_img('create', '-f', iotests.imgfmt, disk_a, str(size))=

>>>> +        qemu_img('create', '-f', iotests.imgfmt, disk_b, str(size))=

>>>> +        self.vm_a =3D iotests.VM(path_suffix=3D'a').add_drive(disk_=
a)
>>>> +        self.vm_b =3D iotests.VM(path_suffix=3D'b').add_drive(disk_=
b)
>>>> +        self.vm_b.add_incoming_migration("exec: cat " + fifo)
>>> I guess this will break if the path contains white space. Is there
>>> something we can do about that?
>>>
>>> (You don't need to protect against quotes or something, just white
>>> space.)
>>>
>>>> +        self.vm_a.launch()
>>>> +        self.vm_b.launch()
>>>> +
>>>> +    def tearDown(self):
>>>> +        self.vm_a.shutdown()
>>>> +        self.vm_b.shutdown()
>>>> +        os.remove(disk_a)
>>>> +        os.remove(disk_b)
>>>> +        os.remove(fifo)
>>>> +
>>>> +    def test_migration(self):
>>>> +        granularity =3D 512
>>>> +        regions =3D [
>>>> +            { 'start': 0,           'count': 0x100000 },
>>>> +            { 'start': 0x100000000, 'count': 0x200000  },
>>>> +            { 'start': 0x399900000, 'count': 0x100000  }
>>>> +            ]
>>>> +
>>>> +        result =3D self.vm_a.qmp('block-dirty-bitmap-add',
>>>> node=3D'drive0',
>>>> +                               name=3D'bitmap', granularity=3Dgranu=
larity)
>>>> +        self.assert_qmp(result, 'return', {});
>>>> +
>>>> +        for r in regions:
>>>> +          self.vm_a.hmp_qemu_io('drive0',
>>> This line isn't aligned to four spaces.
>>>
>>> With that fixed, and if you deem fixing the white space issue too
>>> complicated:
>>
>> may be, just add quotes, like
>>
>> self.vm_b.add_incoming_migration("exec: cat '" + fifo + "'")
>>
>>
>> ?
>=20
> looks like ./check doesn't work with spaces anyway:
>=20
> [root@kvm qemu-iotests]# ./check -qcow2 -nocache 169
> QEMU          -- "/work/src/post
> copy/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
> -nodefaults -machine accel=3Dqtest
> QEMU_IMG      -- "/work/src/post copy/tests/qemu-iotests/../../qemu-img=
"
> QEMU_IO       -- "/work/src/post copy/tests/qemu-iotests/../../qemu-io"=
=20
> -f qcow2 --cache none
> QEMU_NBD      -- "/work/src/post copy/tests/qemu-iotests/../../qemu-nbd=
"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 kvm 3.10.0-327.36.1.vz7.20.9
> TEST_DIR      -- /work/src/post copy/tests/qemu-iotests/scratch
> SOCKET_SCM_HELPER -- /work/src/post
> copy/tests/qemu-iotests/socket_scm_helper
>=20
> 169 33s ..../check: line 306: $tmp.out: ambiguous redirect
>  [failed, exit status 1] - output mismatch (see 169.out.bad)
> mv: target '169.out.bad' is not a directory
> diff: 169.out.bad: No such file or directory
> ./check: line 158: [: too many arguments
> ./check: line 171: [: /work/src/post: binary operator expected
> Failures: 169
> Failed 1 of 1 tests
> [root@kvm qemu-iotests]# pwd
> /work/src/post copy/tests/qemu-iotests

Hm, too bad. I remember someone once fixing everything, but apparently
it broke again...

Nonetheless, I'd rather not introduce new issues into newly added code.
Perhaps some day someone can once again fix all of the current issues...

Max


--vctCcIKLTXVNNlJwoCVKarirPbxEMV24i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU1P0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATKsIAKC9TJndDVSJxN90b8ndxNQhAzZPtY65
3f1DPiAwT+MoIeblySDkprBKW5XfJ0Q7X+nR+674MyZfrefP2lLLgRxNcJduN9aF
FVdA1iMnDR7fExUb+LV4joCv4JT4QgyC700uQOv0/uB6KZXix+TYTSBES4BuAKb0
XYNc7dIi6q5K+GaLjLTY7Wsci6PuD+9ZWQVQ9hggDy++YXcwkZBcNl9AXQ+I3WRr
In0vKQ1myjs9G2ZLOoQjvLTJ40fddweTAAjqYXt+zGIe0c00TJQ1F98pIHKkBUUv
T/ukrI10uuV/keNMuqVfAZt0kneJhFDB07RIqcxvNDCyqp3b9kwBIXE=
=sQ2h
-----END PGP SIGNATURE-----

--vctCcIKLTXVNNlJwoCVKarirPbxEMV24i--
