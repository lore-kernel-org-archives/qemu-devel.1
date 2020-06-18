Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462C4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D28C206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzE7/Xz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D28C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxaj-0007FG-BX
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxZM-0005wZ-Cu
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:39:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxZK-0003gh-SE
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:39:16 -0400
Received: by mail-ot1-x343.google.com with SMTP id m2so5005295otr.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Qq3iHbr4Ebotr0tZQjE91j16O7ZoICe3YyZSauPGbo=;
 b=EzE7/Xz1q1rzE985qQaw5knsIfZ1VQpcxtvTEo+X5eQQzz/FP8PSQRmFtO/f5mWZ0b
 m0hHHaHjJ0wtwt6yUmRXQvY5rRiHux1QKHt5ZNVBPBgr4+nhWawqSY+pGxuLLUu0q6qI
 Fw5zsiyBCtPryRZQZUDdGUtWMXx1pyqw6yq7j370ndfeosF/1VNd6+sXOT80AE2UJ+Cs
 S9pO81N13WBwiToYuq258RgTgz0wqrDhraO7/Q/hhZBKFTGS8pNMRzbTTRZhplLAyW44
 0yqv1DKCTO4FWh2yFPSW5r3Wcfa7Eh3av3xnetBcPRZHIR9gKX6EIgmtN9CLSF8u/yyu
 +Kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Qq3iHbr4Ebotr0tZQjE91j16O7ZoICe3YyZSauPGbo=;
 b=NUJUkh1DzZsbD4+VVbkBfRbDnEmsqhtBtx/qzkQV1r1oB8/PrGZ441TI40AEhCJUXb
 QCLB5dqRAg1dPk/Ae96M34JxReyF6nNcG5CVfVorFCUtv3CqFAwRz8A0tVIVfKL9Zm5f
 YsYstoHcUeMCVXRVw/LFEEh/ivSVS88+ciNkL6xrguOhy07nkx8OZ2MtI2VGY7xQQn3Q
 dBOkuillOqDVv+wOC/8FRjgDdDBvnXsH8BmRWohWBh66MYeERyNXS8qi9TVBlCfB2qDr
 yx5jEwnO0ysSjbYXWsnA5UpnfHw2Wkag0iPJcpw8l8/YVf/yXu0h720OVfmWFkHmGGLJ
 0iuQ==
X-Gm-Message-State: AOAM533EhsKd2rte9K+vLtwRl+YJHIr1Wi0f1xNY6+ag1C1+5fwk/0oT
 fBKpwPci38NMcpsQBRln/jEnyWqMNf29ezbc0PK2C69CSjU=
X-Google-Smtp-Source: ABdhPJzfkm1ddwEo7jLXs6qvX0XQtUzCV8D4zH25m8Xj5Vc9u6k4fCmAqAla1HKS3yZZ4HGtHQgF+5RH/T+I4/ylGLE=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr4112709otn.221.1592498353737; 
 Thu, 18 Jun 2020 09:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-40-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 17:39:02 +0100
Message-ID: <CAFEAcA83Tb0r11R6EUFPrqLWrXNx4+9Q13q0m8X-jwO49Wgysw@mail.gmail.com>
Subject: Re: [PATCH v7 39/42] target/arm: Enable MTE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We now implement all of the components of MTE, without actually
> supporting any tagged memory.  All MTE instructions will work,
> trivially, so we can enable support.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v6: Delay user-only cpu reset bits to the user-only patch set.
> ---
>  target/arm/cpu64.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index cbc5c3868f..e4bce55c5f 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -655,6 +655,7 @@ static void aarch64_max_initfn(Object *obj)
>
>          t = cpu->isar.id_aa64pfr1;
>          t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
> +        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
>          cpu->isar.id_aa64pfr1 = t;

If we don't actually have tagged memory yet should we really
set the MTE field to 2 rather than 1 ?

thanks
-- PMM

