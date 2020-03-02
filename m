Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AFEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D05320873
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVkZccG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D05320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8t3H-0004qL-D9
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 16:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8t2a-0004MI-BB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8t2Y-0005J2-Jr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:55:55 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:43146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8t2Y-0005I7-EB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:55:54 -0500
Received: by mail-ot1-x335.google.com with SMTP id j5so885480otn.10
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dxxq1riCoaMO68tNmZ4BKbhiPk+kVhbeqK9VSzGBoRA=;
 b=sVkZccG40ZrE1FXzhbT3ptcYYKCkJM/7h0YNZM2HGmYOd3tFVehrmj0IQsAzYlJIi5
 WGSSpZrfevP4CbT/5QngngPgBvnT+oy5xDJF/PBVgNh5j8Pvm01OmUIQ6XRW9H8qMF8b
 189szYLqQo0dWw2SdNt0GXOAaBLEazXVjhtYJ+wTTLQQ0pivRBmJldt/oqEtF83WTdiY
 XPtBNWFwVi9FKoVEvLipqyvf4cGiv+QxYEXhT0wYLLMPgn+xG7YNfXtwjWrNXMs7TExh
 ritpS4N/j1DsDI8DfeHhsYBrC0JtjocQLXauX+6MJW9BTr3utVS72da+MLMKiUE5JZqv
 FD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dxxq1riCoaMO68tNmZ4BKbhiPk+kVhbeqK9VSzGBoRA=;
 b=U2TK9PpTGxwLnic5ve8Usxd4pmVRTR/ssIXlmkeVnRam4kK7HLP/srH6fz487HJIrt
 wk32rZAo60xgiwoslxuqy30ZBBkhRMaYlmIfibhQP5L+OPQ/VzPTSeXZ2K9ZM3cYJjE/
 AaldiRiptea22vYnpMuiM/fVdeGcOdjbc/WOWrg6rfdUmsYBfCCIR1AjWYHyPrfAO5Zp
 F3rF9b/dw7zDtV1HUI82C0IEy74SAk1W9gYpsN2EL4le3H1mBhWZabA28A7UVKa0gMX6
 NJ/VzwERVs8kvohvy2TqIeRbIVmJ/HH6DrseP6i1rhgNz05TfoPyrKb8jJWPSO6RFwII
 UcJw==
X-Gm-Message-State: ANhLgQ2nQn4YAlEI1kSxFT/6N6dQ16ODgkYF4Q1JwyUNn51japSiCtkA
 a8+8SEyAtJ9gFS7gsFy8p09dPWOf18ly3i87ktiLwA==
X-Google-Smtp-Source: ADFU+vtuN3rmfQO7XDOrzSfONWltDfGwkG5B5uTO9pgmrRYEPaOVYWQYhhvlzUo6+6HPg53A9LCXSmKhQlT7KxWs4Kg=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr992149oto.135.1583186153313; 
 Mon, 02 Mar 2020 13:55:53 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
 <20200302174551.GK4440@habkost.net>
 <CAFEAcA8AY4ZPuWh=oPd4heepAAZziLP1DLNHhrC_3jLuMXnBcQ@mail.gmail.com>
 <20200302214036.GO4440@habkost.net>
In-Reply-To: <20200302214036.GO4440@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 21:55:42 +0000
Message-ID: <CAFEAcA_4yf6+BujSKEpX6TwTurE_GP5vOZ16OnfsQP10CAWeMA@mail.gmail.com>
Subject: Re: CPU reset vs DeviceState reset
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Mar 2020 at 21:40, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Mon, Mar 02, 2020 at 06:41:31PM +0000, Peter Maydell wrote:
> > On Mon, 2 Mar 2020 at 17:45, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >
> > > My impression is that this is just historical legacy, but I'm not
> > > sure how much work a conversion to the new system would require.
> > > I see lots of cpu_reset() calls scattered around the code.
> >
> > I think we can just make the cpu_reset() function be a
> > wrapper that calls device_cold_reset(DEVICE(cpu)).
> > We would need to update the prototypes for
>
> [1] This might have unintended side effects, as it will also call
>     cpu_common_reset().  I still think we should try it.

Yes, but cpu_reset() ends up calling cpu_common_reset()
at the moment (every subclass uses cpu_class_set_parent_reset()
to put in its own reset implementation and save a pointer to
the base class reset function, which it then invokes from
its own reset method). A DeviceClass::reset changeover works
exactly the same way.

(I have some working code for this, just need to test it a bit
more and satisfy myself that there aren't any weird places
that call DeviceClass::reset on a CPU object and expect it
to be a no-op like it is right now. I don't think there should be
any since a CPU object is never on a qbus, and none of the
direct calls to functions that do device-object resets are
dealing with CPUs.)

> > At least for Arm CPUs, I don't think it does (well, it
> > has the default DeviceState base class reset method
> > which does nothing). Is there somewhere I missed?
>
> TYPE_CPU points DeviceClass::reset to cpu_common_reset(),
> so I believe this affects all TYPE_CPU descendants.

Where does it do that? cpu_class_init() sets CPUClass::reset
to cpu_common_reset and doesn't touch DeviceClass::reset:
https://git.qemu.org/?p=qemu.git;a=blob;f=hw/core/cpu.c;h=fe65ca62aceef581d4d9ef3cb9e1b0d7df4e5bfa;hb=HEAD#l416
(the two reset methods have different type signatures so
you wouldn't be able to assign cpu_common_reset() to
DeviceClass::reset without an ugly and undefined-behaviour
cast...)

> > (I'm currently attempting to wrestle Coccinelle into
> > doing the conversion of the target/ code automatically.)
>
> I see 3 separate problems we might want to address:
>
> 1) Making device_cold_reset() end up calling CPUClass::reset
>    in addition to existing cpu_common_reset()
>    (easier to do without side effects).  This would get rid of
>    the custom reset callbacks on machine code.
>
> 2) Making cpu_reset() call device_cold_reset()
>    (will have side effects, needs additional care[1]).
>    This would make us have only one method of resetting CPUs.
>
> 3) Replacing CPUClass::reset with the new reset mechanisms..
>    This would let us get rid of legacy CPU reset code.

My work-in-progress patch does:
 * cpu_reset() calls device_cold_reset()
 * all the targets, plus the base TYPE_CPU class, implement
   DeviceClass::reset instead of CPUClass::reset
 * CPUClass::reset goes away entirely
It passes 'make check' and 'make check-acceptance', so it's
basically right, I think.

Note that this does not do anything about the need for each
machine or whatever to use qemu_register_reset() to arrange
to call cpu_reset() -- that is necessary because CPU objects
are not on any qbus, so they don't get reset when the qbus
tree rooted at the sysbus bus is reset, and that doesn't change.
That's a different and much trickier problem to try to tackle
(I don't currently have any good ideas for how we would want
to approach it).

thanks
-- PMM

