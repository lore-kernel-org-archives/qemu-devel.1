Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15273C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05B720754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsUKGaQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05B720754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyZI-0006C4-Nh
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNyXq-0004sk-5M
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:22:50 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNyXl-0007zf-UI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:22:49 -0400
Received: by mail-ed1-x542.google.com with SMTP id g3so1290170edu.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zhZ2DrEBJHc/wY+7OGWbuJoNY7yjbhzfKXMfXQbrk0s=;
 b=EsUKGaQ01A+j4rUb8i2zvY3zK+ZUEc/C5LlTH9f5dwoHP6aN3SEo8lptIP8OfMMEWC
 OorntpQBqe5OFfTyiIlQj0ubAziz0BvEEP2ANq8NcGBlVe9bFJOTFhHs3SAXS2VdTx3w
 WCx1L8XSA5OqDqkr+zNYBY3JiLiPO2OeC8UE/WjeSE95vAvh4E5YsAQT3ZireL5jOFC3
 be4D8PApjkWchwYzc+O0BEAP1GZBNHbb5/pu3fEcPtdSxA9lIKZzdyeRcO6rhpFlVP+A
 EJPCMR4cZaEgRaqKmb3Uxh2Uspcvqfn2tT1UqwBffzOaYKqDv7PhGxoGJSwSLyHYsRQH
 T9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zhZ2DrEBJHc/wY+7OGWbuJoNY7yjbhzfKXMfXQbrk0s=;
 b=C7nndLLgqffObf0nV6PVYOtHBE+CEaa6olsLP38SjB7j8SKyi3zrKo6cwdBnqDSofE
 nGGFQw3EX7+1UP5THkXVL3UmY9QVGkKESImVNrGA82uaqjNk/Yulvk8jV2Dk1xUO15Ce
 cBEBGz6DuUxwYdHDOF1npmP+8/9U7RPSMBswH+jwYlGkbkeqNd/bdNHq1WbtImx0npTo
 Dx2ibwyVgvKmwfgjRW91RMxSpJS+ASV7Fpm/7VW9OCQc11HAJ/Z9P9sW9DikPmkF5FSf
 EJEiOFG+Bs0ohIe9pCN0kmzdzO/E1aHXJxDyYEB64leIB/1hY37eGcE2pw0D0gPDHwrW
 y0/Q==
X-Gm-Message-State: AOAM5319IY7yxLF99wNXA6SY8Tr18tuYkkykXOEkEfhIk5PFDIN2wlG/
 WWMDFJC+4urvZSqfnbSQILwbcyhNtPfC5UEuhOt9Cw==
X-Google-Smtp-Source: ABdhPJyWSwnHguAVQ4ypKjz4okQwrIzwWUTMrzWUghCQPpOYDPORkBlxBPSKc2QYC7buRk9oHgNhHubEMzaeBqpG9Ao=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr8546896edm.100.1601558563157; 
 Thu, 01 Oct 2020 06:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200918000500.2690937-1-richard.henderson@linaro.org>
In-Reply-To: <20200918000500.2690937-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 14:22:32 +0100
Message-ID: <CAFEAcA9xe+wLBbz9xbJCS7xd=bLqMSxAth=5cQhu-XN-RDHRAw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix SVE splice
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 at 01:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While converting to gen_gvec_ool_zzzp, we lost passing
> a->esz as the data argument to the function.
>
> Fixes: 36cbb7a8e71
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

