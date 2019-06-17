Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F855C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9F120652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATucXdHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9F120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcya0-0004Nd-CY
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 16:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40594)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcyXW-00038F-Jy
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcyXS-0001IS-SD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:47:40 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcyXQ-0001H5-1T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:47:37 -0400
Received: by mail-pl1-x644.google.com with SMTP id m7so1041756pls.8
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=k4C9DAXCFx+UmryFVSHcBwmnqLk9ruBovsyhxgNwO4s=;
 b=ATucXdHXo58pLcS2pQ3NwAZeRKbtQ/+ENqQeJ1/vfbYQQelDthzLX95ScTu6h0NNMl
 Xnu8Mn5dU4dKT62wEaJ0h8nnIAVLvMOL45Ao8bYwTjxQHHbLd5d5pjfiGrQtFbnaVB1F
 VNd3OeHB/AOUFgWsn/nR90b+0S7Wq88dUVGpHBvx6H9Ko41cQM8J1bmroeK5+LLmfCUd
 68MK4aS4jLcpnVYn4+yThT0B9l/vXSN6yjj+8u2yE+kqcCXNfV/msMtUdKMuHavaxrgn
 uInuYRKstttbROIMWHsS1PjkzZeXs1iCjjQfLfumedicjVSEZLPOyjZu43miuyY1dAP0
 8tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k4C9DAXCFx+UmryFVSHcBwmnqLk9ruBovsyhxgNwO4s=;
 b=TIRb3KQAER2KtnrT9lXRgoTIdz97+zMIO21ChgSaYpZ3QftrGyYg7P2BXs+zaoiArk
 8KKOtsPuhL/4iRArzXxjxOzLxieYiBQE+uQDeoTRo2CiuV4j+GO4r8ObYgHDuYtV5iqC
 dIPfGyQNpEZUX1KVQEXfX+3dliqyzWLz5ZHL38V50xaPknjUHZ5mdz9AJB9c6Duuktb1
 Nq/mXUELhfF9zLCTADC8EP6SmyapyX1B4EvkKwOz3z3OnacIrbfQoJXb+P2+a5lXKKeF
 q2J9g0RbUKZ0a3Yl46+V3i7gUuztoX82gMmwHl/cXdAA+ufsCAbc7tUe9uiiKEPyGLBi
 GqMQ==
X-Gm-Message-State: APjAAAUnqbZMm4Ukrm9elSabzS3b/Erupgtw7Uzuc/kmDcDSpC7c0f/L
 AvG2Zrow7qdYP6Rrj2YzXaE3Lg==
X-Google-Smtp-Source: APXvYqzFRZtXT01NooFimGtWNzxJ2G2lrW/ItSo9jgsIFnDHKuZsB+TTCWYL01LxfF4BqC5HojgRLA==
X-Received: by 2002:a17:902:9a82:: with SMTP id
 w2mr91546723plp.291.1560804454595; 
 Mon, 17 Jun 2019 13:47:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id m13sm197154pjq.16.2019.06.17.13.47.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 13:47:33 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <46d93f42-76c4-a3fd-1662-b45c872e4d7b@linaro.org>
Date: Mon, 17 Jun 2019 13:47:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v3 17/50] atomic_template: add inline
 trace/plugin helpers
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
> +#ifndef ATOMIC_TEMPLATE_COMMON
> +#define ATOMIC_TEMPLATE_COMMON
> +static inline
> +void atomic_trace_rmw_pre(CPUArchState *env, target_ulong addr, uint8_t info)
> +{
> +    CPUState *cpu = env_cpu(env);
> +
> +    trace_guest_mem_before_exec(cpu, addr, info);
> +    trace_guest_mem_before_exec(cpu, addr, info | TRACE_MEM_ST);
> +}
> +
> +static inline void atomic_trace_rmw_post(CPUArchState *env, target_ulong addr,
> +                                         void *haddr, uint8_t info)
> +{
> +}
> +
> +static inline
> +void atomic_trace_ld_pre(CPUArchState *env, target_ulong addr, uint8_t info)
> +{
> +    trace_guest_mem_before_exec(env_cpu(env), addr, info);
> +}
> +
> +static inline void atomic_trace_ld_post(CPUArchState *env, target_ulong addr,
> +                                        void *haddr, uint8_t info)
> +{
> +}
> +
> +static inline
> +void atomic_trace_st_pre(CPUArchState *env, target_ulong addr, uint8_t info)
> +{
> +    trace_guest_mem_before_exec(env_cpu(env), addr, info);
> +}
> +
> +static inline void atomic_trace_st_post(CPUArchState *env, target_ulong addr,
> +                                        void *haddr, uint8_t info)
> +{
> +}
> +#endif /* ATOMIC_TEMPLATE_COMMON */
>  

All of this should just go into atomic_common.inc.c.


r~

