Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEDDC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8B420883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8B420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVgPj-00075H-A0
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 14:01:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVgNZ-0005f9-7J
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVgNU-0002U4-G5
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVgNC-0002Ga-Ap; Tue, 28 May 2019 13:58:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B828308A124;
	Tue, 28 May 2019 17:58:44 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B94731017E3A;
	Tue, 28 May 2019 17:58:41 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190410202033.28617-1-mreitz@redhat.com>
	<20190410202033.28617-5-mreitz@redhat.com>
	<fc4bb38f-b13e-1e79-7e94-094f3dd984c4@virtuozzo.com>
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
Message-ID: <259b7865-48d3-b640-71f6-6d18e65a9ee3@redhat.com>
Date: Tue, 28 May 2019 19:58:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fc4bb38f-b13e-1e79-7e94-094f3dd984c4@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cs52RGlUyl9AtUm4wkzkMzwArFODC9dnv"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 28 May 2019 17:58:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 04/11] block: Inline
 bdrv_co_block_status_from_*()
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
--Cs52RGlUyl9AtUm4wkzkMzwArFODC9dnv
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <259b7865-48d3-b640-71f6-6d18e65a9ee3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/11] block: Inline
 bdrv_co_block_status_from_*()
References: <20190410202033.28617-1-mreitz@redhat.com>
 <20190410202033.28617-5-mreitz@redhat.com>
 <fc4bb38f-b13e-1e79-7e94-094f3dd984c4@virtuozzo.com>
In-Reply-To: <fc4bb38f-b13e-1e79-7e94-094f3dd984c4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.05.19 10:57, Vladimir Sementsov-Ogievskiy wrote:
> 10.04.2019 23:20, Max Reitz wrote:
>> With bdrv_filtered_rw_bs(), we can easily handle this default filter
>> behavior in bdrv_co_block_status().
>>
>> blkdebug wants to have an additional assertion, so it keeps its own
>> implementation, except bdrv_co_block_status_from_file() needs to be
>> inlined there.
>>
>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   include/block/block_int.h | 22 -----------------
>>   block/blkdebug.c          |  7 ++++--
>>   block/blklogwrites.c      |  1 -
>>   block/commit.c            |  1 -
>>   block/copy-on-read.c      |  2 --
>>   block/io.c                | 51 +++++++++++++------------------------=
--
>>   block/mirror.c            |  1 -
>>   block/throttle.c          |  1 -
>>   8 files changed, 22 insertions(+), 64 deletions(-)

[...]

>> diff --git a/block/io.c b/block/io.c
>> index 5c33ecc080..8d124bae5c 100644
>> --- a/block/io.c
>> +++ b/block/io.c

[...]

>> @@ -2088,7 +2059,8 @@ static int coroutine_fn bdrv_co_block_status(Blo=
ckDriverState *bs,
>>  =20
>>       /* Must be non-NULL or bdrv_getlength() would have failed */
>>       assert(bs->drv);
>> -    if (!bs->drv->bdrv_co_block_status) {
>> +    has_filtered_child =3D bs->drv->is_filter && bdrv_filtered_rw_chi=
ld(bs);
>> +    if (!bs->drv->bdrv_co_block_status && !has_filtered_child) {
>>           *pnum =3D bytes;
>>           ret =3D BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
>>           if (offset + bytes =3D=3D total_size) {
>> @@ -2109,9 +2081,20 @@ static int coroutine_fn bdrv_co_block_status(Bl=
ockDriverState *bs,
>>       aligned_offset =3D QEMU_ALIGN_DOWN(offset, align);
>>       aligned_bytes =3D ROUND_UP(offset + bytes, align) - aligned_offs=
et;
>>  =20
>> -    ret =3D bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offs=
et,
>> -                                        aligned_bytes, pnum, &local_m=
ap,
>> -                                        &local_file);
>> +    if (bs->drv->bdrv_co_block_status) {
>> +        ret =3D bs->drv->bdrv_co_block_status(bs, want_zero, aligned_=
offset,
>> +                                            aligned_bytes, pnum, &loc=
al_map,
>> +                                            &local_file);
>> +    } else {
>> +        /* Default code for filters */
>> +
>> +        local_file =3D bdrv_filtered_rw_bs(bs);
>> +        assert(local_file);
>> +
>> +        *pnum =3D aligned_bytes;
>> +        local_map =3D aligned_offset;
>> +        ret =3D BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
>> +    }
>=20
>=20
> preexistent, but why default for filters is aligned and for other nodes=
 is not?

I suppose because the default code for other nodes has been written
before the aligning code was introduced.

I guess there is no good reason to enforce alignment in either case.  It
is important to do so when issuing a request to the driver because the
driver is not required to be able to handle unaligned requests.  If we
completely forgo the driver and just go through to the next layer, it
doesn=E2=80=99t really matter, I think.

Well, I just kept it as it was before. O:-)

Max


--Cs52RGlUyl9AtUm4wkzkMzwArFODC9dnv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlztdtAACgkQ9AfbAGHV
z0BV0ggAsBOacCzn76Dniu5A6q+yx1kDZNSrpZqq9tKxgEUYUlhT5Y5X7ESJfAq6
0IWPdMTzRXXyaXFX8w3cdw09LxlYXjCnth9qRPvO0JGmVOw+L+Ud6tFNrdJB1ZsG
v6Nl/RbLy5BxoGN7HPhDImBDqJpOXEMnFWgmAlc/5CQleavIY9d1NyOueuiQFtqj
Aetak27/rm70uoTvnf+ut+CQH3cWECr4ytNcoTsgpza94+X2DzjeoJo7lPzFqZ/q
UIdSvAIxRJ2pqIXa8Y+7KidDMMduiN46vQVR0Kcv+IBmcq/gqKDFFnsvAx8IGF5+
mSLreligqqLBI9+2oXtdqWx76+TYWQ==
=0+Gd
-----END PGP SIGNATURE-----

--Cs52RGlUyl9AtUm4wkzkMzwArFODC9dnv--

