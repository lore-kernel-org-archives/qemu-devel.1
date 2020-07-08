Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B254C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B4D20786
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnyUh4aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B4D20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCnW-0003Tw-EY
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCmV-0002Db-Ja
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:18:47 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCmT-00048X-IX
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:18:47 -0400
Received: by mail-pj1-x1042.google.com with SMTP id t15so1395484pjq.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=kkWIbkNGWdWUvqGQupOw2Cj1/7qklfMAzkUg5S6Lhvg=;
 b=cnyUh4aqJFkRSxhDaKvrLuXVfAXJFMU4cydymS7DR2w+hc1NWIdYe6h61DyvKcR5C4
 kTlS/vhcRM9MHOBABMYgOBKbZxJMrdhZFVa/4+NEszor8gQs2BRHqER0ZVictqb9UdMR
 aBgBOWOpDkAybyOXfQpCaeJQWHXWVhB/zm56SkyTFtoF/lnuOiinztUMj4jQFQdfD5Xe
 5F7ULFomybNqpt3VjSytHVncc1Pbb/QNQ9KRq6o9jVJsgQCmdpxfYhlGVjDpla97/uFL
 LTFia/LY5uaUCGOpGTBkAmk27fYe/YxLkEahGK5WmCDBKee8/FjR5JHeh8kj5h3EiLry
 qPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kkWIbkNGWdWUvqGQupOw2Cj1/7qklfMAzkUg5S6Lhvg=;
 b=qICHN3Ok5oKhIWm7OpuwBu2NpxFKPXXT/fb7YOSEJPVRUCVN/aCHpk5bWUAPo7TTVq
 tKc9IhywS1Ux1KW6SOgMwDK2MfVsEheAJbI0bBPdZIht516rSj1DpnWHa//CRTK4OJ0s
 Q+3Hss3rlj/DxxHZu3T+zyrDnUJWOa3F7tWtTcbllGDknZlBe1wv0chED4KY4ar6g9WT
 gCqN3+zxBvBkXQbp4hccW/jlQS7LZiwFbl9rBxXWD3SIGJZa+lNKmsswglmGtFUs5CjX
 GVna9b8MQlwP/HR1ul1G9eBAmIXXn31uM/OXCAVHk5uyA2A4TBZW6/8uDuSfPFGYmVM+
 nJtg==
X-Gm-Message-State: AOAM531gIWv6Pxd9gFuuJ/r+ZF0ES0Rmt+8yPC14TinqTij8aELE/q/6
 Ya1VcZkCgJz+dumcKJs2pNPHnCjJRLo=
X-Google-Smtp-Source: ABdhPJykRH66fIMLMqP/vLFfiba8p0s9PD1FZK5pTGrz7JKgLSkcb5L7KtarpFQX7PaKQxKBDiXnNQ==
X-Received: by 2002:a17:90a:ea83:: with SMTP id
 h3mr10835128pjz.176.1594225123959; 
 Wed, 08 Jul 2020 09:18:43 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id r6sm275682pfl.142.2020.07.08.09.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:18:43 -0700 (PDT)
Subject: Re: [PATCH 07/21] target/xtensa: move FSR/FCR register accessors
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-8-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f04f7c0-6761-ceb0-c19b-3b9b3eaa9d13@linaro.org>
Date: Wed, 8 Jul 2020 09:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200706234737.32378-8-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 4:47 PM, Max Filippov wrote:
> Move FSR/FCR register accessors from core opcodes to FPU2000 opcodes as
> they are FPU2000-specific.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/translate.c | 64 +++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

