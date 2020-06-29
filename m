Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A9BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4665023343
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTNLbiYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4665023343
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpovG-00006r-KO
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpouj-00085w-Mp
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:13:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpoui-0001bx-11
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 04:13:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id f18so15190332wml.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yijM6EgjSGaM9PbE5pwRnq/U/P0D24TbYZpKtOhkbMM=;
 b=CTNLbiYxNVoTHGBhjhf6ouO8+sx518EvrVA1N+/0vl4lY5ZSXRM9H2Fqy0jfwh8QwB
 xZz9hmskKri4uZIyHN7Rb7do8M5XIYDI27DItLpvh5u2EUti33YYz6ArG/zQxJxFeIuo
 XSYc07nShS2UWy0dN9hJnyDG6iXj1Dv7Lk1TehYGBYOqI9XcvJrTofCEUZPN5xjEFPcj
 5ms397n2pn2B0c8Rctd7drCBctvrTVdbqCKwQpmLc3eqzY00CUtNYpoKtg2xcIWCsTuz
 OtG7FjID2u5lYsQsBe5aiRuNPKazyWFaxWA3ROqrNHwSduwacJPd31Cldisj+wJqy9sa
 pE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yijM6EgjSGaM9PbE5pwRnq/U/P0D24TbYZpKtOhkbMM=;
 b=ffEETR/ede+zBiyNKVyxafchIIQlP427IbJE3fQUDbVC8A51YHqUvMHrK92eV90tVA
 umM2ZgYx3sQ1RapK5gK5lGtc897I0hkLbUKIfuKrBp4eFRMPKSXFO0XzbyO6Xaz/mx71
 kxV7YPK6TK88sVKNx9uZgn+CsFgrJ5jlU/BbQucPrF8CQ/aryPGq0VsGCBEdYWBPNUUm
 MKVMN2L17xA5NSlDvtqJ4AjIYcKdPF9BJGTwxJwVozkp4gEgF0ewjpeEegV3kLRxIYwm
 WsnUEeTxOVSwRdzVVi6CtROf33IxZ8DiyLZqDtq9nd4U8XEk6L2MT0hTQvHtTQ+y4ak5
 BXOA==
X-Gm-Message-State: AOAM532NJCztt7tQmjkNulYZiQqa43gfSRsZiU0TqwNg6ZICFjqSyFnz
 4Y5aL451+BtF7kTm/sWH5Cw=
X-Google-Smtp-Source: ABdhPJzz2FiwcVeG97qwRVV4sTC45czVfI4dU+V5OIAqBkBRCkw9TE8oeDfQJB14jtcacz/uCSzZ7A==
X-Received: by 2002:a1c:2044:: with SMTP id g65mr13913339wmg.127.1593418394517; 
 Mon, 29 Jun 2020 01:13:14 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v11sm35050929wmb.3.2020.06.29.01.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 01:13:13 -0700 (PDT)
Subject: Re: [PULL 6/6] MAINTAINERS: Add 'Performance Tools and Tests'
 subsection
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1593287503-25197-7-git-send-email-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97eb7447-0453-2e2c-4003-a4de338ee11f@amsat.org>
Date: Mon, 29 Jun 2020 10:13:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593287503-25197-7-git-send-email-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 6/27/20 9:51 PM, Aleksandar Markovic wrote:
> This commit creates a new 'Miscellaneous' section which hosts a new
> 'Performance Tools and Tests' subsection. This subsection will contain
> the the performance scripts and benchmarks written as a part of the
> 'TCG Continuous Benchmarking' project. Also, it will be a placeholder
> for follow-ups to this project, if any.
> 
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Message-Id: <20200626164546.22102-4-ahmedkhaledkaraman@gmail.com>
> ---
>  MAINTAINERS | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe925ea..dec252f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1096,11 +1096,10 @@ F: hw/isa/vt82c686.c
>  F: hw/pci-host/bonito.c
>  F: include/hw/isa/vt82c686.h
>  
> -Loongson-3 Virtual Platform
> +Loongson-3 virtual platforms
>  M: Huacai Chen <chenhc@lemote.com>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  S: Maintained
> -F: hw/mips/loongson3_virt.c

Ah, now I see, here you unlist the uncommited file.

It might be easier to manage sending 2 different pull requests,
on for MIPS and one for the performance tools.

>  F: hw/intc/loongson_liointc.c
>  
>  Boston
> @@ -3026,3 +3025,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained
>  F: docs/conf.py
>  F: docs/*/conf.py
> +
> +Miscellaneous
> +-------------
> +Performance Tools and Tests
> +M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>

Aleksandar, don't you want to be listed here with Ahmed?

> +S: Maintained
> +F: scripts/performance/
> 


