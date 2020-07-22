Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063ABC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B832D20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyenCBvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B832D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCvw-0006sh-Rg
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyCvM-0006PA-GY
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:28:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29768
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyCvK-0000Oi-VF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595417314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mKJIng+251aCBMaHhOpcZ6u/GPos32Cz/FEZh4rFzh0=;
 b=dyenCBvRkdSi/Rg0V4VPPCVo6uK10ul/dtD/nVwfhs6AVqtiXmxMD4Bxl2V54QbAmaJpid
 jporROw1Ky5AyZjgYiKMg7foX1587ARH4OWRZXhI6T/LTnCPndgcsxefglca8O6mlKe2YU
 x4gLQhI3Bum8sBHi2dvm39t12Dd3gCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-l3xoLQFhOneOc_gkl9tNTQ-1; Wed, 22 Jul 2020 07:28:30 -0400
X-MC-Unique: l3xoLQFhOneOc_gkl9tNTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2783100AA2F;
 Wed, 22 Jul 2020 11:28:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-86.ams2.redhat.com
 [10.36.113.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A690160C05;
 Wed, 22 Jul 2020 11:28:26 +0000 (UTC)
Subject: Re: [PATCH v2 08/20] block/block-copy: add block_copy_cancel
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-9-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <93e0a82c-71eb-66f3-cf02-a06e3be7c9e8@redhat.com>
Date: Wed, 22 Jul 2020 13:28:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-9-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GI52Fliafcaz8vI85xcPHgQDWf9Pr48S2"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GI52Fliafcaz8vI85xcPHgQDWf9Pr48S2
Content-Type: multipart/mixed; boundary="osA5peRKeKsDMnY0WSrOVdN7Eg68bffUw"

--osA5peRKeKsDMnY0WSrOVdN7Eg68bffUw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> Add function to cancel running async block-copy call. It will be used
> in backup.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block-copy.h |  7 +++++++
>  block/block-copy.c         | 22 +++++++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index d40e691123..370a194d3c 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -67,6 +67,13 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s=
,
>  void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_st=
ate,
>                            uint64_t speed);
> =20
> +/*
> + * Cancel running block-copy call.
> + * Cancel leaves block-copy state valid: dirty bits are correct and you =
may use
> + * cancel + <run block_copy with same parameters> to emulate pause/resum=
e.
> + */
> +void block_copy_cancel(BlockCopyCallState *call_state);
> +
>  BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
>  void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
> =20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 851d9c8aaf..b551feb6c2 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -44,6 +44,8 @@ typedef struct BlockCopyCallState {
>      bool failed;
>      bool finished;
>      QemuCoSleepState *sleep_state;
> +    bool cancelled;
> +    Coroutine *canceller;
> =20
>      /* OUT parameters */
>      bool error_is_read;
> @@ -582,7 +584,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_st=
ate)
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>      assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
> =20
> -    while (bytes && aio_task_pool_status(aio) =3D=3D 0) {
> +    while (bytes && aio_task_pool_status(aio) =3D=3D 0 && !call_state->c=
ancelled) {
>          BlockCopyTask *task;
>          int64_t status_bytes;
> =20
> @@ -693,7 +695,7 @@ static int coroutine_fn block_copy_common(BlockCopyCa=
llState *call_state)
>      do {
>          ret =3D block_copy_dirty_clusters(call_state);
> =20
> -        if (ret =3D=3D 0) {
> +        if (ret =3D=3D 0 && !call_state->cancelled) {
>              ret =3D block_copy_wait_one(call_state->s, call_state->offse=
t,
>                                        call_state->bytes);
>          }
> @@ -707,13 +709,18 @@ static int coroutine_fn block_copy_common(BlockCopy=
CallState *call_state)
>           * 2. We have waited for some intersecting block-copy request
>           *    It may have failed and produced new dirty bits.
>           */
> -    } while (ret > 0);
> +    } while (ret > 0 && !call_state->cancelled);

Would it be cleaner if block_copy_dirty_cluster() just returned
-ECANCELED?  Or would that pose a problem for its callers or the async
callback?

>      if (call_state->cb) {
>          call_state->cb(ret, call_state->error_is_read,
>                         call_state->s->progress_opaque);
>      }
> =20
> +    if (call_state->canceller) {
> +        aio_co_wake(call_state->canceller);
> +        call_state->canceller =3D NULL;
> +    }
> +
>      call_state->finished =3D true;
> =20
>      return ret;


--osA5peRKeKsDMnY0WSrOVdN7Eg68bffUw--

--GI52Fliafcaz8vI85xcPHgQDWf9Pr48S2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8YItkACgkQ9AfbAGHV
z0CnKAf4qGAQPmvH39QDaChuayRqj/JVuVLr+pB1hMuh/sKlOglUomdo0fCnsHn8
cWgUffAoWuq/8a9Q3Drr19rawZg7htnie8K0lXRFJ9wqVLicHsqa4k2AEvzPkqWe
kQQxQf/O0bKhDYwHYeOfzFeONGjdQFCsH4DYacjvmuiDEwOAUR6/Nibe+6SOOToc
2z2nDfguaIdvPIabAmU0Zpt/6LQApARUrFFtShz/Id29u/6wq6xp0IIVtSWTmQmA
F7Bu5LM07Y7fqqXUGHy+vJZ2rloyqp9CwOs6goj1RyGE4VvIs+O6TS6cdbH7BQpZ
iGFyG04Z4GwZNko07G6wffk/pdar
=WrG7
-----END PGP SIGNATURE-----

--GI52Fliafcaz8vI85xcPHgQDWf9Pr48S2--


