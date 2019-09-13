Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A62C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 07:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BDD20830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 07:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BDD20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8gOh-00057I-0F
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 03:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8gNw-0004as-Pw
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8gNv-0007BB-IW
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:52:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8gNs-00079P-1g; Fri, 13 Sep 2019 03:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57DF588304;
 Fri, 13 Sep 2019 07:52:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2625410016EA;
 Fri, 13 Sep 2019 07:52:42 +0000 (UTC)
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
References: <20190912161624.40886-1-slp@redhat.com>
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
Message-ID: <3ceab9a7-e002-a33e-d996-8c4fba374ece@redhat.com>
Date: Fri, 13 Sep 2019 09:52:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912161624.40886-1-slp@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YOmRZPFCwGM9l5Xer7PQvnOfJoBg74mi4"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 13 Sep 2019 07:52:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] blockdev: avoid acquiring AioContext lock
 twice at do_drive_backup()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YOmRZPFCwGM9l5Xer7PQvnOfJoBg74mi4
Content-Type: multipart/mixed; boundary="bbbhBacSvlKsXVEGKCnnt6WYWojgKWE4x";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com
Message-ID: <3ceab9a7-e002-a33e-d996-8c4fba374ece@redhat.com>
Subject: Re: [PATCH] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup()
References: <20190912161624.40886-1-slp@redhat.com>
In-Reply-To: <20190912161624.40886-1-slp@redhat.com>

--bbbhBacSvlKsXVEGKCnnt6WYWojgKWE4x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.09.19 18:16, Sergio Lopez wrote:
> do_drive_backup() acquires the AioContext lock of the corresponding
> BlockDriverState. This is not a problem when it's called from
> qmp_drive_backup(), but drive_backup_prepare() also acquires the lock
> before calling it.
>=20
> This change adds a BlockDriverState argument to do_drive_backup(),
> which is used to signal that the context lock is already acquired and
> to save a couple of redundant calls.

But those redundant calls don=E2=80=99t really hurt (it=E2=80=99s just bd=
rv_lookup_bs(),
as far as I can tell).  Wouldn=E2=80=99t it be simpler to just release th=
e
context lock in drive_backup_prepare() before calling do_drive_backup()?
 The BDS is drained anyway.

On top of that, do_backup_common() calls bdrv_try_set_aio_context() to
bring the target into the source=E2=80=99s AioContext.  However, this fun=
ction
must be called with the old AioContext held, and the new context not held=
=2E

Currently, it=E2=80=99s called exactly the other way around: With the new=

context held, but the old one not held.

So I think it indeed actually makes more sense to release the AioContext
before calling do_drive_backup(), and to move the
bdrv_try_set_aio_context() call for target_bs to the callers of
do_backup_common() (where they have not yet taken the AioContext lock).

Max

> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  blockdev.c | 54 ++++++++++++++++++++++++++++++++++++++----------------=

>  1 file changed, 38 insertions(+), 16 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index fbef6845c8..0cc6c69ceb 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1762,8 +1762,10 @@ typedef struct DriveBackupState {
>      BlockJob *job;
>  } DriveBackupState;
> =20
> -static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
> -                            Error **errp);
> +static BlockJob *do_drive_backup(DriveBackup *backup,
> +                                 BlockDriverState *backup_bs,
> +                                 JobTxn *txn,
> +                                 Error **errp);
> =20
>  static void drive_backup_prepare(BlkActionState *common, Error **errp)=

>  {
> @@ -1781,6 +1783,11 @@ static void drive_backup_prepare(BlkActionState =
*common, Error **errp)
>          return;
>      }
> =20
> +    if (!bs->drv) {
> +        error_setg(errp, "Device has no medium");
> +        return;
> +    }
> +
>      aio_context =3D bdrv_get_aio_context(bs);
>      aio_context_acquire(aio_context);
> =20
> @@ -1789,7 +1796,9 @@ static void drive_backup_prepare(BlkActionState *=
common, Error **errp)
> =20
>      state->bs =3D bs;
> =20
> -    state->job =3D do_drive_backup(backup, common->block_job_txn, &loc=
al_err);
> +    state->job =3D do_drive_backup(backup, bs,
> +                                 common->block_job_txn,
> +                                 &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          goto out;
> @@ -3607,7 +3616,9 @@ static BlockJob *do_backup_common(BackupCommon *b=
ackup,
>      return job;
>  }
> =20
> -static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
> +static BlockJob *do_drive_backup(DriveBackup *backup,
> +                                 BlockDriverState *backup_bs,
> +                                 JobTxn *txn,
>                                   Error **errp)
>  {
>      BlockDriverState *bs;
> @@ -3625,18 +3636,27 @@ static BlockJob *do_drive_backup(DriveBackup *b=
ackup, JobTxn *txn,
>          backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
>      }
> =20
> -    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
> -    if (!bs) {
> -        return NULL;
> -    }
> +    if (backup_bs) {
> +        bs =3D backup_bs;
> +        /*
> +         * If the caller passes us a BDS, we assume it has already
> +         * acquired the context lock.
> +         */
> +        aio_context =3D bdrv_get_aio_context(bs);
> +    } else {
> +        bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
> +        if (!bs) {
> +            return NULL;
> +        }
> =20
> -    if (!bs->drv) {
> -        error_setg(errp, "Device has no medium");
> -        return NULL;
> -    }
> +        if (!bs->drv) {
> +            error_setg(errp, "Device has no medium");
> +            return NULL;
> +        }
> =20
> -    aio_context =3D bdrv_get_aio_context(bs);
> -    aio_context_acquire(aio_context);
> +        aio_context =3D bdrv_get_aio_context(bs);
> +        aio_context_acquire(aio_context);
> +    }
> =20
>      if (!backup->has_format) {
>          backup->format =3D backup->mode =3D=3D NEW_IMAGE_MODE_EXISTING=
 ?
> @@ -3713,7 +3733,9 @@ static BlockJob *do_drive_backup(DriveBackup *bac=
kup, JobTxn *txn,
>  unref:
>      bdrv_unref(target_bs);
>  out:
> -    aio_context_release(aio_context);
> +    if (!backup_bs) {
> +        aio_context_release(aio_context);
> +    }
>      return job;
>  }
> =20
> @@ -3721,7 +3743,7 @@ void qmp_drive_backup(DriveBackup *arg, Error **e=
rrp)
>  {
> =20
>      BlockJob *job;
> -    job =3D do_drive_backup(arg, NULL, errp);
> +    job =3D do_drive_backup(arg, NULL, NULL, errp);
>      if (job) {
>          job_start(&job->job);
>      }
>=20



--bbbhBacSvlKsXVEGKCnnt6WYWojgKWE4x--

--YOmRZPFCwGM9l5Xer7PQvnOfJoBg74mi4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17SsgACgkQ9AfbAGHV
z0AdbQf/bO0H2s82J0qG5Mny55BzJM/dAovfWOvXDeQmLPXYUWfteJp4Bo9d+gEC
OaLxvkzmcclvMR33Zjy2Z6RllgbTYZIHLVQHtUwL8N7jz/GOogv/Awf2kF6b4vJi
JYt6bJRwu8044YinZZH2ETiE18yD7gkl3+aVdwm7HlwApliQ0p1aBqflc6FOcUW8
sEunOELx99Bx86Rp3oQc9mP8j7xL8qOGMiRWDZDoi52w+RgdpcmpDY80HdraVUK5
/soElST6kyu9q0t+T7yP2ZaRjGgwcXhS+65xdF6oNTORKPd0afz5oG6qNw0aXE/m
qKNg5xKwz73ixqZCM6XI81IXd5sVeQ==
=jKoZ
-----END PGP SIGNATURE-----

--YOmRZPFCwGM9l5Xer7PQvnOfJoBg74mi4--

