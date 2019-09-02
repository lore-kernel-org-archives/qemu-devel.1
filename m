Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A097C3A5A5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025012173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025012173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4nkh-0001RL-4d
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 10:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i4njl-0000dh-60
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i4njj-0003SC-Sz
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:55:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i4njg-0003Dg-26; Mon, 02 Sep 2019 10:55:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AAF8C18C8908;
 Mon,  2 Sep 2019 14:55:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-221.brq.redhat.com
 [10.40.204.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 698951001947;
 Mon,  2 Sep 2019 14:55:13 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-28-mreitz@redhat.com>
 <64a06bc9-ba3a-b666-1d49-e263614d4566@virtuozzo.com>
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
Message-ID: <232f0d57-9c33-e1ef-c6a4-d4be3a4aae13@redhat.com>
Date: Mon, 2 Sep 2019 16:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <64a06bc9-ba3a-b666-1d49-e263614d4566@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="62t3MByb5w85FhdTyQOf5HnonJLQLVoIs"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 02 Sep 2019 14:55:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 27/42] commit: Deal with filters
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
--62t3MByb5w85FhdTyQOf5HnonJLQLVoIs
Content-Type: multipart/mixed; boundary="kFjmVcwtqZo6b9vDt2buTmy4PYBNSbIBh";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <232f0d57-9c33-e1ef-c6a4-d4be3a4aae13@redhat.com>
Subject: Re: [PATCH v6 27/42] commit: Deal with filters
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-28-mreitz@redhat.com>
 <64a06bc9-ba3a-b666-1d49-e263614d4566@virtuozzo.com>
In-Reply-To: <64a06bc9-ba3a-b666-1d49-e263614d4566@virtuozzo.com>

--kFjmVcwtqZo6b9vDt2buTmy4PYBNSbIBh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.08.19 12:44, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 19:13, Max Reitz wrote:
>> This includes some permission limiting (for example, we only need to
>> take the RESIZE permission if the base is smaller than the top).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/block-backend.c | 16 +++++---
>>   block/commit.c        | 96 +++++++++++++++++++++++++++++++----------=
--
>>   blockdev.c            |  6 ++-
>>   3 files changed, 85 insertions(+), 33 deletions(-)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index c13c5c83b0..0bc592d023 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -2180,11 +2180,17 @@ int blk_commit_all(void)
>>           AioContext *aio_context =3D blk_get_aio_context(blk);
>>  =20
>>           aio_context_acquire(aio_context);
>> -        if (blk_is_inserted(blk) && blk->root->bs->backing) {
>> -            int ret =3D bdrv_commit(blk->root->bs);
>> -            if (ret < 0) {
>> -                aio_context_release(aio_context);
>> -                return ret;
>> +        if (blk_is_inserted(blk)) {
>> +            BlockDriverState *non_filter;
>> +
>> +            /* Legacy function, so skip implicit filters */
>> +            non_filter =3D bdrv_skip_implicit_filters(blk->root->bs);=

>> +            if (bdrv_filtered_cow_child(non_filter)) {
>> +                int ret =3D bdrv_commit(non_filter);
>> +                if (ret < 0) {
>> +                    aio_context_release(aio_context);
>> +                    return ret;
>> +                }
>>               }
>=20
> and if non_filter is explicit filter we just skip it. I think we'd bett=
er return
> error in this case. For example, just drop if (bdrv_filtered_cow_child)=
 and get
> ENOTSUP from bdrv_commit in this case.

Sounds good, yes.

> And with at least this fixed I'm OK with this patch:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> However some comments below:
>=20
>>           }
>>           aio_context_release(aio_context);
>> diff --git a/block/commit.c b/block/commit.c
>> index 5a7672c7c7..40d1c8eeac 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -37,6 +37,7 @@ typedef struct CommitBlockJob {
>>       BlockBackend *top;
>>       BlockBackend *base;
>>       BlockDriverState *base_bs;
>> +    BlockDriverState *above_base;
>=20
> you called it base_overlay in mirror, seems better to keep same naming

Indeed.

[...]

>> @@ -315,17 +336,43 @@ void commit_start(const char *job_id, BlockDrive=
rState *bs,
>>  =20
>>       s->commit_top_bs =3D commit_top_bs;
>>  =20
>> -    /* Block all nodes between top and base, because they will
>> -     * disappear from the chain after this operation. */
>> -    assert(bdrv_chain_contains(top, base));
>> -    for (iter =3D top; iter !=3D base; iter =3D backing_bs(iter)) {
>> -        /* XXX BLK_PERM_WRITE needs to be allowed so we don't block o=
urselves
>> -         * at s->base (if writes are blocked for a node, they are als=
o blocked
>> -         * for its backing file). The other options would be a second=
 filter
>> -         * driver above s->base. */
>=20
> This code part is absolutely equal to corresponding in block/mirror.c..=
 It would be great
> to put it into a function and reuse. However its not about these series=
=2E

It would probably be great to just drop block/commit.c altogether and
fully merge it into block/mirror.c at some point.

(I suppose we=E2=80=99d just have to check whether there=E2=80=99s any pa=
rent who=E2=80=99s
taken the WRITE permission on the top node, and if so, emit READY (and
if not, skip to COMPLETED).)

[...]

>> @@ -412,19 +457,22 @@ int bdrv_commit(BlockDriverState *bs)
>>       if (!drv)
>>           return -ENOMEDIUM;
>>  =20
>> -    if (!bs->backing) {
>> +    backing_file_bs =3D bdrv_filtered_cow_bs(bs);
>=20
> Hmm just note: if in future we'll have cow child which is not bs->backi=
ng, a lot of code will
> fail, as we always assume that cow child is bs->backing. May be, this s=
hould be commented in
> bdrv_filtered_cow_child implementation.

I couldn=E2=80=99t see why we=E2=80=99d ever do this.  I hope we never do=
=2E

(Aside from just removing bs->file and bs->backing altogether.)

Max


--kFjmVcwtqZo6b9vDt2buTmy4PYBNSbIBh--

--62t3MByb5w85FhdTyQOf5HnonJLQLVoIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1tLU8ACgkQ9AfbAGHV
z0CgjQgAhmZ4oPEVASyem4SgCkvcUlFLJkT5FpFNrf+mfQqh3bZCO18mY8R1JHRY
jK9oNPRqH/cEh2TImVOdnXp9Cqnu0lS4OBgx9Y4SDa26IPLdkjP/XV7LBr6DPZ2F
RSyIoBmUvkfbWMZtoKYDVgQ+rF3jsZzN4uaDDwoqMHRK6E/2URPLB0ZrSHclrxdv
Nrmqls37amK2tqBEXh5WkXmym2RjVSgpDa7BJ9qDBGLssFj3C1wLEFrQPTIObRGo
R0/vh42u8GUJbkFkTbOuNzYOylnBRClH+MjOdStp2WNvAdobonnaINnk436v0Kf+
WX+J2881JJOgWa7TxsTLlLKrvjf4Gw==
=lyOj
-----END PGP SIGNATURE-----

--62t3MByb5w85FhdTyQOf5HnonJLQLVoIs--

