Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F59C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBF32078A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulu8FNge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBF32078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKIJ-0007Bv-GO
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtKHU-0006j4-G1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:19:16 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtKHS-0007HD-9l
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:19:16 -0400
Received: by mail-pf1-x441.google.com with SMTP id q17so204374pfu.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vy/D5ZNtk6N2Fkob7O70wtCtGnQWnhrPWVsJPv+dYgc=;
 b=ulu8FNge9z+oEwDA14qhHyFPRFfKJqmBnzaSxS8pQXBrGkyIY9tIcoXe+yyGzEsaH3
 0X4Iv/0ky8sq/AGlz7IczNs8S8qNvivGWizErpIsbvkrFsjGHse6WnanJR5ktFu0jhGK
 aIdMB1EAqxnewxWysE1wnsL0xCdA1cT4N1L1JDY/Vcga8Th/OodZYIwA6HmhOB2s8lJg
 9AfIi76rGiCITZeIqeKJ9sQT/0kIPfBLyWMX45QYCPzg4BgcYl5QjKPMwsmaJXyNCj/b
 9rraEBbkGSlhByvbgoIjnMVJc+pOtZ56jhIA+mFjQoWrkEp2qnKoSCw8etnLQg6r5VzA
 o74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vy/D5ZNtk6N2Fkob7O70wtCtGnQWnhrPWVsJPv+dYgc=;
 b=QbuerHqb7VweGczWSw68EZH5/42CPLgq+Gl8PI+UseHNMzcj/4dnBFL90RbpfIWHo8
 ibD6SBqF7yNtA/vJp62/XCItuKPiW1/lp35ABNW8vHlq9fpijlgx+GGJ/zVgIXVHB9+w
 rVBid3H2snXX6fweSG83ACMKPLRQEYve23xecrRXbjRDtw7q9tNr1bbFQtSFx19CRnU5
 MtszLSHaEtXKmcQy9yJ5QJmmbpuUvqK3XwxpyTFw4sB9N6cTSPfx8lrgRCEnVObJ603B
 5uPVBd2JEmxFrf2FOoPcGO5mHz1Se/C0mgODxVKAaIr/1+t4xOHB/kLZwxfOYS8woNYo
 qfog==
X-Gm-Message-State: AOAM530cYGXFkaCMuQAFOegZT+lIi6lFo1bH4cckHWyiENRyyVzfnP77
 L75C82PCkvuzgCidT3/ff7m5WJUyTEU=
X-Google-Smtp-Source: ABdhPJwA4+3adN2GqPFrIQjRKYj8S+AjqF7DIPmUOrapWa75BMPM61DVUJzxkjz4yTON9I1J5noitA==
X-Received: by 2002:a65:4786:: with SMTP id e6mr35877105pgs.258.1594253950985; 
 Wed, 08 Jul 2020 17:19:10 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id q7sm842259pfn.23.2020.07.08.17.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 17:19:10 -0700 (PDT)
Subject: Re: [PATCH 09/21] target/xtensa: add DFP option, registers and opcodes
To: Max Filippov <jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-10-jcmvbkbc@gmail.com>
 <4fc60414-4b04-2402-3e72-50e77a7854b6@linaro.org>
 <CAMo8BfKLbHrJBfz64vO9Mtyz6fWL8+ZekiOzvpdYVhg58_PxpQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <26e7179e-692c-9467-b2d2-c04c6f03b0db@linaro.org>
Date: Wed, 8 Jul 2020 17:19:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfKLbHrJBfz64vO9Mtyz6fWL8+ZekiOzvpdYVhg58_PxpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 10:37 AM, Max Filippov wrote:
> On Wed, Jul 8, 2020 at 9:25 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 7/6/20 4:47 PM, Max Filippov wrote:
>>> +float64 HELPER(add_d)(CPUXtensaState *env, float64 a, float64 b)
>>> +{
>>> +    set_use_first_nan(true, &env->fp_status);
>>> +    return float64_add(a, b, &env->fp_status);
>>> +}
>>> +
>>>  float32 HELPER(add_s)(CPUXtensaState *env, float32 a, float32 b)
>>>  {
>>> +    set_use_first_nan(env->config->use_first_nan, &env->fp_status);
>>>      return float32_add(a, b, &env->fp_status);
>>>  }
>>
>> I think you can do better than to set the use_first_nan flag before every
>> operation.
> 
> And it was better, until I found that the rules for float64 are a
> bit... peculiar.

Do I read that right,

> @@ -99,6 +103,7 @@
>      XCHAL_OPTION(XCHAL_HAVE_CP, XTENSA_OPTION_COPROCESSOR) | \
>      XCHAL_OPTION(XCHAL_HAVE_BOOLEANS, XTENSA_OPTION_BOOLEAN) | \
>      XCHAL_OPTION(XCHAL_HAVE_FP, XTENSA_OPTION_FP_COPROCESSOR) | \
> +    XCHAL_OPTION(XCHAL_HAVE_DFP, XTENSA_OPTION_DFP_COPROCESSOR) | \
>      XCHAL_OPTION(XCHAL_HAVE_RELEASE_SYNC, XTENSA_OPTION_MP_SYNCHRO) | \
>      XCHAL_OPTION(XCHAL_HAVE_S32C1I, XTENSA_OPTION_CONDITIONAL_STORE) | \
>      XCHAL_OPTION(((XCHAL_HAVE_S32C1I && XCHAL_HW_VERSION >= 230000) || \
> @@ -515,6 +520,7 @@
>      .ndepc = (XCHAL_XEA_VERSION >= 2), \
>      .inst_fetch_width = XCHAL_INST_FETCH_WIDTH, \
>      .max_insn_size = XCHAL_MAX_INSTRUCTION_SIZE, \
> +    .use_first_nan = !XCHAL_HAVE_DFP, \
>      EXCEPTIONS_SECTION, \
>      INTERRUPTS_SECTION, \
>      TLB_SECTION, \

means that if DFP is present, float64 has use_first_nan, but float32 does not?!?

What in the world is going on?

>> E.g. the translator could remember the previous setting within the TB, only
>> changing when necessary.  E.g. if env->config->use_first_nan, then set it
>> during reset and never change it again.  Similarly if DFP is not enabled.
> 
> This thought crossed my mind too, but then set_use_first_nan only
> sets one variable in the float_status and gets inlined.
> Is it worth the trouble?

You have a point that the operation I'm trying to avoid is trivial, and
probably not worth much.  But I had hoped that a given cpu would stick with one
method and not change it.


r~

