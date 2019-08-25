Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA55EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 21:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F47B206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 21:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqT8/Idy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F47B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i201Q-0004zP-PN
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 17:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i200Y-0004II-K1
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 17:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i200X-0002M6-N1
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 17:25:06 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i200X-0002LT-Hc
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 17:25:05 -0400
Received: by mail-oi1-x244.google.com with SMTP id q8so10420057oij.5
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nXjc4ujN8Ti2yYt/HglvZ3kuHstCglbKEVSqw7EoV9M=;
 b=lqT8/IdyU3LCx2Mdr6/XH7CUGmKyR1saOHer7uoZpVGymANh4O8Z2INyiXE9ptNurP
 8Y5pietDPvBB9QsH3RKj/+9SYrX3Tmu+URaUEZ2E7MVGEcSdPyzbcX+UPVahPUDWWYCu
 63y0sie41u2iqB/1x9EX+9lDIK9xjkHVT5MdCNfrWRGYFK8/na2QhPFeSwV6QFrBZD/q
 3whkF0cxD5QpIn0nvWCZKGFYZT5ryET0kCZHIFDogddbsq3DHoyFiObBp9WWbYBAxAsp
 oBq9kaSqsB5rAWtNwEdv7heIGxbM4mRl8WV6zrlpIXZRa82cYzxW+H6rcadFWPiKvc4i
 ZiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nXjc4ujN8Ti2yYt/HglvZ3kuHstCglbKEVSqw7EoV9M=;
 b=S9raJxaZd0FgCzgT5ZBklw5AbBpA9InTHCGkV8y//VS9X7WJ17+gNTVwaLcdbL9wxb
 isKq813apo8taEz+9gIQ/DiB4LXRJLBchjLQ2ngJeeD95d33kbhhHB4l3bEjZmBc7wBD
 CoGa6eMiPJRL7vl9DNfqDAo1svM6sXzR6EBfAC3ZXLMwc6X1L52U3nlsu7Sl/8X8P58T
 OFaSH7BWGi9xWH8rESgwJJD1nMzs86qEF2klYmbbtiSZTFMv1Zh6kYS7hUfcAgbj2UkS
 iXqoUpQE/zLeQgYUYe5dZL0Oe2NhPOZY0eyyUmuUdPvTXJla1pqG0Ilsy84mDy+U++Yp
 i/Pg==
X-Gm-Message-State: APjAAAUPhcqMnanlgsHsFTWfieV2v0gO5yIHLbzvd9mAxQmKsJDnnNjd
 bYnWVciegs128IzdwL34Fxo+SqwCeNqFTtzte6Hw1w==
X-Google-Smtp-Source: APXvYqwHxCvRPimf4vPgObNL3wDfydIJwIKTH4YKFNSF35dyk9L1wo0Sq3zU2M138e+YIGQ7DWJ/TTA+sIJhcdKglvc=
X-Received: by 2002:a54:4718:: with SMTP id k24mr9887873oik.146.1566768304377; 
 Sun, 25 Aug 2019 14:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-49-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-49-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2019 22:24:53 +0100
Message-ID: <CAFEAcA_geYNUvKuiGaBtL1bphZhhxQcNh9LTCc+DkM3v=0KSnA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 48/68] target/arm: Convert T16 add pc/sp
 (immediate)
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

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 12 +-----------
>  target/arm/t16.decode  |  7 +++++++
>  2 files changed, 8 insertions(+), 11 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

