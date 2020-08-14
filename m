Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0237EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 19:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7EE205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 19:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwaj9NIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7EE205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6fBd-00009v-WB
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 15:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6fAu-0007mM-3S
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 15:15:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6fAs-0003Zv-EE
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 15:15:35 -0400
Received: by mail-pf1-x443.google.com with SMTP id 74so4994251pfx.13
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VPevZZZSNzJI3RXDIboWLUgP7dDJqhDDw2za3RM3Et0=;
 b=wwaj9NImhBeBZyp3CKoz6Fznw3zHjiwjna7r8hPQuVA6RMhRMChDQ50dTqXUoj/Dj6
 Kz5uRgAURVi/1Li3lTfy98tIyTqitKeXTuA7627HqQgccPh/p5AjUjiU5XwS7TCuJx/J
 vsawYCexBkeZJN7ET1Pj1SIE8jnu7M6s+hI+PwFXnyav6QZEDYsa9cG4TFI0mLtTYMUX
 3HPDn7YYkPnvKLCJRM+i55URRy4lLbe3G9rvYUaGlQc+3YENDnYIl6DBiksZn2me/aYS
 hWm48uga5o+h7JFCfz2yRAoMJZ4aG8qbh4Zjm18VWRXeCftIzvRcoZVIzGqSWLBzkIT5
 fMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VPevZZZSNzJI3RXDIboWLUgP7dDJqhDDw2za3RM3Et0=;
 b=MC6ZxcVnlMV6XH9d6iVL3681afw6v7+uwJCk9d1LGt1gFhsMXahKvi0KpnUrr2ad43
 MZgIhdSQRpCVq/66hfQe3JCN9k7n1HC63z9hadWtdd02IVSqvmY3xTq49kZsatUqeH6a
 mSS2NT6gAizbYIsOoljksjkLVJaeoT/mRbIcHvAGuQFDUuheIJGYeLOnBW5fX8lsKzJL
 KsOcDDSP6VIBg9mCG2OaISLCbCQuT8SDQ2i/XJcV/z3P4AtPjBMfOuoaLz5KbxkBtMbW
 NsXhVpZYMvgg+KM/TrG1WeYd2kgtCY79wbPoBS0vv/vv6aRjb8B/dolcSaB6twwVpzIa
 qaqw==
X-Gm-Message-State: AOAM531eH+43NO/JyYfG3KfGksP5xcFTcd2zBfIqHf5zzmmXeqfQERXv
 TLTLBC86XI7Px2YJfWOJ9Qub3XdExaSdJQ==
X-Google-Smtp-Source: ABdhPJwH02TPJoyKMUBXPXIlpAAF+Hv+OxKK37favLAVCOlRlWx3l4KN3hzngbVGhyE3KDdJMcrR2g==
X-Received: by 2002:a05:6a00:1344:: with SMTP id
 k4mr2710398pfu.131.1597432532122; 
 Fri, 14 Aug 2020 12:15:32 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k125sm9198339pga.48.2020.08.14.12.15.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 12:15:31 -0700 (PDT)
Subject: Re: [PATCH 3/7] target/arm/cpu: spe: Add an option to turn on/off
 vSPE support
To: Haibo Xu <haibo.xu@linaro.org>, peter.maydell@linaro.org
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <c4ab709b684bf6505a9721163564d2223d06c49d.1596768588.git.haibo.xu@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9fc812e2-a401-0f5d-b96a-0cce9c405aca@linaro.org>
Date: Fri, 14 Aug 2020 12:15:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c4ab709b684bf6505a9721163564d2223d06c49d.1596768588.git.haibo.xu@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: drjones@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 1:10 AM, Haibo Xu wrote:
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

I think you want to simply set cpu->has_spe here, and leave the adjustment of
ID_AA64DFR0 to a finalize routine.  Because there are multiple values that
PMSVer can take.

Once the get/set routines are only setting a flag on ARMCPU, you can use a
simpler property interface:

static Property arm_cpu_spe_property =
    DEFINE_PROP_BOOL("spe", ARMCPU, has_spe, true);

qdev_property_add_static(DEVICE(obj), &arm_cpu_spe_property);

The finalize routine would be called from arm_cpu_finalize_features(), much
like the existing arm_cpu_sve_finalize().

Since you're only registering the spe property when the selected cpu supports
spe, the finalize routine only needs to set PMSVer to 0 to turn it off,
preserving the initial enabled value of 1 or 2.


r~

