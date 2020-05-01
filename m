Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A77C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BC720857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOQOPH0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BC720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXyb-0000Ig-35
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUXwa-0005iT-9e
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUXvq-00065a-V6
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:15 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUXvq-00064S-F7
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:50:30 -0400
Received: by mail-pl1-x641.google.com with SMTP id w3so3772782plz.5
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AThqTKuVg6PLJY6jc0hWagWCxDuONRhIR0VFAaLXWfo=;
 b=XOQOPH0ZqoldYyydnCix2XzzkN/7uaH0hotSak471Kji+ub7A05dcgb9sRymAt1EPI
 PqTR7YbfoUlZBqz1F4qCsEBNm3tPr1UXFri+kCOlKrc3RhxeEDtXPORGvVvt7wDzt8IK
 /oc1kNcSdx/+3GU5Fb3GpuOC9WMmhEl1hadlZgNXv/swpiU+c+0FdenuWwMrmJh2uG+o
 /oYu2/H5DB1SihID0G0v+OxTRm2kUwrJ99KWNXNsEKSn25m7CCLzvm6AIJkbM/AAC22o
 +IDdSOFmSIzD1KT6CmZVUldNDfTLi+rxgKfkg2jNWJvi1Zg9LxRXH7bLYcIg+zwCtz6E
 1aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AThqTKuVg6PLJY6jc0hWagWCxDuONRhIR0VFAaLXWfo=;
 b=iiuFImnmfwKBIEG+djbfVjBKNXX+Q0RSR5j5iGvMc7Yi3YgQGpRHWrH284ijzDFbfj
 4QIWn/+fhjedUvPFcEMdV4DtFJRQuufv+vNTnjiFYP2Pmb88oEw5v+onOrnkq4NC26Qg
 rLUcwAIlxy5Nwal9ANETORb586tzSlrRl16reXNtPOp42fmPIbt9q9f0iPTf+C0f/ozI
 /2HxbBFsa9a3WcPmCkXuyi7V2fAPuOP6wqXyq/hN0x1apiMTYai09ZtecYDYZzN4RHcq
 ZEMKZ1PA12U6TqXNPgbOwyfDxpfgMowCG/u4Jg6AkI538so9wpFLGP0xoM5XpzSZoNoK
 P5fg==
X-Gm-Message-State: AGi0PubSbx0kRTfTg8U7oA4P3c0NFQX2x8blaDhwdhjgpWzS9wS3ti9d
 xnVtZnwCjOz9Li9lVOwwKcGmsZgvDl0=
X-Google-Smtp-Source: APiQypIfSRX+7R8HumYeT+vLMFRUNcJSdwsar9qOl2UKptMzvxfj8nnh6jUQhZVej8yxKrkIY4b1XQ==
X-Received: by 2002:a17:90a:cc9:: with SMTP id 9mr283126pjt.16.1588348228499; 
 Fri, 01 May 2020 08:50:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 13sm2577420pfv.95.2020.05.01.08.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 08:50:27 -0700 (PDT)
Subject: Re: [PATCH 23/36] target/arm: Convert Neon 64-bit element 3-reg-same
 insns
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-24-peter.maydell@linaro.org>
 <366a2e79-d963-bfdc-fcc6-2a63026fa1db@linaro.org>
 <CAFEAcA8M6M7CYg0AsTVbmfX88jzW9MZvRFihQ9cGDJNHhXV+Pw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2050ff9f-1338-2b6e-230f-e07c72ece3e5@linaro.org>
Date: Fri, 1 May 2020 08:50:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8M6M7CYg0AsTVbmfX88jzW9MZvRFihQ9cGDJNHhXV+Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 8:36 AM, Peter Maydell wrote:
> On Thu, 30 Apr 2020 at 21:54, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> You can morph this into the gvec interface like so:
>>
>> #define DO_3SAME_64(INSN, FUNC) \
>>     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,
>>                                 uint32_t rn_ofs, uint32_t rm_ofs,
>>                                 uint32_t oprsz, uint32_t maxsz)
>>     {
>>         static const GVecGen3 op = { .fni8 = FUNC };
>>         tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
>>                        oprsz, maxsz, &op);
>>     }
>>     DO_3SAME(INSN, gen_##INSN##_3s)
>>
>> The .fni8 function tells gvec that we have a helper that processes the
>> operation in 8 byte chunks.  It will handle the pass loop for you.
>>
>> There's also a .fni4 member, for those neon helpers that operate on 4-byte
>> quantities, fwiw.
> 
> Is there a version of this that works on functions that need
> to be passed the cpu_env, or do I have to create a trampoline
> function that just calls the real helper function passing it
> the extra argument ?

A trampoline is required.

The original intention of the hook is to expand some inline tcg ops.  That it
can be used to call a helper is a happy accident.  For a helper that needs env,
ideally we would use tcg_gen_gvec_ptr and handle the vector with one call.


r~

