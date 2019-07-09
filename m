Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B3C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7249C216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 16:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7249C216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hksbR-0007ZC-FC
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 12:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53486)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1hksXB-0005kF-B0
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1hksX9-00064M-LY
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:00:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1hksX9-00063V-G6
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:59:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so20481819otl.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 08:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z1mIOFo8Yb9qP+Xw6RYXcy8nIe448VjUC8u9ee+We+c=;
 b=gfn1NoMDhxiikpy+rmCGiL4IwznB7LNdiYKYCYoHtKjgQZ4c3bxeZmcgtEoxXueADz
 Rhup/5ZqRqCtMj2smG3VbgkzdFDa7tfLPK/m9ZG+rWSSIako5DFJxL00AIIXr/B3qtWJ
 1wJBjfZvJS+kfVYfExvbsP5PgwCoUxPk/1S/uUmoA9t0eVkVt4/q3zLuuz6xld7cs9xN
 m/UPlnpCp4lg6YPTL3+TQx3ufgi8WYHYFucq+jVsjtV0i8wBvmfDmrTGwuzRCaOJQCcd
 Pp26ZqckSOnaOHL/FBHh1ZFly9d6d0VmNT5JuVUOksrpnyO/uZyfGlDUuHF0fuRh1hgr
 XxZQ==
X-Gm-Message-State: APjAAAUW7+X6Csi877DINSPQ9pFKOV0C9K4q6MtZoG/GWDBDd37XLX4x
 Tmv1yZkSfK/5lqZy69eTdsWQF/W/i8KsYQjAmsA=
X-Google-Smtp-Source: APXvYqwKIGFzgXhLsG7x1Ibj/zqO9Ml43UWKnLOrH2GD2U0KJFvJPE3d3t4YQY0+Ry5zNqEpFNq7esdkQCqbfLmXXoM=
X-Received: by 2002:a05:6830:210f:: with SMTP id
 i15mr2448511otc.250.1562687998070; 
 Tue, 09 Jul 2019 08:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <CAMpxmJXOrDLdw6ZPBHxzsDRYiLmhRNCb-s_Z=Gu=Ecg1XA5ONQ@mail.gmail.com>
 <CAMuHMdWdb0dcS8Nvk-Poz2dT7nuHjFhqpsRPZZnSKsc3VffcRA@mail.gmail.com>
 <CAMpxmJUF1s1zyXVtoUGfbV7Yk+heua4rNjY=DrX=jr-v8UfNxA@mail.gmail.com>
In-Reply-To: <CAMpxmJUF1s1zyXVtoUGfbV7Yk+heua4rNjY=DrX=jr-v8UfNxA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jul 2019 17:59:47 +0200
Message-ID: <CAMuHMdUkF32+wOLkfd2BL4h-=0nZjPDMtVOpOcyDYzBbhWXteQ@mail.gmail.com>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.68
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
 LKML <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-gpio <linux-gpio@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bartosz,

On Tue, Jul 9, 2019 at 4:59 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> pon., 8 lip 2019 o 12:24 Geert Uytterhoeven <geert@linux-m68k.org> napisa=
=C5=82(a):
> > On Mon, Jul 8, 2019 at 11:45 AM Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> wrote:
> > > pt., 5 lip 2019 o 18:05 Geert Uytterhoeven <geert+renesas@glider.be> =
napisa=C5=82(a):
> > > > GPIO controllers are exported to userspace using /dev/gpiochip*
> > > > character devices.  Access control to these devices is provided by
> > > > standard UNIX file system permissions, on an all-or-nothing basis:
> > > > either a GPIO controller is accessible for a user, or it is not.
> > > > Currently no mechanism exists to control access to individual GPIOs=
.
> > > >
> > > > Hence add a virtual GPIO driver to aggregate existing GPIOs (up to =
32),
> > > > and expose them as a new gpiochip.  This is useful for implementing
> > > > access control, and assigning a set of GPIOs to a specific user.
> > > > Furthermore, it would simplify and harden exporting GPIOs to a virt=
ual
> > > > machine, as the VM can just grab the full virtual GPIO controller, =
and
> > > > no longer needs to care about which GPIOs to grab and which not,
> > > > reducing the attack surface.
> > > >
> > > > Virtual GPIO controllers are instantiated by writing to the "new_de=
vice"
> > > > attribute file in sysfs:
> > > >
> > > >     $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
> > > >            "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
> > > >             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
> > > >
> > > > Likewise, virtual GPIO controllers can be destroyed after use:
> > > >
> > > >     $ echo gpio-virt-agg.<N> \
> > > >             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device

> Am I doing it right? I'm trying to create a device and am only getting th=
is:
>
> # echo gpiochip2 23 > new_device
> [  707.507039] gpio-virt-agg gpio-virt-agg.0: Cannot find gpiochip gpioch=
ip2
>
> gpiochip2 *does* exist in the system.

Please try the name of the platform device instead.
I.e. for my koelsch (R-Car M2-W), it needs "e6052000.gpio" instead
of "gpiochip2".

Probably the driver should match on both.

> I see. I'll try to review it more thoroughly once I get to play with
> it. So far I'm stuck on creating the virtual chip.

Thanks, good luck!

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

