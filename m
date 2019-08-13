Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390EFC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D602067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxgn8f7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D602067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxTsE-0004BO-CM
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxTrN-0003Nq-Ow
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxTrL-0000B6-V5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:16:57 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxTrL-0000AK-Q1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:16:55 -0400
Received: by mail-ot1-x343.google.com with SMTP id k18so38263232otr.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oNwStrN+/EsnU4MA8wxhsySv/IFe0kuMTJLQOEkXquY=;
 b=jxgn8f7Prkf+EIID06Cmy8fc/MYgbfJjlgR9ywFY8GsA3LFVapPiy/qECm5TvvsTTD
 /HB//Cj5ah0mrYn2rx93CDxV8QoDT1oOkOpWY9VB57ueF9LPWhgaBd9Iw7w284+aUE0t
 UOUzbaZi+MAjg/ZfzekHQhe3mbvmIHLoaoDTcdpOKFvB5QniOolYIgQAlIfsrYBa4XK6
 hqoNSi/RgcEQSMa7YjUDO9Q2A1Vs/Waxz2SqeH9jRBFyO9oxS1USghmI3M43Lg8kUXTc
 hmQ3KHkcgV0jk9grk3jxlTmgdVHRUo1EcJdY5NuwuG8cmpN5q65/fhyNI8nPzBh7rQav
 tqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oNwStrN+/EsnU4MA8wxhsySv/IFe0kuMTJLQOEkXquY=;
 b=nxc5zpHSR4y/Hvnn6G2dtXM+6KTZGeo4+gjKlrQV34ua1ceXxfS54xe9aK6YYPDoTX
 sgW1VE95+IM/9Fe6QF+1YXuNF7O/rY7RP7UjRK531HQbCl53xvmkEoSGvnxbqhxVlUxN
 9aQFbSPwDK4zANpgA1Q4kPsen23MTSgjRt27VyJC2qt+y4hRuiwiclCPlXYA6OtM1sVx
 uSqbdUhSZHiqRERzIa86GhbDD2HumR97yIps9qW62HcD3Sae7HegMaWflZSAO8+LSaY5
 TePROqybApE6h6a8uAVpkG9EDyCnpEWNHQ9qwqtkre4OWEAU48HutYuSNQFuDN58q0QA
 xFrw==
X-Gm-Message-State: APjAAAX0L5YxyOsMlu1EO4sdV4XgCywXSXgJVWz0GUHG5VzKyvrbnW4L
 0XruDMahTSIkA08swf4Nrvtw1j3OZtGhWKFF6nfAPw==
X-Google-Smtp-Source: APXvYqwOtTi5RlMLMNztk6dEMFrAXykgCiNvkFRBUsle6C/bt7kSESzaeu3QI787ysrVCKIESLnuEoNKA2zoSTzIt0U=
X-Received: by 2002:aca:6185:: with SMTP id v127mr991337oib.163.1565691414741; 
 Tue, 13 Aug 2019 03:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190709073222.26370-1-huth@tuxfamily.org>
 <20190709073222.26370-3-huth@tuxfamily.org>
In-Reply-To: <20190709073222.26370-3-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2019 11:16:44 +0100
Message-ID: <CAFEAcA9uech2_Uc1XnxSm8Dk2rEAuyvxtnH74e_oCgw7ovVCaw@mail.gmail.com>
To: Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v4 2/6] m68k: Add NeXTcube keyboard device
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jul 2019 at 08:35, Thomas Huth <huth@tuxfamily.org> wrote:
>
> It is likely still quite incomplete (e.g. mouse and interrupts are not
> implemented yet), but it is good enough for keyboard input at the firmware
> monitor.
> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>
>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-kbd.c
>
> and altered to fit the latest interface of the current QEMU (e.g. to use
> memory_region_init_io() instead of cpu_register_physical_memory()).
>
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> +static void nextkbd_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +    dc->realize = nextkbd_realize;
> +    dc->reset = nextkbd_reset;
> +}

This one definitely needs migration state...

thanks
-- PMM

