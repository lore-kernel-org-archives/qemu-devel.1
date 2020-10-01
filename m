Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F829C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807492085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGXvbEo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807492085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2Ll-0004Ni-Gz
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO2Ig-00013Q-Av
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:23:27 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO2Ie-0003tB-KZ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:23:26 -0400
Received: by mail-ot1-x342.google.com with SMTP id m13so6205591otl.9
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aadCQxrYur+RQnESnD9Y8brdfumKt2rm4LSnIfwNy7Q=;
 b=cGXvbEo1398dB0Fb42e+AoxJM+9yGteEJePrC1UOOPSkCV8w2Wocd6jG1ddCgT9BUB
 B1j74ngBNQW/1V9zpKWZRY33Ds5TXeZKwuGW10V0W4RK2bM/NffF1QbA9sfCJGg5JBd+
 tn2X1FrYH2OGWy6olz8ivVxiv+MFDelecoZqz0nJIYgr7T9rFvMvWVkz99Ta85fmxvZJ
 Mpin0MsBWH/aiLIJJbIRxRY3eXQREDN+ixL9Eso7R+OxKF7kJFluGxf/AnwZnxx15j4f
 QqZglNje2BYmtMYknCQ3eakeImPq6+FBU78j3OWqip9z0gOS6PycuQIboH/5p86/0mj7
 7rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aadCQxrYur+RQnESnD9Y8brdfumKt2rm4LSnIfwNy7Q=;
 b=PhqTgdnEDEedASOomwPBfHwBsl3SS9eISj7Im1RbBvkZNSvMBZiCGanwfZb4obhSlC
 Ma25SAGJ9SRJsai0yJD72F4e2z3OSPA2IBeXlBEokXuTHXdS82a10TjMvbno5CvZr4Q4
 9I8IEyNiXMzd0q32o6+dq34mW+Un6I2UMuhz/oZmHFBrpNmb/pvY2+eNtQgxpZraO370
 56rzVM1/STG29DNC/8LIfhZ1Rx2w5CuuPoZc0sdjFacGAdRe3ajOOB7KPRYaDQLJXaS7
 FkXXB07i6SAmJZFHkuwpfIaf9Rlk7aW9Ihy9wzMo7yJPdO2bRTFeH+l+oZKYVNdw1XyP
 NYDA==
X-Gm-Message-State: AOAM531K1vYuqFxTSJ0q2ZVxX3tSTT+F3NEyv/EgSAZEXaGbAZZX5rhG
 yImnSm4OhWGruLbBigFueXyElA==
X-Google-Smtp-Source: ABdhPJyulHV+kxqrwa+U4JdcR336SKWaL4xTOn91XXOItuIg8iAoryrt7a00QtA46iCBzlaKunLflg==
X-Received: by 2002:a9d:7242:: with SMTP id a2mr3266767otk.186.1601573003398; 
 Thu, 01 Oct 2020 10:23:23 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id s13sm1354517otq.5.2020.10.01.10.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 10:23:22 -0700 (PDT)
Subject: Re: [PATCH 1/5] target/riscv: Add basic vmstate description of CPU
To: Yifei Jiang <jiangyifei@huawei.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200929020337.1559-1-jiangyifei@huawei.com>
 <20200929020337.1559-2-jiangyifei@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b70824e1-aed9-1d72-21e8-ac444ccc9a09@linaro.org>
Date: Thu, 1 Oct 2020 12:23:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929020337.1559-2-jiangyifei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 Alistair.Francis@wdc.com, yinyipeng1@huawei.com, palmer@dabbelt.com,
 wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 9:03 PM, Yifei Jiang wrote:
> --- /dev/null
> +++ b/target/riscv/machine.c
> @@ -0,0 +1,59 @@
> +#include "qemu/osdep.h"
> +#include "cpu.h"

All new files must contain license boilerplate.

Otherwise, considering the followups, this seems ok.


r~

