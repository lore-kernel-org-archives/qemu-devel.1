Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AE7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023CF206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHo4vUaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023CF206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1josDG-0005Zp-9G
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1josCg-00058y-1S
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:31:54 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1josCe-0006FY-6b
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:31:53 -0400
Received: by mail-ot1-x343.google.com with SMTP id n5so9364710otj.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cVT4MFE3mhEzGU4xpJZAgxUlBlMkqbFTX1eeNNTZMsE=;
 b=dHo4vUaJQdOL6b2ZcBdVG/cdLz33RPxAmHpZatkKHppweGw5MpCtGDm82ZZSJKD20E
 5HeTl/MR5oMgyVBpdp09WgEfFfefto4CZfVaBxHYWbDvJKj9mViD9ihHHDwYIl4QoTl7
 KeqATUo6sA2Msi6yIsehy8m7qD6YYzxgOZn257lRcBDU68zb6oMDccGMflsgZtbYJBp2
 4/jZA8JQ5jLgnAGFuEebglLcW2Eed7Snkq9UH5X4iLKRdgIcOTEx3/H5TpH74dNNTkUY
 kdt/oQX1Ovrojtdh8IqqF5zlqW0E+SXWw7H18XMAL77gZzj0Hk56KBSrI5szLhILczRc
 by9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cVT4MFE3mhEzGU4xpJZAgxUlBlMkqbFTX1eeNNTZMsE=;
 b=WbWxkuXgj/6K3OW06YMY74WlIU0Zh0AsQnbFoHQs40wcJii+X1OK0YHF8XSHjP89dF
 /B2l1NNjHQJZpBLVWtoRVoKJMfA/EbWE+KV96JHOoA/MZSg00AgfeWibEQXOngSmS4EO
 DaXvccKxWIF1yQbJY+JtetrWmAP1bmDs9CoZ+YTsqJlJooSQU8l0s4o5tH9W2RKWRaeo
 qdHfDP4ZQOHS/p4+NBNMmcP+6XiwTwMl5UcTUbERFfgkKgBa21evDYGY9451dHKkz3cY
 KK2cQVuB6g+3gpC1wrtsQ+rJnX1Eju7kCAB3xNawPsSwWl2dx32ZZYL0dKekWngjdJvS
 /sGw==
X-Gm-Message-State: AOAM530Wd8NmyzYKEK3f7W26/lHau3/GTDHGRMAiEmuh7Abs3DUlqL/I
 Nmktp4XwYYWhtHKxvwkJN4iGqoG9iUAQ3BuvRvH3iZlsBKs=
X-Google-Smtp-Source: ABdhPJy0HSwwT+Wut/aXPMVEUvInq6Dz5cIoDaHdZgM2EKxi3bcAqGVDB8Hxneiu1DE3EeSyM1Pz1zHrZNDumygry20=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr702069ota.91.1593192710529; 
 Fri, 26 Jun 2020 10:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200625230740.549114-1-keithp@keithp.com>
 <CAFEAcA9ut5CVAgRTP-_BK3WpiDSmitFowZMe549TvgSAjj+Kfg@mail.gmail.com>
 <87imfdixv9.fsf@keithp.com>
In-Reply-To: <87imfdixv9.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 18:31:37 +0100
Message-ID: <CAFEAcA_ZRMpqAhR7BL05a+O_C54fhXZn8-+kC_KUU5n3BpzoCw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Add 'virtm' hardware
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 17:40, Keith Packard <keithp@keithp.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > So, I'm really dubious about adding more "virtual"
> > not-real-hardware boards. We have "virt" because we
> > absolutely have to have it for KVM purposes; but otherwise
> > "emulate real hardware" gives us a concrete specification
> > of what we're trying to do and tends to lead us into fewer
> > messy swamps than making up virtual platforms does.
>
> It depends on what you're using qemu for. I'm using it for C library
> tests, where I need memory and a processor, plus the ability to make
> semihosting calls and that's it.

You might find the user-mode qemu-arm sufficient for that
kind of thing. I know some gcc tests run that way. You
get a processor, semihosting, and whatever memory your
ELF file's data segment says you have (plus anything
you care to mmap()).

> > For instance, this board model claims to handle the M33
> > but makes no attempt to set up any of the TrustZone
> > related components like the IDAU, so it isn't really
> > a useful platform for that CPU.
>
> It's sufficient for my purposes, if adding those things would make it
> suitable for more people, that'd be awesome.

Sure, but "machine-that-works-for-keith-packard" isn't really
a very clearly-defined concept :-)

> > This is the kind of area where having a real hardware system to check
> > against means we make the right choices about what does or doesn't
> > need to be present.
>
> I have tried every single 32-bit ARM emulation provided by qemu and none
> of them offer enough memory along with the ability to select an
> arbitrary processor. The stellaris code is the closest as it allows
> overriding the CPU type, and I've been able to run most of the C library
> tests using that. However, both boards supported by that code have a
> small fixed memory size, which isn't large enough to run the full test
> suite (the math tests require over 1M of ROM and RAM).

> Instead of creating another virtual platform, should I be working on the
> existing virt code to add cortex-m support?

I think that trying to weld M-profile into the A-profile virt
board is likely to be more confusing than having a separate board.
But I remain unhappy about defining a virtual board at all
if I can avoid it.

thanks
-- PMM

