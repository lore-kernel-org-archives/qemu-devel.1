Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CCAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166E82067B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6IWGOOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166E82067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiyX-0007zu-85
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 14:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiixe-0007SS-45
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:26:58 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiixc-0006Yi-30
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:26:57 -0400
Received: by mail-pl1-x641.google.com with SMTP id v24so8358348plo.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=r8Vu9Tm93Dmrk+zHQCQGIKrzaytIj2BW9FR72UMQBn8=;
 b=S6IWGOOwYAGIvWKNeeuabL7Gy9SsPXKCekqmH2xnUV7uGApfl4J+LwJ8Vnm+UltGnN
 J0I8sKatyJqYsgsNcNiHaIgJpLMz/R18jRgME0TGQOKSsJHf08bhOdqjGPToBHxTkD01
 S+8QPYg2fCHE6/kVvNnluBlnLGrUGB260Qnk6kf7jxegOuoXN5d1U4CSfNzV1QoM9qtM
 opZPCPy+ZovTcgyxG4AEkBFaD8/vih8hXAoNYt31n+Y3etshS6LlJk+o+6p9J66LeVEQ
 5ipV9ieM7aLuSS9c4myrLlsatLMQZ9Ms1W1Tts8OBJF9P0HLZzCYoYPsS87lmMMKtnvX
 7knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r8Vu9Tm93Dmrk+zHQCQGIKrzaytIj2BW9FR72UMQBn8=;
 b=Sz+p7yUQsaf/vIr++E8L9D1sg6FGd+vSwHO70RfKf3ZxhAmDnBh1MAGYk3YKX0IAZC
 0yCZxmhSFkvIdXb2xmkkvtRoiYbckT6+1LNkNcuGoX1VOYUgQjTGwuCpXGsRGDeSG3WC
 SwHRjizZqaPiKZQqkxRMuYlC1+kjX1RVaqA/c/XrJEblPo9KT4Bvrhfb+2xxRdfGf7Yu
 LgI0g9NzJbGjfdJQ0Nk/r/0Q8LtlAmB93EJY8vqlenLtoqG70G2XokjCE4t8i1SSsr8t
 klvZlYXClQtyJPr72SVviwRcVR1ioD9m2eQ/0FdSVAEd3tBsA8lZDbo9vxXytkRGKCib
 ffbw==
X-Gm-Message-State: AOAM533Az3jct1kaVEzuOZaoTQ2vOUpwo9ZWgOngmRG1+xtf32Sr8/nv
 Ylre2GoucanT2AbzfXNUkiwCgElqSEY=
X-Google-Smtp-Source: ABdhPJyHuTI56rTV2BVzCqhYXnW9BTANI+/maQ2MeI5kxvyA1b0I/xkaP283Hw0q7tVgRmoOxj77rg==
X-Received: by 2002:a17:902:7785:: with SMTP id
 o5mr4535291pll.288.1591727214107; 
 Tue, 09 Jun 2020 11:26:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o20sm3089465pjw.19.2020.06.09.11.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 11:26:53 -0700 (PDT)
Subject: Re: [PATCH 5/7] target/arm: Convert Neon 3-reg-diff long multiplies
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200609160209.29960-1-peter.maydell@linaro.org>
 <20200609160209.29960-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4491ecd5-43c1-4ee2-c7a7-7a337813a5f5@linaro.org>
Date: Tue, 9 Jun 2020 11:26:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609160209.29960-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/9/20 9:02 AM, Peter Maydell wrote:
> +static bool trans_VMULL_S_3d(DisasContext *s, arg_3diff *a)
> +{
> +    NeonGenTwoOpWidenFn *opfn[] = {

static const again, 4 instances.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

