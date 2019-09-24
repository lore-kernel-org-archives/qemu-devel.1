Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31210C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DC2214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DC2214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChqB-0000je-0i
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 06:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iChod-00084a-QO
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iChob-00059E-Nu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:13:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iChoX-00058T-UH; Tue, 24 Sep 2019 06:12:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73770300413C;
 Tue, 24 Sep 2019 10:12:56 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD6915D713;
 Tue, 24 Sep 2019 10:12:51 +0000 (UTC)
Subject: Re: [PATCH v4 02/10] block: reverse order for reopen commits
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <20190807141226.193501-3-vsementsov@virtuozzo.com>
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
Message-ID: <8aa8b6f1-0698-fa97-64e7-1dd251d0eeee@redhat.com>
Date: Tue, 24 Sep 2019 12:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807141226.193501-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r5dtV5m5P9VSnyV5DYeIAjeg9JcLyMtFT"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 24 Sep 2019 10:12:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r5dtV5m5P9VSnyV5DYeIAjeg9JcLyMtFT
Content-Type: multipart/mixed; boundary="9c3vNvdaAfwFOTKEsv3ZmvlVMLJalTfEP";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, fam@euphon.net,
 kwolf@redhat.com, den@openvz.org
Message-ID: <8aa8b6f1-0698-fa97-64e7-1dd251d0eeee@redhat.com>
Subject: Re: [PATCH v4 02/10] block: reverse order for reopen commits
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <20190807141226.193501-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190807141226.193501-3-vsementsov@virtuozzo.com>

--9c3vNvdaAfwFOTKEsv3ZmvlVMLJalTfEP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.19 16:12, Vladimir Sementsov-Ogievskiy wrote:
> It's needed to fix reopening qcow2 with bitmaps to RW. Currently it
> can't work, as qcow2 needs write access to file child, to mark bitmaps
> in-image with IN_USE flag. But usually children goes after parents in
> reopen queue and file child is still RO on qcow2 reopen commit. Reverse=

> reopen order to fix it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 696162cd7a..d59f9f97cb 100644
> --- a/block.c
> +++ b/block.c
> @@ -3476,10 +3476,16 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_q=
ueue, Error **errp)
>          bs_entry->perms_checked =3D true;
>      }
> =20
> -    /* If we reach this point, we have success and just need to apply =
the
> -     * changes
> +    /*
> +     * If we reach this point, we have success and just need to apply =
the
> +     * changes.
> +     *
> +     * Reverse order is used to comfort qcow2 driver: on commit it nee=
d to write
> +     * IN_USE flag to the image, to mark bitmaps in the image as inval=
id. But
> +     * children are usually goes after parents in reopen-queue, so go =
from last
> +     * to first element.
>       */
> -    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
> +    QTAILQ_FOREACH_REVERSE(bs_entry, bs_queue, entry) {
>          bdrv_reopen_commit(&bs_entry->state);
>      }

I suppose this works, but only because everything but the IN_USE thing
actually behaves correctly.  In theory, all the work is done by the time
=2Eprepare is through, so we can call commit in any order anyway.

So I=E2=80=99m still of the opinion that writing IN_USE in commit is just=
 plain
wrong.

It feels like you=E2=80=99re trying to work around wrongs in reopen by pi=
ling
more wrongs on top.  I don=E2=80=99t like reopen already, and I don=E2=80=
=99t think this
makes it any better.

I don=E2=80=99t like how the comment implies that everything is just as i=
t
should be, but that isn=E2=80=99t the real problem here, so whatever.


Well, at least the change is simple, and it doesn=E2=80=99t make things w=
orse
than they actually are already (that is, wrong), so

Acked-by: Max Reitz <mreitz@redhat.com>


--9c3vNvdaAfwFOTKEsv3ZmvlVMLJalTfEP--

--r5dtV5m5P9VSnyV5DYeIAjeg9JcLyMtFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2J7CIACgkQ9AfbAGHV
z0CnbAf+MI+l9TcrrMVQg41g51R7pl9HZXtlUDWOY0U5TpkkIfsH1KFDtLKBk5RH
/eMILFt9wyM2lCm6bp+Dws4btnfFejuIonZUZ2EeArdGOTbPEHPEW2PmHT1ZlAAy
DnSgZnyfAj/SboCio9Vx9rUhw4WBr7tqcVOTCpWXfPjqCK449cK08IkcRqKwaGl0
IbDCoc6f2WnO6Oqn7feDeRCV1W+82t+hxZAPxAXj5+/+9hlMA4pDjjlhiRZmXMjK
2RjrP5vUZpnFMGzYjFPFieCPJdgohZLirCBbvqJ1TphzWo8CUW7IzDZJbKKAKvbU
mmIsE/T8tgzJdfWscb1AHRbUzgo+mQ==
=w85i
-----END PGP SIGNATURE-----

--r5dtV5m5P9VSnyV5DYeIAjeg9JcLyMtFT--

