Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DB4C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078C1205ED
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078C1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMZFn-0002FX-VI
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 10:33:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMZEo-0001tc-Il
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMZEn-0001nD-CE
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hMZEk-0001m1-Ex; Fri, 03 May 2019 10:32:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 865A359440;
	Fri,  3 May 2019 14:32:29 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-131.brq.redhat.com
	[10.40.204.131])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E4F25C582;
	Fri,  3 May 2019 14:32:27 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Sam Eiderman
	<shmuel.eiderman@oracle.com>, kwolf@redhat.com, qemu-block@nongnu.org, 
	qemu-devel@nongnu.org, fam@euphon.net, eblake@redhat.com
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
	<20190502130822.46858-1-shmuel.eiderman@oracle.com>
	<20190502130822.46858-2-shmuel.eiderman@oracle.com>
	<8d201096-ab9d-82e0-93cb-74bd23d93dbe@redhat.com>
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
Message-ID: <a44ffb98-4cc2-47b9-2c9e-eeeda445a0a0@redhat.com>
Date: Fri, 3 May 2019 16:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8d201096-ab9d-82e0-93cb-74bd23d93dbe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nkFuwTVZPcc8jVP1uvtA5W2aNCiBINu0P"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 03 May 2019 14:32:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] vmdk: Set vmdk parent backing_format to
 vmdk
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
Cc: arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503143225.dWISkxZoSNPlBiU_fopUvgq7wvQj5HfHfy9SoVaORAk@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nkFuwTVZPcc8jVP1uvtA5W2aNCiBINu0P
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Sam Eiderman
 <shmuel.eiderman@oracle.com>, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, fam@euphon.net, eblake@redhat.com
Cc: arbel.moshe@oracle.com
Message-ID: <a44ffb98-4cc2-47b9-2c9e-eeeda445a0a0@redhat.com>
Subject: Re: [PATCH v2] vmdk: Set vmdk parent backing_format to vmdk
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
 <20190502130822.46858-1-shmuel.eiderman@oracle.com>
 <20190502130822.46858-2-shmuel.eiderman@oracle.com>
 <8d201096-ab9d-82e0-93cb-74bd23d93dbe@redhat.com>
In-Reply-To: <8d201096-ab9d-82e0-93cb-74bd23d93dbe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.05.19 13:34, Thomas Huth wrote:
>  Hi Sam,
>=20
> On 02/05/2019 15.08, Sam Eiderman wrote:
>> Commit b69864e ("vmdk: Support version=3D3 in VMDK descriptor files")
>> fixed the probe function to correctly guess vmdk descriptors with
>> version=3D3.
>>
>> This solves the issue where vmdk snapshot with parent vmdk descriptor
>> containing "version=3D3" would be treated as raw instead vmdk.
>>
>> In the future case where a new vmdk version is introduced, we will aga=
in
>> experience this issue, even if the user will provide "-f vmdk" it will=

>> only apply to the tip image and not to the underlying "misprobed" pare=
nt
>> image.
>>
>> The code in vmdk.c already assumes that the backing file of vmdk must =
be
>> vmdk (see vmdk_is_cid_valid which returns 0 if backing file is not
>> vmdk).
>>
>> So let's make it official by supplying the backing_format as vmdk.
>>
>> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>> Reviewed-By: Liran Alon <liran.alon@oracle.com>
>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>> Signed-off-by: Shmuel Eiderman <shmuel.eiderman@oracle.com>
>> ---
>>  block/vmdk.c           | 2 ++
>>  tests/qemu-iotests/110 | 6 +++---
>>  tests/qemu-iotests/126 | 4 ++--
>>  3 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index 8dec6ef767..de8cb859f8 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -397,6 +397,8 @@ static int vmdk_parent_open(BlockDriverState *bs)
>>          pstrcpy(bs->auto_backing_file, end_name - p_name + 1, p_name)=
;
>>          pstrcpy(bs->backing_file, sizeof(bs->backing_file),
>>                  bs->auto_backing_file);
>> +        pstrcpy(bs->backing_format, sizeof(bs->backing_format),
>> +                "vmdk");
>>      }
>=20
> Your patch with this change has already been merged into the QEMU maste=
r
> branch...
>=20
>> diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
>> index fad672c1ae..982569dbc5 100755
>> --- a/tests/qemu-iotests/110
>> +++ b/tests/qemu-iotests/110
>> @@ -54,7 +54,7 @@ _make_test_img -b "$TEST_IMG_REL.base" 64M
>>  # qemu should be able to reconstruct the filename, so relative backin=
g names
>>  # should work
>>  TEST_IMG=3D"json:{'driver':'$IMGFMT','file':{'driver':'file','filenam=
e':'$TEST_IMG'}}" \
>> -    _img_info | _filter_img_info
>> +    _img_info | _filter_img_info | grep -v "backing file format"
>> =20
>>  echo
>>  echo '=3D=3D=3D Non-reconstructable filename =3D=3D=3D'
>> @@ -78,7 +78,7 @@ TEST_IMG=3D"json:{
>>              }
>>          ]
>>      }
>> -}" _img_info | _filter_img_info
>> +}" _img_info | _filter_img_info | grep -v "backing file format"
>> =20
>>  echo
>>  echo '=3D=3D=3D Backing name is always relative to the backed image =3D=
=3D=3D'
>> @@ -110,7 +110,7 @@ TEST_IMG=3D"json:{
>>              }
>>          ]
>>      }
>> -}" _img_info | _filter_img_info
>> +}" _img_info | _filter_img_info | grep -v "backing file format"
>> =20
>> =20
>>  # success, all done
>> diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
>> index 96dc048d59..1f7618c8a5 100755
>> --- a/tests/qemu-iotests/126
>> +++ b/tests/qemu-iotests/126
>> @@ -63,7 +63,7 @@ TEST_IMG=3D$BASE_IMG _make_test_img 64M
>>  TEST_IMG=3D$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
>> =20
>>  # The default cluster size depends on the image format
>> -TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
>> +TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size\|backing file f=
ormat'
>> =20
>>  _rm_test_img "$BASE_IMG"
>>  _rm_test_img "$TOP_IMG"
>> @@ -79,7 +79,7 @@ TOP_IMG=3D"file:image:top.$IMGFMT"
>>  TEST_IMG=3D$BASE_IMG _make_test_img 64M
>>  TEST_IMG=3D$TOP_IMG _make_test_img -b "$BASE_IMG"
>> =20
>> -TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
>> +TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size\|backing file f=
ormat'
>> =20
>>  _rm_test_img "$BASE_IMG"
>>  _rm_test_img "image:top.$IMGFMT"
>>
>=20
> ... so please just send a patch with these fixes!

I already did, it's here:

http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html

Max


--nkFuwTVZPcc8jVP1uvtA5W2aNCiBINu0P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzMUPkACgkQ9AfbAGHV
z0DuzAf/bKKuVTHw8V9qpcG3s00cp0IhtNbFMHCmIObVrZDd/JOXKVS2Vxt8BLYY
wNBaYa6fovohjPG/Av74cGW7cAymBZOX1E6CD3eWvTZDD7j9sIgoETOTyDHomjBK
dearq+ctWz7EuKC2PYR5WWBTgklW5D7w/PLLkIGWsP+sKIPIbNd/+FZ9w3iFOiWB
fSwPXQeorHGZ5k8ods+rBQ2Ktbqe9M6euNlrqEWBCf+Otl0p1tXFVNgNrHT+nqhN
mKfaVJxP1vLSdEvQthmxGtE0hHw9RszAUiBIs/HrBmL1IwLEKky9k/1DhyfVuU0v
C76VC0u+D+rNoHHU/sS9xwoIKbmUwQ==
=tX6n
-----END PGP SIGNATURE-----

--nkFuwTVZPcc8jVP1uvtA5W2aNCiBINu0P--

