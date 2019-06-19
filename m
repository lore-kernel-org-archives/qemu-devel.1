Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D62C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5192187F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5192187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcwT-0007i0-7X
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdcqY-0002Fh-JZ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdcqW-0000eg-9k
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:50:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdcqO-0000aP-Mo; Wed, 19 Jun 2019 11:49:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 464F131628FC;
 Wed, 19 Jun 2019 15:49:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-121.ams2.redhat.com
 [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BF745C207;
 Wed, 19 Jun 2019 15:49:43 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-31-mreitz@redhat.com>
 <5fb4108f-eb50-d076-4e1a-d59de96ef3a7@virtuozzo.com>
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
Message-ID: <9a90cab8-6738-5e20-8350-12965e240c5a@redhat.com>
Date: Wed, 19 Jun 2019 17:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5fb4108f-eb50-d076-4e1a-d59de96ef3a7@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="POIfe0wnnD03n5dJvX5NsS9PFdkHSCbvs"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 19 Jun 2019 15:49:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 30/42] qemu-img: Use child access
 functions
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--POIfe0wnnD03n5dJvX5NsS9PFdkHSCbvs
Content-Type: multipart/mixed; boundary="97Y9w3OuPxrBiDqe2i7HwJQdgromqFLvg";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <9a90cab8-6738-5e20-8350-12965e240c5a@redhat.com>
Subject: Re: [PATCH v5 30/42] qemu-img: Use child access functions
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-31-mreitz@redhat.com>
 <5fb4108f-eb50-d076-4e1a-d59de96ef3a7@virtuozzo.com>
In-Reply-To: <5fb4108f-eb50-d076-4e1a-d59de96ef3a7@virtuozzo.com>

--97Y9w3OuPxrBiDqe2i7HwJQdgromqFLvg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.06.19 11:18, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> This changes iotest 204's output, because blkdebug on top of a COW nod=
e
>> used to make qemu-img map disregard the rest of the backing chain (the=

>> backing chain was broken by the filter).  With this patch, the
>> allocation in the base image is reported correctly.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   qemu-img.c                 | 36 ++++++++++++++++++++----------------=

>>   tests/qemu-iotests/204.out |  1 +
>>   2 files changed, 21 insertions(+), 16 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 07b6e2a808..7bfa6e5d40 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -992,7 +992,7 @@ static int img_commit(int argc, char **argv)
>>       if (!blk) {
>>           return 1;
>>       }
>> -    bs =3D blk_bs(blk);
>> +    bs =3D bdrv_skip_implicit_filters(blk_bs(blk));
>=20
> if filename is json, describing explicit filter over normal node, bs wi=
ll be
> explicit filter ...
>=20
>>  =20
>>       qemu_progress_init(progress, 1.f);
>>       qemu_progress_print(0.f, 100);
>> @@ -1009,7 +1009,7 @@ static int img_commit(int argc, char **argv)
>>           /* This is different from QMP, which by default uses the dee=
pest file in
>>            * the backing chain (i.e., the very base); however, the tra=
ditional
>>            * behavior of qemu-img commit is using the immediate backin=
g file. */
>> -        base_bs =3D backing_bs(bs);
>> +        base_bs =3D bdrv_filtered_cow_bs(bs);
>>           if (!base_bs) {
>=20
> and here we'll fail.

Right, will change to bdrv_backing_chain_next().

>>               error_setg(&local_err, "Image does not have a backing fi=
le");
>>               goto done;
>> @@ -1626,19 +1626,18 @@ static int convert_iteration_sectors(ImgConver=
tState *s, int64_t sector_num)
>>  =20
>>       if (s->sector_next_status <=3D sector_num) {
>>           int64_t count =3D n * BDRV_SECTOR_SIZE;
>> +        BlockDriverState *src_bs =3D blk_bs(s->src[src_cur]);
>> +        BlockDriverState *base;
>>  =20
>>           if (s->target_has_backing) {
>> -
>> -            ret =3D bdrv_block_status(blk_bs(s->src[src_cur]),
>> -                                    (sector_num - src_cur_offset) *
>> -                                    BDRV_SECTOR_SIZE,
>> -                                    count, &count, NULL, NULL);
>> +            base =3D bdrv_backing_chain_next(src_bs);
>=20
> As you described in another patch, will not we here get allocated in ba=
se as allocated, because of
> counting filters above base?

Damn, yes.  So

    base =3D bdrv_filtered_cow_bs(bdrv_skip_rw_filters(src_bs));

I suppose.

> Hmm. I now think, why filters don't report everything as unallocated, w=
ould not it be more correct
> than fallthrough to child?

I don=E2=80=99t know, actually.  Maybe, maybe not.

>>           } else {
>> -            ret =3D bdrv_block_status_above(blk_bs(s->src[src_cur]), =
NULL,
>> -                                          (sector_num - src_cur_offse=
t) *
>> -                                          BDRV_SECTOR_SIZE,
>> -                                          count, &count, NULL, NULL);=

>> +            base =3D NULL;
>>           }
>> +        ret =3D bdrv_block_status_above(src_bs, base,
>> +                                      (sector_num - src_cur_offset) *=

>> +                                      BDRV_SECTOR_SIZE,
>> +                                      count, &count, NULL, NULL);
>>           if (ret < 0) {
>>               error_report("error while reading block status of sector=
 %" PRId64
>>                            ": %s", sector_num, strerror(-ret));

[...]

>> @@ -2949,7 +2950,7 @@ static int img_map(int argc, char **argv)
>>       if (!blk) {
>>           return 1;
>>       }
>> -    bs =3D blk_bs(blk);
>> +    bs =3D bdrv_skip_implicit_filters(blk_bs(blk));
>=20
> Hmm, another thought about implicit filters, how they could be here in =
qemu-img?

Hm, I don=E2=80=99t think they can.

> If implicit are only
> job filters. Do you prepared it for implicit COR? But we discussed with=
 Kevin that we'd better deprecate
> copy-on-read option..
>=20
> So, if implicit filters are for compatibility, we'll have them only in =
block-jobs. So, seems no reason to support
> them in qemu-img.

Seems reasonable, yes.

> Also, in block-jobs, we can abandon creating implicit filters above any=
 filter nodes, as well as abandon creating any
> filter nodes above implicit filters. This will still support old scenar=
ios, but gives very simple and well defined scope
> of using implicit filters and how to work with them. What do you think?=


Hm, in what way would that make things simpler?

Max


--97Y9w3OuPxrBiDqe2i7HwJQdgromqFLvg--

--POIfe0wnnD03n5dJvX5NsS9PFdkHSCbvs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0KWZUACgkQ9AfbAGHV
z0Dj1Qf/V8oo4hHGmb6nrowrpoZjvBNx9XOHPZ7BlPKzYEOG7WdlPk3v/Hc5NoeW
ugPvwnVFu8WG4/KHA1O77Y/yD0K7sypizIYjwFVa4RXIGMiOCStU2RukaT/zBnjr
TE8skUawsWEccVKaxLuGoBLCmA5JW4tUcIVFJT9QCqartXVCnN3/62JHbzn+t5tu
vb6SYgkhMxYLOGfcc3zToR4ddX7OELG83FXaPCdoboKnrjZI35+tGyTIUrOqfZiD
Q83OYj+CpyDmpsG7t+XuphB3OMd73a96PMfoM02YfCnKRfkVvjxTlPYjdXUZcRvX
0lWVaZP526GCXPpf5sl7H/7DuE873A==
=CQF5
-----END PGP SIGNATURE-----

--POIfe0wnnD03n5dJvX5NsS9PFdkHSCbvs--

