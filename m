Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D37C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC324206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhJ/3n6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC324206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRAZ-0000LD-0s
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joR9f-0007fn-Eg
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:39:00 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joR9e-0004YS-2V
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:38:59 -0400
Received: by mail-oi1-x242.google.com with SMTP id j11so2131501oiw.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ctlRjVAFYwCY6pTqUKZJ3/d99UBemWYSFar5HyCixx4=;
 b=EhJ/3n6HyeAIeV/GQ1IqXcu90fbpKaWW+v4v03tPlNTWJPUiaFUzUuq1r1Yjw93EbV
 1UxJAW1pDOVlyQdllWQgu/OVKATDp9DhgUL0Q1SvjC4vOgeqg+wPRFV733bwmrN7OW6C
 V1YbWlE7/b13eHsWKMLVKZ3iZPZni40iErmtZj3WSoutcbWG0MN0EcvjIyq5cLTYtCGW
 Qth7JPhnVzo0Bz7hy2DrWCRjtzFf2RPcCbQcyFhrI3B4JqKHNNyoxFhCbqy3rGGtt0tT
 n+jUlYh4ubJOPtSqsxDXVTG4WzQk7uKkUWrLjpp6joK+XTd3qabv6UVzIjfz3X41HqKW
 g5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ctlRjVAFYwCY6pTqUKZJ3/d99UBemWYSFar5HyCixx4=;
 b=hEaDlvJHGPkZAJdDL2jB5OW1/ZO0/JxJsiSY2gJGaRPLHNvZJX8Smi2LbTZfmuxz2g
 OoF6ln9wYaDMfHp226Ny0NSBFTkzjiw/AnIlXsNjDKSMd81wmc87/qkDNUl0nwMdqxms
 PRSNM2t5Kroja4EzjAm0fpu+B35IUv6Bc12yVl0KHupa0IkC+JhGhl4vIjNaSMTllRIK
 aoEBmipm+hAbn2kxnDAEr0OBu/cPH7TNsx8F+73enapekYKBFBUPPDcsYywtypb/V/1Y
 IvyMi83JZL/kvGU6ttv+FJ72CxVN9lvrlGUEwxaIsu8lFQz7qqXhfrxtGYYgBdPjGyHD
 KCAg==
X-Gm-Message-State: AOAM531HeqZNVtvxtqhyQD2SDb8DI9Deeo4E5H0+rAoAzCMcCZvBAAjq
 kVl9Vi12vWTOfvkhTRPg+MZWlA1jl4E/q2i6EvFvvrpR1s8=
X-Google-Smtp-Source: ABdhPJx0Vyg1x94Gp10JN9s4+xSxpKiMGGyZzjb5hix6UeoWzFoyIuOd6JhQQhjT69Yd8/2qVuw/gfiNRt3qaYkBXUQ=
X-Received: by 2002:a54:4694:: with SMTP id k20mr1902820oic.146.1593088736912; 
 Thu, 25 Jun 2020 05:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-36-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 13:38:46 +0100
Message-ID: <CAFEAcA-mYKrRBRRMFPBrHX6=AJ0vdXNdP0AUQnueZ31OcoP1Ew@mail.gmail.com>
Subject: Re: [PATCH v8 35/45] target/arm: Add mte helpers for sve scalar + int
 ff/nf loads
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Because the elements are sequential, we can eliminate many tests all
> at once when the tag hits TCMA, or if the page(s) are not Tagged.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  98 ++++++++++++++++
>  target/arm/sve_helper.c    |  99 ++++++++++++++--
>  target/arm/translate-sve.c | 232 +++++++++++++++++++++++++------------
>  3 files changed, 343 insertions(+), 86 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

