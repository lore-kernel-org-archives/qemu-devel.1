Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38A2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6D2206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Yt7qOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6D2206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xf2-0000VF-QQ
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3xbb-0004OQ-RT; Fri, 07 Aug 2020 04:19:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3xba-0002eq-9q; Fri, 07 Aug 2020 04:19:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id d190so956356wmd.4;
 Fri, 07 Aug 2020 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=261yakEzIsjQYGiJSqJdvqKWXSx+Gt1B3PJAmEaQsJA=;
 b=X7Yt7qOLFoi+2E8OVpsiLF2U5GZyQht1+zoFnULv2OkQ+i6AazYjNP7ZiiFQcxcKNL
 qTJbPyjHfvLlsEJm6lEFgf6f/ySnqpPrUw9/5C2rc0GtTwFyP0zGmuhKfZxL4G+aiJ6F
 yawXy14DBa6ufFCdjrdcVSg6jZgFPaLK6BBovSHhX5gKcworQTQdw+V63S15r2UfniU7
 78V2297UeNcDq0eyPwAgyoY+6+ZUZJDjR1V/BlTnOx8JtC9lQ7GiBayvQskYsL/xerkE
 ERwgjZo9GuwAcUX9AqpJFu91jivGuAreTNGxMtlUvWv6kkCtQsJNk6QGw/MzppFQHS6S
 vvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=261yakEzIsjQYGiJSqJdvqKWXSx+Gt1B3PJAmEaQsJA=;
 b=chBA7ocHx3oH79ebHGIgQin5G7Og07DuBcJXaqQ3v5ahqNOezMuaS6ODnSGAVW92Ax
 MT4mXaRV+35HNfcK04MrMimLD9YkSDGdsO5jn1TLl8AYjerPYlcNQA4yfGrqXe9cwdUV
 E8QFqJdL57CxZI8zxUuCrPaus615mrso6uPqizd9rE2rXfjOgM+QI+WByCKz6YMIjE43
 tZG8Al5RSpGBVwblsoRzRB11yzdexQXuDzhf6F45OKO3Iv7KqFgDvIOJm3G/gTUPkgpA
 rOMTcKG6zhUOx9yWFs9ty+Fj4SJO/PGunlNTSF5fgPK+0EQXA+T2DclEyjOrAMYZX/+5
 IuPA==
X-Gm-Message-State: AOAM531gh6cSMYB+lGEVNjeftFzrOsb15BW2f6FSDHT+FzsN1T087Hao
 aORlbPBbV0apv9+LvoRoaD8=
X-Google-Smtp-Source: ABdhPJycyXPYnBy7SwSKaXBM1XW3qu75L7vTRFZXzRTsYVkFCivsICJeqIo8sYelAqa9hjgRrV7ZvA==
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr11441089wmg.69.1596788395435; 
 Fri, 07 Aug 2020 01:19:55 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b139sm9952910wmd.19.2020.08.07.01.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 01:19:54 -0700 (PDT)
Subject: Re: [PATCH 4/7] target/arm/kvm: spe: Unify device attr operatioin
 helper
To: Haibo Xu <haibo.xu@linaro.org>, peter.maydell@linaro.org
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <3cc31df5191ae6b03e060ccd8e82df74416a3ef5.1596768588.git.haibo.xu@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b4790af9-38b7-f74a-4ebc-a7e9d3684ae0@amsat.org>
Date: Fri, 7 Aug 2020 10:19:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3cc31df5191ae6b03e060ccd8e82df74416a3ef5.1596768588.git.haibo.xu@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

On 8/7/20 10:10 AM, Haibo Xu wrote:
> Rename kvm_arm_pmu_set_attr() to kvm_arm_dev_set_attr(),

Maybe rename kvm_arm_device_set_attr() to match the structure
name?

> So both the vPMU and vSPE device can share the same API.
> 
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>

Regardless, with the typo "operation" in patch subject fixed:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/kvm64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 1169237905..75a417d65c 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -398,7 +398,7 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
>      return NULL;
>  }
>  
> -static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
> +static bool kvm_arm_dev_set_attr(CPUState *cs, struct kvm_device_attr *attr)
>  {
>      int err;
>  
> @@ -427,7 +427,7 @@ void kvm_arm_pmu_init(CPUState *cs)
>      if (!ARM_CPU(cs)->has_pmu) {
>          return;
>      }
> -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> +    if (!kvm_arm_dev_set_attr(cs, &attr)) {
>          error_report("failed to init PMU");
>          abort();
>      }
> @@ -444,7 +444,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
>      if (!ARM_CPU(cs)->has_pmu) {
>          return;
>      }
> -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> +    if (!kvm_arm_dev_set_attr(cs, &attr)) {
>          error_report("failed to set irq for PMU");
>          abort();
>      }
> 


