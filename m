Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53073C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018872078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K31QKriK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018872078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnQY-0005yc-4L
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDnPu-00055T-IU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:28:34 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:37972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDnPs-0008Op-SO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:28:34 -0400
Received: by mail-ej1-x631.google.com with SMTP id i22so3348039eja.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f2Y/32ubcLIXu+Fx8yG/mdzu/9JOvOGnww1HfRFRsSA=;
 b=K31QKriKcy/TAktk/Vbh17w+h4AXT/tCR8MUcg60+M0r/ZD4VEu3BdZ5fzjewjAr8Q
 icXaagNnA6Q1sauog4wbFM9oz76X43H5pbh3asTUPcbPmbj6oxPq5uLiCxSINnwPHb9a
 H83tiNshVXvCV69VRJZlrE+c4U229YLNBzCNiXyFyhXUv4/dziqPR7mssmMSofivpn82
 DXg/zhUJIFz07Rls3aXhsjxywhZ0XzLoUs8hPtMvAkwSvScBup2PKZdq07TCnJYY+2ou
 s13eCO+xUPDCXsBQkK6NNNyB4N0Ys8C8DXOc2bG6R90kim1mOd0MnwGA5NBGiLjXkzey
 rVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f2Y/32ubcLIXu+Fx8yG/mdzu/9JOvOGnww1HfRFRsSA=;
 b=JMJGfDiT5lbpfCug2p0L4QG3TC1wc1Rm5zp/jsVF1byw8a4rS3B5cnHsdOlua55bo5
 BxlPXpShkhztZaCScOLWtf7/4vEc/3xNux/4A+4410utSQpBynKZD9aGZTlEDku2X9O5
 BwqjGULojB3VzK4b+pIX3xROzyD1YuJAdMkTbYD2FdEOHfbz34XTXvObw+/2zRtEE9da
 LLjY/CS4eC0VuShFtV3h/lOlnxoux0eMEZPHV2mnfX3F1eGayHr8OI8LBYlvspR2/jCQ
 DJ7HHITE6R8asHig3syEM5MHbUhp6NNNdxSwWH1HfcsYZx4tJKpVAeqBmuPk7msEqMu6
 88PA==
X-Gm-Message-State: AOAM5304+VjtAVYuki/PJA6o1Hd0MdGmCVZHjjcAQ6cHqyliz959NCSV
 3NGfHd5gCOXlpNxyTxAr1LaZF2gursU8K0WdHEkRQg==
X-Google-Smtp-Source: ABdhPJz9tMoARJhmCl2kHHLm31mzSpOEJ8lUS85RWIkQQYP2yB4GVDoclIVe2ZzYiYU/nehhLZVi1zWRTFy1c8M28Xk=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr1578723ejb.382.1599132511255; 
 Thu, 03 Sep 2020 04:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200902162206.101872-1-liq3ea@163.com>
 <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
 <CAFEAcA9mvMaR5MJJ74Vv63TG6frWnMeSZA19Zxv8TUceudPUTQ@mail.gmail.com>
 <CAKXe6SLYgkiTAYa81nppHUMEzoeGy3988OmrzZyw8-VY8ajE3w@mail.gmail.com>
 <CAFEAcA9TEpfBmfOOtpfR9JCAFkMF0fy20L=DBVDTFaLp6J3Lfg@mail.gmail.com>
 <CAKXe6SKgVo5HBL2Uf8AscEn5ohZOJZGLMmT3NZL5cEbcQzgivg@mail.gmail.com>
In-Reply-To: <CAKXe6SKgVo5HBL2Uf8AscEn5ohZOJZGLMmT3NZL5cEbcQzgivg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2020 12:28:20 +0100
Message-ID: <CAFEAcA_yTWf2toD_R3ye_cYRZjGOeyrKTV6At2U6vtHn5iiYPg@mail.gmail.com>
Subject: Re: [RFC 0/3] try to solve the DMA to MMIO issue
To: Li Qiang <liq3ea@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@163.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 at 12:24, Li Qiang <liq3ea@gmail.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=88=
3=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:19=E5=86=99=E9=81=93=EF=BC=
=9A
> > No. Any device can have an inbound or outbound qemu_irq line.
> > We use them not just for actual IRQ lines but for any
> > situation where we need to pass an on-or-off signal from
> > one device to another.
>
> Could you please provide some example, I haven't noticed this before.

Look at any device that calls qdev_init_gpio_in() or
qdev_init_gpio_in_named() for an example of inbound signals.
Outbound signals might be created via qdev_init_gpio_out(),
qdev_init_gpio_out_named() or sysbus_init_irq().

thanks
-- PMM

