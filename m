Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FC2C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F66C216C8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F66C216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqor-0001d6-Iy
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pmathieu@redhat.com>) id 1hsqng-0000kt-0p
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1hsqne-0005Ds-Qq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:45:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hsqne-00056m-Ks
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:45:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so61339196wmj.5
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 08:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eZUTq130Vr1BellBBksVsLLFPBlgAJiRnUqxsUwGW6k=;
 b=A8UcduRZb9YXohZqjG0tcR1w6xa2mR9bCBIiNFpbPt3tEplOm0aBxjhmBm5yTcl39a
 ebPntjHCyOygjyZBCkslxvb3egll5331926y9WAQ6JmCWw4tdP19za0AzjfqXKb6WToX
 dYWY44TT3NG4PxIOmJ4m5rEwBhk9hVzc/2jvAI8cwrtRvvsW60rp1NL+CXwZ49zBD2kY
 k7VFtQkfTMO2Hk/rzAcPs8GCojteAzuMnEP5Pnr5FOon8jvBSOnaExMwSCqLPl3UZ/Ji
 DQ/idXiR6ukNNxNec58R1/J7v8h2FmYxO6La1AI6uocGGwe3hNBBSHQXsGmfUKGDN6W2
 KcIw==
X-Gm-Message-State: APjAAAXnjoGbgkLM/f1CeQX8zGY8iREKrZ3FCjQwcPz9IyIO7Ods3xdg
 2qOjIVQlzpdHyywNIWDpa7QO++Y9XE15oQUPaVxCRJdb
X-Google-Smtp-Source: APXvYqxzmZuQCGwAO5MzBWaF4oc/DIXLanvUV8xzO4nDItOCO1hRxQm6vUkrESMXBdozkwdAK7DMb6s5YH8CJAGaahU=
X-Received: by 2002:a7b:c857:: with SMTP id c23mr117859927wml.51.1564587957073; 
 Wed, 31 Jul 2019 08:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <6ea54e80-63cd-5759-337b-1eb1686453f5@greensocs.com>
 <e979936e-3545-87fb-eec6-e3a098785113@redhat.com>
In-Reply-To: <e979936e-3545-87fb-eec6-e3a098785113@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 31 Jul 2019 17:45:46 +0200
Message-ID: <CAP+75-XzR9bQAm6KVdF=QZ4Bs9yWw-OLt6cRXNM=j8d0BjSZmQ@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] RFC raspberry pi sd-card reset
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 5:43 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 7/31/19 4:21 PM, Damien Hedde wrote:
> > Concerning the reset on the raspi2/3 machine, I ran into an issue with
> > the sd-card.
> >
> > Here follows a subset of the qbus/qdev tree of the raspi2&3 machine as
> > it is initialized:
> >  + System
> >    * bcm2835_gpio
> >      + sd-bus
> >        * sd-card
> >    * bcm2835-sdhost
> >      + bcm2835-sdhost-bus
> >    * generic-sdhci
> >      + sdhci-bus
> >
> > raspi_init does 2 things:
> >  + it creates the soc
> >  + then it explicitly creates the sd-card on the bcm2835_gpio's sd-bus
> >
> > As it happens, the reset moves the sd-card on another bus: the
> > sdhci-bus. More precisely the bcm2835_gpio reset method does it (the
> > sd-card can be mapped on bcm2835-sdhost-bus or sdhci-bus depending on
> > bcm2835_gpio registers, reset configuration corresponds to the sdhci-bu=
s).
> >
> > Reset call order is the following (it follows children-before-parent or=
der):
> >  1 sd-card
> >  2 sd-bus
> >  3 bcm2835_gpio -> move the sd-card
> >  4 bcm2835-sdhost-bus
> >  5 bcm2835-sdhost
> >  6 sd-card  (again)
> >  7 sdhci-bus
> >  8 generic-sdhci
> >
> > In the end, the sd-card is reset twice, which is no big-deal in itself.
>
> The machine cold reset implicitly cold resets the sd-card.
>
> IIRC the sd-bus shouldn't (cold/warm)-reset the sd-card.
>
> Only SDBusClass::set_inserted() can cold-reset the card.
>
> > But it only depends on the bcm2835_gpio tree being reset before the
> > generic-sdhci (probably depends on the machine creation code).
> >
> > I checked and it seems this is the only platform where such things
> > happen during master reset.
> >
> > IMO this is a bit hazardous because reset is based on the qdev/qbus
> > tree (and with the multi-phase I'm working on, even if it still works,
> > it's worse).
> > I'm not sure what we should do to avoid this (and if there's is
> > something to be done).
> >
> > The easiest solution would be to initialize the platform with the
> > sd-card at the right initial place (I do not really understand why it i=
s
> > created in the bcm2835_gpio in the first place since we move it just
> > after). But it won't solve the issue if a reset is done afterwards.
> >
> > Or maybe we could move the sd-card on the proper bus in a machine
> > reset code so that it's on the right place when we do the sysbus tree
> > reset just after.
> >
> > What do you think ?
>
> There is only 1 bus, the SDHCI bus lines are muxed with the GPIO ones.
>
> bcm2835-sdhost-bus should not be child of bcm2835-sdhost, the sdbus
> might be child of bcm2835-peripherals and shared by both sdhost and gpio
> (as a link property?).

There is a similar modelling issue with the AUX uart and SPI on this device=
.

> I tried to do that 2 years ago. I thought I posted the series and Peter
> rejected it but can't find it, maybe we had an IRC chat. I won't have
> time until next week to dig for it.
>
> >
> > --
> > Damien
> >

