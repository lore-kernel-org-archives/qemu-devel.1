Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E4BC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F391218B8
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F391218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3LE-00073E-CT
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 11:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35545)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hj3KJ-0006TZ-To
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hj3KH-0005kC-Vp
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:07:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hj3KF-0005eA-0o; Thu, 04 Jul 2019 11:07:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F28F7356E4;
 Thu,  4 Jul 2019 15:06:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-93.brq.redhat.com
 [10.40.204.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 286A7177F0;
 Thu,  4 Jul 2019 15:06:46 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-3-jsnow@redhat.com>
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
Message-ID: <04397b94-63d6-7d2c-77ad-964abe0e0310@redhat.com>
Date: Thu, 4 Jul 2019 17:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703215542.16123-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uSfIrnRTPwrBgIbiTIrrX9FgDMub166eO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 04 Jul 2019 15:07:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/18] drive-backup: create
 do_backup_common
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uSfIrnRTPwrBgIbiTIrrX9FgDMub166eO
Content-Type: multipart/mixed; boundary="CFChXodEQWBuQdezWSztihfVZeuB728Sa";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <04397b94-63d6-7d2c-77ad-964abe0e0310@redhat.com>
Subject: Re: [PATCH v2 02/18] drive-backup: create do_backup_common
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-3-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-3-jsnow@redhat.com>

--CFChXodEQWBuQdezWSztihfVZeuB728Sa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 23:55, John Snow wrote:
> Create a common core that comprises the actual meat of what the backup =
API
> boundary needs to do, and then switch drive-backup to use it.
>=20
> Questions:
>  - do_drive_backup now acquires and releases the aio_context in additio=
n
>    to do_backup_common doing the same. Can I drop this from drive_backu=
p?

I wonder why you don=E2=80=99t just make it a requirement that
do_backup_common() is called with the context acquired?

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 138 ++++++++++++++++++++++++++++++++---------------------=

>  1 file changed, 83 insertions(+), 55 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 4d141e9a1f..5fd663a7e5 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3425,6 +3425,86 @@ out:
>      aio_context_release(aio_context);
>  }
> =20
> +static BlockJob *do_backup_common(BackupCommon *backup,
> +                                  BlockDriverState *target_bs,
> +                                  JobTxn *txn, Error **errp)
> +{

[...]

> +    job =3D backup_job_create(backup->job_id, bs, target_bs, backup->s=
peed,
> +                            backup->sync, bmap, backup->compress,
> +                            backup->on_source_error, backup->on_target=
_error,
> +                            job_flags, NULL, NULL, txn, &local_err);
> +    if (local_err !=3D NULL) {
> +        error_propagate(errp, local_err);
> +        goto out;
> +    }

Below, you change do_drive_backup() to just pass errp instead of
local_err and not do error handling.  Why not do the same here?

Other than that:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +
> +out:
> +    aio_context_release(aio_context);
> +    return job;
> +}


--CFChXodEQWBuQdezWSztihfVZeuB728Sa--

--uSfIrnRTPwrBgIbiTIrrX9FgDMub166eO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0eFgUACgkQ9AfbAGHV
z0DvnAf7BGJjnUFZSTFT5yLfaI5U81diCA5Gz7z6/rotik3huwQO49dvuIYY+m79
duvnRIbwqy1ogFQa3bIYSKT6U8mgxtHL+0YV+Uvs95DB5hv1hRllClH/cdGfFsF4
ASSAm2DJW0xg0S7EP8kBHV8ic8PI6O7Nd9RaZ9p7mQeTiofsBX97/xF/B4f8g59u
l8UX+hidrIiPqEI31ULHadVwvtgB83LV/tdaa680G2jCfeZtiPBLFaXwrQGTZZS+
zidiAD3rXOF8c83VQt95DZI11dyHf4YWa0Cut/PmOmCbvdwdFXz0v2hMBm6rcZpK
qgfjTkxvf4sfEHNBoyCQpvpmAZLZ6Q==
=sB+6
-----END PGP SIGNATURE-----

--uSfIrnRTPwrBgIbiTIrrX9FgDMub166eO--

