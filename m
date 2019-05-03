Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B814C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05572070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05572070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYjw-0007Mu-3Y
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 10:00:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMYj5-0006Ut-6t
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMYj3-0007Gt-N3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:59:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hMYj0-0007Ch-Ao; Fri, 03 May 2019 09:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FF57461CD;
	Fri,  3 May 2019 13:59:40 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-131.brq.redhat.com
	[10.40.204.131])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B710600C7;
	Fri,  3 May 2019 13:59:36 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-2-vsementsov@virtuozzo.com>
	<fe340a80-f918-7999-fb75-4b129162bd89@redhat.com>
	<8e928f60-f2b2-6e05-bf16-5578941bfd8b@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
	mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
	/PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
	U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
	mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
	awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
	AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
	CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
	B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
	2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
	AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
	8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
	4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
	BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
	xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
	W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
	DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
	64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
	ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
	sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
	alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
	/ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
	bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
	R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <3f55b80e-407d-622b-f1cd-3922ef32680b@redhat.com>
Date: Fri, 3 May 2019 15:59:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8e928f60-f2b2-6e05-bf16-5578941bfd8b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pg6sDRKFIS3Ja5VBCRxfyGnhGhzuUK2uU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 03 May 2019 13:59:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v5 01/10] tests/perf: Test qemu-img convert
 from raw to encrypted qcow2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503135934.5xL4txMC_LoLHy6QBGHxND0kjR_PUcL6hwfTVoWCMkc@z>

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

