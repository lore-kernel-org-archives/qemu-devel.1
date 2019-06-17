Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF098C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 21:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBA82080C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 21:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMbDFcaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBA82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51978 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcyoY-0004SC-Ne
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 17:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44123)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcylS-00030l-AS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 17:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcylN-0002Si-V6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 17:02:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcylK-0001hk-63
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 17:01:59 -0400
Received: by mail-pl1-x642.google.com with SMTP id a93so4661388pla.7
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6SiFxzEdZNXZd0J6flxbH/nulQ2r1TzUWUUPbTy2bvM=;
 b=iMbDFcaL8+6R+yJADObN7TVzPiLgoYYASTMbbvHxG6a4HQOanFDE1EVAOqQYTVmip5
 3f+56M7j/poEyHwoWd3YK+tjtdaA9LFfmSyTkARE3TQNzhrV8JSdxa4kIAxQqQttBEdW
 ayiRNxZre8bGEDiDiCjdzT3JuBcR6LO2wyFt1ZW9YQqrMAnbv0xqJrn8YA8h1iUYYq2b
 aqVOz7wl/tQPiPXUA3LrST7tJ5HME/iq9eCkc3B2BA8d4cV0cmm17wUUWMCmSMSR3Q1C
 Di1WcFqs4Xq5KvvYwZY1FSEljSJPAmekqhVWZpjbASe+zafliUw4z4hEfoJwoj3c2tzL
 QEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6SiFxzEdZNXZd0J6flxbH/nulQ2r1TzUWUUPbTy2bvM=;
 b=TmgKY6v3Sa10bJxAPfKdJIAdzPI/Hvh8h69Ql9o/KwQ9iDmnp7aXtlXNDuj4BSwJwD
 vS6Na4OZkA/DM9PdMnwyp9tO5DGxQYyr/46kOK3WduPmMzL66257D65894HGHT4b4d/V
 xiCht8gjnTSmw5XBLdfl4zOJ1rCJbd7crdoFLPiUMhYHKxFKX9rwfC4iMpiUl4gFgRVr
 dvFvm8iW3UsLJNp4C344ptf5rQ6ACyTYyBwV777Xu4crqbDS8rCYBrIQiK37lcpAiNNR
 +mr7aZKCDxAZbOmtBWDOnnxZ/0PcS3FYbmBIdHEyqcxFIF6WyzFESpgjC4ZcxM01phNE
 Za9A==
X-Gm-Message-State: APjAAAXn4hT4kn1urvJCAOWkxeVmtn1ku7MYLeNo/qvubm5sWe/T/+Bo
 UtlUdpeXJyNeJ77fy//EAGBsWw==
X-Google-Smtp-Source: APXvYqwlYBmO4AUjofKWvQ7F7eI6KYUnhu7/KN4TDxvDiojvt+ykPtdkxzAUq0NWiH0dQl9v5YPx/g==
X-Received: by 2002:a17:902:2aa8:: with SMTP id
 j37mr66859791plb.316.1560805253640; 
 Mon, 17 Jun 2019 14:00:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id n1sm11342416pgv.15.2019.06.17.14.00.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 14:00:53 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-24-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dac8247b-2148-6460-ce5f-aefb5b0d3bc7@linaro.org>
Date: Mon, 17 Jun 2019 14:00:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v3 23/50] cpu: hook plugin vcpu events
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
>  static void qemu_wait_io_event(CPUState *cpu)
>  {
> +    bool slept = false;
> +
>      while (cpu_thread_is_idle(cpu)) {
> +        if (!slept) {
> +            slept = true;
> +            qemu_plugin_vcpu_idle_cb(cpu);
> +        }
>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
>      }
> +    if (slept) {
> +        qemu_plugin_vcpu_resume_cb(cpu);
> +    }

Maybe better without the variable.

	if (cpu_thread_is_idle(cpu)) {
	    qemu_plugin_vcpu_idle_cb(cpu);
	    do {
	        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
	    } while (cpu_thread_is_idle(cpu);
	    qemu_plugin_vcpu_resume_cb(cpu);
	}

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

