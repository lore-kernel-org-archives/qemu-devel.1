Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD26CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 10:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1032073B
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 10:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6TjIWe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1032073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jez7q-000531-SF
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 06:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jez6j-0004NZ-CH
 for qemu-devel@nongnu.org; Sat, 30 May 2020 06:52:54 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e]:44512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jez6i-0002xJ-2i
 for qemu-devel@nongnu.org; Sat, 30 May 2020 06:52:52 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id e8so3461ooi.11
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 03:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vMfmCTWb0imwssAHTClDDjU/xyQXM5x5+2yO9O/NSL4=;
 b=g6TjIWe8McrCh00OfVR4kzTum5HXeTDXaHEFxPXYbuI0qF2WKxlm7xdri2l1Xj6Kat
 4h3k11AfIFE2kyBxZQIkP3JX4VMDWZbfJj2fXtmFVEa87wThcTSRvx59Eu3xcqJQkTPZ
 LpMgvJWXffGqT+LBtlzoX7KdbgySE1obNQNaGMD0TxldBEyKdMYn8+egckK4YMoc8AsZ
 YvDiFigWROiX2Uo0ItTwv7oP+61MS7AYmbQR/RXsLh3YldpkRByj6MXXIvj4hYuEk5zm
 hEjw4g7BS5fci46uo8pmWW8uVbO6w40LqlAvY7EkjWwkozA+Ddy4fBQuCKAdZwlDEiwy
 5sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vMfmCTWb0imwssAHTClDDjU/xyQXM5x5+2yO9O/NSL4=;
 b=X5LCNMVXKwHtxnCnCTAxijmYfV8sw0iNpHbmXr2/p/KbyMM9mNmMqELHnjXhv7VbMX
 pCW52h/G1XR6Fn0OZsT7aHQ6LLE6PcJXDukL/0mSOWglHQVVqXLH56KD2o2tddNR5xrz
 hcFiMBFdRS48Diozfe7wck7sYpyJ55g0fhZvAGHb9N/vkegsaABl6vIky2zZKGrxZjCu
 5rQEnIqfBzueM8HNhc0RwEmsd/GqjvvQGICTEKSwOIRUXpsCJYtn9OrWJwkf25m0dLop
 u0e3pGJu9HZwbE+U+fte40VIa/uzKJATN6VagFhGM5zupyv4Xc1vtQJdBcFLS0iD63OS
 xpQw==
X-Gm-Message-State: AOAM531OYzMjnn0ybx/H3RLxOsVrJOfqhY4eEIvJ7RFPfBV1y0rzQLJ2
 oItDk2mj4g/qp0ihmfAQsHsYS08LLoYv/X4relSLyQ==
X-Google-Smtp-Source: ABdhPJwbzfKnkTM8OGL1gKNxh6uEVgJUJ1xoTAuf0FzhnzZEeWMCvlaI5Wa1dd09u1b7Yt7AIT6JuiHss8vjViZhipk=
X-Received: by 2002:a4a:d0b2:: with SMTP id t18mr10194922oor.69.1590835970644; 
 Sat, 30 May 2020 03:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_Lr8ySUK_PUNVB+RRQhFhEQL2wFeJtdYAxZhhT1xEFNw@mail.gmail.com>
 <CAFEAcA_qiz6fa7sGJmqcHEwX9CirqXVrbVP6XaLcxfskrb6wYg@mail.gmail.com>
 <CAL1e-=jThKOGtG=tJT4ponkkZRTig1ZFAwJyH0vwrqxrr4Yaew@mail.gmail.com>
In-Reply-To: <CAL1e-=jThKOGtG=tJT4ponkkZRTig1ZFAwJyH0vwrqxrr4Yaew@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 May 2020 11:52:39 +0100
Message-ID: <CAFEAcA8mdUsuM+zaSh95S81yxMNgLdBaEacn5=jvwYn7kaqZuA@mail.gmail.com>
Subject: Re: 5.1 proposed schedule
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 30 May 2020 at 09:03, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> I really like "Tuesdays" concept. It worked very well for me as a submaintainer. I don't
> know its origin, but it works, bringing some degree of order and predictability, and at the
> same seemingly not imposing larger than necessary burden, and the end-of-week rush.

Yeah, it's just a pattern I've adopted because it seems to work -- the
first and last
days in the week didn't seem like a good idea because Monday wouldn't
give us any
time to try to investigate or fix something that came up over the weekend, and I
definitely didn't want to be trying to get tags or releases out last
thing on Friday
(it doesn't give us useful room to slip a tag by a day or so if
necessary). And I
don't work Wednesdays, so Tuesday is a natural choice.

thanks
-- PMM

