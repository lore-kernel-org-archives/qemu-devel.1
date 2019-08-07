Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7029C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8431C21BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FG4BZfJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8431C21BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNsd-0002ic-SB
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNrn-0001jm-CO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNrm-0003TL-5L
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:28:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvNrl-0003Sw-WD
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:28:42 -0400
Received: by mail-ot1-x342.google.com with SMTP id q20so105776075otl.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vsWAd3sS+abRbYDwBUJmXOh15cy4aX+CfS9hDhks7DQ=;
 b=FG4BZfJEFkrslbfAitSQfpiiWhxrb3hyjOf1fcyk4TiavPCc6vX6efpJbFD2WDWprz
 vDHZ1/L6DR+X811JKk2xQGnbt/kWMcCZDzcvKDyTbYxDC8db1hjCPsoKV3KhKaLB3Ad7
 GuTTgdxtVOMJOXxlORiKEvzf7K2D/4OPsAFP0fQzMBuPFfmZ4nrL/GMVVDvISs4TDKqi
 PRcZxYlK6VgWO/VLxFk02wfh1Ah/V25K/yGYOjZAcAVSQmBF7YtO5vka267d3hBwGvWu
 vdP1q7WlL+y2z2yknV7KCdRRbQxE7i1Sm9f/YwaNPWDrJNkP2OR5Cd54AlCtqWoJPyXj
 bFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vsWAd3sS+abRbYDwBUJmXOh15cy4aX+CfS9hDhks7DQ=;
 b=FPWa2V+4Nxwd43aW5dK+z/70DTNFwY4ILzbN8ka0Wp19+oPftC7Pa1uZbj51flQ/sU
 htoY3yhDLvbCMltzufVVIjeB1s0OPl5lj3cQicKjz4lMmuRKDJyC/5uC4iofxRaOUeoj
 nd8sj8v6semSahTbIwfPpl3DQPYh7ysm6hEObmVIK4JriqPCi4zGANyxXWHAUueL622m
 LyFn8nhQSeBGYzZCbaH1b6zbPg/O3wIC+anBFRZlITynWsO6nKK3sEuH1+xxNK+1jDsI
 JCHH8s9wHnzgzoMFDsyS9NaHhqEG3pmEpoiVCJqq/W3DVJv3876rAOCFk0r7cBPDR1bZ
 /HSg==
X-Gm-Message-State: APjAAAX1lSYIW6ED9Pum7SJS1Ea2KOVdVBVdo+/e+dmmdS9P4igH47WA
 rSGO3DQohrLE44ipJi9G4Cfxs1WTTUKXcFhAH2QKTA==
X-Google-Smtp-Source: APXvYqwsKCSu0YiGlH524zOCHGpebwT49BSbfF5rulyUhko3FSXBG+dEb4oLxbLOmhmhpkyMvsy036blbAzSoaJ85wY=
X-Received: by 2002:a6b:b593:: with SMTP id
 e141mr10236695iof.203.1565191721376; 
 Wed, 07 Aug 2019 08:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-5-damien.hedde@greensocs.com>
 <CAFEAcA_WEf6YKwMWbE0=Qqn1NfUN-Hwr9iMk1PKe0ZxZfVfwVA@mail.gmail.com>
 <625412c2-1866-7c01-3035-334335088fa3@greensocs.com>
In-Reply-To: <625412c2-1866-7c01-3035-334335088fa3@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 16:28:30 +0100
Message-ID: <CAFEAcA-Jmvu3rYU0Q99+hm-Gg=v1Y+Azrr8J8iZ7cW_BiSpUqw@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 04/33] make Device and Bus Resettable
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
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug 2019 at 16:23, Damien Hedde <damien.hedde@greensocs.com> wrote:
> On 8/7/19 4:41 PM, Peter Maydell wrote:
> > On Mon, 29 Jul 2019 at 15:58, Damien Hedde <damien.hedde@greensocs.com> wrote:
> >> legacy resets are called in the "post" order (ie: children then parent)
> >> in hierarchical reset. That is the same order as legacy qdev_reset_all
> >> or qbus_reset_all were using.
> >
> > This is true, but on the other hand the semantics of most device
> > reset methods match "init", not "exit" -- they just set device
> > internal fields to the correct reset state.
>
> I changed from "init" to "exit" due to the change of the init phase call
> order to parent-then-children.
>
> This is a consequence of what I found about the raspi reset: it changes
> the reset hierarchy during reset. The only way I saw to have a chance
> allowing this kind of things cleanly is: do parent init first so that it
> can setup its children before they are considered for reset.

Changing the reset hierarchy during reset is a bit awkward;
I'll have to have a look at the email you sent about the raspi.

I can't decide whether there's an obvious "natural" order to
want the phases to be done in for parent vs children. I guess
it only matters for controller devices and the things on their
bus (eg pci controller vs pci devices, scsi controller vs scsi
devices). We should figure out what the right semantics for our
new multi phase setup are by looking at those, I suppose.

> I can put the legacy reset method to the hold phase which is part of the
> "enter reset state". Otherwise I need to change back the order of init
> phase.
>
> My other concern with putting it in init phase is that some device do
> things we forbid in it (like setting irq).

Yes, but those devices are broken today, because we forbid
setting IRQs in a 'legacy' device reset method as well!
The correct fix for those (eventually) would be to split the 'set irq'
part out into new-style 'init' and 'hold' methods.

thanks
-- PMM

