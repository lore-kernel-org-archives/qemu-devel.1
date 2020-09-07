Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2312DC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589272080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo6ktWwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589272080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5iu-0002gs-BZ
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5hj-0001dG-EP; Sun, 06 Sep 2020 21:12:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5hh-0002k4-Ll; Sun, 06 Sep 2020 21:12:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id m12so8045195otr.0;
 Sun, 06 Sep 2020 18:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=U1xrxZw6wNGe1qsNnvO0rraAAbdhelBwJsQdL/3pJWQ=;
 b=Uo6ktWwNqk2KdWSfPEHgjXtOmpkDJOu+BXbMxymwGNXGoPD6lftNR85tcZxhnKreQ+
 UhbAtH2Zm9VETZtJxi0+JI6g6Ymjp1gXUv+ULdfoJiuSEbxAwRB5o11vL1j59HdboQ2z
 Dea0fEu/J3LAEjuh721Z3GmDdQDxChVgiCwy55IZIj07wBW4Pp5VXNk71LVi/JU2bSv3
 l0f4RT+LI4z0lXTg77GY/AF5fGQRz1SflMmZhi+fNyWJEoA0DjYztAlC0jTgieQm9U52
 DeJqAmJLfJXSBgxjf8NPWpIS3KQtTfEOHKW/vV0/QaVIf5aETb1uEYyIcXNPXEMjbmOM
 Nu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=U1xrxZw6wNGe1qsNnvO0rraAAbdhelBwJsQdL/3pJWQ=;
 b=VKI2vUjVmg42xbd9fylIr5aHbFjtcbv1fRvn96RLZ7lliKwe0VZOL9G8kYBMiI+wGi
 R8FmLrfqM1ZflhHP6HB4MSU153gMaQ1XONkdqt6AaKhevwxFabSpqE5qjHa5RTAd2ozS
 sLPkUeTkwEway/y+/Y+bDDi/N8R9+ymVd1w1oyLCkBMg/5AEaUytX+sIh+eQ1vqeypj9
 wIiHHNLHF2AShTe9M90FDPx6C4439tZ5yYTs7t00VDU0tSGK+P6QIE2fNO8Yl7/6CcI8
 PH4XGMqQIsjHktqx22f6yK5DEdnndTjoxGF3e0T3bHXLuNaqtRnQEYLFqkDWVVnwBBO7
 SH9g==
X-Gm-Message-State: AOAM531rB44Cw2mO6k3s8ba7L3Kh7MRiJgV5DUn9pdBbvONizXvdI96M
 mOhWAw94llz3kAPD5KkF4s5BJKRbAEj4V5D0pVY=
X-Google-Smtp-Source: ABdhPJy0/A/+1MTwLtB7F8FfSeCbxgJdRa10tCUQw98dd8cUNeSpBCNn9u3S6RHXZmS40B+0T3myrkfzyeRITXqPgtY=
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr12169963oti.353.1599441135520; 
 Sun, 06 Sep 2020 18:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-9-philmd@redhat.com>
In-Reply-To: <20200904154439.643272-9-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:11:39 +0800
Message-ID: <CAKXe6SJ76vvU-Dom1twGhKi2UmARN1UcV3k59D1xqG2ybUTo7A@mail.gmail.com>
Subject: Re: [PATCH 08/13] dma: Let dma_memory_valid() take MemTxAttrs argument
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
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:48=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Let devices specify transaction attributes when calling
> dma_memory_valid().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/hw/ppc/spapr_vio.h | 2 +-
>  include/sysemu/dma.h       | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
> index bed7df60e35..f134f6cf574 100644
> --- a/include/hw/ppc/spapr_vio.h
> +++ b/include/hw/ppc/spapr_vio.h
> @@ -96,7 +96,7 @@ static inline void spapr_vio_irq_pulse(SpaprVioDevice *=
dev)
>  static inline bool spapr_vio_dma_valid(SpaprVioDevice *dev, uint64_t tad=
dr,
>                                         uint32_t size, DMADirection dir)
>  {
> -    return dma_memory_valid(&dev->as, taddr, size, dir);
> +    return dma_memory_valid(&dev->as, taddr, size, dir, MEMTXATTRS_UNSPE=
CIFIED);
>  }
>
>  static inline int spapr_vio_dma_read(SpaprVioDevice *dev, uint64_t taddr=
,
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index f4ade067a46..b322aa5947b 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -73,11 +73,11 @@ static inline void dma_barrier(AddressSpace *as, DMAD=
irection dir)
>   * dma_memory_{read,write}() and check for errors */
>  static inline bool dma_memory_valid(AddressSpace *as,
>                                      dma_addr_t addr, dma_addr_t len,
> -                                    DMADirection dir)
> +                                    DMADirection dir, MemTxAttrs attrs)
>  {
>      return address_space_access_valid(as, addr, len,
>                                        dir =3D=3D DMA_DIRECTION_FROM_DEVI=
CE,
> -                                      MEMTXATTRS_UNSPECIFIED);
> +                                      attrs);
>  }
>
>  static inline MemTxResult dma_memory_rw_relaxed(AddressSpace *as,
> --
> 2.26.2
>
>

