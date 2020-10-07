Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3144C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AF8207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYzUfdRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AF8207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6ep-0005hC-SX
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ6dY-0004pN-Lc; Wed, 07 Oct 2020 06:25:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ6dW-0006t2-IW; Wed, 07 Oct 2020 06:25:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id v12so1741213wmh.3;
 Wed, 07 Oct 2020 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=buIhwdKmuFX+16I5i8G60ot1/uj3CwJgYtHZlp1inHk=;
 b=QYzUfdRuOZ4nBBNmQ9HnjKtUDvisYrznHDS1stUQu/57cWo3/jIZEnyx2aH5zx/Awi
 K6hbyo6dFuQlK7EURQuTqrfpYy9wNOZBAdDNuioZrfItICVFI/Pf/gD2xHjjCzvJLz1t
 ecAtj7DNDoLl9qVSrwFM7aY2NdTjBZ2OioMVbxoTIgW44l3Yk/UxiPzvL+suiL0PKQB1
 Q6MeHAL3ZpvhMtTYDrJ+Tw4OXd53CQq/ABILecM9l/2mOqsj6vEasF+BgFLcgN7nXPnC
 kNbolmJDjpDp+1MRmsviwxr8TBnhvl31PXdGbyjSLS5YoY58semX9i7S07Hm3pbdXlQd
 Xggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=buIhwdKmuFX+16I5i8G60ot1/uj3CwJgYtHZlp1inHk=;
 b=QGoJuPo8hbT56NGHM5dK9R5gqOjRECQLHuaMSMMa4rfXIwTNtq41KItq937RKs9+G9
 vManZcEOik+7UsEpCSmcPIAwtjFbM6zajO+nJXZkhiPXi6Y0kaoZgektPip7uehB1gI2
 4oi8vTCtXWFDJ7r/EoNLEuG+FeTL/bt7KhYiAtGNoS/2hQitKJaYQhLiWlvDe0oSDYUV
 kaMEZG1iMROH1cCQoWh91fp1mw/koES9PF63RZCqSUqfMgCL3glmuQNzEhNdRohpl9f1
 npF5m/Kg6Aqpb3S56qKxz2fD1ZxELsrbggYnQukmGkaNHaoyDrQAZssKEgVlCIjyqmcZ
 og9g==
X-Gm-Message-State: AOAM530ZGBWMNDJ9DmddjAXG8Ob4Q1+Bgo+no9SCfOgsy55iN+vHX3mf
 mtrKW/QKpHL+kIqGHRv8yc4=
X-Google-Smtp-Source: ABdhPJzl3ZPWd8JnFs9i8BK5BLQXRaObQA5e6V4uD6Zd7eg7ZxkrDpNmhK16wkl0bQYn5b0BYfwMDQ==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr2566856wmj.79.1602066328222;
 Wed, 07 Oct 2020 03:25:28 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l3sm2044231wmh.27.2020.10.07.03.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 03:25:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] hw/arm/sbsa-ref : allocate IRQs for SMMUv3
To: Graeme Gregory <graeme@nuviainc.com>, qemu-arm@nongnu.org
References: <20201007100732.4103790-1-graeme@nuviainc.com>
 <20201007100732.4103790-3-graeme@nuviainc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <66ffdecb-12fb-8295-c09b-63eda4b60bc2@amsat.org>
Date: Wed, 7 Oct 2020 12:25:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007100732.4103790-3-graeme@nuviainc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org, leif@nuviainc.com, rad@semihalf.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 12:07 PM, Graeme Gregory wrote:
> Original commit did not allocate IRQs for the SMMUv3 in the irqmap
> effectively using irq 0->3 (shared with other devices). Assuming
> original intent was to allocate unique IRQs then add an allocation
> to the irqmap.
> 
> Fixes: e9fdf453240 ("hw/arm: Add arm SBSA reference machine, devices part")
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Previous version also has:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

> Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
> ---
>  hw/arm/sbsa-ref.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 65e64883b5..01863510d0 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -133,6 +133,7 @@ static const int sbsa_ref_irqmap[] = {
>      [SBSA_SECURE_UART_MM] = 9,
>      [SBSA_AHCI] = 10,
>      [SBSA_EHCI] = 11,
> +    [SBSA_SMMU] = 12, /* ... to 15 */
>  };
>  
>  static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> 

