Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0765C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 23:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7978020692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 23:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4oiBbU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7978020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipKVx-0006Ct-Kd
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 18:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1ipKV7-0005l4-Vp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 18:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1ipKV6-0006x3-Nq
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 18:12:33 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:41896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1ipKV6-0006sW-G4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 18:12:32 -0500
Received: by mail-lj1-x243.google.com with SMTP id h23so5097129ljc.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 15:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9PdCnLDfRrpTe57HbjA01QxkIMaIeln31WkhfMvjiwc=;
 b=s4oiBbU1nrcXdyE6ajcf/7ipB/YOE89ljAV/j8S3V1GrEIqoBOr47JYnVmEsKRV8GJ
 m4q0+MdmjmzPl9uXRDzb5Amt57zy3bc3WxPF0K5yDX2VpMdCN/AhXoZnSdWYKA7heegf
 wRS55OdtQNKvabxlFMD4rrY3EAmDaAyQ/BZXlmPZ0CYqE3Lb2AxGF4u8Wn6qmi2T8j5O
 cdnewIk+KP+Htuwy0PgAnh2udE8rVTcaKVrkgALjESDjkQ3mY3GfGNqQXizf+0ZMl2Q6
 vXSmyvELflYoWLjnjXyFw556vBiDknK3YpTds+gEithiEvcry2P64oYpOGLedDWey+af
 esbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9PdCnLDfRrpTe57HbjA01QxkIMaIeln31WkhfMvjiwc=;
 b=eaD2ZigT1Wxy2sKU3QpOv0+PpkMHGVZsWJnD5RL9tVXBpBlT+CRw07ODnue+fHvejz
 q7bswtIQiVMBh8pPi+wU8e/OdbFEnqhcSYE9d+wQtVogrF0RzZSmqE9pBqzx2Qar+8JC
 fmAbw0JN6SZtWUDM1JvAC5xORK0IrPIvpXd9L6D7RwqinTwNGiDsOlBO6cQSxikQ4k+z
 4eCtz0LFo60gwEkhL/y+IQ0iUrDrwlZ1coSSbPzfkhuI9xSAdywkWSqsSz9D/HluHY/k
 A3MmOeBU5Jw4KrusFhOO9HNArCriHK3tXEimoOyzkzY0lnyV3BQwvks4jKIOnsaCBzVv
 pTJA==
X-Gm-Message-State: APjAAAWqYQ80UBWWgvEW0smxmYL/USMsFHycMgu3sSuHO0F8wiei+q4q
 AYiGGUof+JM/x1pvRcrAMiJiRjVVGldP5xDGEnS2OA==
X-Google-Smtp-Source: APXvYqzqb9iQtaKF+nk9oiPjLBxsjLdTUTmVU669xZcPD3ecVDu582+r9iYp2mPEVpHt4i81yKoxko8lyI3k7+1q8V0=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr4342769ljh.183.1578525150247; 
 Wed, 08 Jan 2020 15:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
 <CACRpkdaW7nmpE99FAvBDBTmkTZOTQ5WdM=JbMzBTLk7cbLRXPw@mail.gmail.com>
 <CAMuHMdVbk5S__8OK-zNXmiW66=WVA8Jzyc=hUvf_hJSU=u9TFg@mail.gmail.com>
 <CACRpkda8QD_tDA=YVDRNVnHd8QHs-yHBTzZuJHsnocgMdxv9cA@mail.gmail.com>
 <CAMuHMdUGGcjoX8TDDS5qGLtJZxizUK=BpasSQK3t1K-dhEgZCg@mail.gmail.com>
In-Reply-To: <CAMuHMdUGGcjoX8TDDS5qGLtJZxizUK=BpasSQK3t1K-dhEgZCg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Jan 2020 00:12:18 +0100
Message-ID: <CACRpkdZYFx3q=eS=y50hsQY5v5EMY-0XmyHsUQRczrS6PRN1+w@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 6, 2020 at 9:23 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > The rest I think we cleared out else I will see it when I review again.
>
> The remaining discussion point is "GPIO Repeater in Device Tree", i.e.
> the GPIO inverter usecase, which might be solved better by adding a
> GPIO_INVERTED flag.
>
> Shall I rip that out, incorporate review comments, and report?

Don't know, if it blocks progress I guess the diplomatic solution is to
do that, divide and conquer. But review is a social process so I don't really
know the right strategy.

Yours,
Linus Walleij

