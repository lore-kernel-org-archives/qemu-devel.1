Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88755C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C812075D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 12:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C812075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEv5c-0002L7-Jm
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 08:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iEv24-0000sJ-FO
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iEv23-0008QD-9r
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iEv1z-0008MK-8Z; Mon, 30 Sep 2019 08:43:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5ABCE86662;
 Mon, 30 Sep 2019 12:43:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3063961559;
 Mon, 30 Sep 2019 12:43:55 +0000 (UTC)
Subject: Re: [PATCH 01/18] iotests: Filter refcount_order in 036
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-2-mreitz@redhat.com>
 <f8db846b4dba5cd8febc09e871a932c7999f5403.camel@redhat.com>
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
Message-ID: <d10fef7d-502a-d8c9-c548-bb6088d16c69@redhat.com>
Date: Mon, 30 Sep 2019 14:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <f8db846b4dba5cd8febc09e871a932c7999f5403.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GgKJa0AHikzukbBjuwsmsq8sLtc8QVajK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 30 Sep 2019 12:43:57 +0000 (UTC)
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
--GgKJa0AHikzukbBjuwsmsq8sLtc8QVajK
Content-Type: multipart/mixed; boundary="STL05H4zEDg0zfy4qfkgEE5fMRihzzSeO"

--STL05H4zEDg0zfy4qfkgEE5fMRihzzSeO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.09.19 18:31, Maxim Levitsky wrote:
> On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
>> This test can run just fine with other values for refcount_bits, so we=

>> should filter the value from qcow2.py's dump-header.
>>
>> (036 currently ignores user-specified image options, but that will be
>> fixed in the next patch.)
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/036     | 9 ++++++---
>>  tests/qemu-iotests/036.out | 6 +++---
>>  2 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
>> index f06ff67408..69d0f9f903 100755
>> --- a/tests/qemu-iotests/036
>> +++ b/tests/qemu-iotests/036
>> @@ -55,7 +55,8 @@ $PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompa=
tible 63
>> =20
>>  # Without feature table
>>  $PYTHON qcow2.py "$TEST_IMG" del-header-ext 0x6803f857
>> -$PYTHON qcow2.py "$TEST_IMG" dump-header
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header \
>> +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
>>  _img_info
>> =20
>>  # With feature table containing bit 63
>> @@ -103,14 +104,16 @@ echo =3D=3D=3D Create image with unknown autocle=
ar feature bit =3D=3D=3D
>>  echo
>>  _make_test_img 64M
>>  $PYTHON qcow2.py "$TEST_IMG" set-feature-bit autoclear 63
>> -$PYTHON qcow2.py "$TEST_IMG" dump-header
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header \
>> +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
>> =20
>>  echo
>>  echo =3D=3D=3D Repair image =3D=3D=3D
>>  echo
>>  _check_test_img -r all
>> =20
>> -$PYTHON qcow2.py "$TEST_IMG" dump-header
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header \
>> +    | sed -e 's/^\(refcount_order\s*\).*/\1(filtered)/'
>> =20
>>  # success, all done
>>  echo "*** done"
>> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
>> index e489b44386..998c2a8a35 100644
>> --- a/tests/qemu-iotests/036.out
>> +++ b/tests/qemu-iotests/036.out
>> @@ -19,7 +19,7 @@ snapshot_offset           0x0
>>  incompatible_features     0x8000000000000000
>>  compatible_features       0x0
>>  autoclear_features        0x0
>> -refcount_order            4
>> +refcount_order            (filtered)
>>  header_length             104
>> =20
>>  qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feat=
ure(s): Unknown incompatible feature: 8000000000000000
>> @@ -53,7 +53,7 @@ snapshot_offset           0x0
>>  incompatible_features     0x0
>>  compatible_features       0x0
>>  autoclear_features        0x8000000000000000
>> -refcount_order            4
>> +refcount_order            (filtered)
>>  header_length             104
>> =20
>>  Header extension:
>> @@ -81,7 +81,7 @@ snapshot_offset           0x0
>>  incompatible_features     0x0
>>  compatible_features       0x0
>>  autoclear_features        0x0
>> -refcount_order            4
>> +refcount_order            (filtered)
>>  header_length             104
>> =20
>>  Header extension:
>=20
> Minor notes:
>=20
> 1. Maybe put the sed command into a function to avoid duplication?

Hm, maybe, but that would increase the LoC, so I=E2=80=99m not sure wheth=
er it
really would be a simplification.

> 2. As I understand the test, it only checks the feature bits.
>    So maybe instead of blacklisting some of the values, white list
>    only the feature bits in the output?

Hm.  Seems reasonable, but then again I=E2=80=99d prefer a minimal change=
, and
changing it to a whitelist would be more change...

Max


--STL05H4zEDg0zfy4qfkgEE5fMRihzzSeO--

--GgKJa0AHikzukbBjuwsmsq8sLtc8QVajK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2R+IkACgkQ9AfbAGHV
z0C73QgAie5bVf14rL8e1hq5B8f43ZSobmFjyw4jWzsgfVCriYt88AtlvkQbVHg7
yXOeCZv26Zr5Hetjst/htWqRVWb/NEDp/U1YW41yfewoqn6s5UMFefaty7XChUOI
tcOx3VKzvS1fzF7ctOY+Xm7JTldMaVlixC60uSYVhRCybDsnCmCxFw17/sc6Mniq
LHVPAtDqpnGJanreOfqmyKCz9ID56c6Pub8Q9usXM1oYek13vgWr/dHYKT6onO4B
8MT2X/JNAxrSGfkSFTjMX6vlBoN0uOCJgXtzDwhe6/pbFXTt8ILuMh3lMb7uSH6F
wFg3vaq5OReWFmX6zIecF78Pq3oK6Q==
=QwDk
-----END PGP SIGNATURE-----

--GgKJa0AHikzukbBjuwsmsq8sLtc8QVajK--

