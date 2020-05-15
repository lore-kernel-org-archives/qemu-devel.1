Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB985C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BC820657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGo4g96J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BC820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZjAq-00064v-JJ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 18:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZj9m-00058e-7H
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:50:18 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZj9l-0006xc-3b
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:50:17 -0400
Received: by mail-pl1-x643.google.com with SMTP id k22so1490634pls.10
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=oi1H+y19DLbIULVXG8f5Ml+d6LyRuAkFYrmphFta2WM=;
 b=RGo4g96JrPoxz18SVMoIGCG/1S9yw7hR4c4E5b1E5YfRDOR4PcP/dfhiZzo2gCn5cT
 vJRrnryzdN5VytnSK0ePzQ06ceyXiKcVatE+T7VcwRCHcZ9EsMyXO7wtlCjShttT/yUS
 nsB5o1/C3n6gx7cPTpJZVIhPHf4Ru5rYudfNJF4v5pvCqVycb7vEy6ScDgEWy9+fN5FV
 rMCxxBc/rvFySGUV1tUy+7QyFQMGK74q7x9ZVYAqtS36X71BWjnPSch6KZj2BsgoEZtV
 EWnxvsJFwqDFsMFBixHiX2ChU3u45IY/Ub7E2b2jQ2Xwej88I8XmyPBHt5bQ4BYQn8FX
 GX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oi1H+y19DLbIULVXG8f5Ml+d6LyRuAkFYrmphFta2WM=;
 b=EEK6NyuuQKC99kJPriuGJCVDoLDdLDdgNwnRNkviYwtxL1dHgTvQ/HWSMEMhjQ1/qR
 QZdMg5ArD2vVFnJnntrJrFr7tUH4Z5g+ojZlpQJSUAHQT45Vb7NRf98Ulb4LQNcPOfq9
 mwSybhwQJ6bXDYoWUHBa6vfYRoWNaMPz1f9KKnWITT3Co9xnoXJVQ1KOUEXT6VJFdsPR
 UiLtsxoKWtE8JzR/unnrRaFQmS3k5UC2ElTkAYjZalow94kixtNjAji288eYHY7v3pI1
 vKso0KSJDbWWUdAgdCbUhTlLDhHck4W9QcLKfi4+LhuXHMmudnwY16lewe0lnqdqB5Lo
 9Mfw==
X-Gm-Message-State: AOAM5317sF7ggh4d60jTZs4KwRP85g8TzgGW3IQNwScIaAK6Kgs1Qyhf
 uNkFtpZkHdTcXUUQDySpoyNNqXImMwI=
X-Google-Smtp-Source: ABdhPJyiMDd6PPiODhHtI7gvg+8P6z/X4jHeiIQKrBruOIB7UjJb2zB4/B3Ai8oOw1dLac3Iag/ynQ==
X-Received: by 2002:a17:90a:db53:: with SMTP id
 u19mr5664490pjx.41.1589583015485; 
 Fri, 15 May 2020 15:50:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d8sm2474408pgb.42.2020.05.15.15.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 15:50:14 -0700 (PDT)
Subject: Re: [PATCH 04/10] target/arm: Convert Neon VSRA, VSRI, VRSHR, VRSRA
 2-reg-shift insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200515142056.21346-1-peter.maydell@linaro.org>
 <20200515142056.21346-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03386d17-94d7-3fac-3e3c-8d4cf8488ce6@linaro.org>
Date: Fri, 15 May 2020 15:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142056.21346-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 7:20 AM, Peter Maydell wrote:
> Convert the VSRA, VSRI, VRSHR, VRSRA 2-reg-shift insns to decodetree.
> (These are the last instructions in the group that are vectorized;
> the rest all require looping over each element.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 63 +++++++++++++++++++++++++++++++++
>  target/arm/translate-neon.inc.c |  7 ++++
>  target/arm/translate.c          | 52 +++------------------------
>  3 files changed, 74 insertions(+), 48 deletions(-)

Modulo the extra formats I mentioned vs the previous patch,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

