Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B51C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391A720738
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1zCS5bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391A720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXWEP-0004vM-9O
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 17:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXWCW-0003Yy-Du; Tue, 27 Oct 2020 17:08:16 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:44036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXWCU-0001vk-Nk; Tue, 27 Oct 2020 17:08:16 -0400
Received: by mail-il1-x142.google.com with SMTP id z2so2790388ilh.11;
 Tue, 27 Oct 2020 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OFt45wZBSTHDWzJGnz4sMYVyBAla/d9gKrF9yfbNNFE=;
 b=o1zCS5bb8cd7rD4inxz5qnT8JDzudke29C0nwTR7nbalQ0+kximfE77/vIyHdXJ0/i
 mWi3RKZEGr5q9a8QDjMgmvYEbyqL9yVQ0u7dMyBpCclaOf50tMz6hBQ9NcNMC/oz9Mnq
 B0xcRUcjb4OWTr8r9mOP1x88T96Ii4UvZ0cD5sB8dsY6i/euiOpFQ1TV1Hc2+SwJGD4L
 VS1rnY9pzewJ/x5zIbv2kdKEEBcppQzv7Eo9ew5oItTbRjsztqydGfE7IpQC90YeFwG6
 LsRdfElgJW5DZmttrpdKU49WwUOJCP4lg0rJrREhJ8H7bPW3/TVFN+WVHwyw2XzJJXVy
 WDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OFt45wZBSTHDWzJGnz4sMYVyBAla/d9gKrF9yfbNNFE=;
 b=rwi8jR/eZQRNq9nQf57M+5Gkc5vBg01GW37XA50jzPUpAWeNB5xmpwN2cQPSXM83Ky
 ikcW4klzWhK6clA7QzMrObhfaEeTWlmNHFe0VjRURamnmNbUzAqRX2TtHd3wGxVp1WlF
 MH6JKu1USgUKTlAFeco7IpoSO21PYDQ3YblHeAy/M1krQt1IvQd4Cz8s4ayh2+HubvBX
 TUCb/9GYk3UUz1aWcJP5pNoZJ4BROw4zUwSl1IhcDD7EASbeOmzHy2edXWCFsPh+ACHx
 U5f0IsWjsJhR+IdSxX9b1SeCmg5n0om088FoN0hmdudMv5fNsZzv4NRgP5lbbk/Or0Pq
 U2EA==
X-Gm-Message-State: AOAM531hfAHH9bQu4Sfav6k2tzgBxwSHIYdGKEYpOh2XyPGgllhQlgEt
 zvANz94aApfaPAUzOPqzdr0AUe+uQndi0tJ0Wm1NbAOKuNc=
X-Google-Smtp-Source: ABdhPJxaXpJAM5KFQUXxUWrfD0VRlJ4oAy5elLMk5YSJhxXCPSqhaq7lN/QYLbJ5k+3rquZtEnWZZda1H7495Q6Wopc=
X-Received: by 2002:a92:c5ce:: with SMTP id s14mr3622676ilt.40.1603832892910; 
 Tue, 27 Oct 2020 14:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKODEgnkw4zBbsNK1zQ7qaiKWEAZBpwhnHzEetjgWpxtzQ@mail.gmail.com>
 <20201016171000.21240-1-ivan.griffin@emdalo.com>
 <CAEUhbmV5V9gXeyn1Bp-u3L4FGwU_+m0CT-vomL7W8WGY9yt_nQ@mail.gmail.com>
In-Reply-To: <CAEUhbmV5V9gXeyn1Bp-u3L4FGwU_+m0CT-vomL7W8WGY9yt_nQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Oct 2020 13:56:22 -0700
Message-ID: <CAKmqyKPQf74rJfYrbWXV1HO=mevyg8DvMYc85dNgPkiaOCyOKA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 18, 2020 at 6:58 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Ivan,
>
> On Sat, Oct 17, 2020 at 1:10 AM Ivan Griffin <ivan.griffin@emdalo.com> wrote:
> >
> > Adding the PolarFire SoC IOSCBCTRL memory region to prevent QEMU
> > reporting a STORE/AMO Access Fault.
> >
> > This region is used by the PolarFire SoC port of U-Boot to
> > interact with the FPGA system controller.
> >
> > Signed-off-by: Ivan Griffin <ivan.griffin@emdalo.com>
> > ---
> >  hw/riscv/microchip_pfsoc.c         | 10 ++++++++++
> >  include/hw/riscv/microchip_pfsoc.h |  1 +
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index 4627179cd3..9aaa276ee2 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -97,6 +97,7 @@ static const struct MemmapEntry {
> >      [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
> >      [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
> >      [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
> > +    [MICROCHIP_PFSOC_IOSCB_CTRL] =      { 0x37020000,     0x1000 },
> >      [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
> >      [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
> >  };
> > @@ -341,6 +342,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
> >      create_unimplemented_device("microchip.pfsoc.ioscb.cfg",
> >          memmap[MICROCHIP_PFSOC_IOSCB_CFG].base,
> >          memmap[MICROCHIP_PFSOC_IOSCB_CFG].size);
> > +
> > +    /* IOSCBCTRL
> > +     *
> > +     * These registers are not documented in the official documentation
> > +     * but used by the polarfire-soc-bare-meta-library code
> > +     */
> > +    create_unimplemented_device("microchip.pfsoc.ioscb.ctrl",
> > +        memmap[MICROCHIP_PFSOC_IOSCB_CTRL].base,
> > +        memmap[MICROCHIP_PFSOC_IOSCB_CTRL].size);
> >  }
> >
> >  static void microchip_pfsoc_soc_class_init(ObjectClass *oc, void *data)
> > diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> > index 8bfc7e1a85..3f1874b162 100644
> > --- a/include/hw/riscv/microchip_pfsoc.h
> > +++ b/include/hw/riscv/microchip_pfsoc.h
> > @@ -95,6 +95,7 @@ enum {
> >      MICROCHIP_PFSOC_ENVM_CFG,
> >      MICROCHIP_PFSOC_ENVM_DATA,
> >      MICROCHIP_PFSOC_IOSCB_CFG,
> > +    MICROCHIP_PFSOC_IOSCB_CTRL,
> >      MICROCHIP_PFSOC_DRAM,
> >  };
>
> Thank you for the patch!
>
> I am currently adding the DDR controller modeling support to PolarFire
> SoC which will cover this memory map. With my patch series, your patch
> is no longer needed.

I forgot to apply this, and Bin just sent his series. So if it's ok
with you Ivan I'm just going to apply Bin's series instead. Sorry
about that.

Alistair

>
> Regards,
> Bin

