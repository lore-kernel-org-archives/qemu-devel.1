Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07D2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472D7206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQMp05qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472D7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJzH-0007rE-7x
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJya-0007PJ-0M
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:59:44 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJyY-0004sI-2o
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:59:43 -0400
Received: by mail-pl1-x642.google.com with SMTP id o1so69579plk.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 16:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eeXMNyNlVKHAv0yBHrPkemQpFjtNzRhWfy4R8Ln7riE=;
 b=mQMp05qcowFc81OlhHfwAc645kv1kXqtNOKfvyUYPnPMjgQvUau1ST794yGNGEGI5g
 HYGZyg/6N6JHdXkzFxdpComm/n7M0gw284QeiNmuRZgZ+45dmiJXEXBqCltohBTu3OvU
 QJdlGp9fX3GTnvtmMliEWD+nz7/U0hu9sYA/AjzAW9XJaBMGWXz1YAUG12Oo4XQyFCI0
 T8GhBYAZvzEZTHSbe3ZL1UCKf7urtZ/45AvWv0JKoko981+qBsY+DgeaR80RYbEL8bjR
 dnfY+mmjtoFjZe+c6gi+yDArRf1lmUavxa8gaB0KJLRrQ+Brp0q9E9ztHCoOxc3pi5FI
 7B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eeXMNyNlVKHAv0yBHrPkemQpFjtNzRhWfy4R8Ln7riE=;
 b=l/eiSyhRL++Y6T1k+06xENQXNhXttWTFMrTyWmrklQE2fJW+5r752ur+bG8O9xAQtx
 hgvS4E91LIQ+cC58rhMwie2Qfn0SYG0hD98z7H1niso4zpz8c9ySw8VcWY6YV+2Thr3f
 GjBIEI9Pfqt0vRmylK4foy/4ajDLVkZ1z2sGWT8tcu0SbNSCVKQOvaMC9RQXGQcPh0kn
 JdluIOSklKwpTWHmUvHQOfsBx4BL+6jQVa2Iy9cTp3BXtL43YW+35wX/Hy7zKJOFfo58
 gR0xzRFPb2xJfC7FCjyTEZI1lYmoTntE0DdUcVRpTHgSV9EI50j3rcm9BXeO4AEmvf15
 q7UA==
X-Gm-Message-State: AOAM531hqD2irJia7rt7EaSoZdN7GskmIxXlwJsXaQwAvdr7ld0rCwuP
 ICt3tvwtafqw5T16SPRUEoPcmg==
X-Google-Smtp-Source: ABdhPJzWaOBDuKK1Xt2+MSVGQ+gWQ0nmPmy9VM4u0o0vqz3nFwiyEWyuotbQLwTKpZTpXTip7WuO+A==
X-Received: by 2002:a17:902:d215:: with SMTP id
 t21mr31610376ply.136.1594252780409; 
 Wed, 08 Jul 2020 16:59:40 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id l16sm748993pff.167.2020.07.08.16.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 16:59:39 -0700 (PDT)
Subject: Re: [PATCH v3 02/21] softfloat: pass float_status pointer to pickNaN
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
 <20200708222101.24568-3-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7d41f2a2-05c6-8658-3555-bac28ba80346@linaro.org>
Date: Wed, 8 Jul 2020 16:59:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708222101.24568-3-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 3:20 PM, Max Filippov wrote:
> Pass float_status structure pointer to the pickNaN so that
> machine-specific settings are available to NaN selection code.
> Add use_first_nan property to float_status and use it in Xtensa-specific
> pickNaN.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Alex Bennée" <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  fpu/softfloat-specialize.inc.c  | 30 ++++++++++++++++++++++++------
>  fpu/softfloat.c                 |  2 +-
>  include/fpu/softfloat-helpers.h |  5 +++++
>  include/fpu/softfloat-types.h   |  1 +
>  4 files changed, 31 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


