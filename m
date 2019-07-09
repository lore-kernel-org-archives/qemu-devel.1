Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCBCC73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B0820651
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="roJZ0rhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B0820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkteT-000687-4j
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 13:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50135)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hktaL-0004HX-Ux
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hktaG-0006jy-K2
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:07:19 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hktaA-0006ci-Cr
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:07:12 -0400
Received: by mail-oi1-x241.google.com with SMTP id t76so15951594oih.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cS9iqPnFf/f8ixjaudjLolIR9G/QaJ05phEjjSxvs9M=;
 b=roJZ0rhCWPA20jjDPYubNT7hfcIxK+HZmsrgY8murJZfUu/klMArrHdWX8zyd/Y15u
 v9hIO5J+xc7BoKPisrErdiyMiOutz7u3B6jEmZizyNESEn2/k/X8g6Qq1FHzn5H/+zVS
 QteMvpJzJ5nH1EbNdsAZiVD0D+stfAUQB84l+rVy6cs2G+iPb1mnfwsDBtSG/pTn5aqR
 UOP1wNSEPh8K+WAWEA3gSBmb+3q1Fbq+3Fhx/KqbkcYfcNzO1v5DdJ32p13glulgFYL8
 VI6aG88KNc5Yc0YkS9ghAR6N2L8Wd9mi6ZbfYJQ1n7S/15seO9VLlj4XXGU6jMyuZ9QF
 PS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cS9iqPnFf/f8ixjaudjLolIR9G/QaJ05phEjjSxvs9M=;
 b=HlRgkmZwbl8uyAUE6UNP19CMfoxxLcV+5IfD9j1ikVfeEoferQFfUXVyvQjT7AgEBP
 PbrAZbMB9mQrs6PNyr4+LzLeJypsg8k2FXjmWcDB9eBwxsU2yUBGA1EZx7fjiFYcsdQ2
 5yhfLXRkuCKpRhXxKG2K2dcPck1SqIfr9D012oQEXbdVZ6fTc0jaEfgxKC1YLi28U5Eu
 Yea02XxN3yX9yjE3ip6VvDf0b5e0d3Yp0Wv/PMwm8UaJUO+ZQx4AR+dOJSObN4o8m5ky
 vxHwkC3CqthIBvWVtQFMbO/0n4fzF+/l6IBuPivF8lEakWJttLUiytWzNujUqmwvsdyZ
 bIMA==
X-Gm-Message-State: APjAAAUJuj8wpq1kkrBX4CYku3EkLUBlej/mRXr3PJY0lwKXM4WLdmsI
 CTP4noT3x3RKWm5Fk6Q3tmyu+YFmTA5b1NYhFHDY1w==
X-Google-Smtp-Source: APXvYqwd2gb16UwILKcA4ca9PGsyZ8lbXyGimVLCuG5yHD05WLBCszpX4HK5gljrHje9/1nSeg9rE6QR2d2Bd8CTKGQ=
X-Received: by 2002:aca:6185:: with SMTP id v127mr637259oib.163.1562692023714; 
 Tue, 09 Jul 2019 10:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
 <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
 <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
In-Reply-To: <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2019 18:06:52 +0100
Message-ID: <CAFEAcA8smaPX-h1qit=b14z_4JRuB-qF+U7TQNTJF+iWMOneFQ@mail.gmail.com>
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jul 2019 at 17:58, Lucien Murray-Pitts
<lucienmp.qemu@gmail.com> wrote:
> On Mon, Jul 1, 2019 at 9:11 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>> > Yes, that's a known bug for arm -- we treat "single step" as
>> > "execute one instruction", whereas I think most debuggers will
>> > treat "we took an exception" as a reason to stop the single step
>> > and return control to the user, rather than executing the insn at
>> > the exception entry point as the one instruction of the step.
>> > (You can see similar odd behaviour if you try to single step a
>> > load instruction which causes a data abort, for instance -- on
>> > arm at least we will execute the first insn of the data abort
>> > handler before completing the step.)

> As recommended in the previous email this is fixable with a call to handle debug
> when were in single step -  I will submit that patch if nobody else it working on this?

I don't think anybody else is, so go ahead.

> Any suggestions on how to obtain pc_next from the "m68k_cpu_do_interrupt( CPUState *cs)" ?

You can't -- pc_next exists only at translate time, and the do_interrupt
function is called at run time. What do_interrupt needs to do is look
at (a) the current state of the CPU and (b) whatever has been stashed
in the exception frame, and then update the state of the CPU accordingly.

thanks
-- PMM

