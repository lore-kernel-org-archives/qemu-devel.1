Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA1EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 02:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCF4214D8
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 02:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVfohEoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCF4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPd2j-0004nx-1d
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 22:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPd0R-0003yn-6o
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 22:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPd0O-0006QJ-9g
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 22:14:53 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPd0M-00064z-Rs
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 22:14:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id 2so1989337pgp.11
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 19:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VLmJVVq29tBgzf1IpTYg4RT+apdN1fHpXJQ10TTYBpw=;
 b=qVfohEoNUyqt8veriBpI+x2Q9Rvtn87OYA8J/gCGHntjRe/pUpqUZ/4aU1IapDBAGJ
 llBDHCslo8MgSO7yoBtufqOWu0j2ax3nSHz7EVurDuobjKBYpYWnrtFS/B0vRcyd4a1g
 r7id2sM+2twDWZzO/Io7azjw3OFgDLCy5quJqwoUhWNR3rBIyV1Wr/bbB5n3s5Q28K3S
 vAqk+T/qCqdD6+13C2PDtsFomDPYqhcqWhuxPrfcBdMhNV5lhqICeKvEzAesKULDN1w9
 xtiFvms3WZ7phZdYXQjVJ1kBOY1tbO+yz7Ejj/VBx0lpFqevgpGtBHy/+ieYRP1W+MtI
 ceHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VLmJVVq29tBgzf1IpTYg4RT+apdN1fHpXJQ10TTYBpw=;
 b=LjeY4S0LDlufR3xgtj2sV09z8NB9E+gMuFHABsf4KoF3E7GKPSEH4ZkjDJjWmp3097
 r9PRGVoJ1WuqafXPHnwtTRLwIKxSgkX7BlwoTtyEIZ3RO3uXxSTn1Sa0vzE+P6Tl9nXB
 p3xe0ng2VZvzaxmGV64k9+rIlg3/yIk3JJNuSD0VIOi7oYBiT26o/y8N4I6Kly9+J7gZ
 aWVVYARgLagfbY8gu1Cyi3VdSJOBxm5GDA32VaozfKjES3JYuqUa/RXuFTGV+sZxKzQw
 Qk3+XpSpcJzY3R6zg6GwkB4f6QQZWfhAsq49vcQ2VjU4UChK1+c5gpsg7qRn4sIJP85b
 ccMQ==
X-Gm-Message-State: AGi0Pub7ICyNRE+rpd3rT29Ex2ux3QuhNx+j7raiys2uNSuyEZUXpbic
 wyFUvbT9e50WcP41s2JxA3RuHg==
X-Google-Smtp-Source: APiQypKX9f3IZSFRDIXdZ61xYVAWWA2U5vGJaEAGr0QbX81m+I+Lc1WzGvRHpLY5SaaKguNqMksjQA==
X-Received: by 2002:a63:de41:: with SMTP id y1mr5846590pgi.176.1587176087154; 
 Fri, 17 Apr 2020 19:14:47 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w13sm5791059pfn.192.2020.04.17.19.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 19:14:46 -0700 (PDT)
Subject: Re: [PATCH 03/16] exec: Add cpu_probe_watchpoint
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-4-richard.henderson@linaro.org>
 <CAFEAcA97saZB=8qbHxfJiNWXN4F916-ZqjaLt=-fzUzKcNmUFg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5581beac-5912-f5a2-fe6d-4b23f1c35133@linaro.org>
Date: Fri, 17 Apr 2020 19:14:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA97saZB=8qbHxfJiNWXN4F916-ZqjaLt=-fzUzKcNmUFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 5:08 AM, Peter Maydell wrote:
>>  void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>>                            MemTxAttrs attrs, int flags, uintptr_t ra);
>> +bool cpu_probe_watchpoint(CPUState *cpu, vaddr addr, vaddr len, int flags);
> 
> Could we have a doc comment for the new function?
> 
>>  int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);

Hah.  In the process of doing that, I notice that
cpu_watchpoint_address_matches actually does what I want.

I have added documentation for cpu_check_watchpoint and
cpu_watchpoint_address_matches and have dropped this new function.

> Clearly the insn emulation needs to do the right thing for
> guest architectural watchpoints, but should a gdb watchpoint
> also affect no-fault-load behaviour? I suppose making them
> both behave the same way is probably the least-surprising choice.

In both cases we need to interrupt the execution in order to actually honor the
watchpoint.  So yes, treating them the same seems the only reasonable way.


r~

