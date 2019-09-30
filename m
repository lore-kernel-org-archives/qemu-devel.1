Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A27FC35280
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E142086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E142086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEw2J-0006y5-IJ
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iEvye-0005AS-Qr
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iEvyd-0008JN-KK
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:44:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iEvya-0008HS-LF; Mon, 30 Sep 2019 09:44:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9640318C4273;
 Mon, 30 Sep 2019 13:44:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D23C60623;
 Mon, 30 Sep 2019 13:44:30 +0000 (UTC)
Subject: Re: [PATCH 01/18] iotests: Filter refcount_order in 036
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-2-mreitz@redhat.com>
 <f8db846b4dba5cd8febc09e871a932c7999f5403.camel@redhat.com>
 <d10fef7d-502a-d8c9-c548-bb6088d16c69@redhat.com>
 <4b3bea45194528716499d1624cdefa6cd3a56806.camel@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <5e39c90a-1e78-6c07-e03b-cef23f566227@redhat.com>
Date: Mon, 30 Sep 2019 15:44:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <4b3bea45194528716499d1624cdefa6cd3a56806.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="knbU0mxTz8SAS5YlbPZqkQAYTTuVFizsL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 30 Sep 2019 13:44:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--knbU0mxTz8SAS5YlbPZqkQAYTTuVFizsL
Content-Type: multipart/mixed; boundary="Lo7oLgElyf6mg1RwUaILHnIKPqMRXFGuy"

--Lo7oLgElyf6mg1RwUaILHnIKPqMRXFGuy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.09.19 15:40, Maxim Levitsky wrote:
> On Mon, 2019-09-30 at 14:43 +0200, Max Reitz wrote:
>> On 29.09.19 18:31, Maxim Levitsky wrote:
>>> On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
>>>> This test can run just fine with other values for refcount_bits, so =
we
>>>> should filter the value from qcow2.py's dump-header.
>>>>
>>>> (036 currently ignores user-specified image options, but that will b=
e
>>>> fixed in the next patch.)
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/036     | 9 ++++++---
>>>>  tests/qemu-iotests/036.out | 6 +++---
>>>>  2 files changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
>>>> index f06ff67408..69d0f9f903 100755
>>>> --- a/tests/qemu-iotests/036
>>>> +++ b/tests/qemu-iotests/036
>>>> @@ -55,7 +55,8 @@ $PYTHON qcow2.py "$TEST_IMG" set-feature-bit incom=
patible 63
>>>> =20
>>>>  # Without feature table
>>>>  $PYTHON qcow2.py "$TEST_IMG" del-header-ext 0x6803f857
>>>> -$PYTHON qcow2.py "$TEST_IMG" dump-header
>>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header \
>>>> +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
>>>>  _img_info
>>>> =20
>>>>  # With feature table containing bit 63
>>>> @@ -103,14 +104,16 @@ echo =3D=3D=3D Create image with unknown autoc=
lear feature bit =3D=3D=3D
>>>>  echo
>>>>  _make_test_img 64M
>>>>  $PYTHON qcow2.py "$TEST_IMG" set-feature-bit autoclear 63
>>>> -$PYTHON qcow2.py "$TEST_IMG" dump-header
>>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header \
>>>> +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
>>>> =20
>>>>  echo
>>>>  echo =3D=3D=3D Repair image =3D=3D=3D
>>>>  echo
>>>>  _check_test_img -r all
>>>> =20
>>>> -$PYTHON qcow2.py "$TEST_IMG" dump-header
>>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header \
>>>> +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
>>>> =20
>>>>  # success, all done
>>>>  echo "*** done"
>>>> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out=

>>>> index e489b44386..998c2a8a35 100644
>>>> --- a/tests/qemu-iotests/036.out
>>>> +++ b/tests/qemu-iotests/036.out
>>>> @@ -19,7 +19,7 @@ snapshot_offset           0x0
>>>>  incompatible_features     0x8000000000000000
>>>>  compatible_features       0x0
>>>>  autoclear_features        0x0
>>>> -refcount_order            4
>>>> +refcount_order            (filtered)
>>>>  header_length             104
>>>> =20
>>>>  qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT fe=
ature(s): Unknown incompatible feature: 8000000000000000
>>>> @@ -53,7 +53,7 @@ snapshot_offset           0x0
>>>>  incompatible_features     0x0
>>>>  compatible_features       0x0
>>>>  autoclear_features        0x8000000000000000
>>>> -refcount_order            4
>>>> +refcount_order            (filtered)
>>>>  header_length             104
>>>> =20
>>>>  Header extension:
>>>> @@ -81,7 +81,7 @@ snapshot_offset           0x0
>>>>  incompatible_features     0x0
>>>>  compatible_features       0x0
>>>>  autoclear_features        0x0
>>>> -refcount_order            4
>>>> +refcount_order            (filtered)
>>>>  header_length             104
>>>> =20
>>>>  Header extension:
>>>
>>> Minor notes:
>>>
>>> 1. Maybe put the sed command into a function to avoid duplication?
>>
>> Hm, maybe, but that would increase the LoC, so I=E2=80=99m not sure wh=
ether it
>> really would be a simplification.
> IMHO, in my opinion, regardless of LOC, duplicated code is almost alway=
s
> bad. Common functions are mostly for the next guy that will be able to =
use
> them instead of searching through code to see how this is done there an=
d there.

In my experience, people write tests without scanning common.filter for
whether anyone has written the same code already.  See the
_filter_qemu_img_check example in this series.

>>
>>> 2. As I understand the test, it only checks the feature bits.
>>>    So maybe instead of blacklisting some of the values, white list
>>>    only the feature bits in the output?
>>
>> Hm.  Seems reasonable, but then again I=E2=80=99d prefer a minimal cha=
nge, and
>> changing it to a whitelist would be more change...
> I don't think this is bad, again in my eyes, the code should be as frie=
ndly
> as possible for the next guy that will have to change it, so adding
> some more extra changes don't seem a problem to me.

In my eyes tests aren=E2=80=99t code.

Max

> Of course this is only my personal option and each approach has its own=
 cons,
> and pros. This doesn't matter that much to me.
>=20
> Best regards,
> 	Maxim Levitsky
>=20



--Lo7oLgElyf6mg1RwUaILHnIKPqMRXFGuy--

--knbU0mxTz8SAS5YlbPZqkQAYTTuVFizsL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2SBrwACgkQ9AfbAGHV
z0DKRwgAizBoq4ira4WHr9pDzUSrOo9rwe6o8j19aV/szqOMHYgvfMHi1IInRISv
o1HM3nln9mDNv+hIzE1g+v40y1reRlqGd2TdYjPqGIZ9/k6KMlbcZzQ9VWzIj4ga
VNnjlXmEY+HgwBCrsN4KzSLJs2K7PS1YxjO7VpVEB0ZIs3aTqa3q3mHoxloCT445
VW9ddZtb+i+owL2X+eSiVaUEjSrNBzy6uutRr0XgDNxQWzE9Qt5u8ro2CzjiW6DL
bXE9FJJ9RfAhRmDH3mEUkrGHwWo3aCCohrFiL9DPSbRq3IpTvvJbQP2H+c0IKA2C
zdWZ2NFAM1rkcSJekhJWqJxBQbgzhA==
=eMP+
-----END PGP SIGNATURE-----

--knbU0mxTz8SAS5YlbPZqkQAYTTuVFizsL--

