Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2255BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694C32080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTWrBZHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694C32080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5YE-0002c1-EX
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5XD-0001lq-1M; Sun, 06 Sep 2020 21:01:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kF5XB-0001en-4q; Sun, 06 Sep 2020 21:01:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id a65so10982817otc.8;
 Sun, 06 Sep 2020 18:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vmLZIdUf1AENjpfh6DNQdv7YRpXdDJb7Kqoes9fdsfk=;
 b=OTWrBZHtmK2ktZ7dnOizo864WES68BEAJh5N2akbVb/+SM2r8vfXR6tpjDe8kTI3go
 nNQ0iM9nQLXBM//dJV9GOuc4nLD090+9aZ//evqAGymJpnFWxOJmLg++i0BEIiBEzHKi
 eShubw3urwfs+y1Zc0nNjDWyaD8ras8bTCeEsXJp8htvuouZhfHwSocC1o15bUQs8QPL
 6iPhia95Lr4WejvqI0RpS1dgetWsU3X5bJb567iurxKdez73/uIQGhMHbe6X37n7wGFP
 qoe5EPk7Y3VKeS5bVWNT41a8H43eEqiXZVLyCmhW785vI/c7sU5dOwWx083ZmnK6fxuC
 HECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vmLZIdUf1AENjpfh6DNQdv7YRpXdDJb7Kqoes9fdsfk=;
 b=Us7nlEaMTEBHkAvak9N0FHJZsjAeTi0KNmFd8WHxcjLDQDba5weFU14ow34SlN6B9I
 owzESX/fVcw5dZM+WmiA3HoAmJv5tWwAEHpFs7eCroasQLLZKS4CoRKmn5TQ+ebLHhDF
 AEw+K/UVP0XV/sXdBPcxG8Pycv0ns4f1zJIYmWvm2B2dZ3gLZqBWiiElMryJSo7/+iJ+
 yvfvcZlfXKJdxV+eiKsgHaZhAQLmDoht+Va4l4IW3Uxys1eHZg9MKeIMinvs1jCWwUHC
 114ekCDfRO4vIMi3qrkaY10gwrJDp93zdxsf6EpSo3iByQ2sC7ZIWi0G9sNFOLiuH7EE
 dNIA==
X-Gm-Message-State: AOAM5311Pz4Nk+eQbMZbbGDenDteg+tiC+dLVAowIlEsPBnMslatlWOT
 kpdKke1z2HiRWuDpNynnPAvvOCkS/ztl9mKGj7k=
X-Google-Smtp-Source: ABdhPJwL0B/6I2tCQQvFwyHYehPJ5MZ54u+uU2aje9MHbKocizQ8tgAGK6VrdoIHvWb5iIQ4sTH/vPzCdgSuBDVCBuQ=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr12439988ote.181.1599440482465; 
 Sun, 06 Sep 2020 18:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-2-philmd@redhat.com>
In-Reply-To: <20200904154439.643272-2-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 7 Sep 2020 09:00:46 +0800
Message-ID: <CAKXe6SLa6045REp+TyXVn3dYWrruromuW17e29Vkf841yW2hWQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] pci: pass along the return value of dma_memory_rw
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
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Keith Busch <kbusch@kernel.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Klaus Jensen <k.jensen@samsung.com>,
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
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Some might actually care about the return value of dma_memory_rw. So
> let us pass it along instead of ignoring it.
>
> There are no existing users of the return value, so this patch should be
> safe.
>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Message-Id: <20191011070141.188713-2-its@irrelevant.dk>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  include/hw/pci/pci.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 4ca7258b5b7..896cef9ad47 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -788,8 +788,7 @@ static inline AddressSpace *pci_get_address_space(PCI=
Device *dev)
>  static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
>                               void *buf, dma_addr_t len, DMADirection dir=
)
>  {
> -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
> -    return 0;
> +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir=
);
>  }
>
>  static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
> --
> 2.26.2
>
>

