Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F60C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF8C2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S70OHjnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF8C2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kang5-0004Gt-00
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kandz-0001Px-V1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:22:13 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kandx-0004M5-EK
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 17:22:11 -0500
Received: by mail-pg1-x543.google.com with SMTP id u4so2332614pgr.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 14:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=23Fy7c7tAAjfwjZBgIzYkXnGwZNlzZJx7NP87jTryoE=;
 b=S70OHjnTvg2/PFKak4FrWOmgka/Gg1YbwRhPLsv1qA1YZbDReVkAbJACfTlzLSCX1V
 Dwg3pUe0L9KyCYAUxW7A2WwKpDlZ0eA4yg0s3R1wSPJvO7MwewKUkK8gkG3/C0Je+tSk
 b3hr2UlQ2/7mMTNrEdivbaJKIr65EQG4IQP7qLAzxUtCXW2dx5QtF8HR1zEr6w7fPY/X
 WruhbW5wUpvdXFycRnJ+LhgL6GCbvnDNu6r4WItYsZtUyhi2/ifUCWHwfbg5/Lv8dzpP
 3fe2akYrGe2jCNTwj9BGeYSuzfEAgrFa/eRxnqpeamy6MLcIWB7hbQxrg0lHpWgw+jwi
 x0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=23Fy7c7tAAjfwjZBgIzYkXnGwZNlzZJx7NP87jTryoE=;
 b=dqD//1ZsA2a2sypTkGoS7dkzv303w8uIZQ101b/1hwmOmbmq0DwK7HTvLyrPhHfgje
 0R/HbWGuRUrVZhzt4QFHi8r2bFposZDe74ycMJJhS/2yeTstU4ZEHU/twDj833ZtB1fL
 C8x3PBzYaytgtl7JWz/6Bf8qghssTcf75UvlLXhXviK0YbRJmdJUXc5PP7e70C9qOUtV
 RVhubKfsxa4JD7B/U/WBSpam0jYatst9k3U8tPfVWF//FzwHjqP9qngCBj1srzR1p1wY
 MCXNe9NJ1mUbvJq3aGdSW3RJflkblLPm19HVuQcKU+Jxd18pcZ7uBq4cwwvmDhvLJyu2
 Y8BA==
X-Gm-Message-State: AOAM533aJU5zQX1LXXhMmLrv5WNm6cAlZpE6qOjqUqQ/XeFD+28efCCU
 zsu9xpGvAJfuBEQ6l77SvU5J3A==
X-Google-Smtp-Source: ABdhPJwJwlJDjicR+aWocSaBfTGsbo0/e8oXM0cpVPOaE9volWkCsUHY7MznRxcJitQdkUP732jfMg==
X-Received: by 2002:aa7:908d:0:b029:15f:d774:584 with SMTP id
 i13-20020aa7908d0000b029015fd7740584mr4581792pfa.6.1604614927214; 
 Thu, 05 Nov 2020 14:22:07 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id k4sm3099007pfg.130.2020.11.05.14.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 14:22:06 -0800 (PST)
Subject: Re: [PATCH for-5.2 2/3] linux-user/sparc: Correct set/get_context
 handling of fp and i7
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201105212314.9628-1-peter.maydell@linaro.org>
 <20201105212314.9628-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f95a1975-2fe1-5ece-56d5-3f226cb6ad98@linaro.org>
Date: Thu, 5 Nov 2020 14:22:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105212314.9628-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 1:23 PM, Peter Maydell wrote:
> Because QEMU's user-mode emulation just directly accesses guest CPU
> state, for SPARC the guest register window state is not the same in
> the sparc64_get_context() and sparc64_set_context() functions as it
> is for the real kernel's versions of those functions.  Specifically,
> for the kernel it has saved the user space state such that the O*
> registers go into a pt_regs struct as UREG_I*, and the I* registers
> have been spilled onto the userspace stack.  For QEMU, we haven't
> done that, so the guest's O* registers are still in WREG_O* and the
> I* registers in WREG_I*.
> 
> The code was already accessing the O* registers correctly for QEMU,
> but had copied the kernel code for accessing the I* registers off the
> userspace stack.  Replace this with direct accesses to fp and i7 in
> the CPU state, and add a comment explaining why we differ from the
> kernel code here.
> 
> This fix is sufficient to get bash to a shell prompt.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm really pretty unsure about our handling of SPARC register
> windows here. This fix works, but should we instead be
> ensuring that the flush_windows() call cpu_loop() does
> before handling this trap has written the I* regs to the
> stack ???
> ---

Ach, I was so close to being right the last time I tried to clean up this code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

