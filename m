Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A808C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445592068F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR7uT1yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445592068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJwu-0001kM-Dg
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 13:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJvF-0000L7-1p
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:19:53 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJvD-0004VD-Ep
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:19:52 -0400
Received: by mail-ej1-x642.google.com with SMTP id y10so21468049eje.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4Y6voXNNTmbwARO0HNg5rXU1hQc8njWyDa9GiF3dMtY=;
 b=eR7uT1yYl0KTizyVBkN3xKF3CMQISJme11zvqpfPupNZBcNoiEcF6TyqOk1tAN7q35
 vxR0rvGUbW35Dk5WxSi5OphqMlAlupZUnpQw8SHYvFNGe3+Nrdg1LO2TrfSv4UDpY++Y
 4h42KVAk/jzooufE2ruK56ERltbgZfEihsT+bPeR03ghMi3H8lmPJ08smx5cTbh9/7vs
 JcOGZM6SGKC+Vq1YWfjrtbhDIQVftEKPPj2KuBSva9JthcXT9fiJZ5/gRfl4cshD5Ddd
 Ezlb1b4GjQK5ZNy5u/jtIog3rTd32yKbyt1dKdywkrX7UrArU2VvGaAfmka/RVHZ86Pq
 N9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Y6voXNNTmbwARO0HNg5rXU1hQc8njWyDa9GiF3dMtY=;
 b=kMxi+0gcmAOjF3jlzWyJwE421X0gLWqtXPHqEIudf+pMcXyDbunFBz2Yt3HshwzhwQ
 tmMLiSoQXtbJ3DpLCVVk/KZzhfbZx2bzGFTZMFwQhYVtxBFsS/XrwjMh8jUdTmImNxCg
 lJK1we2e6FLIE1NV+ANpgdJr6LKHIZ61xEQp3SWOjD/nbHSgCrPGcxVbkH7bLkpfT8Ri
 C/EXaoOnwr4Tkzcewpn0XnAQZhBrhlfTMeg49ZfzbKQDDjFaBt64SYeEfC73l9W+nCrF
 KHuf5IEc1cC/1dsCWPG0deCTBod5Tga0D6LtQzrH5qFWFYmpVLI0jg+xRZzJk49xMgM+
 TCdA==
X-Gm-Message-State: AOAM530Ef5n7lHDk2GWrLvSFztvePNHBkqV46L5dbR6U5I/9iUd+YWa8
 yYGnsNwxBGqhGD+QwktpW54=
X-Google-Smtp-Source: ABdhPJwaC5Wx3USndBbaHUyvW9J3yqeM77b97FXGBBSuFefwKCEZlCUVOo5fXlWTiOppcfefjQejGA==
X-Received: by 2002:a17:906:6d87:: with SMTP id
 h7mr13751884ejt.344.1593537590090; 
 Tue, 30 Jun 2020 10:19:50 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id b6sm3375413eds.64.2020.06.30.10.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 10:19:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Adjust MIPS maintainership
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
 <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1fdab6eb-9258-7df1-75ea-b4717a9c2b87@amsat.org>
Date: Tue, 30 Jun 2020 19:19:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: aleksandar.rikalo@syrmia.com, Paul Burton <paulburton@kernel.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Missing in the patch description that you are taking this
machine over.

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


