Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C0FC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA972072C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aor9RHQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA972072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1uQ-00088X-9s
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1in1tD-0007Ci-5E
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1in1tC-0007Up-21
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:55:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1in1tB-0007UN-Og
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:55:54 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so39509540wru.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 06:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XI6H3qvhm97n3lMYni2zReM9gFfPnStxLgKU7vPNoSo=;
 b=Aor9RHQdbIn5czalFUzu6J4YIPFfOL5Y/Zr7ZBgHerAoG/1lQcJqUCDn17fC0kAls/
 OKXuCPh9K1sSFoDdFm8D0emCt9BTZbHV0qthNZASBC0rvxBwuruwhrtYPJUtRFuPnwjb
 3LgBG+/fN+wsSdupu6GKQi30YQmBNL5zZmWhI/+X+SlY0FnqGzLj8kvkRk98IokwyzQo
 fbL8b6XXJKljfc1pW49lhMqRSTYehqlV3ypOl2qZstGFH0vpR8AWfd6kJHYLU2Qn51w+
 g9Ge4AKnevGXC3REBvRowepGnFJRLsEs00f+AyrpR2vXd5KfacodXItgQ30EIIpQFJFQ
 SlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XI6H3qvhm97n3lMYni2zReM9gFfPnStxLgKU7vPNoSo=;
 b=dPTLR8cleHpmtux07X9fk9me+vm9Lkbne4adVBI5a5nQJrviLmN19zhY6kObpjh6gc
 VT305wGkbO1BkJ9NQEPqHuBRIF6qEn8iPsBw73mTwCj7unUnks8m1H5z46A5L5WXcYo1
 fMEyRQzh0W+caeTl2sDtEoPWLOSPXGf2Vi6+0R3yQqd658CpF0M74Yf9S40zv4ucU265
 5jY+soOhLX152dXGpV+X6WAWr8ILMsOnnTpSh9EbSM0orvrRfynzDPJLjghSH1WmO4vl
 OcYW4Dn8iX16aKQO2QI7zpJQXgYQgWN5WrDslK63py4emKQeLKNF8tVTNv+k63DsJWSu
 B0VA==
X-Gm-Message-State: APjAAAWim3SL/LvNYQ75NC9IIWIv8h9okHGqgiRQosq1nl5MKZRM4P1y
 qMSqfhqEaNq03S7VOG5lFo4=
X-Google-Smtp-Source: APXvYqzcdyTA8e3is+E7oB0VAhFr43hFGfcisEtomUM2EFykEhhoNtUwxocXA5kCBe1RmJvdD8Mtpg==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr82262910wrj.225.1577976952474; 
 Thu, 02 Jan 2020 06:55:52 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s8sm55377706wrt.57.2020.01.02.06.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 06:55:51 -0800 (PST)
Date: Thu, 2 Jan 2020 14:55:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1] virtio: stregthen virtqueue size invariants
Message-ID: <20200102145550.GM121208@stefanha-x1.localdomain>
References: <20191223131820.19300-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tDYGg60iReQ7u8wj"
Content-Disposition: inline
In-Reply-To: <20191223131820.19300-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tDYGg60iReQ7u8wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2019 at 04:18:20PM +0300, Denis Plotnikov wrote:
> 1. virtqueue_size is a power of 2
> 2. virtqueue_size > 2, since seg_max is virtqueue_size - 2
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/virtio/virtio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 04716b5f6c..e3ab69061e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2166,7 +2166,8 @@ void virtio_queue_set_num(VirtIODevice *vdev, int n=
, int num)
>       */
>      if (!!num !=3D !!vdev->vq[n].vring.num ||
>          num > VIRTQUEUE_MAX_SIZE ||
> -        num < 0) {
> +        num < 2 ||

This is generic VIRTIO code so it's not possible to make assumptions
about seg_max, which is a virtio-blk/scsi concept.  Other VIRTIO devices
may tolerate num < 2 just fine.  Please drop this.

> +        !is_power_of_2(num)) {

This constraint only applies to the Split Virtqueue layout.  Please see
VIRTIO 1.1 "2.7.10.1 Structure Size and Alignment" for the Packed
Virtqueue layout:

  The Queue Size value does not have to be a power of 2.

The condition should be:

  !(virtio_has_features(vdev, VIRTIO_F_RING_PACKED) || is_power_of_2(num))

--tDYGg60iReQ7u8wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4OBHYACgkQnKSrs4Gr
c8jopggAu/7zTZtrHpgkHEj2XZI8/51pB2C9Q+qgwMhl/RWpv+pdoXWCI6PCaAry
C9bwQae6pIyTRGT5LMBbVjbriEeQ160475hYzASDKlbmlOcLotj30fX4qu58KrYu
wp7DVGGSOM6JTpFQKSjPEMxwn0qa4aiCiRpRVDgMUrcYEUSeD4XnbVklLgHrtRZG
gLb31RPa12l5FzdUruVkq8czTzpQcpgjFQOUJdf6RJufruOex9bMO341Y7Boudtr
cpSlxdt6Ibr+rOxEv+fKtsxrNmgS9zkOCtH0mmCEN52wF4bYgdTn/H2bD4vHZnkE
WVcTHImVjkm6j7J1r3ERk4EZjgE4HA==
=vFt6
-----END PGP SIGNATURE-----

--tDYGg60iReQ7u8wj--

