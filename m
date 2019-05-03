Received: from eggs.gnu.org ([209.51.188.92]:40111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMYj5-0006Ut-6t
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMYj3-0007Gt-N3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:59:47 -0400
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-2-vsementsov@virtuozzo.com>
	<fe340a80-f918-7999-fb75-4b129162bd89@redhat.com>
	<8e928f60-f2b2-6e05-bf16-5578941bfd8b@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3f55b80e-407d-622b-f1cd-3922ef32680b@redhat.com>
Date: Fri, 3 May 2019 15:59:34 +0200
MIME-Version: 1.0
In-Reply-To: <8e928f60-f2b2-6e05-bf16-5578941bfd8b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pg6sDRKFIS3Ja5VBCRxfyGnhGhzuUK2uU"
Subject: Re: [Qemu-devel] [PATCH v5 01/10] tests/perf: Test qemu-img convert
 from raw to encrypted qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berrange@redhat.com" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pg6sDRKFIS3Ja5VBCRxfyGnhGhzuUK2uU
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com"
 <berto@igalia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "berrange@redhat.com" <berrange@redhat.com>
Message-ID: <3f55b80e-407d-622b-f1cd-3922ef32680b@redhat.com>
Subject: Re: [PATCH v5 01/10] tests/perf: Test qemu-img convert from raw to
 encrypted qcow2
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
 <20190402153730.54145-2-vsementsov@virtuozzo.com>
 <fe340a80-f918-7999-fb75-4b129162bd89@redhat.com>
 <8e928f60-f2b2-6e05-bf16-5578941bfd8b@virtuozzo.com>
In-Reply-To: <8e928f60-f2b2-6e05-bf16-5578941bfd8b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.04.19 10:53, Vladimir Sementsov-Ogievskiy wrote:
> 29.04.2019 1:55, Max Reitz wrote:
>> On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   tests/perf/block/qcow2/convert-to-encrypted | 48 ++++++++++++++++++=
+++
>>>   1 file changed, 48 insertions(+)
>>>   create mode 100755 tests/perf/block/qcow2/convert-to-encrypted
>>
>> Thanks for the test case, but I don=E2=80=99t know whether this is the=
 right way
>> to include it.
>>
>> A concrete problem is that it doesn=E2=80=99t work with out-of-tree bu=
ilds (I
>> only do out-of-tree builds).  I wonder whether it would be possible an=
d
>> make sense (I have no idea) to add a subdirectory "perf" to the iotest=
s
>> and reuse its infrastructure?  Those tests wouldn=E2=80=99t run by def=
ault.
>>
>=20
> Honestly, I don't really like existing iotests infrastructure, bound to=
 check
> script, which I don't like too (and any other large script in bash, sor=
ry :(..

Hm, OK.  It would need some modifications, because it=E2=80=99d need to a=
ccept
non-numeric test names, and for perf tests, it probably shouldn=E2=80=99t=

compare against a reference output.  But I don=E2=80=99t like bash either=
, and
that doesn=E2=80=99t sound impossible to me.

> What do you mean? You have env variables QEMU_IMG, etc, and want them t=
o be
> accepted by script?

That would work, although it=E2=80=99d be cumbersome.  As for check, you =
just
run it from the build tree, so it auto-detects the binaries.

> I'd prefer to commit something simple and separate, to be able to build=
 up
> infrastructure around it gradually..

Well, I=E2=80=99d prefer something that works.  I=E2=80=99d also very muc=
h prefer
something that is not separate, because that=E2=80=99s just adding comple=
xity
for no good reason.  I don=E2=80=99t see how new infrastructure that work=
s can
be simple.

There are Avocado tests, maybe you prefer using that.

> Finally, I want a simple way to run
> a set of perf tests on a set of git commits and get an html and ascii
> tables of performance comparison between these commits.

That doesn=E2=80=99t sound very simple to me, implementation-wise.  It do=
esn=E2=80=99t
sound overly complicated either, it sounds useful =E2=80=93 but throwing =
out
check now because you say you just need something simple, and then
intending to make it not-so-simple later makes me raise my eyebrows.

I mean, feel free to rewrite the check script in Python, but having two
separate test infrastructures feels like a bit of waste to me.

(And you don=E2=80=99t have to add these new features like comparison of
performance results between commits to the check script, I think.  For
instance, you can write a wrapper script in e.g. Python or whatever that
just calls check to run the test and then processes the test result
itself.  I don=E2=80=99t want to force you to write more bash code, nobod=
y wants
that, I just think that check works fine as a test launcher.)

Max

>>> diff --git a/tests/perf/block/qcow2/convert-to-encrypted b/tests/perf=
/block/qcow2/convert-to-encrypted
>>> new file mode 100755
>>> index 0000000000..7a6b7b1cab
>>> --- /dev/null
>>> +++ b/tests/perf/block/qcow2/convert-to-encrypted
>>> @@ -0,0 +1,48 @@
>>> +#!/bin/bash
>>> +#
>>> +# Test qemu-img convert from raw to encrypted qcow2
>>> +#
>>> +# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserv=
ed.
>>> +#
>>> +# This program is free software; you can redistribute it and/or modi=
fy
>>> +# it under the terms of the GNU General Public License as published =
by
>>> +# the Free Software Foundation; either version 2 of the License, or
>>> +# (at your option) any later version.
>>> +#
>>> +# This program is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +# GNU General Public License for more details.
>>> +#
>>> +# You should have received a copy of the GNU General Public License
>>> +# along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
>>> +#
>>> +
>>> +if [ "$#" -lt 2 ]; then
>>> +    echo "Usage: $0 SOURCE_FILE DESTINATION_FILE [additional qemu-im=
g convert parameters]"
>>> +    exit 1
>>> +fi
>>> +
>>> +ROOT_DIR=3D"$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../../.." >/d=
ev/null 2>&1 && pwd )"
>>> +QEMU_IMG=3D"$ROOT_DIR/qemu-img"
>>> +QEMU_IO=3D"$ROOT_DIR/qemu-io"
>>> +
>>> +size=3D1G
>>> +
>>> +src=3D"$1"
>>> +shift
>>> +
>>> +dst=3D"$1"
>>> +shift
>>> +
>>> +(
>>> +# create source
>>> +$QEMU_IMG create -f raw "$src" $size
>>> +$QEMU_IO -f raw -c "write -P 0xa 0 $size" "$src"
>>> +
>>> +# create target
>>> +$QEMU_IMG create -f qcow2 --object secret,id=3Dsec0,data=3Dtest -o e=
ncrypt.format=3Dluks,encrypt.key-secret=3Dsec0 "$dst" $size
>>> +) > /dev/null
>>> +
>>> +# test with additional parameters left in $@
>>> +/usr/bin/time -f %e $QEMU_IMG convert "$@" -f raw --object secret,id=
=3Dsec0,data=3Dtest --target-image-opts -n "$src" "driver=3Dqcow2,file.fi=
lename=3D$dst,encrypt.key-secret=3Dsec0"
>>>
>>
>>
>=20
>=20



--pg6sDRKFIS3Ja5VBCRxfyGnhGhzuUK2uU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzMSUYACgkQ9AfbAGHV
z0D9yAf/coWzvOWz3qn47PBh5PMA2BrTBWdab6cS6UTpjCvKXmui/AWMEu5qIGRm
rZ0Ohnv5dYa0tX7dj93cKmCk+8hKrmMD+SZB13CmpeC/5Ctu+ztICnmB0oUL6527
5orrpo/1FAqImPcRwF8x7jiIdvIRWkdzQrc+0AUfd1p7GXMFuYzayL3pBTlHZg/p
2qi9SpAmsL72J36eJW7F2zz9mUAEWEAL15/iGo7pe7qz8IGUutznbWyoMjbLMH8l
8yngPqHO0oayJL1ATMQeiPixqohVzxouUQR4v7a2Av7znEQeg073pnkJLP5I7J6s
CbYw6mtRQ4Vw8OUAOhyXewJe7NjEaw==
=JuLY
-----END PGP SIGNATURE-----

--pg6sDRKFIS3Ja5VBCRxfyGnhGhzuUK2uU--
