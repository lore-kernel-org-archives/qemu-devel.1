Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA72C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530302080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSZI9Q5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530302080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5ne-0000pN-Dv
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5m3-0006ij-KW; Sun, 06 Sep 2020 21:16:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5m0-0003K1-M3; Sun, 06 Sep 2020 21:16:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id a2so10984013otr.11;
 Sun, 06 Sep 2020 18:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DwQq+SQ9APaseDdyF5QolhXuOi5ygDwwGZx18kWUF5Y=;
 b=pSZI9Q5ukGLFLP+1JS/d6jIZRybhBMFoXTXnwufiqioUgmjG0Bp8bSyaawAhRM4Djz
 s6s2bsLu5jOk408dPmQ/BiMaSkJ7PQxN6w7PdOLojaLqsx6jFUZqmZw5yeWA11phgI8Z
 yPFbzuWmhT1V5/yGr+XdWHek/oDaLz3nC1YS6nwIv3+wwoFRBKvpSUgYCitO+J+r0sTI
 634FMHCyn/YwJhN0wm0BtLeMg/WhF55hl1Xxe8Og6xbaUj0pM+bFG6W/qKArXpDDPItG
 QvcxlpW+XYyFYpH4wG6M4EMpyRhriedh5+5Nxbnu4JWyTsUmQXB585wfWcBf3Oz3KNvU
 qCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DwQq+SQ9APaseDdyF5QolhXuOi5ygDwwGZx18kWUF5Y=;
 b=c7ApdBosAaQVCmaeJ/4mQmwZy3rQeZ3mwcGYjtoek6fAtDkophJWlCF4cctgalnoxa
 +6wybfPv0MuIWDjye2+lHobuRimNGnwJK4+wYBKwcZWdiCEco7XAQTmMPXHGrPFLmm54
 +0B/Xu3qLoa08EOn9r4lJaL1Jvla8zFY3BeBeETZ9eMIgxLTVNuM8/aRKxsPR4KwRZ3m
 wUU/qvyxK8NclsQn+eNOWombe6MRZddWyvq4xWC0XiY4l1TUCmCcLv77E8n/KuZ3XaOs
 jzRPyD/W6SuUhyzIvhW1QxhDgaK9yNRcnM9XvzsykKivdngMZIKHBABXaahFJ8eY2c/N
 4O/g==
X-Gm-Message-State: AOAM530mQhGXAP2Vl9n5XWvSKASdFOZoNQ4jcB+ufNoYrfWyPgJuCqPX
 U8bx9HJufyYiXwzLUf+lUTlqk/HefQ+oL/2s5AE=
X-Google-Smtp-Source: ABdhPJydT+eeb1ABib4Vh6kA8ZEWd5wRwbe30LtEL6kxF1SWAd3uvLCFNXvfaJUUTnsrIcpyOZfvK9gHcc4pirqG5aA=
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr12178824oti.353.1599441402238; 
 Sun, 06 Sep 2020 18:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-12-philmd@redhat.com>
In-Reply-To: <20200904154439.643272-12-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:16:05 +0800
Message-ID: <CAKXe6SL2aa=ewKQbKjfKLfUOQstGV+Xn5t00NvbxVYDiB0oE3Q@mail.gmail.com>
Subject: Re: [PATCH 11/13] dma: Let dma_memory_rw() take MemTxAttrs argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:53=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Let devices specify transaction attributes when calling
> dma_memory_rw().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/hw/pci/pci.h |  3 ++-
>  include/sysemu/dma.h | 11 ++++++-----
>  dma-helpers.c        |  3 ++-
>  hw/intc/spapr_xive.c |  3 ++-
>  hw/usb/hcd-ohci.c    | 10 ++++++----
>  5 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 896cef9ad47..0c3217e019c 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -788,7 +788,8 @@ static inline AddressSpace *pci_get_address_space(PCI=
Device *dev)
>  static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
>                               void *buf, dma_addr_t len, DMADirection dir=
)
>  {
> -    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir=
);
> +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,
> +                         dir, MEMTXATTRS_UNSPECIFIED);
>  }
>
>  static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index 59331ec0bd3..0695d430119 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -121,15 +121,15 @@ static inline MemTxResult dma_memory_write_relaxed(=
AddressSpace *as,
>   * @buf: buffer with the data transferred
>   * @len: the number of bytes to read or write
>   * @dir: indicates the transfer direction
> + * @attrs: memory transaction attributes
>   */
>  static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t add=
r,
>                                          void *buf, dma_addr_t len,
> -                                        DMADirection dir)
> +                                        DMADirection dir, MemTxAttrs att=
rs)
>  {
>      dma_barrier(as, dir);
>
> -    return dma_memory_rw_relaxed(as, addr, buf, len, dir,
> -                                 MEMTXATTRS_UNSPECIFIED);
> +    return dma_memory_rw_relaxed(as, addr, buf, len, dir, attrs);
>  }
>
>  /**
> @@ -147,7 +147,8 @@ static inline MemTxResult dma_memory_rw(AddressSpace =
*as, dma_addr_t addr,
>  static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t a=
ddr,
>                                            void *buf, dma_addr_t len)
>  {
> -    return dma_memory_rw(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
> +    return dma_memory_rw(as, addr, buf, len,
> +                         DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED=
);
>  }
>
>  /**
> @@ -166,7 +167,7 @@ static inline MemTxResult dma_memory_write(AddressSpa=
ce *as, dma_addr_t addr,
>                                             const void *buf, dma_addr_t l=
en)
>  {
>      return dma_memory_rw(as, addr, (void *)buf, len,
> -                         DMA_DIRECTION_FROM_DEVICE);
> +                         DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFI=
ED);
>  }
>
>  /**
> diff --git a/dma-helpers.c b/dma-helpers.c
> index 6a9735386dc..6c3b2200f16 100644
> --- a/dma-helpers.c
> +++ b/dma-helpers.c
> @@ -305,7 +305,8 @@ static uint64_t dma_buf_rw(uint8_t *ptr, int32_t len,=
 QEMUSGList *sg,
>      while (len > 0) {
>          ScatterGatherEntry entry =3D sg->sg[sg_cur_index++];
>          int32_t xfer =3D MIN(len, entry.len);
> -        dma_memory_rw(sg->as, entry.base, ptr, xfer, dir);
> +        dma_memory_rw(sg->as, entry.base, ptr, xfer, dir,
> +                      MEMTXATTRS_UNSPECIFIED);
>          ptr +=3D xfer;
>          len -=3D xfer;
>          resid -=3D xfer;
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 4bd0d606ba1..dbf73a8bf47 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -1666,7 +1666,8 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
>          mmio_addr =3D xive->vc_base + xive_source_esb_mgmt(xsrc, lisn) +=
 offset;
>
>          if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
> -                          (flags & SPAPR_XIVE_ESB_STORE))) {
> +                          (flags & SPAPR_XIVE_ESB_STORE),
> +                          MEMTXATTRS_UNSPECIFIED)) {
>              qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ESB @=
0x%"
>                            HWADDR_PRIx "\n", mmio_addr);
>              return H_HARDWARE;
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 1e6e85e86a8..bac1adf439c 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -586,7 +586,8 @@ static int ohci_copy_td(OHCIState *ohci, struct ohci_=
td *td,
>      if (n > len)
>          n =3D len;
>
> -    if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf, n, dir))=
 {
> +    if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf,
> +                      n, dir, MEMTXATTRS_UNSPECIFIED)) {
>          return -1;
>      }
>      if (n =3D=3D len) {
> @@ -595,7 +596,7 @@ static int ohci_copy_td(OHCIState *ohci, struct ohci_=
td *td,
>      ptr =3D td->be & ~0xfffu;
>      buf +=3D n;
>      if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf,
> -                      len - n, dir)) {
> +                      len - n, dir, MEMTXATTRS_UNSPECIFIED)) {
>          return -1;
>      }
>      return 0;
> @@ -613,7 +614,8 @@ static int ohci_copy_iso_td(OHCIState *ohci,
>      if (n > len)
>          n =3D len;
>
> -    if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf, n, dir))=
 {
> +    if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf,
> +                      n, dir, MEMTXATTRS_UNSPECIFIED)) {
>          return -1;
>      }
>      if (n =3D=3D len) {
> @@ -622,7 +624,7 @@ static int ohci_copy_iso_td(OHCIState *ohci,
>      ptr =3D end_addr & ~0xfffu;
>      buf +=3D n;
>      if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf,
> -                      len - n, dir)) {
> +                      len - n, dir, MEMTXATTRS_UNSPECIFIED)) {
>          return -1;
>      }
>      return 0;
> --
> 2.26.2
>
>

