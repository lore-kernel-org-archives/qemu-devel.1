Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFFAC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45A22147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45A22147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbVP0-00021O-1k
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49639)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbU3r-00027M-0A
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 14:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbU3n-0005MX-UE
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 14:02:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbU3f-0004ap-EO; Thu, 13 Jun 2019 14:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C76B307CDD1;
 Thu, 13 Jun 2019 18:02:10 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F2072B59B;
 Thu, 13 Jun 2019 18:02:02 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-8-vsementsov@virtuozzo.com>
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
Message-ID: <92bc9deb-f364-683a-e6ae-046e4ff8561c@redhat.com>
Date: Thu, 13 Jun 2019 20:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529154654.95870-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ylYCgS5jRhWzOBasyJkNhPXFR9d3ZAJtj"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 18:02:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 7/7] block/backup: use backup-top
 instead of write notifiers
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ylYCgS5jRhWzOBasyJkNhPXFR9d3ZAJtj
Content-Type: multipart/mixed; boundary="kErIDWrsS7ZyBQSQsgaIALmCne60esVbU";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com
Message-ID: <92bc9deb-f364-683a-e6ae-046e4ff8561c@redhat.com>
Subject: Re: [PATCH v8 7/7] block/backup: use backup-top instead of write
 notifiers
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-8-vsementsov@virtuozzo.com>
In-Reply-To: <20190529154654.95870-8-vsementsov@virtuozzo.com>

--kErIDWrsS7ZyBQSQsgaIALmCne60esVbU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.05.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
> Drop write notifiers and use filter node instead. Changes:
>=20
> 1. copy-before-writes now handled by filter node, so, drop all
>    is_write_notifier arguments.
>=20
> 2. we don't have intersecting requests, so their handling is dropped.
> Instead, synchronization works as follows:
> when backup or backup-top starts copying of some area it firstly
> clears copy-bitmap bits, and nobody touches areas, not marked with
> dirty bits in copy-bitmap, so there is no intersection. Also, backup
> job copy operations are surrounded by bdrv region lock, which is
> actually serializing request, to not interfere with guest writes and
> not read changed data from source (before reading we clear
> corresponding bit in copy-bitmap, so, this area is not more handled by
> backup-top).
>=20
> 3. To sync with in-flight requests at job finish we now have drained
> removing of the filter, we don't need rw-lock.
>=20
> =3D=3D RFC part =3D=3D
>=20
> iotests changed:
> 56: op-blocker doesn't shot now, as we set it on source, but then check=

> on filter, when trying to start second backup... Should I workaround it=

> somehow?

Hm.  Where does that error message even come from?  The fact that the
target image is in use already (Due to file locks)?

It appears that way indeed.

It seems reasonable to me that you can now run a backup on top of
another backup.  Well, I mean, it is a stupid thing to do, but I don=E2=80=
=99t
see why the block layer would forbid doing so.

So the test seems superfluous to me.  If we want to keep it (why not),
it should test the opposite, namely that a backup to a different image
(with a different job ID) works.  (It seems simple enough to modify the
job that way, so why not.)

> 129: Hmm, now it is not busy at this moment.. But it's illegal to check=

> busy, as job has pause-points and set busy to false in these points.
> Why we assert it in this test?

Nobody knows, it=E2=80=99s probably wrong.  All I know is that 129 is jus=
t
broken anyway.

> 141: Obvious, as drv0 is not root node now, but backing of the filter,
> when we try to remove it.

I get a failed assertion in 256.  That is probably because the
bdrv_set_aio_context() calls weren=E2=80=99t as unnecessary as I deemed t=
hem to be.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c             | 171 ++++++++++++++-----------------------=

>  tests/qemu-iotests/056     |   2 +-
>  tests/qemu-iotests/129     |   1 -
>  tests/qemu-iotests/141.out |   2 +-
>  4 files changed, 68 insertions(+), 108 deletions(-)

For some reason, my gcc starts to complain that backup_loop() may not
initialize error_is_read after this patch.  I don=E2=80=99t know why that=
 is.
Perhaps it inlines backup_do_cow() now?  (So before it just saw that a
pointer to error_is_read was passed to backup_do_cow() and took it as an
opaque function, so it surely would set this value somewhere.  Now it
inlines it and it can=E2=80=99t find whether that will definitely happen,=
 so it
complains.)

I don=E2=80=99t think it is strictly necessary to initialize error_is_rea=
d, but,
well, it won=E2=80=99t hurt.

> diff --git a/block/backup.c b/block/backup.c
> index 00f4f8af53..a5b8e04c9c 100644
> --- a/block/backup.c
> +++ b/block/backup.c

[...]

> @@ -60,56 +53,17 @@ typedef struct BackupBlockJob {
> =20
>  static const BlockJobDriver backup_job_driver;
> =20
> -/* See if in-flight requests overlap and wait for them to complete */
> -static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob =
*job,
> -                                                       int64_t start,
> -                                                       int64_t end)
> -{
> -    CowRequest *req;
> -    bool retry;
> -
> -    do {
> -        retry =3D false;
> -        QLIST_FOREACH(req, &job->inflight_reqs, list) {
> -            if (end > req->start_byte && start < req->end_byte) {
> -                qemu_co_queue_wait(&req->wait_queue, NULL);
> -                retry =3D true;
> -                break;
> -            }
> -        }
> -    } while (retry);
> -}
> -
> -/* Keep track of an in-flight request */
> -static void cow_request_begin(CowRequest *req, BackupBlockJob *job,
> -                              int64_t start, int64_t end)
> -{
> -    req->start_byte =3D start;
> -    req->end_byte =3D end;
> -    qemu_co_queue_init(&req->wait_queue);
> -    QLIST_INSERT_HEAD(&job->inflight_reqs, req, list);
> -}
> -
> -/* Forget about a completed request */
> -static void cow_request_end(CowRequest *req)
> -{
> -    QLIST_REMOVE(req, list);
> -    qemu_co_queue_restart_all(&req->wait_queue);
> -}
> -
>  /* Copy range to target with a bounce buffer and return the bytes copi=
ed. If
>   * error occurred, return a negative error number */
>  static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *=
job,
>                                                        int64_t start,
>                                                        int64_t end,
> -                                                      bool is_write_no=
tifier,
>                                                        bool *error_is_r=
ead,
>                                                        void **bounce_bu=
ffer)

Future feature: Somehow get this functionality done with backup-top, I
suppose.  (This is effectively just backup_top_cbw() with some bells and
whistles, isn=E2=80=99t it?)

>  {
>      int ret;
>      BlockBackend *blk =3D job->common.blk;
>      int nbytes;
> -    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0=
;
>      int write_flags =3D job->serialize_target_writes ? BDRV_REQ_SERIAL=
ISING : 0;
> =20
>      assert(QEMU_IS_ALIGNED(start, job->cluster_size));

[...]

> @@ -154,15 +108,12 @@ fail:
>  /* Copy range to target and return the bytes copied. If error occurred=
, return a
>   * negative error number. */
>  static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
> -                                                int64_t start,
> -                                                int64_t end,
> -                                                bool is_write_notifier=
)
> +                                                int64_t start, int64_t=
 end)

And I suppose this is something backup-top maybe should support, too.

>  {
>      int ret;
>      int nr_clusters;
>      BlockBackend *blk =3D job->common.blk;
>      int nbytes;
> -    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0=
;
>      int write_flags =3D job->serialize_target_writes ? BDRV_REQ_SERIAL=
ISING : 0;
> =20
>      assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));

[...]

> @@ -391,28 +333,41 @@ static int coroutine_fn backup_loop(BackupBlockJo=
b *job)
>      int64_t offset;
>      HBitmapIter hbi;
>      BlockDriverState *bs =3D blk_bs(job->common.blk);
> +    void *lock;
> =20
>      hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
>      while ((offset =3D hbitmap_iter_next(&hbi)) !=3D -1) {
> +        lock =3D bdrv_co_try_lock(backing_bs(blk_bs(job->common.blk)),=
 offset,
> +                                job->cluster_size);
> +        /*
> +         * Dirty bit is set, which means that there are no in-flight
> +         * write requests on this area. We must succeed.
> +         */
> +        assert(lock);
> +

Hm.  It makes me uneasy but I suppose you=E2=80=99re right.

>          if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
>              bdrv_is_unallocated_range(bs, offset, job->cluster_size))

This can yield, right?  If it does, the bitmap is still set.  backup-top
will see this, unset the bitmap and try to start its CBW operation.
That is halted by the lock just taken, but the progress will still be
published after completion, so the job can go beyond 100 %, I think.

Even if it doesn=E2=80=99t, copying the data twice is weird.  It may even=
 get
weirder if one of both requests fails.

Can we lock the backup-top node instead?  I don=E2=80=99t know whether lo=
cking
would always succeed there, though...

Max

>          {
>              hbitmap_reset(job->copy_bitmap, offset, job->cluster_size)=
;
> +            bdrv_co_unlock(lock);
>              continue;
>          }
> =20
>          do {
>              if (yield_and_check(job)) {
> +                bdrv_co_unlock(lock);
>                  return 0;
>              }
> -            ret =3D backup_do_cow(job, offset,
> -                                job->cluster_size, &error_is_read, fal=
se);
> +            ret =3D backup_do_cow(job, offset, job->cluster_size, &err=
or_is_read);
>              if (ret < 0 && backup_error_action(job, error_is_read, -re=
t) =3D=3D
>                             BLOCK_ERROR_ACTION_REPORT)
>              {
> +                bdrv_co_unlock(lock);
>                  return ret;
>              }
>          } while (ret < 0);
> +
> +        bdrv_co_unlock(lock);
>      }
> =20
>      return 0;


--kErIDWrsS7ZyBQSQsgaIALmCne60esVbU--

--ylYCgS5jRhWzOBasyJkNhPXFR9d3ZAJtj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Cj5gACgkQ9AfbAGHV
z0DlVgf7B7x8lyf1q0GsFQVRz6XCwd0BGVamQlY/UPX4xfBU6e+IOpw2Tn4IZ8TR
P2737+tSMfaqKrn8U7nLkdeW9pZFx3JVjUlUPQzIJZYh0IS3lvFTMDOsk5KcArrO
UAuSxPGEJgDWY8KDCYitiMh8dydFXvLQMP1m78TDNO0qZEzUAPi7F9mRNgDxXehK
7Pa4Aon3Xu7Oa9BM55IYlYiFQ461ar2kL7CywwVsCFkXzAFSsagXiSGOneFNfw4x
9/aUvPY3C6N6HkzHriHYqjAXz/psUAbWae5+s+wjsQZVspIR8ZBtxb+S16MA6q/2
yLiob9RETrWXc0nlri9zKbYgbWCPCg==
=bFkG
-----END PGP SIGNATURE-----

--ylYCgS5jRhWzOBasyJkNhPXFR9d3ZAJtj--

