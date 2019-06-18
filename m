Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD8EC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3C12070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oy33dy9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3C12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdBP9-0000Le-TV
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 06:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34531)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hdBOa-0008Fa-O7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hdBOZ-0005fS-OE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:31:20 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hdBOZ-0005dO-Fs
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:31:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id 107so13677222otj.8
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5+63sKQjEWxDjNPavIZp3aBHTo9bsItjTwBV7ypFB5c=;
 b=Oy33dy9aGOljFxXjebAJ1Vit+1bMCPAMIkbnvrGsb8QiDN1sqZ1uqswDxM4aMOahmh
 G3rSARVjlqEGmgAF3Fw0dEJS3TX5+jHKeFSdNgi2UtYOCaRTCggZx4/VntpZ8xUFhy3f
 xIQrLsq+uD0kDG74vc7AzvsSR/7+Nj898tnqdA5wM6+rmf8a2ugGVz/9fnacwxo7igQa
 XlXtXMHSyMx06dWlcIbYxwh5DPykAo2sLqOBTHwF3AHxF6/LfdMy3BPneIXR0xT0i6ZY
 P7uS2f6xZ/aXq/q4M4K00LCujA2PWjWy627BP/ZCbkIbxwmeJaDR1aWGG7oiVkAmFMTH
 7CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5+63sKQjEWxDjNPavIZp3aBHTo9bsItjTwBV7ypFB5c=;
 b=r0js3kZuTFtiDzEk+TflYk8NKp65DyEN2O3EjJ4iJj1et3FgIuPEorPBaCYQRMyjxb
 FXBBpBdCZDOy7g665p4QppOCX2gndJ+ZL71/NkAgd1pFzl1ikta+tZ6eGc1TkVdS1qRu
 DrT8pvA+lQb37mfonb8IA2cTO4VuPRuvn2ATg5yfIVqbnrBqJIbe6UmRkWyiqTeWGd5p
 PYKIrciq2E/C/MvyjamRTCl+XYiNSKRkuP90Zhdv31ePKAmMb1qAVHVUa7L94FhVgdPY
 7PJuzBoSzj/QlYna4Fdr5X/kXANNjEeMSiVqqKekypTqH0421k9PI2/wDsXNyHRHwdjS
 AQVw==
X-Gm-Message-State: APjAAAXRqpcUG/TioOohnFKRRkF9E9iGuJ1sl9vY90mLRgJRmX6t++yU
 QjlETJP8LLmItjvpk62gX9XtbpHv4aCAVGdHkLzAVA==
X-Google-Smtp-Source: APXvYqyMa2rFn3nZ0KGKrBCr6yIwKTBp73tK/vmMoiQmSdw2TndVKz2lj88VtbLvB3tcKcrpgPoumfeeP3q7TqWeC9I=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr62381100oti.221.1560853877464; 
 Tue, 18 Jun 2019 03:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190617175317.27557-1-peter.maydell@linaro.org>
 <20190617175317.27557-2-peter.maydell@linaro.org>
 <38277bbe-b942-337e-4a7c-dac3ad3a60b5@linaro.org>
In-Reply-To: <38277bbe-b942-337e-4a7c-dac3ad3a60b5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 11:31:05 +0100
Message-ID: <CAFEAcA9P=5=+Z9-+FXVAB=j=3d7XO3QhWYVGvMZd=-_YdPr6aQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 1/6] target/arm: NS BusFault on vector
 table fetch escalates to NS HardFault
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 at 20:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/17/19 10:53 AM, Peter Maydell wrote:
> > +     * The HardFault is Secure if BFHFNMINS is 0 (meaning that all HFs are
> > +     * secure); otherwise it targets the same security state as the
> > +     * underlying exception.
> >       */
> > -    exc_secure = targets_secure ||
> > -        !(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK);
> > +    if (!(cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
> > +        exc_secure = false;
> > +    }
>
> exc_secure = true, surely?

Yep, good catch. I got it right in the comment text :-)

thanks
-- PMM

