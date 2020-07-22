Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE2BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8258F20729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwjUIhZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8258F20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDmX-0004ER-NQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyDlo-0003hg-RJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:22:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyDln-0000BT-7Q
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595420565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1bMyfvr9a1fDde40Z5rH/5UgXB/swfVl5/wMwxh2BtY=;
 b=EwjUIhZdQGNUE9ap6U702rxXTG7phbaj6x9c6sNHR0Vqf4FJIcql478UhZf0T1N5/sqBS3
 ZI4GAVPgURdsNjLe56CNG3tuYAzDLDzgqhCnwHzZRYrDneVvEVtahq9e6Dr5mBw/UJrww2
 F7LsTN/o2fNwyTJNkLFHSPjR6aDU7Ps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-HRiPJNB_P2OFDthGAw445A-1; Wed, 22 Jul 2020 08:22:41 -0400
X-MC-Unique: HRiPJNB_P2OFDthGAw445A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2C8880BCAC;
 Wed, 22 Jul 2020 12:22:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-86.ams2.redhat.com
 [10.36.113.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77B575D9D3;
 Wed, 22 Jul 2020 12:22:37 +0000 (UTC)
Subject: Re: [PATCH v2 11/20] qapi: backup: add x-max-chunk and x-max-workers
 parameters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-12-vsementsov@virtuozzo.com>
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
Message-ID: <2117c54a-c9b3-59c6-c0b2-9fd84cb965b6@redhat.com>
Date: Wed, 22 Jul 2020 14:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-12-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3R8n183G8bc1F7lisDxqEHz3AQAvGHLld"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
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
--3R8n183G8bc1F7lisDxqEHz3AQAvGHLld
Content-Type: multipart/mixed; boundary="Vo58nyj8em1oGZ9ctRebQ8dsFbKseR2cz"

--Vo58nyj8em1oGZ9ctRebQ8dsFbKseR2cz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> Add new parameters to configure future backup features. The patch
> doesn't introduce aio backup requests (so we actually have only one
> worker) neither requests larger than one cluster. Still, formally we
> satisfy these maximums anyway, so add the parameters now, to facilitate
> further patch which will really change backup job behavior.
>=20
> Options are added with x- prefixes, as the only use for them are some
> very conservative iotests which will be updated soon.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json      |  9 ++++++++-
>  include/block/block_int.h |  7 +++++++
>  block/backup.c            | 21 +++++++++++++++++++++
>  block/replication.c       |  2 +-
>  blockdev.c                |  5 +++++
>  5 files changed, 42 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0c7600e4ec..f4abcde34e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1407,6 +1407,12 @@
>  #
>  # @x-use-copy-range: use copy offloading if possible. Default true. (Sin=
ce 5.1)
>  #
> +# @x-max-workers: maximum of parallel requests for static data backup. T=
his
> +#                 doesn't influence copy-before-write operations. (Since=
: 5.1)

I think I=E2=80=99d prefer something with =E2=80=9Cbackground=E2=80=9D rath=
er than or in
addition to =E2=80=9Cstatic=E2=80=9D, like =E2=80=9Cmaximum number of paral=
lel requests for the
sustained background backup operation=E2=80=9D.

> +#
> +# @x-max-chunk: maximum chunk length for static data backup. This doesn'=
t
> +#               influence copy-before-write operations. (Since: 5.1)
> +#
>  # Note: @on-source-error and @on-target-error only affect background
>  #       I/O.  If an error occurs during a guest write request, the devic=
e's
>  #       rerror/werror actions will be used.
> @@ -1421,7 +1427,8 @@
>              '*on-source-error': 'BlockdevOnError',
>              '*on-target-error': 'BlockdevOnError',
>              '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
> -            '*filter-node-name': 'str', '*x-use-copy-range': 'bool'  } }
> +            '*filter-node-name': 'str', '*x-use-copy-range': 'bool',
> +            '*x-max-workers': 'int', '*x-max-chunk': 'int64' } }
> =20
>  ##
>  # @DriveBackup:
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 93b9b3bdc0..d93a170d37 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1207,6 +1207,11 @@ void mirror_start(const char *job_id, BlockDriverS=
tate *bs,
>   * @sync_mode: What parts of the disk image should be copied to the dest=
ination.
>   * @sync_bitmap: The dirty bitmap if sync_mode is 'bitmap' or 'increment=
al'
>   * @bitmap_mode: The bitmap synchronization policy to use.
> + * @max_workers: The limit for parallel requests for main backup loop.
> + *               Must be >=3D 1.
> + * @max_chunk: The limit for one IO operation length in main backup loop=
.
> + *             Must be not less than job cluster size or zero. Zero mean=
s no
> + *             specific limit.
>   * @on_source_error: The action to take upon error reading from the sour=
ce.
>   * @on_target_error: The action to take upon error writing to the target=
.
>   * @creation_flags: Flags that control the behavior of the Job lifetime.
> @@ -1226,6 +1231,8 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>                              bool compress,
>                              const char *filter_node_name,
>                              bool use_copy_range,
> +                            int max_workers,
> +                            int64_t max_chunk,
>                              BlockdevOnError on_source_error,
>                              BlockdevOnError on_target_error,
>                              int creation_flags,
> diff --git a/block/backup.c b/block/backup.c
> index 76847b4daf..ec2676abc2 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -46,6 +46,8 @@ typedef struct BackupBlockJob {
>      uint64_t len;
>      uint64_t bytes_read;
>      int64_t cluster_size;
> +    int max_workers;
> +    int64_t max_chunk;
> =20
>      BlockCopyState *bcs;
>  } BackupBlockJob;
> @@ -335,6 +337,8 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
>                    bool compress,
>                    const char *filter_node_name,
>                    bool use_copy_range,
> +                  int max_workers,
> +                  int64_t max_chunk,
>                    BlockdevOnError on_source_error,
>                    BlockdevOnError on_target_error,
>                    int creation_flags,
> @@ -355,6 +359,16 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
>      assert(sync_mode !=3D MIRROR_SYNC_MODE_INCREMENTAL);
>      assert(sync_bitmap || sync_mode !=3D MIRROR_SYNC_MODE_BITMAP);
> =20
> +    if (max_workers < 1) {
> +        error_setg(errp, "At least one worker needed");
> +        return NULL;
> +    }
> +
> +    if (max_chunk < 0) {
> +        error_setg(errp, "max-chunk is negative");

Perhaps =E2=80=9Cmust be positive or 0=E2=80=9D instead?  I think most erro=
r messages
try to specify what is allowed instead of what isn=E2=80=99t.

> +        return NULL;
> +    }
> +
>      if (bs =3D=3D target) {
>          error_setg(errp, "Source and target cannot be the same");
>          return NULL;
> @@ -422,6 +436,11 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
>      if (cluster_size < 0) {
>          goto error;
>      }
> +    if (max_chunk && max_chunk < cluster_size) {
> +        error_setg(errp, "Required max-chunk (%" PRIi64") is less than b=
ackup "

(missing a space after PRIi64)

> +                   "cluster size (%" PRIi64 ")", max_chunk, cluster_size=
);

Should this be noted in the QAPI documentation?  (And perhaps the fact
that without copy offloading, we=E2=80=99ll never copy anything bigger than=
 one
cluster at a time anyway?)

> +        return NULL;
> +    }
> =20
>      /*
>       * If source is in backing chain of target assume that target is goi=
ng to be
> @@ -465,6 +484,8 @@ BlockJob *backup_job_create(const char *job_id, Block=
DriverState *bs,
>      job->bcs =3D bcs;
>      job->cluster_size =3D cluster_size;
>      job->len =3D len;
> +    job->max_workers =3D max_workers;
> +    job->max_chunk =3D max_chunk;
> =20
>      block_copy_set_progress_callback(bcs, backup_progress_bytes_callback=
, job);
>      block_copy_set_progress_meter(bcs, &job->common.job.progress);
> diff --git a/block/replication.c b/block/replication.c
> index 25987eab0f..a9ee82db80 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -563,7 +563,7 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
>          s->backup_job =3D backup_job_create(
>                                  NULL, s->secondary_disk->bs, s->hidden_d=
isk->bs,
>                                  0, MIRROR_SYNC_MODE_NONE, NULL, 0, false=
, NULL,
> -                                true,
> +                                true, 0, 0,

Passing 0 for max_workers will error out immediately, won=E2=80=99t it?

>                                  BLOCKDEV_ON_ERROR_REPORT,
>                                  BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
>                                  backup_job_completed, bs, NULL, &local_e=
rr);


--Vo58nyj8em1oGZ9ctRebQ8dsFbKseR2cz--

--3R8n183G8bc1F7lisDxqEHz3AQAvGHLld
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8YL4wACgkQ9AfbAGHV
z0BreQgAtr3Mn2mIgUsgypG8JtM8+Lg5cKtSd8O7yYPvEbvhTuUJhfQT8S2PXc5D
VMWH1Q3W8zJ30h1XUsw7hAuVsXJKYNCSmBSIhylYkC2v2fSmSbO3P5kIs2AW7VEj
+/tzN19uSs779+Xlml5JvI6NpN0oG1a15jlnT/tXrEMj58j2MVYjYliMfsm9Oi9x
+TPVz6mknAv9iY36AYKkfIAMVIgnFX6i+RCWjIarE2fjJGrxw5gG2/mzbF6gY4am
JpGgiQXnRQZoaPP01vAcnNmE72yn3poIUQNDfVFzHEBUQCTUgHa6JtsHqFZo0SWK
6a8pB3cBJWXdoyNAs7z6KPejOzR03w==
=ryGa
-----END PGP SIGNATURE-----

--3R8n183G8bc1F7lisDxqEHz3AQAvGHLld--


