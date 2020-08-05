Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8341EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA6F233FB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIDfFLsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA6F233FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3M44-0002OT-Kd
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3M2z-0001hZ-FK
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:13:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:33931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3M2x-00005f-MQ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:13:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id u185so22982152pfu.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=1znVNOxtsb12P2bEtHCMxakeRtG7wQdoITwFpnpBvOU=;
 b=bIDfFLswQnXkTCzl4WxLkLYoNk01tjYmsgKg+hKWJ6CO71QWUSC3vR2g1B1/kbFwOt
 icUCMYfCyoy9IAj1fpnMOjAeuJZG/frO7F4AjCpBmsvi1ilNWkjp37rSWTkbe9c6aUhw
 kO2RsgU2JxFKGtz8X7UZSRwwZ+jzSfMYYwtpeHSr2O2oIX4zlpEhOj+FhzgwRiqaCw8Y
 8eEwUmGNY8DTMoE52laz7E5MHMk7lpfwa3zw1p/TA28/q7uOJ5EYwYUhkrGS/UFseHB8
 Zp4gSpVdwW4NGwDeJUNyx+pz/WiVeBbMCu77604imf+L4cXM1S031vi4oXo0ygy1bITm
 NP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1znVNOxtsb12P2bEtHCMxakeRtG7wQdoITwFpnpBvOU=;
 b=cJxYla/7I72UDHTQptAd0Ju2f98jXxUYGtt3fCbpWHj+sWeFQ+IWwKPmwou81nYhro
 zN4Z4nOrI/AK0+OHfW88rFDW0ERx0LPPPpNYyG/VeE5BJTqX+kTOtpIWLC8HcGaNodIz
 hmbu3HCFaFGNzAorn0ZJ1+OoZ3bpKpey4b1MJSXXREz8NNl/9DbbYu+1mZj171Uw/2H3
 QCMvr90GjslXPQt1UxtPgTgQxhvCldJFmdvRvkS+blHPEaQKbisc7x74qbB7LcImgf4L
 tzGD75jb8Ww7EfnB+nfc2EGc4TTyQn5NmvuMFOU4HTmZDQdPLOR0SZ4fGIuwCJP5IyJI
 TZYw==
X-Gm-Message-State: AOAM533821B9xKhtPc8MhggnEig6YboRwTC1Dfjm5CACj+Wx/t50/ZK2
 KsWQlEL8NlHqbARlSp2mP02XyQ==
X-Google-Smtp-Source: ABdhPJwMWQvGA3ylvmUl+k89rrnweJFTocqWJTZGd5iHAHj36IW95GURc+2plaKMBqxcUg1bcRvNxg==
X-Received: by 2002:aa7:943a:: with SMTP id y26mr4239817pfo.244.1596644021716; 
 Wed, 05 Aug 2020 09:13:41 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t2sm4324370pfb.123.2020.08.05.09.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 09:13:41 -0700 (PDT)
Subject: Re: v8.1M cpu emulation and target-arm feature-identification strategy
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAFEAcA_6zbOfdVi+Tp18seaEy4don1GurVya+E+QXRGrZ_WVLg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c5ed9d8-6d79-1b53-5588-8fb9efebf0fa@linaro.org>
Date: Wed, 5 Aug 2020 09:13:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6zbOfdVi+Tp18seaEy4don1GurVya+E+QXRGrZ_WVLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 4:08 AM, Peter Maydell wrote:
> Mostly recently we've been aiming for QEMU emulation code in
> target/arm to use ID register fields to determine whether a
> feature is present or not (the isar_feature_* functions) rather
> than the old style of defining ARM_FEATURE_* flags. This seems to
> be working out well for A-profile. However, for v8.1M there are
> a small handful of minor behaviour differences which don't have an
> associated ID register field, but which are instead in the spec
> and pseudocode just called out as "if this is a v8.1M CPU".
> (The major v8.1M new features do have ID register fields.)
> 
> I can think of two ways to handle this:
>  (1) define an ARM_FEATURE_V81M flag
>  (2) define an isar_feature_aa32_v81m() function which under the
>      hood is actually testing for a specific feature which happens
>      to be known to be always present in v8.1M, like low-overhead-branches
>      (ie ID_ISAR0.CmpBranch >=3)

I think (2) has the potential to be confusing in odd ways.  If there really is
no official flag for this, I think we should use (1).


r~

