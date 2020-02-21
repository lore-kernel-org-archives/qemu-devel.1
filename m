Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33460C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE5F24650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE5F24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BNG-00065q-8m
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1j5BKu-0003mK-QR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1j5BKt-0003zb-NL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:39:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1j5BKt-0003yx-IY
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:39:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so2502556otp.12
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4BgZBtTDREnYAapVdHrqgQ9W3R4CTcWbIkMjaCPQlXs=;
 b=KXUVpLbi3u3qAL/PfQGiydOxkmaeXY+F9DSerLxflqhSj09QHARVAssIHY0+9Jmsid
 1tM13M/mgK1t2SB2yoyjVvErcCjhkroBJGxp+Yvoy83b4A/dmIAEWW7Sx37osHN4T6e2
 7vFXYjBJEZle2TG/njMEu9V2tg8HPIuaUAWCXbsoB/2I+teQ5tPqKIR3PQWWObh7T26c
 7DfGfXoklfxt9ttEj1ZmJk7VvF25OSBELwtPPeFJG8IAsOmqoxIgO3Rwcyy3/cbCSIZU
 wWPYnt22r6s3oqC79IJos5rB/7lrWmOHjf9x5vCxJxYvPoHjiX590RpeK1typBh5seuD
 +qPg==
X-Gm-Message-State: APjAAAUPVyrepWU7JHB+2bL6/jqsPf3FQ1LqPyiUs1D1v3ABbF59fJ3W
 e6YgPmR+L60rJezAM6YwwGmDCNYTp4YjsVkIvuQ=
X-Google-Smtp-Source: APXvYqyHdwKbUhPCfLeqiqCgnHSzlLvGxUb88yDmpTUxNb9KdZfgkLsmdvKxBtKDh+BkPpxepYgxvBCP9OOjR7Ep3ks=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr29016938ots.250.1582303170916; 
 Fri, 21 Feb 2020 08:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
In-Reply-To: <20200218151812.7816-1-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Feb 2020 17:39:19 +0100
Message-ID: <CAMuHMdWo_JBpBeS72RkZBwuWyMhMj79=9ErFdXcLSqC2rOhJDg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] gpio: Add GPIO Aggregator
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.67
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
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Linus and Bartosz,

On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> GPIO controllers are exported to userspace using /dev/gpiochip*
> character devices.  Access control to these devices is provided by
> standard UNIX file system permissions, on an all-or-nothing basis:
> either a GPIO controller is accessible for a user, or it is not.
> Currently no mechanism exists to control access to individual GPIOs.
>
> Hence this adds a GPIO driver to aggregate existing GPIOs, and expose
> them as a new gpiochip.  This is useful for implementing access control,
> and assigning a set of GPIOs to a specific user.  Furthermore, this
> simplifies and hardens exporting GPIOs to a virtual machine, as the VM
> can just grab the full GPIO controller, and no longer needs to care
> about which GPIOs to grab and which not, reducing the attack surface.

Do you have any more comments, before I respin and post v6?

Thanks, and have a niec weekend!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

