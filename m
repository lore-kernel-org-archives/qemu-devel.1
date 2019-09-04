Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F75DC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF6C22CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0iBndTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF6C22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5QSa-0000Qy-9Y
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 04:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5QRV-00083k-S1
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5QRR-0005Yd-Ok
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:15:03 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5QRO-0005XC-Em
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:14:59 -0400
Received: by mail-oi1-x243.google.com with SMTP id l2so15201658oil.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ofSdGbxial0Tz+WLmbAYdzO5nrNnJVDtTMFh6DHac58=;
 b=e0iBndTQDAw+15lyNXBygmT1TuPzCZG9MqU+o0tXaCqOF9vpQaFu3/VZr1ltv0WPZ2
 j1MyDgeRXaZPQwD2wzOCZ2vFc3xgGj6eXcH0lMWpUPQxxseZZscFB+ks04YDMR6h2X9f
 Nqp7uj5MwDpIdwNhG436ueNwPC57Fp2x5PTCmSky0WimKwxQblBLac8S68Py8I+AJb7n
 kE0xJJvT4f1LRpVF1GmKF2Lh667XzjF8PlCCi/3nvrpmPsUQGxPLayz/ENzGsAM1DRvR
 ctGHkC5O+Dz8CbxLDxtghBxnsN2WYStR+TUoudtouRVXYVMiQbEBwLXiXbEGxLmYyqqD
 napw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ofSdGbxial0Tz+WLmbAYdzO5nrNnJVDtTMFh6DHac58=;
 b=lLViSAwUvb5cZSq8745wid0FDNug48XhfdrFnH94r5D4DA0GSXJSs8aUto6gs5uC/l
 PrZ21pI6NLuosqwUm1/tGfaS0LFq6AHv73zWSJbMuRnBMAPwB/8G8x/C9ins8bfAUkUA
 9m6B0cexwOIf1F42o3qZh05KfhNTJyqfZds9jGzhr+2djgBz/h8dZMbC4kHvSntsMXSR
 N+Hl8GfgdfFPRy/lEdP5t/l/pIvWfFHlLLrbMLXhwqKNjKW3EzM0F6ok2nLX7c8sv9wk
 lW9ORegEcbfwkJgRqYy8OlGp+8u8+vA4Z+47cNxmAjnyiRE+KuoBOklP8x0EvI16Zi+v
 F+fA==
X-Gm-Message-State: APjAAAW0ZhvoBmOWKJMR97gPKcQhuSnfrWfM/YRXEoBoRzcmof0UUCda
 Z6sTwAMFSJhG1PfK1pyDX/qitDYe2oURIUcQ46AGUA==
X-Google-Smtp-Source: APXvYqzv15CFwaf9Wbd+ggZRTCSJl3iOJKZ7czjR8tgRRGuWwHbQ0cDMw3PQg5LkDt8G5rSOcWAF+Gs1Ww+TvtSBOk8=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr2369005oib.146.1567584895541; 
 Wed, 04 Sep 2019 01:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190801183012.17564-1-peter.maydell@linaro.org>
 <CAFEAcA-hBDgVKkzsWu=L63z85y23u3hQqzMLQgmtvMvTYNKhOQ@mail.gmail.com>
 <5c070cad-70d4-0b80-24f0-539599709cc7@ilande.co.uk>
In-Reply-To: <5c070cad-70d4-0b80-24f0-539599709cc7@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 09:14:44 +0100
Message-ID: <CAFEAcA9K4cicMWYMY_KeqYdxmt8Fe7hHEoPgDyPuY3dXc6_MBA@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 0/7] target/sparc: Convert to
 do_transaction_failed hook
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 18:00, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 03/09/2019 14:15, Peter Maydell wrote:
>
> > Mark -- ping? Richard has reviewed this series; do you want
> > more time to test it, or should I just apply it to master
> > if you don't have any other pending sparc patches?
>
> Yes, sorry - it has been on my TODO list for a while to look at this, but I've been
> quite short of time these past few weeks. I should be able to run it through my SPARC
> test images before the end of the week if that helps?

Yeah, that would be great. It's not hugely urgent, but I would
like to get this refactoring complete some time this
release cycle so we can drop the old hooks.

thanks
-- PMM

