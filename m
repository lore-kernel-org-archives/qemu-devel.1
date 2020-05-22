Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20168C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CB920748
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzpMgl4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CB920748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbyFY-0007PY-1P
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbyEs-00070N-HW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:20:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbyEr-0006iY-J8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:20:50 -0400
Received: by mail-pf1-x444.google.com with SMTP id x2so4516372pfx.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 20:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FVmF/O7FpEe0HqEOcEde8Y3yU8U5ZvZ43RhN2Mly5IE=;
 b=LzpMgl4Vg3LtMTuaGuNICbOHD4CSDJbKwFOKUtQlmciIZvTToH1f2TdnEsOBU+DBRZ
 NIchzmfNjdA3kqfO6LCTYlQlfa+jJ0vCAygKn4ERc0gNlWoVSaBRXFy7oB5VIl/648LR
 gYpcNvGLHYdY9jYSVzt31psTb32ocCNMX8aSvFulpnqjKI9L5qAWmCw7bLrysspQX3Fs
 yY+7wum5aRKWnXxesfInBWipxOhk2atiGhLlnLK4CiEjttQYCLwsMVvtBXN4aiDXSbqL
 f1t43qk/Et18FaBUcpXG8LGttjsbrYLIrvAHi2Bc6lFSmpVGjn3d/71RaXsV4qaN52gW
 Gegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FVmF/O7FpEe0HqEOcEde8Y3yU8U5ZvZ43RhN2Mly5IE=;
 b=YMJIn5gQUtvNBD1rsy5pF6QegaG3JL2tcq1sGleJt0/kgQUHBjF9wT2AwtXvTA0ykj
 9Y8e+T5BGxdv6kxGRKtdkTEKsHpJwOz/Qxr+msiVNRKbksiN+W6q8b2w4kZDQSzcs0s2
 tGa5NTUnoYdyWTPRANIfkwAICuLtnmZATGVzJL4EPvYxqV9qbdbGFqbF+IzQ/anuHCTN
 6BTu2VvOxmQRbBWmpHDFc9R//kt66hj2YJuZLXtjsK42JndVw93AKLgqFbuTjaWtLXyw
 Jlk8wsCWA+mZjNHk4ueuLMoro8Y+EDUj6r177WKI8W5T8E6oOnK2aMIlg4EA1Zwy9OL9
 yhcA==
X-Gm-Message-State: AOAM5317JcHWjzLMlj18PwPjj4KfoBiOPP2zxw7/pmSg7Va3vI0wGGBx
 kfsRrSg2gd9KgEyGGXZTbydFyw==
X-Google-Smtp-Source: ABdhPJwkAqpqiM//uVan4/xmUsjEV2OMnlUi8RSbaQcKVCswpioGRlVeMXNcab+pSpR2UI2vNpyMIg==
X-Received: by 2002:a62:75d7:: with SMTP id q206mr1878565pfc.172.1590117647965; 
 Thu, 21 May 2020 20:20:47 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u4sm9825241pjf.3.2020.05.21.20.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:20:47 -0700 (PDT)
Subject: Re: [PATCH v1 12/15] cpus-common: ensure auto-assigned cpu_indexes
 don't clash
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200520140541.30256-1-alex.bennee@linaro.org>
 <20200520140541.30256-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3322a15d-c8bc-a5ee-2e81-3bfddac32781@linaro.org>
Date: Thu, 21 May 2020 20:20:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520140541.30256-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:05 AM, Alex Bennée wrote:
> Basing the cpu_index on the number of currently allocated vCPUs fails
> when vCPUs aren't removed in a LIFO manner. This is especially true
> when we are allocating a cpu_index for each guest thread in
> linux-user where there is no ordering constraint on their allocation
> and de-allocation.
> 
> [I've dropped the assert which is there to guard against out-of-order
> removal as this should probably be caught higher up the stack. Maybe
> we could just ifdef CONFIG_SOFTTMU it?]
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Nikolay Igotti <igotti@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> 
> ---
> v2
>   - slightly tweak the index algorithm to preserve cpu_index = 0
> ---
>  cpus-common.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


