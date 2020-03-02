Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB46C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43692173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4S+tcBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43692173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ohv-0004oD-4S
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8obq-0001oR-Of
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8obp-0006Ho-8i
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:02 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:45713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8obp-0006HA-3W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:01 -0500
Received: by mail-ot1-x329.google.com with SMTP id f21so1904251otp.12
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ojux791QudJWGTLfdX46+vB+ol6fMgidPvZabtUmSQ8=;
 b=f4S+tcBNUKUxMbDThzjq7j1wrcMrv2Qji34feyFf66SiyTYRnF5+KY4z9M4+Eqn7PI
 xVcOc3lc79RLFCwbbmo5VgRFofqfXekbziKlTD7WeUxE/xTnnYXDb0kEs5JMuXF60wF8
 BPVKllgYdIlhnDlfpOYZRA96x3rEq9cUZAPTW3LGTo0ZJAH5kuJhQAL4lIgYtkYx/ZRd
 DkTAeal8V53rjysPrKgKayVjuVAhqYm34EhNFqjWJs/iB+BH/U+5UMkZf4eNOjsOhHFY
 d+tcLicpYSTsKpp9w3PFAKkLyBq+MzLZOTTM4fCokdAv7insptIee7cDpVyzJDBiPihc
 xPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ojux791QudJWGTLfdX46+vB+ol6fMgidPvZabtUmSQ8=;
 b=GqmOL2VJOSAA6s7EvLSY2J5x578Br3LFX3aX5dYWt6Avj7AAXgWp8oUBCTJoy6TOSM
 HTj8/fZmJZgWzP522vN9f7BlRv5azH5rnEGHXa/SmoRhc7vnhg7ipx+ZX22ty9VdV9+M
 Z6JALP+nkCw3IpbsXN6R+n77cNqCStD3BK3mt756EN4Rn/1w8tGjhqO3cek1Ybc4rTWa
 7yY3H8zmgFTH+AKcmeZ4WklpVJTDWLMcx1vjOYgdYRVKjbSzkQd/q+CdxsIh0PNBBAeY
 W3RqFLRHKRYgWVJnTI56GYMAUuLVIufW4OYmPeXJKpcS8FSPcd58RGeesgOCxJJ6lIZL
 1JCg==
X-Gm-Message-State: ANhLgQ2iY2R/a1qrb1R8Fib5qgPPIPhC5lILWDZHWDwkElCsyxL0v4VR
 D77O8NHuT+ED9JUiio0ovNeDM3hEq3z75okP7SJxsg==
X-Google-Smtp-Source: ADFU+vtmLPnronTmyFV9KDkYQakUEpJCXOzPjxCpOL/7ZA7mxCIjrR8FFOEay8uiNsRzUGwdiB6BSDbE0RX13mByRKU=
X-Received: by 2002:a9d:75ca:: with SMTP id c10mr130802otl.97.1583169119484;
 Mon, 02 Mar 2020 09:11:59 -0800 (PST)
MIME-Version: 1.0
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
 <1582631466-13880-12-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_0y0NsHfkK2V4-PTYe0fiOHE6x00i9z7am5+Kvg86PNg@mail.gmail.com>
 <20200302175503.65e404d0@redhat.com>
In-Reply-To: <20200302175503.65e404d0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 17:11:48 +0000
Message-ID: <CAFEAcA_fmqchrhbiS18zeXJMCMfZ14fdsVzjBjY1=gS5hJ60_w@mail.gmail.com>
Subject: Re: [PULL 012/136] arm/cubieboard: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020 at 16:55, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon, 2 Mar 2020 15:41:13 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Hi Igor, I just noticed this, and I don't think it's the
> > right thing. The board model should have its own state
> > structure which contains any objects it creates. Just
> > because there happens currently to be only a single
> > object in this case doesn't mean we want to lose the
> > structure. In particular, we now just leak the
> > pointer to the TYPE_AW_A10 object, rather than having
> > it be tracked by being pointed to from the MachineState.
> > Being able to avoid just leaking pointers to objects like
> > that is one of the reasons I like having a MachineState now.
> The reason why this structure was removed was that it wasn't
> MachineState object but a random structure which was a common
> pattern in pre-QOM qemu.
>
> Code was allocating 's', assigning pointer to s->a10 member and
> then happily loosing both pointers in the end.

Oh, so it was -- I misread the code.

> I can convert it to MachineState derived board as
> an example to follow.

No, you don't need to do that, I hadn't realized it
wasn't already MachineState derived, because it looked
superficially like it was. Apologies for the false alarm.

thanks
-- PMM

