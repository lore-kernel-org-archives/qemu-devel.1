Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D28C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 19:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1AC20651
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 19:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1AC20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxc8C-0004HC-Kp
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 15:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxc7S-0003he-Ma
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 15:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxc7Q-0005jB-5g
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 15:06:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxc7N-0005hY-KC; Tue, 13 Aug 2019 15:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6A7E308FC22;
 Tue, 13 Aug 2019 19:06:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E3F44B6;
 Tue, 13 Aug 2019 19:05:56 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, seabios@seabios.org,
 kraxel@redhat.com, kevin@koconnor.net
References: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
 <20190626123948.10199-6-shmuel.eiderman@oracle.com>
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
Message-ID: <8e54c29d-119b-e02b-8966-56fa7ea91f9e@redhat.com>
Date: Tue, 13 Aug 2019 21:05:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190626123948.10199-6-shmuel.eiderman@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eIeAeCUgaM6eFfHY0XUQAZNswKPfXTTv4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 13 Aug 2019 19:06:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU] [PATCH v5 5/8] bootdevice: Gather LCHS from
 all relevant devices
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
Cc: liran.alon@oracle.com, karl.heubaum@oracle.com, arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eIeAeCUgaM6eFfHY0XUQAZNswKPfXTTv4
Content-Type: multipart/mixed; boundary="Xo9hQ7pS0ah2uMVaKc0VLHqlZiuE6Jmsx";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, seabios@seabios.org,
 kraxel@redhat.com, kevin@koconnor.net
Cc: karl.heubaum@oracle.com, liran.alon@oracle.com, arbel.moshe@oracle.com
Message-ID: <8e54c29d-119b-e02b-8966-56fa7ea91f9e@redhat.com>
Subject: Re: [QEMU] [PATCH v5 5/8] bootdevice: Gather LCHS from all relevant
 devices
References: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
 <20190626123948.10199-6-shmuel.eiderman@oracle.com>
In-Reply-To: <20190626123948.10199-6-shmuel.eiderman@oracle.com>

--Xo9hQ7pS0ah2uMVaKc0VLHqlZiuE6Jmsx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.06.19 14:39, Sam Eiderman wrote:
> Relevant devices are:
>     * ide-hd (and ide-cd, ide-drive)
>     * scsi-hd (and scsi-cd, scsi-disk, scsi-block)
>     * virtio-blk-pci
>=20
> We do not call del_boot_device_lchs() for ide-* since we don't need to =
-
> IDE block devices do not support unplugging.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  hw/block/virtio-blk.c |  6 ++++++
>  hw/ide/qdev.c         |  5 +++++
>  hw/scsi/scsi-disk.c   | 14 ++++++++++++++
>  3 files changed, 25 insertions(+)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 06e57a4d39..787bbd768a 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1182,6 +1182,11 @@ static void virtio_blk_device_realize(DeviceStat=
e *dev, Error **errp)
>      blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size);=

> =20
>      blk_iostatus_enable(s->blk);
> +
> +    add_boot_device_lchs(dev, "/disk@0,0",
> +                         (&conf->conf)->lcyls,
> +                         (&conf->conf)->lheads,
> +                         (&conf->conf)->lsecs);

=2E..why not simply =E2=80=9Cconf->conf.lcyls=E2=80=9D and so on?

[...]

> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 7b89ac798b..3451aefdea 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c

[...]

> @@ -2988,6 +2998,7 @@ static void scsi_hd_class_initfn(ObjectClass *kla=
ss, void *data)
>      SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(klass);
> =20
>      sc->realize      =3D scsi_hd_realize;
> +    sc->unrealize    =3D scsi_unrealize;
>      sc->alloc_req    =3D scsi_new_request;
>      sc->unit_attention_reported =3D scsi_disk_unit_attention_reported;=

>      dc->desc =3D "virtual SCSI disk";
> @@ -3019,6 +3030,7 @@ static void scsi_cd_class_initfn(ObjectClass *kla=
ss, void *data)
>      SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(klass);
> =20
>      sc->realize      =3D scsi_cd_realize;
> +    sc->unrealize    =3D scsi_unrealize;
>      sc->alloc_req    =3D scsi_new_request;
>      sc->unit_attention_reported =3D scsi_disk_unit_attention_reported;=

>      dc->desc =3D "virtual SCSI CD-ROM";
> @@ -3054,6 +3066,7 @@ static void scsi_block_class_initfn(ObjectClass *=
klass, void *data)
>      SCSIDiskClass *sdc =3D SCSI_DISK_BASE_CLASS(klass);
> =20
>      sc->realize      =3D scsi_block_realize;
> +    sc->unrealize    =3D scsi_unrealize;
>      sc->alloc_req    =3D scsi_block_new_request;
>      sc->parse_cdb    =3D scsi_block_parse_cdb;
>      sdc->dma_readv   =3D scsi_block_dma_readv;
> @@ -3095,6 +3108,7 @@ static void scsi_disk_class_initfn(ObjectClass *k=
lass, void *data)
>      SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(klass);
> =20
>      sc->realize      =3D scsi_disk_realize;
> +    sc->unrealize    =3D scsi_unrealize;
>      sc->alloc_req    =3D scsi_new_request;
>      sc->unit_attention_reported =3D scsi_disk_unit_attention_reported;=

>      dc->fw_name =3D "disk";

Only scsi-hd has the lchs properties, though, so what=E2=80=99s the purpo=
se of
defining the unrealize function for all other classes?

Max


--Xo9hQ7pS0ah2uMVaKc0VLHqlZiuE6Jmsx--

--eIeAeCUgaM6eFfHY0XUQAZNswKPfXTTv4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1TChIACgkQ9AfbAGHV
z0AYmggAhfJ8XYh7MBvUnWa+TVTyReLON77W6zTXUp3Wo0hxocP+nfSNdfu2Qt0I
Gp1uEWXATj7/7bLc9h1kIzEBd6RaTjP/jnW0Ck71Rkwr4xBmcKiWLoHYGxJ1sBNM
kukSQnOf3vpT5cWR+uNTTlo4S5wKm3xTINOCVwbgEYUxEfgj1cXnkG9MGBO7CcYU
Pn0jV8/BO8eiMaP/kHgjC/uwl/qDyOrhnZAqO7ov8obnzu0I6hecUs8N43rrD+7b
28YOxc2dLoiCrm/AFaPz8NuUHPWHF44g+B+dgdZ9wezbJLCtCYuAka5fg4Map8jW
pOKTMbUpcrY/zeB74MO729xAqPhi2A==
=3yty
-----END PGP SIGNATURE-----

--eIeAeCUgaM6eFfHY0XUQAZNswKPfXTTv4--

