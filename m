Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A2920679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOPRqMjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A2920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO3BH-0006AP-TA
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO2mZ-00042H-Rh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO2mY-0004DD-28
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:49:47 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO2mX-0004Ci-KP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:49:46 -0400
Received: by mail-oi1-x244.google.com with SMTP id c2so2014848oic.13
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VoZbl5OxKxZPuFiNKqwKOiwQuGJcnCnPWMqR6+Ad2XU=;
 b=MOPRqMjOk+pR7H72nrCVTN9Wh6hU/2M5x4S8o1wzq6qkaNmfjDXaO7JvlQ7zganTlE
 Am1Jr0rGi9j+iUXKcfJlHZGMmG/CAqrCZO80lATFeNFLkWnfnzfzqY8WQ2KFht0+KFM8
 Pxyv8Zt4NuSw8CEwfnWOrq803kroSpcbeXnVIqax+4r5gvfKx32GcMHBmcY1W1ECh94H
 LLFcGQrtjKUgSNv8LuPPevbLA5bg2nPejmr18c7zHqPw/Si0cod6AJ4tWWtCAU8pZRPo
 QhcuCzw2hZM7gZEisHY4bm4F2LfO0anSZyXPLjCqkHh1TMbeN4AXN5VhD33MHEbjQMaB
 F4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VoZbl5OxKxZPuFiNKqwKOiwQuGJcnCnPWMqR6+Ad2XU=;
 b=pQ8AvRSCJebmdq38fLxASwZSeLP97kwl9x3B3fZ3gCxvXjj3i7Bx0CEXkQlQyomslk
 HHHvgHX78rtTobWlO0cuWxqyPXUahOKR1rtLTjsRnd5/5mn1QcNUe/wb1sDfaXpwlM+V
 QXQQtMN5lwMADPKXAqayBwcISZ/iRP2sHwpPdbUIJnRc12SJckkyslM5fAYvPRnw/ApS
 kOGrsME7tjkLtcqESKjdAnS6T8oemTqTE8iUQAJxep0bnMIr28DhygzWD4XfzctM1M4v
 szIQdbF+cxYofh13tMlv9AqA37Gik7DqO9Qsx7EYhB7Of7BcPJYvYAKNq2lWL3IEl77S
 /M6w==
X-Gm-Message-State: APjAAAUgxxApOKRLcrVX0KFKMS2pX55rP9XQayVf/KnPEVfTuiYTc/m7
 uQ5N5RKaMBoCkH/0zS9RQSsKbiLVfrKSpwkADboOIA==
X-Google-Smtp-Source: APXvYqydKDV4+7MmdGyNc4Puzjuk7jppiAoFaSfx5WYfLKOUYA8CsC4BLsMdXqqFD+HA7yAjKeOqOPxKH5LRSWZtxB0=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr3201089oij.163.1572022184584; 
 Fri, 25 Oct 2019 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
In-Reply-To: <87pnik4w9n.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 17:49:33 +0100
Message-ID: <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 17:40, Keith Packard <keithp@keithp.com> wrote:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > I can see the use for this but I'd like to know what you are testing
> > with. We only have very basic smoketests in check-tcg but I've tested
> > with the latest arm-semihosting tests and they are all fine so no
> > regressions there.
>
> I'm adding semihosting support to picolibc
> (https://keithp.com/picolibc/) and need a way to automate tests for it's
> SYS_READC support, so eventually I'll have automated tests there, but
> that depends on qemu support...

I have a cheesy-but-functional set of test code
https://git.linaro.org/people/peter.maydell/semihosting-tests.git/
here, fwiw.

> Argh! Just git operation failure -- I'm building another patch on top of
> this (for RISC-V semihosting support) and the stubs/semihost.c change
> got caught in there. My overall check for changes missed this mistake.

Is there a specification for RISC-V semihosting? This is
likely to be my first question when the support comes
round for review, so you can have it early :-)  We'd
prefer to implement specified interfaces, not random
ad-hoc "this seems to be what newlib wants to see,
which is turn got hacked together by copying some other
architecture's code".

> Here's what the docs say:
>
>         https://static.docs.arm.com/100863/0200/semihosting.pdf
>
>         Return
>
>         On exit, the RETURN REGISTER contains the byte read from the cons=
ole.
>
> If this call didn't block, they'd have to define a value which indicated
> that no byte was available? Openocd also implements SYS_READC using
> 'getchar()', which definitely blocks. So, at least qemu would be the
> same.
>
> I realize it's really weird to block the whole emulation for this call,
> but given the target environment (deeply embedded devices), it's quite
> convenient as the whole qemu process blocks, instead of spinning.

Yeah, the docs could perhaps spell it out more clearly, but
the intention is that the call blocks.

It's possible if necessary to implement this so it doesn't
block the entire simulation: you just have the QEMU implementation
do a block-until-character-or-timeout operation, and if it times
out then you rewind the guest PC to point at the BRK/HLT insn that
triggered the semihosting call, and resume simulation. That would
give an opportunity for things like interrupts to fire before going
back into waiting for a character. This feels to me like it's a bit
overcomplicated unless it turns out we actually require it though.

> I also thought this would be a nice cleanup. However, the last caller to
> qemu_chr_fe_set_handlers gets the focus for input, and connect_chardevs
> is called before the serial ports and monitor are initialized, so
> semihosting gets pushed aside and stdio input ends up hooked to the monit=
or
> instead.

Isn't the answer to this "don't use a command line that tries
to connect stdio to multiple things" ?

thanks
-- PMM

