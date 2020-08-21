Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994FEC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6602620748
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8syaC6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6602620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9C4F-000570-N2
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 14:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9C3A-00048x-Ld; Fri, 21 Aug 2020 14:46:04 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9C38-00034E-Rn; Fri, 21 Aug 2020 14:46:04 -0400
Received: by mail-io1-xd43.google.com with SMTP id b16so2713725ioj.4;
 Fri, 21 Aug 2020 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z5aWo09n3Q8ekEgF0lgavQRLE2LoBW6o6Ace2isOne0=;
 b=M8syaC6GqLCeXgy8xW4iOggNYh57nRWWiLAnkPoGliRAgaE3kSc/xuLuXXJzFxjok6
 UpMAmEVLIAsFFr81rOh0xprc04IC+b1A4hjEmDmzlhrVOOy7Pmlo8MwXzKhKbYrPF5yU
 yv4t8W4Wog4bbO6GZgSoJmNeCg20OEGUxVcFqSR0XQPxMHqlaq5XxDDe0EZ3xr693xcT
 31taWO2E04L/7ZFZKYfQUkzyg1eaTux+w9TC9zwmSNiqHmut/49tr7WPQxuDhyODel4Y
 4GpQNGs5A9U0YO29LGH0LgiN9E54JmMMFzeHs6wnSCrIXqgWJwOwYWnFyewppcO8TCG+
 W/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z5aWo09n3Q8ekEgF0lgavQRLE2LoBW6o6Ace2isOne0=;
 b=IDAFdtA8F7EX+Jvbn6bL/LodhXuGN9zjWZD9ghU3jbPhE9jjt38XnFhMocRQvFKR56
 a7kHDODZoT7WTQjcnknCjwoMNudM2z/1LMVo7LMU/rN++XEZTsAVl5ZxJm5Qnlp2IJ0Q
 WoUk6uFwlN+0gv4fL88JJS8XzYXvxwTLfgBXgX8nertD+D/GuTmIFNJ38WbS1KPcwBYx
 6T9P4xa2h4D1rQIQ/HzWWwfn2XlQ5f9E0VqhO+WC1NpWS7l4EfhEJeFERAt2L1y1EvIT
 41kcGlBNtf9RF2Y4mCVMucTxV3I4CVQBjFgMbjihCFyh2oXxMQrWaVqmKINnZ09UPPJM
 hTyQ==
X-Gm-Message-State: AOAM533yPIZlBwTW1XR5TLYFu/Uj6HcOW6oRn4g4GyYf6eXAaX4pSg0p
 VLCLevCGS+LTJECfZI+o5Vog8OKFP9/DFv6efsk=
X-Google-Smtp-Source: ABdhPJyTyQ6nfwyl3J98Lec2GMmnPEIFGaxPAXb3EBUnSLaJtRkwflQDi9goEnpnd4YwORcTYz7/hE6qzli/RJ9k2D0=
X-Received: by 2002:a6b:6016:: with SMTP id r22mr3411692iog.42.1598035561307; 
 Fri, 21 Aug 2020 11:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200309100009.17624-1-kraxel@redhat.com>
 <CAKmqyKNZfhkTxmcGx6iAU3b1Nom2Zd5dKSeSmBrBDEfe=nAJbQ@mail.gmail.com>
In-Reply-To: <CAKmqyKNZfhkTxmcGx6iAU3b1Nom2Zd5dKSeSmBrBDEfe=nAJbQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Aug 2020 11:35:24 -0700
Message-ID: <CAKmqyKODqOF8s45tkLAh5c==hbsPdv4UMG3ouN=cS5J=mQw2QA@mail.gmail.com>
Subject: Re: [PATCH v2] stdvga+bochs-display: add dummy mmio handler
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 11:33 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Mon, Mar 9, 2020 at 3:00 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > The bochs-display mmio bar has some sub-regions with the actual hardware
> > registers.  What happens when the guest access something outside those
> > regions depends on the archirecture.  On x86 those reads succeed (and
> > return 0xff I think).  On risc-v qemu aborts.
> >
> > This patch adds handlers for the parent region, to make the wanted
> > behavior explicit and to make things consistent across architectures.
> >
> > v2:
> >  - use existing unassigned_io_ops.
> >  - also cover stdvga.
> >
> > Cc: Alistair Francis <alistair23@gmail.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> + QEMU stable.
>
> Can this be back ported to 5.0?

Sorry, I meant 4.2

Alistair

>
> Without this patch the bochs device doesn't work with RISC-V.
>
> Alistair
>
> > ---
> >  hw/display/bochs-display.c | 4 ++--
> >  hw/display/vga-pci.c       | 8 ++++----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> > index 62085f9fc063..70eb619ef424 100644
> > --- a/hw/display/bochs-display.c
> > +++ b/hw/display/bochs-display.c
> > @@ -284,8 +284,8 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
> >      memory_region_init_io(&s->qext, obj, &bochs_display_qext_ops, s,
> >                            "qemu extended regs", PCI_VGA_QEXT_SIZE);
> >
> > -    memory_region_init(&s->mmio, obj, "bochs-display-mmio",
> > -                       PCI_VGA_MMIO_SIZE);
> > +    memory_region_init_io(&s->mmio, obj, &unassigned_io_ops, NULL,
> > +                          "bochs-display-mmio", PCI_VGA_MMIO_SIZE);
> >      memory_region_add_subregion(&s->mmio, PCI_VGA_BOCHS_OFFSET, &s->vbe);
> >      memory_region_add_subregion(&s->mmio, PCI_VGA_QEXT_OFFSET, &s->qext);
> >
> > diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> > index b34632467399..6b9db86e363c 100644
> > --- a/hw/display/vga-pci.c
> > +++ b/hw/display/vga-pci.c
> > @@ -249,8 +249,8 @@ static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
> >
> >      /* mmio bar for vga register access */
> >      if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_MMIO)) {
> > -        memory_region_init(&d->mmio, NULL, "vga.mmio",
> > -                           PCI_VGA_MMIO_SIZE);
> > +        memory_region_init_io(&d->mmio, OBJECT(dev), &unassigned_io_ops, NULL,
> > +                              "vga.mmio", PCI_VGA_MMIO_SIZE);
> >
> >          if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
> >              qext = true;
> > @@ -285,8 +285,8 @@ static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
> >      s->con = graphic_console_init(DEVICE(dev), 0, s->hw_ops, s);
> >
> >      /* mmio bar */
> > -    memory_region_init(&d->mmio, OBJECT(dev), "vga.mmio",
> > -                       PCI_VGA_MMIO_SIZE);
> > +    memory_region_init_io(&d->mmio, OBJECT(dev), &unassigned_io_ops, NULL,
> > +                          "vga.mmio", PCI_VGA_MMIO_SIZE);
> >
> >      if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
> >          qext = true;
> > --
> > 2.18.2
> >

