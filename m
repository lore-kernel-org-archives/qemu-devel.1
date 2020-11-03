Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CA8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556BF20731
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FATwurUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556BF20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvld-0004BO-BX
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvij-0002Us-0C
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:47:29 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvih-0000jS-60
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:47:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id s9so18402137wro.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 04:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sHksTowz5dtsSX7PsRRADU4YGWUqCX7D+FbYtbwzQEA=;
 b=FATwurUZjDSbsvDUIWdIfsgrgJ7X8BoKOUjRfGI5ZM8U//nU/AMb1QYRytNlf60BHz
 JIoV5oVy5kAOlOwYn8pJRFhpijAXOg7UEzWPyNOaV1LBei7Q6syPP5nE5+I1xFCoIXxR
 ccayLqvXXaslVflpGXiJlXSyRPqTBVv3aD7n73taJCyQhfVnVm6bronde4dLtJWGeHK2
 sc0DqGZKkSZ/Tr+o21ln/ZuzW32PPsDXJFoqAxP55FJkFwaS5VuEe0//QOEOIkFm+EMO
 tE2sI2b+o/TA/+zhvMMldCsYVNXcmm5DXGUMFk0DwW+f7vtDIKUai3NhARzvlSA01cDq
 vE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sHksTowz5dtsSX7PsRRADU4YGWUqCX7D+FbYtbwzQEA=;
 b=G7+1k4Tqy0T93fk5xveOZh7nW0YT+HswXhtqqW3lZ2cSw4AjcFEm4tynJ6/SCLiS7S
 k/oGB9RNy3bPbfcJR/83jtlZzuj8ShIdc2Eu8DcwnybMIMoS3G5ftFW/dZAdCl8Ea7oc
 xvBCUoo+fNEd0iH/yFuwuMN4sXP/0bz5y0rIOQr8mVrHolXGXWrTW17iylDzCzweCxVe
 yt4CEbbiIcDQhD9x1IAlOEMqFq3YO7Tup4GWTLEx1Dca32Nay0jFN89tjFXaRamsPaMy
 ONHiYWws3UOIN11YFp3X6vEEjOkkbKCmhv1a/dVHuVUSkBZIgZt7S2ttw7E/6222mTAh
 ejmw==
X-Gm-Message-State: AOAM530J3OnnRH+jWzFod/7BieSJNUsdD9JCzUi7oA3Yw6QHCugwYwdd
 vE1s3XeM1mr7usSIWmCirXM=
X-Google-Smtp-Source: ABdhPJzpkUAJvmUHBgqtig5999YbMQZzm2GCtyxi8ieKguV9PVANKaPJziOeDoV9rOCywjq8jtk5KA==
X-Received: by 2002:adf:e743:: with SMTP id c3mr26513895wrn.317.1604407645377; 
 Tue, 03 Nov 2020 04:47:25 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id z191sm2814395wme.30.2020.11.03.04.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 04:47:24 -0800 (PST)
Subject: Re: [PATCH V16 2/6] target/mips: Add unaligned access support for
 MIPS64R6 and Loongson-3
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
 <1604053541-27822-3-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c1b9a5a-7214-b724-f565-9069cc8823ab@amsat.org>
Date: Tue, 3 Nov 2020 13:47:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1604053541-27822-3-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 11:25 AM, Huacai Chen wrote:
> MIPSR6 (not only MIPS32R6) processors support unaligned access in
> hardware, so set MO_UNALN in their default_tcg_memop_mask. Btw, new
> Loongson-3 (such as Loongson-3A4000) also support unaligned access,
> since both old and new Loongson-3 use the same binaries, we can simply
> set MO_UNALN for all Loongson-3 processors.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  target/mips/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index f449758..470f59c 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -31442,8 +31442,8 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>  #else
>          ctx->mem_idx = hflags_mmu_index(ctx->hflags);
>  #endif
> -    ctx->default_tcg_memop_mask = (ctx->insn_flags & ISA_MIPS32R6) ?
> -                                  MO_UNALN : MO_ALIGN;
> +    ctx->default_tcg_memop_mask = (ctx->insn_flags & (ISA_MIPS32R6 | ISA_MIPS64R6 |
> +                                  INSN_LOONGSON3A)) ? MO_UNALN : MO_ALIGN;
>  
>      LOG_DISAS("\ntb %p idx %d hflags %04x\n", ctx->base.tb, ctx->mem_idx,
>                ctx->hflags);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

And queued to mips-next.

