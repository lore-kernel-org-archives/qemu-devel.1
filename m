Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0A8C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8203421019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8203421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36823 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMEb-0002oj-MZ
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:03:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOMD8-0002DE-Qa
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOMD7-0006ub-O2
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:02:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOMD2-0006q3-6k; Wed, 08 May 2019 09:02:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 482A73060486;
	Wed,  8 May 2019 13:02:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-94.brq.redhat.com
	[10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 12FB15D9C8;
	Wed,  8 May 2019 13:02:00 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190508125548.10458-1-mreitz@redhat.com>
	<3293830f-5356-ae5d-525b-8414a2cd577c@redhat.com>
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
Message-ID: <341c31d5-afaa-dc51-0927-d173ea70eb07@redhat.com>
Date: Wed, 8 May 2019 15:01:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3293830f-5356-ae5d-525b-8414a2cd577c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="muINOQIYEE8WhYA1HHAaBVzA1PYyRCyT9"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 08 May 2019 13:02:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] iotests: Clean up after 192
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--muINOQIYEE8WhYA1HHAaBVzA1PYyRCyT9
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <341c31d5-afaa-dc51-0927-d173ea70eb07@redhat.com>
Subject: Re: [PATCH] iotests: Clean up after 192
References: <20190508125548.10458-1-mreitz@redhat.com>
 <3293830f-5356-ae5d-525b-8414a2cd577c@redhat.com>
In-Reply-To: <3293830f-5356-ae5d-525b-8414a2cd577c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.19 15:00, Thomas Huth wrote:
> On 08/05/2019 14.55, Max Reitz wrote:
>> This patch makes 192 clean up the qemu command FIFOs, the qemu PID fil=
e,
>> and the NBD socket file.
>>
>> Reported by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/192 | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
>> index 158086f9d2..37bd975eec 100755
>> --- a/tests/qemu-iotests/192
>> +++ b/tests/qemu-iotests/192
>> @@ -29,7 +29,9 @@ status=3D1	# failure is the default!
>> =20
>>  _cleanup()
>>  {
>> -	_cleanup_test_img
>> +    _cleanup_qemu
>> +    rm -f "$TEST_DIR/nbd"
>> +    _cleanup_test_img
>>  }
>>  trap "_cleanup; exit \$status" 0 1 2 3 15
>=20
> Thanks a lot! ... but Kevin was a little bit faster already:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01732.html

Dang.  At least it looks basically the same, so that=E2=80=99s good. O:-)=


Max


--muINOQIYEE8WhYA1HHAaBVzA1PYyRCyT9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzS00cACgkQ9AfbAGHV
z0DVOQgAuYccabxdiC+2lJpsTHO1hXFadNbbdvH3vnzWHe3hA8MJcVqfT/kDEw84
ejVLC+Q0n+56O8YjJZAlUznzuCeUKTP/Gs+UZLHpBQNZEaf9hhDpMiHUiD7ug3Yc
1m8zJfPfZSM9OzQM6to9VDRNQLEB88ghRvFqFYukre8AXKXHb45UKxgB6zlN5axC
CV97TQBadT3yIuey/l8Lao8VAWdGId2CATbbrReQuBegX/YRdXschlZBq0M5lx0I
NwJpMKQ/dRcfTaZqA4miTGFGbu/zDFQA4zCI1r8aUJ5ktjg5eQ0oqxrOCuE3PTQe
7OrwEhhydQbwYdp6uPq5HqZrZzIhsg==
=3dgx
-----END PGP SIGNATURE-----

--muINOQIYEE8WhYA1HHAaBVzA1PYyRCyT9--

