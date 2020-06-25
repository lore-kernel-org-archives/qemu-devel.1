Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5E0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90F0206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yg+Fyd7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90F0206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPor-00013P-0y
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPni-0008GX-BV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:12:14 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPng-0004US-L9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:12:13 -0400
Received: by mail-oi1-x241.google.com with SMTP id s10so4365132oih.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5D7Cxn7b9MsMev/P/1/7mvIgigKqkFhH9vyQhINyiOc=;
 b=Yg+Fyd7TTwJJhThkhPGLZEODrmlVOMS0Gtde14LYyrHkrG/iYdYnI2wfFu2lP1D88S
 WoVVc2OFZGD8NZUTnGaDRgg4KHIdAQz7GCtWMHOBMxlBETiUDWGXJrpsiR7XxMhgICs+
 IALOI96/1KjkSHr3z2BOmndtcTSyEDz7/FaYKjE+kRSxxM2PiplVEQ1Y6oXcW/bqRrSf
 zT7OEUzOGTPgJ5/54LKMRM8/7BnnL8wOKowpWeNYwIdrntSjTIIFE08C8swv5QaYKwqe
 EZ+8ifQ+aGEQ3xMxSA/h0NWNlkSHs+p6+cs/JwrSOAogt7mgJ6AthBN8ksem8F0K2YDp
 fY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5D7Cxn7b9MsMev/P/1/7mvIgigKqkFhH9vyQhINyiOc=;
 b=BgKiEfe5pJKqXsdo89SNWDwMiW7/+rjmFz3sA2cXzXQp+Ru6U7TzxPgc+HKJ/af1Qx
 WmefsB+xmE662Qgdl9PFUVRO5D9S90/NTiBX1PIiTKoCqZ2Znh/TYgW9bP7oWAor2Sri
 lTR+mqB7JCfQ9Oirqp8Sq51pTfSHdJDN3nuNv8Up8KJU9PgYcPCPwSHWiV3Y8JBGQEcz
 WrBEraaE95o38vuvC1pZnmdPMlWed0UlQKE/I5G72rQ2oRDFGOfNf78JczKRhFxePxnl
 YCxTz0Ujc/N0G20BJJurT/89CI5oRmRwF6YU9WzFHgQF66iUg1gu2KbfkCS11QJX1++j
 5opg==
X-Gm-Message-State: AOAM530ZY+c/Lo2YThs3gK2rCnO7xoUfMdMP/WBekPrF2PXOEUB4j8rr
 uO71q4YVBRNMa2nbXQaxOKEAknqrbbr0vyQ96y6MgA==
X-Google-Smtp-Source: ABdhPJybeBgaei3UnNdppGIyxCR9Y6uJ89Bvv2AHsY43C0lP2f8urGY9nbYFiYaFyZ7oZFz0X8tnPimdLeFCRXidCsg=
X-Received: by 2002:a54:4694:: with SMTP id k20mr1651453oic.146.1593083531242; 
 Thu, 25 Jun 2020 04:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-31-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 12:12:00 +0100
Message-ID: <CAFEAcA8+zRSz+mvq5n7tLt4U3kwfFFpSfCnOupBOTWy8OHLgAA@mail.gmail.com>
Subject: Re: [PATCH v8 30/45] target/arm: Use mte_check1 for sve LD1R
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

