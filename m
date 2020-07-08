Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D7FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B35A206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XItcPYYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B35A206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCP5-00036J-GQ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCNO-0002QG-Ng
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:52:50 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCNN-0008DI-1C
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:52:50 -0400
Received: by mail-pg1-x542.google.com with SMTP id j19so14999576pgm.11
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x2NpFGtIE0NPSb36NbBkhctLucscDV376PCm5f06N4o=;
 b=XItcPYYplol16Xi2uVyyHhDz1ox/f87BGyQ4ahgUjwKogefqFxGnofx99Bbwy6WYhT
 bj+dK1YrGmGhOxYd7+CCRDcSo7e4mqfvZTicqP3t7Q3IYE55AlxveOusaBsZrnXJN3S4
 3WorV6aHHSpwm6HAXFP36pFQlRtLEgs9YNqsOYgOWcko6cnrmWQoQB7Whdpy2+IF06rS
 dry7sSgIR/2xGK8T4zn8pjySBTBZjDl1K7zOGHVVWJ+wiVe5XNW03mBR9245TbOlfUD0
 ZtE4D9G70f0GLH0NZfSaPhvZXMHZjadtBkgD38iK8KU5pmw5TD75HmbHFIPrmaNdEIWA
 SCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x2NpFGtIE0NPSb36NbBkhctLucscDV376PCm5f06N4o=;
 b=X29/eSxRV0/3POKO5kIqQoarhQ41t9CW7MQuSrjpdupvNqaEVG4O7m5ayueSqybkDv
 jv/sVqWwXIzjcEOAZcHJq+y41Ascow47oqFxxA2y+KL1xgyB2wRB17WuDzX9+h6v0qiJ
 oBw8r8vT1vUC9VLcwC8nn/9T5oZYiESpQNDG+Dkt3r+lOpuy8X8fmwG5hXteG7NSmb09
 KidSNEFQgeNQqtp4zD43t2p0sxLgblZDbFJvys+UeqsHyjWPl3OpG7dwDsQPvKRjxzAH
 R8IcF6W8IEakXe9r5GqUDWxnjhEXYTYWRsB4UHz2IXizP17B0e77jy1Y8BKG/h1GFANg
 ACQg==
X-Gm-Message-State: AOAM531rBCIfdxWsTdK/F6n73bcySjzF9NzRqPzEnqxxrMJXpPMBvrq6
 dMHxdpL9jC55zVYoxEKfQPLvaA==
X-Google-Smtp-Source: ABdhPJyWOEKr1DiBTff9lJwA41/dgbN1yWjcCXstahiFeTArgEvFJonVbg8Fw8hgUNYtJCL1dkBGrA==
X-Received: by 2002:a62:2546:: with SMTP id l67mr15392496pfl.154.1594223567274; 
 Wed, 08 Jul 2020 08:52:47 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id u14sm247836pfk.211.2020.07.08.08.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 08:52:46 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] linux-user: fix print_syscall_err() when syscall
 returned value is negative
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200708152435.706070-1-laurent@vivier.eu>
 <20200708152435.706070-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91f28ac2-c3be-7088-db8a-6bad60fc2c1f@linaro.org>
Date: Wed, 8 Jul 2020 08:52:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708152435.706070-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 8:24 AM, Laurent Vivier wrote:
> -static void
> +static bool
>  print_syscall_err(abi_long ret)
>  {
> -    const char *errstr = NULL;
> +    const char *errstr;
>  
>      qemu_log(" = ");
>      if (ret < 0) {

This should be a target-specific test.

E.g. on most asm-generic I'm pretty sure this should be

    if ((abi_ulong)ret > -(abi_ulong)512)

whereas for Alpha it should be

    /*
     * Syscall writes 0 to V0 to bypass error check, similar
     * to how this is handled internal to Linux kernel.
     */
    if (ret < 0 && env->ir[IR_V0] != 0)


r~

