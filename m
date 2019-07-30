Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC6C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57AD206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Khx2ocOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57AD206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsSRO-0002UD-5e
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51990)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsSQf-0001ow-6Q
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsSQe-0000Fn-3v
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:44:37 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsSQc-0000EH-J1
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:44:34 -0400
Received: by mail-oi1-x241.google.com with SMTP id t76so47960998oih.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J7rrvofl9pFv1q1kmCicmzCjHC/lfB+Hj2dddYPvq5k=;
 b=Khx2ocObOyQwrZV0tP3Z6cN83aS+tE20KgRogDcimPfPzXUCBcLpz8n/NITywkqn7D
 2em97yoVX45EkGz2CJrp2J4MxeJO5l+eGhbZ8YJN+FkT8LsoQylgGJglJHirChpFAbf3
 j4hZh2DdNAkWthIwzWGKImwaj77BO2dv9tg+cJVJvdjR0bx9Dov+aQbWw1kk18js+Yf2
 s+HYvQndhw5zEhqf+6RVzsWqPhEx0E6hCzRVuiRJlq/3Uat0RSyOt2aqU21yyWsHv5pE
 Y1RgRwLAR7H76+1dEmksGB8ugn1y+6E00a/RVS/zFqPc15UwnvEbzqB9Dj3oKiQ51cVZ
 wnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J7rrvofl9pFv1q1kmCicmzCjHC/lfB+Hj2dddYPvq5k=;
 b=Lhne/J11365d37o7hWn9jwGpEycmW0I+qcrrbHeNulkSOMttxrMyYuUtHYr8OnMCPL
 n+PLMEfMG6tOK89VSxAS+uxei1FT4aGwvDeWXIJQJVgGIkkZ9E7NRfgYIJHcrokMO2V8
 iwD2jlEf1ju8hUq3ftnkDIOAEeXL4tFmdvYb2RKhmPoqOVM2tKM12436B5Tr+ZrNe4CI
 B3DkaEm1jnB6TO9+wDbbnDTYBt0fc1LUe2yZISDFU55UNtttMGudDb0iiCqfVnUsHtxo
 NCHZamDCrWBIUxgpAxBR9GhkxL1cmWsvaKOW2z0op3cPQ5EzwsPkn1CjRQTWH2avKlqh
 uxrA==
X-Gm-Message-State: APjAAAWTv7tyLa8W3u/SzPjjok5i9ckmQFEAqxWovC1Jx3Ba1B5cmRzo
 Fnk9T5gSci64vuhNydog0gqrh4c6nWWWr6DpaAeGXw==
X-Google-Smtp-Source: APXvYqwLSuK4H9bu7oKSiBveKjq6hA6BKJoF7XXyy8BcS/qw21Mc0/VBPUYG8R85iGVWNLJXov0p5mqo9QYdW0StbLE=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr51661163oib.146.1564494272629; 
 Tue, 30 Jul 2019 06:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-2-damien.hedde@greensocs.com>
 <20190730154209.2049f10a.cohuck@redhat.com>
In-Reply-To: <20190730154209.2049f10a.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 14:44:21 +0100
Message-ID: <CAFEAcA-rwBiXkDEDuT-=KQVJ2A2ob16=P0obbZBPUfZeYXy+dQ@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 01/33] Create Resettable QOM interface
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 14:42, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, 29 Jul 2019 16:56:22 +0200
> Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> (...)
>
> > +/*
> > + * ResettableClass:
> > + * Interface for resettable objects.
> > + *
> > + * The reset operation is divided in several phases each represented by a
> > + * method.
> > + *
> > + * Each Ressetable must maintain a reset counter in its state, 3 methods allows
> > + * to interact with it.
> > + *
> > + * @phases.init: should reset local state only. Takes a bool @cold argument
> > + * specifying whether the reset is cold or warm. It must not do side-effect
> > + * on others objects.
>
> I'm having a hard time figuring out what a 'cold' or a 'warm' reset is
> supposed to be... can you add a definition/guideline somewhere?

Generally "cold" reset is "power on" and "warm" is "we were already
powered-on, but somebody flipped a reset line somewhere".

thanks
-- PMM

