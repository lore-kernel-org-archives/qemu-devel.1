Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0743DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E28205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmUTo7y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E28205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkud-0003M8-Eh
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibktG-00025j-VJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibktF-0003bl-HU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:33:22 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibktF-0003bK-Av
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:33:21 -0500
Received: by mail-ot1-x344.google.com with SMTP id k14so15212075otn.4
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 04:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w3QJs8joDrXvkLAs2T6oYNfyRbXCuGP1b67uc8VXb3g=;
 b=bmUTo7y+WXT3jeoZnZzhuDLmZGLKL5qvE7VeN9OUKBdZzN5t16bkgVgCtPaP0pmnBJ
 SoOEWn1YKZkRvpRydhy8N/zJGwII3CzOoN8cw2zL5efw2bSfpRi0BuaMqmdi9tK5MIK/
 sfH8CIVTePqAUKgr0npKbPgVPh+qx34xHd7yIvoVm899+7L8wgzgl9Ok4sY4a2dtKFBs
 ILrD5mT30mCzLGGhaXDZjL00Fo8NBkwNnFveWyLua1ZIsHRSDK/bOj+uSz83qLSSaDT+
 HVNdj4BvE2Kv6DajnaZ/11yqbADmpY1+ItJABt2SIN8EmTgp4HsgV2/lflwobaQjhJ0j
 x6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w3QJs8joDrXvkLAs2T6oYNfyRbXCuGP1b67uc8VXb3g=;
 b=mx3rhntABhBYoJYDkYOLoN5+H1C2JaYQ9XnvHWvdIwVPn0prekX/fMRYhfVclxlLn4
 Gb5Szo1GNF5Ok3CqAi/AHR4haBX71X33nFPMXwGrP+K39PSvMnCydxducgx1H5Elt4Hh
 IWuBCHjeWB5cderVEYgGYoXtzA+o52ShKIuJc2EwpHtdaCSIP/YA+GUlv6X8/NNnEZre
 auv1H1IYHATejgPVVEeySA562ujc4CVecv6GSp0DSsM+c9XrNWEnGaaMYWFl6AqWPN2J
 WxCRNLmf9mf49+Xn4ZJU0e8Sh75UEEUWbLo8v+oHI5pWsjclAEV7o2OlR3PMxqCk842A
 Lmdg==
X-Gm-Message-State: APjAAAXu9Ji9TSM3GuyylJg8544c+1cOP7fE9pNCGqUydlaViM1zihsI
 fr98rAPRmJzy28a6yT6equNp38C1ZMdV9L+F36LZUw==
X-Google-Smtp-Source: APXvYqxy0bMHLvZ1VrTEwtwKIyzCUsG2Pbx1oTlFbb93vFIB5dNEW4NDiuWD64dctB4s/w7gTB9CftR48JMoJksodKE=
X-Received: by 2002:a05:6830:2001:: with SMTP id
 e1mr2540872otp.97.1575290000501; 
 Mon, 02 Dec 2019 04:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-13-damien.hedde@greensocs.com>
 <CAFEAcA-YiD6B1wMTrOvj5=QbYY3uuqdbJbSP57zg3S86nU=k-Q@mail.gmail.com>
 <1ae3a4d3-26e6-fe6d-87a3-d5dcce1fd64c@greensocs.com>
In-Reply-To: <1ae3a4d3-26e6-fe6d-87a3-d5dcce1fd64c@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 12:33:09 +0000
Message-ID: <CAFEAcA89bbvd0Zi44GZrCDc8e-AEKqGkJ3SA3e=Sz6xVHNbfEw@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] hw/gpio/bcm2835_gpio: Isolate sdbus reparenting
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 at 12:27, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
>
>
> On 11/29/19 8:05 PM, Peter Maydell wrote:
> > On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
> >> @@ -97,6 +101,7 @@ static void gpfsel_set(BCM2835GpioState *s, uint8_t reg, uint32_t value)
> >>              && (s->fsel[53] == 4) /* SD_DATA3_R */
> >>              ) {
> >>          /* SDHost controller selected */
> >> +        sdbus_reparent_card(&s->sdbus, s->sdbus_sdhost);
> >>          sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
> >
> > The commit message says it's just splitting the function in two,
> > but these two hunks are adding extra calls to sdbus_reparent_card().
> > Why do we need to call it twice ?
>
> You're right. I forgot to update the commit message. The patch also
> refactor a little the reset procedure and move the call to
> sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci)
> which was in there to this part of the code.
>
> raspi machines create the sd in &s->sdbus. So there is need for a first
> reparenting from this bus.
>
> With this addition "gpfsel_update_sdbus" always do the expected effect
> of putting the sd card onto the right bus.
>
> sdbus_reparent_card(src,dst) only do something if the _src_ bus has a
> card. So only one of the 2 sdbus_reparent_card will have an effect. If
> the card is already onto the _dst_, both calls will be nop-op

The intention of sdbus_reparent_card() is that it moves
something from the 'src' bus to the 'dst' bus. So one
call is supposed to do the whole job of the move. If
it doesn't, then that's a bug.

I thought the raspi machines had an sd card that could
either be connected to one of the controllers, or the
other. Why would the sd card ever be somewhere else
than on one of those two buses? If the machine creation
puts the sdcard somewhere wrong then we should probably
just fix that.

thanks
-- PMM

