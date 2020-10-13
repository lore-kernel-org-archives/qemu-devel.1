Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FE5C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B06020B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5EYztbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B06020B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSTU0-00089r-FG
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 19:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSTSk-0007IS-GV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:12:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSTSa-0004KJ-Jr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:12:09 -0400
Received: by mail-pg1-x542.google.com with SMTP id y14so682345pgf.12
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UjNLcc5zisJRAiP5K13I6Eo454zrEd/6/yuNT6MH5Us=;
 b=v5EYztbCEzOVvWzlzgnRWMiHGxeLrKqhZIHKem0scReCqwY3AopCZ4rg+Ltqbd7bn/
 ANnSyEwWJPkGv0ETRk80v6zw5M0vrvddsp/TZMyq/ugM1wxhrPyHIa3iiEuzB71RZ4qR
 82kf7CEaTQ40+yOnc9BGExHRAgzt4nAH3Qn77VWH0gpikGUiJqKmLU8B+fTYEQhYPYVc
 nJITYpFHaPIZD7ydzNgtIhDGvXyxWpYu7CC0gTlMPqQgaQZz1Nki0IDsIZ2GLIVZx4R5
 a7umaRDGiFF2LG5vci55v4vD0EUpuPGpsNRBoO0RGB40zRTtM7m6KnycIDnErwaLG7kj
 L0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UjNLcc5zisJRAiP5K13I6Eo454zrEd/6/yuNT6MH5Us=;
 b=WavKXy3ukpxNxXR3JG/y1d/WIc7SqgdhaNUAl/xOY/V+KuPXmXy+CgHoNVRGSqNCaR
 dLuDqoElaydScPv1VQLR+CXC1ehzoyG2ev6Q/4mJ60Gi9eRXTb60cv/DUfaAfNMoVu9C
 UQAd5dJbHd4m8bUb4zLkljEsxLNCuPu4b1HCjV0dXTZRJD1Wul1b9OGCSmweqDgPw4x+
 gV1fRwPyRDxMgQ9RWLaBEX0UQfLgc5nQmd/xREbQbc1VZ+AmxrMzybkwYNDEmcsHTdd0
 TVvPp6AqE611oNBrSDIBx/SUsvPUw3PwtkuAAl0R8SuTwvWsKV9VKAM1xCimSjIbslew
 x1Kg==
X-Gm-Message-State: AOAM530/r+GormqFQ9wgx5QFH0Na9hHW6mjyK+D7n2ALUsjpf3Xzxaif
 ti8WP7EGr3iLJecIYmIPtOi/ow==
X-Google-Smtp-Source: ABdhPJxh0pCNQbOkZzhfwGyIOsAsRC8Ywy3wKNU+BMbU+S6MP1EH07QuFpGA48u5DOPIpGzM0OL9oA==
X-Received: by 2002:a63:e26:: with SMTP id d38mr1508542pgl.247.1602630718904; 
 Tue, 13 Oct 2020 16:11:58 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j5sm327463pjb.56.2020.10.13.16.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 16:11:58 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Victor Kamensky <kamensky@cisco.com>
References: <20201013132535.3599453-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b059e2f-b868-82b3-3d96-bd4e93d36368@linaro.org>
Date: Tue, 13 Oct 2020 16:11:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013132535.3599453-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 6:25 AM, Philippe Mathieu-Daudé wrote:
> Yocto developers have expressed interest in running MIPS32
> CPU with custom number of TLB:
> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html
> 
> Help them by making the number of TLB entries a CPU property,
> keeping our set of CPU definitions in sync with real hardware.

You mean keeping the 34kf model within qemu in sync, rather than creating a
nonsense model that doesn't exist.

Question: is this cpu parameter useful for anything else?

Because the ideal solution for a CI loop is to use one of the mips cpu models
that has the hw page table walker (CP0C3_PW).  Having qemu being able to refill
the tlb itself is massively faster.

We do not currently implement a mips cpu that has the PW.  When I downloaded
the document set in 2014, I only got the mips64-pra and neglected to get the
mips32-pra.  So I don't actually know if the PW applies to mips32.  I do know
that there's nothing in the kernel that ifdefs around it.

So:

(1) anyone know if the PW incompatible with mips32?
(2) if not, was there any mips32 hw built with PW
    that we could model?
(3) if not, would a cpu parameter to force-enable PW
    for any r2+ cpu be more useful that frobbing the
    number of tlb entries?


r~

