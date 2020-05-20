Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F99C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C8D20758
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C8D20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbO55-0002dG-TH
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jbNw4-0002Ah-Uf
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:35:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jbNw3-0007rB-Jx
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:35:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id w4so2781790oia.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 05:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F/u+6tnly2BFfAMjAK8M1DKWCRzqZwn5wyDMJLDJi3s=;
 b=AMZ4mY15GuUxsRkP7ia3LDGKQQIawd19+43xsVeQgJabNqpWinlsygxLXB3K5yqk+6
 Kn8zXDj9Vi8zwzZP1WklE8dCZjAjIwBEb97Os68WK6FJOw33APWk2zMiodhl6bkAg7SE
 5EGxP+kCHZOQFYVCND6phyoIKZNvwApK+Vmt4JtkuJmqG6plWlIyE4lKLynWbBcjQ68C
 rTWW2gjseRISY94V1b8P8Mw53lstzDCvlMcOgLI8DAvRrhw6IDkyuvBqTpZ+NAPzbk4G
 eAwjzYCxj4VcX8aeaV7Hld+nIkNQRSRGwj+UCqWsdS86fIvQJ7DtiEcgvSiBtWjGtevg
 1MWQ==
X-Gm-Message-State: AOAM533j9Gqbi2yy+s4+iSROmQ8/1nlQIjvnd9VvzMkyVCnuv3srqDrd
 Nud+vEEFxnrYXJ8ZVQ7rMVWWcyTvHRGH9B6k+x8=
X-Google-Smtp-Source: ABdhPJwOCOKGJWDMvkrJ0xNeetJajHrD/IP3CJbDZJ76726JW+VglbUl0g5pNhwQURwdBQbNda+mABt+2A5T1kia3c0=
X-Received: by 2002:aca:210a:: with SMTP id 10mr1526706oiz.153.1589978097806; 
 Wed, 20 May 2020 05:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200511145257.22970-1-geert+renesas@glider.be>
 <20200520121420.GA1867563@smile.fi.intel.com>
In-Reply-To: <20200520121420.GA1867563@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2020 14:34:46 +0200
Message-ID: <CAMuHMdW9EsRLYYTL0pd-PqqZs5WcUfK8i2uceNwJnSvAQKuVgw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] gpio: Add GPIO Aggregator
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.167.194;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-oi1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 08:34:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andy,

On Wed, May 20, 2020 at 2:14 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Mon, May 11, 2020 at 04:52:51PM +0200, Geert Uytterhoeven wrote:
> > GPIO controllers are exported to userspace using /dev/gpiochip*
> > character devices.  Access control to these devices is provided by
> > standard UNIX file system permissions, on an all-or-nothing basis:
> > either a GPIO controller is accessible for a user, or it is not.
> > Currently no mechanism exists to control access to individual GPIOs.
> >
> > Hence this adds a GPIO driver to aggregate existing GPIOs, and expose
> > them as a new gpiochip.  This is useful for implementing access control,
> > and assigning a set of GPIOs to a specific user.  Furthermore, this
> > simplifies and hardens exporting GPIOs to a virtual machine, as the VM
> > can just grab the full GPIO controller, and no longer needs to care
> > about which GPIOs to grab and which not, reducing the attack surface.
> > This has been implemented for ARM virt in QEMU[1].
> >
> > Recently, other use cases have been discovered[2], like describing
> > simple GPIO-operated devices in DT, and using the GPIO Aggregator as a
> > generic GPIO driver for userspace, which is useful for industrial
> > control.
> >
> > Note that the first patch of this series ("i2c: i801: Use GPIO_LOOKUP()
> > helper macro") has been applied to i2c/for-next.
>
> Sorry for late reply, recently noticed this nice idea.
> The comment I have is, please, can we reuse bitmap parse algorithm and syntax?
> We have too many different formats and parsers in the kernel and bitmap's one
> seems suitable here.

Thank you, I wasn't aware of that.

Which one do you mean? The documentation seems to be confusing,
and incomplete.
My first guess was bitmap_parse(), but that one assumes hex values?
And given it processes the unsigned long bitmap in u32 chunks, I guess
it doesn't work as expected on big-endian 64-bit?

bitmap_parselist() looks more suitable, and the format seems to be
compatible with what's currently used, so it won't change ABI.
Is that the one you propose?

> (Despite other small clean ups, like strstrip() use)

Aka strim()? There are too many of them, to know all of them by heart ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

