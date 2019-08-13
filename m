Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4A9C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 20:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA5020665
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 20:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA5020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxdif-0008Ka-1c
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 16:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxdhn-00073M-TQ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 16:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxdhm-0002S9-U6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 16:47:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxdhi-0002PR-Pc; Tue, 13 Aug 2019 16:47:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EDE085546;
 Tue, 13 Aug 2019 20:47:36 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25AAB4510;
 Tue, 13 Aug 2019 20:47:31 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-2-vsementsov@virtuozzo.com>
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
Message-ID: <565ee3a9-d606-cc64-3748-21f9c54cffb7@redhat.com>
Date: Tue, 13 Aug 2019 22:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730141826.709849-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MDT5Acitqyevr4eLcODZAcALXm5LDj5TC"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 13 Aug 2019 20:47:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: introduce aio task pool
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
--MDT5Acitqyevr4eLcODZAcALXm5LDj5TC
Content-Type: multipart/mixed; boundary="i6CpnHsO9waPxWizlDlVYwqisw0NCIbUK";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, kwolf@redhat.com, den@openvz.org,
 stefanha@redhat.com
Message-ID: <565ee3a9-d606-cc64-3748-21f9c54cffb7@redhat.com>
Subject: Re: [PATCH v2 1/4] block: introduce aio task pool
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190730141826.709849-2-vsementsov@virtuozzo.com>

--i6CpnHsO9waPxWizlDlVYwqisw0NCIbUK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 16:18, Vladimir Sementsov-Ogievskiy wrote:
> Common interface for aio task loops. To be used for improving
> performance of synchronous io loops in qcow2, block-stream,
> copy-on-read, and may be other places.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Looks good to me overall.

>  block/aio_task.h    |  52 +++++++++++++++++++

I=E2=80=99ve move this to include/block/.

>  block/aio_task.c    | 119 ++++++++++++++++++++++++++++++++++++++++++++=

>  block/Makefile.objs |   2 +
>  3 files changed, 173 insertions(+)
>  create mode 100644 block/aio_task.h
>  create mode 100644 block/aio_task.c
>=20
> diff --git a/block/aio_task.h b/block/aio_task.h
> new file mode 100644
> index 0000000000..933af1d8e7
> --- /dev/null
> +++ b/block/aio_task.h

[...]

> +typedef struct AioTaskPool AioTaskPool;
> +typedef struct AioTask AioTask;
> +typedef int (*AioTaskFunc)(AioTask *task);

+coroutine_fn

> +struct AioTask {
> +    AioTaskPool *pool;
> +    AioTaskFunc func;
> +    int ret;
> +};
> +
> +/*
> + * aio_task_pool_new
> + *
> + * The caller is responsible to g_free AioTaskPool pointer after use.

s/to g_free/for g_freeing/ or something similar.

Or you=E2=80=99d just add aio_task_pool_free().

> + */
> +AioTaskPool *aio_task_pool_new(int max_busy_tasks);
> +int aio_task_pool_status(AioTaskPool *pool);

A comment wouldn=E2=80=99t hurt.  It wasn=E2=80=99t immediately clear to =
me that status
refers to the error code of a failing task (or 0), although it wasn=E2=80=
=99t
too much of a surprise either.

> +bool aio_task_pool_empty(AioTaskPool *pool);
> +void aio_task_pool_start_task(AioTaskPool *pool, AioTask *task);

Maybe make a note that task->pool will be set automatically?

> +void aio_task_pool_wait_slot(AioTaskPool *pool);
> +void aio_task_pool_wait_one(AioTaskPool *pool);
> +void aio_task_pool_wait_all(AioTaskPool *pool);

Shouldn=E2=80=99t all of these but aio_task_pool_empty() and
aio_task_pool_status() be coroutine_fns?

> +#endif /* BLOCK_AIO_TASK_H */
> diff --git a/block/aio_task.c b/block/aio_task.c
> new file mode 100644
> index 0000000000..807be8deb5
> --- /dev/null
> +++ b/block/aio_task.c

[...]

> +static void aio_task_co(void *opaque)

+coroutine_fn

[...]

> +void aio_task_pool_wait_one(AioTaskPool *pool)
> +{
> +    assert(pool->busy_tasks > 0);
> +    assert(qemu_coroutine_self() =3D=3D pool->main_co);
> +
> +    pool->wait_done =3D true;

Hmmm, but the wait actually isn=E2=80=99t done yet. :-)

Maybe s/wait_done/waiting/?

Max

> +    qemu_coroutine_yield();
> +
> +    assert(!pool->wait_done);
> +    assert(pool->busy_tasks < pool->max_busy_tasks);
> +}


--i6CpnHsO9waPxWizlDlVYwqisw0NCIbUK--

--MDT5Acitqyevr4eLcODZAcALXm5LDj5TC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1TIeEACgkQ9AfbAGHV
z0DM5wf/YsfLlPDhf8my90Qpzz0U9KuFJgrdVmxn1+6+jWfJiGK1cZZ86zHDFnB0
neXMls/t8bJQ7FvWCAu8l3sWt8hWiNr6eMRk/Ki0To3RjlO0SrHOMhs2M26Aoecx
jZ7l5xm3gDhaiH281FegKVjJR950Gh+XgEeMjZQqGRPm5JlpL/zohKcNHC+lKdcs
by9m5+DIBpm1pCQPUtPMTuk8hYO3I42Y+YXRNiV8JO0TRrMruFwbFebR+BFrVHX5
YMXIjI1taghZhK1DH9UlQhaPXvEw7t1Iz0tkoYAoKFJ3jUkpheQGCmW6fzUxKmk7
ChIPZUgJWzNvI7FBSSWPQXknCSh9bg==
=z9R+
-----END PGP SIGNATURE-----

--MDT5Acitqyevr4eLcODZAcALXm5LDj5TC--

