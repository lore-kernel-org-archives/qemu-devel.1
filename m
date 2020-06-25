Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8723AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54382204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7nOy4Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54382204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUiM-0001Fi-Kd
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUhK-0000Cw-TT
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:25:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUhJ-0001nV-3P
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:25:58 -0400
Received: by mail-oi1-x243.google.com with SMTP id w17so4771141oie.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q4NICn2rH9wRXLsNbSacQr+mTFRLOs/zOXykNRuPmDw=;
 b=E7nOy4WhTn4Y6T562b2h68Z/JAsJ6nEe28zCJPmT7gKdp21Bp2S3o8beGrvjYTxhyb
 KvKFZKqVLnSpKGC+ErUYm/k1NA2+WewSuAaJ8e6VL2tU1b/bQ1pWGMpqo5aCW342cXTE
 YQoMuYllnmnaWhoBOth4gItxVksIRm0Gqu9ejSKKzEpcGewFrFodZc3eAszmyNVkmgG9
 HXaqRLRGtPj8m/BVdEkWTuWoqnMtMajhlrr+DDi/v68QS8U9V1vkP6uZNvLTV8jGKbpo
 26Iv8WPuetz4JoRZ419xzYrAG99333xTxIYbDjlaBsAEqss7oIYt6mlKKHShmfQsda0n
 oVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q4NICn2rH9wRXLsNbSacQr+mTFRLOs/zOXykNRuPmDw=;
 b=KtM3moEGxmzkZEqgKHskmrINE1lW2FUEP6zYWK20PAmD4n8xRRc5o7Tp4rBufBW2SS
 TreAiNpjp+mu2jE89juZcmEH5EiQkZxZphGqnOonOIkTcBDfPmvYmcSUiIBiAb/ab7HR
 zFKfD3BhbW3czXd5WSvSMQf6ct9T3r/YwiRWKqAfBvIoTGVrjZeS91/uZPca14q3wsg7
 mMqoYZ0n0R9iZ8d27Ca18i+xMkXuzbP5cl/N2aNOvrAhZ5opd1VCUjoOq+lTUenvCt/i
 N1THlh40P0nKPSRmo/3JBT5LlORe9pM4KDqU8Do7ldsthuST9wND00u2Q7qp5AFR8grS
 P9Kw==
X-Gm-Message-State: AOAM532+jUav12C5m9JKzhpTrrWDZa5hfAeEQFfDOO+jtDouq9cqigmQ
 G157Gf0TxsW+YaDixrOkbsaJ3PWPjres44stlmQ8qw==
X-Google-Smtp-Source: ABdhPJyJnzTcalDV4hjCXEDde7X78gtsEsrvkgvdv4Vm2dZKqNItl4ZbN/dh9JruMPIYqzMciuJr9nYjoI9uQHp3OWc=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2946481oia.163.1593102355864; 
 Thu, 25 Jun 2020 09:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-4-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:25:45 +0100
Message-ID: <CAFEAcA-y4zVO059kyULgqJmY0_sRUUDREryQ3Zp54zkw9ykGTg@mail.gmail.com>
Subject: Re: [PATCH v2 03/17] linux-user: Check for overflow in access_ok
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

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Verify that addr + size - 1 does not wrap around.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/qemu.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

