Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49117C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C075121D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+oNCl7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C075121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYsq-0004Na-Pn
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQYq9-0000us-At; Thu, 08 Oct 2020 12:32:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQYq5-0000bk-9h; Thu, 08 Oct 2020 12:32:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id w5so7311437wrp.8;
 Thu, 08 Oct 2020 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rhiI/j29m7rZdAWc0urXdi1B+rjXT8BWsxABfuYalto=;
 b=G+oNCl7oeyTQMy527vBTDs1gbA+0H9Xx4EL7Cu/n6/THUIGwHiov0S+u9Jbz9FsrqI
 8uf59xD4DUK6z/lQPpt9LZquAHjaDZCDV+TvkFqq9dr3sWOsfa2Pi5vP04hr0lIdiTs4
 UGiI+6+pbzQtA7drLmGGNsIQ3qhkmPYTY1hHHvX7zT/ejT+rsFvooHu+K5lBtXZKZz2A
 8lOjeck1HvAULJFzaMSwq9Peq0QBywsTGNMGu6m3rv1+UIjse0RalQ67Qk3G3DVp9N2g
 e7TVy3MRbGZgooRNyTPuW6pGaR+7ZSUvu9vDXBCFDlEQJzeuOi+69J5c6BJdeBRR5/8c
 wO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rhiI/j29m7rZdAWc0urXdi1B+rjXT8BWsxABfuYalto=;
 b=DNTB4Egu0x69b8+LSnNgDK2Ca89X+I3HqETxMC14ERTJxIUmQkocRsZeNM1cUUFYdu
 185/i3TLd7WwZjFDYIZI4MsSwQsgCOoapEtswtll0MoviPD8obiUtlH1M5wN6DqVh+s2
 xU72NalE2hUyODnuQz63nV1zeDV8+9ChHeWLTq756LOxbLUequ+I23NWeQZjS5lRweVd
 BLA5OV7Qrbo6pNC2J/Iswoc7URzT/GkaXWIeUvUqlRQzGHmtZzc16TL8aV+gRY26jv8N
 pGbg/K7/r7KV3WJ9GhnzQdZ60Fk8TUVy1gAekFWPj2SXznD/jaW08UnmJlVRPI3yyzDf
 s88g==
X-Gm-Message-State: AOAM532WBwEXcwhqzkwj1g3xsgRMgVn3SBKN6K3BPYgvI2L48s83/1X/
 5AVvlSO0d4spRSYnbXq3H79+DrBKo40=
X-Google-Smtp-Source: ABdhPJxyM+VTxhQOOXQfxRgXexBV1gkpBDZENAB2kBgH2l2Zw9XmpnwU4yTEdvtD88FK0DipciWc2Q==
X-Received: by 2002:a5d:46c5:: with SMTP id g5mr10627736wrs.416.1602174739469; 
 Thu, 08 Oct 2020 09:32:19 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z5sm7084841wrw.37.2020.10.08.09.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 09:32:18 -0700 (PDT)
Subject: Re: [PATCH 1/3] target/arm: Remove redundant mmu_idx lookup
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201008162155.161886-1-richard.henderson@linaro.org>
 <20201008162155.161886-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <975f0583-2cc3-ea8b-9303-ee4b37521c5f@amsat.org>
Date: Thu, 8 Oct 2020 18:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008162155.161886-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.214,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, vincenzo.frascino@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 6:21 PM, Richard Henderson wrote:
> We already have the full ARMMMUIdx as computed from the
> function parameter.
> 
> For the purpose of regime_has_2_ranges, we can ignore any
> difference between AccType_Normal and AccType_Unpriv, which
> would be the only difference between the passed mmu_idx
> and arm_mmu_idx_el.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/mte_helper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
> index 5615c6706c..734cc5ca67 100644
> --- a/target/arm/mte_helper.c
> +++ b/target/arm/mte_helper.c
> @@ -563,8 +563,7 @@ static void mte_check_fail(CPUARMState *env, uint32_t desc,
>  
>      case 2:
>          /* Tag check fail causes asynchronous flag set.  */
> -        mmu_idx = arm_mmu_idx_el(env, el);
> -        if (regime_has_2_ranges(mmu_idx)) {
> +        if (regime_has_2_ranges(arm_mmu_idx)) {
>              select = extract64(dirty_ptr, 55, 1);
>          } else {
>              select = 0;
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


