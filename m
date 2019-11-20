Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004FAC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB4E22429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPUmXQVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB4E22429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNMX-0004kL-O8
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:37:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNLk-00044j-AM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNLj-0001Lv-7E
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:36:40 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXNLj-0001JZ-2m
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:36:39 -0500
Received: by mail-ot1-x344.google.com with SMTP id r24so20741182otk.12
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RtIxhKscXKv9SP0Cu/koEsS13Uo3TXhTms6kVgHWxfM=;
 b=aPUmXQVx5y2DHnk1t0Ty2KlnD2IZfB8Rpe3NwBxyQEFZZ1qUIJZ+0DjKEWJmZc8FCX
 UP4Nwtg671PhLvAVYfTsC2xyA8uwqs3sbVZBXV7u2yt1X0Yq6HXQiAGw4TtN8ZSUwpCi
 FUMGEhgcSUDbbezkebqEAVwSwBrp0ebrimD/Ufn4bcNKHIJg7CfFfkv8W9uiuPjqw9BH
 AgvV0vJlD1AD3pQUJG2dgFrLldLWyka74A5qMYQ5ufuUvRfbPt08+I/eol1r9VvybXja
 MN2pc8an0Paj07p+bYPfxuLsA/1hJ0+Iu2ik36GhcajXx1mjOJaU7Prre2HGYOfm9zJr
 Eh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RtIxhKscXKv9SP0Cu/koEsS13Uo3TXhTms6kVgHWxfM=;
 b=Krb6MhKtrFpPhyHuTcGXYpcH0eDzFYlJwP87JhJD6XGEdHw7Iw53jfUiaOj7/0k1h0
 DYlTIOXJq30lD7LWBSf5cd8yikgrZPQKlRhkRZel+hLh7aABvr4+xaSLzbufI7RH9F+N
 5+0PaxnJjjJWMQ5XyObLLxbeGNGcKktltjT10bLRNKq0zaDbJpiPSyjZ0WctAnuYxoFA
 zBbN3JCFlLNT1LkDvDB8Km6fcoLydbhwqTLsQ2EaAFJnz9mkNpEG+Psg1dKt3LRSeUkq
 BdLfqxOvc5+QCNK9WD/YcSJCs76jLQmbvSAq7g5BKNj7ozj/V4nGq63l1VZ3Cmct0Awy
 qbEQ==
X-Gm-Message-State: APjAAAUUSt9/oJoW85cRfsE1iOIeRD0j7y1sdnW5Fx6VsRoOT6tVg4Sk
 Q6k8hoyihLRfI3mpprp1d7uucHyPrl0t7Y8+NZ0bwQ==
X-Google-Smtp-Source: APXvYqyqt07XwBVBcqg3/5c/xONwchsIoXER2UlWTw+Pw79rpR1H6r3jxBPqcbj25VKfYlZU9HvO5BWALHZUY79SGmM=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr1431546otn.135.1574246197642; 
 Wed, 20 Nov 2019 02:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-14-marcandre.lureau@redhat.com>
 <CAFEAcA9Cq_MkAzqAjt5uPNu3HDUfxO0hyVWtqEiAashPEEq3=g@mail.gmail.com>
 <CAMxuvawroZ0jrQTJCbakft21Lgk2cHrE9VyihiUvYBVp+AXgXw@mail.gmail.com>
In-Reply-To: <CAMxuvawroZ0jrQTJCbakft21Lgk2cHrE9VyihiUvYBVp+AXgXw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2019 10:36:26 +0000
Message-ID: <CAFEAcA97LxS0LhCN-uqmO++D2U3dXBn3KctW7n-4tA-b50xKcw@mail.gmail.com>
Subject: Re: [PATCH v3 13/33] serial: start making SerialMM a sysbus device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
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

On Wed, 20 Nov 2019 at 07:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:

> > > +static void serial_mm_instance_init(Object *o)
> > > +{
> > > +    SerialMM *self =3D SERIAL_MM(o);
> >
> > 'self' is not idiomatic for the name of the variable containing
> > the pointer to the object in QOM code ("git grep '\Wself\W' hw"
> > shows no uses of it at all, which is quite unusual for us --
> > usually the codebase has at least a few uses of any non-standard
> > way of writing something ;-))
> >
> > Usually we use something approximating to the abbreviation
> > of the type name, so here 'smm' would do.
>
> I would prefer something more straightforward than having to come up
> with various name mangling.
>
> Imho, we loose some readability, consistency & semantic by not naming
> the object argument of the method "self"

There are two problems here:
 (1) "self" gives no hint at all about whether it's the Object*,
the DeviceState*, or the SerialMM*. All of those are the
object the method is operating on, but the type differences matter.

(2) *Absolutely nobody anywhere else in any other device model
is using the 'self' argument name*. It's not a convention if
only this one file is using it, and adopting it here gives us
absolutely no consistency -- exactly the opposite.

Item (1) is part of why we do things the way we do; item (2)
is why we should not make the 16550 UART some weird
exception from the way we do things.

thanks
-- PMM

