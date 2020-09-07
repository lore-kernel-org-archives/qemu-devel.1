Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DCFC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A382080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0VIfIY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A382080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5ee-0008IP-Jg
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5db-0006qo-RS; Sun, 06 Sep 2020 21:08:03 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5dZ-0002Cm-Gq; Sun, 06 Sep 2020 21:08:03 -0400
Received: by mail-oi1-x243.google.com with SMTP id w16so12233467oia.2;
 Sun, 06 Sep 2020 18:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s6lBFBc4HaiFISgjHlK8hHEp4NKwroeyNp8C/sSoYAE=;
 b=b0VIfIY/U2ggfQrJUFsntTQgswpctg3TzGbf7QqC7ocA0pwEThv+XpsXWzdGLG7bN9
 Xi0GzfCj3DBGGSmsMhedFrY3b4or+DRBOauQIee8ojA/HZJbMLIED7+4+2WTt7CVHwH9
 juE6fbXWL1cU3Zfv8LLJrrB6uR/B8wrLCywZXQc4/kZFw5AXP3/Rduh4cB/hvKCsXG7e
 VgbJ4navowzFRg6DuORZQRiub+KM2yS7UNfu+9xjTR4+4dxebNcnl89232iFw2Gbw+Yv
 lYrQqRvwY6p2f7xX1MWoYsy68dSBgUp737Pbdw4KhwRuF0DWE+Ufxa/CLCVYF3YCV06X
 tUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s6lBFBc4HaiFISgjHlK8hHEp4NKwroeyNp8C/sSoYAE=;
 b=V6fjpaKne6tN7WAvYVeIl5VoPCdLKpv7rwVWgyf/tH/Fz2rfZmtQXcsL6UD4Pl3AVe
 xhbSNWIdguevUjFqwxtteiH0B2P/5qVod8ZKzpMAJWubOE+q6GZeZz3PwsPgE73eHmfr
 yJcozJo1aRY2297Uu3uKZFLRIBN+N8MfnyvZwRGugd6VkykGulR5kdMbLHUrVvjEWjVy
 BbjqPh2riIgvKgl3lu71tEpNns8f0V+0BMRHJmh35xWiMq83wdWYLpjNgXQBLaLnzXdc
 OJremXKwESbteznb+AVkv6xZrrhDmBhpT2oUCUwjcLHgP/TqWP+kMxovvSJnlNPcczu4
 V8AQ==
X-Gm-Message-State: AOAM530XRIh1zQn9IAGkMmzCDE/pmVLB8Xd8UF7jxd8haA4o9W38wVKG
 H0P+GQL28N+glFn91/fLxZykCPbx7u0y7wQ9vnc=
X-Google-Smtp-Source: ABdhPJwf10Dqj1X9iLTP0c1xDBlLJxUqijtmfMb+3EiKhsFNO/T1/WcrhS3tR2zapzFkcdrZYcHiEI7Z6AX+5DHVUqw=
X-Received: by 2002:aca:904:: with SMTP id 4mr2890193oij.97.1599440879388;
 Sun, 06 Sep 2020 18:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-8-philmd@redhat.com>
In-Reply-To: <20200904154439.643272-8-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:07:23 +0800
Message-ID: <CAKXe6SJG1ReNyj0TiTZEsmZAib=uwTLaXmx7iCLn2v2MoOd-XA@mail.gmail.com>
Subject: Re: [PATCH 07/13] dma: Let dma_memory_write() propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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
=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:46=E5=86=99=E9=81=
=93=EF=BC=9A
>
> dma_memory_rw_relaxed() returns a MemTxResult type.
> Do not discard it, return it to the caller.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/sysemu/dma.h | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index 2961a96ad67..f4ade067a46 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -96,8 +96,10 @@ static inline MemTxResult dma_memory_read_relaxed(Addr=
essSpace *as,
>      return dma_memory_rw_relaxed(as, addr, buf, len, DMA_DIRECTION_TO_DE=
VICE);
>  }
>
> -static inline int dma_memory_write_relaxed(AddressSpace *as, dma_addr_t =
addr,
> -                                           const void *buf, dma_addr_t l=
en)
> +static inline MemTxResult dma_memory_write_relaxed(AddressSpace *as,
> +                                                   dma_addr_t addr,
> +                                                   const void *buf,
> +                                                   dma_addr_t len)
>  {
>      return dma_memory_rw_relaxed(as, addr, (void *)buf, len,
>                                   DMA_DIRECTION_FROM_DEVICE);
> @@ -143,8 +145,20 @@ static inline MemTxResult dma_memory_read(AddressSpa=
ce *as, dma_addr_t addr,
>      return dma_memory_rw(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
>  }
>
> -static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
> -                                   const void *buf, dma_addr_t len)
> +/**
> + * address_space_write: Write to address space from DMA controller.
> + *
> + * Return a MemTxResult indicating whether the operation succeeded
> + * or failed (eg unassigned memory, device rejected the transaction,
> + * IOMMU fault).
> + *
> + * @as: #AddressSpace to be accessed
> + * @addr: address within that address space
> + * @buf: buffer with the data transferred
> + * @len: the number of bytes to write
> + */
> +static inline MemTxResult dma_memory_write(AddressSpace *as, dma_addr_t =
addr,
> +                                           const void *buf, dma_addr_t l=
en)
>  {
>      return dma_memory_rw(as, addr, (void *)buf, len,
>                           DMA_DIRECTION_FROM_DEVICE);
> --
> 2.26.2
>
>

