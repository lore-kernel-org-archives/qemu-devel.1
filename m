Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D527C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37DC20679
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37DC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvIb-0002iD-Oy
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iEvGr-00025t-2t
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iEvGp-0007i5-OI
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 08:59:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iEvGk-0007e7-LH; Mon, 30 Sep 2019 08:59:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58CE518C426C;
 Mon, 30 Sep 2019 12:59:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1203760A9F;
 Mon, 30 Sep 2019 12:59:11 +0000 (UTC)
Subject: Re: [PATCH 02/18] iotests: Replace IMGOPTS by _unsupported_imgopts
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-3-mreitz@redhat.com>
 <456ed2bf18ee3033aa2115cc3b31bde1e0833348.camel@redhat.com>
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
Message-ID: <54c5cff5-b9c9-4274-3ff7-77bfc586ed18@redhat.com>
Date: Mon, 30 Sep 2019 14:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <456ed2bf18ee3033aa2115cc3b31bde1e0833348.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xS99n0uviDhuq1RE8dzEtO8iSfWPhrNXd"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 30 Sep 2019 12:59:13 +0000 (UTC)
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
--xS99n0uviDhuq1RE8dzEtO8iSfWPhrNXd
Content-Type: multipart/mixed; boundary="DDgYKNOHvNISSX8J1KfuJBnEA4NZEs6nd"

--DDgYKNOHvNISSX8J1KfuJBnEA4NZEs6nd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.09.19 18:31, Maxim Levitsky wrote:
> On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
>> Some tests require compat=3D1.1 and thus set IMGOPTS=3D'compat=3D1.1'
>> globally.  That is not how it should be done; instead, they should
>> simply set _unsupported_imgopts to compat=3D0.10 (compat=3D1.1 is the
>> default anyway).
>>
>> This makes the tests heed user-specified $IMGOPTS.  Some do not work
>> with all image options, though, so we need to disable them accordingly=
=2E
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/036 | 3 +--
>>  tests/qemu-iotests/060 | 4 ++--
>>  tests/qemu-iotests/062 | 3 ++-
>>  tests/qemu-iotests/066 | 3 ++-
>>  tests/qemu-iotests/068 | 3 ++-
>>  tests/qemu-iotests/098 | 3 +--
>>  6 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
>> index 69d0f9f903..57dda23b02 100755
>> --- a/tests/qemu-iotests/036
>> +++ b/tests/qemu-iotests/036
>> @@ -43,9 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  # This tests qcow2-specific low-level functionality
>>  _supported_fmt qcow2
>>  _supported_proto file
>> -
>>  # Only qcow2v3 and later supports feature bits
>> -IMGOPTS=3D"compat=3D1.1"
>> +_unsupported_imgopts 'compat=3D0.10'
>> =20
>>  echo
>>  echo =3D=3D=3D Image with unknown incompatible feature bit =3D=3D=3D
>> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
>> index b91d8321bb..9c2ef42522 100755
>> --- a/tests/qemu-iotests/060
>> +++ b/tests/qemu-iotests/060
>> @@ -48,6 +48,8 @@ _filter_io_error()
>>  _supported_fmt qcow2
>>  _supported_proto file
>>  _supported_os Linux
>> +# These tests only work for compat=3D1.1 images with refcount_bits=3D=
16
>> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D\([^1]\|.\([^6]=
\|$\)\)'
>> =20
>>  rt_offset=3D65536  # 0x10000 (XXX: just an assumption)
>>  rb_offset=3D131072 # 0x20000 (XXX: just an assumption)
>> @@ -55,8 +57,6 @@ l1_offset=3D196608 # 0x30000 (XXX: just an assumptio=
n)
>>  l2_offset=3D262144 # 0x40000 (XXX: just an assumption)
>>  l2_offset_after_snapshot=3D524288 # 0x80000 (XXX: just an assumption)=

>> =20
>> -IMGOPTS=3D"compat=3D1.1"
>> -
>>  OPEN_RW=3D"open -o overlap-check=3Dall $TEST_IMG"
>>  # Overlap checks are done before write operations only, therefore ope=
ning an
>>  # image read-only makes the overlap-check option irrelevant
>> diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
>> index d5f818fcce..ac0d2a9a3b 100755
>> --- a/tests/qemu-iotests/062
>> +++ b/tests/qemu-iotests/062
>> @@ -40,8 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  # This tests qocw2-specific low-level functionality
>>  _supported_fmt qcow2
>>  _supported_proto generic
>> +# We need zero clusters and snapshots
>> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
>> =20
>> -IMGOPTS=3D"compat=3D1.1"
>>  IMG_SIZE=3D64M
>> =20
>>  echo
>> diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
>> index 28f8c98412..9a15ba8027 100755
>> --- a/tests/qemu-iotests/066
>> +++ b/tests/qemu-iotests/066
>> @@ -39,9 +39,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  # This tests qocw2-specific low-level functionality
>>  _supported_fmt qcow2
>>  _supported_proto generic
>> +# Weneed zero clusters and snapshots
> Typo

Indeed!

>> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
>> =20
>>  # Intentionally create an unaligned image
>> -IMGOPTS=3D"compat=3D1.1"
>>  IMG_SIZE=3D$((64 * 1024 * 1024 + 512))
>> =20
>>  echo
>> diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
>> index 22f5ca3ba6..65650fca9a 100755
>> --- a/tests/qemu-iotests/068
>> +++ b/tests/qemu-iotests/068
>> @@ -39,8 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  # This tests qocw2-specific low-level functionality
>>  _supported_fmt qcow2
>>  _supported_proto generic
>> +# Internal snapshots are (currently) impossible with refcount_bits=3D=
1
> Why currently? 1 bit will only allow to mark a cluser as used/unused wh=
ich
> is not enough for any snapshots?

It is, because in theory you can just copy the clusters at the time of
snapshotting.  We=E2=80=99ll never implement it, but, well...

>> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
>> =20
>> -IMGOPTS=3D"compat=3D1.1"
>>  IMG_SIZE=3D128K
>> =20
>>  case "$QEMU_DEFAULT_MACHINE" in
>> diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
>> index 1c1d1c468f..2d68dc7d6c 100755
>> --- a/tests/qemu-iotests/098
>> +++ b/tests/qemu-iotests/098
>> @@ -40,8 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>> =20
>>  _supported_fmt qcow2
>>  _supported_proto file
>> -
>> -IMGOPTS=3D"compat=3D1.1"
>> +_unsupported_imgopts 'compat=3D0.10'
> Any idea why? I am not familiar with qcow2 well enought to
> know but this misses a comment with justification.

Because the special bdrv_make_empty() version we want to test only works
with qcow2 v3 images.

>> =20
>>  for event in l1_update empty_image_prepare reftable_update refblock_a=
lloc; do
>> =20
>=20
>=20
> Best regards,
> 	Maxim Levitsky
>=20

Thanks for reviewing!

Max


--DDgYKNOHvNISSX8J1KfuJBnEA4NZEs6nd--

--xS99n0uviDhuq1RE8dzEtO8iSfWPhrNXd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2R/B4ACgkQ9AfbAGHV
z0Aljgf/ZYGtVFrwLt5ozOpNSPdKVnYyaUULVAl3lEfb24Ga6is0/veBxgc8wfZB
b3vBYdssaZmGX+gZv/0ZnlHpFbNW5S6ibzFAsQuV2hQHzDSewYHvZBrNp6GEFIfe
kJxao1qTr9VkM7SQLK9fSLo1nGHbUhpIu9jzUNRqxwU/JoOqobEw61E7YUjfLLOw
GB7wnrMnLRgv0ud9i9T1XPYIOlTDoDEXq39ddUrOnVurqX1XaWtFRsbNg7LU/mtF
2zs1T53rrPRKUePw9FwOhhfeoqtZtV4aq4UIfB2rh7D90+LHHm4Xf8ZJNIWn7oiC
q1bBRd1DJEgpo6wQFURBQRfQdH7VXA==
=jSHC
-----END PGP SIGNATURE-----

--xS99n0uviDhuq1RE8dzEtO8iSfWPhrNXd--

