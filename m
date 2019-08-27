Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90833C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B02921872
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dd7VtJUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B02921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2XtP-0008K5-3p
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Xsh-0007nP-VM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Xsg-0003Wq-VG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:35:15 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2Xsg-0003WC-Np
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:35:14 -0400
Received: by mail-oi1-x243.google.com with SMTP id o6so14407160oic.9
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TO1fpXR52tpiFBbHwXUbh6JkTBfsaP57UT07kD4OE8c=;
 b=dd7VtJUSq26Q6gc41K58Fyu4SEqCDxxew0AjxvOnS/ijiw43MyhT19Zo4ee0DhxuBJ
 VfEKn0a0A2H5J116Ay242aMS5muwuLgvCsD8+ZYKZNBqNTwoijuX9I8gmztj0oZGJHM1
 Y7ZcGTaknWKkTQRb0LlacNBm54YY4+kZWXt0oDW6Wn3paaH6ZVyICLpwcRcXyjXii7/Z
 LJT98yS2pJ6878Dp7j6K8wS886+CPfvJOr9jg/zZ7v/op0HVZ36iZa36lJKAPA/TlgAf
 yEUqNz92QbVmdIr+CQOVRsmAsWrJA4ee+6MYO0z95IsY9j688MBo+rmGDmuQ3BZgEMqE
 HZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TO1fpXR52tpiFBbHwXUbh6JkTBfsaP57UT07kD4OE8c=;
 b=g3Dneikz/QJCqqG4QhSR4SpwpaZNjqJ737h9tDscUaXQ8jVdxpjz7DIhwL0oyvTEoi
 Y3EOZ8e29lG+kJR919suJQZOXqR3PuSXXiqndLslMQNrdddmipT4Gv9LUMXi2AnRU6YV
 yx56lnKFs/nPmM9cP5PI2MeVQZZkYV4dDJDw105sw7kLL5DxoKv+8F/Wb9Ah5oN5R8ca
 bgAhaYt+E78NfssWYLgbk5GpLU84wCEvDP1X1npDuvRs5YP40j+S/Rw7fOffkLCQi2Ej
 Zs/VosZJdzsO305oOtcCHnlrYaBiS2V7YDe6WlBe8pPribNx+Pq13oc33dtttjY7h8od
 XgTQ==
X-Gm-Message-State: APjAAAW1lQY6wEi8LP4K+rCBPAIoqHRXpRWatdDY+hNOsWCwyK/mhIRf
 U+kl0QGsrI6jvsQ+OSOB2e00G1gcDm20ZK0ykTq3Xg==
X-Google-Smtp-Source: APXvYqwc0Yh9hsT1ONSl7WqWJKVaIjkQg/gFfgOmSEtE1Ewlm9Drgu2NFLG1iZvpwsk8uKAw6bAeGEZEyPzlcT4K1ss=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr14344054oib.48.1566898513845; 
 Tue, 27 Aug 2019 02:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-68-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-68-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 10:35:02 +0100
Message-ID: <CAFEAcA96kJ0bozeqiBeCzQ9X4pXkaJZJMK=xeEyWiDa8XzsurA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v2 67/68] target/arm: Clean up
 disas_thumb_insn
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

On Mon, 19 Aug 2019 at 22:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that everything is converted, remove the rest of
> the legacy decode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

