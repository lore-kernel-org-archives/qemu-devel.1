Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FCB20862
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxIv5fvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FCB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2N3-0006zh-O5
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia2IF-00053h-Aa
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia2IE-0004vr-Cx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:44:03 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ia2IE-0004up-7p
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:44:02 -0500
Received: by mail-oi1-x244.google.com with SMTP id j7so21045065oib.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 10:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2c7MWjgpnJMTZJszGOqQij87q7nZGnfbS9NosbanhtY=;
 b=oxIv5fvqVNnz3wVJNKuB0kJHr6M++YTsm1NqNN3oHHXbdbFE2ErwwHmlEGnGCJmgBb
 Q1Q8b2jM5WyRbbHENovh6zCeWQ/O1EeGGkJGafza/tOFvLEmwyqZForLvxVaSnrfgGyr
 z8/g9ngpj9Gzl/+TQ1baVXQp4MIQyTV8lfL4JL/QnpE6/Lzz3dLcoDlMFG3QiTnErftj
 TjAuwkRAftWaTjS599o7WyrQCO1gHDdp6ULRnz9yMUO5AFYP7elq1w+bpKuRisfY9lng
 1k3AAJzzEOKG+AGy1UKTIju5fRIeJ9s1qACZ59XRvRr8yvZppMOPYiCfM6t/xjmVLs0G
 eiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2c7MWjgpnJMTZJszGOqQij87q7nZGnfbS9NosbanhtY=;
 b=fZpnVv/A7ptEEq6gbN6MY3Mr2qQy4yAcja8A7vBgpji6jFqr0BVT3PgPPKVJIfsRAg
 LQXRP75omB2gVqsJCgb/4+Kz68AIPdu9n3th8bov2AkpUUS3Zez7b2VGrHAHbgm8JLS+
 VMKscFq7WZYrjRzCH+d9gualAYXs0MDd63f7GPFaYuh9SRG2jYBYYrRXZ3NSdoXDh0VW
 9yJbl0kyJ59rs5i64eV8OHpl8ZS8y0cFenTQcRe0RXLTlyk6Au5czk1iXoy03ltvFPJk
 x9HHiZYO7x/aImftayfWMyVKP+p+F8Ye24FWwaMZSnju1w/mlNt4gHVoYARFOc4idm/4
 oBbg==
X-Gm-Message-State: APjAAAVSsVPV2stznF2H1EjSzr+F2CesSo6EwSO2grZsAHbg9GiDKzlL
 W2ngiH612gCpSm1fA9x0uvBKcCrkKwjINqlCiV0=
X-Google-Smtp-Source: APXvYqytSjr6mU2DGmXJ+mobaEacqU6TyzshU5X4vmcCGtpfUoh9VJjJGcxcqStgROLo434Ur5Xnvy8EBhCGK5jSKhc=
X-Received: by 2002:aca:670b:: with SMTP id z11mr5168670oix.79.1574880241379; 
 Wed, 27 Nov 2019 10:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-12-mrolnik@gmail.com>
 <81b62c00-243e-b76e-f52c-4f681b47b727@redhat.com>
In-Reply-To: <81b62c00-243e-b76e-f52c-4f681b47b727@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 19:43:50 +0100
Message-ID: <CAL1e-=i6tctJ6bKo7mz2fmSzPXpdMY1kV1WrKhL5TCAKd0DkcQ@mail.gmail.com>
Subject: Re: [PATCH v36 11/17] target/avr: Add limited support for USART and
 16 bit timer peripherals
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > +/* Offsets of registers. */
> > +#define USART_DR   0x06
> > +#define USART_CSRA  0x00
> > +#define USART_CSRB  0x01
> > +#define USART_CSRC  0x02
> > +#define USART_BRRH 0x05
> > +#define USART_BRRL 0x04
> > +
> > +/* Relevant bits in regiters. */
> > +#define USART_CSRA_RXC    (1 << 7)
> > +#define USART_CSRA_TXC    (1 << 6)
> > +#define USART_CSRA_DRE    (1 << 5)
> > +#define USART_CSRA_MPCM   (1 << 0)
> > +
> > +#define USART_CSRB_RXCIE  (1 << 7)
> > +#define USART_CSRB_TXCIE  (1 << 6)
> > +#define USART_CSRB_DREIE  (1 << 5)
> > +#define USART_CSRB_RXEN   (1 << 4)
> > +#define USART_CSRB_TXEN   (1 << 3)
> > +#define USART_CSRB_CSZ2   (1 << 2)
> > +#define USART_CSRB_RXB8   (1 << 1)
> > +#define USART_CSRB_TXB8   (1 << 0)
> > +
> > +#define USART_CSRC_MSEL1  (1 << 7)
> > +#define USART_CSRC_MSEL0  (1 << 6)
> > +#define USART_CSRC_PM1    (1 << 5)
> > +#define USART_CSRC_PM0    (1 << 4)
> > +#define USART_CSRC_CSZ1   (1 << 2)
> > +#define USART_CSRC_CSZ0   (1 << 1)
>
> The previous definitions can go into hw/char/avr_usart.c.
>

Why?

