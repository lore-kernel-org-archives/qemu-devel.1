Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92754C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563BB2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563BB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHnB-0008Nl-Ko
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:55:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRHja-0005gE-Ct
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRHjZ-0001mu-97
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:51:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hRHjU-0001Sg-IR; Thu, 16 May 2019 10:51:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8AE8E8553B;
	Thu, 16 May 2019 14:51:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-34.brq.redhat.com
	[10.40.204.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 30A684D734;
	Thu, 16 May 2019 14:51:42 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190507203508.18026-1-mreitz@redhat.com>
	<20190507203508.18026-7-mreitz@redhat.com>
	<9639dbcf-ab1f-0f25-489b-2d24a8e4ee01@virtuozzo.com>
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
Message-ID: <61e9a21d-55bf-6b66-466d-016dc54e59d6@redhat.com>
Date: Thu, 16 May 2019 16:51:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9639dbcf-ab1f-0f25-489b-2d24a8e4ee01@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7dVqoFoQ4YxrD8oKesIKle5YCYrSTSao6"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 16 May 2019 14:51:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 6/7] iotests: Test qemu-img convert
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
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7dVqoFoQ4YxrD8oKesIKle5YCYrSTSao6
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Message-ID: <61e9a21d-55bf-6b66-466d-016dc54e59d6@redhat.com>
Subject: Re: [PATCH v4 6/7] iotests: Test qemu-img convert --salvage
References: <20190507203508.18026-1-mreitz@redhat.com>
 <20190507203508.18026-7-mreitz@redhat.com>
 <9639dbcf-ab1f-0f25-489b-2d24a8e4ee01@virtuozzo.com>
In-Reply-To: <9639dbcf-ab1f-0f25-489b-2d24a8e4ee01@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.05.19 16:40, Vladimir Sementsov-Ogievskiy wrote:
> 07.05.2019 23:35, Max Reitz wrote:
>> This test converts a simple image to another, but blkdebug injects
>> block_status and read faults at some offsets.  The resulting image
>> should be the same as the input image, except that sectors that could
>> not be read have to be 0.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/251     | 162 +++++++++++++++++++++++++++++++++++=
++
>>   tests/qemu-iotests/251.out |  43 ++++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 206 insertions(+)
>>   create mode 100755 tests/qemu-iotests/251
>>   create mode 100644 tests/qemu-iotests/251.out
>>
>> diff --git a/tests/qemu-iotests/251 b/tests/qemu-iotests/251
>> new file mode 100755
>> index 0000000000..508d69769f
>> --- /dev/null
>> +++ b/tests/qemu-iotests/251
>> @@ -0,0 +1,162 @@

[...]

>> +_filter_offsets() {
>> +    filters=3D
>> +
>> +    index=3D0
>> +    for ofs in $2
>> +    do
>> +        filters+=3D" -e s/$(printf "$1" $ofs)/status_fail_offset_$ind=
ex/"
>=20
> Why not just $ofs ? I've tested, it works for me as well
>=20
>> +        index=3D$((index + 1))
>> +    done
>> +
>> +    index=3D0
>> +    for ofs in $3
>> +    do
>> +        filters+=3D" -e s/$(printf "$1" $ofs)/read_fail_offset_$index=
/"
>=20
> and here.

Oops.  Those are artifacts from when I had to use hexadecimal offsets
because the output was in hex.  (So the $1 parameter could be either %i
or %x.)  Will fix.

[...]

>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index 7ac9a5ea4a..dde113a552 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -249,3 +249,4 @@
>>   247 rw auto quick
>>   248 rw auto quick
>>   249 rw auto quick
>> +251 auto quick
>=20
> why not rw? (actually, I don't know what means rw group...)

Neither do I. :-)

So I don=E2=80=99t mind (or care, actually).

> With simplified _filter_offsets (also, if drop $1 parameter, parameters=
 may be changed to be $1 and $2)
> (or without, if there is a reason, but I don't see it):
> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks!

Max


--7dVqoFoQ4YxrD8oKesIKle5YCYrSTSao6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzdePwACgkQ9AfbAGHV
z0CHWwf+M7VXjxCPlijNC9uArXW+MKY7cwAmhVXlQZx8ZfsI4w9UhqlzRFs+un6+
RvTRAEKyyzeftY7xNACLV9G+hKcvFOoF5HJXCMMrDDo0XPHFizq86x5mnhfR3BDd
KO7C1XZCW9J03aDqQV9h02m0yokmBK3RVpOdWwOdYf2Mto+GzFwrR319k49JKQXi
NQv9NAYd8OnPN3YALcoCPU4SpszTN11k20kcWEBc3ctpEwmZjzY9W/V1Onug82Qk
aGGO5JSIWZ2QF+vWiC2pjN88gK2Y4SEu74nzSkUeYxem87Xj2tnJnKcRUHHuKYge
XPsLXXaJpEuxUnKQqemFrp1GsweW/g==
=DeYW
-----END PGP SIGNATURE-----

--7dVqoFoQ4YxrD8oKesIKle5YCYrSTSao6--

