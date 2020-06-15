Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2614EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74E1207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdVDpl59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74E1207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkpBM-00011R-74
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpAg-0000VG-8g
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:29:06 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:39510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpAb-0004IH-Bs
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:29:05 -0400
Received: by mail-ot1-x333.google.com with SMTP id g5so13082035otg.6
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=00JybM0MXmULAioCguiRO9CK+vNJLXdxs45uJsFW4Gw=;
 b=KdVDpl59Xz3xlB1jacci+qUyWdzD+2lVklyLGQsBwIRV1YDTaF/UEhXtRKq7QkwKTd
 P2MlWRd1NvAiZ7amt0hKJyjm9/uOipY2YPC701PyxdQUn5qW1StuXzcHZe/yVaXArRYO
 cZ2YOOyFEGWjYJ6RCmSz58EUap3EKJOI3EVn/Glyl2LqNXJM+byWBUPH51kQfLccHHQj
 4bQVjCsb6Q/doU8bgu4erG+rK4QHW8fZIqM9cX6Y+QTvFPWl5qKp0glEFM+r4ExMdfAZ
 owhsFgzh87nnKq+ZlEM4w9ZEPPG0WZkjDWmjfwwGgK7fDX1P3l4WXBJBk2ijSaMzzImr
 OLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=00JybM0MXmULAioCguiRO9CK+vNJLXdxs45uJsFW4Gw=;
 b=q0QbHW2CwAppdL+52XDr2/+Fu57R4Vf5rpkkPaZ9wAOuTob+tIqC30O+etfZQqthDE
 o/1hC+HiAyoFaKU3Ayma102H96ZPNW7VGIcoe7Y8q83uQyKw8CX8qsDbvNvxmVXynPNR
 j8M5JB9kRr4O3zZsCQcdOwVSfGpiX+deegt5s5EnhmhYPx633jiU4J4Q9/Mbvm+Ha4yW
 e54NlrV64pKx2sJ2GOpcI5ftuupbJOObYfQRbHjWPxJciPc6Yqs7aaaPUiP58HYd3xqq
 m0j5vIt/EVi793poM4PDVTG3G9h1W8iq/nk6rAkWwF57k5T1S2uB/fl2ps9SXOvp2YVL
 FBpA==
X-Gm-Message-State: AOAM533emdoLUFNjcZyt/wxpZpEqBa1LkpB7VmDuEaFAoub6bO+SsNMV
 zpaD7Sqc4T/rFCUVKj38uKSXm7Bbmep0mRcJzOcjkA==
X-Google-Smtp-Source: ABdhPJwBEBXlyiGx5isrQT8vBhBILzNU3FnAP33p+Vd4Df6lIFtXLmkD80HclkpjYjl3lWmznc+T2rHyreTdx9/jiuY=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr21209862oto.91.1592227740054; 
 Mon, 15 Jun 2020 06:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200605102230.21493-1-philmd@redhat.com>
 <20200605102230.21493-5-philmd@redhat.com>
In-Reply-To: <20200605102230.21493-5-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 14:28:49 +0100
Message-ID: <CAFEAcA8kKjbc4wj1CYs0t0soJGHoPm7+JYkYsT-0BnB+TZRP1g@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] hw/sd/sdcard: Restrict Class 6 commands to SCSD
 cards
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 11:23, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Only SCSD cards support Class 6 (Block Oriented Write Protection)
> commands.
>
>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>
>   4.3.14 Command Functional Difference in Card Capacity Types
>
>   * Write Protected Group
>
>   SDHC and SDXC do not support write-protected groups. Issuing
>   CMD28, CMD29 and CMD30 generates the ILLEGAL_COMMAND error.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

