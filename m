Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537B9C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D01A206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txtpsKaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D01A206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHm6y-00021h-8t
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHm5M-0001Gc-Mu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHm5L-0000VP-3I
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:47:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHm5K-0000Ub-Ry
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:47:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id 60so13534140otu.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Sdir98usYJaSxNxjLhnEPrKLAXbPzK6zXTfpOFV1Mgg=;
 b=txtpsKaL6JzLPFUE8v+JpWZHiHbOjI04yWWRrWGLE+rKm7EzEFE8X6BjkDniXiZCxd
 uoKeBML3xpoqxKPRgyPvD6ldtR0/nNRtN1brBHkuXlLddmUgCW/EUVgFgwJYJc7gdlsW
 k2+eG22ZO8/YrkrtZq3CUQjIOdzOPOPejle+2aM8gZOGmdtJCqE/kIZHkaA8isyjoffW
 OtKHiabH+6MgP6vPc9fIuoyurmfQ3+HG+F1GPYJk7tQiMlQYyFG/aSy0MSOAXDE2Prlb
 1lESBMoCG3G+4Z6O1KznjWz0VX5jzPr8V/F73sVdspkCXUWzCwiIYCTyiQidgNT5/N8f
 gm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Sdir98usYJaSxNxjLhnEPrKLAXbPzK6zXTfpOFV1Mgg=;
 b=Dm28xlMdeZEgp+jD17Lh0JqQ/fGzS/ndLzEgpMQUBwL9T7IfMHfbybaaO28J0UPlAS
 hH/0fn+Z5dbGICmd6VspOkz713SwVUwkT0XVoSysKzVkJx0J2M9cQRgR/XMJRcU11mCz
 UQKHfRiCVNj0Nf4bduVMOHafgVAxri2JeyDaNH8D02/+b62vROoIsKHpr+6BIa4xq8xm
 U5i46I8zYCN8kh8WDaTQtz5dqtcKGRqd7euM4qAvtXJlAnIEpNxF5W6UPVUJyYubstrI
 QNI2mnYxSSTkg0+a+V6nW2kgzuAVRlwHFTekJY2+NNze1ckezxToh8II9wLNplT2RXaw
 iojg==
X-Gm-Message-State: APjAAAX6vetGCc3u10/GUKAYLUL2la+UJwot9Z8mUnYY0FrhOdkoJpW5
 REmoaE4TyE/yH6IDMBDl7tr09YZctQI+lA+zmFA+Jw==
X-Google-Smtp-Source: APXvYqxTm1ep07p91RU4l2Rjxuvl4OlgudVlzoxV4WFXbUGwX0W8Nb544Nez8AzJ5zclPYZbvg2V63phiWM8hxg0qFc=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr23134501ote.97.1570528033957; 
 Tue, 08 Oct 2019 02:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190926151733.25349-1-philmd@redhat.com>
 <20191005174531-mutt-send-email-mst@kernel.org>
 <9a20b4a9-b255-95e9-1e27-94e294e21042@redhat.com>
 <20191007212406.GU4084@habkost.net>
In-Reply-To: <20191007212406.GU4084@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2019 10:47:03 +0100
Message-ID: <CAFEAcA_ymKafY+KCqBDjFtgf-_tRO1hH3Y4eaNNB3Pw6W0GQCQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] hw: Convert various reset() handler to DeviceReset
To: Eduardo Habkost <ehabkost@redhat.com>
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Oct 2019 at 22:24, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Mon, Oct 07, 2019 at 12:01:54PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Michael,
> >
> > On 10/5/19 11:46 PM, Michael S. Tsirkin wrote:
> > > On Thu, Sep 26, 2019 at 05:17:22PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> > > > Hi.
> > > >
> > > > Following the thread discussion between Peter/Markus/Damien about
> > > > reset handlers:
> > > > https://www.mail-archive.com/qemu-devel@nongnu.org/msg617103.html
> > > > I started to remove qemu_register_reset() calls from few qdevified
> > > > devices (the trivial ones).
> > > >
> > > > Regards,
> > > >
> > > > Phil.
> > >
> > > How do you want these patches merged? Trivial tree?
> >
> > I was hoping Eduardo would take them but he is busy and I even forgot t=
o Cc
> > him. They might go via Trivial or else via Paolo's Misc...
>
> I can merge them if somebody reviews the series.  How exactly are
> we making sure device_reset() is really being called for all
> devices touched by this series?  Are all buses guaranteed to be
> children of main-system-bus?

At least one of them is not (vmcoreinfo), as noted in review
comments on that patch. So while some of these patches might
be ok, some are not, and so we need to review them first
before they get merged via any route I think.

thanks
-- PMM

