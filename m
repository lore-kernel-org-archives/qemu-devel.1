Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC54CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8C822CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8C822CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34ga-0005ef-EM
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i33yG-0006VR-T0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i33yF-0000Oi-2d
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:51:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i33yA-0000MI-Hu; Wed, 28 Aug 2019 15:51:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FA1F317528A;
 Wed, 28 Aug 2019 19:51:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
 [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21AFB1001944;
 Wed, 28 Aug 2019 19:50:52 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-14-vsementsov@virtuozzo.com>
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
Message-ID: <bcfb962a-0ca1-7f3f-1db4-5098c66a08da@redhat.com>
Date: Wed, 28 Aug 2019 21:50:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826161312.489398-14-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6zeu1DzNFrZsqy8zFhXZYldPeL43ZzUUG"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 28 Aug 2019 19:51:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 13/13] block/backup: use backup-top
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
Cc: fam@euphon.net, kwolf@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6zeu1DzNFrZsqy8zFhXZYldPeL43ZzUUG
Content-Type: multipart/mixed; boundary="E0UfdNbytQln61Q7FJqUoBcgrb7FwpP54";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net,
 stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <bcfb962a-0ca1-7f3f-1db4-5098c66a08da@redhat.com>
Subject: Re: [PATCH v9 13/13] block/backup: use backup-top instead of write
 notifiers
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-14-vsementsov@virtuozzo.com>
In-Reply-To: <20190826161312.489398-14-vsementsov@virtuozzo.com>

--E0UfdNbytQln61Q7FJqUoBcgrb7FwpP54
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.19 18:13, Vladimir Sementsov-Ogievskiy wrote:
> Drop write notifiers and use filter node instead.
>=20
> =3D Changes =3D
>=20
> 1. add filter-node-name argument for backup qmp api. We have to do it
> in this commit, as 257 needs to be fixed.

I feel a bit bad about it not being an implicit node.  But I know you
don=E2=80=99t like them, they=E2=80=99re probably just broken altogether =
and because
libvirt doesn=E2=80=99t use backup (yet), probably nobody cares.

> 2. there no move write notifiers here, so is_write_notifier parameter

s/there/there are/, I suppose?

> is dropped from block-copy paths.
>=20
> 3. Intersecting requests handling changed, now synchronization between
> backup-top, backup and guest writes are all done in block/block-copy.c
> and works as follows:
>=20
> On copy operation, we work only with dirty areas. If bits are dirty it
> means that there are no requests intersecting with this area. We clear
> dirty bits and take bdrv range lock (bdrv_co_try_lock) on this area to
> prevent further operations from interaction with guest (only with
> guest, as neither backup nor backup-top will touch non-dirty area). If
> copy-operation failed we set dirty bits back together with releasing
> the lock.
>=20
> The actual difference with old scheme is that on guest writes we
> don't lock the whole region but only dirty-parts, and to be more
> precise: only dirty-part we are currently operate on. In old scheme
> guest write to non-dirty area (which may be safely ignored by backup)
> may wait for intersecting request, touching some other area which is
> dirty.
>=20
> 4. To sync with in-flight requests at job finish we now have drained
> removing of the filter, we don't need rw-lock.
>=20
> =3D Notes =3D
>=20
> Note the consequence of three objects appearing: backup-top, backup job=

> and block-copy-state:
>=20
> 1. We want to insert backup-top before job creation, to behave similar
> with mirror and commit, where job is started upon filter.
>=20
> 2. We also have to create block-copy-state after filter injection, as
> we don't want it's source child be replaced by fitler. Instead we want

s/it's/its/, s/filter/filter/ (although =E2=80=9Cfitler=E2=80=9D does hav=
e an amusing
ring to it)

> to keep BCS.source to be real source node, as we want to use
> bdrv_co_try_lock in CBW operations and it can't be used on filter, as
> on filter we already have in-flight (write) request from upper layer.

Reasonable, even more so as I suppose BCS.source should eventually be a
BdrvChild of backup-top.

What looks wrong is that the sync_bitmap is created on the source (=E2=80=
=9Cbs=E2=80=9D
in backup_job_create()), but backup_cleanup_sync_bitmap() still assumes
it is on blk_bs(job->common.blk) (which is no longer true).

> So, we firstly create inject backup-top, then create job and BCS. BCS
> is the latest just to not create extra variable for it. Finally we set
> bcs for backup-top filter.
>=20
> =3D Iotest changes =3D
>=20
> 56: op-blocker doesn't shot now, as we set it on source, but then check=


s/shot/show/?

> on filter, when trying to start second backup, so error caught in
> test_dismiss_collision is changed. It's OK anyway, as this test-case
> seems to test that after some collision we can dismiss first job and
> successfully start the second one. So, the change is that collision is
> changed from op-blocker to file-posix locks.

Well, but the op blocker belongs to the source, which should be covered
by internal permissions.  The fact that it now shows up as a file-posix
error thus shows that the conflict also moves from the source to the
target.  It=E2=80=99s OK because we actually don=E2=80=99t have a conflic=
t on the source.

But I wonder whether it would be better for test_dismiss_collision() to
do a blockdev-backup instead where we can see the collision on the target=
=2E

Hm.  On second thought, why do we even get a conflict on the target?
block-copy does share the WRITE permission for it...

> However, it's obvious now that we'd better drop this op-blocker at all
> and add a test-case for two backups from one node (to different
> destinations) actually works. But not in these series.
>=20
> 257: The test wants to emulate guest write during backup. They should
> go to filter node, not to original source node, of course. Therefore we=

> need to specify filter node name and use it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json       |   8 +-
>  include/block/block-copy.h |   2 +-
>  include/block/block_int.h  |   1 +
>  block/backup-top.c         |  14 +-
>  block/backup.c             | 113 +++-----------
>  block/block-copy.c         |  55 ++++---
>  block/replication.c        |   2 +-
>  blockdev.c                 |   1 +
>  tests/qemu-iotests/056     |   2 +-
>  tests/qemu-iotests/257     |   7 +-
>  tests/qemu-iotests/257.out | 306 ++++++++++++++++++-------------------=

>  11 files changed, 230 insertions(+), 281 deletions(-)

Nice.

I don=E2=80=99t have much to object (for some reason, I feel a bit uneasy=
 about
dropping all the request waiting code, but I suppose that is indeed
taken care of with the range locks now).

[...]

> diff --git a/block/backup.c b/block/backup.c
> index d927c63e5a..259a165405 100644
> --- a/block/backup.c
> +++ b/block/backup.c

[...]

> @@ -552,6 +480,9 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>          backup_clean(&job->common.job);
>          job_early_fail(&job->common.job);
>      }
> +    if (backup_top) {
> +        bdrv_backup_top_drop(backup_top);
> +    }

This order is weird because backup-top still has a pointer to the BCS,
but we have already freed it at this point.

> =20
>      return NULL;
>  }
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 6828c46ba0..f3102ec3ff 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -98,27 +98,32 @@ fail:
>   * error occurred, return a negative error number
>   */
>  static int coroutine_fn block_copy_with_bounce_buffer(
> -        BlockCopyState *s, int64_t start, int64_t end, bool is_write_n=
otifier,
> +        BlockCopyState *s, int64_t start, int64_t end,
>          bool *error_is_read, void **bounce_buffer)
>  {
>      int ret;
> -    int nbytes;
> -    int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0=
;
> +    int nbytes =3D MIN(s->cluster_size, s->len - start);
> +    void *lock =3D bdrv_co_try_lock(blk_bs(s->source), start, nbytes);=

> +
> +    /*
> +     * Function must be called only on full-dirty region, so nobody to=
uching or
> +     * touched these bytes. Therefore, we must successfully get lock.

Which is OK because backup-top does not share the WRITE permission.  But
it is organized a bit weirdly, because it=E2=80=99s actually block-copy h=
ere
that relies on the WRITE permission not to be shared; which it itself
cannot do because backup-top needs it.

This of course results from the fact that backup-top and block-copy
should really use the same object to access the source, namely the
backing BdrvChild of backup-top.

Maybe there should be a comment somewhere that points this out?

> +     */
> +    assert(lock);

[...]

> @@ -128,13 +133,16 @@ static int coroutine_fn block_copy_with_bounce_bu=
ffer(
>          if (error_is_read) {
>              *error_is_read =3D false;
>          }
> -        goto fail;
> +        goto out;
>      }
> =20
> -    return nbytes;
> -fail:
> -    bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
> -    return ret;
> +out:
> +    if (ret < 0) {
> +        bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);=

> +    }
> +    bdrv_co_unlock(lock);
> +
> +    return ret < 0 ? ret : nbytes;
> =20

I feel like it would still be simpler to keep the separate fail path and
just duplicate the bdrv_co_unlock(lock) call.

[...]

> diff --git a/blockdev.c b/blockdev.c
> index fbef6845c8..f89e48fc79 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3601,6 +3601,7 @@ static BlockJob *do_backup_common(BackupCommon *b=
ackup,
>      job =3D backup_job_create(backup->job_id, bs, target_bs, backup->s=
peed,
>                              backup->sync, bmap, backup->bitmap_mode,
>                              backup->compress,
> +                            backup->filter_node_name,

Is this guaranteed to be NULL when not specified by the user?

Max


--E0UfdNbytQln61Q7FJqUoBcgrb7FwpP54--

--6zeu1DzNFrZsqy8zFhXZYldPeL43ZzUUG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1m2xsACgkQ9AfbAGHV
z0DEzAf/Wh6O1UXU2ojx4e7DKkZ6YB37jqPlmPCbiecCfsMJVt+fwjb7GHJI6oO9
ogmiGIthE3lT4WvgNijYxdXSHRF1czSn5V4t4B1rLZZFH2rZxI/asw6OSoGpqLuW
SfDvO5O/ASY5/XPm32Vhgbh9y9xQW+yq0ckQFa3j/tIlXOXj5DBhtgVhkuZI3JHV
Km3JzqXN7a7jwo2X8LuFEbcE/iHIP8/iTLbzVpLxHrAUpEwGcGCriaVdks8LNOC9
j3LpnDGBJjURVyQUp8SFFxAwFXksXGJiViBUtv4fWBxiqoyqBz5WA913Mq1ViY4N
zQA7c2jWuDmf/d9H/ZspV8WjnsCVbg==
=QPqR
-----END PGP SIGNATURE-----

--6zeu1DzNFrZsqy8zFhXZYldPeL43ZzUUG--

