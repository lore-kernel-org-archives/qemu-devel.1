Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F7DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 17:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD29120663
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 17:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD29120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxEaz-0004ZR-6i
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 13:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxEaN-0003hl-Bh
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 13:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxEaM-0006rU-Bl
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 13:58:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxEaJ-0006nF-Pz; Mon, 12 Aug 2019 13:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B206315C037;
 Mon, 12 Aug 2019 17:58:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 996F0183BD;
 Mon, 12 Aug 2019 17:58:16 +0000 (UTC)
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-6-anton.nefedov@virtuozzo.com>
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
Message-ID: <b0af8e55-81a9-d9c4-e65e-04a6cec802b6@redhat.com>
Date: Mon, 12 Aug 2019 19:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190516143314.81302-6-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SI6qU558httXi2hr8g3cAYz7Zxl0IZyG3"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 12 Aug 2019 17:58:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 5/9] scsi: store unmap offset and
 nb_sectors in request struct
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SI6qU558httXi2hr8g3cAYz7Zxl0IZyG3
Content-Type: multipart/mixed; boundary="5tC6j0bGEkT4cXoDoVDyhXWjgCqjZvm1G";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com,
 vsementsov@virtuozzo.com
Message-ID: <b0af8e55-81a9-d9c4-e65e-04a6cec802b6@redhat.com>
Subject: Re: [PATCH v8 5/9] scsi: store unmap offset and nb_sectors in request
 struct
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-6-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190516143314.81302-6-anton.nefedov@virtuozzo.com>

--5tC6j0bGEkT4cXoDoVDyhXWjgCqjZvm1G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.05.19 16:33, Anton Nefedov wrote:
> it allows to report it in the error handler
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  hw/scsi/scsi-disk.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

(Sorry for the late reply :-/)

> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e7e865ab3b..b43254103c 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -1602,8 +1602,6 @@ static void scsi_unmap_complete_noio(UnmapCBData =
*data, int ret)
>  {
>      SCSIDiskReq *r =3D data->r;
>      SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> -    uint64_t sector_num;
> -    uint32_t nb_sectors;
> =20
>      assert(r->req.aiocb =3D=3D NULL);
>      if (scsi_disk_req_check_error(r, ret, false)) {
> @@ -1611,16 +1609,16 @@ static void scsi_unmap_complete_noio(UnmapCBDat=
a *data, int ret)
>      }
> =20
>      if (data->count > 0) {
> -        sector_num =3D ldq_be_p(&data->inbuf[0]);
> -        nb_sectors =3D ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;
> -        if (!check_lba_range(s, sector_num, nb_sectors)) {
> +        r->sector =3D ldq_be_p(&data->inbuf[0]);
> +        r->sector_count =3D ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;=

> +        if (!check_lba_range(s, r->sector, r->sector_count)) {
>              scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
>              goto done;
>          }
> =20
>          r->req.aiocb =3D blk_aio_pdiscard(s->qdev.conf.blk,
> -                                        sector_num * s->qdev.blocksize=
,
> -                                        nb_sectors * s->qdev.blocksize=
,
> +                                        r->sector * s->qdev.blocksize,=

> +                                        r->sector_count * s->qdev.bloc=
ksize,

This looks to me like these are not necessarily in terms of 512-byte
sectors.  It doesn=E2=80=99t seem to make anything technically wrong, bec=
ause
patch 7 takes that into account.

But it=E2=80=99s still weird if everything else in this file treats these=
 fields
as being in terms of 512 byte sectors (and they are actually defined
this way in SCSIDiskReq).

Max

>                                          scsi_unmap_complete, data);
>          data->count--;
>          data->inbuf +=3D 16;
>=20



--5tC6j0bGEkT4cXoDoVDyhXWjgCqjZvm1G--

--SI6qU558httXi2hr8g3cAYz7Zxl0IZyG3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RqLYACgkQ9AfbAGHV
z0BEWgf+K0UBixIHeQII2TH1evWrQv9wU2kjSN3OoAqlIkCYlneJTFlR7jMgb0uj
8TNII1tOqqehZ7lpENilCxwL1G8z4a4x23g0BWD4yL0seNCmdOnx+X4q+bjgqW7V
Imk9C06ZTBq/yk0eQDWG3UVmhT/OBH2oiRUDcsyhqBjHkb0lCMSK0mCz030fkcUq
coOnaSRySdCJScH593uWFIdtMWVjCaNB/UqJcgM7tuIha0SUCH+tM2vOHfKYtqo8
hI2ew2rvqQ+/WfjiqBj8wlWdHddlYBO+4HgU2eBGHoYtL8ZgLZnXf9DnplsRzXJj
UeDA1+0QD9mlXd8Rgoimk6Vu0Fb67g==
=59uy
-----END PGP SIGNATURE-----

--SI6qU558httXi2hr8g3cAYz7Zxl0IZyG3--

