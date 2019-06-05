Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F0C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028DE206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZ88OSUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028DE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXKS-0006RD-4E
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:55:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYXC3-00007a-Ba
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYXC1-0004X6-3s
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:47:11 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYXC0-0004NL-Lt
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:47:08 -0400
Received: by mail-oi1-x244.google.com with SMTP id w196so8865259oie.7
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=1mDLBue+5jFbyEYZW/m2z4fBoq3WNTvLx22keUu3zqI=;
	b=kZ88OSUNKcGNB/ejp9osrhGh5ZOReanCp+yI6k2a/6gBgs+BdY70xHHkrnArAH5xcD
	3JsymoNrf4ooi5lHo+iO/9f3paKbggE0Nois3JHTX1qIZe5abtUue526UEVukDJLnX8o
	1omJhqwALPHeyO7ObxROtgdAn0d4HAfL5O7Z9/vJbFrHAuVLBnwl/i4zGZuzaobywqvy
	VNB7wY0aYwKRfLl2WW7mKX/yq63gIHc/oVsbA3UGkzgx09OzAprFAZq4+TjwiyUt7ImE
	N/VuxOqDoVwKdqSkIt2vVrqEZ4uqkJof1ei6L2BtUjG3vICHzjj0yrWHQsti/Hz04SIN
	zPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1mDLBue+5jFbyEYZW/m2z4fBoq3WNTvLx22keUu3zqI=;
	b=uMUboa5kmFft12t5As6Mk3gWp8oXZB0HQO0RPmK1ubHrNOijlw9Kc5DTg3LrgrMCWW
	X3IcGr7wku5BKCpeWtC2Pzl0KsXPtK/Rf3PXw+0OKe3iZJGTHRjfqUyvaDGpubWHYM95
	7T3bdSlkkrefRSAq/0bVEI/PPZCjTOZTlp3WSW8R14EG4Tf51DNIioJbiIvJQvY+hC6+
	p0cGvXMyxr0XQK4FaJQBya1o4n2yLUxNynRVZXKhHotQTAKv86oMJyvuZHEchMW2UfP2
	WDOoUGYL+CxWo3PMhfwD+uOC4xCO+IAnCLmdoRLvvxJQYiI69mv1h2RPQ/lklIweCBHq
	WVnw==
X-Gm-Message-State: APjAAAXz6/S0l05KC27Wcx5hJJ27F0kjTOs+WZYjRQ+eA1VMfopcmvWI
	emC791ueXyxZCqJFGBNUPFLptg==
X-Google-Smtp-Source: APXvYqwml/hOLsTs1rxk/ikcrg4w5kxXXeceVHEAscuRByEX/KQMoEItjhRGBFWUQ7iRD1zERAQmRg==
X-Received: by 2002:aca:b7c3:: with SMTP id h186mr4733798oif.53.1559746027283; 
	Wed, 05 Jun 2019 07:47:07 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	t139sm7989495oie.21.2019.06.05.07.47.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 07:47:06 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
References: <20190603090635.10631-1-david@redhat.com>
	<20190603090635.10631-7-david@redhat.com>
	<ab465abb-4a36-8155-218e-450cfd8d5434@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cd106b8d-8a07-e41d-8918-db11919a44a0@linaro.org>
Date: Wed, 5 Jun 2019 09:47:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ab465abb-4a36-8155-218e-450cfd8d5434@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 06/22] s390x/tcg: Implement VECTOR FP
 COMPARE (EQUAL|HIGH|HIGH OR EQUAL)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/19 4:19 AM, David Hildenbrand wrote:
> On 03.06.19 11:06, David Hildenbrand wrote:
>> Provide for all three instructions all four combinations of cc bit and
>> s bit.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/helper.h           |  12 ++++
>>  target/s390x/insn-data.def      |   6 ++
>>  target/s390x/translate_vx.inc.c |  51 ++++++++++++++++
>>  target/s390x/vec_fpu_helper.c   | 104 ++++++++++++++++++++++++++++++++
>>  4 files changed, 173 insertions(+)
>>
>> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
>> index d34d6802a6..33d3bacf74 100644
>> --- a/target/s390x/helper.h
>> +++ b/target/s390x/helper.h
>> @@ -254,6 +254,18 @@ DEF_HELPER_FLAGS_5(gvec_vfa64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>>  DEF_HELPER_FLAGS_5(gvec_vfa64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>>  DEF_HELPER_4(gvec_wfc64, void, cptr, cptr, env, i32)
>>  DEF_HELPER_4(gvec_wfk64, void, cptr, cptr, env, i32)
>> +DEF_HELPER_FLAGS_5(gvec_vfce64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_FLAGS_5(gvec_vfce64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_5(gvec_vfce64_cc, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_5(gvec_vfce64s_cc, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_FLAGS_5(gvec_vfch64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_FLAGS_5(gvec_vfch64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_5(gvec_vfch64_cc, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_5(gvec_vfch64s_cc, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_FLAGS_5(gvec_vfche64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_FLAGS_5(gvec_vfche64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_5(gvec_vfche64_cc, void, ptr, cptr, cptr, env, i32)
>> +DEF_HELPER_5(gvec_vfche64s_cc, void, ptr, cptr, cptr, env, i32)
>>  
>>  #ifndef CONFIG_USER_ONLY
>>  DEF_HELPER_3(servc, i32, env, i64, i64)
>> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
>> index c45e101b10..446552f251 100644
>> --- a/target/s390x/insn-data.def
>> +++ b/target/s390x/insn-data.def
>> @@ -1212,6 +1212,12 @@
>>      F(0xe7cb, WFC,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
>>  /* VECTOR FP COMPARE AND SIGNAL SCALAR */
>>      F(0xe7ca, WFK,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
>> +/* VECTOR FP COMPARE EQUAL */
>> +    F(0xe7e8, VFCE,    VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
>> +/* VECTOR FP COMPARE HIGH */
>> +    F(0xe7eb, VFCH,    VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
>> +/* VECTOR FP COMPARE HIGH OR EQUAL */
>> +    F(0xe7ea, VFCHE,   VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
>>  
>>  #ifndef CONFIG_USER_ONLY
>>  /* COMPARE AND SWAP AND PURGE */
>> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
>> index 283e8aa07a..5571a71e1a 100644
>> --- a/target/s390x/translate_vx.inc.c
>> +++ b/target/s390x/translate_vx.inc.c
>> @@ -2588,3 +2588,54 @@ static DisasJumpType op_wfc(DisasContext *s, DisasOps *o)
>>      set_cc_static(s);
>>      return DISAS_NEXT;
>>  }
>> +
>> +static DisasJumpType op_vfc(DisasContext *s, DisasOps *o)
>> +{
>> +    const uint8_t fpf = get_field(s->fields, m4);
>> +    const uint8_t m5 = get_field(s->fields, m5);
>> +    const uint8_t m6 = get_field(s->fields, m6);
>> +    const bool se = extract32(m5, 3, 1);
>> +    const bool cs = extract32(m6, 0, 1);
>> +    gen_helper_gvec_3_ptr *fn;
>> +
>> +    if (fpf != FPF_LONG || extract32(m5, 0, 3) || extract32(m6, 1, 3)) {
>> +        gen_program_exception(s, PGM_SPECIFICATION);
>> +        return DISAS_NORETURN;
>> +    }
>> +
>> +    if (cs) {
>> +        switch (s->fields->op2) {
>> +        case 0xe8:
>> +            fn = se ? gen_helper_gvec_vfce64s_cc : gen_helper_gvec_vfce64_cc;
>> +            break;
>> +        case 0xeb:
>> +            fn = se ? gen_helper_gvec_vfch64s_cc : gen_helper_gvec_vfch64_cc;
>> +            break;
>> +        case 0xea:
>> +            fn = se ? gen_helper_gvec_vfche64s_cc : gen_helper_gvec_vfche64_cc;
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +    } else {
>> +        switch (s->fields->op2) {
>> +        case 0xe8:
>> +            fn = se ? gen_helper_gvec_vfce64s : gen_helper_gvec_vfce64;
>> +            break;
>> +        case 0xeb:
>> +            fn = se ? gen_helper_gvec_vfch64s : gen_helper_gvec_vfch64;
>> +            break;
>> +        case 0xea:
>> +            fn = se ? gen_helper_gvec_vfche64s : gen_helper_gvec_vfche64;
>> +            break;
>> +        default:
>> +            g_assert_not_reached();
>> +        }
>> +    }
>> +    gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
>> +                   get_field(s->fields, v3), cpu_env, 0, fn);
>> +    if (cs) {
>> +        set_cc_static(s);
>> +    }
>> +    return DISAS_NEXT;
>> +}
>> diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
>> index f9357d9221..e72500d4d5 100644
>> --- a/target/s390x/vec_fpu_helper.c
>> +++ b/target/s390x/vec_fpu_helper.c
>> @@ -149,3 +149,107 @@ void HELPER(gvec_wfk64)(const void *v1, const void *v2, CPUS390XState *env,
>>  {
>>      env->cc_op = wfc64(v1, v2, env, true, GETPC());
>>  }
>> +
>> +typedef int (*vfc64_fn)(float64 a, float64 b, float_status *status);
>> +static int vfc64(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
>> +                 CPUS390XState *env, bool s, vfc64_fn fn, uintptr_t retaddr)
>> +{
>> +    uint8_t vxc, vec_exc = 0;
>> +    S390Vector tmp = {};
>> +    int match = 0;
>> +    int i;
>> +
>> +    for (i = 0; i < 2; i++) {
>> +        const float64 a = s390_vec_read_element64(v2, i);
>> +        const float64 b = s390_vec_read_element64(v3, i);
>> +
>> +        /* swap the order of the parameters, so we can use existing functions */
>> +        if (fn(b, a, &env->fpu_status)) {
>> +            match++;
>> +            s390_vec_write_element64(&tmp, i, -1ull);
>> +        }
>> +        vxc = check_ieee_exc(env, i, false, &vec_exc);
>> +        if (s || vxc) {
>> +            break;
>> +        }
>> +    }
>> +
>> +    handle_ieee_exc(env, vxc, vec_exc, retaddr);
>> +    *v1 = tmp;
>> +    if (match) {
>> +        return s || match == 2 ? 0 : 1;
>> +    }
>> +    return 3;
>> +}
>> +
>> +void HELPER(gvec_vfce64)(void *v1, const void *v2, const void *v3,
>> +                         CPUS390XState *env, uint32_t desc)
>> +{
>> +    vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfce64s)(void *v1, const void *v2, const void *v3,
>> +                          CPUS390XState *env, uint32_t desc)
>> +{
>> +    vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfce64_cc)(void *v1, const void *v2, const void *v3,
>> +                            CPUS390XState *env, uint32_t desc)
>> +{
>> +    env->cc_op = vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfce64s_cc)(void *v1, const void *v2, const void *v3,
>> +                            CPUS390XState *env, uint32_t desc)
>> +{
>> +    env->cc_op = vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfch64)(void *v1, const void *v2, const void *v3,
>> +                         CPUS390XState *env, uint32_t desc)
>> +{
>> +    vfc64(v1, v2, v3, env, false, float64_lt_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfch64s)(void *v1, const void *v2, const void *v3,
>> +                          CPUS390XState *env, uint32_t desc)
>> +{
>> +    vfc64(v1, v2, v3, env, true, float64_lt_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfch64_cc)(void *v1, const void *v2, const void *v3,
>> +                            CPUS390XState *env, uint32_t desc)
>> +{
>> +    env->cc_op = vfc64(v1, v2, v3, env, false, float64_lt_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfch64s_cc)(void *v1, const void *v2, const void *v3,
>> +                             CPUS390XState *env, uint32_t desc)
>> +{
>> +    env->cc_op = vfc64(v1, v2, v3, env, true, float64_lt_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfche64)(void *v1, const void *v2, const void *v3,
>> +                          CPUS390XState *env, uint32_t desc)
>> +{
>> +    vfc64(v1, v2, v3, env, false, float64_le_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfche64s)(void *v1, const void *v2, const void *v3,
>> +                           CPUS390XState *env, uint32_t desc)
>> +{
>> +    vfc64(v1, v2, v3, env, true, float64_le_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfche64_cc)(void *v1, const void *v2, const void *v3,
>> +                             CPUS390XState *env, uint32_t desc)
>> +{
>> +    env->cc_op = vfc64(v1, v2, v3, env, false, float64_le_quiet, GETPC());
>> +}
>> +
>> +void HELPER(gvec_vfche64s_cc)(void *v1, const void *v2, const void *v3,
>> +                              CPUS390XState *env, uint32_t desc)
>> +{
>> +    env->cc_op = vfc64(v1, v2, v3, env, true, float64_le_quiet, GETPC());
>> +}
>>
> 
> Richard, still want to review this patch? I'm planning to send a pull
> request soon.
> 

Somehow I bypassed this one.  Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

