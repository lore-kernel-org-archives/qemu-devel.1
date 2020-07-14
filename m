Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C75C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F5420760
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nweXCsxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F5420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLNS-00008i-WE
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLMj-0007jt-JK
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:53:01 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLMi-0002tN-1r
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:53:01 -0400
Received: by mail-pf1-x442.google.com with SMTP id 1so7597466pfn.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vwfkHH4kfa6qoa98JVkW6baA7c5gJwqwJP3BBo6e/kg=;
 b=nweXCsxoHGEQzmSBSMuaUzvTm1YJqHfwNtklajfKfyVS99rwBa0hCAc+bp/6NNAkw1
 Pyaud+CW1a1DaFnt2/TCP/kYzNFQ0LBDJTCL4dA9TXXkZWfI3cc1dbB5Xi8KsezOJ/RD
 ER+nypQMYkbpXAAuaKwLQVwF0uEyXFm8rYsx2jLUWFFcdbAUBkMGY6B2k3hAwm483OFW
 j4nuGZvM70MoTEs1TWgRP/7g41w+WIPEzlsj7nuO7/yTXQNQtXLPVVDFmx8HE7ccl7j5
 ogKqxp/a3P0qvNdr7hbeyRsGz9JQiWphTYyQrxY4vsgEEM57NPCi6sT750wC+79LHQ4a
 HhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vwfkHH4kfa6qoa98JVkW6baA7c5gJwqwJP3BBo6e/kg=;
 b=sQooQSDB/hO+K4KzK/A0WZdexWsc2MZUc+YozNBUIMmx2OP8oEzB1LwiddHbRju+YK
 XE4SVqLeo4OSlIfZEeyF7vTtC68i6S9Os+iMsxsr7iL6RmFCVWBUUA1vgw6wImNYNg1J
 xDJa7D564Ehz86rdKZOP6edC/LiI06m5EMbS+fFalTpuFHJe9ZuixmQSUM0+6xhWf1Rk
 Og5vb2aju8bMO/rS5B5y1Iudgc8AMuXiH45ijlcPI45vl+mDhUH/RTtwyTkVxq/pB6Ge
 EBb4t5+kn+GWkr38G+oaSy28mdrPn+Jzr1sk0FrDm1Fj88TA+UBIsyAR0mkITrwqUYHR
 8gvQ==
X-Gm-Message-State: AOAM530LXfau2thujaYwn/Zrn8w2CbieA0eU9tREJqYXeI4Ag0Z7TqQx
 suO0zVSY5IrHDkQ6tyUMLzODCQ==
X-Google-Smtp-Source: ABdhPJxVdRSYXR/kMGoOfC/25LUC17b0DzDG0M9F8uAQueZ3FMLomNseT+eS2Eu2UcYNKHQ3LiL55A==
X-Received: by 2002:a05:6a00:78a:: with SMTP id
 g10mr4536227pfu.0.1594734778774; 
 Tue, 14 Jul 2020 06:52:58 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm17826208pfo.192.2020.07.14.06.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:52:58 -0700 (PDT)
Subject: Re: [PATCH] target/cris: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600455-23439-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6314e8a7-05b7-3119-c607-e8413d047d87@linaro.org>
Date: Tue, 14 Jul 2020 06:52:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600455-23439-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: xue.zhihong@zte.com.cn, qemu-trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 5:34 PM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  target/cris/translate.c         | 7 +++----
>  target/cris/translate_v10.inc.c | 2 --
>  2 files changed, 3 insertions(+), 6 deletions(-)

Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

