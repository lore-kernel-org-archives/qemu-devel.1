Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B927C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2200C2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2200C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboaK-0008LG-8r
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hboYB-0006Ta-PT
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hboY1-0002Tf-2g
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:55:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hboXv-0002Qr-WF; Fri, 14 Jun 2019 11:55:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AE5B3082B5F;
 Fri, 14 Jun 2019 15:55:18 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCA331001B37;
 Fri, 14 Jun 2019 15:55:16 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-17-mreitz@redhat.com>
 <d3a6b385-6aa5-cec0-268a-5f6c3e2075c2@virtuozzo.com>
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
Message-ID: <8f86527e-2d2b-81d8-95e3-d458113c70ba@redhat.com>
Date: Fri, 14 Jun 2019 17:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d3a6b385-6aa5-cec0-268a-5f6c3e2075c2@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tQqEbk6d9Q4F66P4jNivH267S9rnQSE1r"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 14 Jun 2019 15:55:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 16/42] block: Use child access functions
 when flushing
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
--tQqEbk6d9Q4F66P4jNivH267S9rnQSE1r
Content-Type: multipart/mixed; boundary="w16PUQPZKF0GYbSTk1vlido4UwGpFx9qc";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <8f86527e-2d2b-81d8-95e3-d458113c70ba@redhat.com>
Subject: Re: [PATCH v5 16/42] block: Use child access functions when flushing
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-17-mreitz@redhat.com>
 <d3a6b385-6aa5-cec0-268a-5f6c3e2075c2@virtuozzo.com>
In-Reply-To: <d3a6b385-6aa5-cec0-268a-5f6c3e2075c2@virtuozzo.com>

--w16PUQPZKF0GYbSTk1vlido4UwGpFx9qc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 16:01, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> If the driver does not support .bdrv_co_flush() so bdrv_co_flush()
>> itself has to flush the children of the given node, it should not flus=
h
>> just bs->file->bs, but in fact both the child that stores data, and th=
e
>> one that stores metadata (if they are separate).
>>
>> In any case, the BLKDBG_EVENT() should be emitted on the primary child=
,
>> because that is where a blkdebug node would be if there is any.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/io.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 53aabf86b5..64408cf19a 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -2533,6 +2533,8 @@ static void coroutine_fn bdrv_flush_co_entry(voi=
d *opaque)
>>  =20
>>   int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>>   {
>> +    BdrvChild *primary_child =3D bdrv_primary_child(bs);
>> +    BlockDriverState *storage_bs, *metadata_bs;
>>       int current_gen;
>>       int ret =3D 0;
>>  =20
>> @@ -2562,7 +2564,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState =
*bs)
>>       }
>>  =20
>>       /* Write back cached data to the OS even with cache=3Dunsafe */
>> -    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_OS);
>> +    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
>>       if (bs->drv->bdrv_co_flush_to_os) {
>>           ret =3D bs->drv->bdrv_co_flush_to_os(bs);
>>           if (ret < 0) {
>> @@ -2580,7 +2582,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState =
*bs)
>>           goto flush_parent;
>>       }
>>  =20
>> -    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
>> +    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
>>       if (!bs->drv) {
>>           /* bs->drv->bdrv_co_flush() might have ejected the BDS
>>            * (even in case of apparent success) */
>> @@ -2625,7 +2627,20 @@ int coroutine_fn bdrv_co_flush(BlockDriverState=
 *bs)
>>        * in the case of cache=3Dunsafe, so there are no useless flushe=
s.
>>        */
>>   flush_parent:
>> -    ret =3D bs->file ? bdrv_co_flush(bs->file->bs) : 0;
>> +    storage_bs =3D bdrv_storage_bs(bs);
>> +    metadata_bs =3D bdrv_metadata_bs(bs);
>> +
>> +    ret =3D 0;
>> +    if (storage_bs) {
>> +        ret =3D bdrv_co_flush(storage_bs);
>> +    }
>> +    if (metadata_bs && metadata_bs !=3D storage_bs) {
>> +        int ret_metadata =3D bdrv_co_flush(metadata_bs);
>> +        if (!ret) {
>> +            ret =3D ret_metadata;
>> +        }
>> +    }
>> +
>>   out:
>>       /* Notify any pending flushes that we have completed */
>>       if (ret =3D=3D 0) {
>>
>=20
> Hmm, I'm not sure that if in one driver we decided to store data and me=
tadata separately,
> we need to support flushing them both generic code.. If at some point q=
cow2 decides store part
> of metadata in third child, we will not flush it here too?
>=20
> Should not we instead loop through children and flush all? And I'd s/fl=
ush_parent/flush_children as
> it is rather weird.

That sounds good.  Well, we only need to flush the ones the driver has
taken a WRITE permission on, but yes.

Max


--w16PUQPZKF0GYbSTk1vlido4UwGpFx9qc--

--tQqEbk6d9Q4F66P4jNivH267S9rnQSE1r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Dw2MACgkQ9AfbAGHV
z0BriQf+I+RqKlyGC7iQ/PJf1ORJ1lgOGRcV10MFuhWrm2lo0FvhuOvr5XbikWQf
FRXKnJxmShgdZwxPGuVkrrjCcOdeKu0Bb3/C2+zoksHwQfTzUwMWB+Q5R0vDzY10
vpGA8o8UN/kX72xlFJABrodEP6GSpc3EaUU4QeSzUe2O3LFUV91Dvr+EexITjsJq
6Yh85UKOO/E7H3jB/Cv2TvkA71VmIow+7G0FqLvGWOQ8n/9qzWZICFnDV46vv9ur
ywGSDDMc2aN2ts7nmWsSlRMOykCn5vVxT1yXnbzw0R90IwrGPv9LNtxV+1WaUbaL
cSnISikwo31LRDIihIC51h4tZ//JdA==
=gbKy
-----END PGP SIGNATURE-----

--tQqEbk6d9Q4F66P4jNivH267S9rnQSE1r--

