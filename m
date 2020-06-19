Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CC4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F462186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTZNLVoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F462186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQVS-0006v0-MJ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQUm-0006OU-C6
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:32:28 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQUl-0000Pl-26
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:32:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id v11so5165155pgb.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=1zOeVC30jfVm1MMvsEmRuFOc6nJ0U8IaZeGnW53qhLo=;
 b=QTZNLVoLksxcYiyK7TIOC2l31DMBk1n1sLniO3gxPoV8P7eSvYfBwWWDzYNmgt4Nod
 uS7mb40prODzc0b+FW7qHjShUoOdewWeYCb+yUK0fkjRpSMD/F1DRPjDZX0imKiepexa
 WPN8ws5/aLDPfcoNHnt49RNnrrAj1UyPXvx/MJC0WP3xaZzBFunMS2NedGj/41dTZ+n/
 cLXIgBwhILwcAPUKFnfs3mp0CGi4rNPfXeAM/VHOl/C5eQV0QKUILID8piaX3qFqt8Oh
 k4WPIrpNp/0LVektEyIHP/fCaJk4WIC8p01nxBoMs76EtYy5J13GRTA59KigyW82QSbY
 mhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1zOeVC30jfVm1MMvsEmRuFOc6nJ0U8IaZeGnW53qhLo=;
 b=gWgO1Tzc1si5mrbAKUkt3HXy1Kn2xoiFjWRdhSUmfNG8EiPHOM15VmGmS+e8v6JQX+
 1PUIOfYQor4v3rx5nWZOeyCzKpJndmXEUyL+7S34BF2zEAasdjtBhiJSXv0VwNuisuTu
 UFVXCE3ZTVn2cZazaZH+RirKlkI6Js7nngaDY9DocZlhzeBJQ1qntyzFtXbCRvRP7xRO
 H/eT9AYespoZv8923qoAX0d77ouSx/oSrv+CS/yhf6g31BMWttSNyDLM9rt6wGfeapXF
 TOBUrYabgy97iVaCj7fqXa1jtO5fecR+j1At1ft/51V6678Pk8FyfPJXrPcqGEnMfdst
 0OwA==
X-Gm-Message-State: AOAM533yU9tIOdRTME+3iepkej0HjF1syAWS6ek2hsJoA7nsOljiD6ZP
 p/aeYSvr0oYMK7ZKm/9aqg3kk2e5LAs=
X-Google-Smtp-Source: ABdhPJyXcFh7tmE1rgrqDzL7MDUKRDJ7MglY80Uhomq05309r1Yhtt51mtDqICwO+JNtCo3nSmxmYQ==
X-Received: by 2002:a63:dc13:: with SMTP id s19mr4732846pgg.53.1592609545111; 
 Fri, 19 Jun 2020 16:32:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p31sm5937691pgb.46.2020.06.19.16.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:32:24 -0700 (PDT)
Subject: Re: [PATCH 10/21] target/arm: Fix capitalization in
 NeonGenTwo{Single,Double}OPFn typedefs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b439e716-4489-d316-3256-c6bcbdc98329@linaro.org>
Date: Fri, 19 Jun 2020 16:32:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 10:08 AM, Peter Maydell wrote:
> All the other typedefs like these spell "Op" with a lowercase 'p';
> remane the NeonGenTwoSingleOPFn and NeonGenTwoDoubleOPFn typedefs to
> match.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.h          | 4 ++--
>  target/arm/translate-a64.c      | 4 ++--
>  target/arm/translate-neon.inc.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


