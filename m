Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FF7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3E92076F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9sR8Ago"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3E92076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGmT3-0007pB-TJ
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 12:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGmSJ-0007FX-0R
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGmSH-0008LG-TO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:31:06 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGmSH-0008Kt-N8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:31:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id e9so10678882oii.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 09:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dc8Bru6669X1ZJa5m4boFqQI/c3OuuO5FFR+Em8EZR4=;
 b=p9sR8AgoUU7dxXa8R8d5J+LdcbQY6aL7seXJpWFmdNLeBNUDCBOuRaw0NxS2RcPJZu
 Gk+JLls4pEACyJAaRJVYF1D/b+5u6asMSh1lc8toFNJfbtwYeOmYP+mSkM0O0bk6JooN
 v16Neq8K+yRUYxrvxHr5WjmRssSy8UH/c0hHWwZerAuV3U6sEAs/rBDHwxBalRySL+jy
 7ZhT7sKOw5X0p+fEBXYwipyI9hpuN3AzesdmIjYW7sOiYgwenWw2y/WBA9P8dxXKJ9T2
 MwOHVl/CGHsTZPnVsr78Fi7wGnL0HG/Qp/vqgXrFYepAlUn3IilG2WDzrx7FlOb3ep85
 lzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dc8Bru6669X1ZJa5m4boFqQI/c3OuuO5FFR+Em8EZR4=;
 b=kaeCJbuvW6xtf8W5+ujTfvJIAis48kt0MoRI9bmsKymcKHgS0ZHJDvuU/m+mkE/HcS
 Kll6zUQv+4IyipNghOEXLpMqRpsiK2ddbGWlrQ5mcDcMtB6xqe2ASlGLMd5Sw7LXW2d+
 lr40RdZvM87swMenBaPws1Q8KnN/xXZIJEzFE0ewsegzVmqWzq7o8y41y4GCUV0Co4ch
 /zISMz31MH7Y0jxB1rLjbJGtds316aflnlLlVZDd244xjfGDmIMnvbAB9ZU4xfBgvs1P
 VAL/yhfpu+5BxRXAQ1xa7Kdi406N0TX05yUM0Lf351eBDEZR8845SnVfYiVexZ65eZO8
 MaiQ==
X-Gm-Message-State: ANhLgQ1+ibU66iBr2oFDct/OzfAPZoQ1NiZK70JyopPrSXIBePyNYcCj
 XYpnk3BSYgnyvw6STNR/u/VK3Hb22dhMVlWzz3AAzw==
X-Google-Smtp-Source: ADFU+vtnCczNHzfdd3uqJhwMIF4ALeD0PC+5w/1V+z20W8/qcT5/qvX1bx7NrsUdXZ1EYGLzNapI7IdyvnYL6hldAcc=
X-Received: by 2002:a54:4614:: with SMTP id p20mr3851284oip.48.1585067464705; 
 Tue, 24 Mar 2020 09:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <CADUS3onjS+T-SSYC6ocKNm3oXsCpiQbDa0eJobhOnts3gZ_gEw@mail.gmail.com>
 <CAFEAcA8tU58_Bdpp7tmpF+X4D5zyxpV4pA-wz97EpP41SQ7sqA@mail.gmail.com>
 <CADUS3o=1XSzi-DdK2gNm4-WEwPsEWc8Tfn4j9Fxy92JAg9Lktw@mail.gmail.com>
 <CAFEAcA94V+8qPyfMyvk8+F3_KpOG7sBcpc5DViDE+jZ1aEwA9A@mail.gmail.com>
 <CADUS3on6Dtk7+r2=d2nUJhz87xxJspYJhgDFEWgi3SLVmhHRUw@mail.gmail.com>
In-Reply-To: <CADUS3on6Dtk7+r2=d2nUJhz87xxJspYJhgDFEWgi3SLVmhHRUw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 16:30:52 +0000
Message-ID: <CAFEAcA9ai_WUE6Z+Le4AHGRtsPYkSo8W_hRJ2GTjAK+p6WRi4A@mail.gmail.com>
Subject: Re: qemu-system-aarch64 windows binary run Arm64 defconfig kernel not
 working
To: yoma sophian <sophian.yoma@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 at 16:29, yoma sophian <sophian.yoma@gmail.com> wrote:
>
> hi Peter:
>
> > Hi; I can't reproduce this (Linux host) either with QEMU
> > head-of-git (commit 29e0855c5af62bbb0b) or with QEMU 4.2.0.
> > I used kernel commit 16fbf79b0f83bc7 (which is 5.6-rc7).
>
> In my experiments, the booting fail ONLY happens on Windows qemu binary.

Thanks for checking that.

Are you using a 32-bit Windows qemu binary or a 64-bit one?
(I'm wondering if this is a 32-bit vs 64-bit bug.)

thanks
-- PMM

