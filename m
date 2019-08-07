Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D27AC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9527219BE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9527219BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQeG-0001AR-9y
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38851)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hvQdV-00007E-I4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hvQdU-0000tK-LE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hvQdS-0000ik-04; Wed, 07 Aug 2019 14:26:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF6413082149;
 Wed,  7 Aug 2019 18:26:04 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-24.brq.redhat.com
 [10.40.204.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B76DF608A7;
 Wed,  7 Aug 2019 18:25:56 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-7-vsementsov@virtuozzo.com>
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
Message-ID: <3ca4a9e1-3889-dfba-71b9-22c828e59661@redhat.com>
Date: Wed, 7 Aug 2019 20:25:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807080750.15950-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EHAahlV88l9mWLhR1uIRDvz7Lile3gNvh"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 07 Aug 2019 18:26:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/8] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EHAahlV88l9mWLhR1uIRDvz7Lile3gNvh
Content-Type: multipart/mixed; boundary="15uiX06kbmhaXAjQjW4unooWfnWB3MNtA";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <3ca4a9e1-3889-dfba-71b9-22c828e59661@redhat.com>
Subject: Re: [PATCH 6/8] block/backup: teach backup_cow_with_bounce_buffer to
 copy more at once
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-7-vsementsov@virtuozzo.com>
In-Reply-To: <20190807080750.15950-7-vsementsov@virtuozzo.com>

--15uiX06kbmhaXAjQjW4unooWfnWB3MNtA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.19 10:07, Vladimir Sementsov-Ogievskiy wrote:
> backup_cow_with_offload can transfer more than on cluster. Let
> backup_cow_with_bounce_buffer behave similarly. It reduces number
> of IO and there are no needs to copy cluster by cluster.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index eb41e4af4f..c765c073ad 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -104,22 +104,24 @@ static int coroutine_fn backup_cow_with_bounce_bu=
ffer(BackupBlockJob *job,
>                                                        int64_t start,
>                                                        int64_t end,
>                                                        bool is_write_no=
tifier,
> -                                                      bool *error_is_r=
ead,
> -                                                      void **bounce_bu=
ffer)
> +                                                      bool *error_is_r=
ead)
>  {
>      int ret;
>      BlockBackend *blk =3D job->common.blk;
>      int nbytes;
>      int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0=
;
> +    void *bounce_buffer =3D blk_try_blockalign(blk, end);

s/end/end - start/ (or probably rather s/end/nbytes/ after that has been
set).

Rest looks good.

Max

> =20
> -    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
> -    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size=
);
> -    nbytes =3D MIN(job->cluster_size, job->len - start);
> -    if (!*bounce_buffer) {
> -        *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
> +    if (!bounce_buffer) {
> +        return -ENOMEM;
>      }


--15uiX06kbmhaXAjQjW4unooWfnWB3MNtA--

--EHAahlV88l9mWLhR1uIRDvz7Lile3gNvh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1LF7MACgkQ9AfbAGHV
z0BQGAgAnb67vLMrRP5iKY1vjHvLGtDRc/l367GQMFwJtvJCYQsJOpdduATBEX9m
wk9KkDvkMz26HYmOBVHO8xVd4Ji82BnjDxeqlY6b7D/F8MElTWD0PTc2VGAHM8mU
dq6z9C8Endqu3OrL1G4gb9GnMCWtXp4HFtlpt6V2P4dKwYH4TR9v+x7tJYZ26i3H
g6ftNwcwygTEx3O92F6M17rgcjLeYKSHM0dS7sfdQG3DPzaA53VxA+5VlqoXpLuY
dYTLVy7hqHbetu1hHfpgigJEVvByrH87CfyhAiDAgT9Lf7wZsdj2WmZvtn1Cjobt
MY90LkPHHFLtHz2Q1yEkDgA60ZeUdA==
=Sg1t
-----END PGP SIGNATURE-----

--EHAahlV88l9mWLhR1uIRDvz7Lile3gNvh--

