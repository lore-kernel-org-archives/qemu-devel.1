Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BBDC31E41
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CB92085A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmA9yJ53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CB92085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haLTY-0007X2-I2
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haLR0-0005fK-Ns
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haLMy-0001rd-Er
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:33:57 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:38806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haLMy-0001pM-3R
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:33:56 -0400
Received: by mail-oi1-x234.google.com with SMTP id v186so6376550oie.5
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WyV7SvPdBu/PCWsfREdWW2CW3uuQ8vRJ6N3VfKz7wgs=;
 b=KmA9yJ53vV7DK8Gi6oMNwmqJljXOeYzNjaNh//TENB4IsbtV1rbvIoa1FBu4HdtWzI
 FqNUUetIFDqRzTLns9K47In3jegDtawtG/OfA4+npyX86/8yaJbrDPzq0WNKf6cNYIlc
 OWLhRPxvYB8yceQUoaBxqOgrRVb1ZDcxC1jLvUnLaY90j80Ec+SUu/nUzHcjuHXkVwn7
 P9dkIaQL2yOVIhsoep/8XlKDG/wnYJKCHy8Ouax4WycD0NGhgZlfgeHJGAtiErvlmD4i
 m2IHjJ/97qFeBDyDyFUpVnZNpF7zmvIzMgkv/B/8wHn2ONSiEfWDprzaqHh4ETEw/32B
 PxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WyV7SvPdBu/PCWsfREdWW2CW3uuQ8vRJ6N3VfKz7wgs=;
 b=WbFOVAiQnUI2nlkICuVopx15OBmLuDDDM601IIqYkRY8PoG19VgJqUUN3xvy03pcOf
 FCpwHiV42CPsGaB9bKRpR+0o0eXVVqW7K3SLTVvPvgBsM/tHbVwUqXdrXyAgALmZhp1i
 SU8MyYWIEA12aGZmK8TWlj+WLh9/YEBrUfUtnh+dcjQmOPruhMVbpn88nttSyp0lwhqI
 Hg9mO8Sz5fUgZLOI2IRx/wxKehOt/Mqgt38phMk9BuUZTJKrCWI1uAVdKB6dEir7KqhK
 1gEQbMguRNxvfRXJJCUWEL8DZfFuvg7QZwqRQmHvotnKn8e2bXg3uqzNY0EjZz0ECnW5
 WQyQ==
X-Gm-Message-State: APjAAAXBYWWj+hzgzTbVAXgHuNkwtICEfykDi3EFJWz12uJ/DHHY3D2h
 yUl9qznxu0gzaA6V5m3l1H0gJ5QPG2i2UQ/YkyfniA==
X-Google-Smtp-Source: APXvYqyfRL482HQKyeD9rBqHIhNuQYaX9N7oyFft62JcIspppqYmuaBgeN5wnKt34nMLs5flh9hjumxMfd8CIrUzNKg=
X-Received: by 2002:aca:c786:: with SMTP id
 x128mr11828886oif.146.1560177235151; 
 Mon, 10 Jun 2019 07:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAA2c-Xp3dAfrNV41UL=Jg--MuE3Nmsc=ZNE7JkMpJL8m6FVRJQ@mail.gmail.com>
In-Reply-To: <CAA2c-Xp3dAfrNV41UL=Jg--MuE3Nmsc=ZNE7JkMpJL8m6FVRJQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 15:33:44 +0100
Message-ID: <CAFEAcA9RjO_7uJAJAuSahBr2YcW1bsXHKf6Lpv=wTAndEDcVag@mail.gmail.com>
To: Nisarg Ujjainkar <nisarg.ujjainkar@iitgn.ac.in>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] Need help generating instruction traces from the
 emulator.
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

On Mon, 10 Jun 2019 at 15:24, Nisarg Ujjainkar
<nisarg.ujjainkar@iitgn.ac.in> wrote:
>
> Hello,
>
> I am using qemu based aosp (emu-master-dev branch of the aosp) to generate
> the instruction traces for android os running on the ARM architecture.
>
> I am able to generate the CPU instruction using the qemu invocation
> <https://en.m.wikibooks.org/wiki/QEMU/Invocation#Debugging> flags. For the
> purpose of my study, I need all the memory requests from all the IPs and so
> far I only have the memory requests from the CPU.

This isn't supported by QEMU's logging infrastructure.
You might be able to find places to add suitable logging,
but you'd be looking at modifying the source code of the
relevant devices to do that.

thanks
-- PMM

