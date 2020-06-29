Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805E7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507FB255A5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxCcQLMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507FB255A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpy2d-0006nQ-GW
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 13:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpy1S-0006Cq-Pl
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 13:56:50 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpy1P-000396-9Z
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 13:56:50 -0400
Received: by mail-ed1-x543.google.com with SMTP id h28so13656413edz.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=22b/USseLZh5ABN4bpIf7G+xAqjRbApwjJeFivL5eEo=;
 b=HxCcQLMAczrlQpHxKVLs52oB0yyE1q1Ymt+H7YYHlq04gwpYv2YdeqWFiAUw9/6d1C
 1kfgXbAfc6FeExLrHISk1HAfHy28Rpcr6niXfeTA4e2XaBJvXuD0gywXk6UL/C0Mm8iZ
 U5hMrnEw7n0qiz+pwjEbETC4gG6HCFh93KmdS5ovh+TarqqHesQaQ3UsBklM0UBRurpz
 SaKGEC8NNVWbt4v2Tws08o/6iwHdObnhCAaZDwx7JSrsCft7Ng1Y31vsXJ8AZ+BEIIGp
 Rc0ZpBElScD1nvD5wfwbqgQG6RvfsQKB+oxmbvXknncWp3/MHW5xkMDcbmPWQ7MKULq7
 SA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=22b/USseLZh5ABN4bpIf7G+xAqjRbApwjJeFivL5eEo=;
 b=KqHmogmaau9ttxnUX7k87uQIuasaHP7pXNe6hVRFLit06y9vtZZ+XWtZT8j4AcVAQk
 kZWHpLJZYWVvZFiR8XDozYj6FK9LdrQEbUoUq1d9HWD21gRA7L9MgmLLyoA3gE3SQiA6
 fz4a6ERw4gEsbQn9UwHBoReZzA9nn+hepUFj+P8Ov2WJlAauWgN46VSvwqPd07Y5Ksaz
 PF7Crj/ZBV8ADST2Tb3/M4OqkQ6ULYHnnNxAaXVeMxfEKFl2KSmJ5wndFJhkXFMDjcMv
 HtY88mLDHmxIiEparyMJCkv+m0WASFAosOVK+GgUn6ISZCcOyr1/M7jfvH5sBMPtBjB8
 250g==
X-Gm-Message-State: AOAM533mxTUYSTp4N1T4SUrkHmzj5DZlzTCEW8Cwfc7Px9OSy/fYXF/9
 3jCoQCiQkEypzza8PX1rwM4=
X-Google-Smtp-Source: ABdhPJylvsp1cll93AE58pFuYWEhGrFMNV8iAE4SczBXJZ/ORLcxJVY0VGa4MAGTvh0sUHFFJpREVg==
X-Received: by 2002:a05:6402:1544:: with SMTP id
 p4mr19230244edx.334.1593453405474; 
 Mon, 29 Jun 2020 10:56:45 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d2sm447863edk.4.2020.06.29.10.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 10:56:44 -0700 (PDT)
Subject: Re: [PATCH] target/m68k: fix physical address translation in
 m68k_cpu_get_phys_page_debug()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 laurent@vivier.eu
References: <20200629162636.6648-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <853eebf0-f8a7-c7dc-bcbd-a491016a2e7a@amsat.org>
Date: Mon, 29 Jun 2020 19:56:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200629162636.6648-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 6:26 PM, Mark Cave-Ayland wrote:
> The result of the get_physical_address() function should be combined with the
> offset of the original page access before being returned. Otherwise the
> m68k_cpu_get_phys_page_debug() function can round to the wrong page causing
> incorrect lookups in gdbstub and various "Disassembler disagrees with
> translator over instruction decoding" warnings to appear at translation time.
> 
> Fixes: 88b2fef6c3 ("target/m68k: add MC68040 MMU")
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/m68k/helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 79b0b10ea9..631eab7774 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -820,10 +820,14 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      if (env->sr & SR_S) {
>          access_type |= ACCESS_SUPER;
>      }
> +
>      if (get_physical_address(env, &phys_addr, &prot,
>                               addr, access_type, &page_size) != 0) {
>          return -1;
>      }
> +
> +    addr &= TARGET_PAGE_MASK;
> +    phys_addr += addr & (page_size - 1);

Correct but all the callers do the same, maybe this can somehow
be moved to the callee? Anyway:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      return phys_addr;
>  }
>  
> 


