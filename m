Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBBAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B4F21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCFmmoTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B4F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPg5-0007EM-KB
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1ifPfT-0006nG-Nw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1ifPfS-0004ff-Mk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:42:15 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:33119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1ifPfS-0004cq-DC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:42:14 -0500
Received: by mail-lf1-x143.google.com with SMTP id n25so1911867lfl.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tZEozXho8/b7kOqmVnapq/xyhPGY85u/Fazs9Eblm1E=;
 b=cCFmmoTXOmDLfgP+nSgeOYumVAZUrCnARZzWT6kYYgCKF1bePY08qH25uoDIaIHIIP
 xy8kMJ6JQ2UyEvDyewbvtPrrH9UtNKJVImB4NokJIoH/R67zMUh04sKFC2b9DZZNNYUs
 aUGcMes7TUb5SFaiVdEGG5DyRqBgacd0FAD4lAf+ICRsdMe3e2j3QZ8mi0budLFypHnU
 Q9CAtFfX69QmpkYitVwIFJ08foJUmu7rOTj1ckh5yeQ90ov1O2obpxX2rMKf54BvokNm
 ude9UZXPiRBYKsQ2CDcY3DczzV6WI8NM6/9D9PHWpM76xo1IPmfR6iBERCj82PcqPI0L
 ppSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tZEozXho8/b7kOqmVnapq/xyhPGY85u/Fazs9Eblm1E=;
 b=P35woZ08411FQ+qS9D2E/D6G1lO0qjhASi3ihwBuG3Tn2FoQ3zBb6lGtVsOy7buha9
 5wxtFAZdKIMuo98cxyy35p6JSMZKAEhjb7f/DzAnAkiRpKhnOZnUpQwd5XcsMkXKkDIN
 zikTXZ4AqorybryT36ngytKRwHljPYOJyz1Dymgr2UsB8ojfpQf6eB945V6808eCu5rZ
 ouvYr4+q82LgzLiHUhpxzlF5m0DirBh5chX8/FWKbyCX/b6XZEFYHo2qLprbYGuca5hQ
 mgjYwP6r89DXxtgot1JX8SmKgyAnJUnX8i+CqHjXcKYcnDz1t4Jh9sn17YjgX1OGFx3W
 3HEQ==
X-Gm-Message-State: APjAAAXp6QxCLXAPsPS8X0ujTMeGpnV7sQ82iJLp9GdsMifsi5QPnawG
 6tr1pNhAMHyhCTLgIrQ53T3WyaaTNliLga7ejRV6Zw==
X-Google-Smtp-Source: APXvYqzNd5E12+tK1syFHjNwCOV5eMNSPBpGptit7BvfAlgSkslbOpdSmdz3b8GlBGkJlIqKTDmvgy11rgnCB3iAN8w=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr5702467lfi.93.1576161732769;
 Thu, 12 Dec 2019 06:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-7-geert+renesas@glider.be>
In-Reply-To: <20191127084253.16356-7-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2019 15:42:01 +0100
Message-ID: <CACRpkdb1XZAeSThxWmJtnm80T4aPufXV2UvJdVdgnw-TJe3trg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] docs: gpio: Add GPIO Aggregator/Repeater
 documentation
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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

> +The GPIO Aggregator allows access control for individual GPIOs, by aggregating
> +them into a new gpio_chip, which can be assigned to a group or user using
> +standard UNIX file ownership and permissions.  Furthermore, this simplifies and
> +hardens exporting GPIOs to a virtual machine, as the VM can just grab the full
> +GPIO controller, and no longer needs to care about which GPIOs to grab and
> +which not, reducing the attack surface.
> +
> +Aggregated GPIO controllers are instantiated and destroyed by writing to
> +write-only attribute files in sysfs.

I suppose virtual machines will have a lengthy config file where
they specify which GPIO lines to pick and use for their GPIO
aggregator, and that will all be fine, the VM starts and the aggregator
is there and we can start executing.

I would perhaps point out a weakness as with all sysfs and with the current
gpio sysfs: if a process creates an aggregator device, and then that
process crashes, what happens when you try to restart the process and
run e.g. your VM again?

Time for a hard reboot? Or should we add some design guidelines for
these machines so that they can cleanly tear down aggregators
previously created by the crashed VM?

Yours,
Linus Walleij

