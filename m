Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F46C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 21:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC9720665
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 21:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC9720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxeOf-0006G1-PH
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 17:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45767)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxeO8-0005lA-Gk
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 17:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxeO7-0004wN-9T
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 17:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxeO4-0004sO-Nm; Tue, 13 Aug 2019 17:31:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD6543082E20;
 Tue, 13 Aug 2019 21:31:23 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9109D1F2;
 Tue, 13 Aug 2019 21:31:19 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-3-vsementsov@virtuozzo.com>
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
Message-ID: <ead713c5-ed20-096c-40cb-a4bb4b3658a6@redhat.com>
Date: Tue, 13 Aug 2019 23:31:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730141826.709849-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YXsDOdauwlffwXMJX0H3dJQSjqHkhuEIL"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 13 Aug 2019 21:31:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block/qcow2: refactor
 qcow2_co_preadv_part
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
--YXsDOdauwlffwXMJX0H3dJQSjqHkhuEIL
Content-Type: multipart/mixed; boundary="C04Jbs1sWTN9ksdTAQh8ywXsqC9UiF6Qc";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, kwolf@redhat.com, den@openvz.org,
 stefanha@redhat.com
Message-ID: <ead713c5-ed20-096c-40cb-a4bb4b3658a6@redhat.com>
Subject: Re: [PATCH v2 2/4] block/qcow2: refactor qcow2_co_preadv_part
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190730141826.709849-3-vsementsov@virtuozzo.com>

--C04Jbs1sWTN9ksdTAQh8ywXsqC9UiF6Qc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 16:18, Vladimir Sementsov-Ogievskiy wrote:
> Further patch will run partial requests of iterations of
> qcow2_co_preadv in parallel for performance reasons. To prepare for
> this, separate part which may be parallelized into separate function
> (qcow2_co_preadv_task).
>=20
> While being here, also separate encrypted clusters reading to own
> function, like it is done for compressed reading.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json |   2 +-
>  block/qcow2.c        | 206 +++++++++++++++++++++++--------------------=

>  2 files changed, 112 insertions(+), 96 deletions(-)

Looks good to me overall, just wondering about some details, as always.

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 93ab7edcea..7fa71968b2 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1967,17 +1967,115 @@ out:
>      return ret;
>  }
> =20
> +static coroutine_fn int
> +qcow2_co_preadv_encrypted(BlockDriverState *bs,
> +                           uint64_t file_cluster_offset,
> +                           uint64_t offset,
> +                           uint64_t bytes,
> +                           QEMUIOVector *qiov,
> +                           uint64_t qiov_offset)
> +{
> +    int ret;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint8_t *buf;
> +
> +    assert(bs->encrypted && s->crypto);
> +    assert(bytes <=3D QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
> +
> +    /*
> +     * For encrypted images, read everything into a temporary
> +     * contiguous buffer on which the AES functions can work.
> +     * Note, that we can implement enctyption, working on qiov,

-, and s/enctyption/encryption/

> +     * but we must not do decryption in guest buffers for security
> +     * reasons.

"for security reasons" is a bit handwave-y, no?

[...]

> +static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
> +                                             QCow2ClusterType cluster_=
type,
> +                                             uint64_t file_cluster_off=
set,
> +                                             uint64_t offset, uint64_t=
 bytes,
> +                                             QEMUIOVector *qiov,
> +                                             size_t qiov_offset)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int offset_in_cluster =3D offset_into_cluster(s, offset);
> +
> +    switch (cluster_type) {

[...]

> +    default:
> +        g_assert_not_reached();
> +        /*
> +         * QCOW2_CLUSTER_ZERO_PLAIN and QCOW2_CLUSTER_ZERO_ALLOC handl=
ed
> +         * in qcow2_co_preadv_part

Hmm, I=E2=80=99d still add them explicitly as cases and put their own
g_assert_not_reach() there.

> +         */
> +    }
> +
> +    g_assert_not_reached();
> +
> +    return -EIO;

Maybe abort()ing instead of g_assert_not_reach() would save you from
having to return here?

Max


--C04Jbs1sWTN9ksdTAQh8ywXsqC9UiF6Qc--

--YXsDOdauwlffwXMJX0H3dJQSjqHkhuEIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1TLCUACgkQ9AfbAGHV
z0DGVAf9GOY1IGRKj3l7XlwWv7hhAlXqvT2QZ5CuOPbaEoWp0e2UuABcmhvGt4U7
D2EVuyx2z8RxrSU31rE3xb8NXfXOuNt8NPFx/pFfDJN4wYavuQgVi/+WaSDvD3jB
l5O/8EVQv7ItREM24B/KebAtRhrY/tAIwjppcp/+IJqPEVvxp25yqRsIu7Vlqz3C
xV4n1RjK3UJ6L1G7tQTyFTaKVmV70Ed5V1QabhURj7gbmKiF0pwR6qhcOP+JV5p2
80HVfuIFdoADFOtW6zC1l5dNdyXGnqdHooBfKfHY1lbUbUhjSwx9wBq5PjJwqcKM
oUyBjbN1hskIiqPyN2Ul6TigwCCKKg==
=1+6W
-----END PGP SIGNATURE-----

--YXsDOdauwlffwXMJX0H3dJQSjqHkhuEIL--

