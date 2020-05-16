Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7701CC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 02:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6A020756
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 02:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="soGxyvtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6A020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZmDs-0002T4-Gc
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 22:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZmDE-0001wX-NB
 for qemu-devel@nongnu.org; Fri, 15 May 2020 22:06:04 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZmDC-0005A2-LB
 for qemu-devel@nongnu.org; Fri, 15 May 2020 22:06:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id x77so1887408pfc.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 19:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=K3/AiZCIlNmYCHQNHs9+FLhY/VlxpY2cSgseGGZqYdQ=;
 b=soGxyvtEvh0WXwjadjLnRwdW7P6/EtX2IAd7GcAV9Hf9u1KSoeoLmdzFCzAvYBsbRa
 rmgtKW1H3D81q0pDqDMb9ThDGEZrtN6vXHLogVILo19qBLrvvK1k0eALF0y2wXRlCkzO
 vLHTCItB3fhvlvx+Css7kCbSUlOeOeLezF0WPJOzvCf8tGSwcQTXCi8hAuto9nM7FRXP
 mxvmtzQVTS26yWGrYB2oZZaI+2simIne23hK9QpFHnr+l9XCtTtB2B73QRh4hY1IMtG9
 RE5a5Yl6/ITy0ddAr5CrODgfAr3OF8Pt+MDxhGZ4yY/KdpOM5qoC4nLIOMDvcY8O8OGD
 hkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K3/AiZCIlNmYCHQNHs9+FLhY/VlxpY2cSgseGGZqYdQ=;
 b=C6EndvoHpwtwqZ7vb/rRoAFeWy6Um/FSUo+pSZfXh3SMaFkU8VL6G2/aJMZchMCchO
 B9PbDjzwIEEruAdGvrOSXOrOZH4mvtbZK/I4fFblfAmxbI/tovHBr0a+STYmuOdN0BGM
 Iq8zorjmjlm7PlHll77Y3R5PgzDcJTgfM3AV3X7jhiFy5Esdz5sWHJJe/v27+HCmJ0oM
 V5yu0f6TjQlJ8QLpzhoLhWTR3Esxj4207GKLRTH/WOtd5KaqRcoeteyD7BkYKOa0qmbO
 tnuGTkp2GpGd4ZQu552+mAy88vSEPDmIYYU3fyz0PGictzLkK9Esl7cacld3KyxTcYR8
 23lw==
X-Gm-Message-State: AOAM532WwOrbMzkmpb4dnGJTDL+Ib83IgcWuq9ymaBJT6Eyp2dE5YaGE
 n8HZPCcuXldkDAqgAQgTGn+rb53RMUY=
X-Google-Smtp-Source: ABdhPJxCI47TtD0hPTBQIvG5EMnF9wL8KmeMtNo16Rg2KsMyJFhj1YjyPsxN6Y0Yai+VOjPZGeVXjQ==
X-Received: by 2002:a62:35c3:: with SMTP id c186mr6553417pfa.261.1589594761115; 
 Fri, 15 May 2020 19:06:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i7sm2448419pjj.33.2020.05.15.19.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 19:06:00 -0700 (PDT)
Subject: Re: [PATCH 07/10] target/arm: Convert Neon narrowing shifts with
 op==9 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200515142056.21346-1-peter.maydell@linaro.org>
 <20200515142056.21346-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a1f1a87b-7b31-cb70-6d2c-b68a864a2429@linaro.org>
Date: Fri, 15 May 2020 19:05:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142056.21346-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/15/20 7:20 AM, Peter Maydell wrote:
> Convert the remaining Neon narrowing shifts to decodetree:
>   * VQSHRN
>   * VQRSHRN
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  32 ++++++++++
>  target/arm/translate-neon.inc.c |  15 +++++
>  target/arm/translate.c          | 110 +-------------------------------
>  3 files changed, 49 insertions(+), 108 deletions(-)

Modulo &2reg_shift_nq,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


