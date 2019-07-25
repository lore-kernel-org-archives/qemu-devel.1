Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B97C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3E1229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2TJf76+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3E1229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqhwK-0006Cd-Hs
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqhwA-0005oD-47
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqhw7-0002od-CY
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:53:53 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:40812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqhw3-0002kd-K2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:53:49 -0400
Received: by mail-ot1-x32c.google.com with SMTP id s7so6448047oth.7
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NqOmkAMehGJU1lKZgKzxjdK+SoGnCcWDkbisp/M5JbM=;
 b=Q2TJf76+8PEPGpm3/yts9OgRYrjcSCeHgmxVuFOAQa9rj66k2pI6fC7iJbbN12/9qu
 pE81i2+C93fMBxBrxEDoJJJ2IFx/+fP1L8ELqbMJCMAE8QzTVZxVtPmGe+WyjeFWbQr9
 uZZR5ve/tGMMDuzWlRbjLd5gqDJtP+nUKPyR4p5z2GaUbSM1hPbixY/oXOX47c6RD4DT
 0GnwRir2EMla54gOeMOUnDIqlGmoJvo7NT1Fss+RJJMhCQBxLgtQVnam1dMNgsCjo/Zf
 Vdd5e6aRtNA1qcRgI3QWaYBYcAP2ENQPpj50Jffj9jNujGW9bzNx7wdVDxEMX2W5tzIo
 ZZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NqOmkAMehGJU1lKZgKzxjdK+SoGnCcWDkbisp/M5JbM=;
 b=TDK3egarwDdDhSCG9c+Ef6u93qccR7oxRxx0KWWT8vPNtbCT6C4gj4xmnw/H6qTp4O
 CvxAMMguzCcWVmADwiwTrzSzZa03ycOE1m218O5pCsB2q3QbOAodq0T8JN1LB5pruWkb
 aX8pWUSmWAD22+Gt4XIg1dFY20TxrEOFAXpzwPEWLx3FT81Lby3SUla/uFN5zEsB/o10
 dZ5cYxvXxMBwbFs9YJXTeGJerKOJflRjSdYpVr1MVfcNPa6aOpXPyu2SLjJrescDY7fL
 H1RnBFOZEEXkJVfyCnV6+HNfNqxXS54na/OdEq3w5Ri7Q+EB1RKun/pk3kwV33/dnl0+
 JCkg==
X-Gm-Message-State: APjAAAUFi1rZ5ckl6HWWq9Z2otEUdtT49Ku1mBPwznnFlpXLgLT8xCtJ
 9XuZ2IQGLXchTPFbEnI/JAp2Ds8F0nFV7UyxkSjXXO5vyus=
X-Google-Smtp-Source: APXvYqz8n/MRzJnssgLHWTzsJR4wY+QyH6L532j5PF4BFbhOGmfVkZV3l7v4H3cYMQKN7odCCeQmmXyE8uv3ccsFcv4=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr7756491oti.91.1564077226360; 
 Thu, 25 Jul 2019 10:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <976a4589-f836-0f31-b682-f384e22149e9@redhat.com>
 <CAFEAcA8eCsgAeX1--jZubKJ+v1U_ioa2q_Ec7UAQiRU6bKTpLA@mail.gmail.com>
 <676de2d8-b7bd-1f16-8270-8bc5f7de8254@redhat.com>
 <CAFEAcA8s=YbvO7Qw4twt5NemH4vVbZX8_mi5LveTYgYYQY5YNA@mail.gmail.com>
 <ce2ae0c3-8b4c-6fc0-2be2-cf1883ccd1e1@redhat.com>
In-Reply-To: <ce2ae0c3-8b4c-6fc0-2be2-cf1883ccd1e1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 18:53:35 +0100
Message-ID: <CAFEAcA_FQ2Rp=yNunKvV2=2fiFZuEzKr48KqrA-mZ_y6j2SyrQ@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: Re: [Qemu-devel] Sphinx and docs/index.rst: dead code?
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 18:26, John Snow <jsnow@redhat.com> wrote:
> On 7/25/19 12:42 PM, Peter Maydell wrote:
> > This means you'll end up building 90% of our documentation twice,
> > which is something I was trying to avoid with the current setup.
> >
>
> Why? Wouldn't it suffice to build just one of the top-level docs just once?
>
> (I guess if you later decided to build the other top-level doc later it
> would duplicate the work, but is that the usual case?)

"make" needs to build the including-for-developers set so
you can refer to it in tree. But what we want for "make install"
is the only-for-users set. We don't want to build stuff during
"make install"; so "make" needs to have already built that set too.

The underlying problem here is that Sphinx doesn't really like
the idea of building documentation but only installing a subset.
So you get to pick which downsides you dislike least when
choosing the workaround. The current setup isn't necessarily
ideal but it seemed good-enough and to more or less match
the five-manuals approach Paolo originally outlined. We can
certainly change it if there's a less-awkward way to do things.

thanks
-- PMM

