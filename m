Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F342FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 03:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EC0205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 03:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldZBJHHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EC0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMNDD-0003nk-84
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 23:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kMNCd-0003NH-Et
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 23:18:19 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kMNCb-00019k-Q9
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 23:18:19 -0400
Received: by mail-pg1-x544.google.com with SMTP id e18so1828007pgd.4
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 20:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tEde0oVVjOwaVuHFWk0AGRryI0+4OYZ+7wyx5U2xlVY=;
 b=ldZBJHHvcl0Me6Rg1lMsKEsybnloCHS/Cu9wgg/spopOl/sCYsdTV1kqBxihFBUv5d
 1yU/2MhJtXL6kzSgdnbB/NocXDDRa2UPlbY7/vQph/O6tTuCMIJxc8wE1g2IQJ4SfeOz
 +m3Ca8am03VN8I1lGy8+6E9u8x6z1U6f6Yx1pA9VAsdSfHZkUjp23qZOXfRz4bAzVSYR
 YhUO3LDypW3GC0FLTpm4K8EC1qMoTew2IP7McDxWfGs4GNY1Q8CSB9zll7QYrhfXQz4Z
 T5XForI2sy7CYunCOEMFXPoNAjJseNchYWk7vz6+u42bYDrLLVX/CY7gO8ycsEJK1OYW
 e0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tEde0oVVjOwaVuHFWk0AGRryI0+4OYZ+7wyx5U2xlVY=;
 b=dU9iS5pTcznBflzjAifYqUKdQLRhJDd9uNmodO3JqBlCrBpr4IByFrWAw/SXe1FypY
 xAGeIx5g//xz43HK48wUJT3/2KNxwWVP4atG6dsSgWB8xbl1nmxUNvZxZ2E4u9BOZO5z
 klnyNt8SsoCsr1qXiKgpnu1je79x1k8f6uEZnXYno6S0SZwQ+J75KgdHTvtSkFjGWsVR
 mYr7dTmNP4aN0Hj4D3Ig9ZJWPPW2cF2rzuv1lhYFNA+Gy8y86DiUtvs3z0mQaFz9RfvO
 S7WaZXeahuHlfFdFaNmMESAHsEe1ip7R88L6lRtLKmWXJpgIeX+IgPcY+YCqAlrI4+ge
 QWNw==
X-Gm-Message-State: AOAM532YkqmWvL4ka26hktewjX5zG2wq7VYYrw3afVJrGm8S0BOCN9vL
 dzpUbtHg53uwZcCVK2+EBjJzag==
X-Google-Smtp-Source: ABdhPJz5GuOynhgUJFEV3ep3WX4gq0gGCdBd2ebCSiZ7ihWdti6oa67yYdZpq0PBxyOZdwiH0Tm/iQ==
X-Received: by 2002:a63:c74e:: with SMTP id v14mr4423240pgg.186.1601176695960; 
 Sat, 26 Sep 2020 20:18:15 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 72sm6640360pfx.79.2020.09.26.20.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 20:18:15 -0700 (PDT)
Subject: Re: [PATCH 2/4] plugin: Fixes compiling errors on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200926140415.1286-1-luoyonggang@gmail.com>
 <20200926140415.1286-3-luoyonggang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6e76dcf-187c-4e49-a82c-ed0b637d07b1@linaro.org>
Date: Sat, 26 Sep 2020 20:18:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926140415.1286-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.213,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 7:04 AM, Yonggang Luo wrote:
> @@ -72,7 +72,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>      CPUCount *count = max_cpus ?
>          g_ptr_array_index(counts, cpu_index) : &inline_count;
>  
> -    unsigned long n_insns = (unsigned long)udata;
> +    uint64_t n_insns = (uint64_t)udata;

This needs to be uintptr_t.

r~

