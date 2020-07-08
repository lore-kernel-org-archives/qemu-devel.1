Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D515C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4531A2063A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3IvFx7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4531A2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDNh-0000qf-Fw
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtDMx-0000Ir-HT; Wed, 08 Jul 2020 12:56:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtDMv-0001bf-UU; Wed, 08 Jul 2020 12:56:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so3979022wmf.0;
 Wed, 08 Jul 2020 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EAXU/TTClvGdi/zI+hMr8WfP/Y7qjetMMediXvP5wR8=;
 b=O3IvFx7amBt/cXfoHJiG5BetCs3YWCQoGaoF71UeSdRiHHVIDHgCkH7fUvoA5F7t9d
 i+fSJvQbLFl+UK+UWOtxwuNF2JOF+bY9ICdvYT1pL6UvuECtAIcfnkA9D5MabRRmQS8P
 88tUO0e3czI32EUuARfan2FLtU5grpDJzLgC2BA10dPCqPNrFT+DOgBT6WUTejCjkKv2
 D1Aty418lVCCtKYnbDN5bxzCEmviD9qJgdikop8CPrtUkQwAWCZ2VmH4+x0/fJB9Fz94
 3br2bITpgj8aAoXoKVXDfMh0LwfY1nN1wNOs9S6S/bONQJjXmv4uUzIQmQtZazyyRpO1
 xWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EAXU/TTClvGdi/zI+hMr8WfP/Y7qjetMMediXvP5wR8=;
 b=B6LqLN5W2zAQNnwe4RSXa9FW8xmKb7X2GxStAi3U/7kCwhxP6Lv73XfUXjZmaV+ihq
 0Ilh0ahiTZtNKmgFHWHp73Ds01eHxg18ro2HalntfmwO2xFcF5xn5nG9MwCkO1icF9uP
 RVlrW62d7RiK0xihSV4dGAFylVsa2t8mjpu5XF+ofpuvFb+tp3+lUtmKlcqNgPN6eYsD
 jUJORqbzTpDq2b70RnWqdRSKgvJU7ZeVOMKG/BkIPWNAF7ZNlTx+01YMs124mqb45moO
 0O93Yzur40gm5VkHXpD8fcPY5jMlb1C2d+k5w6SGZdmoluMVc4m9aUZc+4/1wKuhuFYA
 sFBQ==
X-Gm-Message-State: AOAM531FB63WVOo+8zF6e26Vg99HvV2mE61TCe9Ce/etZwGjP8hpMLjE
 XsSnlqqaufXwSLn1fRHpN3du5LNB
X-Google-Smtp-Source: ABdhPJxhDOuloOWMoN3fy3KasBKogjfSw6tEYzBvcug5ZzAxOMVOIgg7dnq4J9m5AUTgGCRiEmMl9g==
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr10040563wme.186.1594227383825; 
 Wed, 08 Jul 2020 09:56:23 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y16sm774472wro.71.2020.07.08.09.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:56:23 -0700 (PDT)
Subject: Re: [PATCH v4 01/12] npcm7xx: Add config symbol
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-2-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9b824a33-13d4-445d-4986-0c5a135c4bb8@amsat.org>
Date: Wed, 8 Jul 2020 18:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200707184730.3047754-2-hskinnemoen@google.com>
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
> Add a config symbol for the NPCM7xx BMC SoC family that subsequent
> patches can use in Makefiles.
> 
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Acked-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  default-configs/arm-softmmu.mak | 1 +
>  hw/arm/Kconfig                  | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 8fc09a4a51..9a94ebd0be 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -27,6 +27,7 @@ CONFIG_GUMSTIX=y
>  CONFIG_SPITZ=y
>  CONFIG_TOSA=y
>  CONFIG_Z2=y
> +CONFIG_NPCM7XX=y

I'd squash this in patch 6: "Add two NPCM7xx-based machines"

>  CONFIG_COLLIE=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_NETDUINO2=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4a224a6351..a31d0d282f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -354,6 +354,14 @@ config XLNX_VERSAL
>      select VIRTIO_MMIO
>      select UNIMP
>  
> +config NPCM7XX
> +    bool
> +    select A9MPCORE
> +    select ARM_GIC
> +    select PL310  # cache controller
> +    select SERIAL
> +    select UNIMP

And this in patch 5: "Add NPCM730 and NPCM750 SoC models"

> +
>  config FSL_IMX25
>      bool
>      select IMX
> 


