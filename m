Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BD9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D6620684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D6620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxA36-0006tf-7D
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48628)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxA2W-0006PM-JT
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxA2V-0005qs-7U
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:07:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxA2R-0005mi-39; Mon, 12 Aug 2019 09:07:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09328306039A;
 Mon, 12 Aug 2019 13:07:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBA9F646B9;
 Mon, 12 Aug 2019 13:07:00 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-21-mreitz@redhat.com>
 <ff792d97-02aa-56f6-dc2c-39c25ebad96c@virtuozzo.com>
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
Message-ID: <9266d305-7290-a622-cbdc-04bc5c7bb820@redhat.com>
Date: Mon, 12 Aug 2019 15:06:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ff792d97-02aa-56f6-dc2c-39c25ebad96c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="osiR8o7nmg2RRhlnyv96ojh8oXwc5ZBtj"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 12 Aug 2019 13:07:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 20/42] block/snapshot: Fix fallback
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
--osiR8o7nmg2RRhlnyv96ojh8oXwc5ZBtj
Content-Type: multipart/mixed; boundary="Z2QWtKsAWCIrUZiPxhtSvZU4HdIdJltGg";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <9266d305-7290-a622-cbdc-04bc5c7bb820@redhat.com>
Subject: Re: [PATCH v6 20/42] block/snapshot: Fix fallback
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-21-mreitz@redhat.com>
 <ff792d97-02aa-56f6-dc2c-39c25ebad96c@virtuozzo.com>
In-Reply-To: <ff792d97-02aa-56f6-dc2c-39c25ebad96c@virtuozzo.com>

--Z2QWtKsAWCIrUZiPxhtSvZU4HdIdJltGg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.08.19 18:34, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 19:13, Max Reitz wrote:
>> If the top node's driver does not provide snapshot functionality and w=
e
>> want to fall back to a node down the chain, we need to snapshot all
>> non-COW children.  For simplicity's sake, just do not fall back if the=
re
>> is more than one such child.
>>
>> bdrv_snapshot_goto() becomes a bit weird because we may have to redire=
ct
>> the actual child pointer, so it only works if the fallback child is
>> bs->file or bs->backing (and then we have to find out which it is).
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/snapshot.c | 100 +++++++++++++++++++++++++++++++++++++--------=
--
>>   1 file changed, 79 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/snapshot.c b/block/snapshot.c
>> index f2f48f926a..35403c167f 100644
>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>> @@ -146,6 +146,32 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDrive=
rState *bs,
>>       return ret;
>>   }
>>  =20
>> +/**
>> + * Return the child BDS to which we can fall back if the given BDS
>> + * does not support snapshots.
>> + * Return NULL if there is no BDS to (safely) fall back to.
>> + */
>> +static BlockDriverState *bdrv_snapshot_fallback(BlockDriverState *bs)=

>> +{
>> +    BlockDriverState *child_bs =3D NULL;
>> +    BdrvChild *child;
>> +
>> +    QLIST_FOREACH(child, &bs->children, next) {
>> +        if (child =3D=3D bdrv_filtered_cow_child(bs)) {
>> +            /* Ignore: COW children need not be included in snapshots=
 */
>> +            continue;
>> +        }
>> +
>> +        if (child_bs) {
>> +            /* Cannot fall back to a single child if there are multip=
le */
>> +            return NULL;
>> +        }
>> +        child_bs =3D child->bs;
>> +    }
>> +
>> +    return child_bs;
>> +}
>> +
>>   int bdrv_can_snapshot(BlockDriverState *bs)
>>   {
>>       BlockDriver *drv =3D bs->drv;
>> @@ -154,8 +180,9 @@ int bdrv_can_snapshot(BlockDriverState *bs)
>>       }
>>  =20
>>       if (!drv->bdrv_snapshot_create) {
>> -        if (bs->file !=3D NULL) {
>> -            return bdrv_can_snapshot(bs->file->bs);
>> +        BlockDriverState *fallback_bs =3D bdrv_snapshot_fallback(bs);=

>> +        if (fallback_bs) {
>> +            return bdrv_can_snapshot(fallback_bs);
>>           }
>>           return 0;
>>       }
>> @@ -167,14 +194,15 @@ int bdrv_snapshot_create(BlockDriverState *bs,
>>                            QEMUSnapshotInfo *sn_info)
>>   {
>>       BlockDriver *drv =3D bs->drv;
>> +    BlockDriverState *fallback_bs =3D bdrv_snapshot_fallback(bs);
>>       if (!drv) {
>>           return -ENOMEDIUM;
>>       }
>>       if (drv->bdrv_snapshot_create) {
>>           return drv->bdrv_snapshot_create(bs, sn_info);
>>       }
>> -    if (bs->file) {
>> -        return bdrv_snapshot_create(bs->file->bs, sn_info);
>> +    if (fallback_bs) {
>> +        return bdrv_snapshot_create(fallback_bs, sn_info);
>>       }
>>       return -ENOTSUP;
>>   }
>> @@ -184,6 +212,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>>                          Error **errp)
>>   {
>>       BlockDriver *drv =3D bs->drv;
>> +    BlockDriverState *fallback_bs;
>>       int ret, open_ret;
>>  =20
>>       if (!drv) {
>> @@ -204,39 +233,66 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>>           return ret;
>>       }
>>  =20
>> -    if (bs->file) {
>> -        BlockDriverState *file;
>> -        QDict *options =3D qdict_clone_shallow(bs->options);
>> +    fallback_bs =3D bdrv_snapshot_fallback(bs);
>> +    if (fallback_bs) {
>> +        QDict *options;
>>           QDict *file_options;
>>           Error *local_err =3D NULL;
>> +        bool is_backing_child;
>> +        BdrvChild **child_pointer;
>> +
>> +        /*
>> +         * We need a pointer to the fallback child pointer, so let us=

>> +         * see whether the child is referenced by a field in the BDS
>> +         * object.
>> +         */
>> +        if (fallback_bs =3D=3D bs->file->bs) {
>> +            is_backing_child =3D false;
>> +            child_pointer =3D &bs->file;
>> +        } else if (fallback_bs =3D=3D bs->backing->bs) {
>> +            is_backing_child =3D true;
>> +            child_pointer =3D &bs->backing;
>> +        } else {
>> +            /*
>> +             * The fallback child is not referenced by a field in the=

>> +             * BDS object.  We cannot go on then.
>> +             */
>> +            error_setg(errp, "Block driver does not support snapshots=
");
>> +            return -ENOTSUP;
>> +        }
>> +
>=20
> Hmm.. Should not this check be included into bdrv_snapshot_fallback(), =
to
> work only with file and backing?

I was under the impression that this was just special code for what
turned out to be bdrv_snapshot_load_tmp() now, because it seems so
weird.  (So I thought just making the restriction here wouldn=E2=80=99t r=
eally
be a limit.)

I was wrong.  This is used when applying snapshots, so it is important.
 If we make a restriction here, we should have it in all fallback code, y=
es.

> And could we allow fallback only for filters? Is there real usecase exc=
ept filters?
> Or may be, drop fallback at all?

raw isn=E2=80=99t a filter driver.  And rbd as a protocol supports snapsh=
otting.
 Hence the fallback code, I presume.

Max


--Z2QWtKsAWCIrUZiPxhtSvZU4HdIdJltGg--

--osiR8o7nmg2RRhlnyv96ojh8oXwc5ZBtj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RZHMACgkQ9AfbAGHV
z0BFNggAiwczDBsUjPfOZT2pNQatkU8g8NSKE6+eTuoX0RzocKew3URUvxWXeIFT
9UM6sXgDkleCLLzOBjX99qLSAl2RaRaVXpxrpXLooHtEG953rp/8Ulbyt+VC4UQQ
kVefJzV7Qb+5BJgukCPU6zZN6/KWHcD5VfZ3vwcQkOvX9ID2a270fvnYGxllAwHB
RJ5oWmgrxbeD3FoUp5motONxLGFSfscDxxLTMbNYu1wuWq6rWKLOJqHFIdkFMrOV
cGSSaA7gt+vM2jCBFloJv0oGz2H57mCAGchP7kk8ltM4hMvSHy1shPLMu7uVjmjb
u1uIYztyPkFBFKole8IDTpGj+EHAOA==
=YhT/
-----END PGP SIGNATURE-----

--osiR8o7nmg2RRhlnyv96ojh8oXwc5ZBtj--

