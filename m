Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F389CC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3ABF20578
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkkKTTxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3ABF20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUKA-00061x-3C
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36796)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpUK0-0005dB-2O
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpUJx-0004xH-UJ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:09:28 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:33491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpUJx-0004vr-OP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:09:25 -0400
Received: by mail-oi1-x230.google.com with SMTP id u15so29071377oiv.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7tH282havsKLUoJQUzdU/9NNOG96wyfkfW1RtAF6H9w=;
 b=DkkKTTxKJUT2bu7pzGYes8EeWT3EV9ahbBFntgF8Jzl79NEXL0z0wboNtYGEXfuElT
 GorUwOygxDi7wAroyXN2gLOkk0tkpnzfRgTFq/1n35AelF6CnRPINUHr599CRnVHfAB6
 7KjNADkurPs3yWDlZVSQxbamGDt0X7qJp6a/yPDhEmna3RpO0Jr1ldokIpxGeH6n5tya
 I9gGpMkE/bml5Tri6Ns3z5DqLwRD7zHdGCilw4Lsb4CsdRWGmdZ5xKh7CCZnInHOkEiT
 XIwhdQkZ5JarCJL5BsZhInAMUi5Yjwh/gxtrLqphFmxf8k1wi/ES0EEZIl+XzWcIvNrI
 6JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7tH282havsKLUoJQUzdU/9NNOG96wyfkfW1RtAF6H9w=;
 b=CoCowWnsV/xnx1yIIugphtoPW+gF8av5XLoQfnFMnm3HSFPGiC+NNsBQv49KMJ4RXi
 tUMuvC7sxnHHFZdhREXCuZJ8X5LneZ9G/pVyL1HdVbMyjy0j1Xci83BOd/391kqI0ldH
 LgkH4XVyLbbDEKnFfZhbJ8mVR0SU8cfTvRIuX/F2m0iWSQPpmIK0Jk2dY3z09hs919cK
 Sz09cy3wkUcYoUwrSi5QeHuLMDODrv3bWi+Z35/vnwOquF5yntWWUuWCCF2uvKw7Yhyh
 Z6K0DxqgKwV4zO3kPv6WP4KDq/1EKOvfyjUhapSjk39RojRk3TWA+ux5DIM/d0dK4P9G
 oBLA==
X-Gm-Message-State: APjAAAWjIHKZvqweNUNEQsDP15Za8Xv5x1+uVrXvb0c35LLNoExiOkZx
 RRLu2gtFLEphosom5kREkmxsf4F/bYVx6NR/hp87UA==
X-Google-Smtp-Source: APXvYqx5v/eLAitafeu3250MeE/Zn2Rach4LwkNrmmF3WV6I9joSQULeCUcZ8Nd14AxZ9kOzy0e7R6ufFnZN0DFRWww=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr34573810oib.163.1563786564165; 
 Mon, 22 Jul 2019 02:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
 <CAL1e-=jE8X1ODnA0aSXe5OCqJzYA0J47h5b6=H_UivPP11zSQA@mail.gmail.com>
 <591d71a5-5b10-ab22-4751-01da8613d84c@weilnetz.de>
 <BN6PR2201MB12519E6C72689FF70B5CA3E4C6F60@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA946VCB=uwOe06v1BNdu8FMf_F4CoT8BeZAvSdRxrK6og@mail.gmail.com>
 <23c9b27f-c3ef-0f14-c522-951d57d4784b@weilnetz.de>
In-Reply-To: <23c9b27f-c3ef-0f14-c522-951d57d4784b@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 10:09:13 +0100
Message-ID: <CAFEAcA8A21Ek14pzs_E+z8+X4PnbCNtgozAY61_SZpJC9srGdQ@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
Subject: Re: [Qemu-devel] Handling of fall through code
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
Cc: Paul Burton <pburton@wavecomp.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Petar Jovanovic <pjovanovic@wavecomp.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 21 Jul 2019 at 17:39, Stefan Weil <sw@weilnetz.de> wrote:
> Peter, is this fall through for ARM correct?
>
> https://github.com/qemu/qemu/blob/master/target/arm/helper.c#L7958
>
> It looks rather suspicious and is one of the remaining related compiler
> warnings.

It's wrong, and Philippe posted a patch for it a day or two ago:

https://patchew.org/QEMU/20190719111451.12406-1-philmd@redhat.com/

thanks
-- PMM

