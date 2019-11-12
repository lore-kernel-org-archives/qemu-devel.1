Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75110C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F26820818
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqkQGZ6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F26820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUoM-0005XT-Cu
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUUnX-0004ZT-Rq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUUnW-0000hw-HO
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:57:27 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUUnV-0000he-VU
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:57:26 -0500
Received: by mail-ot1-x343.google.com with SMTP id l14so14031807oti.10
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 03:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mHpwGMoPzVkjMtJKGRfojVDKC+X1kuu8azyLDSIFOE4=;
 b=pqkQGZ6STXIyXNO4PMpO1Yen/Pj4jbOobXe9Pewp56aTepFfn964MHsmDQCZAN5uhq
 R8PU4Xjs1cKsQGQdrT3PcNJdxL+gcs+psvSXjRtR9vsIk78uozNerRKc+rDnegADqX+s
 3UHPthspSxA0Tkah9vqod3p6lF09oycDAQgdoP9pCe5nZm2+SVen6HDiSEYNd7tlDEVM
 GH+ddjvWFSvkOtomPc5gpV7ZZI7c/2fNeLnb9007YUIw3HJwwviECrvWowzI6mlmCSW6
 5nHNy2pddcqZ8Zd8YY5V1d/wX09sjI9TYmR41N1Xm7IRPkMKf+OE9gbMkkRInoSnhIGf
 MsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mHpwGMoPzVkjMtJKGRfojVDKC+X1kuu8azyLDSIFOE4=;
 b=ZjcXpYeEKFRjbFOtDxL3xfzbsEKt1dR3dqYmnDCSHTyNEPbycA1uWGOS767OEN+XQT
 3Lhh2kCyQy6LDeVxd8TLdeAy2QpSNNRkGJOVaLBy8adAzx7OW7xeLCgjcFKJtR2prIGh
 kcC4y1Abdu1D77V35v1wtttSASbrOdvgdRm+bQYBiUjrYzjGk+p02nipr1liKmcxViVk
 NdySSXY38uYbZcOZf8lAwP+Lhqu0VxF2AVckco6nvnbnShHAET3Vxp0lmL+twHkHdcft
 4u3MLz9KM+Zv2u2EokOyBdBoRJJAq/wNTayvi1pkBgf+0/ZjYSSJAEdrknD6QnI3UXVb
 5saA==
X-Gm-Message-State: APjAAAUKAEOcJ1LW6i3VhbXJM+LUw8/epFjEofZLoKpz87J2SYJXK815
 V/DqaZMEo4bR9t7lkLMlf7f76d2pGBcHSNnwClHCyg==
X-Google-Smtp-Source: APXvYqzvWiUMaXUA0GTitEP9X7HvLd3GBuL3U28I/qW73lQTmUCNiaX1f1O5y8ulNbtk27e9AA7P9Chh2pb+cUG6Onk=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr15265137otn.135.1573559844701; 
 Tue, 12 Nov 2019 03:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20191104115228.30745-1-graf@amazon.com>
 <CAFEAcA8zkR_MZ-28Nc=x4j05U9MsFYfzQtkHxTf65ZwacK020w@mail.gmail.com>
 <246a7cd4-7c39-c92e-05c3-1045bca2c114@amazon.com>
In-Reply-To: <246a7cd4-7c39-c92e-05c3-1045bca2c114@amazon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 11:57:13 +0000
Message-ID: <CAFEAcA_kwscZRqK5wTRu5WLkixGYbdV0c7mZMV6n+40DOS0-Mg@mail.gmail.com>
Subject: Re: [PATCH] pl031: Expose RTCICR as proper WC register
To: Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Hendrik Borghorst <hborghor@amazon.de>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 at 07:28, Alexander Graf <graf@amazon.com> wrote:
>
> Hey Peter,
>
> On 08.11.19 17:58, Peter Maydell wrote:
> > Did you find this because you had a guest that assumed the
> > other behaviour? This bug has been in QEMU for a very long time,
> > and it seems odd for a guest to deliberately perform an action
> > (writing 0) which is documented to have no effect on the device...
>
> We found this bug by trying to find justification for the behavior in
> the spec and apparently my spec reading skills were lacking. I could not
> find the reference you cited above.
>
> So no, I did not see any guest breakage.
>
> I still think that being consistent with the actual PL031 spec is
> preferable though. If any real world guest breaks because of this, we
> can still revert this patch and document the exact breakage in the
> comment instead.

Yeah, I agree; I'm essentially just gathering material
for the commit message here. (The gold standard would be
to go find some hardware with a real pl031 and prod it
to confirm behaviour, but that's more effort than really
seems justified to me.)

thanks
-- PMM

