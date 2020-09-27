Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C9AC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 17:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5B72399C
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 17:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqYA8njH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5B72399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMat7-0000LD-3O
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 13:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kMasY-0008L4-Ss
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 13:54:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kMasX-00050R-2j
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 13:54:30 -0400
Received: by mail-pg1-x542.google.com with SMTP id g29so6256336pgl.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5dNc+/tH83QRCkbjC7Lhc++CK9QQAiNDtwEMQw9WJpI=;
 b=lqYA8njHTLXlmGaayFbMEZDor11v0NWJijWCesKSagbS8slcbQIZ2R/7YN8UrNV6Tg
 P60vq4guHOXBpnYjrUNooqTkBHP5O0VPAlKlNd76FWALt2lyvG905BhmrUY6lc9aJ2XM
 K0LfsJdVHYWXPjRXOiskAeXdaKMXZMjdunFRRxxw9PPd10OvvOPhd9QjM7mQEhQfYy8T
 TQqQ6Vuw8Wv394G30JkTb//rWRUTxpVwRq+P0zjo0M5E874EGjdXedkAa7P7/lJag8p7
 GLvH/ImYUSTJxXDDjGvjQI2HJcKc5EFwoWwJjrTtD2gViQQc7gf/yRRYtJp3zaKZ5b9V
 zNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5dNc+/tH83QRCkbjC7Lhc++CK9QQAiNDtwEMQw9WJpI=;
 b=suCRZ1/9PYhLieLbDe34lAQ4/bbLynNEFAshgYuEqoUEMUYxXWlLFbN+G6tSqlo/y5
 fBphgZExCH22GnnfUh/u8WnQeeNpnYKZWH3bihXw88GTvjCzgTQyEPpe8jBFDqcjcHjU
 L8/nNKiI/SPSpiGcw+kYelKnOffWma156KW5UWdjv/db7FJfvfBlml4MKGV7VCFm+qFa
 4okyjDtHfLohshpl982MydQQPhT8gbWrE+L3YeiIQJPR4asI11jpmY0qvxe9DVgFzAkA
 XDL+q6Ni1rwJLNQGs1DLf7sgs+/7A5dGiH/t82B3k6hoHwrsDz+2fL8wIvjw+Qq7jrUz
 28XA==
X-Gm-Message-State: AOAM532LQPU3TK1Nxkig+7i1gmAWO29TIcD2aNd7JDRFZ32obyI1gZqH
 o3cLMet4fU7G2BwDszalJQcs3EAEmkJMKQ==
X-Google-Smtp-Source: ABdhPJx/TO3MGF5shQMM+ujvy4trdQanxlu36IHIAqgGYAx02ftefldRPonhaI1u08d3v1b53VUpyg==
X-Received: by 2002:a63:a510:: with SMTP id n16mr4208147pgf.256.1601229266918; 
 Sun, 27 Sep 2020 10:54:26 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gj6sm4534452pjb.10.2020.09.27.10.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 10:54:25 -0700 (PDT)
Subject: Re: [PATCH] linux-user: i386: Use trapnr which returns from
 cpu_exec() instead of exception_index
To: chengang@emindsoft.com.cn, ehabkost@redhat.com,
 marcel.apfelbaum@gmail.com, laurent@vivier.eu
References: <20200926103956.28199-1-chengang@emindsoft.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ef9553e-94fe-56fa-8c17-728741afcd9a@linaro.org>
Date: Sun, 27 Sep 2020 10:54:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926103956.28199-1-chengang@emindsoft.com.cn>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.011,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 3:39 AM, chengang@emindsoft.com.cn wrote:
> +++ b/include/hw/core/cpu.h
> @@ -458,6 +458,8 @@ struct CPUState {
>  
>      /* track IOMMUs whose translations we've cached in the TCG TLB */
>      GArray *iommu_notifiers;
> +
> +    int trapnr;

Don't put this here.  It belongs in CPUX86State, possibly with #ifdef
CONFIG_USER_ONLY.



>  void cpu_loop(CPUX86State *env)
>  {
>      CPUState *cs = env_cpu(env);
> -    int trapnr;

Why are you removing the local variable?


r~

