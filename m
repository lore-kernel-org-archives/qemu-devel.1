Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5399C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E2A204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I29cW7OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E2A204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsKE-00050s-Le
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsJT-0004Ey-SI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:02:31 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlsJP-0004Y0-Um
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:02:29 -0400
Received: by mail-oi1-x243.google.com with SMTP id s21so4669189oic.9
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ivLhvnhRrT9bHWVFX0sgU3qFIW56QB8SCvTpx0SnlDs=;
 b=I29cW7OPj0Ejx2LGVrpXrhliwurlq/WGHwG8JuMoYCc96Ejd31wmC9rF0foWGmwdYy
 GhjFD2DR6Qs2Ew0QsV5iLx1slKAgcGKvsirSGXPsKqhfJ3C6ADwHJfgjNDUoYhOJCCjX
 a8a7l6axZhoUe6/jw92PUXSwYbkaw0/KnWhJiJyGDaxy7IfXIZgtKS96nCBrSez3UpUz
 or6Sac4blBVX1Mp/OYr6AFBoJhXFN/ahmQso/aDj2I0afSjrwDFdTf7vroHj47wkxj+A
 6vtGQQr8tdbvMk6iTl5f7uasjpzjziVU/a0JFm9asbVtGdjhb8GiHVk1JOYa6nUAwZNi
 vNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ivLhvnhRrT9bHWVFX0sgU3qFIW56QB8SCvTpx0SnlDs=;
 b=kvHuVMu+r9vIZmk69uXBz6U7f0DCYOpm/sGzfQy8tKOomb71/4Zi0X2sc29d2N7kjr
 BaXiBb2w9pyVlkcMJLCwoWDD8O4LG++IhLmepPq8OQmZ+3mf/MaxsjHunR/HTkoheKdR
 dS2o7ked1+SDEMUAlZKfWjUwakWb7Zz2luzPbiomwEu69APhkq4DfsHhaLCda7Qwq9/3
 jCNQX0HC1RTDtvOFIOPBHYdQfZ1vVGS0oz5dGyjk4UWXzqLymFi4THyutC4VQ7IyRC8l
 iHPC8rQa9I8C0ICD2DA5r7BnsctKqVMzelxdLN8P9DvYeaX6uxrxDIHxnXBNsvSg/nFi
 vPbw==
X-Gm-Message-State: AOAM530z1Q1ScIDc3HziWrINRhlsYscDiqt+YgI2Pc2WBLcwjuoJdI0G
 RvNdHTn1IXajF0Bz5rw6fYB/y7oiOjCct5kHgqxb1g==
X-Google-Smtp-Source: ABdhPJzy8eggtTAQR/z3jX1uWrsKd9QfTVadBDdKY6PP22Gm+bAegiC/+pZEhZ5nC5dBwPwJ9IijPV0dLksBTutm8Cc=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2299578oib.146.1592478144634; 
 Thu, 18 Jun 2020 04:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-5-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 12:02:13 +0100
Message-ID: <CAFEAcA_Hur6VJhUB_Xa5TUnRoX=Q55iwrDg_VZ7+tHSh=o96Fg@mail.gmail.com>
Subject: Re: [PATCH v7 04/42] target/arm: Add support for MTE to HCR_EL2 and
 SCR_EL3
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

