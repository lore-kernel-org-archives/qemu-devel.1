Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A63EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BB320747
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsJoh0YP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BB320747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwMA-0000GQ-JE
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1jqwLc-0008IH-Vi
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:21:41 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1jqwLb-0006DS-6o
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:21:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id q15so26139350wmj.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pn/iRItMkTY07UzX0WwMASPjN/nYYmjk0bA3lbQdYV0=;
 b=TsJoh0YPRydtwcFVZUTEQ7prBzZXAdXAsqj6P7MsmzE5t82L5+t08OSLGzu1ciPDix
 5h4+9SguipJQk/0SVXgnr7A3eoXGxYqWuaIeGsvlDU7Z17XzbqTLlHo0anxc56sd7bSI
 f/PI3sWyl6IEsy0J80HrSaTTYuBIjoyEosCllNRL4DtptCvK/RNYOJFIpOQYuFR+GNZR
 ZqGBuiumJldbGLIrFbWjuBlddVXf+0xrRLEObM+CLGw7C1pOyFWJW7/eiXEmflbr4zI8
 WKCMm6hJ1evc3msSLJVK5uWjzi+fFDFn8BECu2rPohV/GBUjdRI5pNZlFqhScbRKSI0Q
 wSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=pn/iRItMkTY07UzX0WwMASPjN/nYYmjk0bA3lbQdYV0=;
 b=coB7IEE/TPDrpDheAQPwjgQqXKIP1aNllMaFQYGHVRbxL0lAfh9++a4mFFTs6eBrL/
 SAXa4FLi7Q/1P22IBsRNL6LQybT2mzYEoV27+IJMEAp8OYx1hP3cBkgTuFr65MebSinz
 hVXvPRFvyX+0QdtyQ0NFZMAJNACkByR+DZTjDKJcLJd0TlItpEVSbgZvRFBJN8moUHSk
 07qIZm4p1XGgWawjtuJedAQYw7sHjF5vypNqsr/pWE3kaJTy47IjE9uUj+SCqxojaTZj
 6BCQ4ShQvh0eh/QTfyinedLpfC8i9rlPJ72z7E9ayFnwZ50M7yogtETl7V3alwL8mCRd
 gUqA==
X-Gm-Message-State: AOAM532sbzS4QsuKtdGaYN81ahmKwwqakrEZvaRHf7BZ5HLDtKir+bT2
 aLTQSobYabP33owzFmXlFlA=
X-Google-Smtp-Source: ABdhPJwAcWsas+Lk3qL2Zqcc7IZr2Zdfk1ORK9S4Sg2IA14WW4JP5J8YUyxHH7+j9k4E/WW4lmov4g==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr32475586wmj.39.1593685297277; 
 Thu, 02 Jul 2020 03:21:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.googlemail.com with ESMTPSA id r3sm10562154wmh.36.2020.07.02.03.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 03:21:36 -0700 (PDT)
Subject: Re: [PATCH] cpus: Move CPU code from exec.c to cpus.c
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200701175432.18892-1-philmd@redhat.com>
 <b476ded8-fbd6-f9d5-66b7-67e7128e86fd@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <34ef8d81-4559-9887-3420-c0045bb83d46@redhat.com>
Date: Thu, 2 Jul 2020 12:21:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b476ded8-fbd6-f9d5-66b7-67e7128e86fd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/20 11:38, Paolo Bonzini wrote:
> On 01/07/20 19:54, Philippe Mathieu-Daudé wrote:
>> This code was introduced with SMP support in commit 6a00d60127,
>> later commit 296af7c952 moved CPU parts to cpus.c but forgot this
>> code. Move now and simplify ifdef'ry.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  cpus.c | 18 ++++++++++++++++++
>>  exec.c | 22 ----------------------
>>  2 files changed, 18 insertions(+), 22 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 41d1c5099f..472686cbbc 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -92,6 +92,11 @@ static unsigned int throttle_percentage;
>>  #define CPU_THROTTLE_PCT_MAX 99
>>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>>  
>> +CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
>> +
>> +/* current CPU in the current thread. It is only valid inside cpu_exec() */
>> +__thread CPUState *current_cpu;
>> +
>>  bool cpu_is_stopped(CPUState *cpu)
>>  {
>>      return cpu->stopped || !runstate_is_running();
>> @@ -134,6 +139,19 @@ static bool all_cpu_threads_idle(void)
>>      return true;
>>  }
>>  
>> +CPUState *qemu_get_cpu(int index)
>> +{
>> +    CPUState *cpu;
>> +
>> +    CPU_FOREACH(cpu) {
>> +        if (cpu->cpu_index == index) {
>> +            return cpu;
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>>  /***********************************************************/
>>  /* guest cycle counter */
>>  
>> diff --git a/exec.c b/exec.c
>> index 21926dc9c7..997b7db15f 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -98,12 +98,6 @@ AddressSpace address_space_memory;
>>  static MemoryRegion io_mem_unassigned;
>>  #endif
>>  
>> -CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
>> -
>> -/* current CPU in the current thread. It is only valid inside
>> -   cpu_exec() */
>> -__thread CPUState *current_cpu;
>> -
>>  uintptr_t qemu_host_page_size;
>>  intptr_t qemu_host_page_mask;
>>  
>> @@ -832,22 +826,6 @@ const VMStateDescription vmstate_cpu_common = {
>>      }
>>  };
>>  
>> -#endif
>> -
>> -CPUState *qemu_get_cpu(int index)
>> -{
>> -    CPUState *cpu;
>> -
>> -    CPU_FOREACH(cpu) {
>> -        if (cpu->cpu_index == index) {
>> -            return cpu;
>> -        }
>> -    }
>> -
>> -    return NULL;
>> -}
>> -
>> -#if !defined(CONFIG_USER_ONLY)
>>  void cpu_address_space_init(CPUState *cpu, int asidx,
>>                              const char *prefix, MemoryRegion *mr)
>>  {
>>
> 
> Queued, thanks.
> 
> Paolo
> 
> 

Wait... this is in exec.c because cpus.c is not linked into user-mode
emulators.

Paolo

