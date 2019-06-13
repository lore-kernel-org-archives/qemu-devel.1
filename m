Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D04DC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB98D20851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB98D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPxQ-0002qb-3a
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37060)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbOve-0002IC-I8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbOvd-0003SF-0Q
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:34:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbOvZ-0003NY-L5; Thu, 13 Jun 2019 08:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A12B8008C;
 Thu, 13 Jun 2019 12:33:56 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A27B7AB48;
 Thu, 13 Jun 2019 12:33:55 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-6-mreitz@redhat.com>
 <6ef1a5a1-756a-7a48-f386-517c6f46e69b@virtuozzo.com>
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
Message-ID: <2d0d8641-e404-3f0c-893e-88ac8f59f8ed@redhat.com>
Date: Thu, 13 Jun 2019 14:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6ef1a5a1-756a-7a48-f386-517c6f46e69b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xuCBaZBus1J6ee2QSZCWuDKQy1NMYSft7"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 13 Jun 2019 12:33:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 05/42] block: Add chain helper functions
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
--xuCBaZBus1J6ee2QSZCWuDKQy1NMYSft7
Content-Type: multipart/mixed; boundary="CU16mCgKjDDQoFtk8WuIkR5p1SZXMa5OG";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <2d0d8641-e404-3f0c-893e-88ac8f59f8ed@redhat.com>
Subject: Re: [PATCH v5 05/42] block: Add chain helper functions
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-6-mreitz@redhat.com>
 <6ef1a5a1-756a-7a48-f386-517c6f46e69b@virtuozzo.com>
In-Reply-To: <6ef1a5a1-756a-7a48-f386-517c6f46e69b@virtuozzo.com>

--CU16mCgKjDDQoFtk8WuIkR5p1SZXMa5OG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.06.19 14:26, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> Add some helper functions for skipping filters in a chain of block
>> nodes.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   include/block/block_int.h |  3 +++
>>   block.c                   | 55 +++++++++++++++++++++++++++++++++++++=
++
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 7ce71623f8..875a33f255 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1264,6 +1264,9 @@ BdrvChild *bdrv_filtered_child(BlockDriverState =
*bs);
>>   BdrvChild *bdrv_metadata_child(BlockDriverState *bs);
>>   BdrvChild *bdrv_storage_child(BlockDriverState *bs);
>>   BdrvChild *bdrv_primary_child(BlockDriverState *bs);
>> +BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
>> +BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs);
>> +BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
>>  =20
>>   static inline BlockDriverState *child_bs(BdrvChild *child)
>>   {
>> diff --git a/block.c b/block.c
>> index 724d8889a6..be18130944 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6494,3 +6494,58 @@ BdrvChild *bdrv_primary_child(BlockDriverState =
*bs)
>>   {
>>       return bdrv_filtered_rw_child(bs) ?: bs->file;
>>   }
>> +
>> +static BlockDriverState *bdrv_skip_filters(BlockDriverState *bs,
>> +                                           bool stop_on_explicit_filt=
er)
>> +{
>> +    BdrvChild *filtered;
>> +
>> +    if (!bs) {
>> +        return NULL;
>> +    }
>> +
>> +    while (!(stop_on_explicit_filter && !bs->implicit)) {
>> +        filtered =3D bdrv_filtered_rw_child(bs);
>> +        if (!filtered) {
>> +            break;
>> +        }
>> +        bs =3D filtered->bs;
>> +    }
>> +    /*
>> +     * Note that this treats nodes with bs->drv =3D=3D NULL
>=20
> as well as filters without filtered_rw child

A filter always must have a filtered_rw child, though.  So I don=E2=80=99=
t quite
understand what you mean here...

Max

>   as not being
>> +     * R/W filters (bs->drv =3D=3D NULL should be replaced by somethi=
ng
>> +     * else anyway).
>> +     * The advantage of this behavior is that this function will thus=

>> +     * always return a non-NULL value (given a non-NULL @bs).
>=20
> and this is the advantage of what I've written, not about bs->drv.
>=20
>> +     */
>> +
>> +    return bs;
>> +}
>> +
>> +/*
>> + * Return the first BDS that has not been added implicitly or that
>> + * does not have an RW-filtered child down the chain starting from @b=
s
>> + * (including @bs itself).
>> + */
>> +BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs)
>> +{
>> +    return bdrv_skip_filters(bs, true);
>> +}
>> +
>> +/*
>> + * Return the first BDS that does not have an RW-filtered child down
>> + * the chain starting from @bs (including @bs itself).
>> + */
>> +BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs)
>> +{
>> +    return bdrv_skip_filters(bs, false);
>> +}
>> +
>> +/*
>> + * For a backing chain, return the first non-filter backing image of
>> + * the first non-filter image.
>> + */
>> +BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs)
>> +{
>> +    return bdrv_skip_rw_filters(bdrv_filtered_cow_bs(bdrv_skip_rw_fil=
ters(bs)));
>> +}
>>
>=20
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20



--CU16mCgKjDDQoFtk8WuIkR5p1SZXMa5OG--

--xuCBaZBus1J6ee2QSZCWuDKQy1NMYSft7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CQrEACgkQ9AfbAGHV
z0DeDwgAu4VK62oWO02Bk49ZtMw3+si22I/D5f/ILoROAPGBI4txCdGtiS2Zw5gL
XL1QzVqIgFR4YpfUrOCeDi5hSGBMxW5+zKxcUhjV5jhJEwJs50Kq+n0nr+Izo/5T
g7fXW6sMC43iDMnpaYJBUwteqp9h46IDd3sAWsxpqdgSG7ons4Kv35/WsB76WVde
xBsYq2D0uCZZHk0tztloqnaUJIPEVvmd/Yv9H3EvnPJ2LCFnPCMOA5JJ6vF0acfH
WnuAWI66qpPZYPWM6oImQ31Jt+TPPEFeOCAc5jyaJ0fbArUKm81Y99fk+iFwBqzn
2SBBKlUJmP6xOhqmxMrqc4Vk71ZKhQ==
=cdA7
-----END PGP SIGNATURE-----

--xuCBaZBus1J6ee2QSZCWuDKQy1NMYSft7--

