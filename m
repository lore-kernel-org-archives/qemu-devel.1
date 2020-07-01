Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35466C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041CA2071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUqdhIpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041CA2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqerE-0004TK-6s
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqeq3-0003kF-8S
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:39:55 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:41702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqeq1-0007zs-J4
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:39:54 -0400
Received: by mail-ej1-x641.google.com with SMTP id dp18so25289654ejc.8
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ew2B272mCRontQOnV9Q4wEWQCLVFOLX3beURS4doyos=;
 b=uUqdhIpQ4CpB3J2atGmewgAUUSfmKHMGTE5z4jyiiNZhX+eZTHL2R/PTsRsC2Vz5eQ
 1iCM1YF/wLAnhl/e0zfTTTzne95GTlvn5vC2FiuMLITrRNM+Bj8bUgcVqAKeAbo6dgW/
 cXMF/X0W7zdBjFv3j1VE24zSmg+kjMRq47peFhy3GVuu/wVSnUZf/MSYInfDGbnfugNO
 RTg9n96BBEKeYZ5U9ZOZRKJUkUmTw7lHG6lsIgW8eicBFY20pbHOsCoY9kV0cfZXJjm4
 z4W574e9xV6shd4VUuURiDVn7Bsacci30e/t9czT1Iz8+MYD4RqXvXE15Iq0hYtvLLIh
 QVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ew2B272mCRontQOnV9Q4wEWQCLVFOLX3beURS4doyos=;
 b=eH7G9Mpk1fLVPc/cyScrsmSUtDSKL7oJiB+/W66Ng6WK2sjIdld2KBnsRi3Nzzh9+h
 xqL7Kss72n25CAdNqXxaWCtGRN5Rdph2gp5xhrlyZkDKHDKsKQy1VHDtzd+CTzwK1Flq
 upPT0LbbhYeEFNf+iAUoRAcNcrj1kxXQ+55Izzs/y0O1pKzOYy7G6ueM+Bdm/5zF8yA5
 JqGrzfHltIaOw2vlNdw7imdjE5DjeDQM++WtPKUrxMvtRf4Ce50f41Zi+GjVNRFy75Bg
 j+NUF2X8YyIieg0mSNztO3Fa6EZL9uv1tNhnwP2wv/Wm4/9aQxzLkApHjwsFhFt2H9BT
 2NuA==
X-Gm-Message-State: AOAM532/cZCpgARhx2frGM8Kf6FO/H0b/JF3VwIlFKg9i8u6lURfJ1v7
 GN2LwI1USdRs3thoq4KeyjY=
X-Google-Smtp-Source: ABdhPJyfHmjjIm6NN3PuterRTV+dNMvciKyGFS9Prnk/8nHMLZdhG9MI6ZYlGZw2GtakUx7XWv8TBg==
X-Received: by 2002:a17:906:fcb7:: with SMTP id
 qw23mr22210987ejb.229.1593617992062; 
 Wed, 01 Jul 2020 08:39:52 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id s18sm5031304ejm.16.2020.07.01.08.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:39:51 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Adjust MIPS maintainership
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
 <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a1eb9cfc-4bff-dbb5-f17b-c088891c69b0@amsat.org>
Date: Wed, 1 Jul 2020 17:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhc@lemote.com>, aleksandar.rikalo@syrmia.com,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Huacai Chen and Jiaxun Yang, as you forgot to
include them.

On 6/30/20 6:46 PM, Aleksandar Markovic wrote:
> Paul Burton and Aurelien Jarno removed for not being present.
> 
> Huacai Chen and Jiaxun Yang step in as new energy.
> 
> CC: Paul Burton <paulburton@kernel.org>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  MAINTAINERS | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d8acf8d31..7fc16e21c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -213,7 +213,8 @@ F: disas/microblaze.c
>  
>  MIPS TCG CPUs
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aurelien Jarno <aurelien@aurel32.net>
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: target/mips/
> @@ -377,6 +378,7 @@ F: target/arm/kvm.c
>  
>  MIPS KVM CPUs
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  S: Odd Fixes
>  F: target/mips/kvm.c
>  
> @@ -1052,6 +1054,7 @@ MIPS Machines
>  -------------
>  Jazz
>  M: Hervé Poussineau <hpoussin@reactos.org>
> +M: Huacai Chen <chenhc@lemote.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: hw/mips/jazz.c
> @@ -1060,8 +1063,8 @@ F: hw/dma/rc4030.c
>  
>  Malta
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  M: Philippe Mathieu-Daudé <f4bug@amsat.org>
> -R: Aurelien Jarno <aurelien@aurel32.net>
>  S: Maintained
>  F: hw/isa/piix4.c
>  F: hw/acpi/piix4.c
> @@ -1073,6 +1076,7 @@ F: tests/acceptance/machine_mips_malta.py
>  
>  Mipssim
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Odd Fixes
>  F: hw/mips/mipssim.c
> @@ -1080,7 +1084,6 @@ F: hw/net/mipsnet.c
>  
>  R4000
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Obsolete
>  F: hw/mips/r4k.c
> @@ -1103,7 +1106,8 @@ S: Maintained
>  F: hw/intc/loongson_liointc.c
>  
>  Boston
> -M: Paul Burton <pburton@wavecomp.com>
> +M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> +M: Huacai Chen <chenhc@lemote.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: hw/core/loader-fit.c
> @@ -2677,7 +2681,8 @@ F: disas/i386.c
>  
>  MIPS TCG target
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aurelien Jarno <aurelien@aurel32.net>
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: tcg/mips/
> 


