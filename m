Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02783C76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C006A218F0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C006A218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgUx-0005lv-1t
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59984)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqgUk-0005IH-QG
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqgUj-0007Ha-22
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:21:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqgUf-0007Gu-EI; Thu, 25 Jul 2019 12:21:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EC1730BA077;
 Thu, 25 Jul 2019 16:21:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99DDE60852;
 Thu, 25 Jul 2019 16:21:22 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-3-mreitz@redhat.com>
 <9021e43da1e3c46354486c416c1d65935b37a9d2.camel@redhat.com>
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
Message-ID: <9f60f964-8b4b-cd7f-d538-b8c41268e804@redhat.com>
Date: Thu, 25 Jul 2019 18:21:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9021e43da1e3c46354486c416c1d65935b37a9d2.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oZxX16zahjJuNL8she2dkO28Ws4VWZBvv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 25 Jul 2019 16:21:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/11] mirror: Fix bdrv_has_zero_init()
 use
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oZxX16zahjJuNL8she2dkO28Ws4VWZBvv
Content-Type: multipart/mixed; boundary="R4ljW4jDVKnCT3QQSVvfU0BM3yHQ4r2Pm";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <9f60f964-8b4b-cd7f-d538-b8c41268e804@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/11] mirror: Fix bdrv_has_zero_init()
 use
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-3-mreitz@redhat.com>
 <9021e43da1e3c46354486c416c1d65935b37a9d2.camel@redhat.com>
In-Reply-To: <9021e43da1e3c46354486c416c1d65935b37a9d2.camel@redhat.com>

--R4ljW4jDVKnCT3QQSVvfU0BM3yHQ4r2Pm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.07.19 17:28, Maxim Levitsky wrote:
> On Wed, 2019-07-24 at 19:12 +0200, Max Reitz wrote:
>> bdrv_has_zero_init() only has meaning for newly created images or imag=
e
>> areas.  If the mirror job itself did not create the image, it cannot
>> rely on bdrv_has_zero_init()'s result to carry any meaning.
>>
>> This is the case for drive-mirror with mode=3Dexisting and always for
>> blockdev-mirror.
>>
>> Note that we only have to zero-initialize the target with sync=3Dfull,=

>> because other modes actually do not promise that the target will conta=
in
>> the same data as the source after the job -- sync=3Dtop only promises =
to
>> copy anything allocated in the top layer, and sync=3Dnone will only co=
py
>> new I/O.  (Which is how mirror has always handled it.)
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/block_int.h   |  2 ++
>>  block/mirror.c              | 11 ++++++++---
>>  blockdev.c                  | 16 +++++++++++++---
>>  tests/test-block-iothread.c |  2 +-
>>  4 files changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 3aa1e832a8..6a0b1b5008 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1116,6 +1116,7 @@ BlockJob *commit_active_start(const char *job_id=
, BlockDriverState *bs,
>>   * @buf_size: The amount of data that can be in flight at one time.
>>   * @mode: Whether to collapse all images in the chain to the target.
>>   * @backing_mode: How to establish the target's backing chain after c=
ompletion.
>> + * @zero_target: Whether the target should be explicitly zero-initial=
ized
>>   * @on_source_error: The action to take upon error reading from the s=
ource.
>>   * @on_target_error: The action to take upon error writing to the tar=
get.
>>   * @unmap: Whether to unmap target where source sectors only contain =
zeroes.
>> @@ -1135,6 +1136,7 @@ void mirror_start(const char *job_id, BlockDrive=
rState *bs,
>>                    int creation_flags, int64_t speed,
>>                    uint32_t granularity, int64_t buf_size,
>>                    MirrorSyncMode mode, BlockMirrorBackingMode backing=
_mode,
>> +                  bool zero_target,
>>                    BlockdevOnError on_source_error,
>>                    BlockdevOnError on_target_error,
>>                    bool unmap, const char *filter_node_name,
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 8cb75fb409..50188ce6e9 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -51,6 +51,8 @@ typedef struct MirrorBlockJob {
>>      Error *replace_blocker;
>>      bool is_none_mode;
>>      BlockMirrorBackingMode backing_mode;
>> +    /* Whether the target image requires explicit zero-initialization=
 */
>> +    bool zero_target;
>>      MirrorCopyMode copy_mode;
>>      BlockdevOnError on_source_error, on_target_error;
>>      bool synced;
>> @@ -763,7 +765,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBl=
ockJob *s)
>>      int ret;
>>      int64_t count;
>> =20
>> -    if (base =3D=3D NULL && !bdrv_has_zero_init(target_bs)) {
>> +    if (s->zero_target) {
> The justification for removing base here, is that it can be !=3D NULL o=
nly
> when MIRROR_SYNC_MODE_TOP. So looks OK

Or with sync=3Dnone, or when doing an active commit,

>>          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
>>              bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length)=
;
>>              return 0;
>> @@ -1501,6 +1503,7 @@ static BlockJob *mirror_start_job(
>>                               const char *replaces, int64_t speed,
>>                               uint32_t granularity, int64_t buf_size,
>>                               BlockMirrorBackingMode backing_mode,
>> +                             bool zero_target,
>>                               BlockdevOnError on_source_error,
>>                               BlockdevOnError on_target_error,
>>                               bool unmap,
>> @@ -1628,6 +1631,7 @@ static BlockJob *mirror_start_job(
>>      s->on_target_error =3D on_target_error;
>>      s->is_none_mode =3D is_none_mode;
>>      s->backing_mode =3D backing_mode;
>> +    s->zero_target =3D zero_target;
>>      s->copy_mode =3D copy_mode;
>>      s->base =3D base;
>>      s->granularity =3D granularity;
>> @@ -1713,6 +1717,7 @@ void mirror_start(const char *job_id, BlockDrive=
rState *bs,
>>                    int creation_flags, int64_t speed,
>>                    uint32_t granularity, int64_t buf_size,
>>                    MirrorSyncMode mode, BlockMirrorBackingMode backing=
_mode,
>> +                  bool zero_target,
>>                    BlockdevOnError on_source_error,
>>                    BlockdevOnError on_target_error,
>>                    bool unmap, const char *filter_node_name,
>> @@ -1728,7 +1733,7 @@ void mirror_start(const char *job_id, BlockDrive=
rState *bs,
>>      is_none_mode =3D mode =3D=3D MIRROR_SYNC_MODE_NONE;
>>      base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL=
;
>>      mirror_start_job(job_id, bs, creation_flags, target, replaces,
>> -                     speed, granularity, buf_size, backing_mode,
>> +                     speed, granularity, buf_size, backing_mode, zero=
_target,
>>                       on_source_error, on_target_error, unmap, NULL, N=
ULL,
>>                       &mirror_job_driver, is_none_mode, base, false,
>>                       filter_node_name, true, copy_mode, errp);
>> @@ -1755,7 +1760,7 @@ BlockJob *commit_active_start(const char *job_id=
, BlockDriverState *bs,
>> =20
>>      ret =3D mirror_start_job(
>>                       job_id, bs, creation_flags, base, NULL, speed, 0=
, 0,
>> -                     MIRROR_LEAVE_BACKING_CHAIN,
>> +                     MIRROR_LEAVE_BACKING_CHAIN, false,
>>                       on_error, on_error, true, cb, opaque,
>>                       &commit_active_job_driver, false, base, auto_com=
plete,
>>                       filter_node_name, false, MIRROR_COPY_MODE_BACKGR=
OUND,
>> diff --git a/blockdev.c b/blockdev.c
>> index 4d141e9a1f..0323f77850 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3705,6 +3705,7 @@ static void blockdev_mirror_common(const char *j=
ob_id, BlockDriverState *bs,
>>                                     bool has_replaces, const char *rep=
laces,
>>                                     enum MirrorSyncMode sync,
>>                                     BlockMirrorBackingMode backing_mod=
e,
>> +                                   bool zero_target,
>>                                     bool has_speed, int64_t speed,
>>                                     bool has_granularity, uint32_t gra=
nularity,
>>                                     bool has_buf_size, int64_t buf_siz=
e,
>> @@ -3813,7 +3814,7 @@ static void blockdev_mirror_common(const char *j=
ob_id, BlockDriverState *bs,
>>       */
>>      mirror_start(job_id, bs, target,
>>                   has_replaces ? replaces : NULL, job_flags,
>> -                 speed, granularity, buf_size, sync, backing_mode,
>> +                 speed, granularity, buf_size, sync, backing_mode, ze=
ro_target,
>>                   on_source_error, on_target_error, unmap, filter_node=
_name,
>>                   copy_mode, errp);
>>  }
>> @@ -3829,6 +3830,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **=
errp)
>>      int flags;
>>      int64_t size;
>>      const char *format =3D arg->format;
>> +    bool zero_target;
>>      int ret;
>> =20
>>      bs =3D qmp_get_root_bs(arg->device, errp);
>> @@ -3930,6 +3932,10 @@ void qmp_drive_mirror(DriveMirror *arg, Error *=
*errp)
>>          goto out;
>>      }
>> =20
>> +    zero_target =3D (arg->sync =3D=3D MIRROR_SYNC_MODE_FULL &&
>> +                   (arg->mode =3D=3D NEW_IMAGE_MODE_EXISTING ||
>> +                    !bdrv_has_zero_init(target_bs)));
>> +
>>      ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
>>      if (ret < 0) {
>>          bdrv_unref(target_bs);
>> @@ -3938,7 +3944,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **=
errp)
>> =20
>>      blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, =
target_bs,
>>                             arg->has_replaces, arg->replaces, arg->syn=
c,
>> -                           backing_mode, arg->has_speed, arg->speed,
>> +                           backing_mode, zero_target,
>> +                           arg->has_speed, arg->speed,
>>                             arg->has_granularity, arg->granularity,
>>                             arg->has_buf_size, arg->buf_size,
>>                             arg->has_on_source_error, arg->on_source_e=
rror,
>> @@ -3978,6 +3985,7 @@ void qmp_blockdev_mirror(bool has_job_id, const =
char *job_id,
>>      AioContext *aio_context;
>>      BlockMirrorBackingMode backing_mode =3D MIRROR_LEAVE_BACKING_CHAI=
N;
>>      Error *local_err =3D NULL;
>> +    bool zero_target;
>>      int ret;
>> =20
>>      bs =3D qmp_get_root_bs(device, errp);
>> @@ -3990,6 +3998,8 @@ void qmp_blockdev_mirror(bool has_job_id, const =
char *job_id,
>>          return;
>>      }
>> =20
>> +    zero_target =3D (sync =3D=3D MIRROR_SYNC_MODE_FULL);
>> +
>>      aio_context =3D bdrv_get_aio_context(bs);
>>      aio_context_acquire(aio_context);
>> =20
>> @@ -4000,7 +4010,7 @@ void qmp_blockdev_mirror(bool has_job_id, const =
char *job_id,
>> =20
>>      blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,=

>>                             has_replaces, replaces, sync, backing_mode=
,
>> -                           has_speed, speed,
>> +                           zero_target, has_speed, speed,
>>                             has_granularity, granularity,
>>                             has_buf_size, buf_size,
>>                             has_on_source_error, on_source_error,
>> diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c=

>> index 1949d5e61a..debfb69bfb 100644
>> --- a/tests/test-block-iothread.c
>> +++ b/tests/test-block-iothread.c
>> @@ -611,7 +611,7 @@ static void test_propagate_mirror(void)
>> =20
>>      /* Start a mirror job */
>>      mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
>> -                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN,
>> +                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, fa=
lse,
>>                   BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
>>                   false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
>>                   &error_abort);
>=20
>=20
> From my limited understanding of this code, it looks ok to me.
>=20
> Still to be very sure, I sort of suggest still to check that nobody rel=
ies on target zeroing=20
> when non in full sync mode, to avoid breaking the users

Whenever we zeroed the target before this patch, we will still zero it
afterwards.

We zeroed it only when base =3D=3D NULL, which translates to sync=3Dfull.=
  We
never zeroed it in any other case.

> For example, QMP reference states that MIRROR_SYNC_MODE_TOP copies data=
 in the topmost image to the destination.
> If there is only the topmost image, I could image the caller assume tha=
t target is identical to the source.

It doesn=E2=80=99t say that it copies the data in the topmost image.  It =
says it
copies the data *allocated* in the topmost image.  It follows that it
will not copy any data that is not allocated.

(So if you preallocate the source, it will indeed copy all data and thus
the target will be identical to the source.)

> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Thanks for reviewing!

Max


--R4ljW4jDVKnCT3QQSVvfU0BM3yHQ4r2Pm--

--oZxX16zahjJuNL8she2dkO28Ws4VWZBvv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl051wAACgkQ9AfbAGHV
z0AKBAf/fyQCsQpiBxgB4HTA7COku4kBArRd1G9VuJySFKpkCJID4C2Ed+ok6Col
gBvhAA21QfzwViVJs+yD+guvwDiQ0JheIlT6BKq1cYFXARSSw26QqYwyU9MR9uTs
ZxqdA09oia3m0cRLYJIe16b/4dCNkbM7dWfxusmb93/ZWcDJHpCouYS/XoHACW1H
+62PnadlVFKpjIPtk40xdDI1AflPIpYN9fTRmSbhfnrL2/iTmhpvrhp2vSqcsv1s
5ntwGy+r3Mfs2BqpQt0SrlhInX+jduY2Vv7P0+41BGmo2p+omJkFNZnlfmECjnS1
+ic9Y7XRbKRB1PMYe+lEb2hcwrbwXA==
=4Vc1
-----END PGP SIGNATURE-----

--oZxX16zahjJuNL8she2dkO28Ws4VWZBvv--

