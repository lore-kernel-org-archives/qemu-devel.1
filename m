Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FEBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8E22087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKVS6dK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8E22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOdh-0005uu-Oj
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGOd1-0005Un-04
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:36:51 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGOcz-0001j9-0g
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:36:50 -0400
Received: by mail-pg1-x544.google.com with SMTP id m5so4421056pgj.9
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+NphFAz+bbbGOLPoViKWvapYAGN08JtmjYnLzZIKOxo=;
 b=GKVS6dK77bx/0jZLujlXrhsPEnEfKJjffubPbjyONPpDBt8aKV+/WikhO98lFUcqBg
 fknNlKQUgg0UcuMI4rvH6oQicx7azui4MD9+lZC8HzP87Vi4TbpnL5wsy+KtaRvsh2LC
 56er56VCnPG1cwnDpL+FZu4sdinoEO6m0lag595MpAp4J3HgJxKTp/ftgfAClZ5xpG9e
 IGh4od5fDmnNKVRLqhekiwgA0ji4hW/l6rP7Ub0rdSacgB+QsToPnSt5fJEOro/bh0y5
 tfWDEo6mZ+GCGnCsbnFxd4FHFyfq+MjpuaQe3PdZTqbmYXIk7DHpN7njMs/8y0p1rs/E
 iOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+NphFAz+bbbGOLPoViKWvapYAGN08JtmjYnLzZIKOxo=;
 b=ZzFt6290lsEhjrd7hevjaVUgS4rzkUbH5BAgnfmFQ/5ES5psbBkjh95DX3ONjg2WXg
 X+Bv6NU2ITHfEm4iAkaQ/uP96kmL1nL6djynxrKNF2QxIY+vqcDaPAiOS9mBzMBtMWLo
 S+Pe3zK3PZvBfQ+A+nzotTtOlXEt4l5CjwKkHhFun9/rUJTNLih1Cm1IrwRZchmq0+hU
 i4xBEOQR7lx/p2C71hPM4B1YVbU2Z+jEBxT/yVIKIGOrumYmDPDklsu9EfeKk2obRlqI
 lkKmNUoomuUakacQBW1e9CwZdStQR/P7+pBmFW6YyCkdamuBnsuZLBd7Q/pnwUyQe+VW
 O+Tw==
X-Gm-Message-State: AOAM532tlNHQ53LCkyLbURudCKezM0/J+/2FWy6YgNTNsDuUEG20/AHg
 J7w5s6s4vpwK18upbLBHBpWQoQ==
X-Google-Smtp-Source: ABdhPJxIZ4y5XTc4IrXUnrqP73HVFyQx7PSmSplY3yEEr1jJKnjEfVZhyGyxvSD2g5MX5wlOI8kPiA==
X-Received: by 2002:aa7:8bd4:0:b029:13c:1611:6538 with SMTP id
 s20-20020aa78bd40000b029013c16116538mr6137309pfd.10.1599752207202; 
 Thu, 10 Sep 2020 08:36:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s187sm6690150pfc.134.2020.09.10.08.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 08:36:46 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To: Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20200904160018.29481-1-steven.price@arm.com>
 <8e661984-70bc-790c-8636-39dcd8b00131@linaro.org>
 <842807ac-562a-36ce-8061-aa323341b605@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6043c5c-4bf1-e42c-1337-a892e6fd7402@linaro.org>
Date: Thu, 10 Sep 2020 08:36:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <842807ac-562a-36ce-8061-aa323341b605@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.576,
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <Peter.Maydell@arm.com>, Haibo Xu <Haibo.Xu@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, linux-kernel@vger.kernel.org,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 3:24 AM, Steven Price wrote:
> It is a shame, however I suspect this is because to use those instructions you
> need to know the block size held in GMID_EL1. And at least in theory that could
> vary between CPUs.

Which is no different from having to read DCZID_EL0 in order to implement
memset, in my opinion.  But, whatever.


> When we have some real hardware it would be worth profiling this. At the moment
> I've no idea whether the kernel entry overhead would make such an interface
> useful from a performance perspective or not.

Yep.


r~

