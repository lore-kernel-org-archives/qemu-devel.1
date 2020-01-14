Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34A8C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2356C2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYtGlfMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2356C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irPJp-0004mI-1Q
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 11:45:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irPJ8-0004EJ-3W
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irPJ6-0008Ea-SS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:44:45 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1irPJ6-0008D8-LR
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:44:44 -0500
Received: by mail-wm1-x344.google.com with SMTP id t14so14523868wmi.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 08:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gHyLbuSDCVZIBmTc/h8VbWLhXLgvgw8UsErROSviADY=;
 b=GYtGlfMFjcfXDFBaLIS1mdBlxOoMVBW22YIYwEPa27VQEFh2wSZXEBymRIJCGJrvT9
 ZcnW1wGAFMThmUrnOT+6qh/TuvnJrIaKh6mVxS9OqjyatGygjhwTzmlwAYCjQr+8MgM+
 UwjodRbGaMuC0Ir9KRriADRax84U5jyLZ+PEEi1pUhoMtzJfwAIL055n95k02WSRxDji
 cSzo1IPlG4m1fJLJ+6d21JKfVwYUREkxLRAoGmbI11xFEnYLmos6dJkbx+ylMRUQvOmn
 DfEpAErZFmB/coRis0YdPNXwHDGsfQqlaDv79I+kaflPz39RiYijbd73kIbWTwc5+D/B
 YaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gHyLbuSDCVZIBmTc/h8VbWLhXLgvgw8UsErROSviADY=;
 b=JMrhaIcJ+pfyvcMlfCa8CHoAJNiPr6mIMC1N2ZQmyOV6QP37gQxZNQ9bIwYlSJ2V+p
 zRqDQoamYBgqqJoTJR8ytDtkaxtkekNNFoYbcQCv2VZf7N1jEZ9Vcdueq1iivhXufdWH
 NlnVhlpTT81re+xoj6OINlAOxcBVDR5aMmhforVzxD1Zte8pD1c9dQZuHUvJmCK96nyC
 s/Rr72al9rxZN9tyNrq+s7+ErikffweZoDUsTHIXxPqOu5bENbZCXBb9/Cawms8NIVw9
 TzmfykuikU7hw5jjx3yHvqfsQ1g5SM6o3Qg9H9FpB9Pd5fqU4+3rS9VtokUzNs8xw9t4
 MZTQ==
X-Gm-Message-State: APjAAAW7PV5bLcC48WiijFzoalO7SBEoWer9EFnIaI3wONwwQri3HBN2
 P2TB1J+7M8Ku3x5tF/wQyqE=
X-Google-Smtp-Source: APXvYqw2hHX+F6bMpHwAjPFCaA6V1veUCxNSABiCxW7va73fGeCozkQ66vQuImBH9d8J/WoFiX2Cwg==
X-Received: by 2002:a1c:7dc4:: with SMTP id
 y187mr27523462wmc.161.1579020283274; 
 Tue, 14 Jan 2020 08:44:43 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b10sm20925549wrt.90.2020.01.14.08.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 08:44:42 -0800 (PST)
Date: Tue, 14 Jan 2020 16:44:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH] vhost-vsock: delete vqs in vhost_vsock_unrealize to
 avoid memleaks
Message-ID: <20200114164441.GG132666@stefanha-x1.localdomain>
References: <20200114075229.40520-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline
In-Reply-To: <20200114075229.40520-1-pannengyuan@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 03:52:29PM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> Receive/transmit/event vqs forgot to cleanup in vhost_vsock_unrealize. Th=
is
> patch save receive/transmit vq pointer in realize() and cleanup vqs
> through those vq pointers in unrealize(). The leak stack is as follow:
>=20
> Direct leak of 21504 byte(s) in 3 object(s) allocated from:
>   #0 0x7f86a1356970 (/lib64/libasan.so.5+0xef970)  ??:?
>   #1 0x7f86a09aa49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
>   #2 0x5604852f85ca (./x86_64-softmmu/qemu-system-x86_64+0x2c3e5ca)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:2333
>   #3 0x560485356208 (./x86_64-softmmu/qemu-system-x86_64+0x2c9c208)  /mnt=
/sdb/qemu/hw/virtio/vhost-vsock.c:339
>   #4 0x560485305a17 (./x86_64-softmmu/qemu-system-x86_64+0x2c4ba17)  /mnt=
/sdb/qemu/hw/virtio/virtio.c:3531
>   #5 0x5604858e6b65 (./x86_64-softmmu/qemu-system-x86_64+0x322cb65)  /mnt=
/sdb/qemu/hw/core/qdev.c:865
>   #6 0x5604861e6c41 (./x86_64-softmmu/qemu-system-x86_64+0x3b2cc41)  /mnt=
/sdb/qemu/qom/object.c:2102
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  hw/virtio/vhost-vsock.c         | 9 +++++++--
>  include/hw/virtio/vhost-vsock.h | 2 ++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index f5744363a8..896c0174c1 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -335,8 +335,10 @@ static void vhost_vsock_device_realize(DeviceState *=
dev, Error **errp)
>                  sizeof(struct virtio_vsock_config));
> =20
>      /* Receive and transmit queues belong to vhost */
> -    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_ou=
tput);
> -    virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE, vhost_vsock_handle_ou=
tput);
> +    vsock->recv_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
> +                                      vhost_vsock_handle_output);
> +    vsock->trans_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
> +                                       vhost_vsock_handle_output);
> =20
>      /* The event queue belongs to QEMU */
>      vsock->event_vq =3D virtio_add_queue(vdev, VHOST_VSOCK_QUEUE_SIZE,
> @@ -378,6 +380,9 @@ static void vhost_vsock_device_unrealize(DeviceState =
*dev, Error **errp)
>      /* This will stop vhost backend if appropriate. */
>      vhost_vsock_set_status(vdev, 0);
> =20
> +    virtio_delete_queue(vsock->recv_vq);
> +    virtio_delete_queue(vsock->trans_vq);
> +    virtio_delete_queue(vsock->event_vq);
>      vhost_dev_cleanup(&vsock->vhost_dev);
>      virtio_cleanup(vdev);
>  }

Please delete the virtqueues after vhost cleanup (the reverse
initialization order).  There is currently no reason why it has to be
done in reverse initialization order, your patch should work too, but
it's a good default for avoiding user-after-free bugs.

Stefan

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4d7/kACgkQnKSrs4Gr
c8gNGAf/UShWOJToCKCZXB9NjELJ+rLGJTEKqnV+07fZ9WyLiEJDoxEAj+plVY/Z
KLPzTHFv5KpoNRcVKVCym/4jMXDaJO7fyyzfnESBHoV6blB83tFDFMewpAoPE0i4
n3BU4wSbhdUnWtQO+XeqJLQgU7NDKhcboY0hruFbBXPbiZodMSx8xikGVZO2iqQP
mtPHYuItwTKUrC73Yt0iIlhcFZZnqzVy7vgeVhjSFLHOHfDXQ2sFWCbLswEIfueY
Ob5yrsipQ4E3cVccPkz9HxOwA7udVwGplomX7/GvXTLxjpBJL/3e+QZBsm/1GMdr
XOF88fA6P16O8tpfY+B33gOY8dB1pQ==
=zrh/
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--

