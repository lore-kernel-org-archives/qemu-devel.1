Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34143C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3829206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfFa4KVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3829206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Ahy-0007nY-CL
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AhL-0007Jn-1V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AhJ-0000vx-VD
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:58:38 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5AhJ-0000ue-NC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:58:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so2006016oif.10
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pTfCpbUH5rr66YHG7kRmdHwFUIHhxyb5GwY3YCDCDvg=;
 b=sfFa4KVB5IiRglUBN4DNMp4i5eX05aETtxSuAMCflvl+t66C+CDz1/ACwZKtcNwxRI
 aWb/CB0q16C0cDO8UlS3WdLH21iFhN9adgR7GwNGfZ+6RJRLypdiIdc5pRZgdVQYgwtE
 ko/7aJmf9zuWtmYOfNU0yzMeDiKzsVUbOOkhjAD9FQFkhhUH7jhM0RRh5/NcDAXeTbCG
 HpTLFrnn+AOjAQWuGyo3+Cg/u9xY/g1KB/EUt5FtLqyYCF/ysMwlz3xnmpWrBHnffaGL
 A5j8hHbrwGaITA7VgEzjMhbYvnxurj7XHB9mBHIgyiRexnoh0jSgDBsAnieGT/HN+2Ff
 90vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pTfCpbUH5rr66YHG7kRmdHwFUIHhxyb5GwY3YCDCDvg=;
 b=c59vRHdOczQNw6AUtWHjBGiccjJfgWat6kkhE3iX/J5wUOYehVvebe8a10iGN1Vac5
 zH3Y0e2SBbPUC2lWylWgI8k0iklH0YcofxlFXOzorJDwN4mmWX4Xs9QA6CDND054Isf5
 0QeBFiI0HK6FPW3eCWuTY1iF8oLPdR1MgSlsjPv4QXiKUMjaRWtCc5xiFnIxA2VbTWdc
 aNqnE48/FaZMPcBPJKOvGx1M37dEANgmDb2J9E7OqYOBluqaSOIEuIENUY5pzfmecGSO
 CTQ1aOV+d7YJxXiuRzU+eJxT6PvG0hAN/PtObLNGazOWyFpNX7bpnff35HvRJrc3gCzh
 fCSg==
X-Gm-Message-State: APjAAAXkdD9r+nyL2EkVlRX49fcesHROcvn36KIX/Z6o4cDt9o+cbzme
 KCU4InHHAuLkN0gb1zo5x++3PV3+OYlV/oRww9iUgQ==
X-Google-Smtp-Source: APXvYqwksEiXjTHWDfUfpNicPVwY4xkRMvIUvMYf4t5+Otdk7CLwfCvGDuj64g5JsA3En45j7CzcMgSgwKSaJ7wGL6Q=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2492798oic.48.1582300715503; 
 Fri, 21 Feb 2020 07:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-3-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 15:58:24 +0000
Message-ID: <CAFEAcA_8x_VjhGYLGXEf=dQDsGY6MfQFraqUOUpN82NJxgkBUw@mail.gmail.com>
Subject: Re: [PATCH 02/19] target/arm: Rename isar_feature_aa32_simd_r32
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 14 Feb 2020 at 18:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The old name, isar_feature_aa32_fp_d32, does not reflect
> the MVFR0 field name, SIMDReg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Can you wrap the long line checkpatch complains about, please?

thanks
-- PMM

