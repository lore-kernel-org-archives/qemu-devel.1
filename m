Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A9FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779D9223AC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDFQgq3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779D9223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWxaI-0003bI-Et
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWxYt-0002bd-0U; Mon, 26 Oct 2020 04:09:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWxYr-00059L-BN; Mon, 26 Oct 2020 04:09:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id k18so11450167wmj.5;
 Mon, 26 Oct 2020 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y8jPhiGQvTCWXAv0hYVCIpQDQLplznWE1yrPbus25zk=;
 b=TDFQgq3/gVQZL9xCeohGD+rqBNkYzVRXA+Vw0RSeTdTH9xjRXhPfl9zmH28Xytb88y
 /R8gf5vWtVM3ayqNuHjMrZeG0TlF24cQQZ88CIaPaJaGdX3LSd7A7D7Iv7XucbsOPuY4
 0H+RS+zWxw93t7tMVefh2EheN66uxzTfPLngNXYyGfyf6mDHopKIz8oZFtyBqvDcwgiB
 5cmMZ1HPKartlM+zaDKTB13uCnMU65wzQSPtaJMtokKrmNiaqeucqpIqfE1cMaa3XP5D
 nS98HMH9ximqqBUuZVmRmGqXUmezUpqJIFx5JFvqF8lhcI6IIRRp1ISo/JNcs8sSMjJR
 RYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y8jPhiGQvTCWXAv0hYVCIpQDQLplznWE1yrPbus25zk=;
 b=T889DzNjGUTgGC2vdfARsPUZ2d7W8HyV1KkEXW4h1Gfz8V1lb0KTNkJk/g+MO26voM
 Fvy/y8SPAxKP3wTg8lwQxPH+CBhjehpEy+jAbM/JrAzGDhr2CqS8WFVfj3daTcebFbc+
 uwtNcsSrlAyS6jpjeNI84o0b0J2aRMe1S3UqNVV3VeCqPXkUtR+l8AGV/PNsMCcT9IIU
 1GxZHmgwh3m8JK0mzMJKJFW2kQncxgduk/FQCoH5I0X7Ls2nh7rrpoyuMVF/CSEJE3Pz
 QtrbY5ODlxKU/9vWr/TUXyeBM3e6KpCEk3DpPxvwRBqcy+u/WoOZKQLDDnbZqn4NOWND
 Gtfw==
X-Gm-Message-State: AOAM533KynIBj9yG99Dwv1mDv0P/Vyt8nPg0pzY8OBs65MVZLZPsM6mr
 7Qp+NByIEAFPW5SD1mr4zXQ=
X-Google-Smtp-Source: ABdhPJwVIa0NCf1SiJfXiVGL44t3W6d3z3SPpwCIqeciGIci4TANBjGaPn42pCVZXjS3rlXwwsDqpA==
X-Received: by 2002:a1c:7f97:: with SMTP id
 a145mr15289672wmd.160.1603699739457; 
 Mon, 26 Oct 2020 01:08:59 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 1sm23408199wre.61.2020.10.26.01.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 01:08:58 -0700 (PDT)
Subject: Re: [PATCH] hw/sd: Zero out function selection fields before being
 populated
To: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20201024014954.21330-1-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e4c44aa-7d2a-e773-fe8e-47b858137896@amsat.org>
Date: Mon, 26 Oct 2020 09:08:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201024014954.21330-1-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Bin Meng <bin.meng@windriver.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/20 3:49 AM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> The function selection fields (399:376) should be zeroed out to
> prevent leftover from being or'ed into the switch function status
> data structure.
> 
> This fixes the boot failure as seen in the acceptance testing on
> the orangepi target.
> 
> Fixes: b638627c723a ("hw/sd: Fix incorrect populated function switch status data structure")
> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>   hw/sd/sd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index c3febed243..bd10ec8fc4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -824,6 +824,7 @@ static void sd_function_switch(SDState *sd, uint32_t arg)
>       sd->data[12] = 0x80;	/* Supported group 1 functions */
>       sd->data[13] = 0x03;
>   
> +    memset(&sd->data[14], 0, 3);
>       for (i = 0; i < 6; i ++) {
>           new_func = (arg >> (i * 4)) & 0x0f;
>           if (mode && new_func != 0x0f)
> 

Thanks, series applied to sd-next tree.

