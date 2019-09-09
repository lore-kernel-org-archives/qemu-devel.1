Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5D8C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34A3218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34A3218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JK2-0005r1-VB
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7JH6-0004uh-QB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7JH4-0002tH-UA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:00:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45533)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7JH1-0002m3-Bp; Mon, 09 Sep 2019 09:00:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61B4131D8B2;
 Mon,  9 Sep 2019 13:00:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 609911D9;
 Mon,  9 Sep 2019 12:59:39 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
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
Message-ID: <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
Date: Mon, 9 Sep 2019 14:59:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830161228.54238-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6dREkUrhARj5bcXaRVayjDFEK2ofzNM1V"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 09 Sep 2019 13:00:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v10 04/14] block/backup: introduce
 BlockCopyState
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
Cc: fam@euphon.net, kwolf@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6dREkUrhARj5bcXaRVayjDFEK2ofzNM1V
Content-Type: multipart/mixed; boundary="p7JNNRNMFMdSe27YjjdpgouCbM8VPOkmt";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net,
 stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
Subject: Re: [PATCH v10 04/14] block/backup: introduce BlockCopyState
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190830161228.54238-5-vsementsov@virtuozzo.com>

--p7JNNRNMFMdSe27YjjdpgouCbM8VPOkmt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.08.19 18:12, Vladimir Sementsov-Ogievskiy wrote:
> Split copying code part from backup to "block-copy", including separate=

> state structure and function renaming. This is needed to share it with
> backup-top filter driver in further commits.
>=20
> Notes:
>=20
> 1. As BlockCopyState keeps own BlockBackend objects, remaining
> job->common.blk users only use it to get bs by blk_bs() call, so clear
> job->commen.blk permissions set in block_job_create and add
> job->source_bs to be used instead of blk_bs(job->common.blk), to keep
> it more clear which bs we use when introduce backup-top filter in
> further commit.
>=20
> 2. Rename s/initializing_bitmap/skip_unallocated/ to sound a bit better=

> as interface to BlockCopyState
>=20
> 3. Split is not very clean: there left some duplicated fields, backup
> code uses some BlockCopyState fields directly, let's postpone it for
> further improvements and keep this comment simpler for review.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c     | 357 ++++++++++++++++++++++++++++-----------------=

>  block/trace-events |  12 +-
>  2 files changed, 231 insertions(+), 138 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index abb5099fa3..002dee4d7f 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -35,12 +35,43 @@ typedef struct CowRequest {
>      CoQueue wait_queue; /* coroutines blocked on this request */
>  } CowRequest;
> =20
> +typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque)=
;
> +typedef void (*ProgressResetCallbackFunc)(void *opaque);
> +typedef struct BlockCopyState {
> +    BlockBackend *source;
> +    BlockBackend *target;
> +    BdrvDirtyBitmap *copy_bitmap;
> +    int64_t cluster_size;
> +    bool use_copy_range;
> +    int64_t copy_range_size;
> +    uint64_t len;
> +
> +    BdrvRequestFlags write_flags;
> +
> +    /*
> +     * skip_unallocated: if true, on copy operation firstly reset area=
s
> +     * unallocated in top layer of source (and then of course don't co=
py
> +     * corresponding clusters). If some bytes reset, call
> +     * progress_reset_callback.
> +     */

It isn=E2=80=99t quite clear that this refers to the copy_bitmap.  Maybe
something like

=E2=80=9CIf true, the copy operation prepares a sync=3Dtop job: It scans =
the
source's top layer to find all unallocated areas and resets them in the
copy_bitmap (so they will not be copied).  Whenever any such area is
cleared, progress_reset_callback will be invoked.
Once the whole top layer has been scanned, skip_unallocated is cleared
and the actual copying begins.=E2=80=9D

instead?

> +    bool skip_unallocated;
> +
> +    /* progress_bytes_callback called when some copying progress is do=
ne. */

Maybe add a colon after the attribute name?  (Or drop the name altogether=
)

> +    ProgressBytesCallbackFunc progress_bytes_callback;
> +
> +    /*
> +     * progress_reset_callback called when some bytes reset from copy_=
bitmap
> +     * (see @skip_unallocated above)

Maybe you should keep the note you before on what to do then, i.e. that
the callee should probably recalculate how many bytes remain based on
the copy_bitmap=E2=80=99s dirty bit count.

> +     */
> +    ProgressResetCallbackFunc progress_reset_callback;
> +    void *progress_opaque;
> +} BlockCopyState;

[...]

> @@ -415,16 +535,16 @@ static void backup_abort(Job *job)
>  static void backup_clean(Job *job)
>  {
>      BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job=
);
> -    BlockDriverState *bs =3D blk_bs(s->common.blk);
> +    BlockCopyState *bcs =3D s->bcs;
> =20
> -    if (s->copy_bitmap) {
> -        bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
> -        s->copy_bitmap =3D NULL;
> -    }
> +    /*
> +     * Zero pointer first, to not interleave with backup_drain during =
some
> +     * yield. TODO: just block_copy_state_free(s->bcs) after backup_dr=
ain
> +     * dropped.
> +     */

I suppose that=E2=80=98s now. :-)

> +    s->bcs =3D NULL;
> =20
> -    assert(s->target);
> -    blk_unref(s->target);
> -    s->target =3D NULL;
> +    block_copy_state_free(bcs);
>  }

[...]

> @@ -449,8 +569,8 @@ static void backup_drain(BlockJob *job)
>      /* Need to keep a reference in case blk_drain triggers execution
>       * of backup_complete...
>       */
> -    if (s->target) {
> -        BlockBackend *target =3D s->target;
> +    if (s->bcs) {
> +        BlockBackend *target =3D s->bcs->target;
>          blk_ref(target);
>          blk_drain(target);
>          blk_unref(target);

(And this hunk can go away now.)

[...]

> diff --git a/block/trace-events b/block/trace-events
> index 04209f058d..453792ed87 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -40,12 +40,12 @@ mirror_yield_in_flight(void *s, int64_t offset, int=
 in_flight) "s %p offset %" P
>  # backup.c
>  backup_do_cow_enter(void *job, int64_t start, int64_t offset, uint64_t=
 bytes) "job %p start %" PRId64 " offset %" PRId64 " bytes %" PRIu64
>  backup_do_cow_return(void *job, int64_t offset, uint64_t bytes, int re=
t) "job %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
> -backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
> -backup_do_cow_skip_range(void *job, int64_t start, uint64_t bytes) "jo=
b %p start %"PRId64" bytes %"PRId64
> -backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64=

> -backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p sta=
rt %"PRId64" ret %d"
> -backup_do_cow_write_fail(void *job, int64_t start, int ret) "job %p st=
art %"PRId64" ret %d"
> -backup_do_cow_copy_range_fail(void *job, int64_t start, int ret) "job =
%p start %"PRId64" ret %d"
> +block_copy_skip(void *bcs, int64_t start) "job %p start %"PRId64
> +block_copy_skip_range(void *bcs, int64_t start, uint64_t bytes) "job %=
p start %"PRId64" bytes %"PRId64
> +block_copy_process(void *bcs, int64_t start) "job %p start %"PRId64
> +block_copy_with_bounce_buffer_read_fail(void *bcs, int64_t start, int =
ret) "job %p start %"PRId64" ret %d"
> +block_copy_with_bounce_buffer_write_fail(void *bcs, int64_t start, int=
 ret) "job %p start %"PRId64" ret %d"
> +block_copy_with_offload_fail(void *bcs, int64_t start, int ret) "job %=
p start %"PRId64" ret %d"

The messages probably should stop calling it a =E2=80=9Cjob=E2=80=9D, too=
=2E

Max


--p7JNNRNMFMdSe27YjjdpgouCbM8VPOkmt--

--6dREkUrhARj5bcXaRVayjDFEK2ofzNM1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12TLkACgkQ9AfbAGHV
z0C96ggAu0mSj1s/sf2DsZEPGmo3Y8jhHWN+8RmfigWf2ihuYi5GQ8LlLFCg8wV8
ArqM2+Cnfp0L5wmbtFrlpWGa34lhJZGBPdoPQiPnUze70Jfwv3YVJv59jeSz5kzI
x/dmqexwznCO0imc861itXMzGSfWxTZpACXrwkmq012e5b9ZxU97GhKU7qsBPWha
KfNoGd1iIW4wfTwV3kU8frdZp9UqiN0HvKsFpunnfOGDCMxzNgpUS+MeNo6wj9Dg
3XTjHrG4p2OWekYdn5DKRdMeGONxrKj/4a0bndUUHd2/TcqytcUO40IKnGxjVpHO
wK2yh4YfsJJbQuziiZU80EsS50qgUA==
=aBCf
-----END PGP SIGNATURE-----

--6dREkUrhARj5bcXaRVayjDFEK2ofzNM1V--

