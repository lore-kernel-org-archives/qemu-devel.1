Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDA5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A3A207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3gjiYVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3A207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jls8f-0004xn-L6
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jls7s-0003PB-68
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:50:32 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jls7q-0001zu-Lm
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:50:31 -0400
Received: by mail-oi1-x241.google.com with SMTP id a21so4643916oic.8
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mouus+/TiWLsqIZOvvBh7EWkOrRqd36lb+ghDPqTUc4=;
 b=w3gjiYVhmJw1GmHBM+fPrEqwwC7WcZc8nIfgD/Gl69ZRzbKoKGDjq25HLnsjM2RzDt
 zCtdRKG+aMiPt/Zi+7xoqZNUuB46sxPcnkZcMxX5lCAHfQpmvm5+WVxYBrGRyscWZnOH
 z2LSYMctbCMhnulw+A2lJPScPKpPpZgbeLtF533WdZkDFrzYgGolMd/jrGjnQmW27Oya
 MO7005EWrFsD3NZoci1XjGRURQr1sOvzTAO5Ie2xGA0tvrWj028uJkmRuoDhCkjSV8Y9
 E92kXPC3LgohNL9K2/sI7eJaAiK+YyH/b2aB5oiHPsZ2onE11IpKtgx9CPXDVnrVnbIe
 7K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mouus+/TiWLsqIZOvvBh7EWkOrRqd36lb+ghDPqTUc4=;
 b=e3ytKMxT/9CKFXmwdZ966hUL19xgre+6wT5zF6G0Ur+yVlmIq9kgV57FVvSsvPC3hL
 FSbU0jZx4391SBvMyQGbNeqJia3YAs+6nUqfyvcAsZwxEbPt9SYBJ0dCLbsy4NZgqzG6
 SBUG8/LXJx0WqDeAoY17RcAcxLFscMzUwztIhGHOYmPE94gNdqSaSyjVLR3NI/b8hiaG
 vLgEjRJZalQuFwaJutTMQ8oLTeqd9Twepv9L3fz3JMO2/dMKK51/z/lMxAECjsG4FhGU
 ppcbCaIKXi8eowZcLMHF7LnLtUZ1B6ec4/J/eGSbYRY6TL7TDZ0yUF9hkzCoGff/bf/F
 otyQ==
X-Gm-Message-State: AOAM532lfMJX2Ag/wX/vd6AIejskq81gRSEwVuGp10jBu/pvJuykXo6u
 SK/QQ2pWm9CdKkDDCHIk7JcOH/9buoZcq8/5EPTEss+E0NA=
X-Google-Smtp-Source: ABdhPJyk4zKWtX0lVULjPB3wyNe1MX94Q8w9Xx6bRAZieG0HiPxif4f+3z6cJ5DumNIrTVXFoanM75EMJlWT+b4cERM=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2222879oib.48.1592477429592; 
 Thu, 18 Jun 2020 03:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-3-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 11:50:18 +0100
Message-ID: <CAFEAcA-S9B++cj2tw2o6X_B3naLVCY99ef=bZ1n=56iwnOSjVg@mail.gmail.com>
Subject: Re: [PATCH v7 02/42] target/arm: Improve masking of SCR RES0 bits
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Protect reads of aa64 id registers with ARM_CP_STATE_AA64.
> Use this as a simpler test than arm_el_is_aa64, since EL3
> cannot change mode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

