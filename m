Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C533C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A296421D46
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzh7blJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A296421D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4HD-0000bg-OS
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4GZ-0008Bf-3j
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:52:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4GX-0000S9-63
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:52:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id a17so3908471wrn.6
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cxAR6GGzSL9bTpKLyCCp/+JyGcGaHWVE6iOvZVeh4Xw=;
 b=pzh7blJ6lkAAl46AEf3xwgSZwCnPDZzCCXBVBNcBzRslxYbGxL9OVop/APuZNang8x
 t+qe0nZTa3upwzEq83j3jcSpqaZNhTuTdYp9rHUIekwqP1mnv0MgbE5XCO5EfwdcSuXO
 CnSbmOUGdjx81v6+4MsOQx1Er0890/AM5WHj4swj9MIG1pEShWIE8Q1mz937kdhktrG4
 k2YnphxzhKBnR5ZdIFGE8FhY0uQculqfUfZLZIaqpW+sJPDVfWqEi7uk29LJ6p8/iHsy
 dvvpc9/bo3cSA5AwsNRxWcrqMUh8gghCLCJHv0My+/aUmviFvioq5vc1EPb+S/DXT/dj
 JARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cxAR6GGzSL9bTpKLyCCp/+JyGcGaHWVE6iOvZVeh4Xw=;
 b=BRC/lqBsrBqRWb8KnxdNW7To/yhbaPQkxComRZ+1IOnyQ3jwbwOS4ZlhJL1BUZ0ot7
 /liP4CtLTd7S7jzlQyW0f70TWKdMzOM/LfSIsb9EPbB1TC31AVv487g3uCkUmACh0+GC
 6kmrMPFGOitmcC+qT8BOEF/zGJO8s+Ej63rOvKnFIwSUkFbRMQFLgYgC/cnMPr4bu7kO
 XgLvXNy28+ziFi3uCaiXSzE2ygQtdrehIGzLHSAH1EPE5Gv1wK0Jf9QjTJc89NXz3jON
 Ezt9ibNtFRtK6iSVlyW7inhfyV4WeUuc3TRFYZ4RcQ453zgr59Ay4wQKdXqDPcWWTQe+
 +Vng==
X-Gm-Message-State: AOAM531Fnp23PrPyjFMpJNL7H9SXq2u2fpP8JnRQQn2ZzCmqmgNyImpX
 pZQcZGjviN6NONls+U+J2Mg=
X-Google-Smtp-Source: ABdhPJx00G2miwfECXZCzHhQDclyw95PbWiqdrPm4Miy6vc/pMXulFnb+WARNcF76o31CGW1cYOYlA==
X-Received: by 2002:adf:81c6:: with SMTP id 64mr4967927wra.176.1599673935713; 
 Wed, 09 Sep 2020 10:52:15 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm4906258wmg.44.2020.09.09.10.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 10:52:15 -0700 (PDT)
Subject: Re: [PATCH 13/43] tcg: Consolidate 3 bits into enum TCGTempKind
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200909001647.532249-1-richard.henderson@linaro.org>
 <20200909001647.532249-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <33675f76-0d1f-af7a-f819-445d456de3d4@amsat.org>
Date: Wed, 9 Sep 2020 19:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909001647.532249-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 2:16 AM, Richard Henderson wrote:
> The temp_fixed, temp_global, temp_local bits are all related.
> Combine them into a single enumeration.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Already reviewed:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg701705.html

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg.h |  20 +++++---
>  tcg/optimize.c    |   8 +--
>  tcg/tcg.c         | 122 ++++++++++++++++++++++++++++------------------
>  3 files changed, 90 insertions(+), 60 deletions(-)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 8804a8c4a2..f157092b51 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -483,23 +483,27 @@ typedef enum TCGTempVal {
>      TEMP_VAL_CONST,
>  } TCGTempVal;
>  
> +typedef enum TCGTempKind {
> +    /* Temp is dead at the end of all basic blocks. */
> +    TEMP_NORMAL,
> +    /* Temp is saved across basic blocks but dead at the end of TBs. */
> +    TEMP_LOCAL,
> +    /* Temp is saved across both basic blocks and translation blocks. */
> +    TEMP_GLOBAL,
> +    /* Temp is in a fixed register. */
> +    TEMP_FIXED,
> +} TCGTempKind;
> +
>  typedef struct TCGTemp {
>      TCGReg reg:8;
>      TCGTempVal val_type:8;
>      TCGType base_type:8;
>      TCGType type:8;
> -    unsigned int fixed_reg:1;
> +    TCGTempKind kind:3;

3 bits for TEMP_CONST later.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      unsigned int indirect_reg:1;
>      unsigned int indirect_base:1;
>      unsigned int mem_coherent:1;
>      unsigned int mem_allocated:1;
> -    /* If true, the temp is saved across both basic blocks and
> -       translation blocks.  */
> -    unsigned int temp_global:1;
> -    /* If true, the temp is saved across basic blocks but dead
> -       at the end of translation blocks.  If false, the temp is
> -       dead at the end of basic blocks.  */
> -    unsigned int temp_local:1;
>      unsigned int temp_allocated:1;
>  

