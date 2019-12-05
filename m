Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D46C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EBF24249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6pWO/TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EBF24249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvch-0002KA-TE
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icvL5-0008L7-V8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icvL4-0003gf-Sh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:54:55 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icvL4-0003gP-N8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:54:54 -0500
Received: by mail-ot1-x341.google.com with SMTP id i4so3395084otr.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 09:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pYOvYVtwhI2S/mDqdqrvk92S8L5OgxKP7rFHJhTjPR0=;
 b=t6pWO/TVK+5BkLfuWbEirKmZHs5GZ3vCHTiHCrxcSLP6tMsm/En+EqeIPXycN6wQfx
 j2QNH6wC++IIohwIid+BgS/i2O7wY3q19DrroInE5+fcQAU2x+CNv2Wag5qfv0ucwL7H
 n8rcQ5KM4yGrYnzbJdUU1jhwVy3i6W4VXCxYwP1AYQwtb7Fv/kKv5PJMSdM919CdgQ5/
 aAhCAm5F9/0VjGo//NjJAMj0BsrkVYC4dUfctkmhPiy4xodOE0znuHVYMilVc81AXfk+
 3HEYlvm6A59MrQLd7Zzv87BSgQy0I4FnYtWtebglYenojTluzNrwAHCaA6lhGQm0t0D/
 hhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pYOvYVtwhI2S/mDqdqrvk92S8L5OgxKP7rFHJhTjPR0=;
 b=dzHMlGzhO0HXkpr4JUrrYE1ZbUvd6aZAsi5GwY6DoIqMtsQQqeTq6gIkcAOjQYRHcz
 Kn24AuwM3H/LO7HcRE0FOiN3jA+c1//j/mVNd30+EbjSqTnK3CeQD0Ng3vyUVYLSnKWY
 LiITC50rfKl0Kih+izSERo2VwpKH+mAix6rdcKzOX9esJDnlEJMP9afn7pE8sHuSx5eF
 FANOTEyYIhHp9OIFYZrZCDI8GxKpJqquykY5cfY8w4xuUujXpI8PcWqIAo/AIX9JuFjI
 HPsp8eZAhh97FXom2sWBQU82lNhpm25gerJMsJuXL03sj2/j5bo/9hK04jFYJ3Q24ozE
 CLzQ==
X-Gm-Message-State: APjAAAUHgCqTbtzXrWCZuSi8WzENfRG+Hlaq3bZAjLlnMPjTYbINjCIs
 ZOhOPUgbhko7kgPjCMCvr+ESx0obg7fYtYjVZVQGVw==
X-Google-Smtp-Source: APXvYqwa0isRd5Y0BJOzA/tjq4CY7RRZbTy378LMDL4lhHjCfifwWS+qGfTWFsvY9rbYkEDYdVSU4l3b6qI4GPbPwpQ=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr7319934otm.221.1575568493991; 
 Thu, 05 Dec 2019 09:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-16-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 17:54:43 +0000
Message-ID: <CAFEAcA9TF5bQWpOccJynDSBVRekZaUbgMWtjxkiyKzmM7=g2eQ@mail.gmail.com>
Subject: Re: [PATCH v5 15/22] target/arm: Clean address for DC ZVA
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This data access was forgotten in the previous patch.

Do you mean "in the patch where we added support for cleaning
addresses of TBI information"? As written it sounds like you're
referring to the previous patch in this patchseries.

> Fixes: 3a471103ac1823ba
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

