Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB8CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFF02080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQIWcIxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFF02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5mB-0006VC-3S
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5j6-00035c-Vd; Sun, 06 Sep 2020 21:13:44 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5j1-0002uw-VD; Sun, 06 Sep 2020 21:13:44 -0400
Received: by mail-ot1-x343.google.com with SMTP id y5so11014580otg.5;
 Sun, 06 Sep 2020 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=81Ote+7MGDRERcHJKZIcBYa5ZvUXREcMw+tp+TEVRHE=;
 b=aQIWcIxYLnQDGIMVFdAHX3ppoCCSGjKJo0JR2CHS1LkI3KwD9+WbhBAl5Ju23/UPA+
 +CrOdtnYWdjbtJjtU31kxTKAgtnGmk/HZuZ3H2MzjopDCGTXGOaGujWhMrwF9h0oLeCy
 uD86ghpyCBPLDovjxJvI57+eBBftbSd1SjnZ+uuDFWvncxGPJPNKBIKnc3ZfGrACrq1Y
 YbX1+Y/pvaV1YRUzdt1Ed8SMe2atJ2o6cKFx4uH9xb1+I+paTBMoj03VTBduqW2fgHPS
 1qooDW4Fh5vYSYWXtOOEwQ84xHkMrzp+L69zMBQaGXKW+bFu87AkBkQx3hhOYgYebkmX
 51rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=81Ote+7MGDRERcHJKZIcBYa5ZvUXREcMw+tp+TEVRHE=;
 b=Le4mv+FUV/EApjG3j5xRwIBI71JOafygWasxrjePlamMrGFzETTK0KqPTnxQEjKDHJ
 YFcFVUDNuM6QWpzGGudaBTrTHIfDcR6uT6T5+V3gYuBR+5QCWwTvT4MvzHT2JrUUokDz
 z9YZ93E+zdeZJkDFRKmnZLOdbOYdmHL9fuZBRUsTtmy+4yT7ZSXHMMhuo76UHeimM2zZ
 ROQB6yGinCWoS3wgix90XG5MthDoq88oJykKzFwesKVNkuVQ62/w5Gra6M820QLJWHv2
 s71+41WNUHWNf05EdrW3vJkBj99IL1G8/VAZAveYZtFPAn2XnKVSBBg0gNkcnLU7f7Bq
 I4lQ==
X-Gm-Message-State: AOAM531YAMUD4Ez04z6DnfsxBTXt6sY1MJluEy7mV/lTy4bdz/9WbHOO
 lnt4+bkprBpEO2Q82X3UJ4ZjET+UOnN+I5ajrXc=
X-Google-Smtp-Source: ABdhPJwyA0xS4lPlwwSNww/4mZylODT5SukWxlR8hI+79ieIY9AQIyV0xbReKWkeZZuDamK0d653+dbmvMVwHBo4IqM=
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr12172590oti.353.1599441217493; 
 Sun, 06 Sep 2020 18:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-10-philmd@redhat.com>
In-Reply-To: <20200904154439.643272-10-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:13:01 +0800
Message-ID: <CAKXe6SLTnSKjR4RUpiqXjm==a=BTwRrnBnQn=sPRSiLqxr-rUg@mail.gmail.com>
Subject: Re: [PATCH 09/13] dma: Let dma_memory_set() take MemTxAttrs argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Qemu Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:49=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Let devices specify transaction attributes when calling
> dma_memory_set().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/hw/ppc/spapr_vio.h | 3 ++-
>  include/sysemu/dma.h       | 3 ++-
>  dma-helpers.c              | 5 ++---
>  hw/nvram/fw_cfg.c          | 3 ++-
>  4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index f134f6cf574..6e5c0840248 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -116,7 +116,8 @@ static inline int spapr_vio_dma_write(SpaprVioDevice =
*dev, uint64_t taddr,
>  static inline int spapr_vio_dma_set(SpaprVioDevice *dev, uint64_t taddr,
>                                      uint8_t c, uint32_t size)
>  {
> -    return (dma_memory_set(&dev->as, taddr, c, size) !=3D 0) ?
> +    return (dma_memory_set(&dev->as, taddr,
> +                           c, size, MEMTXATTRS_UNSPECIFIED) !=3D 0) ?
>          H_DEST_PARM : H_SUCCESS;
>  }
>
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index b322aa5947b..d0381f9ae9b 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -175,9 +175,10 @@ static inline MemTxResult dma_memory_write(AddressSp=
ace *as, dma_addr_t addr,
>   * @addr: address within that address space
>   * @c: constant byte to fill the memory
>   * @len: the number of bytes to fill with the constant byte
> + * @attrs: memory transaction attributes
>   */
>  MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
> -                           uint8_t c, dma_addr_t len);
> +                           uint8_t c, dma_addr_t len, MemTxAttrs attrs);
>
>  /**
>   * address_space_map: Map a physical memory region into a DMA controller
> diff --git a/dma-helpers.c b/dma-helpers.c
> index 4a9e37d6d06..6a9735386dc 100644
> --- a/dma-helpers.c
> +++ b/dma-helpers.c
> @@ -19,7 +19,7 @@
>  /* #define DEBUG_IOMMU */
>
>  MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
> -                           uint8_t c, dma_addr_t len)
> +                           uint8_t c, dma_addr_t len, MemTxAttrs attrs)
>  {
>      dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
>
> @@ -31,8 +31,7 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t=
 addr,
>      memset(fillbuf, c, FILLBUF_SIZE);
>      while (len > 0) {
>          l =3D len < FILLBUF_SIZE ? len : FILLBUF_SIZE;
> -        error |=3D address_space_write(as, addr, MEMTXATTRS_UNSPECIFIED,
> -                                     fillbuf, l);
> +        error |=3D address_space_write(as, addr, attrs, fillbuf, l);
>          len -=3D l;
>          addr +=3D l;
>      }
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index f3a4728288e..a15de06a10c 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -397,7 +397,8 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
>               * tested before.
>               */
>              if (read) {
> -                if (dma_memory_set(s->dma_as, dma.address, 0, len)) {
> +                if (dma_memory_set(s->dma_as, dma.address, 0, len,
> +                                   MEMTXATTRS_UNSPECIFIED)) {
>                      dma.control |=3D FW_CFG_DMA_CTL_ERROR;
>                  }
>              }
> --
> 2.26.2
>
>

