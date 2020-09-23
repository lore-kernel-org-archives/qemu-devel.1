Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219FFC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC5320725
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekhqrqdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC5320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL2ea-0002As-JR
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kL2dU-0001em-FS
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:08:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kL2dS-0002Q4-NJ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:08:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id b79so6654025wmb.4
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 04:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/WiH6uLl2VjwKV4X+/AAV4KnsSY4AgF2NB6XIEOSIms=;
 b=ekhqrqdMdIZgLID4xSK6oiF2Dm0yv7A34FOnJBKN54ALoS2124688PQpJ90K5I05v1
 ivsYMZYOeLQ1Slc4xXgzlRmoIc4F1EIf0DhVBzluvs0WaBdABqZ/Ph0DQy1Xi5p+6h6v
 e+uE7cW1DLa6Xrl1Ktq/2aLVrd4Pcq2OBKwKw6rzjPm9xanQvyKAoIrHAg2RuRely8Xc
 Jqz4AZumEf+gRsN18ERYSVB9ncq/yxIOGqpWnTumpmW6fLNkDNUZbKGX/XlfXx7FC+mn
 BdogSCuecnh/L1vhSqG7dm/F3wNplRH0g4AalF/lMtjbV3E49la0Va39SItEcTFSngvE
 kcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/WiH6uLl2VjwKV4X+/AAV4KnsSY4AgF2NB6XIEOSIms=;
 b=n/56A5hfoSTzzQ623AnjNr6NKIxQugrLRHO/ET4uRdAR1Wc0XoeNPvLu4Y4Ne5Q53Y
 N7inA97pIlpWZYNC9/cDHqQdn2NnlU8o/YkIRHf2Gnmn4YhdsxXvpu1QXepjMdx51z31
 Muutanm4HogqbFiIt8WcjrYK36rq9j0UQWmYcQfmewP3Od/StCeHgyKOn3t95Ieavqi9
 +3oUYQak8OMILNoEnY7mRSUou64+UyTpSC4iBi3O9xjw/n3eh9PSwkRMp33fU2ezjP8q
 iOVnjmTqJ3RlwEsvMdN+BzZdRfiLk0YUXNgQbM2cbC8glBNEoebmB95DUNL+k/i04gUB
 Sy6A==
X-Gm-Message-State: AOAM533TvcsXwO4BBWo00Rhrl3GqGz5QOGvFdCPpfjs8eSwEWESGnBa2
 pVMf9mIA4e8IUIda0kSUbTM=
X-Google-Smtp-Source: ABdhPJxsyuq4UREZ/aEDRM4yceiof/d07y5O64WOSxv9j+qo/HxZfzQTKJvmSrhxh5Z0MQMi0jTvlg==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr6166041wmy.51.1600859308294; 
 Wed, 23 Sep 2020 04:08:28 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l4sm6293922wrc.14.2020.09.23.04.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 04:08:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] accel/tcg: Fix computing of is_write for mips
To: Kele Huang <kele.hwang@gmail.com>, qemu-devel@nongnu.org
References: <503406> <20200923093800.9845-1-kele.hwang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <25889d77-4de0-6f5a-2b60-ab3e474e7c50@amsat.org>
Date: Wed, 23 Sep 2020 13:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923093800.9845-1-kele.hwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Xu Zou <iwatchnima@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing the TCG MIPS maintainers, and also
Cc'ing Richard who made a comment in v1.

On 9/23/20 11:38 AM, Kele Huang wrote:
> Detect mips store instructions in cpu_signal_handler for all MIPS
> versions, and set is_write if encountering such store instructions.
> 
> This fixed the error while dealing with self-modifed code for MIPS.

Quoting Eric Blake:

"It's better to post a v2 as a new top-level thread rather
than buried in-reply-to the v1 thread; among other things,
burying a reply can cause automated patch tooling to miss
the updated series."

> 
> Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> Signed-off-by: Xu Zou <iwatchnima@gmail.com>
> ---
>  accel/tcg/user-exec.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index bb039eb32d..18784516e5 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -710,11 +710,60 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>      greg_t pc = uc->uc_mcontext.pc;
>      int is_write;
>  
> -    /* XXX: compute is_write */
>      is_write = 0;
> +
> +    /* Detect store by reading the instruction at the program counter. */
> +    uint32_t insn = *(uint32_t *)pc;
> +    switch(insn>>29) {
> +    case 0x5:
> +        switch((insn>>26) & 0x7) {
> +        case 0x0: /* SB */
> +        case 0x1: /* SH */
> +        case 0x2: /* SWL */
> +        case 0x3: /* SW */
> +        case 0x4: /* SDL */
> +        case 0x5: /* SDR */
> +        case 0x6: /* SWR */
> +            is_write = 1;
> +        }
> +        break;
> +    case 0x7:
> +        switch((insn>>26) & 0x7) {
> +        case 0x0: /* SC */
> +        case 0x1: /* SWC1 */
> +        case 0x4: /* SCD */
> +        case 0x5: /* SDC1 */
> +        case 0x7: /* SD */
> +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
> +        case 0x2: /* SWC2 */
> +        case 0x6: /* SDC2 */
> +#endif
> +            is_write = 1;
> +        }
> +        break;
> +    }
> +
> +    /*
> +     * Required in all versions of MIPS64 since MIPS64r1. Not available
> +     * in MIPS32r1. Required by MIPS32r2 and subsequent versions of MIPS32.
> +     */
> +    switch ((insn >> 3) & 0x7) {
> +    case 0x1:
> +        switch (insn & 0x7) {
> +        case 0x0: /* SWXC1 */
> +        case 0x1: /* SDXC1 */
> +            is_write = 1;
> +        }
> +        break;
> +    }
> +
>      return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
>  }
>  
> +#elif defined(__misp16) || defined(__mips_micromips)
> +
> +#error "Unsupported encoding"
> +
>  #elif defined(__riscv)
>  
>  int cpu_signal_handler(int host_signum, void *pinfo,
> 


