Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85221C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF92A207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoLyVlKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF92A207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTQha-0000BC-Pr
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 10:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQg9-0007Zh-0y
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 10:25:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQg7-0008Rd-H2
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 10:25:56 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so3195957wme.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M7kX4oLiEcCvoIi+hZ3WOgF+kWhmwVHxtz/UNCErP5I=;
 b=CoLyVlKwMfKVY6zXSKUsmXfKBa7hVgl2+71I91/FmPXTTj/LrkA6dlGcMMw7JvwQ9X
 hVKs5F+IqLpMI2C+pHs1anNMNelQxaaPh4G5ga+f4Dw0eodslAlkS5RDMVjeOWMGZIXv
 eQkY0S1eKNg+NEFs210GUxgDc4y50jVWoVEPRoZzTDP4cNrRO7XzRsL0MprL8ssaVWuR
 0hZKq608ApMTkEBeqV25xuB23Fb+KDB/a0bVVWam1+NrkbHt/RzAXGN15lP5tkx0iQsk
 A9hAJZWuUrykGvmfgUeRXeLEUMdpipsMv+TCgV/bUluJD3FdjQum11ialJ30jBNXELFa
 aDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M7kX4oLiEcCvoIi+hZ3WOgF+kWhmwVHxtz/UNCErP5I=;
 b=fUcC5cYJwuoGN9tcN3xEGEAICxu4lT85q61DGaH3BOOCxQob1OeMl/kWT9rGodh7hy
 cKnzfu4+eX7IniGfPsx19JFUPk9/6Xx+xpNKJS+2vbX7aiXAVshahripxKkhP+BGBRlj
 zxgIa0UceKlhQBOopJW5/1/sbUrOfYmk/5z8e3mnZQ+s0kZhoEEYQ4v9UCoCp0rJjHSb
 EdjSiu5MJh3aooNljnTUZ0To8t6ZTZr0MoAvxSeCLVO8OvjDxiZko7bTos6+5sSKeyon
 HJbhA87ud2U6R7aY5FL6d+ipg67HbTI593hF/xa/zDvK7pIsSxYVmJIsfJfdGO7ADGR4
 h8XQ==
X-Gm-Message-State: AOAM532PHqbFPZbd3mNC9N+SdSQKQDIyTrVQkElNQA7KXT2G5N2ZGSg2
 E6e7L+cD6hjsBxRsy7nzWgo=
X-Google-Smtp-Source: ABdhPJxPZNWyKzDb8hTdNhjaesNyqXk6ifno4bkbikhLd0zYnbyQ4yEGKXwhcLAsWaT/+EuthMB6NQ==
X-Received: by 2002:a1c:dd0b:: with SMTP id u11mr4030680wmg.186.1602858354110; 
 Fri, 16 Oct 2020 07:25:54 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j13sm3725370wru.86.2020.10.16.07.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 07:25:53 -0700 (PDT)
Subject: Re: [PATCH V14 8/8] docs/system: Update MIPS machine documentation
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
 <1602831120-3377-9-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1a2686c7-0d6d-230a-8001-83413f99ded1@amsat.org>
Date: Fri, 16 Oct 2020 16:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602831120-3377-9-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:52 AM, Huacai Chen wrote:
> Add Loongson-3A CPU models and Loongson-3 based machine description.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   docs/system/cpu-models-mips.rst.inc | 10 ++++++++--
>   docs/system/target-mips.rst         | 10 ++++++++++
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/cpu-models-mips.rst.inc b/docs/system/cpu-models-mips.rst.inc
> index 499b5b6fed..02cc4bb884 100644
> --- a/docs/system/cpu-models-mips.rst.inc
> +++ b/docs/system/cpu-models-mips.rst.inc
> @@ -48,11 +48,17 @@ across all desired hosts.
>   ``I6400``
>       MIPS64 Processor (Release 6, 2014)
>   
> +``Loongson-2E``
> +    MIPS64 Processor (Loongson 2, 2006)
> +
>   ``Loongson-2F``
>       MIPS64 Processor (Loongson 2, 2008)
>   
> -``Loongson-2E``
> -    MIPS64 Processor (Loongson 2, 2006)
> +``Loongson-3A1000``
> +    MIPS64 Processor (Loongson 3, 2010)
> +
> +``Loongson-3A4000``
> +    MIPS64 Processor (Loongson 3, 2018)
>   
>   ``mips64dspr2``
>       MIPS64 Processor (Release 2, 2006)

I'm queuing the CPU models part for now.

> diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
> index cd2a931edf..138441bdec 100644
> --- a/docs/system/target-mips.rst
> +++ b/docs/system/target-mips.rst
> @@ -84,6 +84,16 @@ The Fuloong 2E emulation supports:
>   
>   -  RTL8139D as a network card chipset
>   
> +The Loongson-3 virtual platform emulation supports:
> +
> +-  Loongson 3A CPU
> +
> +-  LIOINTC as interrupt controller
> +
> +-  GPEX and virtio as peripheral devices
> +
> +-  Both KVM and TCG supported
> +
>   The mipssim pseudo board emulation provides an environment similar to
>   what the proprietary MIPS emulator uses for running Linux. It supports:
>   
> 

