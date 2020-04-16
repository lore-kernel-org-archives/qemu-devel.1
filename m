Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB6C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBBC22244
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="po+32DyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBBC22244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP6MU-000547-Du
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 11:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6LS-0003oe-CM
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6LR-0002ee-DG
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:22:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP6LR-0002e5-8j
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:22:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id m13so3361885otf.6
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ge2yQ0GbVdyo4A7ocWftWeRhBpa1p8Io8fLZ46j5vEk=;
 b=po+32DyCOLn9UtCPYKlsCBA9XXc/hVSEixDY9Ck5KJtHWBUzfuYSUaEl5Lcp3Z1WIg
 FZ/uyCHA9bNkC6x97AIRRrBmUmQujGPDdx0hHgTTECgLLKtYA1XxiYqkNNNIrTCclxc5
 jWgY2B7pbEJ6WMcG9+1xBa58tgmR8MMINWDvIp42v5G5K+9pNs0Rtu4TPQNIDyrtzD3G
 YGxriw+2y8X195EV4EwV274A3r9/8Xu5x5HoHGqYVKbwYe+ySqzPLwGWfBMarZcFbJ8O
 r7b47D+vK3TK3Nqay26vw6aNamwnJLfdFx8zdFE1fOVZ8EB2GihRH7RHhNLzh3XESK1g
 EBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ge2yQ0GbVdyo4A7ocWftWeRhBpa1p8Io8fLZ46j5vEk=;
 b=kKUMj6YpjQ8iWFkgPWx8oYBBxf0wUXT6WPrXb+cuXDrIjw5jPp7zmBGTynTgCQa6pu
 SnuraHDGlftfTmcpTWTh1m9quMbqWy4e3N7A9xVrDJhh26X63W5cUGWYWg6xFeibOpQ1
 oKGME0zwWcWw3sSqPfLw4ruqyyw7L6dSnYM4jmz8DjJDYRH0Zey13zU5n0+baVXIuMRm
 BHI4/cxb4BE9MZzNk25O89dNmbUlCGVx/H/pqVifqttiP4IEtZioJtlFsoNy5mdzDvfS
 fNHSPBWKC+EIaEg6h88SIbQIeCfb0M+dsf6S+ri9gjGmjup/Wtmg4q/6oHB2hTLjuCzp
 KhuA==
X-Gm-Message-State: AGi0Pub15F6WxPTBA34AgLDxEm+VHUogopTyUve4el4fl1wGRe8OZB8J
 q23WssHtysmq5Hzrbjm8P7MbuVCJTOY/wGqKvFyAJg==
X-Google-Smtp-Source: APiQypIFQylK6RbijQqdg5qdnQTzQpW97zvI7pQjZ1I27J5DAwb9XEBWrJvcXj1TwtPmuz1hspl1SiuUNyeJR8QK95o=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr5643398otc.221.1587050544306; 
 Thu, 16 Apr 2020 08:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200322211919.11335-1-linux@roeck-us.net>
 <20200322211919.11335-8-linux@roeck-us.net>
In-Reply-To: <20200322211919.11335-8-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 16:22:13 +0100
Message-ID: <CAFEAcA9J7SkzqDbxDiH1_YHkSRoyPKCLJDR62ED1b-7oKypT9A@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] hw/arm/fsl-imx7: Instantiate various unimplemented
 devices
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020 at 21:19, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Instantiating PWM, CAN, CAAM, and OCOTP devices is necessary to avoid
> crashes when booting mainline Linux.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

