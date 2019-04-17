Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBF8C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E630720835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E630720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56485 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGnf5-0007k7-8f
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 12:43:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGne8-0007HA-P5
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGne6-0001BE-PS
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hGne1-00016M-B5; Wed, 17 Apr 2019 12:42:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 441383001572;
	Wed, 17 Apr 2019 16:42:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-140.brq.redhat.com
	[10.40.204.140])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A5435C224;
	Wed, 17 Apr 2019 16:42:42 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-7-mreitz@redhat.com>
	<e38792c2-dec4-0d05-4463-2efcfd5d968f@virtuozzo.com>
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
Message-ID: <78523ece-a4a1-753c-c04d-81126cb8315b@redhat.com>
Date: Wed, 17 Apr 2019 18:42:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e38792c2-dec4-0d05-4463-2efcfd5d968f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pjkPxzQBTVXCgKrASNE2BALT8xmuGtPK2"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 17 Apr 2019 16:42:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 6/7] iotests: Test qemu-img convert
 --salvage
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417164240.InL6FrCoq9niLLiY1lZ1YimGRLtYwZiKuGvOEC7s0pA@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pjkPxzQBTVXCgKrASNE2BALT8xmuGtPK2
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <78523ece-a4a1-753c-c04d-81126cb8315b@redhat.com>
Subject: Re: [PATCH v3 6/7] iotests: Test qemu-img convert --salvage
References: <20190413165343.9018-1-mreitz@redhat.com>
 <20190413165343.9018-7-mreitz@redhat.com>
 <e38792c2-dec4-0d05-4463-2efcfd5d968f@virtuozzo.com>
In-Reply-To: <e38792c2-dec4-0d05-4463-2efcfd5d968f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.04.19 10:02, Vladimir Sementsov-Ogievskiy wrote:
> 13.04.2019 19:53, Max Reitz wrote:
>> This test converts a simple image to another, but blkdebug injects
>> block_status and read faults at some offsets.  The resulting image
>> should be the same as the input image, except that sectors that could
>> not be read have to be 0.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/249     | 163 +++++++++++++++++++++++++++++++++++=
++
>>   tests/qemu-iotests/249.out |  43 ++++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 207 insertions(+)
>>   create mode 100755 tests/qemu-iotests/249
>>   create mode 100644 tests/qemu-iotests/249.out
>>
>> diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
>> new file mode 100755
>> index 0000000000..d3883d75f3
>> --- /dev/null
>> +++ b/tests/qemu-iotests/249
>> @@ -0,0 +1,163 @@
>> +#!/bin/bash
>> +#
>> +# Test qemu-img convert --salvage
>> +#
>> +# Copyright (C) 2018 Red Hat, Inc.
>=20
> 2019
>=20
>> +#
>> +# This program is free software; you can redistribute it and/or modif=
y
>> +# it under the terms of the GNU General Public License as published b=
y
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
>> +#
>> +
>> +# creator
>> +owner=3Dmreitz@redhat.com
>> +
>> +seq=3D$(basename $0)
>> +echo "QA output created by $seq"
>> +
>> +here=3D$PWD
>=20
> this variable is not defined in latest bash-based iotests, is it needed=
 really?

Hm, no, it=E2=80=99s just here to remind me that this test really is from=
 2018. :-)

>> +status=3D1	# failure is the default!
>> +
>> +_cleanup()
>> +{
>> +    _cleanup_test_img
>=20
> as I understand, you also need to remove source img which is $TEST_IMG.=
orig

That=E2=80=99s done automatically by _cleanup_test_img().

(It removes $TEST_IMG, $TEST_IMG.orig, and $TEST_IMG.base.)

>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +# get standard environment, filters and checks
>> +. ./common.rc
>> +. ./common.filter
>> +. ./common.qemu
>> +
>> +_supported_fmt generic
>> +_supported_proto file
>> +_supported_os Linux
>> +
>> +
>> +TEST_IMG=3D"$TEST_IMG.orig" _make_test_img 64M
>> +
>> +$QEMU_IO -c 'write -P 42 0 64M' "$TEST_IMG.orig" | _filter_qemu_io
>> +
>> +
>> +sector_size=3D512
>> +
>> +# Offsets on which to fail block-status.  Keep in ascending order so
>> +# the indexing done by _filter_offsets will appear in ascending order=

>> +# in the output as well.
>> +status_fail_offsets=3D"$((16 * 1024 * 1024 + 8192))
>> +                     $((33 * 1024 * 1024 + 512))"
>> +
>> +# Offsets on which to fail reads.  Keep in ascending order for the
>> +# same reason.
>> +# Element 1 is shared with $status_fail_offsets on purpose.
>=20
> you mean element 2
>=20
>> +# Elements 2 and later test what happens when a continuous range of
>=20
> and 3..
>=20
> ah no, you just counting from zero..

Of course I am. :-)

I can rewrite the comment to "The second element" and "Starting with the
third element, we test...".

>> +# sectors is inaccessible.
>> +read_fail_offsets=3D"$((32 * 1024 * 1024 - 65536))
>> +                   $((33 * 1024 * 1024 + 512))
>> +                   $(seq $((34 * 1024 * 1024)) $sector_size \
>> +                         $((34 * 1024 * 1024 + 4096 - $sector_size)))=
"
>> +
>> +
>> +# blkdebug must be above the format layer so it can intercept all
>> +# block-status events
>> +source_img=3D"json:{'driver': 'blkdebug',
>> +                  'image': {
>> +                      'driver': '$IMGFMT',
>> +                      'file': {
>> +                          'driver': 'file',
>> +                          'filename': '$TEST_IMG.orig'
>> +                      }
>> +                  },
>> +                  'inject-error': ["
>> +
>> +for ofs in $status_fail_offsets
>> +do
>> +    source_img+=3D"{ 'event': 'none',
>=20
> idea: may be make @event optional with default of 'none'?

I don=E2=80=99t know whether that makes sense.  'none' is a special case,=
 so my
personal feeling is not to make it the default.

>> +                   'iotype': 'block-status',
>> +                   'errno': 5,
>> +                   'sector': $((ofs / sector_size)) },"
>> +done
>> +
>> +for ofs in $read_fail_offsets
>> +do
>> +    source_img+=3D"{ 'event': 'none',
>> +                   'iotype': 'read',
>> +                   'errno': 5,
>> +                   'sector': $((ofs / sector_size)) },"
>> +done
>> +
>> +# Remove the trailing comma and terminate @inject-error and json:{}
>> +source_img=3D"${source_img%,} ] }"
>> +
>> +
>> +echo
>> +
>> +
>> +_filter_offsets() {
>=20
> why to filter them? They are constant..

So the reference output actually tells you what=E2=80=99s happening.

I personally don=E2=80=99t like reference outputs that are full of number=
s which
I have a hard time associating with anything meaningful.  This function
here does it for me.

Max

>> +    filters=3D
>> +
>> +    index=3D0
>> +    for ofs in $2
>> +    do
>> +        filters+=3D" -e s/$(printf "$1" $ofs)/status_fail_offset_$ind=
ex/"
>> +        index=3D$((index + 1))
>> +    done
>> +
>> +    index=3D0
>> +    for ofs in $3
>> +    do
>> +        filters+=3D" -e s/$(printf "$1" $ofs)/read_fail_offset_$index=
/"
>> +        index=3D$((index + 1))
>> +    done
>> +
>> +    sed $filters
>> +}
>> +
>> +# While determining the number of allocated sectors in the input
>> +# image, we should see one block status warning per element of
>> +# $status_fail_offsets.
>> +#
>> +# Then, the image is read.  Since the block status is queried in
>> +# basically the same way, the same warnings as in the previous step
>> +# should reappear.  Interleaved with those we should see a read
>> +# warning per element of $read_fail_offsets.
>> +# Note that $read_fail_offsets and $status_fail_offsets share an
>> +# element (read_fail_offset_1 =3D=3D status_fail_offset_1), so
>> +# "status_fail_offset_1" in the output is the same as
>> +# "read_fail_offset_1".
>> +$QEMU_IMG convert --salvage "$source_img" "$TEST_IMG" 2>&1 \
>> +    | _filter_offsets '%i' "$status_fail_offsets" "$read_fail_offsets=
"
>> +
>> +echo
>> +
>> +# The offsets where the block status could not be determined should
>> +# have been treated as containing data and thus should be correct in
>> +# the output image.
>> +# The offsets where reading failed altogether should be 0.  Make them=

>> +# 0 in the input image, too, so we can compare both images.
>> +for ofs in $read_fail_offsets
>> +do
>> +    $QEMU_IO -c "write -z $ofs $sector_size" "$TEST_IMG.orig" \
>> +        | _filter_qemu_io \
>> +        | _filter_offsets '%i' '' "$read_fail_offsets"
>> +done
>> +
>> +echo
>> +
>> +# These should be equal now.
>> +$QEMU_IMG compare "$TEST_IMG.orig" "$TEST_IMG"
>> +
>> +
>> +# success, all done
>> +echo "*** done"
>> +rm -f $seq.full
>> +status=3D0
>> diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
>> new file mode 100644
>> index 0000000000..9213d3e450
>> --- /dev/null
>> +++ b/tests/qemu-iotests/249.out
>> @@ -0,0 +1,43 @@
>> +QA output created by 249
>> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D67108864
>> +wrote 67108864/67108864 bytes at offset 0
>> +64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +
>> +qemu-img: warning: error while reading block status at offset status_=
fail_offset_0: Input/output error
>> +qemu-img: warning: error while reading block status at offset status_=
fail_offset_1: Input/output error
>> +qemu-img: warning: error while reading block status at offset status_=
fail_offset_0: Input/output error
>> +qemu-img: warning: error while reading offset read_fail_offset_0: Inp=
ut/output error
>> +qemu-img: warning: error while reading block status at offset status_=
fail_offset_1: Input/output error
>> +qemu-img: warning: error while reading offset status_fail_offset_1: I=
nput/output error
>> +qemu-img: warning: error while reading offset read_fail_offset_2: Inp=
ut/output error
>> +qemu-img: warning: error while reading offset read_fail_offset_3: Inp=
ut/output error
>> +qemu-img: warning: error while reading offset read_fail_offset_4: Inp=
ut/output error
>> +qemu-img: warning: error while reading offset read_fail_offset_5: Inp=
ut/output error
>> +qemu-img: warning: error while reading offset read_fail_offset_6: Inp=
ut/output error
>> +qemu-img: warning: error while reading offset read_fail_offset_7: Inp=
ut/output error
>> +qemu-img: warning: error while reading offset read_fail_offset_8: Inp=
ut/output error
>> +qemu-img: warning: error while reading offset read_fail_offset_9: Inp=
ut/output error
>> +
>> +wrote 512/512 bytes at offset read_fail_offset_0
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset read_fail_offset_1
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset read_fail_offset_2
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset read_fail_offset_3
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset read_fail_offset_4
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset read_fail_offset_5
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset read_fail_offset_6
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset read_fail_offset_7
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset read_fail_offset_8
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +wrote 512/512 bytes at offset read_fail_offset_9
>> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +
>> +Images are identical.
>> +*** done
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index bae7718380..a2e2f507e8 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -248,3 +248,4 @@
>>   246 rw auto quick
>>   247 rw auto quick
>>   248 rw auto quick
>> +249 auto quick
>>
>=20
>=20



--pjkPxzQBTVXCgKrASNE2BALT8xmuGtPK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3V4AACgkQ9AfbAGHV
z0ClWQf8C4ehfH1Gn+Dkc5Pi27Z4d5Ej12wTX1Tb351SRUWDdIoBwO76F7Sp9JtU
jvfsUPmB74WlD3mC5rFgd9k5o9HHmMMy7gpclIyfumvNG5/eE5W6T3AzBq8Vvouo
7fEloMygdCgvR31GyQakZzJR0/9LnM9FU/Zj6wFplHJY+tX2hI4/SSkg7cW9YumD
7Pqm6x0oJFLayuIFElwcE4LB1wzd2utXZbyiCBcy3PpxIjOCy37jQ5JJTB23fiVn
VBmrEtzPJVygm7hlAVtqEIhhscOYiYT6ArcG5eT8GHuC1YpvYj2dgJOYcnG3pkJn
MwmBmK9ftxsIPtxfg0/OiyeCa0FhIw==
=CEvv
-----END PGP SIGNATURE-----

--pjkPxzQBTVXCgKrASNE2BALT8xmuGtPK2--

