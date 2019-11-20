Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F124C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A3D206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfrIgbyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A3D206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNSj-0001ij-C6
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXNPq-0006uz-7w
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXNPo-0007pA-VR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:40:54 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iXNPo-0007nc-Pb; Wed, 20 Nov 2019 05:40:52 -0500
Received: by mail-wr1-x441.google.com with SMTP id l7so27518953wrp.6;
 Wed, 20 Nov 2019 02:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jdVziSE2yJjgCmCoewk2esye2yNz3gG8mZIZe2t2++c=;
 b=mfrIgbyK4rbIUtPKay5Tin7JAuHtVCEqdCxVenQN0h7k+Cml1PEFh2QITOun1aLBsj
 e3P81MqtqZN5Od9lxw6FaNDx2p1yvhBU7baVGs3aJvluAtMEjJmCFqcmgt8+/MZvFbgC
 z8JeMSnrYgK5gM8Zco9m6koU7v/UmfD4xJidWJ4z29qNitB6NFi0hwqNObPN/iFPFoPI
 JvyICNy/9tNBs8ZQH7CMYPvA3ldchA+vX5sl5OcSIg/y1pGXvnWxrxowKZ+tSiLgQumT
 H9ZLxHqnoJA9FDvw2NkPX1DPxJfTUI/cE9o6s+7kmRXSzxw90p8ufrwUDo5U/hNFxVVo
 vUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jdVziSE2yJjgCmCoewk2esye2yNz3gG8mZIZe2t2++c=;
 b=KKtDBKSJirVPbZJQsv0jgddNk7EuGFzYwD1RpCB9z+QUS5/fNaM8GcrhCyyJieNh2U
 4/c2X6tKUa8TROfQvVkBN3lxPaPqo60amU8BMCVPgU9w8vhTDe3Tp16vC1s0lh56gq9Q
 jG2nOFdWdjsxFEVRpmnkqcO6DzC3L/kuEh6qAax/hOd5InSNiHkMDBD+6oHkrSLYs83R
 cQ5rAFoqwP2TNoSR+BxDdIkDW7T6M0kHZjJ9UF2vxcyz8h7hoEjVy+EmiJ3S1tzmS51v
 hMnk7aBWQTW07VAEbLKi5aHlDXo80kU2iwpJCr0jXkc1lJYsUcWBx4oyMMatWlci1oeD
 8Yjw==
X-Gm-Message-State: APjAAAVWhI/7NKSA66457zYNKR7NxRcZtZrlV9/K6sOeZ/l3vPsbH8S0
 LOwp9Sb75Zq/z73bOkDqU9nY0E5RUqroIBPb8Zg=
X-Google-Smtp-Source: APXvYqzgxeysE6GY0J92IRNkC4vvC7PpCDVc0/dGJc/tC1l/4f8KwRmblhSiqHYZrH6HGtbSDGhYoM/gm9JbK0g9GX0=
X-Received: by 2002:a5d:6cc3:: with SMTP id c3mr2367608wrc.202.1574246450708; 
 Wed, 20 Nov 2019 02:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-14-marcandre.lureau@redhat.com>
 <CAFEAcA9Cq_MkAzqAjt5uPNu3HDUfxO0hyVWtqEiAashPEEq3=g@mail.gmail.com>
 <CAMxuvawroZ0jrQTJCbakft21Lgk2cHrE9VyihiUvYBVp+AXgXw@mail.gmail.com>
 <CAFEAcA97LxS0LhCN-uqmO++D2U3dXBn3KctW7n-4tA-b50xKcw@mail.gmail.com>
In-Reply-To: <CAFEAcA97LxS0LhCN-uqmO++D2U3dXBn3KctW7n-4tA-b50xKcw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Nov 2019 14:40:37 +0400
Message-ID: <CAJ+F1CJGHeb2aT+8t7vEdB0bKZ8r6OAnnqpDdnkGbfDRcV=JjA@mail.gmail.com>
Subject: Re: [PATCH v3 13/33] serial: start making SerialMM a sysbus device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 20, 2019 at 2:36 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 20 Nov 2019 at 07:34, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>
> > > > +static void serial_mm_instance_init(Object *o)
> > > > +{
> > > > +    SerialMM *self =3D SERIAL_MM(o);
> > >
> > > 'self' is not idiomatic for the name of the variable containing
> > > the pointer to the object in QOM code ("git grep '\Wself\W' hw"
> > > shows no uses of it at all, which is quite unusual for us --
> > > usually the codebase has at least a few uses of any non-standard
> > > way of writing something ;-))
> > >
> > > Usually we use something approximating to the abbreviation
> > > of the type name, so here 'smm' would do.
> >
> > I would prefer something more straightforward than having to come up
> > with various name mangling.
> >
> > Imho, we loose some readability, consistency & semantic by not naming
> > the object argument of the method "self"
>
> There are two problems here:
>  (1) "self" gives no hint at all about whether it's the Object*,
> the DeviceState*, or the SerialMM*. All of those are the
> object the method is operating on, but the type differences matter.

"self" should have the type of the object that is being implemented.

serial_mm_instance_init ->  SerialMM *self

>
> (2) *Absolutely nobody anywhere else in any other device model
> is using the 'self' argument name*. It's not a convention if
> only this one file is using it, and adopting it here gives us
> absolutely no consistency -- exactly the opposite.

Since there is no clear convention, then adding "self" isn't breaking
any convention.

>
> Item (1) is part of why we do things the way we do; item (2)
> is why we should not make the 16550 UART some weird
> exception from the way we do things.

It's about trying to make things better, and not about staying in the
current undefined/free zone.

--=20
Marc-Andr=C3=A9 Lureau

