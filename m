Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02226C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523F72226A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSblrZAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523F72226A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjp5-0000rs-Dw
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGjo4-0008O8-So
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:13:40 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGjo2-0001Kd-5i
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:13:40 -0400
Received: by mail-ed1-x542.google.com with SMTP id n22so10125570edt.4
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B25QMA1bjbU5zxjsl+kIX7dDRm5uNIbHylbwXQEjzRA=;
 b=XSblrZAw9qgTlxyW6YjHqgwKEeogRN8e8g1mQmHbpEUSwL/9CjrV/i6kaMYYw5Hj4O
 Haf6PiLMlNcPC0C7otJVBQJETmdou5ihFLYzMk4BBFF/yIEGbrX6wHKpCxrYlccmwghQ
 rMoA1YjAXVW78d+cIs0EqxUGeCN2ds4e4vEMCzpZCvrLcVHe2jVCRV2s9AYWkwoK2voT
 iOKrTi5kM5y5q/DRGtz2CevtWhmG6UI/MSg3s4giYEGeor1onOGeCecLJ46v0ZGz9CIs
 xPCOz8XbtXVIhWy84V2cvI9aDxKNcdU2DxuHZgDY8CJVBVWRlP0Haw3OkmZfUNvpRVWf
 ZZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B25QMA1bjbU5zxjsl+kIX7dDRm5uNIbHylbwXQEjzRA=;
 b=Uc8F04hg3c90WNT5yG0NL8sjkr99uHZpBmHsqXb665+vyZs3MqQ2OlVd6MGgSB8swP
 WAIdQcKtBpQESflgSKNQODSKePhzqFJxyUPl/r/BG2jW9UxY8QXmYtMtumXX6X3Fg0xy
 wch8xmA/Iz7vuaAUNUQY6QGxwr/CzhKU8H5KjOtXFixZy40bPzDQhGnM/us83ZaitXdQ
 qZkHQq3rOMq7s7ZTFKH4fRA7bEhdezlcV6SSLBxp4etdUiPmnR4yBb+tsMlPpyHaqeqC
 2ARkfAOLcVqjuWg/knWp8XTKsgUDtBHlOqKU7qYjTQ4zVaqetFMR/R2UdEyjEGWf2Aev
 r7Hg==
X-Gm-Message-State: AOAM531raCddZdyMqS6AieRQNpxmV3kQ++pM8Cv8ovNTvQE6r1p5Z972
 GpkwXKiYrRFMbxf5JtuMoD3cf8LTjy4qzBuqIDGxXg==
X-Google-Smtp-Source: ABdhPJx9QiqAnLICbYLnAxDoZisCNkEymabD/zqM5aRHcIRR94JvdRUfxOyJgLx1zz7KktnEatp7g5bE2B91SGYB7Fs=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr2313736edm.100.1599833616105; 
 Fri, 11 Sep 2020 07:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9jUpJF4FQirb3avWJAMjh+AdkimW3DgMyMjbDjBCQSvQ@mail.gmail.com>
 <20200825144810.1755379-1-aaron@os.amperecomputing.com>
In-Reply-To: <20200825144810.1755379-1-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Sep 2020 15:13:24 +0100
Message-ID: <CAFEAcA_k1wy-zmdYSHf=hFkCQ1fBPigGJQ1=K7DyGaXkF5C8Xw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Count PMU events when MDCR.SPME is set
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 15:49, Aaron Lindsay
<aaron@os.amperecomputing.com> wrote:
>
> This check was backwards when introduced in commit
> 033614c47de78409ad3fb39bb7bd1483b71c6789:
>
>     target/arm: Filter cycle counter based on PMCCFILTR_EL0
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6b4f0eb533..8e7730c7e3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1452,7 +1452,7 @@ static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
>          }
>      } else {
>          prohibited = arm_feature(env, ARM_FEATURE_EL3) &&
> -           (env->cp15.mdcr_el3 & MDCR_SPME);
> +           !(env->cp15.mdcr_el3 & MDCR_SPME);
>      }
>
>      if (prohibited && counter == 31) {



Applied to target-arm.next, thanks.

-- PMM

