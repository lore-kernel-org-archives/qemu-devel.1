Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B18C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C3A20723
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuxkKdvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C3A20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef6M-0008Eu-7Z
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jef0v-0007OB-Mj
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:25:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jef0u-0004Ya-53
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:25:33 -0400
Received: by mail-oi1-x241.google.com with SMTP id 23so2514202oiq.8
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=btgoFOOyR201ip2U5xlh75C3/9fSQsab6c8vWsLd7P4=;
 b=NuxkKdvNH3Ml2auKBoV2zLyLN4/FqjwIxufUiCdgDGEfKfw1XxGczx+UQ5NwEJsxeE
 080lEVkgPxa8r6xPQIPBv/15lS9xI7jrfQuaonvVKcS4w08BRhLfcmFiBLsePbcxxq0l
 KAaledeB98PniOyge4mrugyabLS+CsfOzBSstYIqmpuAiKTNhXaRACNtgnsocoxE3pFX
 ES9aL7yDEnRy9Mhr91q5F7A6YNkOa8q55CXD3VUlEvqTRZFL14qpx7QAYImAjqrslaDS
 er4APZSqstq91l1sYNCb4flgPVtbqAhVHidDFk0l6UIdLpqVO7UbUHEl3S3ZU0bTrEpF
 IrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=btgoFOOyR201ip2U5xlh75C3/9fSQsab6c8vWsLd7P4=;
 b=G9pye3XVGCWJmzxDKPzEeVrM24m2H+gifYlBAEnjfEu16no/mSG3XRPircNCNV4EX3
 2MXI12WbHpxwR7UPdLKTxAk8K82/2mZTwVaQLJDAKrY9AZJfVNCeuXfgFsePeDSxg5PF
 ZPt7z/3vXfU0FvXKmtUL1JI+ZsTgGnJ4GJTvahU+kB0VXKFFFYoyr035rGm7pGXwJVT5
 /P+aCjqAJuM4m6pDoyC8DCJJa1VM/mPcVVfxgRMAUWrmOGb9Z73eKOEmZgY0O2SVfQQC
 0yIMzduBLMcylA6tVj3kO+eUS2iFc5qjBxonSFD+c3vDvGx4afMhScq/H7c9cU6UzsWS
 gbvg==
X-Gm-Message-State: AOAM531yXBeY+xhvqCerDE6jBKk65FcSCzLcrLXGmW/5ciOn2myZTbDa
 gu600eHuq6QuN0DWASwJEZBG8B7NO3UbY1efbQDq1Q==
X-Google-Smtp-Source: ABdhPJyFDGnahpefq/nXKHHefxEqrMbkGExjes8U78WuR2TTIIrotl+5zK4kjQ2dPoBlm7LmCljTorr/dxdLjCk6Sks=
X-Received: by 2002:a54:469a:: with SMTP id k26mr5702300oic.163.1590758730883; 
 Fri, 29 May 2020 06:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200525114123.21317-1-f4bug@amsat.org>
In-Reply-To: <20200525114123.21317-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2020 14:25:20 +0100
Message-ID: <CAFEAcA_iW32pJHnAOC0J5P3JTh=4yS6rzpSZ7a2tn0_uhsrD8g@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/arm/pxa2xx: Logging cleanups
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 May 2020 at 12:41, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Last pair of trivial logging cleanup patches
> from last week-end.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/input/pxa2xx_keypad: Replace hw_error() by qemu_log_mask()
>   hw/arm/pxa2xx: Replace printf() call by qemu_log_mask()
>
>  hw/arm/pxa2xx.c          | 66 +++++++++++++++++++++++++++++-----------
>  hw/display/pxa2xx_lcd.c  | 26 ++++++++--------
>  hw/input/pxa2xx_keypad.c | 10 ++++--
>  3 files changed, 70 insertions(+), 32 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

