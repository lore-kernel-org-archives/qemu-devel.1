Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A3AC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047A12086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047A12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hudNO-0002Z8-1g
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 09:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hudMm-0001nu-0p
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hudMk-0002G8-Tm
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:49:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hudMi-0002BN-3K; Mon, 05 Aug 2019 09:49:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6348C08E296;
 Mon,  5 Aug 2019 13:49:30 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 432495D71A;
 Mon,  5 Aug 2019 13:49:28 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190805114923.23701-1-mreitz@redhat.com>
 <f3b36f80-589f-039d-233b-1a54f2cfcefc@virtuozzo.com>
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
Message-ID: <ba1126d9-f5e5-d216-a52c-d9f7a8328fcc@redhat.com>
Date: Mon, 5 Aug 2019 15:49:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f3b36f80-589f-039d-233b-1a54f2cfcefc@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xrc8YTn7kq0pmcnj1WzGCgpQm4ea7ZJcD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 05 Aug 2019 13:49:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] mirror: Only mirror granularity-aligned
 chunks
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xrc8YTn7kq0pmcnj1WzGCgpQm4ea7ZJcD
Content-Type: multipart/mixed; boundary="bBZrVvUeQ6upwtaJnlL3JsKIL2tCHFTkh";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ba1126d9-f5e5-d216-a52c-d9f7a8328fcc@redhat.com>
Subject: Re: [PATCH] mirror: Only mirror granularity-aligned chunks
References: <20190805114923.23701-1-mreitz@redhat.com>
 <f3b36f80-589f-039d-233b-1a54f2cfcefc@virtuozzo.com>
In-Reply-To: <f3b36f80-589f-039d-233b-1a54f2cfcefc@virtuozzo.com>

--bBZrVvUeQ6upwtaJnlL3JsKIL2tCHFTkh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.08.19 15:00, Vladimir Sementsov-Ogievskiy wrote:
> 05.08.2019 14:49, Max Reitz wrote:
>> In write-blocking mode, all writes to the top node directly go to the
>> target.  We must only mirror chunks of data that are aligned to the
>> job's granularity, because that is how the dirty bitmap works.
>> Therefore, the request alignment for writes must be the job's
>> granularity (in write-blocking mode).
>>
>> Unfortunately, this forces all reads and writes to have the same
>> granularity (we only need this alignment for writes to the target, not=

>> the source), but that is something to be fixed another time.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> This is an alternative to Vladimir's "util/hbitmap: fix unaligned rese=
t"
>> patch.  I don't mind much either way, both of pros and cons.  Comparin=
g
>> this patch to Vladimir's:
>>
>> + Makes copy-mode=3Dwrite-blocking really work (unless I'm mistaken)
>> - Lowers performance with copy-mode=3Dwrite-blocking unnecessarily
>> ---
>>   block/mirror.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 8cb75fb409..3f9c5a178a 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1481,6 +1481,15 @@ static void bdrv_mirror_top_child_perm(BlockDri=
verState *bs, BdrvChild *c,
>>       *nshared =3D BLK_PERM_ALL;
>>   }
>>  =20
>> +static void bdrv_mirror_top_refresh_limits(BlockDriverState *bs, Erro=
r **errp)
>> +{
>> +    MirrorBDSOpaque *s =3D bs->opaque;
>> +
>> +    if (s && s->job && s->job->copy_mode =3D=3D MIRROR_COPY_MODE_WRIT=
E_BLOCKING) {
>> +        bs->bl.request_alignment =3D s->job->granularity;
>> +    }
>> +}
>> +
>>   /* Dummy node that provides consistent read to its users without req=
uiring it
>>    * from its backing file and that allows writes on the backing file =
chain. */
>>   static BlockDriver bdrv_mirror_top =3D {
>> @@ -1493,6 +1502,7 @@ static BlockDriver bdrv_mirror_top =3D {
>>       .bdrv_co_block_status       =3D bdrv_co_block_status_from_backin=
g,
>>       .bdrv_refresh_filename      =3D bdrv_mirror_top_refresh_filename=
,
>>       .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
>> +    .bdrv_refresh_limits        =3D bdrv_mirror_top_refresh_limits,
>>   };
>>  =20
>>   static BlockJob *mirror_start_job(
>> @@ -1678,6 +1688,8 @@ static BlockJob *mirror_start_job(
>>  =20
>>       QTAILQ_INIT(&s->ops_in_flight);
>>  =20
>> +    bdrv_refresh_limits(mirror_top_bs, &error_abort);
>> +
>>       trace_mirror_start(bs, s, opaque);
>>       job_start(&s->common.job);
>>  =20
>>
>=20
> Am I right that the fact that no guest request will skip this limit is =
guaranteed by
> aio_context_acquire/release around blockdev_mirror_common?

Hm.  As long as we don=E2=80=99t drain or release the context.

Unfortunately, block_job_add_bdrv() does release the context (if the job
runs in a foreign context).

The reason we need this call is because the automatic calls invoke the
function when either bs->opaque or bs->opaque->job are still NULL, or
when bs->opaque->job->copy_mode is not yet set.

So I could just call it when copy_mode has been set (which is still
before the dirty bitmap is created; and if we have I/O before that
point, we have bigger problems than this.)

Max

> Not sure how much it lowers performance, but it should work..
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20



--bBZrVvUeQ6upwtaJnlL3JsKIL2tCHFTkh--

--xrc8YTn7kq0pmcnj1WzGCgpQm4ea7ZJcD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1IM+YACgkQ9AfbAGHV
z0Be+Qf/RA5rsOGqxFzowfi9k9OjE+5IU9MJVDk9adaPAR3pKJM/uBpw/Loe2EEV
HP0DNunOc3Othkgg22Oqqzkx91yWriFnFMVvLFS6m+JSoepc2RAPaCLJYdXe517q
Z7lgCSMSesRWaz9NFSiNwWgCfK42DMRm/CCrZxC9scppsETT37+Zt505lkK6k0uO
mA1l8EpPQ4bCEwxxWqC3992KmlnfLrfDHc5JE6ObOowHUWxgB2Fjoa4J0iSnUcWI
hmXjTR7q7hyDRoh45aR+FWyeOYSk5AnXulOeiSIpCMwkr1wD3rF3puODJ/iyhaS6
dH/P4RZbCd4eBul5CO4u58V+RnABIg==
=1uz5
-----END PGP SIGNATURE-----

--xrc8YTn7kq0pmcnj1WzGCgpQm4ea7ZJcD--

