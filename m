Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3B0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BA122CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdIqaTEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BA122CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i544e-0005tE-TV
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i543z-0005Ro-Fb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i543y-0006Cb-GA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:21:19 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:38484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i543y-0006CL-AT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:21:18 -0400
Received: by mail-oi1-x22f.google.com with SMTP id 7so3935744oip.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gFRlwDYifODrohqCjNVPYTwkRzClI6HFFM8x02R+9QM=;
 b=CdIqaTEEaENDYKCwOOC8vwZ/dBTqrZaFx5epw4/tri0YicpwBJXWdFBltOuGaJHQTt
 A+XLvOKqxAkGDXAF425RFCFF3uW7uxYihiNvA/JCRq++6XIGLIT/UrD1zy9Fv6EWnuwA
 iPQufmDxI+Hnp0A8eUtctqkM3o0GtqJNCUFVg+PuPfUaytxaj5x1AeTuAsJMC7+afFQN
 i/ebmre9KROWiXkb24888scNIOJscXm7WJ/m0WGzmgXbP41FsBOMy9CGuQJQP8+mMSel
 q4Fc+nbwsBFirbqKCSqfeK4j306CV8KMNvwzFY1pCNNvmh2JnTx+3JUwb4dTn37R9JBO
 2Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gFRlwDYifODrohqCjNVPYTwkRzClI6HFFM8x02R+9QM=;
 b=qpFdkvJBEy8QkuoGUrhF823FaN84T5uiypizUujEeuKbfHFo2IoVlokbgkQ+S1c5SD
 KHhSnmK7KJiROFTFYC30IIHHOhs+MVZTJssZxNBwN+QLGozw/Dt7a6FIDLlOJqPCKHp7
 mSRQg0crM1/5vuEoK2mMSf5iJxtDC38MzFWf9n4wSG53qZSSUD5+R1aslUaU0ASGf6nm
 GOQR43+0sx0Ea7n74uMNYNaQ0iu2y8hHADOWITkVPqAiJd2b3b/3q2L4+40vuAwory69
 Z2X0ZemPtgVVYgBuSZWrlfYWb3CnofLos/Gnz2W0KTzbpS0928WM+4TS/wV1NJmpHw9/
 hK6Q==
X-Gm-Message-State: APjAAAX0NoYFmFEb2jUP71gPuf3XnE4KeM/FdhLDwyaaNnZ/pYqImKV7
 cgQ4AqcKer1libBFyoq+UHtSjo+tsTonCvD+W+F1Gg==
X-Google-Smtp-Source: APXvYqyWyDeSflQ7mXYBm9YKAHUl9IgIzoNyj/rgVZPi9DTOBiFFWZsMQ3/RSj1Yms1YpSh+cuwCYK6Vbgu2PCrvrNw=
X-Received: by 2002:aca:281a:: with SMTP id 26mr3789945oix.163.1567498877461; 
 Tue, 03 Sep 2019 01:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJzA9zP0GnZ17_YSxUhAGFrD_fCM-R=rxEVN5y9V-5-5zTsnVw@mail.gmail.com>
 <a7c948d1-1c2d-aee6-96a3-bf146004fd07@redhat.com>
 <CAFEAcA-Faa7j+Dv0L5KPDDwuEvaRMNYNeUNzB8p=ceD3vhyzDw@mail.gmail.com>
 <ca896264-89fc-bcb6-9e21-b411bd4f9a01@redhat.com>
In-Reply-To: <ca896264-89fc-bcb6-9e21-b411bd4f9a01@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 09:21:06 +0100
Message-ID: <CAFEAcA_fZEmsTuHPnUA-KFZLKubrOR-Ggi58HUVKrFSuMx4PSA@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] GSoC project: API Documentation Generation links
 and comments
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Gabriel Barreto <sbarreto.gabriel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 22:01, John Snow <jsnow@redhat.com> wrote:
>
>
>
> On 8/27/19 4:56 PM, Peter Maydell wrote:
> > On Tue, 27 Aug 2019 at 21:52, John Snow <jsnow@redhat.com> wrote:
> >> - For theming, I'm a fan of the RTD theme, because I think it makes the
> >> TOC tree stand out better and makes for nicer browsing than the default
> >> alabaster theme. Maybe when there's a better over-arching TOC laid out
> >> with better organization we could see which themes the list likes best.
> >
> > FWIW, for the in-tree doc generation I opted for Alabaster
> > (though I prefer RTD's look as well) because Alabaster doesn't
> > require shipping any fonts, whereas RTD does, and it seemed
> > easier to sidestep any questions about whether a font file in the
> > docs was mere aggregation or not. For "putting docs up on the
>
> What do you mean by "mere aggregation"?

I mean what the GPL means by that term, ie the situation
where you can put a GPL-licensed thing and a non-GPL
licensed thing together without the non-GPL thing falling
under the terms of the GPL. (The canonical example is "Linux
distro CD which contains binaries for lots of different programs".)

thanks
-- PMM

