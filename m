Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA12EC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8962E2072B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfj+MJhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8962E2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igozc-0007RB-KL
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:56:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igopu-0007FA-MT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igops-0006OT-GO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:46:50 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igops-0006Jt-9v
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:46:48 -0500
Received: by mail-ot1-x342.google.com with SMTP id 66so8848659otd.9
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8I5trJBGTW4luMb11Ffwe+Tyg+F3aLb9Oz/+hKtjAZQ=;
 b=yfj+MJhPaUOx7sxyWSVqpAJ3fhdorMc3yaCPiBcoJGHf3s50+RFX6CsD4btsF+xSNc
 epRtGKgGbnJcYr0b+57Psp8tbjWI91A+UwqXMW8IC/oT7eShtLBIxYb7eKq1wMyKwPQ7
 hDHK3B767lDJVvofvKZem/Aqt3PKjOSZNDB1JlLc4zYu+HdTtUx0gF31MlGxOPJ7M7ha
 Z+iDvgWzgkUF498+wFV8G9EUAcZ6xu5vn/w+H8bCbsk1CeEoLt0xYd/DPhZEXGjqxCMF
 oLZb9t8B63ZeKqB1WI752r0JJh7BkK5f9q4W1HbKLXetzOwI8GmThU55YSrFU9rPVH+/
 2aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8I5trJBGTW4luMb11Ffwe+Tyg+F3aLb9Oz/+hKtjAZQ=;
 b=uRkQBVjTGIG0xLgjAy879kIoj7zJvH1Gp+H3LMHO+SN9bk8azlEleSSukA6Sw7sGH9
 LP5Q12DduNHKfcE6BmE8LVrMEOUl9C2Sgjo1yuXkkth55grtroM4HIF+SjMwgYhmWdRB
 RicYzVe2wtYa7/mdkB4CPzU50ijsQWbPyGU8DdBInEc35tV9bK7OyHSpYu7t73DQVLxT
 QEAmS2pgp1qpczQRJRrsC+eD48ouzvpAwc7bJ2MuQWe4rknBzMSSqra0/2BL/unhHu2B
 uoEIQ78460SI6QJA7Uz7kC7B6rB+d9jhhBDx/VTSVVEdIa48nn3sWiipAdM1omcxaNXE
 AxmQ==
X-Gm-Message-State: APjAAAU0nf99quoULuRivMEpaSIiRUPfv6Z5WlXTjtGYrmy68grg9cq6
 19AfCyoJLCQAM8v2nnIEMngsAft32W+DhdQVocAQTw==
X-Google-Smtp-Source: APXvYqxU8RwCCG8UHVDxyzHL7AncEdglJUZybQzX82nL6dMWGIqTX5XxVtjPkHDzIBRKKOCDoO1XFnaJ5Vmd7ng4cws=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr31703782otq.135.1576496807419; 
 Mon, 16 Dec 2019 03:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20191214155614.19004-1-philmd@redhat.com>
 <CAFEAcA_QZtU9X4fxZk2oWAkN-zxXdQZejrSKZbDxPKLMwdFWgw@mail.gmail.com>
 <20191215044759-mutt-send-email-mst@kernel.org>
 <CAFEAcA9ZF3VTR7kG_D-cJ+vPFTgd8zjmt2VPfJC7urNemF-5AQ@mail.gmail.com>
 <20191216063529-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191216063529-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 11:46:35 +0000
Message-ID: <CAFEAcA8RLOOT+0Bad4PfU0Jubp9MDOTTt1rHBQYABAfd9oMRLw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Simplify memory_region_add_subregion_overlap(...,
 priority=0)
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Dec 2019 at 11:40, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Dec 15, 2019 at 03:27:12PM +0000, Peter Maydell wrote:
> > On Sun, 15 Dec 2019 at 09:51, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Sat, Dec 14, 2019 at 04:28:08PM +0000, Peter Maydell wrote:
> > > > (It doesn't actually assert that it doesn't
> > > > overlap because we have some legacy uses, notably
> > > > in the x86 PC machines, which do overlap without using
> > > > the right function, which we've never tried to tidy up.)
> > >
> > > It's not exactly legacy uses.
> > >
> > > To be more exact, the way the non overlap versions
> > > are *used* is to mean "I don't care what happens when they overlap"
> > > as opposed to "will never overlap".
> >
> > Almost all of the use of the non-overlap versions is
> > for "these are never going to overlap" -- devices or ram at
> > fixed addresses in the address space that can't
> > ever be mapped over by anything else. If you want
> > "can overlap but I don't care which one wins" then
> > that would be more clearly expressed by using the _overlap()
> > version but just giving everything that can overlap there
> > the same priority.
>
> Problem is device doesn't always know whether something can overlap it.
> Imagine device A at a fixed address.
> Guest can program device B to overlap the fixed address.
> How is device A supposed to know this can happen?

That's why (the original intention was) only one of the
regions needs to be marked 'overlap OK', not both.

thanks
-- PMM

