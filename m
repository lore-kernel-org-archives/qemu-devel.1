Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00024C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2DC2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 10:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrhJ0jrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2DC2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifLrZ-0006Gk-U6
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 05:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1ifLqy-0005oI-7k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1ifLqw-0003qY-UW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:37:51 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1ifLqw-0003m4-K8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 05:37:50 -0500
Received: by mail-lj1-x243.google.com with SMTP id d20so1672494ljc.12
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 02:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5SqIcgl9aAE6TWcTOYOiDMyzk/mR4NkfrL+RLRJKD3A=;
 b=zrhJ0jrk8v5e2O4535/tOC22kazrIMievOQeaiWJ+BlR4UVjsChlFbVD0HUP/xerlF
 3wBn6gl7CtLZNMLO+hWHrUxx7TlUMy+HaBVNYdFSjUevwA+HgtpDaR/FfWiBn+H3/er1
 Ir1JZ0uUzRwlVBp6+6TflpQV+NyONx/CUx6PfVtw8pha+1yrolweS7xYIjv4DlMP0k1P
 XOhV11uS5VZMIYGGOzwg0tu3/fO6zs+rszwaXK1aYekYsMbWaPyrGtTq3LYaH/mvE5iQ
 s9UeDa5n1umu6QM/E8cUVmJXwoUnqEmMp8bLHfDq9VdNK4nvCsZsWa5Hwgkt0RCw1ijh
 DpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5SqIcgl9aAE6TWcTOYOiDMyzk/mR4NkfrL+RLRJKD3A=;
 b=LWBEwS7vo4W2cWJUnSI2GBZ/P/yrd/1Gyx2KJe9olC4dSQWd7Y8m72CFJ6dqVkEbkx
 8gOFnVRTeU5vp6Tcfm0bzWBxk62GNkElw5qbH/ZLoIwxDVmGVJlM9P1oCNmPgQKoaZOr
 cdrfmqubRmn3iN6QMx/FKhsrK1wpizQLjvE63WTEFaftTUaHEpTM1RtvTNt+VOQDU6L8
 aS6EyeM3SnobO9D+561KKDMnvfgTswV87KRywy9I22JBUvPb0T14giK2fD/svaUnSji7
 jJ/+8CWrktPffp9ajo0WYfvVBKstFh+uyTat7fiGAYgpg+bZBGu9+r6BhWW5Ya6Cvqky
 8BvQ==
X-Gm-Message-State: APjAAAVBgFoYnNBMjJgVV3RK6d0YEBKJpd6ODrmknp3CZcxsHyL7wuZW
 Xhpa7TuHhjUM8npys8maM3l0ajckQ/9ExmhjycOFBw==
X-Google-Smtp-Source: APXvYqxXDWfApEe5saT3On7j10fORvpRuprInc2tRlPoCQ/N7PszanwFYUgT0kGoFWH15AGjzElKuVlkyQcfwIG8L6U=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr5366826ljh.183.1576147068543; 
 Thu, 12 Dec 2019 02:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-2-geert+renesas@glider.be>
In-Reply-To: <20191127084253.16356-2-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2019 11:37:37 +0100
Message-ID: <CACRpkdY18k7EXb_oMAYXM44jz4Oc+AtcNWZfStPBZ4K1TnZ6mw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] gpiolib: Add GPIOCHIP_NAME definition
To: Geert Uytterhoeven <geert+renesas@glider.be>
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
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
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

On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The string literal "gpiochip" is used in several places.
> Add a definition for it, and use it everywhere, to make sure everything
> stays in sync.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.

This is a good patch on its own merits so I have applied
this with the ACKs. (Haven't looked at the rest yet...)

Yours,
Linus Walleij

