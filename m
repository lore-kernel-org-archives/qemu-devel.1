Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61030C0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 10:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232B2214AF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 10:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8poNhj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232B2214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjhkk-0007MY-8j
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 06:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38772)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjhkG-0006uy-3l
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 06:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjhkF-0005AR-9U
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 06:16:40 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:35147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjhkF-00059p-3e
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 06:16:39 -0400
Received: by mail-ot1-x333.google.com with SMTP id j19so11406463otq.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2019 03:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8CbIpL/d8RMk73Z1kxStfL1+Aak90TmH8hkTnMh/AS8=;
 b=D8poNhj01itfyIo4VYtjQyoAZ3P0OI85U9S7o5klGOSuEuo3OCYrIPb1RQA2S6iZfB
 +saPV7VtHI/hMF7pT0IuFURhyzEZCRDC+299G/IzUcRrvjS6rOyPJdeQeDVgmsI39tev
 e/JIsk0w5iLtJev/M0RUAEc+s+j+iMguN0AuPwcUXB5oOlxQdIzFBkGGXquUL/EOhphJ
 9HG2sc/p4EnYgMLFjz6tCyuExVZbXThJxuGWbXzkgXJFJxNLfRudX5+gK7XJjMqYhdLe
 UQUpWWbLlUebo6LDEonYGKGLCmYAb0tODPOgyZ3PXMjjeta1cFc2cHbK08J744qWQdkf
 gUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8CbIpL/d8RMk73Z1kxStfL1+Aak90TmH8hkTnMh/AS8=;
 b=LABbqCm20ScWF085etpDtlmwD5DjlXClI9W1r+aEhgHF7J2+Hp40SxR/v7p25w3elj
 a8WQ8H45EmS82NrLZFOnaaHc4d8bymIwykGu1dBHrO8PoRR+OiMWoT/lpGhg2SETaJpI
 zGLsSF+GfIglLeaPPntzxhiKwLnMgsh+r0nSkLGlHN4l9X9H+LO6XjBi+Bwo5QTwrygZ
 eyFZtmvRH7MZGGHFd37EieRlJ19GWspwx+50EueBXfXrszHP1AE2uAewu9Q48up44jhB
 3gFZWNHVm65082d0imqBRdtgx9nOABFeyDlR8/KameHw7B4gvFv7mwIuMmY6VYA05AHF
 J7nQ==
X-Gm-Message-State: APjAAAV3gUOxeKKh64zzuO5iH2oiuxTlU+dTdPTytpccrMx+gRpdA35i
 +QCFbqf8jeu0CpuuHfTnbN9xzsDWLh953hPzmReazWHoIbM=
X-Google-Smtp-Source: APXvYqyB2t9i9t5C9eTnnwdwY/CfXTy620lYgPK4MGcSgrHlI5hX9ZXlx9NPzJ4f0tY0U8Uia7RTPNXVTORPEJw62lg=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr6536228oti.91.1562408197624; 
 Sat, 06 Jul 2019 03:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <3c8b83fe-120b-40e6-84d5-5a3b88e46ee3@ilande.co.uk>
In-Reply-To: <3c8b83fe-120b-40e6-84d5-5a3b88e46ee3@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 6 Jul 2019 11:16:25 +0100
Message-ID: <CAFEAcA9KjJUE7R0OYfM9AT=Ydu8eXBYJR=sGoGog25xrpRMZig@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] Parallel make build fails on fast machine
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

On Sat, 6 Jul 2019 at 10:59, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> Hi all,
>
> Today I tried transferring my QEMU development setup from my laptop onto a faster
> desktop machine (Intel i7-6700) and was surprised to find my normal "full" build
> script failing:
>
> ./configure --target-list='x86_64-softmmu sparc64-softmmu sparc-softmmu ppc-softmmu
> arm-softmmu' --prefix=/home/build/rel-qemu-git
> make V=1 -j2 install

If you just do 'make' rather than 'make install' does it fail the same way?

thanks
-- PMM

