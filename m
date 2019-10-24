Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8F1C47E49
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D4621872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D4621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaBB-0004qA-6M
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iNZuS-0004tj-Dn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iNZuR-0001oS-6m
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iNZuQ-0001mM-Tn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:59:59 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B7ED4E4E6
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:59:57 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id r5so12927209otn.22
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 02:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FJB5eNMUoMSyJPvrt8Sm0IHAjPcwYY2MdO0zgEnLntk=;
 b=oaCxQFGphzVKmEq5nOIPMCoFdNwZfdauTZXo1MMPecAN+DkJwbmNsZW7cNS/PCyNER
 MXLT43coDJchH8pirGmTq54W38PwdPaWZ+IDSAMyR8or7Irq9RUVN2543xPAdfZ5TEUh
 lusgkDr1QU94SSqc9MEzan0w1617Fj3/G4uDovVv7B5I3pZ6mKFhtE/VotLkHVM+pLL7
 ylURIu+Jbf7QJAgGAg4RrTI210uH4h/9ctiHIWI5DSEAZwqGN5wrjAjfAPhhm6elceK6
 G5SjsKwH/ZyIr0a6fVr/cFungVRG3O8kd/9SF+cTBrMYMmuvJRg04epGboQD5uxDiKPo
 Ke5Q==
X-Gm-Message-State: APjAAAU4UhorbNIm2Y+EYITDjIykfkCidZHp20GjYPxl1Ep9EgRIkfN0
 D02wOK+F/OhjpzkF99GCzRUmfOZY9mI44U8cMQpYGUmidNGIqYC1jjz/MvvnqbMuPTsRBwxSpD6
 B6HRlIZsjicz43XbQZRvcmQhkUO8zkRY=
X-Received: by 2002:a05:6830:1617:: with SMTP id
 g23mr10496113otr.368.1571911196650; 
 Thu, 24 Oct 2019 02:59:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkZyXSGnuuNrCpiBwX+CEWZWprQ+KPlWkjHXcIO+w4U/1cGzKZ7In7uTQye5nk2QWn4huwsrvEIkQPcR+v2T8=
X-Received: by 2002:a05:6830:1617:: with SMTP id
 g23mr10496094otr.368.1571911196347; 
 Thu, 24 Oct 2019 02:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-6-marcandre.lureau@redhat.com>
 <6918ee75-31e8-7816-b196-5654cda451e0@redhat.com>
In-Reply-To: <6918ee75-31e8-7816-b196-5654cda451e0@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 24 Oct 2019 11:59:45 +0200
Message-ID: <CAMxuvaxoaFTpoDb8NT7D68697td4Wck5wkJYx9zufFu38RBE8w@mail.gmail.com>
Subject: Re: [PATCH v3 05/33] serial-pci-multi: factor out
 multi_serial_get_nr_ports
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
 qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 12:41 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Reused in following patch.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/char/serial-pci-multi.c | 26 ++++++++++++++------------
> >   1 file changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> > index 5f13b5663b..6fa1cc6225 100644
> > --- a/hw/char/serial-pci-multi.c
> > +++ b/hw/char/serial-pci-multi.c
> > @@ -77,24 +77,26 @@ static void multi_serial_irq_mux(void *opaque, int =
n, int level)
> >       pci_set_irq(&pci->dev, pending);
> >   }
> >
> > +static int multi_serial_get_nr_ports(PCIDeviceClass *pc)
>
> static size_t multi_serial_get_port_count()?
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

works for me, thanks

>
> > +{
> > +    switch (pc->device_id) {
> > +    case 0x0003:
> > +        return 2;
> > +    case 0x0004:
> > +        return 4;
> > +    }
> > +
> > +    g_assert_not_reached();
> > +}
> > +
> > +
> >   static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
> >   {
> >       PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
> >       PCIMultiSerialState *pci =3D DO_UPCAST(PCIMultiSerialState, dev, =
dev);
> >       SerialState *s;
> >       Error *err =3D NULL;
> > -    int i, nr_ports =3D 0;
> > -
> > -    switch (pc->device_id) {
> > -    case 0x0003:
> > -        nr_ports =3D 2;
> > -        break;
> > -    case 0x0004:
> > -        nr_ports =3D 4;
> > -        break;
> > -    }
> > -    assert(nr_ports > 0);
> > -    assert(nr_ports <=3D PCI_SERIAL_MAX_PORTS);
> > +    int i, nr_ports =3D multi_serial_get_nr_ports(pc);
> >
> >       pci->dev.config[PCI_CLASS_PROG] =3D pci->prog_if;
> >       pci->dev.config[PCI_INTERRUPT_PIN] =3D 0x01;
> >

