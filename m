Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9E4C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 21:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489DA206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 21:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZypsk73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489DA206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i20BR-0001Pp-FI
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 17:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i20AM-0000rp-U7
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 17:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i20AK-0007c2-US
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 17:35:14 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i20AJ-0007ax-8W
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 17:35:12 -0400
Received: by mail-oi1-x243.google.com with SMTP id 16so10702905oiq.6
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BUqAqjJsrqEMDL1hV7C2hJaR3rj6n1r8M8LSs3a6Zyg=;
 b=qZypsk73ydrWi3YLIIqAdcBhjeLSYb6s4t0ZzTeCMtHE0bGDsHhpbyzP5Jwr5SRVmy
 WFiHgxTwc039ZTo1lvwQ/rrc62jdxGYFXUusgDTVRak7S4DXHfn4z7kAlDPIxRGjuj4l
 LHZx/D4HLDtuw4ctFcvuOrrniqiWohlCBtlkn1REUbTN7K5EEO4toLfo8jyfzXu04cEW
 Vr6aIWA8/NZ7yjY0hRD8OoomVhbzqXWSDE3MPOa9laBcbWE22uZ1D7ktgJLKpzu6t7jF
 G3Xk2I3cGp8BsAlTVv7aH2SYNesIdibjWdsjrGFbEkES+OHdPw1fkSpqaHvA+Wkch+VT
 9/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BUqAqjJsrqEMDL1hV7C2hJaR3rj6n1r8M8LSs3a6Zyg=;
 b=EKciaxVOvyEtKPGf4ZDpclfPCcP2Oq9KplX0kQopv7wO2mbzwti6PaEYMzCg4fioCd
 6c3CYv6/pojWObpnIxcZTXSD3IUWNkQkTVv20QxvYIInLFVa2+2QBPhp5cpv+zObcetu
 s9vZoVk4Wj8vTXeDbQI0vQ4X5bUUpmohg6IX3A/PMt5rg8rF3Y/ig7HbWRGjBAvCEGAt
 KoniGDNg7fBwa5NPaY8YxiJbK6wsRFuuzLDvEOWrUv5CTii3mPj8EHx88H4OATbYqFdC
 865AOgI6Sh3O0FGBXisWD/rmdaxo5aL/SGTLUiLe4hVBGr791rpJNWpxm3pN9+cilW9j
 99yg==
X-Gm-Message-State: APjAAAUpx1zjSToUHOgSdhxy5d4o29PsliP+4+MgqvK4jCtfwCFA0Cqb
 1XR8i6dS2zWhJ7id0/2XoHCgkfi8Z6WHhJVqJ1WK7w==
X-Google-Smtp-Source: APXvYqxDZey3LjiTkLNR53U6xAuFGIcVx3gPig+iY7wdcXqhMyDNhtunEdEetucncgzLbruZXMUCeuuHbZ2oqgj5iYo=
X-Received: by 2002:aca:4a57:: with SMTP id x84mr10414452oia.170.1566768910433; 
 Sun, 25 Aug 2019 14:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-52-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-52-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2019 22:34:59 +0100
Message-ID: <CAFEAcA9RMdLXZFkxS_2TRxM_VTfMSNf3JygcaXZbD1jh6quN9w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v2 51/68] target/arm: Convert T16 one low
 register and immediate
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

