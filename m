Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBB8C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57422173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoxKCJ0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57422173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40411 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP2JR-0007ej-W9
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:59:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP2HS-0006bg-Q4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP2HR-00040W-UD
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:57:30 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP2HR-000400-Pb
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:57:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id g24so498741otq.2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=EHtOaT/ARSac7sGeN9L3HNGWrGrb3bkgIx1Xcu+5V7s=;
	b=aoxKCJ0h1twnhndpk+ttlxBKXaueQ14ZEIX213bQYe/dcRIGgjYS8pG+NEuWNRaRjL
	3e7PKrCoybLhhVtFGDzhXW/aaAxOT85ADsf8tC2WzqWHuHhsmjF8968TuDTE6O6+lsTv
	QNuq+wINnlElPyK1GEV8Wz7eLZFJBUMamXO/mmpWJBtKQQKOJCIbrKALdoq+k0wbXKgb
	O627ZSYRKDsnnFM/hKNaDCG5G1/RLyVGtE5eBbYthXoS5ERYAeJC2jVb6SO8/k4cc8IU
	gGOIccytB6VwPwFzXMs3yACB5s2gAIl7JxZUPhBAyZMW4L8OxiqPsjhGRazpSeOJUiVB
	K7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EHtOaT/ARSac7sGeN9L3HNGWrGrb3bkgIx1Xcu+5V7s=;
	b=PFBjY9XGvdZRnunWIuUtbbfdiTBYNpugM9BNd4I6P+n4WZR3aydUMrHCuh2X3X+rAj
	jxGsc2ncDftsdclNM//9dRW6vNfH6kA+WBTuOsCq2frmmew01eNxKIvqF4iIlCd4+4P5
	NDj4scN0z44KDpJTiLDHXMP/YNRKo5AnWA9P1hbswq5nhXNFIs77slJUwK9PlpGY2fsw
	hrvw9M1JdrAOi3fkoFKnYItOik4aI/1EKBluc8z3JOLg3O0ZXYoPwpSp+KM+Di3T4Kp8
	zCWa7wI0DWhQjRC9wiH2KOztm5Vi25x/v5Fs8/vsZZgeaYJcIeA3PdbznX+teg9LdYKb
	zszw==
X-Gm-Message-State: APjAAAU9R5/uhV6i54Y8pMyW95X3VGMp76gmCsjGnDbKFnatuEUJm6mt
	P2Q5SfLTHf7ExNh6w4a+BX0hO1w2oQ7I12OenJzHKw==
X-Google-Smtp-Source: APXvYqxhf+DK6kGSk+seNv6HTAxNZb3E/psZ4Mw3jWuxudoQrAPndtTwjmd5DBdcJrDCMxFAY8irQTFYn2AOE83RfvQ=
X-Received: by 2002:a9d:404:: with SMTP id 4mr6056072otc.352.1557482248934;
	Fri, 10 May 2019 02:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190509222631.14271-1-richard.henderson@linaro.org>
	<20190509222631.14271-21-richard.henderson@linaro.org>
	<CAFEAcA-pGmH0VOhRnmcBGGM_bfmF8pBobJg2u4s=XKwV6HnFxA@mail.gmail.com>
In-Reply-To: <CAFEAcA-pGmH0VOhRnmcBGGM_bfmF8pBobJg2u4s=XKwV6HnFxA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 10:57:17 +0100
Message-ID: <CAFEAcA8Qxx9e3g1Hd7JKm4RU0OnXPC=vLpMii78hOb8whgkjEw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 20/27] target/sparc: Convert to
 CPUClass::tlb_fill
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 10:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 9 May 2019 at 23:52, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> > Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> > v2: Keep user-only, sparc32, and sparc64 tlb_fill separate.
> > v3: Assert !probe for sparc32.
>
>
> Applied, thanks.

Whoops, triggered the wrong canned reply in my mail client.
What I meant was

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

