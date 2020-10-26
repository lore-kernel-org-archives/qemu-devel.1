Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E9CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060962076A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGJWycwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060962076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7Ly-0003bF-OQ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX6xt-0006LQ-47
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:11:29 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX6xr-0007C0-J0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:11:28 -0400
Received: by mail-ej1-x641.google.com with SMTP id p9so15014498eji.4
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dffak8BKJG+IYBFdXpktJ4BEfRLU2hqlsz9PIJj9l3g=;
 b=NGJWycwx8wcNa9/rpznwirGoe0+T1HwZdee3WPdLxFYbWf7USqAfKKc394fLv+nBUH
 V6i650Wlp2khsAH8ne6Z2dWhVlzzvkJAxuTTFNx7OIgPYdSHBpGi8ESYnSPbmny9UH/G
 HHW8ZwuQoFa/xHrhDg5V9z3rsYyY4AjaDnXhqOUqlq8vIJx+QYR56BBs6vZBW9oBoYoY
 mO2ILXbCSBvwdUlipuSP15Zevu9kEgimQeD7nRgtBDBuVAyeKKLp82UqiDpM+rQlmJSU
 RxlkrIntP4BCpEfpPE06rstOGitrLqcF+qQbIpdCresXlGuYXpKpI7fJ/vjG0dn9IHDo
 Uvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dffak8BKJG+IYBFdXpktJ4BEfRLU2hqlsz9PIJj9l3g=;
 b=Nt7ft6gTq4cGfVkr9aTRNacARk5ZNHxI16PK302oFApq0PR6XVjWT9JwMISiQt3Nlg
 RaOiPs75/+Cc2JfpEjWggTsCU8F00vBbnI4oa+x6Gl8OqbiGLxAeGv1wxcLGBL1oKDdC
 ZBIWXM92sNx0At9ik5gHuJ7Y1X7DneTcdNy3cCx36hhmSGKRoiQmPd94YrLCAdyUQn2+
 PnsvogfbvqdrSuWVlb4s592OszwfMD1jhvaLfOHvh9w7eBc/Bc2ldegrfw4zbzfB9Mwl
 Qq+ULetZe73rLIQ2fgo4ZKDi661ZQb7Y0JYP166dBdz7TK6Iz0gYtoCEeNVpME1VCARq
 gkww==
X-Gm-Message-State: AOAM533i9pX+Xv/ex7HZKpy0bq7trc4v5JVgQH6bWTjlYPNtwP5tykX0
 yoaaBh2n4Yi1VKwE8bCMy18=
X-Google-Smtp-Source: ABdhPJycYkb8DR52ckldv7TrwY4CV/yLM4Tfks3V5GpYk9WyfYxcFjNYY1RlUBTifJl3nmZeT3bKCA==
X-Received: by 2002:a17:906:5509:: with SMTP id
 r9mr17282365ejp.12.1603735885382; 
 Mon, 26 Oct 2020 11:11:25 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i20sm5587769edv.96.2020.10.26.11.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 11:11:24 -0700 (PDT)
Subject: Re: [PATCH 04/15] hppa: remove bios_name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-5-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c060c37d-cd98-70b6-481a-699b8b06ad9a@amsat.org>
Date: Mon, 26 Oct 2020 19:11:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026143028.3034018-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 3:30 PM, Paolo Bonzini wrote:
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/hppa/machine.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


