Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D932C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4B5207BC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4pwXzG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4B5207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMSFe-0005lR-Jo
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 04:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSF4-0005Mb-Gv
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:41:10 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSF2-0007ZN-He
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:41:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id k10so5228908wru.6
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gKh8Pb9atTXZwt2G67h+oqhfOUppWxa5k1OnvPWksKs=;
 b=W4pwXzG84hCZFzMNYN3VIC65tNF2zT9CE+kbxGi0xe6V5Y1AESLK1fkVRd4r2S3eR9
 Ff6v7NWs5gnilZIIypr/B1eykU9e6EUzFIj5UlkeES7tmZMScyIFVw4tInH6jNn14LXK
 oD3EtVCkMnNuuZIFyt+bKxv+fZGUQ1IRL3kHW8X7WI139QyULO+BVuLUR+FsddJHQVfn
 5G5Cp5HhDXr9sHQGoui+keNFJbFRH2FCAL0ffLd5URrrn4+hSw/Du7ghTIg55HMdD8Wq
 217PrmNwPwYgHjZJROBr+Ih1LVEW42Wy6nHGqYWSiG1WVCPxcf4oSjEjL1Z9WK/ZRn7r
 mkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gKh8Pb9atTXZwt2G67h+oqhfOUppWxa5k1OnvPWksKs=;
 b=g/7wlD7IXyo0HockFCCq/SY/8GYZp/zyZ5OT4ozVcWeZLbBTbrraE+E1LtQI789Cv7
 KqqEcJCaVqz5/GgVDyid63MxBXtHeU/565qXEqpDW7arQNQ9gu3EPlxUkHrQhPCNEvlp
 k5Fyln3pV9Lk5kgfuXScz+34bZzUUf9PwKPXHkMtqQwFgRcPDROLQ4fxb5YtTyu639bm
 xgrRsizC8qkBs5vM6xWml6ztGl1EwpzakbzuGWMfbPUoTUP7qpGkGowu/I5FOEhbEKXi
 iriodJNh5j8nA5w0WTVF0V7JsiDImSZrcv7636HPvII29ezgjW5vb0byU16VP+Ge5Sho
 a+7w==
X-Gm-Message-State: AOAM532EFtb28niLAim0S/vWZa8XE3HrGNWjq9Qw6eanTgOcc9rQYeGt
 zZ79k/KrJmEydhF7+00EZTw=
X-Google-Smtp-Source: ABdhPJwIHDtPgyBlbr67M6lX+dc2+qx6y4hsyEni0wkw0ltMKEHe96bN04kODewWtp4EiLKQ8BapSg==
X-Received: by 2002:adf:f508:: with SMTP id q8mr12391198wro.233.1601196066492; 
 Sun, 27 Sep 2020 01:41:06 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id f14sm4813638wme.22.2020.09.27.01.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 01:41:05 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] accel/tcg: Fix computing of is_write for MIPS
To: Kele Huang <kele.hwang@gmail.com>, qemu-devel@nongnu.org
References: <20200927082033.8716-1-kele.hwang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c716ca94-5600-5521-f0ef-cd0e7809f52a@amsat.org>
Date: Sun, 27 Sep 2020 10:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200927082033.8716-1-kele.hwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.213,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Xu Zou <iwatchnima@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/20 10:20 AM, Kele Huang wrote:
> Detect all MIPS store instructions in cpu_signal_handler for all available
> MIPS versions, and set is_write if encountering such store instructions.
> 
> This fixed the error while dealing with self-modified code for MIPS.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> Signed-off-by: Xu Zou <iwatchnima@gmail.com>

I already Cc'ed the TCG MIPS maintainers twice for you,
but you don't mind, so this time I won't insist.

> ---
>  accel/tcg/user-exec.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index bb039eb32d..9ecda6c0d0 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>  
>  #elif defined(__mips__)
>  
> +#if defined(__misp16) || defined(__mips_micromips)
> +#error "Unsupported encoding"
> +#endif
> +
>  int cpu_signal_handler(int host_signum, void *pinfo,
>                         void *puc)
>  {
> @@ -709,9 +713,42 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>      ucontext_t *uc = puc;
>      greg_t pc = uc->uc_mcontext.pc;
>      int is_write;
> +    uint32_t insn;
>  
> -    /* XXX: compute is_write */
> +    /* Detect all store instructions at program counter. */
>      is_write = 0;
> +    insn = *(uint32_t *)pc;
> +    switch((insn >> 26) & 077) {
> +    case 050: /* SB */
> +    case 051: /* SH */
> +    case 052: /* SWL */
> +    case 053: /* SW */
> +    case 054: /* SDL */
> +    case 055: /* SDR */
> +    case 056: /* SWR */
> +    case 070: /* SC */
> +    case 071: /* SWC1 */
> +    case 074: /* SCD */
> +    case 075: /* SDC1 */
> +    case 077: /* SD */
> +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
> +    case 072: /* SWC2 */
> +    case 076: /* SDC2 */
> +#endif
> +        is_write = 1;
> +        break;
> +    case 023: /* COP1X */
> +        /* Required in all versions of MIPS64 since 
> +           MIPS64r1 and subsequent versions of MIPS32r2. */
> +        switch (insn & 077) {
> +        case 010: /* SWXC1 */
> +        case 011: /* SDXC1 */
> +        case 015: /* SDXC1 */
> +            is_write = 1;
> +        }
> +        break;
> +    }
> +
>      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
>  }
>  
> 


