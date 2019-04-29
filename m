Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F63C46470
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E15E21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZQaB5n8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E15E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLAaN-0001s5-Mo
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 14:01:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAZY-0001VT-HT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAZX-0006xA-Kl
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:00:12 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLAZX-0006wO-FC
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:00:11 -0400
Received: by mail-oi1-x244.google.com with SMTP id n187so9046950oih.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=gXGWIwiJqZLz2BKQse8qzQKUr44XobAk1ybDi6s5D9I=;
	b=gZQaB5n8mQQFO8HpnEV3vvVMf47aAQDjHQ9OQffxpgZGleoL8f8khUf0HH2FquiWtj
	b2sz/SxHs2ls+QR/QIvKwxsJVs+FKkvJ8nbbdJGBzVzCOCzxaGXclph+LJ1GBFcR9wCv
	SMD6WqaLrKS7OgZ2OUXr0/19o80l2duvqopNxYKNSsjmJcjPiE4QQ5X0lHeiMXoxZ2CB
	rl89pHf1pqMzb4Q6kH4nkd4QRBzkuHX+aH5q98iH34IeTDHmgJXw9BZFAjsiP/Ce7jCI
	5O+BaR1VGTN+u+s14f8SYOJd70LXAifrjL2malvDGkymAoAnb9TUyAAfAmxXJ99hXG9F
	G05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=gXGWIwiJqZLz2BKQse8qzQKUr44XobAk1ybDi6s5D9I=;
	b=jsG1hFoANlgPK9CRKetMuuiEq9MGV0RG37veRC2UadaCfPpaHLwaXhFb5MyBKD/iGi
	ocTOOj2dHGbYdhn7SIbe/FL9kPww/EzjRfh4dEEEBiCNtl6HACd6d7N4fXTBvvaqKi94
	tY5xY/Q5byFseM7+AMCYXclHXefo9xg+aOKavl/GiHmcgT+pBummQtZSVIJbsst1DdLW
	2N8nOJO2cmFw0gW7cd23VRjfMqturj50VMxhEv9un4bf+ljzlgDzW8bbiYP4SC/tlEKr
	H40V8c0MiqpXNJoIbGlHgW/GkxNWk1642o4p3whRX/AffIkWbXjmFHSFRLqE4K7EPT8f
	7KFA==
X-Gm-Message-State: APjAAAVVnG5VCWsi5flhXKzboJeNwjiY00bte5prgHGcTGoXdoWqtKqJ
	B9zY0OLjf8nhih09YbKhAaftGG59tDhCXFNmKebhsA==
X-Google-Smtp-Source: APXvYqwdj6pxBVyCkjV4RiLPuM82quliS/7OmC5AXyNioggzBHmfNMMgYnleb5MakS6gVmYwebydp9Ho6wITuS33WxE=
X-Received: by 2002:aca:4b04:: with SMTP id y4mr24502oia.170.1556560810455;
	Mon, 29 Apr 2019 11:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-19-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:59:59 +0100
Message-ID:
 <CAFEAcA9aOWheZjUCBMh3Bo8zvpeb1e9TvwKroG3Oo6cU1+0NdA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 18/26] target/sh4: Convert to
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429175959.IKxcD9fFnu1kfQ3Wd2bybti7QLRFCMPi-YTWopvTYbg@z>

On Wed, 3 Apr 2019 at 05:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

