Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDCAC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA3D205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJnSiKdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA3D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgt1Y-0004qE-NG
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56218)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hgsrA-0007ro-ES
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hgsr9-0007oN-4f
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:32:08 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hgsr8-0007iG-RC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:32:07 -0400
Received: by mail-oi1-x241.google.com with SMTP id 65so4531427oid.13
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jWYGqSWT6KDyvd2qN921iKPeaXkxTy4Q2/TxzHJb/DA=;
 b=PJnSiKdOwCqRbrALnVh1tsy/yqitQGUh5yzE7Q4X8Vq8WExDbGd3TR2+u6X6sA/6gV
 nk/Y3Jx/9sVIC6yaJEI71virCbXyF1mgA/netqyT5Wppja1XF2AvrTpJ3niDYlAc8rOb
 c2g4gOEjmPS++LcyF+l1zvsmd+ew5185g0RvPkISBkMpL4tyRsIfnHyrOMs54zp6gezy
 IBSjeoKmqYNHYUfWqUIb8nB7rXGsU1ZocR1ljK1T9q7aI5cvuhC/4IoSGx0eBAgEvFXP
 wbJUVv6XSfs/G8fGvvad2XJ7qdyYptqloKCdKZU/KGimGw6Qh/l03EDfX+vWCP1KCviR
 p+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jWYGqSWT6KDyvd2qN921iKPeaXkxTy4Q2/TxzHJb/DA=;
 b=VvdRiVePqb0VVc7c6uKCOmtSATut/zuUYfK9XY07aGjVPXneadbsAsSk06S51Vy9Wt
 puv2Mu5oKf+NE3tnWFWHNuZOeKHzv1qXFnM6btw0r9PhUB2EJKdL5AV8k9i+K3J7zvOd
 CwaKZWg87a7dmrurOdh0w7fbMF8juCgcFqtJ27EqI9zvp0iqM/ex4ZJQxazibvbtElF/
 IurUHRciVRk4VCazG8uj12bCA7xmUgtPbrwW9ycGA67xsEaeHCBkwyRK0Bx94e/Xm+LL
 GK+L3RcPcepsB2azTiQRun/2sFSY8Wn37Qm6ewsvXKysWGz6DQeUqOrnypZauqlUZ9kz
 2ejQ==
X-Gm-Message-State: APjAAAVdw3vrJQpXFWm3vqikKWRASeQ2xl6D5lgzoeqvxeYfWjx7hO7R
 UqPz711Mf+SzVnIFxV3vUUHZdBc+2Ll/CoOn6vU=
X-Google-Smtp-Source: APXvYqxzVN94yjObbbFvp8KYx8jG4wOrP98uw0sB+9tUN4pL6arEzMUx4FVOAF970m/z+cby7fUQFgwuBnTBMiUzKZA=
X-Received: by 2002:aca:3602:: with SMTP id d2mr1947881oia.150.1561735920601; 
 Fri, 28 Jun 2019 08:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190628072357.31782-1-kraxel@redhat.com>
In-Reply-To: <20190628072357.31782-1-kraxel@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 28 Jun 2019 23:31:24 +0800
Message-ID: <CAKXe6S+6PsbK=enz0XALCmg=ERBNgvig85h-d=iy2qK+1sWYfA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix unmap in error path
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
Cc: Qemu Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=883:24=E5=86=99=E9=81=93=EF=BC=9A

> We land here in case not everything we've asked for could be mapped.
> So unmap only the bytes which have actually been mapped.
>
> Also we didn't access anything, so acces_len can be 0.
>
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

It is reasonable, so

Reviewed-by: Li Qiang <liq3ea@gmail.com>

btw: Does it break something before this patch?
AFAICS, the 'len' is not used for the unmap, only the 'access_len' is used.

Thanks,
Li Qiang



> ---
>  hw/display/virtio-gpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 2b0f66b1d68d..475a018c027c 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1048,9 +1048,9 @@ static int virtio_gpu_load(QEMUFile *f, void
> *opaque, size_t size,
>                  if (res->iov[i].iov_base) {
>                      dma_memory_unmap(VIRTIO_DEVICE(g)->dma_as,
>                                       res->iov[i].iov_base,
> -                                     res->iov[i].iov_len,
> +                                     len,
>                                       DMA_DIRECTION_TO_DEVICE,
> -                                     res->iov[i].iov_len);
> +                                     0);
>                  }
>                  /* ...and the mappings for previous loop iterations */
>                  res->iov_cnt =3D i;
> --
> 2.18.1
>
>
>
