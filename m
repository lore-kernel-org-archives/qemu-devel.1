Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E45C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B2F208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B2F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfm6S-0000IT-4z
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38741)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfm2O-0006zg-6D
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfm2N-0005LM-14
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:03:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfm2K-00043h-Ea; Tue, 25 Jun 2019 10:03:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C8883086214;
 Tue, 25 Jun 2019 14:02:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-156.brq.redhat.com
 [10.40.204.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0407D600CD;
 Tue, 25 Jun 2019 14:02:11 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190509145927.293369-1-sgarzare@redhat.com>
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
Message-ID: <7a3e37bd-dd24-a97f-5354-7793df44c53e@redhat.com>
Date: Tue, 25 Jun 2019 16:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190509145927.293369-1-sgarzare@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qPoTTjyxGxO4trvXkXJiqm9tsxoEIPQQF"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 25 Jun 2019 14:02:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: increase dynamically the
 image size
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 Jason Dillaman <jdillama@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qPoTTjyxGxO4trvXkXJiqm9tsxoEIPQQF
Content-Type: multipart/mixed; boundary="Gee5FwrnoQnsbQhdeg3vmJ2DQfICOZrIA";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Dillaman <jdillama@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>
Message-ID: <7a3e37bd-dd24-a97f-5354-7793df44c53e@redhat.com>
Subject: Re: [PATCH v3] block/rbd: increase dynamically the image size
References: <20190509145927.293369-1-sgarzare@redhat.com>
In-Reply-To: <20190509145927.293369-1-sgarzare@redhat.com>

--Gee5FwrnoQnsbQhdeg3vmJ2DQfICOZrIA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.05.19 16:59, Stefano Garzarella wrote:
> RBD APIs don't allow us to write more than the size set with
> rbd_create() or rbd_resize().
> In order to support growing images (eg. qcow2), we resize the
> image before write operations that exceed the current size.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
>   - add 'image_size' field in the BDRVRBDState to keep track of the
>     current size of the RBD image [Jason, Kevin]
> ---
>  block/rbd.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 0c549c9935..b0355a2ce0 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c

[...]

> @@ -833,6 +842,22 @@ static void qemu_rbd_close(BlockDriverState *bs)
>      rados_shutdown(s->cluster);
>  }
> =20
> +/* Resize the RBD image and update the 'image_size' with the current s=
ize */
> +static int qemu_rbd_resize(BlockDriverState *bs, uint64_t size)
> +{
> +    BDRVRBDState *s =3D bs->opaque;
> +    int r;
> +
> +    r =3D rbd_resize(s->image, size);
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    s->image_size =3D size;

I think this should update bs->total_sectors, too.  In fact, I=E2=80=99m
wondering why you don=E2=80=99t just use bs->total_sectors (or bdrv_getle=
ngth(),
which returns bs->total_sectors * 512) instead of adding this new field?

Max

> +
> +    return 0;
> +}
> +
>  static const AIOCBInfo rbd_aiocb_info =3D {
>      .aiocb_size =3D sizeof(RBDAIOCB),
>  };


--Gee5FwrnoQnsbQhdeg3vmJ2DQfICOZrIA--

--qPoTTjyxGxO4trvXkXJiqm9tsxoEIPQQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0SKVwACgkQ9AfbAGHV
z0Ax6wgAjx11LBLHzep7bt+bgVD/NctciVZn/UuMBepZFAz+k+0nNX4cy2c0NXMx
MFLftbl0LNlSmKFDQpctnn8dDbNkMjPvkQ6mkiwKb15IP8i15+Y+AXOtCcXzao/c
Q1SISotBMrm4713Uz2uBZEyoIovHn4MsVaSRB0TABfpaEj4fHw4RgarYKUr/q0jv
mJBUZOns48sHxuXnjjGCM45/wLa3R9I7neqO/geit0jWxIxP3cg38Uk8m/OndrfR
EK7aqKxihSPG4WH+lw50OjV3OQXZEbioY4oBEEDaMyy+POl12Vm8iFuawZCTABsT
CySrInHv8doD3Zu/h9O5XhNv6wRJaA==
=r1Lu
-----END PGP SIGNATURE-----

--qPoTTjyxGxO4trvXkXJiqm9tsxoEIPQQF--

