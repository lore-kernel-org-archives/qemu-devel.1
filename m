Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E016BC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E8F2187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vd7zadIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E8F2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irs12-0000jP-SC
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 18:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irs0Q-0000Bw-3U
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irs0O-0007NB-G7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:23:21 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irs0O-0007MV-8S
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:23:20 -0500
Received: by mail-pf1-x443.google.com with SMTP id 62so2602213pfu.11
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uWlpig+/u/56qnvw1fmKkFAok1AE4OSKikBk5iGXPk8=;
 b=Vd7zadIJwAF+/rO6PdzkiHwUkV8jkF9S4/iBOn5kBvF5LlyOPnWsHhXZwNkGztikEZ
 WkkkR7ncljFNIYYqlMmTdw8VpgoAdLzDEqoPZAxM891sLdbpH7GQXSiKcnJhcmeLv7Un
 3XEWgPgSsVxmFzeR0yqxURtVOhk5GPc20Hx67BldagK448SBcPOVPRhP4p/S9piwrYp0
 JbhqhSLMaaGskMJgCsjSxnbS05oTKkCswabSPi7eSDJdTJaTm2UEPaal4P1vzjzzcQYD
 mAeikI0k6h/kcWPNz9USdvwlRDOG76/+gtrBlcnPVYcqQY12QxljfNB0TwFbg0IHCSTQ
 FM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uWlpig+/u/56qnvw1fmKkFAok1AE4OSKikBk5iGXPk8=;
 b=oF/sDJi/Y21Iz4fEeNkS1NEhR8lUXGuCi8tnsgeqTLiuBNXjFvybte+vvPGtR9Mggi
 jFNVAQLFJ7058KQZkaFbS2bzTLH7AOlSkxMRTvhxVdZmmv1RJfznEa1yoDXjDV18TiD3
 vKx36A0fSs697zS77SH9BnlySBhI+seBhURc7zqX/1vaNueI4gVFmBf/1+Gcie5r9QuO
 aOkX9iy5t925glNVYp96ARfLSF/W+25Pmbj6V84dE8iEOJHkxwXj8JV3s26lAKkHTPJV
 BJLvnxv1c3u5FmaOj7Cyux/Gm9ppv8ioQ1lkGumzUg8tWCDa3u6V2N1+g1r3ebOg1z3F
 +ejA==
X-Gm-Message-State: APjAAAVgv3lVtK4SYCKARe2EwG0EJjckMtM5RBGKjfsBa3Qip1cYKlj3
 4c3fTt9yV6vbAXzZN6+Fb1huVRX6dwE=
X-Google-Smtp-Source: APXvYqxmtmFWKZ6qOgEN18ehgyRZooQ2mRsuVDPec6iK/Z+88Nb8rKfiYVXXoW0ZcPz1bjpIXMC67g==
X-Received: by 2002:a63:5243:: with SMTP id s3mr34578143pgl.449.1579130598686; 
 Wed, 15 Jan 2020 15:23:18 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id j5sm23437690pfn.180.2020.01.15.15.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 15:23:17 -0800 (PST)
Subject: Re: [PATCH v2 00/86] refactor main RAM allocation to use hostmem
 backend
To: Igor Mammedov <imammedo@redhat.com>, no-reply@patchew.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <157910661287.7467.969397900495856191@37313f22b938>
 <20200115180957.74ccc5f4@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17773280-0acd-95e0-b8fd-a8ec8e5e524a@linaro.org>
Date: Wed, 15 Jan 2020 13:23:14 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115180957.74ccc5f4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 7:09 AM, Igor Mammedov wrote:
> On Wed, 15 Jan 2020 08:43:33 -0800 (PST)
> no-reply@patchew.org wrote:
> 
>> Patchew URL: https://patchew.org/QEMU/1579100861-73692-1-git-send-email-imammedo@redhat.com/
>>
>>
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
> [...]
> 
>> 6/86 Checking commit b9b1823833a3 (alpha:dp264: use memdev for RAM)
>> ERROR: spaces required around that '*' (ctx:WxV)
>> #30: FILE: hw/alpha/alpha_sys.h:14:
>> +PCIBus *typhoon_init(MemoryRegion *, ISABus **, qemu_irq *, AlphaCPU *[4],
> 
> patch keeps the same style that was used in original code
> I can rewrite it on the next respin to mach current codestyle 

False positive.  The script doesn't understand pointers well, and it's
triggering the rule for multiplication.


r~

