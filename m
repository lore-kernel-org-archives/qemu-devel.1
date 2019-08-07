Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27018C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FBD22297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaloFjre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FBD22297
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvORL-0005gS-5F
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37042)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvOO5-0000mc-JO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvOO1-00067c-CE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:02:03 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:47061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvONz-0005uw-Pu
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:02:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id z23so78001495ote.13
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JRp+GCBhRCvNVP/Ko71Bv5RLsa9azOABccrtfnznMFM=;
 b=NaloFjreMAMcG84k0+ZCWZGy/vgs+qon7TMAIa7UGyq/+pRaZByvToXFaLIOicEPcG
 UDKhyA6k3r4umIx8jhOrY0oo/BaYr737yaTEn+49SDraChk7NIuUFhPTucwuWI5Y/cem
 r/jxW+bXrSdOepnRIVExwUymgWw7VYGMAlpGVmjC8lUgRyaYU8jaEQq/hWpsYMLDel4h
 msX9Mvtd+nucMK74JSNIUBEc3Jy6rKlmMDzw1+S5CaBiyvdZUpY7Att8qkMiMZwhVoJI
 ZNWacTc/ciGzhV7xrZf69j2BBuanVH0N5+47W1d7js67HEpWYyTXLMVJjMHz86Sp8LJc
 QWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JRp+GCBhRCvNVP/Ko71Bv5RLsa9azOABccrtfnznMFM=;
 b=tZGeTL0eUu4yQulgk5lfpyLdJg6zH06J2S8aNEEzMCFjXbc7T+XqsJEwBAGqagoFQR
 524b2VJldYTEuUCCjpU4cLvHSsi1ICGytwXr+rKWP/TepelvTZ19yMLqibkUsWVvrEWY
 CgtNqUh9PyrLKtWV2EYYGSdW5TZLTxVU3zJffvmnVke+R5b396PFSUHctzxyfrx/5DnU
 9qR94Pb4jaWAX8m00NZpEJDJ/BlMplRe2VhIqFUXJFK9+Ndo2tC38sTKnbjsqpSUdkfC
 0AN2VLKoz2A3JetUHr+UmYissTFVJE8QWFGsMMOH7fQXEqHKWj8VO/IftVXBnX47ghPu
 +4EA==
X-Gm-Message-State: APjAAAV/fCS6aK2gPsa40AhV8dVyuWaG7n6ODDZAoZzngRX8293byocR
 oFfWh6BWQGGJb8IMjGYFWN9r0+PiwsZ5VBOHFQ1s3Q==
X-Google-Smtp-Source: APXvYqys3WQHQirVD5rzB9dLAHkiy+bv0dmhOTA9X55Li3gTlJ/YMzIF2jjmgdZ1nJ3NMvuvmcSIRkuz5yNNHQpkYS8=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr8913557oti.91.1565193713448; 
 Wed, 07 Aug 2019 09:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-10-damien.hedde@greensocs.com>
 <20190731063044.GG2032@umbus.fritz.box>
In-Reply-To: <20190731063044.GG2032@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 17:01:42 +0100
Message-ID: <CAFEAcA97PbDP3XrtHCXuiwZorC7B8hY_EGL+iRLsJeC=L=kekw@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 09/33] add doc about Resettable interface
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 31 Jul 2019 at 07:33, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Mon, Jul 29, 2019 at 04:56:30PM +0200, Damien Hedde wrote:
> > Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> > +For Devices and Buses there is also the corresponding helpers:
> > +void device_reset(Device *dev, bool cold)
> > +void bus_reset(Device *dev, bool cold)
>
> What's the semantic difference between resetting a bus and resetting
> the bridge device which owns it?

We should definitely explain this in the documentation, but
consider for instance a SCSI controller. Resetting the
SCSI controller puts all its registers back into whatever
the reset state is for the device, as well as resetting
everything on the SCSI bus. Resetting just the SCSI bus
resets the disks and so on on the bus, but doesn't change
the state of the controller itself, which remains programmed
with whatever state the guest has set up.

PCI has a similar distinction between resetting the controller
and resetting the bus.

Note that we have this distinction in the current APIs too:
qbus_reset_all() vs qdev_reset_all().


thanks
-- PMM

