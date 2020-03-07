Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB3C10DCE
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 02:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AD62067C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 02:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8i+BiZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AD62067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAOx2-0004Id-R2
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 21:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jAOwV-0003ts-4L
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 21:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jAOwT-0004wT-QW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 21:11:54 -0500
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:47091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jAOwT-0004tg-M6; Fri, 06 Mar 2020 21:11:53 -0500
Received: by mail-ua1-x944.google.com with SMTP id h22so1414358uap.13;
 Fri, 06 Mar 2020 18:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U9/PvS9v3w6r+2piSor+3FOIHmJEuAulYDCStu3UObY=;
 b=q8i+BiZDvG2OJvu69XxkoodxhOGF8msOpn7X9ptnQtmS9VfV4O9TTAArvfWhx9GwZd
 l7byjP+qRRiERu5G6nAgKcbOR9MrpKCoTqghnvo2iN/flxdbfjEcrij0WQaIlRuiI4tR
 kqeSuz2eDzV8DaWksWTRRRpzdIogbLOrQFDJZoEh7Dg0D7VDcbqlm3tvoZ591+R5PWal
 VKi52lzFLdTpzREYVZTwolGEtWBguephXe4+BSNT65smD2Klms66jwDePJ+gPFjwurbN
 hXVr/pxI+kX3ZSv9mNLTyMmvMugfkXfMTOX7KDgyeV76fOszV34BPIuysM1MIVJr6RMq
 94/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U9/PvS9v3w6r+2piSor+3FOIHmJEuAulYDCStu3UObY=;
 b=uUJYmV0TeK5C0i5dZzjm1hN8XgMEJXeQvEifNkB6HL0jeG7SOZbP8fq+STvzh/M0iV
 x4VRJj26Xg0tP5QBf4EGrPRw3B4Yz8ogupBx7JSio/V3mRvHuEzal43MGJXHYusfhZVD
 SuNEck89bGnQIIQonYYBWON51FBoXWZZ/xKwbRXF2QS3QWH8GkW8eNXo24ajjGsy+Gsc
 MpJoQEUC1fgSM9ic847usE+Izqyad63739wH1OlZ6t1C6MDeYQYVV1iG6KPoj6zTkcBE
 QvE5alj0Sxa2+MimBkS7i0vU5R5Dt4+IGvsCyKgAGQyVPwOJd91ujujaQF8LxkzwNhCO
 ZgkQ==
X-Gm-Message-State: ANhLgQ1oGRmJxCwiI297Msd8JZWxks/kK8M0WcJSZrMCSGPFl1s66vxj
 s9Jux1YpqOMbyNkCZuLHnyyIWzLqbJdV+9mFcWo=
X-Google-Smtp-Source: ADFU+vuaqF2VuueOmDaD9qDWoVxuZHhrlzCdZfKNDDQo8P0c3N/w0yw4g4mOwqgZY1iqbSMM4o1vZ1R112yICvy4MPs=
X-Received: by 2002:ab0:2302:: with SMTP id a2mr3432633uao.21.1583547112826;
 Fri, 06 Mar 2020 18:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20200229141011.58989-1-root@stephanos.io>
 <CAKmqyKP1QFiWSQzUsoV9TLWBQ8hrx+yg7UM2=DnAoCAanLRuwA@mail.gmail.com>
 <CAFEAcA_O6ScMF0fJgHORVXDQ+PvFNW4w6kBkeeB0vHixHo0zqA@mail.gmail.com>
 <SLXP216MB0285BF0CF1158A96DDABA736BDE30@SLXP216MB0285.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SLXP216MB0285BF0CF1158A96DDABA736BDE30@SLXP216MB0285.KORP216.PROD.OUTLOOK.COM>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Mar 2020 18:11:25 -0800
Message-ID: <CAKmqyKPewWrntQpsJLV-VJ5Px6dtm3Xq51gNL1nRhdt8WiXPiA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation support
To: Stephanos Ioannidis <root@stephanos.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::944
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
 Alistair Francis <alistair@alistair23.me>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 4:48 PM Stephanos Ioannidis <root@stephanos.io> wrote:
>
> > Is it portable, though? I thought C bitfield order and packing was implementation-defined, which would mean that you can't guarantee that this union will give you the required thing in the uint32_t half.
>
> They are indeed implementation defined. As for packing, it is often controllable; as for order, I do not recall seeing a compiler that dares to change the order by which the fields are specified; though
> I understand the concern if QEMU policy is to be as portable as possible.
>
> Does QEMU have any form of bit field manipulation macros (e.g. GET_BIT_RANGE(a, b), SET_BIT_RANGE(a, b), ...)?

The register fields that I pointed out earlier should do what you want.

You can look at other devices and see what they do.

Alistair

>
> -----Original Message-----
> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Friday, March 6, 2020 4:30 AM
> To: Alistair Francis <alistair23@gmail.com>
> Cc: Stephanos Ioannidis <root@stephanos.io>; Alistair Francis <alistair@alistair23.me>; open list:All patches CC here <qemu-devel@nongnu.org>; open list:ARM TCG CPUs <qemu-arm@nongnu.org>
> Subject: Re: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation support
>
> On Thu, 5 Mar 2020 at 19:24, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Sat, Feb 29, 2020 at 6:12 AM Stephanos Ioannidis <root@stephanos.io> wrote:
>
> > > +typedef union {
> > > +    struct {
> > > +        uint32_t hsion : 1;
> > > +        uint32_t hsirdy : 1;
> > > +        uint32_t reserved0 : 1;
> > > +        uint32_t hsitrim : 5;
> > > +        uint32_t hsical : 8;
> > > +        uint32_t hseon : 1;
> > > +        uint32_t hserdy : 1;
> > > +        uint32_t hsebyp : 1;
> > > +        uint32_t csson : 1;
> > > +        uint32_t reserved1 : 4;
> > > +        uint32_t pllon : 1;
> > > +        uint32_t pllrdy : 1;
> > > +        uint32_t plli2son : 1;
> > > +        uint32_t plli2srdy : 1;
> > > +        uint32_t reserved2 : 4;
> > > +    };
> > > +    uint32_t reg;
> > > +} RccCrType;
> >
> > This is a pretty interesting way to represent the registers
>
> Is it portable, though? I thought C bitfield order and packing was implementation-defined, which would mean that you can't guarantee that this union will give you the required thing in the uint32_t half.
>
> I think it would be better to do this the way that other device models do it, and avoid bitfields.
>
> thanks
> -- PMM

