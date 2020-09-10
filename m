Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDE8C2D0E1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE8020882
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IW4GcCN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE8020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSjz-0008DP-3I
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGSid-0006Bz-5M
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:58:55 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:46995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGSib-0001ph-JO
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:58:54 -0400
Received: by mail-ed1-x543.google.com with SMTP id a12so7571495eds.13
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y3bXVXjl2M3exTxIx45mG0qCMBytEm1Uu1EFN62liIs=;
 b=IW4GcCN2rkGt8t000m89KkFANBWO7askk1JSROwlleZ5cYpLirtrxoBpk2TGuySx2i
 uleVunTKJA7TV4lRCUD0ge9oP5TeCjHyH9O3HxB/XcCQs+CcKO3urmhAJU85RbFkPofT
 U8F5Bgd1tZk8y5Qhc/DPh3zQs1A/hc/R9infA7Q4w8wTIubdR9vkDINYck9dvipJjr+T
 w5YhrzXPXC3LaCw3q2rhbjNSkC6v+cFbXFDvUrh6V61sPd9fJiT7UFMZXs1ogFXgwF3l
 2KmNpe0Mjj7/agcADzBKZebLoCZLH+HjBSWjQQspDFdkO14RiyZohitLTUZPXjAitMVV
 ciOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y3bXVXjl2M3exTxIx45mG0qCMBytEm1Uu1EFN62liIs=;
 b=taqqrgmABD0cESx0oWDKyDXlDGFRToCyqPrXSbDyh/lYXTK2DOxisYyglScEmY9x3F
 a8JKHQ05pl+WYeLVdQw6DyW2L/r+9TeRNSNTf5wKkl9nLuAxvnZVHxRJNbvCkCJrEg7g
 8yfASPqDGjerizFA7qtEOfD4OaqdqvegTUNFuiuNvArpiLwr1zmdhjTgoWfcU25OHCqG
 WsB+cBPaHJVp/mV6pVR/zf8GPh+ZR1eueAnQLcf1zlB0aOqGDM4Dh2oqnK1mi/WyaC11
 3/j0OM2OPARaA+sI+nC2tKp1hYr2BZr8MEyaSIDh3tAQ+lIpPiTep9Q6l1ozUnyiaD1I
 X+Kw==
X-Gm-Message-State: AOAM532CAUFwQ93s49H04fOo35iAYhnQn1aej6e0r6hq858Mo6YjMTlX
 yaqTgvFIBCywQd6KYGXDRuKn2GiLUMgTRR0CWVkJgA==
X-Google-Smtp-Source: ABdhPJyZm3UBTqo2Q4U3M2FO5Pcb/X22zM6gd8XH+CbPbZWAJJ3JTjigE63Cky5iTIq2zeh/54s0opxesQPYdN8He6s=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr11440969edl.204.1599767932021; 
 Thu, 10 Sep 2020 12:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200903192334.1603773-1-richard.henderson@linaro.org>
In-Reply-To: <20200903192334.1603773-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2020 20:58:41 +0100
Message-ID: <CAFEAcA-UB=Qcuc1i2Owcwwj-oEcB1Cw1=jQEjhjbL9CZMUEtDg@mail.gmail.com>
Subject: Re: [PATCH] decodetree: Improve identifier matching
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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

On Thu, 3 Sep 2020 at 20:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Only argument set members have to be C identifiers, everything
> else gets prefixed during conversion to C.  Some places just
> checked the leading character, and some places matched a leading
> character plus a C identifier.
>
> Convert everything to match full identifiers, including the
> [&%@&] prefix, and drop the full C identifier requirement.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I'll take this via target-arm.next, as that will allow me to
update the neon size-encoding patches to use "3same_fp_size"
as I queue those, rather than having to send a separate patch
to fix up the name afterwards.

thanks
-- PMM

