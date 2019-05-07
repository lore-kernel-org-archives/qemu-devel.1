Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56260C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274BD20675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274BD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO6Qa-0000nH-94
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 16:11:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO6Ov-00085d-1n
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO6Ot-0004Ao-5z
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:09:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO6Ol-00043y-D7; Tue, 07 May 2019 16:09:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D16B3003B41;
	Tue,  7 May 2019 20:09:03 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 16D0617998;
	Tue,  7 May 2019 20:09:00 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190507183610.9848-1-mreitz@redhat.com>
	<20190507183610.9848-5-mreitz@redhat.com>
	<727274a0-e221-1a88-ee78-9c2962bf72d5@redhat.com>
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
Message-ID: <56c9739a-942c-c26c-fcab-7a86e53b232d@redhat.com>
Date: Tue, 7 May 2019 22:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <727274a0-e221-1a88-ee78-9c2962bf72d5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h07hT9aE5r7MFXTm8j48nBvCUgUetfCKD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 07 May 2019 20:09:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 4/5] iotests: Use qemu-nbd's --pid-file
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
--h07hT9aE5r7MFXTm8j48nBvCUgUetfCKD
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <56c9739a-942c-c26c-fcab-7a86e53b232d@redhat.com>
Subject: Re: [PATCH 4/5] iotests: Use qemu-nbd's --pid-file
References: <20190507183610.9848-1-mreitz@redhat.com>
 <20190507183610.9848-5-mreitz@redhat.com>
 <727274a0-e221-1a88-ee78-9c2962bf72d5@redhat.com>
In-Reply-To: <727274a0-e221-1a88-ee78-9c2962bf72d5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.05.19 21:53, Eric Blake wrote:
> On 5/7/19 1:36 PM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/common.rc | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.=
rc
>> index 93f87389b6..217cf3874d 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -106,8 +106,8 @@ _qemu_io_wrapper()
>>  _qemu_nbd_wrapper()
>>  {
>>      (
>> -        echo $BASHPID > "${QEMU_TEST_DIR}/qemu-nbd.pid"
>> -        exec "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS "$@"
>> +        exec "$QEMU_NBD_PROG" --pid-file=3D"${QEMU_TEST_DIR}/qemu-nbd=
=2Epid" \
>> +                              $QEMU_NBD_OPTIONS "$@"
>>      )
>=20
> Beforehand, we needed the subshell + exec to guarantee that the pid we
> were writing was that of the subshell. Now, we don't need either; this
> could be simplified to:
>=20
> _qemu_nbd_wrapper()
> {
>     "$QEMU_NBD_PROG" --pid-file... "$@"
> }

True, but I just followed _qemu_img_wrapper()=E2=80=99s example.  I could=
 change
both, of course...

Max


--h07hT9aE5r7MFXTm8j48nBvCUgUetfCKD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzR5doACgkQ9AfbAGHV
z0AyiQf+IVDUxNWW9k1PevPYE5LTBlu59UgtIckerucJFFyr241XaGxLDv0cZLMM
L2W6PCvf+uzRJ0kG/fOsIoIEeMGgPM6Xxx45bZd6PLWxIM6FDwjwfLzAjKz+Uf53
yCPUzhTqr+s9y2GgSWZrUQlK91NeOae0KShOMac3b4yntCtQSrD6xRaX5quuZKeE
I/pDhaTEJrNXy2Z3eRzS91fMBpi/SgOaOL3/YorxQTX+BGVrOfbbwFVXehnVp+u6
4PRW/RtWlKivbBheuY0WklhZyoC4eXY5uqRpyMOrbRDiI6rjGX5mUmLO3B15Ei3d
bjHpMO2loone0CNLTpKHBLjZ0c0W+g==
=Em2p
-----END PGP SIGNATURE-----

--h07hT9aE5r7MFXTm8j48nBvCUgUetfCKD--

