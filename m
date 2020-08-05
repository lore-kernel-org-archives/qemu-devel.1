Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F2AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65702068F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7FjH4Af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65702068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Own-00062c-8T
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 15:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3Ow6-0005FH-NH
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:18:50 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:40962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3Ow5-00059I-5H
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:18:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id f10so1000861plj.8
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AfstIsFence6deA4Gn3Q6irVLpNdIbmEDipILdnAxzs=;
 b=E7FjH4Af0w8qnSI/HKNskSngtGBzOYX+7xm+bqdYP1hmHnV5lB9STU3a6UfVcEHgYR
 qpv/efhrPJKC7Man1xozbaQKDWtYorXbLJ5LHqVKr1nzBsbbuybrXi6Weo+/hSSIHCL5
 05y3iF2br5RgH9vDSzQTaKCQgLeiKURFfpaay7eKPYHUIkGxSv4cWCbXCOZKH7gYq5eF
 fhvZzRMBSXS/9h/OUbA4Ce7bvTzCPtheoFKK+jQ5BjCPz5Glw2O5obOz4G0e3kvfyA4X
 Yor9TeNf/spmvwgk2ccf+qKNNwnRsjWLkXbHKkl5ulInqtR8yJBThAuhHoQy0NlvVpke
 pdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AfstIsFence6deA4Gn3Q6irVLpNdIbmEDipILdnAxzs=;
 b=LGCoJnLLoP12Jcox1y5EsMbDNgK0gA0eDqfzMIOwSBuG4n2FjTFxFqVsFIaXU9ppjs
 eaK6IZH9ScypU2z2Enu0JsdB45NkCvSYQ+8mbXzVkVAEv8cPYFHH1y9Nzxuymc82Qrsw
 R/V5H0hUzrqKXNNw2xNrGy3OtXUX40ZGnAZ4jFD6KNm/Rzz/dWacFNcEpXkjbHsjIuBa
 N5LwGyCWafmpoCLmwz3IrkbkavqZb9bvCMk8EX1YzogISouF77hiA/aSt0wqOJPp/5Dm
 Kw08fxbZV5/52d3cnZAvlz+saBrYGMJyZuBIc/hwe1wA+1FgDRKGfnC4hA7VypSv58HS
 GQ4g==
X-Gm-Message-State: AOAM532ur2fzqbqMhxDXZuHAjtApQtV+zBiijxZCOM3TCgE0B5OfzwQH
 +gy9DEKWSDdj7sLCd8r12lwM6A==
X-Google-Smtp-Source: ABdhPJyPPPIkZgJWfTHqEzLVqlYhAC78gxVuzissQgfnifSIA1+yLIof7xfaijSN/09KQM+r/mWyCg==
X-Received: by 2002:a17:90a:3549:: with SMTP id
 q67mr4784313pjb.56.1596655127442; 
 Wed, 05 Aug 2020 12:18:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ez7sm3828321pjb.10.2020.08.05.12.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 12:18:46 -0700 (PDT)
Subject: Re: [PATCH v1 02/21] target/alpha: add BQL to do_interrupt and
 cpu_exec_interrupt
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-3-robert.foley@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <02c892db-164e-89c0-d484-ba1cb33f2d6d@linaro.org>
Date: Wed, 5 Aug 2020 12:18:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805181303.7822-3-robert.foley@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
Cc: peter.puhov@linaro.org, Richard Henderson <rth@twiddle.net>, cota@braap.org,
 alex.bennee@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 11:12 AM, Robert Foley wrote:
> @@ -299,8 +299,12 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>  {
>      AlphaCPU *cpu = ALPHA_CPU(cs);
>      CPUAlphaState *env = &cpu->env;
> -    int i = cs->exception_index;
> -
> +    int i;
> +    bool bql = !qemu_mutex_iothread_locked();
> +    if (bql) {
> +        qemu_mutex_lock_iothread();
> +    }

Why does this patch for alpha need to check qemu_mutex_iothread_locked and the
next patch for arm does not?


r~

