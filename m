Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F9C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72526215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72526215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvst-0007sY-Hv
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iEvpS-0004Bs-Cq
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iEvpR-00045o-4c
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iEvpN-00043M-3l; Mon, 30 Sep 2019 09:35:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 442598980E2;
 Mon, 30 Sep 2019 13:34:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 181F3261B9;
 Mon, 30 Sep 2019 13:34:57 +0000 (UTC)
Subject: Re: [PATCH 14/18] iotests: Make 110 work with data_file
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-15-mreitz@redhat.com>
 <037a6ded4b29435dec32fe71f12613315915aeca.camel@redhat.com>
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
Message-ID: <80d3ceb9-37f6-9b20-ee04-2376ed66e0f8@redhat.com>
Date: Mon, 30 Sep 2019 15:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <037a6ded4b29435dec32fe71f12613315915aeca.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7ACBVYQxUrpWtdrhz64NBT905XVJWV3O2"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Mon, 30 Sep 2019 13:34:59 +0000 (UTC)
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
--7ACBVYQxUrpWtdrhz64NBT905XVJWV3O2
Content-Type: multipart/mixed; boundary="rTQHA6QlfB10SwfSQxpN7II9EgizLNQMV"

--rTQHA6QlfB10SwfSQxpN7II9EgizLNQMV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.09.19 18:34, Maxim Levitsky wrote:
> On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
>> The only difference is that the json:{} filename of the image looks
>> different.  We actually do not care about that filename in this test, =
we
>> are only interested in (1) that there is a json:{} filename, and (2)
>> whether the backing filename can be constructed.
>>
>> So just filter out the json:{} data, thus making this test pass both
>> with and without data_file.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/110     | 7 +++++--
>>  tests/qemu-iotests/110.out | 4 ++--
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
>> index f78df0e6e1..34459dcd60 100755
>> --- a/tests/qemu-iotests/110
>> +++ b/tests/qemu-iotests/110
>> @@ -67,6 +67,7 @@ echo
>>  # Across blkdebug without a config file, you cannot reconstruct filen=
ames, so
>>  # qemu is incapable of knowing the directory of the top image from th=
e filename
>>  # alone. However, using bdrv_dirname(), it should still work.
>> +# (Filter out the json:{} filename so this test works with external d=
ata files)
>>  TEST_IMG=3D"json:{
>>      'driver': '$IMGFMT',
>>      'file': {
>> @@ -82,7 +83,8 @@ TEST_IMG=3D"json:{
>>              }
>>          ]
>>      }
>> -}" _img_info | _filter_img_info | grep -v 'backing file format'
>> +}" _img_info | _filter_img_info | grep -v 'backing file format' \
>> +    | sed -e 's#^image: json:.*#image: json:{ /* filtered */ }#'
>> =20
>>  echo
>>  echo '=3D=3D=3D Backing name is always relative to the backed image =3D=
=3D=3D'
>> @@ -114,7 +116,8 @@ TEST_IMG=3D"json:{
>>              }
>>          ]
>>      }
>> -}" _img_info | _filter_img_info | grep -v 'backing file format'
>> +}" _img_info | _filter_img_info | grep -v 'backing file format' \
>> +    | sed -e 's#^image: json:.*#image: json:{ /* filtered */ }#'
>> =20
>> =20
>>  # success, all done
>> diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
>> index f60b26390e..f835553a99 100644
>> --- a/tests/qemu-iotests/110.out
>> +++ b/tests/qemu-iotests/110.out
>> @@ -11,7 +11,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t=
=2EIMGFMT.base)
>> =20
>>  =3D=3D=3D Non-reconstructable filename =3D=3D=3D
>> =20
>> -image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_=
aio", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driv=
er": "blkdebug", "set-state.0.new_state": 42}}
>> +image: json:{ /* filtered */ }
>>  file format: IMGFMT
>>  virtual size: 64 MiB (67108864 bytes)
>>  backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
>> @@ -22,7 +22,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D=
67108864 backing_file=3Dt.IMGFMT.b
>> =20
>>  =3D=3D=3D Nodes without a common directory =3D=3D=3D
>> =20
>> -image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "fi=
le", "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TE=
ST_DIR/t.IMGFMT.copy"}], "driver": "quorum", "vote-
>> threshold": 1}}
>> +image: json:{ /* filtered */ }
>>  file format: IMGFMT
>>  virtual size: 64 MiB (67108864 bytes)
>>  backing file: t.IMGFMT.base (cannot determine actual path)
>=20
> Again, maybe put that into the common.filter, so new tests won't need t=
o copy&paste this?

Good idea.

> Also maybe remove the image name completely from output, thus not needi=
ng the more complex regex?

I=E2=80=99d prefer to still see that there is a json:{} filename instead =
of a
plain one.  (This is important in this test because for plain filenames,
it=E2=80=99s generally easy to reconstruct the backing file path; it=E2=80=
=99s only
difficult for json:{} filenames.)

Max


--rTQHA6QlfB10SwfSQxpN7II9EgizLNQMV--

--7ACBVYQxUrpWtdrhz64NBT905XVJWV3O2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2SBIAACgkQ9AfbAGHV
z0C7ugf/UNsGLgpLyOjuxuoDi+s07tsX3TMTGKOFh4C8V43UZDd0rkIvSkv1c5Js
CT/DneCFA4x/QKDq9yvm4X7n52+qph7jVoNP2S1duSRCcxfocnDu6qSwRq/9x7wQ
8zdC1jjESCuMp7cuotLEZ6w3yIXI6lv0Jhrw5qFXe9AIoRKlr1obGcSqGh1QkNP4
2Kp1PSxOBmxCAX8MTbhwh5CPpUfyZ0CA7PJSYjI+c/jbngcdyyK/wenH1P0UtlRL
vQ4z9JQEd8N+cxLxnPlRmyZzPEeB7vSV3JYkC7pBAKMChPx5fDEYn+c1H5vRzXyX
TCIkEMDs7T2Ah6k7ntxY9Fp/KCvy5g==
=SXJL
-----END PGP SIGNATURE-----

--7ACBVYQxUrpWtdrhz64NBT905XVJWV3O2--

