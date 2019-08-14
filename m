Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1CEC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C0C20665
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C0C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxw5v-0002RZ-5O
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 12:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hxw4w-0001Ff-0d
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxw4v-0001E2-49
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:24:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxw4r-0001AJ-Lp; Wed, 14 Aug 2019 12:24:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4C68302C075;
 Wed, 14 Aug 2019 16:24:44 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8143F87B8;
 Wed, 14 Aug 2019 16:24:40 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-5-vsementsov@virtuozzo.com>
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
Message-ID: <d435e9d2-f078-3167-ad79-e2f21a34f033@redhat.com>
Date: Wed, 14 Aug 2019 18:24:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730141826.709849-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="etl8aDlKGy1j2e1pheHhFqi01qgrGFGfZ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 14 Aug 2019 16:24:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/4] block/qcow2: introduce parallel
 subrequest handling in read and write
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--etl8aDlKGy1j2e1pheHhFqi01qgrGFGfZ
Content-Type: multipart/mixed; boundary="napUPjDuaMbsyRabN273iH7y2Q1Pw1FbS";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, kwolf@redhat.com, den@openvz.org,
 stefanha@redhat.com
Message-ID: <d435e9d2-f078-3167-ad79-e2f21a34f033@redhat.com>
Subject: Re: [PATCH v2 4/4] block/qcow2: introduce parallel subrequest
 handling in read and write
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190730141826.709849-5-vsementsov@virtuozzo.com>

--napUPjDuaMbsyRabN273iH7y2Q1Pw1FbS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 16:18, Vladimir Sementsov-Ogievskiy wrote:
> It improves performance for fragmented qcow2 images.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.c      | 125 +++++++++++++++++++++++++++++++++++++++++----=

>  block/trace-events |   1 +
>  2 files changed, 115 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 37766b8b7c..5f0e66ea48 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -2017,6 +2018,62 @@ fail:
>      return ret;
>  }
> =20
> +typedef struct Qcow2AioTask {
> +    AioTask task;
> +
> +    BlockDriverState *bs;
> +    QCow2ClusterType cluster_type; /* only for read */
> +    uint64_t file_cluster_offset;
> +    uint64_t offset;
> +    uint64_t bytes;
> +    QEMUIOVector *qiov;
> +    uint64_t qiov_offset;
> +    QCowL2Meta *l2meta; /* only for write */
> +} Qcow2AioTask;
> +
> +#define QCOW2_MAX_WORKERS 8

Maybe move this to the top, or even qcow2.h?

[...]

> @@ -2112,7 +2182,16 @@ static coroutine_fn int qcow2_co_preadv_part(Blo=
ckDriverState *bs,
>          qiov_offset +=3D cur_bytes;
>      }
> =20
> -    return 0;
> +out:
> +    if (aio) {
> +        aio_task_pool_wait_all(aio);
> +        if (ret =3D=3D 0) {
> +            ret =3D aio_task_pool_status(aio);
> +        }
> +        g_free(aio);
> +    }
> +
> +    return ret;

My gcc complains here that ret may be initialized.  (Which is indeed the
case if @bytes is 0.)

The rest looks good to me.

Max


--napUPjDuaMbsyRabN273iH7y2Q1Pw1FbS--

--etl8aDlKGy1j2e1pheHhFqi01qgrGFGfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1UNcYACgkQ9AfbAGHV
z0BhrwgAtcXmPWBPhOLzYk/BDuC7Ze7AvuLEpQHYJLLtOrehuTlAlxdKYJXAQz3l
akWnEWYwRyL4SEyq1pD9Crn381xipnlIw4lnqDuYhQ7oKer3/YoKwMNr8HxjmmmE
gzgXljLEmJROwJfo+pDfNp4mVcE3QZYcKTp3H8muxuEAVv3TnQgkpPsTenXhZCKg
/1ZZL+fNqOvzMfbDhqEW2IVvZ/iYXpEfOKxjxqPUyLJtLph8hbhAggniRILBu0WQ
E2y4nKCbnzX4Vpb8DIQboS+HPHfUtjfincrHp0iJaVbKnylom+09jVI45Gn/hq78
BpIC+sBKGg781EzJVlurs2W6w12HcQ==
=aGVq
-----END PGP SIGNATURE-----

--etl8aDlKGy1j2e1pheHhFqi01qgrGFGfZ--

