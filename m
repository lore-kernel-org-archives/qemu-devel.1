Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699FEC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432A6213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432A6213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58830 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdFix-0001Zv-FF
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35045)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdF07-0005KI-6p
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdF05-00064F-I4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdF01-0005zm-W3; Tue, 18 Jun 2019 10:22:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35FDA80F7C;
 Tue, 18 Jun 2019 14:22:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
 [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E39815F7DA;
 Tue, 18 Jun 2019 14:22:06 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-25-mreitz@redhat.com>
 <7cdd5863-e420-4816-7ca4-0148dd63993b@virtuozzo.com>
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
Message-ID: <f8f402c3-193f-b904-5856-3fb5489577bf@redhat.com>
Date: Tue, 18 Jun 2019 16:22:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7cdd5863-e420-4816-7ca4-0148dd63993b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JsYfoISUCnJDCy8AiRE063CF0PyOGFdl3"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 18 Jun 2019 14:22:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 24/42] block: Use child access functions
 for QAPI queries
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
--JsYfoISUCnJDCy8AiRE063CF0PyOGFdl3
Content-Type: multipart/mixed; boundary="5j99ngT5UA7xT4AGYNq4G2hmwpbCl0LFK";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <f8f402c3-193f-b904-5856-3fb5489577bf@redhat.com>
Subject: Re: [PATCH v5 24/42] block: Use child access functions for QAPI
 queries
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-25-mreitz@redhat.com>
 <7cdd5863-e420-4816-7ca4-0148dd63993b@virtuozzo.com>
In-Reply-To: <7cdd5863-e420-4816-7ca4-0148dd63993b@virtuozzo.com>

--5j99ngT5UA7xT4AGYNq4G2hmwpbCl0LFK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.06.19 14:06, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> query-block and query-named-block-nodes now return any filtered child
>> under "backing", not just bs->backing or COW children.  This is so tha=
t
>> filters do not interrupt the reported backing chain.  This changes the=

>> output for iotest 184, as the throttled node now appears as a backing
>> child.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/qapi.c               | 35 ++++++++++++++++++++---------------
>>   tests/qemu-iotests/184.out |  7 ++++++-
>>   2 files changed, 26 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/qapi.c b/block/qapi.c
>> index 0c13c86f4e..1fd2937abc 100644
>> --- a/block/qapi.c
>> +++ b/block/qapi.c
>> @@ -150,9 +150,13 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBack=
end *blk,
>>               return NULL;
>>           }
>>  =20
>> -        if (bs0->drv && bs0->backing) {
>> +        if (bs0->drv && bdrv_filtered_child(bs0)) {
>> +            /*
>> +             * Put any filtered child here (for backwards compatibili=
ty to when
>> +             * we put bs0->backing here, which might be any filtered =
child).
>> +             */
>>               info->backing_file_depth++;
>> -            bs0 =3D bs0->backing->bs;
>> +            bs0 =3D bdrv_filtered_bs(bs0);
>=20
>=20
> so, here we report all filtered filter children as backing ...
>=20
>>               (*p_image_info)->has_backing_image =3D true;
>>               p_image_info =3D &((*p_image_info)->backing_image);
>>           } else {
>> @@ -161,9 +165,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBacke=
nd *blk,
>>  =20
>>           /* Skip automatically inserted nodes that the user isn't awa=
re of for
>>            * query-block (blk !=3D NULL), but not for query-named-bloc=
k-nodes */
>> -        while (blk && bs0->drv && bs0->implicit) {
>> -            bs0 =3D backing_bs(bs0);
>> -            assert(bs0);
>> +        if (blk) {
>> +            bs0 =3D bdrv_skip_implicit_filters(bs0);
>>           }
>>       }
>>  =20
>> @@ -348,9 +351,9 @@ static void bdrv_query_info(BlockBackend *blk, Blo=
ckInfo **p_info,
>>       BlockDriverState *bs =3D blk_bs(blk);
>>       char *qdev;
>>  =20
>> -    /* Skip automatically inserted nodes that the user isn't aware of=
 */
>> -    while (bs && bs->drv && bs->implicit) {
>> -        bs =3D backing_bs(bs);
>> +    if (bs) {
>> +        /* Skip automatically inserted nodes that the user isn't awar=
e of */
>> +        bs =3D bdrv_skip_implicit_filters(bs);
>>       }
>>  =20
>>       info->device =3D g_strdup(blk_name(blk));
>> @@ -507,6 +510,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats =
*ds, BlockBackend *blk)
>>   static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
>>                                           bool blk_level)
>>   {
>> +    BlockDriverState *storage_bs, *cow_bs;
>>       BlockStats *s =3D NULL;
>>  =20
>>       s =3D g_malloc0(sizeof(*s));
>> @@ -519,9 +523,8 @@ static BlockStats *bdrv_query_bds_stats(BlockDrive=
rState *bs,
>>       /* Skip automatically inserted nodes that the user isn't aware o=
f in
>>        * a BlockBackend-level command. Stay at the exact node for a no=
de-level
>>        * command. */
>> -    while (blk_level && bs->drv && bs->implicit) {
>> -        bs =3D backing_bs(bs);
>> -        assert(bs);
>> +    if (blk_level) {
>> +        bs =3D bdrv_skip_implicit_filters(bs);
>>       }
>>  =20
>>       if (bdrv_get_node_name(bs)[0]) {
>> @@ -531,14 +534,16 @@ static BlockStats *bdrv_query_bds_stats(BlockDri=
verState *bs,
>>  =20
>>       s->stats->wr_highest_offset =3D stat64_get(&bs->wr_highest_offse=
t);
>>  =20
>> -    if (bs->file) {
>> +    storage_bs =3D bdrv_storage_bs(bs);
>> +    if (storage_bs) {
>>           s->has_parent =3D true;
>> -        s->parent =3D bdrv_query_bds_stats(bs->file->bs, blk_level);
>> +        s->parent =3D bdrv_query_bds_stats(storage_bs, blk_level);
>=20
> ... and here not as "backing" but as "parent"
>=20
> Shouldn't we report filter-child as backing here too, for consistency?

My idea here was that it compatibility is not that important, it=E2=80=99=
s just
stats, after all.  Well, wr_highest_offset is kind of important, but
that doesn=E2=80=99t matter for a backing file.

So I decided to implement here what actually makes sense.  But maybe I
was actually wrong about =E2=80=9Cwhat makes sense=E2=80=9D.  It doesn=E2=
=80=99t make much sense
to interrupt the backing chain here because of a filter...  Maybe the
s->backing field should always be the next non-implicit element in the
backing chain?  (So that may be duplicated in s->parent and s->backing,
but actually, so what.)

Max

> anyway:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>>       }
>>  =20
>> -    if (blk_level && bs->backing) {
>> +    cow_bs =3D bdrv_filtered_cow_bs(bs);
>> +    if (blk_level && cow_bs) {
>>           s->has_backing =3D true;
>> -        s->backing =3D bdrv_query_bds_stats(bs->backing->bs, blk_leve=
l);
>> +        s->backing =3D bdrv_query_bds_stats(cow_bs, blk_level);
>>       }
>>  =20
>>       return s;
>> diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
>> index 3deb3cfb94..1d61f7e224 100644
>> --- a/tests/qemu-iotests/184.out
>> +++ b/tests/qemu-iotests/184.out
>> @@ -27,6 +27,11 @@ Testing:
>>               "iops_rd": 0,
>>               "detect_zeroes": "off",
>>               "image": {
>> +                "backing-image": {
>> +                    "virtual-size": 1073741824,
>> +                    "filename": "null-co://",
>> +                    "format": "null-co"
>> +                },
>>                   "virtual-size": 1073741824,
>>                   "filename": "json:{\"throttle-group\": \"group0\", \=
"driver\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
>>                   "format": "throttle"
>> @@ -34,7 +39,7 @@ Testing:
>>               "iops_wr": 0,
>>               "ro": false,
>>               "node-name": "throttle0",
>> -            "backing_file_depth": 0,
>> +            "backing_file_depth": 1,
>>               "drv": "throttle",
>>               "iops": 0,
>>               "bps_wr": 0,
>>
>=20
>=20



--5j99ngT5UA7xT4AGYNq4G2hmwpbCl0LFK--

--JsYfoISUCnJDCy8AiRE063CF0PyOGFdl3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0I840ACgkQ9AfbAGHV
z0Ah1gf+NLZ8T1o/bGPkH58gc8BtkATwLQyDjeTxgPrUazGd1es/k0pFT9hxZoFS
yvhRXW9Xs+xxtXMBWjvf2tY86BrPBaetNV3XkTYoqiokvcCjU1/lY6H1SpN59H4F
2mS8dj8dqzIXoq2I+8g066UqD0ud5a5dI4/GS53DPMYsIedHBraDPxbqsceSsJdh
aKNnIQJ2UxmVhGscb20S2yuaUYO9B4+kZtn/RgiUh5JSe0eHrvrYzsfanXMLHW8j
w/0hexID9W+nYVapAJ9L+fkCKkp7pM0+l4A+XyOHNTE7g/rd6UgiIZ+Ygut1NZxc
Hd22z3u6KQzZfBWmK+2hWmGeghDsNw==
=EZ6x
-----END PGP SIGNATURE-----

--JsYfoISUCnJDCy8AiRE063CF0PyOGFdl3--

