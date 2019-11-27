Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F74C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BD6205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTRQqtDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BD6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia3XA-0006Qj-7j
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 15:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia3Vv-0005vP-D7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia3Vu-0001s5-B3
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:02:15 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ia3Vu-0001qJ-5D
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:02:14 -0500
Received: by mail-ot1-x343.google.com with SMTP id r27so5642477otc.8
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 12:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5RF3XmyEPO29i4zAOcQbPJh0ynx3v3k1tWmNvSoh08Y=;
 b=rTRQqtDrFXh2b4IsX7ExWwR6+Gt17ju3vS29q0yAh+ouCGnjkSnK5q7Ccnrz0Rc6cP
 urldnwV9DM1GHxirefzW1lACUXZNwGwAKVp7u32YmEFrQnv31uc4pVNBUCR/WA1tkUEs
 6342F98LNGGmmz3hi7b49if1XKHVgDOR1idCBFaDvlelVgBzIVn7FVrl3i96Nb8dyTUI
 vdnS+H8/S2wid1mBRMGofJD91EYOwdA1IMl4Hg9WYtWc824x1e1NDGX0UHiwa49tl/U9
 GkixfeLT4RmsIjwxH2nzmiODsmLhAodBzMNaQm4+FWF9zPHWna1mvfran+iXiyjMDt08
 2o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5RF3XmyEPO29i4zAOcQbPJh0ynx3v3k1tWmNvSoh08Y=;
 b=HEhtJR8BJ/vDbIt+TxKfdPcSWo+p9nDTdMy6Pv796NFMHZJ7jf91BOMw/lA5wfPS/N
 +yUGDp2E+TnXojsxg+Ayz/hPryccjokd4XAmZQ7TyLC8U/HNYxQMq5tJ96c0H+6T73Hr
 mSbm/vYpcR6VQ2Lpg34RlN4Amj1fskr8IK/hPDiz1Zf7Vfqu7cMB5voIsRh+3xe6Av7+
 9sOCvN3tRoUG09zF5J7F3spqXDs1fZ6skETxnjyEnVXt8NwKeiXYRWXLF4puNhgDo4Gh
 T1tDe1Ra/rb3uREtsTSrVSgJqYyImKs4eRBScP4qa0VSGjD92tz1FWWemIiCsRJcuMpA
 P22A==
X-Gm-Message-State: APjAAAW3cs5vQDItXdyk9Aqa4iVRP1yhP6BjRn4PawgLHJ+g3TSYDgo4
 eA8mygxAdDMEiI/W1jsLtgLrwWT/wXvQjDQPFlk=
X-Google-Smtp-Source: APXvYqyb9GgFCKFarn73O+NL/Qwt4f+kY3Ud1dXMdlGh1FZDosDabNfrh1dOAvRd5a6UtTUKg3d2YX5UQRIBapyhcb0=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr371823oth.121.1574884932720;
 Wed, 27 Nov 2019 12:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-12-mrolnik@gmail.com>
 <81b62c00-243e-b76e-f52c-4f681b47b727@redhat.com>
 <CAL1e-=i6tctJ6bKo7mz2fmSzPXpdMY1kV1WrKhL5TCAKd0DkcQ@mail.gmail.com>
In-Reply-To: <CAL1e-=i6tctJ6bKo7mz2fmSzPXpdMY1kV1WrKhL5TCAKd0DkcQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 21:02:00 +0100
Message-ID: <CAL1e-=jfHoEUNY-ZWGF2HZLF6NbsWwo0cXd4X9P6dkgWooo1LQ@mail.gmail.com>
Subject: Re: [PATCH v36 11/17] target/avr: Add limited support for USART and
 16 bit timer peripherals
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Wed, Nov 27, 2019 at 7:43 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> > > +/* Offsets of registers. */
> > > +#define USART_DR   0x06
> > > +#define USART_CSRA  0x00
> > > +#define USART_CSRB  0x01
> > > +#define USART_CSRC  0x02
> > > +#define USART_BRRH 0x05
> > > +#define USART_BRRL 0x04
> > > +
> > > +/* Relevant bits in regiters. */
> > > +#define USART_CSRA_RXC    (1 << 7)
> > > +#define USART_CSRA_TXC    (1 << 6)
> > > +#define USART_CSRA_DRE    (1 << 5)
> > > +#define USART_CSRA_MPCM   (1 << 0)
> > > +
> > > +#define USART_CSRB_RXCIE  (1 << 7)
> > > +#define USART_CSRB_TXCIE  (1 << 6)
> > > +#define USART_CSRB_DREIE  (1 << 5)
> > > +#define USART_CSRB_RXEN   (1 << 4)
> > > +#define USART_CSRB_TXEN   (1 << 3)
> > > +#define USART_CSRB_CSZ2   (1 << 2)
> > > +#define USART_CSRB_RXB8   (1 << 1)
> > > +#define USART_CSRB_TXB8   (1 << 0)
> > > +
> > > +#define USART_CSRC_MSEL1  (1 << 7)
> > > +#define USART_CSRC_MSEL0  (1 << 6)
> > > +#define USART_CSRC_PM1    (1 << 5)
> > > +#define USART_CSRC_PM0    (1 << 4)
> > > +#define USART_CSRC_CSZ1   (1 << 2)
> > > +#define USART_CSRC_CSZ0   (1 << 1)
> >
> > The previous definitions can go into hw/char/avr_usart.c.
> >
>
> Why?

Seriously, Philippe, why move this from their perfect cosy place in the header?

If the answer is "because most of others in QEMU do", I don't know...
I wouldn't consider that a legitimate reason - at least not in this
particular case.

Aleksandar

