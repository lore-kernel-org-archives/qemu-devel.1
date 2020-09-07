Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FEAC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4923B2080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqObNhWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4923B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5cS-00054b-Cb
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5be-0004Nk-Vu; Sun, 06 Sep 2020 21:06:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5bd-00026K-AC; Sun, 06 Sep 2020 21:06:02 -0400
Received: by mail-oi1-x241.google.com with SMTP id n2so875497oij.1;
 Sun, 06 Sep 2020 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fzdN9DWuqP7ekXV9NuzssYinoOJxcFqBEqc2i8WsHog=;
 b=tqObNhWMfp6AY27NZVatjocQLrulQE2EXnMe/N+ZN+lSoiBt9gMPhhmRnluleG55AN
 tblyIgJfm17asV9RWDaiphD4vCa52C1TxPxoiQ/5lGBlTLPsLitCdnP4eISIUpmUwW9A
 LQ6JwHaVTjnzLZQ0k+kNiR0Myoi7xoAYcLynVkXQ0ldLXueLumThpIPM2JUKOCpnSXMS
 0hUnEc907mJ5hSUK1LauqbgWLoANDldDZ6re5hJXAHndPX5jy8pVBWT0TgR9pL8DyNWX
 B/ubq8ysWP088Zt8uqUaZVdmPcZYy9LnyFN2iHKrqOnSoiaJlz1xEUO4N3VlaCgsQP36
 tLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fzdN9DWuqP7ekXV9NuzssYinoOJxcFqBEqc2i8WsHog=;
 b=Ow/AxeCZ9qvmme6oYskyMRMm3d/u3/PwS1xz+tkcF5AMPOlDaXy1YU43FDRGfkw6s/
 Am+kAHFsypWuvp2ZeuKjSBA/QCJVyjOvsbDMAADabC+EkuGpm8RUjDBjbQ/9WYc3Iomt
 T0tSn0d3G/wp5Rm3ySjUlI4yWM4wXgvmxiUUKagYd1FOrdlkdKmxCem+sQt/XaorVT+I
 kZLZukEQusOieDBG2/Rxq0tISaK1yMtn2shCzSDSg4KyEkrqefjXON7Ezn/mztpLlcak
 1midWxJu+Fn66A+x8vhdjy9jpnEViTS9Y11J9ICh0O+qh7bdj+nB51f2i5xOGec0WByB
 BTwQ==
X-Gm-Message-State: AOAM533K3lkETOu2lA3FE4eloz3axEuLZae+2eTqSMCBDYJmvXfq7EPS
 IsU4xsJ1NZpkemJ0Dh3KvP7pJ6uIEVrziXefV2w=
X-Google-Smtp-Source: ABdhPJwKZG3S4W6rG0Rttq6vd04epYbTg9NeshQ9mLYL+y7TFU2doy2l8ZdqL9L1QfgxjYrRM/7S/7JPP+/VeyA2gKQ=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr11713708oif.56.1599440758784; 
 Sun, 06 Sep 2020 18:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-5-philmd@redhat.com>
In-Reply-To: <20200904154439.643272-5-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:05:22 +0800
Message-ID: <CAKXe6SJ01BjWoOyph5ZHn2=zV7_9WP3L3ObOvv5TzpL_v1sSmw@mail.gmail.com>
Subject: Re: [PATCH 04/13] dma: Let dma_memory_set() propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:47=E5=86=99=E9=81=
=93=EF=BC=9A
>
> address_space_write() returns a MemTxResult type.
> Do not discard it, return it to the caller.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/sysemu/dma.h | 15 ++++++++++++++-
>  dma-helpers.c        |  7 ++++---
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index 19bc9ad1b69..ad8a3f82f47 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -123,7 +123,20 @@ static inline int dma_memory_write(AddressSpace *as,=
 dma_addr_t addr,
>                           DMA_DIRECTION_FROM_DEVICE);
>  }
>
> -int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_add=
r_t len);
> +/**
> + * dma_memory_set: Fill memory with a constant byte from DMA controller.
> + *
> + * Return a MemTxResult indicating whether the operation succeeded
> + * or failed (eg unassigned memory, device rejected the transaction,
> + * IOMMU fault).
> + *
> + * @as: #AddressSpace to be accessed
> + * @addr: address within that address space
> + * @c: constant byte to fill the memory
> + * @len: the number of bytes to fill with the constant byte
> + */
> +MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
> +                           uint8_t c, dma_addr_t len);
>
>  /**
>   * address_space_map: Map a physical memory region into a DMA controller
> diff --git a/dma-helpers.c b/dma-helpers.c
> index 41ef24a63b6..4a9e37d6d06 100644
> --- a/dma-helpers.c
> +++ b/dma-helpers.c
> @@ -1,7 +1,7 @@
>  /*
>   * DMA helper functions
>   *
> - * Copyright (c) 2009 Red Hat
> + * Copyright (c) 2009,2020 Red Hat
>   *
>   * This work is licensed under the terms of the GNU General Public Licen=
se
>   * (GNU GPL), version 2 or later.
> @@ -18,14 +18,15 @@
>
>  /* #define DEBUG_IOMMU */
>
> -int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_add=
r_t len)
> +MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
> +                           uint8_t c, dma_addr_t len)
>  {
>      dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
>
>  #define FILLBUF_SIZE 512
>      uint8_t fillbuf[FILLBUF_SIZE];
>      int l;
> -    bool error =3D false;
> +    MemTxResult error =3D MEMTX_OK;
>
>      memset(fillbuf, c, FILLBUF_SIZE);
>      while (len > 0) {
> --
> 2.26.2
>
>

