Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A7DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F57422D00
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko20DkSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F57422D00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xke-0003KQ-LC
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3xk0-0002iS-DU; Fri, 07 Aug 2020 04:28:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3xjy-0003lE-O8; Fri, 07 Aug 2020 04:28:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id t14so1035384wmi.3;
 Fri, 07 Aug 2020 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lZxZpm0Rzy/KYdlLPypoCmX/hmaaJpYmZ0ULCWLsDMg=;
 b=Ko20DkSbfAFBvCe038x6K1le23xdXZrhmoY1Qz8YAfcaHKQFisK/LvVsdovdqi9kRe
 xP1CfCzkFtMV0uxpNLPsqtpjfw9jgXU3ttctORM6b6MqxiZR/mhzBsTcvZ0OYjG2KDcr
 qJ/v2hAr6X914Gi0a6HXDf9TqRrxXkcDqqXIHIlrTCo4qwNzOdfBwuIAShkw9AfzSY/j
 uyqJqu0Gdob+Zzq1T8BscfuM6doKrNgO+GM0GrAY44WLXoi0/t+dZpggXLBc09rgR5Gb
 IiioGazIVFFIaxon+wurbuBC5W2p5oePY8MpBmhVt/+rz5hVTUunLfJFYRO8i+4zSyo0
 O0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lZxZpm0Rzy/KYdlLPypoCmX/hmaaJpYmZ0ULCWLsDMg=;
 b=f3zgTfXv2w+gteGMqiOsqzop3u3I9A30zPAYe72rpxpqU03yIbnfJn8paTaexUqHfC
 X51R40wzcxsqhqO1SkKDSbcRvlhTV210xxcoC8CQAmXGRHtlBBjHsVkNoq2xUN+6jSgJ
 zzUmGQ43s89rKIdCriq3NYq8Z5c8PJQc10V1WrHuxnylphnTJO8D2PR07LZZXq+FmqA7
 oEIp3K4IzvMNtEJ+YrG2nYR+Ro6NhOdhneaT/mEbWy1gC1S+p652bP8nBOQzpmxJkEFz
 LvTHWt1uzJxBMev526FcmuLVWk/59gT31CMWmQgb8VMSNyBFJfBG1uFtDpCgA8t24nbv
 X3wA==
X-Gm-Message-State: AOAM532j+/I/6hYZXzokN60Dw0EP23WZm4Etu3RCXzcbidpoFwExv1MW
 RcczarnrR2CbEvLgO02TZ04=
X-Google-Smtp-Source: ABdhPJxY+VnYWB+FhwDvrSdDDNlirhKc/JKLRT2MCawwVo/ryoO16Y1qzM+KRTe1/Xhp84BijceNvA==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr11490687wmd.10.1596788916439; 
 Fri, 07 Aug 2020 01:28:36 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h13sm9623430wrx.17.2020.08.07.01.28.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 01:28:35 -0700 (PDT)
Subject: Re: [PATCH 3/7] target/arm/cpu: spe: Add an option to turn on/off
 vSPE support
To: Haibo Xu <haibo.xu@linaro.org>, peter.maydell@linaro.org
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <c4ab709b684bf6505a9721163564d2223d06c49d.1596768588.git.haibo.xu@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5fd62d43-0cdb-d69f-c11c-4a0122b28396@amsat.org>
Date: Fri, 7 Aug 2020 10:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c4ab709b684bf6505a9721163564d2223d06c49d.1596768588.git.haibo.xu@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: drjones@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Haibo,

On 8/7/20 10:10 AM, Haibo Xu wrote:
> Adds a spe=[on/off] option to enable/disable vSPE support in
> guest vCPU. Note this option is only available for "-cpu host"
> with KVM mode, and default value is on. 
> 
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  target/arm/cpu.c | 28 ++++++++++++++++++++++++++++
>  target/arm/cpu.h |  3 +++ 
>  2 files changed, 31 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 111579554f..40768b4d19 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1122,6 +1122,29 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>      cpu->has_pmu = value;
>  }
>  
> +static bool arm_get_spe(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    return cpu->has_spe;
> +}
> +
> +static void arm_set_spe(Object *obj, bool value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    if (value) {
> +        if (kvm_enabled() && !kvm_arm_spe_supported()) {
> +            error_setg(errp, "'spe' feature not supported by KVM on this host");
> +            return;
> +        }
> +        set_feature(&cpu->env, ARM_FEATURE_SPE);
> +    } else {
> +        unset_feature(&cpu->env, ARM_FEATURE_SPE);
> +    }
> +    cpu->has_spe = value;
> +}
> +
>  unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
>  {
>      /*
> @@ -1195,6 +1218,11 @@ void arm_cpu_post_init(Object *obj)
>          object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>      }
> 
> +    if (arm_feature(&cpu->env, ARM_FEATURE_SPE)) {
> +        cpu->has_spe = true;

Being a profiling feature, are you sure you want it to be ON by default?

I'd expect the opposite, either being turned on via command line at
startup or by a management layer at runtime, when someone is ready
to record the perf events and analyze them.

> +        object_property_add_bool(obj, "spe", arm_get_spe, arm_set_spe);
> +    }
> +
>      /*
>       * Allow user to turn off VFP and Neon support, but only for TCG --
>       * KVM does not currently allow us to lie to the guest about its
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9e8ed423ea..fe0ac14386 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -822,6 +822,8 @@ struct ARMCPU {
>      bool has_el3;
>      /* CPU has PMU (Performance Monitor Unit) */
>      bool has_pmu;
> +    /* CPU has SPE (Statistical Profiling Extension) */
> +    bool has_spe;
>      /* CPU has VFP */
>      bool has_vfp;
>      /* CPU has Neon */
> @@ -1959,6 +1961,7 @@ enum arm_features {
>      ARM_FEATURE_VBAR, /* has cp15 VBAR */
>      ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
>      ARM_FEATURE_M_MAIN, /* M profile Main Extension */
> +    ARM_FEATURE_SPE, /* has SPE support */
>  };
> 
>  static inline int arm_feature(CPUARMState *env, int feature)
> 


