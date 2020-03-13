Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FD6C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 05:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FAD206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 05:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzdIMajM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FAD206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCcr0-0008CH-8I
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 01:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCcpw-0007kq-P8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 01:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCcpv-0004gx-Kz
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 01:26:20 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCcpv-0004fA-DG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 01:26:19 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ca13so3707373pjb.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 22:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+e4fyTDy0r9KzAFfSiWr6DhKCoTvO7zjWFgRj7An7YQ=;
 b=PzdIMajMaby/N9WxVfihw1viCtJ4LpuMMhd0qnhD7fCFwS+kw+T2TPOPxdUkfgRwzk
 c9T3+e8YQwP6CT5K/kD/EHLvwR/qLqtwJttI9foZiq80qkmbq+i9xX9USVcZEYxZg/ew
 kC9hN8uTa4FzOIl0tgX5T62yep3syMQI/O8rrWSLJhhrtgBWRAV7CD5bXorFyOCfaIrX
 4XEv5xAiZaNT8PS6heOEnaiXJvbNG92nQ/6ShlcoL9GOLyTYIGUgPLCFeMlgO1r4cCos
 iW9JuNuSy+ZWCKm6ga8erbgZiIC4KWPbpUFMjnBcxb0m308pniZyK6zrK+QdO4igc8xI
 yLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+e4fyTDy0r9KzAFfSiWr6DhKCoTvO7zjWFgRj7An7YQ=;
 b=jUbaBj6iCyX6VQlxWb9Qru5V1ILJeaj/I886/ylMeOgiPRA6jW9blFRP3Gnmx3oaDc
 w3tfGTaOw4TGM46subSAxzQuowckz9fyk6kH9XTSM+M9PgkE5HIHZm0Rrm3gGebB4KFE
 /ybgmiED9U55lPz/CpFb7hZGDhZRfO4mbOxq+9NPwqXcfNGYF3Du9o4N1lc8zXg7RdFA
 vczQy7o3zvYPl+huloFbhyCJkUkxMfp8XwjnN4EdC3aU4lX1wwdrt7IiUJyF1b1xOeq9
 GRASlfcum6xZxzJJibf+2qR0qNHSPcB/wR1sToS3fGXaGgG9WQVFPGvGULHOsfrMVCLo
 nhfQ==
X-Gm-Message-State: ANhLgQ0fqu+QEwLdt6Ca4+iexWnnKhrBfz5Q8F8ncrDkTezzuIhmC9MA
 c0LZPUE4zEfLvFpPVUUOFbkAlA==
X-Google-Smtp-Source: ADFU+vuWX8zs/99Ab7pYAT0ImUYzl5YtT4f5xYcMUKY9HwI0YsALMcvlAnOa56GibgU9iMyJb/wFzA==
X-Received: by 2002:a17:90a:d103:: with SMTP id
 l3mr7984625pju.116.1584077178258; 
 Thu, 12 Mar 2020 22:26:18 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 ep10sm10467049pjb.26.2020.03.12.22.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2020 22:26:17 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] target/riscv: Don't set write permissions on dirty
 PTEs
To: Alistair Francis <alistair23@gmail.com>
References: <c827880a47774cd3a6bcd59b79657f380da11d5d.1583284602.git.alistair.francis@wdc.com>
 <e8498727-03f8-7e04-efd3-c04763dcbfac@linaro.org>
 <CAKmqyKOnb+CpnugoUkeL_kabyiCfZCmWyNF9uV5GUBT_pek=0g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <47b0bc38-6384-9ab4-7c3e-d5ed405ea90d@linaro.org>
Date: Thu, 12 Mar 2020 22:26:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOnb+CpnugoUkeL_kabyiCfZCmWyNF9uV5GUBT_pek=0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 3:10 PM, Alistair Francis wrote:
>> I still think this must be a guest (or nested guest) bug related to clearing
>> PTE bits and failing to flush the TLB properly.
> 
> It think so as well now. I have changed the Linux guest and Hypervisor
> to be very aggressive with flushing but still can't get guest user
> space working. I'll keep digging and see if I can figure out what's
> going on.
> 
>>
>> I don't see how it could be a qemu tlb flushing bug.  The only primitive,
>> sfence.vma, is quite heavy-handed and explicitly local to the thread.
> 
> Yes, both sfence and hfence flush all TLBs, so that doesn't seem to be
> the problem.

Here's an idea: change the tlb_flush() calls to tlb_flush_all_cpus_synced().

If that works, it suggests a guest interprocessor interrupt bug in the tlb
shoot-down.


r~

