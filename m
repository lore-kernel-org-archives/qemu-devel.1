Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17693C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934D5207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAkocZBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934D5207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRAD1-0001uo-Jy
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRABe-0008WL-Nz
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 04:25:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRABd-00012Z-0c
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 04:25:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id v12so11941238wmh.3
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4cg7QNiKP+39eVLI/ZmJE37C1I6M1JRB/YJAbaM5g2E=;
 b=MAkocZBPhuJkPZOf/Llg1ZzV7NZa5+hoxgBz+cNpFeh9JjrVaA+wVBb+tEOpT92Bi4
 Xnlqow3btiVs4LfIZu/KPR1zRX8hhEw0g9sUc5GQCHsBhUCsA+nMg8TdLQweAeFtUPSU
 wg01PXl0byPGbCnZ7qby/BTWyT9l9PQmNGLoLAIfOxa5oSEJj982hQFBbFYKwz0sn+eJ
 q6nhsKwobeXYMxQJ6fd3Taqrb90ndlbruvn/aWEXsbp49jFCfAcXsZ8qySQV6j4N6z0X
 VyN4NMV1HKkP1+NAVIlVkWwL5/hd+iu29soKkLZplmYalKbcI0KmnZvuTejUdO3TYxTc
 dDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4cg7QNiKP+39eVLI/ZmJE37C1I6M1JRB/YJAbaM5g2E=;
 b=in9G4jNVzXcT2KVkn5Njj1Nc/+9TQ2X3ySzofXkJos3Kiu7kL8RVLXMgL3px89Q4sj
 lIXS9V5gQ808r+rJWrZlp1iwsUKI/x0V5yzpyYbTnMi15xxlUI/x6opAJFudFAmOBUYI
 kDUbhXCWYhQMXlPwNRHo74r/WgfCI3ZvgKFNlMbMH6zsZNAEHJqTHrLCkOeG4kPDoh9u
 f2SAVY/0EilT0zl5ISlBv7dqzQq+xrSZd9CjhckZnRoC48BSnTZNc1hnAtRYzC/rr8T5
 yl1ztSVTh7ZVpxhUQgqeZREt3qL6nqfZFXmdD/3Gz5wSgqd+Mm+7yu4lE/xYpXX7p79Q
 SYmQ==
X-Gm-Message-State: AOAM532I5vNwa8aK4iFDQul7DUR6xMQWE9dECHqaIx7X2CgqgES39DW6
 zPTRVfCewEZMvraS3yARsAI=
X-Google-Smtp-Source: ABdhPJwl9q1kNSRTjlPaBs5iwdadLsx8ATXe2E2zC9RQNDcUFTC/EaNThFgRBDZjwcKi2oapTG45YQ==
X-Received: by 2002:a05:600c:2241:: with SMTP id
 a1mr1887238wmm.49.1602318302981; 
 Sat, 10 Oct 2020 01:25:02 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c16sm16224716wrx.31.2020.10.10.01.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 01:25:02 -0700 (PDT)
Subject: Re: [PATCH V13 1/9] linux-headers: Update MIPS KVM type defintition
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-2-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76fd94c4-0370-a20a-2007-43f478ce1940@amsat.org>
Date: Sat, 10 Oct 2020 10:25:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602059975-10115-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 10:39 AM, Huacai Chen wrote:
> Update MIPS KVM type defintition from Linux 5.9-rc6.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   linux-headers/linux/kvm.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 6683e2e..c138b2f 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -790,9 +790,10 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_VM_PPC_HV 1
>   #define KVM_VM_PPC_PR 2
>   
> -/* on MIPS, 0 forces trap & emulate, 1 forces VZ ASE */
> -#define KVM_VM_MIPS_TE		0
> +/* on MIPS, 0 indicates auto, 1 forces VZ ASE, 2 forces trap & emulate */
> +#define KVM_VM_MIPS_AUTO	0
>   #define KVM_VM_MIPS_VZ		1
> +#define KVM_VM_MIPS_TE		2
>   
>   #define KVM_S390_SIE_PAGE_OFFSET 1
>   
> 

