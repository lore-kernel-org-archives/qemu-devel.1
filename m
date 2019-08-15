Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE8C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287A2206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVonPP2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287A2206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGRH-0006Ft-Bh
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1hyGPv-0004wO-4z
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hyGPs-0005qQ-Fj
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:07:50 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hyGPs-0005pe-6I
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:07:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so1358107wmj.5
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qTYr+CPp7+bY2GVHu46fm3QuQtJqQLMQiV0hhdpazAY=;
 b=PVonPP2uJhtRVPlyO5PB/v8C8ocfx2ZHCHg0q7j9UPI5NKQeJU+JugCkzTQJzf1Hdk
 9Gz/g4UP4EFL+onYB1Sj0yrmQ7c22sRRyR658yA7Hfvup6DN+/+WOF9gWzOsaqz+HRU2
 ol3Jx27b5/tley1wonZcSAGxnOgWaKAHHEJ1BC7x73Xxhz0eJWd7wedEjzXDQv4QaTZY
 XBpiuRXsIBlzAgR9YQsEnzbk2IB+OLK1MdWvaqWhpy+x+bgGKbEyP8GdxtrqRTtWzgRh
 aa9TCIY1ujBNig70BF/gK4fjKpvjhmMRFf6mn4X3Y63dtXqmx+C9P09VTuiJ3PqFkFkd
 wvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qTYr+CPp7+bY2GVHu46fm3QuQtJqQLMQiV0hhdpazAY=;
 b=eKocl2oWnpCjywFLAuiDgkcRiuiAps7iegGgL01akSCwSPMhBTge5tX+Szipe5LyAj
 oRJpY4KV3VM5wlrmBH5mqdK97SeCbkcVjOQZ/MW6BpJBPbx9Af0fQaB+NHu7vB+jvZh/
 wf1UsgI5qDfAEGdRcc5+1KR3vYKGlPyDq/KH74OrGW7J1adXHCoObQhSuLcRfGYFnT09
 4zAO2qPgUOyAou0MD6s7ogoq43Vx4vlCA3w14ftYjYSAsZYgTOzRnvEnNeAt37mtnc4N
 abVmsbmxRm7hOwwQKdfiZlv5ZyT4F/vOIaI3DV1XN14k5l0r6hFa2Og2XNdKN/twTIWg
 xMcQ==
X-Gm-Message-State: APjAAAXqltB3zbdIHYVXS6mRJcGEZ2jIPMItNsMM06T/H4/QABxG0p+u
 g0SpXATROL8uou8DWKnk5xg=
X-Google-Smtp-Source: APXvYqzptyaVYcH66XSi3vMPQYeWJZoVkQ3xUACEnufYXq4qkYibBaNNOJOk9mOQSeYxJFve6ePWpw==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr3070528wmj.13.1565878066784;
 Thu, 15 Aug 2019 07:07:46 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f134sm2077469wmg.20.2019.08.15.07.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 07:07:45 -0700 (PDT)
Date: Thu, 15 Aug 2019 15:07:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: William Tu <u9012063@gmail.com>
Message-ID: <20190815140744.GE10996@stefanha-x1.localdomain>
References: <CALDO+SbRvSSW3OQimwVe59HcHqv0PPLwoAW6yGg_UOnzounPtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline
In-Reply-To: <CALDO+SbRvSSW3OQimwVe59HcHqv0PPLwoAW6yGg_UOnzounPtQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] Question about libvhost-user and
 vhost-user-bridge.c
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2019 at 10:54:34AM -0700, William Tu wrote:
> Hi,
>=20
> I'm using libvhost-user.a to write a vhost backend, in order to receive a=
nd
> send packets from/to VMs from OVS. I started by reading the vhost-user-br=
idge.c.
> I can now pass the initialization stage, seeing .queue_set_started get in=
voked.
>=20
> However, I am stuck at receiving the packet from VM.
> So is it correct to do:
> 1) check vu_queue_empty, started, and aval_bytes, if OK, then

This step can be skipped because vu_queue_pop() returns NULL if there
are no virtqueue elements available.

> 2) elem =3D vu_queue_pop(&dev->vudev, vq, sizeof(VuVirtqElement));
> 3) the packet payload should be at elem->in_sg->iov_base + hdrlen? or
> at elem->out_sg?

The driver->device buffers are elem->out_sg and the device->driver
buffers are elem->in_sg.

Device implementations must not make assumptions about the layout of
out_sg and in_sg (e.g. you cannot assume that in_sg[0]->iov_len =3D=3D
sizeof(struct virtio_net_hdr) and you must handle the case where
in_sg[0]->iov_len =3D=3D 1).

> I tried to hex dump the iov_base, but the content doesn't look like
> having a ethernet header. I saw in vubr_backend_recv_cb at vhost-user-bri=
dge.c,
> we're creating another iovec and recvmsg(vubr->backend_udp_sock, &msg, 0);
> I don't think I have to create backend UDP sock, am I correct?

Please see the VIRTIO specification for details of the virtio-net rx/tx
virtqueue formats:
https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x=
1-2050006

I think you may need to handle the struct virtio_net_hdr that comes
before the Ethernet header.

Stefan

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1VZzAACgkQnKSrs4Gr
c8izSwf+LDxMPKUh+yBj0rExv3O1+ZYzd9GgcM2QoU55pJQUx+kd3vK0+wvXcZql
+gCZNUYFmf0rNoVHMnMuDqdBB7Nj53ZVyMceyEA+mEoBci6ldKTw4UfnSIZRgU1r
mtIP8ItRaTIaPLxajZ24dhTER1uljy/0r6FQFxTeXEsUqc267puqRx45Ee4ib4ZA
BqtS2iINn23shzSlwVfmqUsH45xa9Ocia3d+ifBuEpVvD2fVGiNJ0D8wuppgfn2g
c+5V3TVkWlTC+KlhPTZnyy2zZ1sN1KwzG9pQjESOqJ0FLvGcECag/1F6R7SeH31F
V317vR0QeHDH7oxkB4QjQzg7KSG+1g==
=NQpZ
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--

