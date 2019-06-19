Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2E0C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6332B21783
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6332B21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40410 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hddbQ-0002b8-MK
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 12:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35440)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hddaf-0001Hq-K8
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hddae-00038Z-FF
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:37:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hddaX-0002zq-88; Wed, 19 Jun 2019 12:37:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A7C730860B8;
 Wed, 19 Jun 2019 16:37:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-121.ams2.redhat.com
 [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37C8A5C2E6;
 Wed, 19 Jun 2019 16:37:26 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190619144447.215894-1-vsementsov@virtuozzo.com>
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
Message-ID: <94df77c0-c44a-49c8-ab16-6a637c55088c@redhat.com>
Date: Wed, 19 Jun 2019 18:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619144447.215894-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Zuon5sJucPR1uhPa8ROYyiWeWu34uX5Yt"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 19 Jun 2019 16:37:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] blockjob: drain all job nodes in
 block_job_drain
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
Cc: kwolf@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zuon5sJucPR1uhPa8ROYyiWeWu34uX5Yt
Content-Type: multipart/mixed; boundary="kbzKnNEHy4E2uqOJEdH9EZKpR3t4eXMK3";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com
Message-ID: <94df77c0-c44a-49c8-ab16-6a637c55088c@redhat.com>
Subject: Re: [PATCH] blockjob: drain all job nodes in block_job_drain
References: <20190619144447.215894-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190619144447.215894-1-vsementsov@virtuozzo.com>

--kbzKnNEHy4E2uqOJEdH9EZKpR3t4eXMK3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.06.19 16:44, Vladimir Sementsov-Ogievskiy wrote:
> Instead of draining additional nodes in each job code, let's do it in
> common block_job_drain, draining just all job's children.
>=20
> It's also a first step to finally get rid of blockjob->blk.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all!
>=20
> As a follow-up for "block: drop bs->job" recently merged, I'm now tryin=
g
> to drop BlockJob.blk pointer, jobs really works with several nodes and
> now reason to keep special blk for one of the children, and no reason t=
o
> handle nodes differently in, for example, backup code..
>=20
> And as a first step I need to sort out block_job_drain, and here is my
> suggestion on it.
>=20
>  block/backup.c | 18 +-----------------
>  block/mirror.c | 26 +++-----------------------
>  blockjob.c     |  7 ++++++-
>  3 files changed, 10 insertions(+), 41 deletions(-)

Looks good to me.  Two questions though:

Would it make sense to remove BlockJobDriver.drain() now?  I think
everything that isn=E2=80=99t =E2=80=9Cdrain the attached nodes=E2=80=9D =
should be handled by
JobDriver.pause(), no?

> diff --git a/blockjob.c b/blockjob.c
> index 458ae76f51..0cabdc867d 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -94,8 +94,13 @@ void block_job_drain(Job *job)
>      BlockJob *bjob =3D container_of(job, BlockJob, job);
>      const JobDriver *drv =3D job->driver;
>      BlockJobDriver *bjdrv =3D container_of(drv, BlockJobDriver, job_dr=
iver);
> +    GSList *l;
> +
> +    for (l =3D bjob->nodes; l; l =3D l->next) {
> +        BdrvChild *c =3D l->data;
> +        bdrv_drain(c->bs);
> +    }

Could it be more efficient to bdrv_drained_begin() all nodes in one loop
and then bdrv_drained_end() them all in a second one?

(Draining a node means draining its parents, and that is quicker if
they=E2=80=99re drained already.  If the nodes are in a chain, just using=

bdrv_drain() may mean some nodes are drained and undrained a couple of
times.)

Max

> =20
> -    blk_drain(bjob->blk);
>      if (bjdrv->drain) {
>          bjdrv->drain(bjob);
>      }
>=20



--kbzKnNEHy4E2uqOJEdH9EZKpR3t4eXMK3--

--Zuon5sJucPR1uhPa8ROYyiWeWu34uX5Yt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0KZMUACgkQ9AfbAGHV
z0AvGwf/Wi6vmtKC8X3ONQmzUElsCp0iiKrFjgyFFDbGAXraepI4/tuS8BKY+Jsz
RSZWhM0gLuah1CBqGWcZueoijrmw/x7EYhz5VkrTVYQbL/HZfl72CU77W0uzvZGS
/0od0G8t28Gmtfdv/RMsgrHZ82wGLn9ocpI9uB2skOVymG2iRV2ZqbJW0Yn/PC0P
izdGYqjQe6hETap/KeyD8NkpYDnAK1moQNLSriqHvMU1LXnCuVmUK6wSxQDHjkfJ
TB/jQoTBoX/f9AfzRPszYHRtx6zqyr9jDS7aor4ABlOqfAPmj7nwUJibttFi/L7T
KZQKCJNAd6o2ZpWhLiCmu6ao+y4s7Q==
=tYVD
-----END PGP SIGNATURE-----

--Zuon5sJucPR1uhPa8ROYyiWeWu34uX5Yt--

