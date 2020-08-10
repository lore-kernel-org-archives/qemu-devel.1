Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD4EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7236820709
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAK9uJ1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7236820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54pY-0004ql-LY
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k54oq-0004HQ-Jw; Mon, 10 Aug 2020 06:14:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k54oo-0007Rg-Jp; Mon, 10 Aug 2020 06:14:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id a5so7617704wrm.6;
 Mon, 10 Aug 2020 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Qn40NgrwtY/NctgQTv97W0/0psxFM0JAvwUBOi2Pf8k=;
 b=IAK9uJ1+LeyzGpgRLhorFGqZTQPfvtZpjiq2HzcTr4Sng6BztEf0Jpue1P3RjSp+Ji
 iCo2/ldKaPjmIyDVnN0HzSauvVrOpz7btDWTbS3DmslUn8D9+sII4CIuVf6apZNjIS5z
 3Fc2dxlqifayHYT1wSR98DOJCwaCTVwb61X3yis8bJJKZ/8UVyXSvu5Lrz6sx5LoxlPA
 k5ZArUOYlWz+KXXFfSsU8UHiZ2v/u7qokBIw0KCab56IqL4jGdahSiD1banEjXfI+oPl
 eIt5ovfmgxGB6w+DK+wPbtRo0OLV8Zw8nFpS/qIe4BbhO7xHgx3FlUzmLWhZbZRa7aky
 w8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qn40NgrwtY/NctgQTv97W0/0psxFM0JAvwUBOi2Pf8k=;
 b=c4Am/DP4R86IzVL/Lxa8I1HsmNX1wlhAqz+CId3jcrbt033a9yC+WTjbwYZgqLRh1S
 adW1WzzvGsbsbjvltu3urX52iIw/1l6TQJcR0hLHBJ+7HChzAJNqkkPQ57nIZ1zLT7qK
 UIXBCeYGMCHmQWz1y2Mcqaspq+/o7u61Hd8it35lFGNSi1QzIr7emDv3d+pbYrbhXYpj
 NBqWBxY738Z278+EGe5kQPxvO62X2DxAuKFkrQXiucAkXnoUrC1DI/qHtnxDFLrEZbZp
 bxsDlsJtImre47hW9JzTxuCaXTakI/ANTkPUl8X01xPVW3XeZU+Cuq4+xOqwthuLyBtg
 za4w==
X-Gm-Message-State: AOAM532e0WuBIC9TKOJgYDWL13W5UKKxhz9I0mQD1U/D+zQ10Fkov3Xh
 Jq/knwwmxzDn/4OCmbDfUPhEdJT+
X-Google-Smtp-Source: ABdhPJxVjN4LEoxbmjEzF/VO1t3Sh+7f/87U5E8UFHkUsHCPox6lfvpGrJpVLhDpge7GGHfziwaSxA==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr23777825wru.21.1597054451139; 
 Mon, 10 Aug 2020 03:14:11 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 31sm20561961wrp.87.2020.08.10.03.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 03:14:10 -0700 (PDT)
Subject: Re: [PATCH 3/7] target/arm/cpu: spe: Add an option to turn on/off
 vSPE support
To: Haibo Xu <haibo.xu@linaro.org>
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <c4ab709b684bf6505a9721163564d2223d06c49d.1596768588.git.haibo.xu@linaro.org>
 <5fd62d43-0cdb-d69f-c11c-4a0122b28396@amsat.org>
 <CAJc+Z1ECoqwzexiGABs4oBk_DdZcA3_r6u7fQP-ZnZnuKaK7Rw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b7f9ee4e-c9f5-8627-09cf-f21c9f7146e4@amsat.org>
Date: Mon, 10 Aug 2020 12:14:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJc+Z1ECoqwzexiGABs4oBk_DdZcA3_r6u7fQP-ZnZnuKaK7Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, drjones@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 5:03 AM, Haibo Xu wrote:
> On Fri, 7 Aug 2020 at 16:28, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Hi Haibo,
>>
>> On 8/7/20 10:10 AM, Haibo Xu wrote:
>>> Adds a spe=[on/off] option to enable/disable vSPE support in
>>> guest vCPU. Note this option is only available for "-cpu host"
>>> with KVM mode, and default value is on.

You are right, we don't know whether if the feature is announced
to the guest, the guest will use the SPE registers, so similarly
to PMU have it default ON if available.

>>>
>>> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>>> ---
>>>  target/arm/cpu.c | 28 ++++++++++++++++++++++++++++
>>>  target/arm/cpu.h |  3 +++
>>>  2 files changed, 31 insertions(+)
>>>
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 111579554f..40768b4d19 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -1122,6 +1122,29 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>>>      cpu->has_pmu = value;
>>>  }
>>>
>>> +static bool arm_get_spe(Object *obj, Error **errp)
>>> +{
>>> +    ARMCPU *cpu = ARM_CPU(obj);
>>> +
>>> +    return cpu->has_spe;
>>> +}
>>> +
>>> +static void arm_set_spe(Object *obj, bool value, Error **errp)
>>> +{
>>> +    ARMCPU *cpu = ARM_CPU(obj);
>>> +
>>> +    if (value) {
>>> +        if (kvm_enabled() && !kvm_arm_spe_supported()) {
>>> +            error_setg(errp, "'spe' feature not supported by KVM on this host");
>>> +            return;
>>> +        }
>>> +        set_feature(&cpu->env, ARM_FEATURE_SPE);
>>> +    } else {
>>> +        unset_feature(&cpu->env, ARM_FEATURE_SPE);
>>> +    }
>>> +    cpu->has_spe = value;
>>> +}
>>> +
>>>  unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
>>>  {
>>>      /*
>>> @@ -1195,6 +1218,11 @@ void arm_cpu_post_init(Object *obj)
>>>          object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>>>      }
>>>
>>> +    if (arm_feature(&cpu->env, ARM_FEATURE_SPE)) {
>>> +        cpu->has_spe = true;
>>
>> Being a profiling feature, are you sure you want it to be ON by default?
>>
>> I'd expect the opposite, either being turned on via command line at
>> startup or by a management layer at runtime, when someone is ready
>> to record the perf events and analyze them.
>>
> 
> I'm not sure whether it's proper to follow the 'pmu' setting here
> which has it on  by default.
> To be honest, I also prefer to turn it off by default(Please refer to
> the comments in the cover letter).
> 
>>> +        object_property_add_bool(obj, "spe", arm_get_spe, arm_set_spe);
>>> +    }
>>> +
>>>      /*
>>>       * Allow user to turn off VFP and Neon support, but only for TCG --
>>>       * KVM does not currently allow us to lie to the guest about its
>>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>>> index 9e8ed423ea..fe0ac14386 100644
>>> --- a/target/arm/cpu.h
>>> +++ b/target/arm/cpu.h
>>> @@ -822,6 +822,8 @@ struct ARMCPU {
>>>      bool has_el3;
>>>      /* CPU has PMU (Performance Monitor Unit) */
>>>      bool has_pmu;
>>> +    /* CPU has SPE (Statistical Profiling Extension) */
>>> +    bool has_spe;
>>>      /* CPU has VFP */
>>>      bool has_vfp;
>>>      /* CPU has Neon */
>>> @@ -1959,6 +1961,7 @@ enum arm_features {
>>>      ARM_FEATURE_VBAR, /* has cp15 VBAR */
>>>      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
>>>      ARM_FEATURE_M_MAIN, /* M profile Main Extension */
>>> +    ARM_FEATURE_SPE, /* has SPE support */
>>>  };
>>>
>>>  static inline int arm_feature(CPUARMState *env, int feature)
>>>
>>
> 

