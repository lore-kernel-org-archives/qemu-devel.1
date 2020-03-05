Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C96C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381F320732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Es5xVb7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381F320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rRd-000619-7h
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9rPE-0002KO-6U
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9rPC-0003qK-6a
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:23:19 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9rPC-0003ps-1T
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:23:18 -0500
Received: by mail-oi1-x242.google.com with SMTP id x75so6096779oix.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 06:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ankb0BBJk3e+XHds1kX6Vse78CMnD2YPH2pAnI5TDRc=;
 b=Es5xVb7t02KTrWd26gaSQyK/IKc27No/LZdMNlYNYvXqGfM47RqCk093MsxfVAEUwT
 6ZbUx3JeSQElCS0X1LjDOoC3lVGZPeIhjEqC95bBqLDV1HuLL4Pq1nXh2Ftp0oyWBPCz
 vJTc6VFvg2h7mISvwA2yhs3nBYZDX92USui2e6oAKDvNArJ9hHwwLEWA7l1iSlObU6Dm
 YBWZGx6jpDU3qA/PjT6qJlySHMi/Zc5dxIyTsf+vfWMSFBcA6z1xwWzPPOG6Tf8RxFRD
 t1U1gM4p6poTMwkE78oZ39ltt7kGFlMQocTx62n1GfkUQLyILT8QDaQhGvh4SOG6aYT0
 4gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ankb0BBJk3e+XHds1kX6Vse78CMnD2YPH2pAnI5TDRc=;
 b=CRjqR0cDDPm3rlzkmKS8IelqJ77EIRBe/n5xllrS8QVGRG6X2UE0giN6yJMRjBhato
 J9LTZuJDwY//eAkVGUov9Fbpxp0nejEIV0q264vwZN3cqB+7Fj6hi20Wsf6DH1Dd7/ge
 4JidQVDC9rzFJXrPFX7ut1ya4hkCUntPpXAefUK3lhwbasDC7ifmF4XIHt17XeVPxt4F
 XtUiGPCN4emyfnxwzJwbGICsWJ7RWFZp5XA562BQ81XilnBmdA+itmCwpFYL6D+7pw89
 KqjLGd0Fcf/hiJhcefMNGK4CTkLvOfoVAxX2JjBi16OOr8oD3WzpuncJRRtlPb6+IxTH
 fv+w==
X-Gm-Message-State: ANhLgQ0mNJoghdwzeG6Qz4T3aV3JiSklV+SP/+4y/RQl8N54Mlhf6v6E
 lkhVA1+RslvrM3F7qA3SSlEvn+7krauWA6ekI29jEg==
X-Google-Smtp-Source: ADFU+vuL1j2h5tfCshFZIhc9Scav1fwTmASecsbr4tTpZI9XVvPu3EiNpgpMD4xBeBljPaP+kkttshkZDmQQZImJ0WY=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr5600961oic.48.1583418197103; 
 Thu, 05 Mar 2020 06:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20200302175829.2183-1-richard.henderson@linaro.org>
 <20200302175829.2183-3-richard.henderson@linaro.org>
In-Reply-To: <20200302175829.2183-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 14:23:06 +0000
Message-ID: <CAFEAcA9N9zKxg6zvOCG9021e4nRcs_ij_VaGszG0O1Suc4r2fw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] target/arm: Optimize cpu_mmu_index
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Mon, 2 Mar 2020 at 17:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We now cache the core mmu_idx in env->hflags.  Rather than recompute
> from scratch, extract the field.  All of the uses of cpu_mmu_index
> within target/arm are within helpers, and env->hflags is always stable
> within a translation block from whence helpers are called.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

