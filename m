Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD80EC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF3F2344C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXMvlfKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF3F2344C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSrn-0001LV-72
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLSmp-0005xq-0v
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:03:55 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLSmk-00016s-4X
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:03:54 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mm21so1845250pjb.4
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jjVAaPXpTkvZsJp6L1araJImDWEUkF/D/tzUyuWhnaY=;
 b=QXMvlfKFfJVfRmVybjcvkwe9pLy/OdTe31WUPGUAbDEmgIlTylYEfcqMsbueDLTA89
 JaGXKJ2/p4wX54uAx40ogN9xUlZ50wFx8FDfD9UBM6ZTv2ZHmr7eR6/mk5VDPUwYvkit
 8MSVVfXN1ijQ1lDHOyp8BHB8uLaHlo94JrkreuA94ijuVSHCuX3qFw/ODPPewfxLXEtU
 Kc8AUbc8LicHv5uRKGb+NU28xwaB77HgqGHGUDSsVvi8Ml/tZitHEwtbG7afFOOwsTGk
 /AK0qmSwN73MBihcBzgQNUvN8pWm1VPRgvisNXQDfELEUke9llBc7ZmmQBDlANv0/YP0
 VMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jjVAaPXpTkvZsJp6L1araJImDWEUkF/D/tzUyuWhnaY=;
 b=OEry3U35mHzNyVFqsqdYQo6owZ85cK5SlQlXh126XNfENISIAXXh8MIKZ7e2A2S/+y
 YQGwZH8GJ5uhzzWZVVY4PO1VaUKmmX7uwFpbl++AUhvXRqzyzQ6quaj+ZAKZ96j6F+SI
 fXTPYy/mHeIIXxtEEccNzrdism7HriEX1WFRoVL60LiA25n41AP4obDf+DoDtfdYd6/G
 nZ6nOYxb5/lrzbRlixdau+9xrJ7je15V2mnynnjdV5+TXbVAzU19DC0A/VKiLirgyXXn
 NVZzezR8MEWo1JL/wTdqpgV5UhD62ogBp6o/u7jdaJKO6BpyfB2i5hAryKByaC7/krcV
 eFPw==
X-Gm-Message-State: AOAM533vqIVGnjGu9YuBN/YeVMrEF0jcsRALpVOZLdEt71FG1j5o9kSe
 2hOhJYl2oPOQfAkFuv2wNUZT0A==
X-Google-Smtp-Source: ABdhPJwg1xEVS1RqEzWd9Omhhm/uw4KbOEpdSZrcGvG6aO0BlztIZ1IaLmza3EmVG34hWafSu4+P4A==
X-Received: by 2002:a17:90b:1212:: with SMTP id
 gl18mr4305162pjb.138.1600959820413; 
 Thu, 24 Sep 2020 08:03:40 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x4sm3395940pfm.86.2020.09.24.08.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 08:03:39 -0700 (PDT)
Subject: Re: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
 <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
 <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <fca34122-160d-8c13-d237-a87a917f341b@linaro.org>
 <BYAPR02MB4886D48EDC604CEEF65FDAA7DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <1cf57f2b-a2c8-6fbc-2c1c-9945a5d77dd8@linaro.org>
 <BYAPR02MB4886F055CBD52DBEE5F269AEDE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <0241f731-61de-41bc-9f58-bc43725eef74@linaro.org>
 <BYAPR02MB4886B33025BE2B65D6F5F5A8DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <f0011ef6-014c-748b-7fc1-ea0f7878c281@linaro.org>
 <BYAPR02MB488667B684F8CEC755CBFD72DE2E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865179810F9248DE1280F8DE390@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e279b41a-a815-ec0e-46e2-2adf8f0b3398@linaro.org>
Date: Thu, 24 Sep 2020 08:03:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48865179810F9248DE1280F8DE390@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 7:56 PM, Taylor Simpson wrote:
> 
> 
>>> On 8/31/20 4:10 PM, Taylor Simpson wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>>> Sent: Monday, August 31, 2020 1:20 PM
>>>>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>>>>> Cc: philmd@redhat.com; laurent@vivier.eu; riku.voipio@iki.fi;
>>>>> aleksandar.m.mail@gmail.com; ale@rev.ng
>>>>> Subject: Re: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
>>>>> instructions with multiple definitions
>>>>>
>>> Ho hum.  Maybe I'm trying to overthink this too much before tackling the
>>> ultimate goal of full parsing of the SHORTCODE.
>>> Perhaps the only thing for the short term is to have the generator grep
>>> genptr.c for "#define fGEN", to choose between the two alternatives:
>> inline
>>> generation or out-of-line helper generation.
>>
>> That's certainly doable.  It will also be good to implement some of your other
>> ideas
>> - Have the generator expand the DECL/READ/WRITE/FREE macros will make
>> the generated code more readable and we can specialize them for
>> predicated vs non-predicated instructions which will make translation faster.
>> - Generate the entire generate_<tag> function instead of just the body will
>> make the generated code more readable.
> 
> I've made these changes to the generator.  I hope you like the results.  As an example, here is what we generate for the add instruction
> 
> DEF_TCG_FUNC(A2_add,
> static void generate_A2_add(
>                 CPUHexagonState *env,
>                 DisasContext *ctx,
>                 insn_t *insn,
>                 packet_t *pkt)
> {
>     TCGv RdV = tcg_temp_local_new();
>     const int RdN = insn->regno[0];
>     TCGv RsV = hex_gpr[insn->regno[1]];
>     TCGv RtV = hex_gpr[insn->regno[2]];
>     gen_helper_A2_add(RdV, cpu_env, RsV, RtV);
>     gen_log_reg_write(RdN, RdV);
>     ctx_log_reg_write(ctx, RdN);
>     tcg_temp_free(RdV);
> })

I would be happier if the entire function body were not in a macro.  Have you
tried to set a gdb breakpoint in one of these?  Once upon a time at least, this
would have resulted in all lines of the function becoming one "source line" in
the debug info.

I also think the full function prototype is unnecessary, and the replication of
"A2_add" undesirable.

I would prefer the function prototype itself to be macro-ized.

E.g.

DEF_TCG_FUNC(A2_add)
{
    TCGv RdV = tcg_temp_local_new();
    const int RdN = insn->regno[0];
    TCGv RsV = hex_gpr[insn->regno[1]];
    TCGv RtV = hex_gpr[insn->regno[2]];
    gen_helper_A2_add(RdV, cpu_env, RsV, RtV);
    gen_log_reg_write(RdN, RdV);
    ctx_log_reg_write(ctx, RdN);
    tcg_temp_free(RdV);
}

with

#define DEF_TCG_FUNC(TAG)                             \
    static void generate_##TAG(CPUHexagonState *env,  \
                               DisasContext *ctx,     \
                               insn_t *insn,          \
                               packet_t *pkt)

> And here is how the generated file gets used in genptr.c
> 
> #define DEF_TCG_FUNC(TAG, GENFN) \
>     GENFN
> #include "tcg_funcs_generated.h"
> #undef DEF_TCG_FUNC
> 
> /*
>  * Not all opcodes have generate_<tag> functions, so initialize
>  * the table from the tcg_funcs_generated.h file.
>  */
> const semantic_insn_t opcode_genptr[XX_LAST_OPCODE] = {
> #define DEF_TCG_FUNC(TAG, GENFN) \
>     [TAG] = generate_##TAG,
> #include "tcg_funcs_generated.h"
> #undef DEF_TCG_FUNC
> };

Obviously, the macro I propose above cannot be directly reused, as you do here.
 But I also think we should not try to do so.

You've got a script generating stuff.  It can just as easily generate two
different lists.  You're trying to do too much with the C preprocessor and too
little with python.

At some point in the v3 thread, I had suggested grepping for some macro in
order to indicate to the python script which tags are implemented manually.  My
definition above is easy to look for: exactly one thing on the line, easy regexp.

> I've also addressed several of the items from Richard's review, so I'll resubmit the series once I figure out how to get "make check-tcg" working under meson.

Yes, make check-tcg is currently broken, as are a few other check-foo.  I've
not yet had the courage to look into it, hoping that someone else will do it first.


r~

