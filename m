Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18798C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7D820674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrxXVlrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7D820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUHE-0001f9-VU
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYUGZ-000186-HR
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:44:11 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:33493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYUGY-0001Lh-4P
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:44:11 -0400
Received: by mail-oo1-xc44.google.com with SMTP id b3so980135oob.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H2uAqVYHNg2yvKLW2FO44iqltVo4e3uY0P/Jgote3O8=;
 b=vrxXVlrELUH9qpVByiX/6ZKIwwyt+ti4cYs/QFRu8GBmLxucesBGSXHTGS7T3c084B
 UAPABK+B2q1ehC7wHdZ7NZQw4sOi7JCPPcMO42nTvAIN1pmBtVHfKYY1Bz951w4ag3SG
 eSRa+vs564t87w0Pm3kwwsVbq+YEdF0uaYUzXmqvbznrm7W9Zw4C4Kx2gH7dxD63zF/Y
 pDqmS9F5DtyaeE1w+In+HNBgjaIil58pTb0aK5re5KDwCZ8ItK/YpCauEZhH/YeaInD2
 Pk6E+eD4TYLIInkRzg+30Qmq2ATxGPTgodkWAoj6EP+qv6kG949MR6fZreAecpIVfCo+
 culQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H2uAqVYHNg2yvKLW2FO44iqltVo4e3uY0P/Jgote3O8=;
 b=e0NhzgW2B6SrkR+AubAXN0z69Z8+aa2t7H3DrFbEpV82XJcCfnX7VMa+EVuOsUZkwX
 7r7GAdd8BedKUVMoGHanzz2Ym7oVfbKtwVZVoUFFmD0W4lcc8HGnIBEKx08ahrh/vnpd
 YAWNFyUvMnxTKDVSq3wthppCw7dDWnEI2YBMz81a+D4W8qxQKwFkc2mjmxr54BDsGWA+
 qpLb355+1pBcOxQnoLUuvYIs+fDJosQFLxt9WQLTAGQbt5z48+5C927S9Uz+QBkuiPmq
 TNWSSXOghCmZw7IHYoux+akPdGaxsAKIWlrvDhXgaUsDmw8RkkEettuTd2z8f5NPIoWp
 vLzQ==
X-Gm-Message-State: AGi0PuYswQa0BzjTizO0UFqQE5lp4YyVRRWu/TB0lIhFB+CiqUdQiaQ8
 bkQEPoruB/I+fRBZd7Oxq2mFuSVxn1ewXQEScSN6ZQ==
X-Google-Smtp-Source: APiQypI/2xXb3tDrFvY61Uph5x6b2qFcinLg1gwlWVlb7fRgiKmo/1AP440puBH7Ff6yUUlhr2H49I1SyFm2mGNAeBw=
X-Received: by 2002:a4a:3556:: with SMTP id w22mr11981224oog.20.1589287448622; 
 Tue, 12 May 2020 05:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200420212206.12776-1-peter.maydell@linaro.org>
In-Reply-To: <20200420212206.12776-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 13:43:57 +0100
Message-ID: <CAFEAcA_T+07JhcY8rGLW6dchsfyez54fenZtJAYV++d+dxzn9A@mail.gmail.com>
Subject: Re: [PATCH 0/4] linux-user/arm: Fix BKPT, SVC immediate handling
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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
Cc: omerg681@gmail.com, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Apr 2020 at 22:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchseries fixes issues with the code in linux-user/arm/cpu_loop.c:
>  * it incorrectly thinks BKPT is a syscall instruction
>    (https://bugs.launchpad.net/qemu/+bug/1873898, reported via irc)
>  * a stale line of code means we incorrectly NOP SVC #0xf0002
>  * we don't implement the distinction between 0x9f0000..0x9f07ff
>    (should return -ENOSYS if not implemented) and higher numbers
>    (should cause a SIGILL)
>  * we abort() for bad immediate values to SVC (ie not the 0 of EABI
>    or the >0x9f0000 of OABI); the kernel delivers a SIGILL for these
>  * for Thumb mode, we never use the immediate value from the insn,
>    but we always read it anyway
>
> This patchseries fixes all those things. (I started out fixing the
> BKPT bug; everything else is problems I spotted along the way while
> I was reading this bit of code...)

Laurent, do you want me to post a v2 with the -2/-4 thinko fixed
so you can put it via the linux-user tree, or should I just take
this via target-arm.next?

thanks
-- PMM

