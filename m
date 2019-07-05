Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE6C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19554218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19554218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjK7t-0006ut-2A
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 05:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjK5d-00069k-Fu
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjK5b-0001lB-TF
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:01:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjK5b-0001ge-Kk
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:01:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so7867098wrx.11
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 02:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4jymrkpCB6h9VW4LpjAhUSFnZgwb/0NgBb4Hwzi/Wko=;
 b=OHBKCwlTbW8aN2MxarNuPo9tw5NIAV6KU3dEieTHVt/MbYWTIpBhPez6Z7nS+Z+CbU
 Fph+EmeGfm95WGgvF+z2DMtP3Zlv7nui50vKqKXsP3W/8SubZ+/IqvNGWxw5Tsl5yMgQ
 0No89Us1nWOSFpgcmOYTF23UUBsXxBuwZbgUr4Lb8zljw9PCyd83apvfcpx4+N2f+ivr
 tByiT1p9hCblrWkIincyOj4Lk3bw+zme1HE4ZAMebzNma3Jrb+4LgjJY3JMNs0jYeEDK
 YSZa00qNCKlENQFQGWmaUzYOQ6/ok3LTF8ZdSa1y6W9Ga0a/lqf75YmzSQHGoXhSTtj4
 9f7A==
X-Gm-Message-State: APjAAAXbhPqh8xSWYHXiUTv08HNiUpElw4cuSDi4bZJT0PVWxKPJVo7b
 ZfqjlsZYoxn7+LuBriDfSz20+svN+wU=
X-Google-Smtp-Source: APXvYqxTSTgPz35Zj/qz1UCRS6jVVpkriGGbo8YVi8bSgEpWvQoRKXO+FEGQzZbSxsupgDjuJBYq8Q==
X-Received: by 2002:adf:f30e:: with SMTP id i14mr2959205wro.59.1562317255162; 
 Fri, 05 Jul 2019 02:00:55 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id v204sm9283831wma.20.2019.07.05.02.00.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 02:00:54 -0700 (PDT)
To: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
 <20190701163943.22313-42-peter.maydell@linaro.org>
 <CABoDooMcKUS0BuS1z2o_z+cRc0tK5SXyrns=4s8MaZQW7LDtKQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b080e911-18e6-ad06-1b03-0b25f37de672@redhat.com>
Date: Fri, 5 Jul 2019 11:00:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CABoDooMcKUS0BuS1z2o_z+cRc0tK5SXyrns=4s8MaZQW7LDtKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PULL 41/46] target/arm/vfp_helper: Extract
 vfp_set_fpscr_to_host()
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 9:24 AM, Laurent Desnogues wrote:
> Hello,
> 
> On Tue, Jul 2, 2019 at 4:18 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> The vfp_set_fpscr() helper contains code specific to the host
>> floating point implementation (here the SoftFloat library).
>> Extract this code to vfp_set_fpscr_to_host().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Message-id: 20190701132516.26392-16-philmd@redhat.com
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/vfp_helper.c | 127 +++++++++++++++++++++-------------------
>>  1 file changed, 66 insertions(+), 61 deletions(-)
>>
>> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
>> index d54e3253240..b19a395b67d 100644
>> --- a/target/arm/vfp_helper.c
>> +++ b/target/arm/vfp_helper.c
>> @@ -81,71 +81,11 @@ static inline int vfp_exceptbits_to_host(int target_bits)
>>      return host_bits;
>>  }
>>
>> -uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
>> -{
>> -    uint32_t i, fpscr;
>> -
>> -    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
>> -            | (env->vfp.vec_len << 16)
>> -            | (env->vfp.vec_stride << 20);
>> -
>> -    i = get_float_exception_flags(&env->vfp.fp_status);
>> -    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
>> -    /* FZ16 does not generate an input denormal exception.  */
>> -    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
>> -          & ~float_flag_input_denormal);
>> -    fpscr |= vfp_exceptbits_from_host(i);
>> -
>> -    i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
>> -    fpscr |= i ? FPCR_QC : 0;
>> -
>> -    return fpscr;
>> -}
>> -
>> -uint32_t vfp_get_fpscr(CPUARMState *env)
>> -{
>> -    return HELPER(vfp_get_fpscr)(env);
>> -}
>> -
>> -void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>> +static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
>>  {
>>      int i;
>>      uint32_t changed = env->vfp.xregs[ARM_VFP_FPSCR];
>>
>> -    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
>> -    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
>> -        val &= ~FPCR_FZ16;
>> -    }
>> -
>> -    if (arm_feature(env, ARM_FEATURE_M)) {
>> -        /*
>> -         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
>> -         * and also for the trapped-exception-handling bits IxE.
>> -         */
>> -        val &= 0xf7c0009f;
>> -    }
>> -
>> -    /*
>> -     * We don't implement trapped exception handling, so the
>> -     * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
>> -     *
>> -     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
>> -     * (which are stored in fp_status), and the other RES0 bits
>> -     * in between, then we clear all of the low 16 bits.
>> -     */
>> -    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
>> -    env->vfp.vec_len = (val >> 16) & 7;
>> -    env->vfp.vec_stride = (val >> 20) & 3;
>> -
>> -    /*
>> -     * The bit we set within fpscr_q is arbitrary; the register as a
>> -     * whole being zero/non-zero is what counts.
>> -     */
>> -    env->vfp.qc[0] = val & FPCR_QC;
>> -    env->vfp.qc[1] = 0;
>> -    env->vfp.qc[2] = 0;
>> -    env->vfp.qc[3] = 0;
>> -
>>      changed ^= val;
>>      if (changed & (3 << 22)) {
>>          i = (val >> 22) & 3;
>> @@ -193,6 +133,71 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>>      set_float_exception_flags(0, &env->vfp.standard_fp_status);
>>  }
>>
>> +uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
>> +{
>> +    uint32_t i, fpscr;
>> +
>> +    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
>> +            | (env->vfp.vec_len << 16)
>> +            | (env->vfp.vec_stride << 20);
>> +
>> +    i = get_float_exception_flags(&env->vfp.fp_status);
>> +    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
>> +    /* FZ16 does not generate an input denormal exception.  */
>> +    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
>> +          & ~float_flag_input_denormal);
>> +    fpscr |= vfp_exceptbits_from_host(i);
>> +
>> +    i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
>> +    fpscr |= i ? FPCR_QC : 0;
>> +
>> +    return fpscr;
>> +}
>> +
>> +uint32_t vfp_get_fpscr(CPUARMState *env)
>> +{
>> +    return HELPER(vfp_get_fpscr)(env);
>> +}
>> +
>> +void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>> +{
>> +    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
>> +    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
>> +        val &= ~FPCR_FZ16;
>> +    }
>> +
>> +    if (arm_feature(env, ARM_FEATURE_M)) {
>> +        /*
>> +         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
>> +         * and also for the trapped-exception-handling bits IxE.
>> +         */
>> +        val &= 0xf7c0009f;
>> +    }
>> +
>> +    /*
>> +     * We don't implement trapped exception handling, so the
>> +     * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
>> +     *
>> +     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
>> +     * (which are stored in fp_status), and the other RES0 bits
>> +     * in between, then we clear all of the low 16 bits.
>> +     */
>> +    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
>> +    env->vfp.vec_len = (val >> 16) & 7;
>> +    env->vfp.vec_stride = (val >> 20) & 3;
>> +
>> +    /*
>> +     * The bit we set within fpscr_q is arbitrary; the register as a
>> +     * whole being zero/non-zero is what counts.
>> +     */
>> +    env->vfp.qc[0] = val & FPCR_QC;
>> +    env->vfp.qc[1] = 0;
>> +    env->vfp.qc[2] = 0;
>> +    env->vfp.qc[3] = 0;
>> +
>> +    vfp_set_fpscr_to_host(env, val);
>> +}
>> +
>>  void vfp_set_fpscr(CPUARMState *env, uint32_t val)
>>  {
>>      HELPER(vfp_set_fpscr)(env, val);
> 
> This patch breaks flag settings because at the point where
> vfp_set_fpscr_to_host is called, the value in
> env->vfp.xregs[ARM_VFP_FPSCR] has already been changed.

Oops.

> A possible fix to that issue to is to save FPCR value when entering
> the helper and passing it to vfp_set_fpscr_to_host.

OK, thanks,

Phil.

