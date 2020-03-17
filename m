Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF74C5ACBF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9F4205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9F4205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE7oF-000729-JR
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 04:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jE7nU-0006de-V9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jE7nT-0000BM-Q5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:42:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jE7nT-00006J-M0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:41:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id t28so18150672ott.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 01:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8KAPg4bTos1rY9vws0C/xCO+F9oh55hyP0CnonU852I=;
 b=g5uOC8sw/Z0RvLGOEnkVvpk3qIFpOZO37vgxryIyUanw0m8QSjoI8EnMjGglh5UUnV
 av85BpkbY53lcyYoLm51NtBzxx/CuxGOn0v/LxMWuUcbiS+Z3tBsI/mCBto7P3H96mno
 mxFI98zZUzh0lhghvJpuVcfcYgNEXPnrA0mjy/p3SgHpHsO9i8506vwEUye+tVeyN9PY
 aVaeK2Jo8xQk2Yj0P6xZchJWKP0uFwixUPXIGfco8LkbeVRB8U11njkBNzLC0wSQ1zKR
 hBemY1lc4NZvY4IGdaaEvePdVuzoR+uuOX6w3gizff2pRs5X+/YMcbXZkNOWMrxRB3sR
 6wVA==
X-Gm-Message-State: ANhLgQ2fUVfVHOGdij2aL04JDCMsJ7cqUMeQrqBpnRKsh/sKRVfBtK94
 N1beCqJA3FFSdc3GWMz8tN/xR/T7+ZmMCICfRpA=
X-Google-Smtp-Source: ADFU+vvJp0nv92HoVayJxMdw/lQoVKJfhGofeOWGjeWQZ4VsyHP2OYzQFJDW/aLh70OIkdl5GYBag7ZinGzuIjBpa74=
X-Received: by 2002:a9d:8d0:: with SMTP id 74mr2800645otf.39.1584434518599;
 Tue, 17 Mar 2020 01:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-2-geert+renesas@glider.be>
 <CACRpkdZGKB9opaOFT8Yz-tfE9vcCVeF9EvvBi7jWWuAAh3C_FA@mail.gmail.com>
In-Reply-To: <CACRpkdZGKB9opaOFT8Yz-tfE9vcCVeF9EvvBi7jWWuAAh3C_FA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2020 09:41:47 +0100
Message-ID: <CAMuHMdVM=F_p0L24shstWbQSur7JJ6irVBiugxxqKsky0hxdAg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] gpiolib: Add support for gpiochipN-based table
 lookup
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.68
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
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Linus,

On Thu, Mar 12, 2020 at 3:23 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Currently GPIO controllers can only be referred to by label in GPIO
> > lookup tables.
> >
> > Add support for looking them up by "gpiochipN" name, with "N" the
> > corresponding GPIO device's ID number.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> > Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
>
> Just like with patch 2/5 I have the same problem here that
> the commit message doesn't state the technical reason why
> we need to change this and support the device name in these
> tables and not just labels.

As these "gpiochipN" names are not stable, I will drop this patch, and
the related support.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

