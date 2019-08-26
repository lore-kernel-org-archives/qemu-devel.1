Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB73C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1563C2184D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbmslqeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1563C2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2KMU-00034K-8z
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 15:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2KLi-0002VQ-Ip
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2KLh-0003Xu-Ei
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:08:18 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2KLh-0003XN-8Y
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:08:17 -0400
Received: by mail-ot1-x341.google.com with SMTP id e12so16244719otp.10
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vCJU9i8aqvr04aQ6i0EfwlW8XMIwknWX/OBeWiLEgC0=;
 b=PbmslqeKsaVBe1CBmhxvtwz6/k0hW+4DZXSZ1PMobVAZHyIKPtwEPjKeBJ4OA5RgIG
 1/KTKjjRXvJ+XJUbbU4WbJ5AN1gBey8hOUuS0jtez409/nTtIQsJ96A8uGFMMuafDa2n
 Xf7+NgF4xenakd8+Ld6z1C08Hp8FcFGFXH75vdJHbp5nysEYAmcUhNfJU0Q/6pLdSliQ
 tkTcZ9Rr8HQF5R7fzCcleaumZUVD9SVRruRPOPDVQdAMkAQ1cIZlA0dW0z3lP6qVvzAI
 eJ51afBD93EHt/8YLfjMzzvBlAzYuYbl8nKapZuG9Ibot7zB+7frS50PECLvvvYqgUjr
 EtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vCJU9i8aqvr04aQ6i0EfwlW8XMIwknWX/OBeWiLEgC0=;
 b=n4rdAhuCzkYRyuTb2171dFCPKid3m8//tHeEmW3NyWKNKmxEd1gpPOvnZYtX4sytKN
 35gauZhSLGhfWdR70LaGboJrO0xaOWZZqWIpGS7Zs/xrVyqqoEWOjvHvz1dOELQwHrYA
 2kuZptF0u4zrEMdFGLKE2ZuQetpc/aQAVPpQHakGLoc/HzwSXSP/RY94G/guYmPozuPT
 /tuM/fL5/ywaNF7uPgoW2/PGhEnj0EDkVEyT8paQTBTcVwL79hN8/1rBueyYNI3VPlSv
 9hCbT4VUztkC5JK3EB17AIB0aiME1j5NCVLYcOvpd0Gy9fu2k3o7skkK8X4XXZdCHvMh
 Jakg==
X-Gm-Message-State: APjAAAWqjfwrEHJuGLKNea4vrHysekdwSL+//pILd5xhKMXpkHM1/Elv
 NBzMDkJ2lLKdnZjcgw56gIlWXhK9d/mtz/DuoMDRAQ==
X-Google-Smtp-Source: APXvYqy32cS6JuaZ6xrP6Ob5jimCLMNKtv1q9B8FQ9xr9JtItJvVPGG4udB1DYK/gpcdrC6a481YrT38g3M8WmVMpos=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr16022310otq.221.1566846496219; 
 Mon, 26 Aug 2019 12:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-56-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-56-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Aug 2019 20:08:05 +0100
Message-ID: <CAFEAcA9OxF20x_aBv-D4GUMx44LWUn8wgwLQPm=ZkQBZ7oyZmQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 55/68] target/arm: Convert T16, extract
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 14 +-------------
>  target/arm/t16.decode  | 10 ++++++++++
>  2 files changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

