Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1148FC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 12:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D235206F4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 12:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUuwFdUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D235206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbN5m-00066A-Vx
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 07:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbN4N-0005fI-9f
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 07:11:47 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbN4K-0006Tg-OT
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 07:11:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id g12so3966416wrp.10
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 04:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cbQCMnoA46n9VWtkBmFYqLaX4zeg/nxbivVpHW/3LaI=;
 b=nUuwFdUQpZjXWAuWicL7CVLfhqzMIkZFHG+r9Ororswvsl6dYnhLUef8yVMNLT00Os
 xGVmdF7IPKPwJhl6g1z6r/XhfDmMpBgEkv58ktYP7+YdlEfQss2+dgZC8BCX2spmJlt1
 OEX1BZYrFY/3JZAMIU+mjHoVPbuZERRKDlBCv9bL7v0wY6rtnqr9FGFuNhvgzr22i4ah
 jQybp7j+JUEVw2PS43cVs6F/scNyhqU1pcQVz6mdotdvXPnQuOPuWZsBI+wQ7GjO/2fh
 x6OzIHwqkOn6pC/Ufy6DhRuqrCciX6WEXnMh9bsTUfEhqeIztcGGhdtxn2W5nNTqzCdt
 6S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cbQCMnoA46n9VWtkBmFYqLaX4zeg/nxbivVpHW/3LaI=;
 b=Osufzp/AxQiDrZjjw+9y3e+qLUT7mZ1/5jGGCaiLs4H4H5XIlnE15WqDl5fZRb387p
 /ACPMJ1vSNgBEoZ3/n6BNEhsVebrv4nTOYqjo38N2gDwJ55I67T0Re0Q6OIsklS6QsTZ
 Oksk+MFeRwAcB0WaRHFreGsoXtsERBUZ26YrITQ4VsLxsQ+9eJooOIjN6Mi820hnyBul
 vuifibx8uPvCC3F37oPOyLKrugDJbF6mjZ2Y2KqgXDTrmlHroY9guOBnsx5q8bzGkise
 wqUeCPJz1CTOuFCo5Dgr2tmfqAJsvI5W68fi25j/4kFZmmcpaXsq+OB6+PPugjFlbdjn
 tY1g==
X-Gm-Message-State: AOAM5329x6B5rNbkGTWX50zR9uDRy/JQeR3+tIQs39g+u763lXku/MMx
 E3+rjAlxoyVdkkW0jpksONo=
X-Google-Smtp-Source: ABdhPJyxJqJMI/Hli+q8dqNn+n4zRdd+FJlooOZlu9rGQqW69kiPWRKosUjeWiqNlFJiiGOX1JUbLg==
X-Received: by 2002:adf:a29e:: with SMTP id s30mr8259298wra.29.1604751102973; 
 Sat, 07 Nov 2020 04:11:42 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f1sm6212445wmj.3.2020.11.07.04.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 04:11:42 -0800 (PST)
Subject: Re: [PATCH V17 1/6] target/mips: Fix PageMask with variable page size
To: Huacai Chen <zltjiangshi@gmail.com>
References: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
 <1604636510-8347-2-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9b081173-c4f6-28b8-178c-7137e911d2f6@amsat.org>
Date: Sat, 7 Nov 2020 13:11:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1604636510-8347-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 11/6/20 5:21 AM, Huacai Chen wrote:
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Our current code assumed the target page size is always 4k
> when handling PageMask and VPN2, however, variable page size
> was just added to mips target and that's no longer true.
> 
> Fixes: ee3863b9d414 ("target/mips: Support variable page size")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  target/mips/cp0_helper.c | 27 +++++++++++++++++++++------
>  target/mips/cpu.h        |  1 +
>  2 files changed, 22 insertions(+), 6 deletions(-)

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> index 709cc9a..92bf14f 100644
> --- a/target/mips/cp0_helper.c
> +++ b/target/mips/cp0_helper.c
> @@ -892,13 +892,28 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
>  
>  void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
>  {
> -    uint64_t mask = arg1 >> (TARGET_PAGE_BITS + 1);
> -    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 == ~0) ||
> -        (mask == 0x0000 || mask == 0x0003 || mask == 0x000F ||
> -         mask == 0x003F || mask == 0x00FF || mask == 0x03FF ||
> -         mask == 0x0FFF || mask == 0x3FFF || mask == 0xFFFF)) {
> -        env->CP0_PageMask = arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK << 1));
> +    unsigned long mask;
> +    int maskbits;
> +
> +    /* Don't care MASKX as we don't support 1KB page */
> +    mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);

I'd simply use extract64().

> +    maskbits = find_first_zero_bit(&mask, 32);
> +
> +    /* Ensure no more set bit after first zero */
> +    if (mask >> maskbits) {
> +        goto invalid;
> +    }
> +    /* We don't support VTLB entry smaller than target page */
> +    if ((maskbits + 12) < TARGET_PAGE_BITS) {

I suppose the magic 12 is TARGET_PAGE_BITS_MIN, right?

If you confirm I can do the change when applying (no need to
repost the whole series).

> +        goto invalid;
>      }
> +    env->CP0_PageMask = mask << CP0PM_MASK;
> +
> +    return;
> +
> +invalid:
> +    /* When invalid, set to default target page size. */
> +    env->CP0_PageMask = (~TARGET_PAGE_MASK >> 12) << CP0PM_MASK;

Ditto.

>  }
>  
>  void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index d41579d..23f8c6f 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -619,6 +619,7 @@ struct CPUMIPSState {
>   * CP0 Register 5
>   */
>      int32_t CP0_PageMask;
> +#define CP0PM_MASK 13
>      int32_t CP0_PageGrain_rw_bitmask;
>      int32_t CP0_PageGrain;
>  #define CP0PG_RIE 31
> 

