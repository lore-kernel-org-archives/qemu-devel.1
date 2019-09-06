Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92FEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCCA206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCCA206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6CCq-0002pn-JT
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1i6CC8-0002Oi-2s
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1i6CC6-0007Ol-OM
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:14:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1i6CC6-0007Nr-JN
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:14:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id 100so5387618otn.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 04:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=A+M249Y2yXTR5pLBFzUNH1SBf+7zmy/nNt6gvl0in+8=;
 b=K0GtRtA9vqg+h/MHS+1aaFYbnC2RjfopY6jw7Fawjttv946/KkAgmpi7xX9av67FZs
 xmxDpNCAPzhO58znbjgvW2IQ6peUeADqJ0ngfN/CvC0o+dvkfZu9hBDoGt7vvv+geoBL
 ++VMAixgm9gMuQVcYAWR/NB2KhsaNhCMfPVQmuPSn1UXJXHw7619sRQmZqQqo8vgFLXd
 79LeNdr5y/wQHGqoKNJkEnvO9x3L61NHqTS1ujSSMKcrVBzr7jQAzch8CMs2x9Aipjm0
 amwtxsxNb4ATM2qlgy+OyuKwXHrBtZhlLBwOQNpIoRSIF78vILgPuyjFHAsp1MJ1e6hv
 am6Q==
X-Gm-Message-State: APjAAAUv3+UCk+lFpnxlkZfZ/mtUpXgrzoQXNSvn96ha0HL6Vkghadrn
 nDm+nmON50p1JT7O1cC7YJbtXw3wSxFMCr7nKWNgeQ==
X-Google-Smtp-Source: APXvYqzUNQXMQuLstdGXR8mRJrmMCqQfnRb/uNRT1dACYw9FvhrBJuzXdIAg5nMAqX8cUVjMPZH+gtG74Cj8EpGzPcc=
X-Received: by 2002:a05:6830:1196:: with SMTP id
 u22mr6812488otq.39.1567768461501; 
 Fri, 06 Sep 2019 04:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <CAMpxmJXOrDLdw6ZPBHxzsDRYiLmhRNCb-s_Z=Gu=Ecg1XA5ONQ@mail.gmail.com>
 <CAMuHMdWdb0dcS8Nvk-Poz2dT7nuHjFhqpsRPZZnSKsc3VffcRA@mail.gmail.com>
 <CAMpxmJUF1s1zyXVtoUGfbV7Yk+heua4rNjY=DrX=jr-v8UfNxA@mail.gmail.com>
 <CAMuHMdUkF32+wOLkfd2BL4h-=0nZjPDMtVOpOcyDYzBbhWXteQ@mail.gmail.com>
 <CAMpxmJXCYeGjCu_PhCPffZQZ+ST9YCp27-PTHfL2SJ0Bh8SJFQ@mail.gmail.com>
In-Reply-To: <CAMpxmJXCYeGjCu_PhCPffZQZ+ST9YCp27-PTHfL2SJ0Bh8SJFQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Sep 2019 13:14:10 +0200
Message-ID: <CAMuHMdV32_x5+CEqZM-mNjg5dAEK-D1JNTTGQYqR87u5X2dJqg@mail.gmail.com>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.66
Subject: Re: [Qemu-devel] [PATCH RFC] gpio: Add Virtual Aggregator GPIO
 Driver
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-gpio <linux-gpio@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bartosz,

On Fri, Jul 12, 2019 at 11:27 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> wt., 9 lip 2019 o 17:59 Geert Uytterhoeven <geert@linux-m68k.org> napisa=
=C5=82(a):
> > On Tue, Jul 9, 2019 at 4:59 PM Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> wrote:
> > > pon., 8 lip 2019 o 12:24 Geert Uytterhoeven <geert@linux-m68k.org> na=
pisa=C5=82(a):
> > > > On Mon, Jul 8, 2019 at 11:45 AM Bartosz Golaszewski
> > > > <bgolaszewski@baylibre.com> wrote:
> > > > > pt., 5 lip 2019 o 18:05 Geert Uytterhoeven <geert+renesas@glider.=
be> napisa=C5=82(a):
> > > > > > GPIO controllers are exported to userspace using /dev/gpiochip*
> > > > > > character devices.  Access control to these devices is provided=
 by
> > > > > > standard UNIX file system permissions, on an all-or-nothing bas=
is:
> > > > > > either a GPIO controller is accessible for a user, or it is not=
.
> > > > > > Currently no mechanism exists to control access to individual G=
PIOs.
> > > > > >
> > > > > > Hence add a virtual GPIO driver to aggregate existing GPIOs (up=
 to 32),
> > > > > > and expose them as a new gpiochip.  This is useful for implemen=
ting
> > > > > > access control, and assigning a set of GPIOs to a specific user=
.
> > > > > > Furthermore, it would simplify and harden exporting GPIOs to a =
virtual
> > > > > > machine, as the VM can just grab the full virtual GPIO controll=
er, and
> > > > > > no longer needs to care about which GPIOs to grab and which not=
,
> > > > > > reducing the attack surface.
> > > > > >
> > > > > > Virtual GPIO controllers are instantiated by writing to the "ne=
w_device"
> > > > > > attribute file in sysfs:
> > > > > >
> > > > > >     $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
> > > > > >            "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
> > > > > >             > /sys/bus/platform/drivers/gpio-virt-agg/new_devic=
e
> > > > > >
> > > > > > Likewise, virtual GPIO controllers can be destroyed after use:
> > > > > >
> > > > > >     $ echo gpio-virt-agg.<N> \
> > > > > >             > /sys/bus/platform/drivers/gpio-virt-agg/delete_de=
vice
> >
> > > Am I doing it right? I'm trying to create a device and am only gettin=
g this:
> > >
> > > # echo gpiochip2 23 > new_device
> > > [  707.507039] gpio-virt-agg gpio-virt-agg.0: Cannot find gpiochip gp=
iochip2
> > >
> > > gpiochip2 *does* exist in the system.
> >
> > Please try the name of the platform device instead.
> > I.e. for my koelsch (R-Car M2-W), it needs "e6052000.gpio" instead
> > of "gpiochip2".
> >
> > Probably the driver should match on both.
> >
> > > I see. I'll try to review it more thoroughly once I get to play with
> > > it. So far I'm stuck on creating the virtual chip.
>
> This is not a show-stopper but one thing that's bothering me in this
> is that lines used by the aggregator are considered 'used' in regard
> to the original chip. I'm wondering how much effort would it take to
> have them be 'muxed' into two (real and virtual) chips at once.

Is that really what you want?
If a GPIO is aggregated with othrs, it's intended to be used only through
the aggregator, isn't it?

> Other than that - seems to works pretty nice other than the matching
> by chip name and by line names.

Thanks, working on that...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

