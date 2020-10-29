Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5866CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FC6206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTP96zsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FC6206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYEDT-0004FI-Lc
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 16:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYECa-0003R9-Bf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:07:17 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYECX-0000l6-27
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:07:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id 15so3234539pgd.12
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BCCJ+4IBzkjbxhkGRfURO1JzDlGWjOZJlaVJiDTW8k0=;
 b=OTP96zsOS165IwgO9RSMWURoC0Zpt9CcqR73MUfXKcDgkP458XX4/VJptYi7vsTE6G
 y011SBi11AcTgRGQrqyTce8a5XxmWBEe+qxSp6GqupN88vOnonnc80gm1PcyeX+rexla
 2hzsJiNGwz7XcdPStOnX326vtJYS+jfOFFutBbfRAGHb57qgvgKOFJxguZZKweqi7U6j
 8PbrliA5vyym8QkvsN0x8n0ZInNV9wzQo9G3OfBqhjYFSPi/co2XB9pcZ7DL0jx/FiZ7
 oPAMgo82zO6ic1C0vTs4WLVk7x/oeVKQx8QW8OPOlmKlpK7V8kQlNuSli35l3JTd9L/k
 uuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BCCJ+4IBzkjbxhkGRfURO1JzDlGWjOZJlaVJiDTW8k0=;
 b=fV01A0sADE37TMS9BbUiVTmfNie66U9L3T3jsJqy+DPqOPkQqNWe+dRUFgmSWU8ZXS
 Zgu6D5HvNPtnFojeA+7qJtoVl89hXl0imuy9Z22bhbE3SEe2NcypfW+2eP4N6DN6J+Uj
 jZ7SlwfPNmEz4naTGcU5ZpDejJjr/gSzK8Gi32K+p4nAfnUAFfEFCE4vgfV9mcZO/k96
 jABqry2MDBGzKYG/Dc5lRl4ddjlRtgegiMSbO2d55jBGA76dRas6na/GgIL9mOPKAo8J
 jOIGHoHCHzHmiiOVNviZFFaPcHGF8OmYFz2aLGEfSVHAF/2vRBgog4f1jEG3drlWVmHh
 ny7w==
X-Gm-Message-State: AOAM530A5auDqLHDflMgVpc4fGbTElMzwww0YFQ+1W+iHGcIRNNyatmm
 4ZqiJBhhl1NAHacGqsFjy5Ju5g==
X-Google-Smtp-Source: ABdhPJzfvSs6D/0j7aJ/Qo6qiBBsT5TKcfUV2LoORlL3Xppbo6EHHGf3vUQ+2u762EENaQG1WuECaQ==
X-Received: by 2002:a17:90a:bc91:: with SMTP id
 x17mr1431578pjr.113.1604002030953; 
 Thu, 29 Oct 2020 13:07:10 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c12sm3507289pgi.14.2020.10.29.13.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 13:07:10 -0700 (PDT)
Subject: Re: [PATCH] tcg/optimize: Add fallthrough annotations
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
References: <20201029122833.195420-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <24b2a36c-d94d-e5f6-57c0-a9e6c4970b53@linaro.org>
Date: Thu, 29 Oct 2020 13:07:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029122833.195420-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.261,
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 5:28 AM, Thomas Huth wrote:
> To be able to compile this file with -Werror=implicit-fallthrough,
> we need to add some fallthrough annotations to the case statements
> that might fall through. Unfortunately, the typical "/* fallthrough */"
> comments do not work here as expected since some case labels are
> wrapped in macros and the compiler fails to match the comments in
> this case. But using __attribute__((fallthrough)) seems to work fine,
> so let's use that instead.

Why would the macro matter?  It expands to two case statements with nothing in
between them.

This sounds like a compiler bug that should be reported.


r~

