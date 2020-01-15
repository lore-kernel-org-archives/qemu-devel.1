Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FD6C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B532187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSv9Z1rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B532187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhNZ-0002y4-UK
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irhML-0001wm-SY
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irhMK-0003Vu-Pr
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:01:17 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irhMK-0003U7-Jb
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:01:16 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so15400363wro.9
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jgLIybfd4cvMOOCKA2HZPMjU82OQBor48llZsuJcEBU=;
 b=mSv9Z1rccBbo319qom1P7NXY9V1XvtYkjXYNzWfhPX+AUjLc4klqux1rQOcEUoiHXJ
 hWf+20H3CwmnjqNVxi2mrPdybzlxGbZKzLE2QoEKAR0ppgpF2FHTUxSLq/nsH99sndPW
 x+27uRJwrw3ZWhXgw2efEUaXyI7li6W7qipmX40XkU3pJQyJdacRJWrlbiqDWVd6vkY4
 yFhfe+Rh2GF4fiNFFu8mTmJUiWilLFo9ZgWNtZAznwpo7UvGYOgxsAdLhXLB0kzgeGEk
 mogJ8RQArZ9I0FxDn3raKP28W1LZ5K9SNJWurnkYDerhQ1UOd8dC/3Wi+zF2Irr34CBe
 Yh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jgLIybfd4cvMOOCKA2HZPMjU82OQBor48llZsuJcEBU=;
 b=pW5O517jjvy8rwh1JjygcOFNjQ/UrBqf7sNAhVZAvWVV+xuHpfD8u/OYz5MYAfkzjK
 2X3ggFx/9TrfaiAltqBj9JtdKrYZoBd8XSTNYt84+tkeLf8EjtqCfbK41hWXVR25eNQt
 zX5gSLoWwjXJpxDEy9skJFFbyThcEFpZV9PYXTCRZpoSXNo7Xf0SsfEolbcN/xj4hPXy
 B7yIFK4N1hUiNbKcJEP0kpUOasI8ZYDWFiG51n6zK2LnYOAgWufrthP14b4fqtyAmTb/
 aHfStaPGnBFlnslSfO6y91kg/W6PbaepQYQvJDOjbot5Ygm1+5l4GPwOshlrfG0kiD65
 aCSQ==
X-Gm-Message-State: APjAAAV3MD0BvPP+dWMH5bGAYWC3m1HZ/r0PTm9N6shOHXboiBivrWTo
 HM11QM0bzZwozf1783WEo3tmgQ==
X-Google-Smtp-Source: APXvYqwZ4EpVv36doa86mU1mmWBgXC+Kdt3F9Vp5oZrj2E+yP4QXXCZYGKbepE4eoQFkeDpdWknM0A==
X-Received: by 2002:adf:a308:: with SMTP id c8mr30207481wrb.240.1579089674043; 
 Wed, 15 Jan 2020 04:01:14 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n187sm23393313wme.28.2020.01.15.04.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 04:01:12 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 356D11FF87;
 Wed, 15 Jan 2020 12:01:12 +0000 (GMT)
References: <11d88b2741eac3f634d5aed9e3355c974b533f7b.camel@kernel.crashing.org>
 <AE7841A1-B4D6-4D6D-9AFD-01C4604D7BC4@livius.net>
 <cd9a2de94700a2781f176247131dceba690d8f31.camel@kernel.crashing.org>
 <87sgkimkma.fsf@linaro.org>
 <1309ca0ab6405d88cfd949c73130ad0f2af944a6.camel@kernel.crashing.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Semihosting, arm, riscv, ppc and common code
In-reply-to: <1309ca0ab6405d88cfd949c73130ad0f2af944a6.camel@kernel.crashing.org>
Date: Wed, 15 Jan 2020 12:01:12 +0000
Message-ID: <87wo9tkjxz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Liviu Ionescu <ilg@livius.net>, keithp@keithp.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2020-01-14 at 09:51 +0000, Alex Benn=C3=A9e wrote:
>> > Well, one of the LCA talks wasn't that interesting so I started
>> > doing
>> > it and am almost done :-)
>> >=20
>> > I'll look at doing something for arm, riscv and ppc and send
>> > patches
>> > once I get it working.
>>=20
>> Cool. Are you considering linux-user as well or are these only things
>> that make sense for system emulation?
>
> There seem to be some linux-user stuff in there, I'm mostly considering
> whatever ARM does today but we can certainly extend later.

Depends on if it is to be used. AFAIK the main users of arm linux user
are compiler test cases for M-profile CPUs.=20

> The idea is to make sure ARM, RiscV and POWER use the same protocol and
> code base to make picolibc (and others) life easier. Bug compatible
> :-)

Hmm, I'm not so sure. QEMU tries to emulate real HW although I
appreciate that is a somewhat loose definition once you get to things
like -M virt and other such SW like abstractions. Is semihosting even
going to be a thing on real RiscV/Power silicon?

>
> Cheers,
> Ben.


--=20
Alex Benn=C3=A9e

