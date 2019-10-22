Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79913CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5259920B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5259920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxT9-0005K6-GO
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iMxEq-00059O-9L
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iMxEn-0007sg-SU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:42:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iMxEn-0007s9-Js
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:42:25 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 303FD85537
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 16:42:24 +0000 (UTC)
Received: by mail-oi1-f198.google.com with SMTP id c190so9767949oig.9
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rpax9PYPBJj/zrlFqV6JFK0mH0hpYJp+AqZkNk9QC4M=;
 b=NhZkZ5F1zdGcorKA6RcA2xerNZu2SFvOOq1+RY07Tp2RZdNAXsryN3JhCY7vYuZ85I
 JxY+GixgADEk521lEhGeQLxOYtG5GIjQo1sDXYECSiCtHCTpdMTZzLVcYarU5evfsMUk
 0pW0NxwOT8k4bajPQ0CO3EqZ+Y4UwgVDXL+IX9TzPEYRq6vIYK6M4A8BVWy68R3HDPK8
 HfJ8GShGKFm/zOgMb6b1LxGkoDWgkGnrDQ5Bcp4Jpw0Mtsf+HBPIV7wmuDhDWY0ZInAI
 GdWPHCPGYtKHXK3Thj1YYk7C0zrbq+ivYU4dwgCIf20iq5r5iXw6WOn6FXb6scLaKqyJ
 ryFA==
X-Gm-Message-State: APjAAAWvst16ELOv9QjRS5kWmBj7VkC1UO2TuMddoDN1zq7CRKQW0TXH
 GYLcRfG9iWlYBp2a3WaNHPR0sue6euAwNqnSbJ3l/ZkPAuebD9rG+rvIcISnLIBVcy94CS73SAd
 GALAuHV7lvW481LalG3WyuEtFv1MjIfs=
X-Received: by 2002:aca:f356:: with SMTP id r83mr3624104oih.13.1571762543675; 
 Tue, 22 Oct 2019 09:42:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXf4u8YZrGmDYFtm9CdWvdLM/bTpj08fl7U8PvrIVCEoxrsj4KQqe+d4f5N38DLUzgodt5ZOifnFnTPueThaI=
X-Received: by 2002:aca:f356:: with SMTP id r83mr3624086oih.13.1571762543427; 
 Tue, 22 Oct 2019 09:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
 <20191022162137.27161-11-marcandre.lureau@redhat.com>
 <CAFEAcA-5DkdB-iUHBRONB0SHO6rYmU7ZzdojJd5iZbQdLHswTQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-5DkdB-iUHBRONB0SHO6rYmU7ZzdojJd5iZbQdLHswTQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Oct 2019 18:42:12 +0200
Message-ID: <CAMxuvaxTdPyODFAofKWURq8_zJNQtxiX7Xj8dogB1iFPqgbj4A@mail.gmail.com>
Subject: Re: [PATCH v2 10/28] serial: add "base" property
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Oct 22, 2019 at 6:32 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Tue, 22 Oct 2019 at 17:23, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/char/serial.c         | 3 +++
> >  include/hw/char/serial.h | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/hw/char/serial.c b/hw/char/serial.c
> > index 0ae52ec60c..4748a2b023 100644
> > --- a/hw/char/serial.c
> > +++ b/hw/char/serial.c
> > @@ -990,6 +990,7 @@ SerialState *serial_init(int base, qemu_irq irq, in=
t baudbase,
> >      qdev_connect_gpio_out_named(dev, "serial-irq", 0, irq);
> >      qdev_prop_set_uint32(dev, "baudbase", baudbase);
> >      qdev_prop_set_chr(dev, "chardev", chr);
> > +    qdev_prop_set_uint64(dev, "base", base);
> >      serial_realize_core(s, &error_fatal);
> >      qdev_set_legacy_instance_id(dev, base, 2);
> >      qdev_init_nofail(dev);
> > @@ -1003,6 +1004,7 @@ SerialState *serial_init(int base, qemu_irq irq, =
int baudbase,
> >  static Property serial_properties[] =3D {
> >      DEFINE_PROP_CHR("chardev", SerialState, chr),
> >      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> > +    DEFINE_PROP_UINT64("base", SerialState, base, 0),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > @@ -1083,6 +1085,7 @@ SerialState *serial_mm_init(MemoryRegion *address=
_space,
> >      qdev_prop_set_uint32(dev, "baudbase", baudbase);
> >      qdev_prop_set_chr(dev, "chardev", chr);
> >      qdev_prop_set_uint8(dev, "regshift", regshift);
> > +    qdev_prop_set_uint64(dev, "base", base);
> >
> >      serial_realize_core(s, &error_fatal);
> >      qdev_set_legacy_instance_id(DEVICE(s), base, 2);
> > diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> > index ecbd3f1b40..6e9c9768ed 100644
> > --- a/include/hw/char/serial.h
> > +++ b/include/hw/char/serial.h
> > @@ -77,6 +77,7 @@ typedef struct SerialState {
> >
> >      QEMUTimer *modem_status_poll;
> >      MemoryRegion io;
> > +    uint64_t base;
> >  } SerialState;
>
> Devices shouldn't have properties to set their MMIO base
> address -- instead the memory-mapped serial device should
> be a child of TYPE_SYSBUS_DEVICE, and should provide
> a sysbus mmio region, which users of the device can
> map at the address they want to map the registers.


Can we make serial a sysbus device? It seems to be embedded from
various places, in various buses. Not sure that makes sense, please
advise me :)

"base" is mostly needed to set qdev_set_legacy_instance_id(), I should
have added a commit comment. Otherwise, it can be passed to
serial_mm_connect() directly.

