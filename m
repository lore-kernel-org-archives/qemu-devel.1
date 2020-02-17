Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9620AC34027
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69739208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjkUVT6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69739208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lvF-0001Ad-LA
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3ltn-0007sw-0x
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3ltm-0004BJ-50
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:17:42 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3ltl-0004Aj-Sy
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:17:42 -0500
Received: by mail-pg1-x543.google.com with SMTP id b35so9564609pgm.13
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tdDHJAsf78GlNGq4jg61fkE/Bm5qsTDczzhj5cjsX+U=;
 b=KjkUVT6XvUIeR/yJ4DERG81evRPZGjFBPFuWvURm2xzPPbb2qkuX7Q6DrOA80TIYo5
 U/jdRtIAl3tdPQJxKjnS6oayHGu+vEWnfdSxVYoTdh/0+BLSXHSkYwkDDXt5IxG/QjKG
 5ALxooXyt0CfgTKteCytxapnpG31av/Lc61QQ9ccFRdKhCszJfAkBtwbzlsgyPEjEkRK
 7ftqb9FLh9UNMjbZNxU08aE9FJnkCG+dDJm/TQvhe4aN+o9kzrNxwmDQpeZoB9UqH9AM
 QmKLen3mtBIF+J6M0nnKZBmwmF363CAU9rE7uG11ddnBMcqG6l6fGcVpCJMaApfuPebw
 mnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tdDHJAsf78GlNGq4jg61fkE/Bm5qsTDczzhj5cjsX+U=;
 b=b+KsmzDNTz9iHRI9TvVOa/iqkY3DSHKHmaTnEvc0kWOHd8BygJioN/LSUU5ZvRzrUE
 F4eUBqvsj9R0rl+25/cUUCHU5NM1NXmsgkrzZhaCQWTo2vfsqcHGyQo/xcXGp/OPXPvL
 wNo/OnGIFRs6UNfWpHdG4LqZkXCxdnH/E9jlLvixdUndm3u/Gsgx5SWVlPYY7jObsEeR
 KSCsajEVAdSQh8TsmPgbShwgejo4UpalojmOy1/0ThnwjAEY+F1Zm3RzPTSHSZIeCNpD
 P9t1+r8dLnm8ci78lYdNLS+zN/hXkEWXfieAomKPlExBSgksFRS3NYRgYWNK3uHCNnQg
 Qxig==
X-Gm-Message-State: APjAAAXAZMXzbeKyxB7EF375M278ePEKovLHkc+/fCfx77ejeZqJGW3S
 tz66nm5XepkFfLt5BbPsOWe8Tw==
X-Google-Smtp-Source: APXvYqxZkmxp5dbSpHDnkcfr1UXJAZzVgnGXdtaGEgg/M4tVXB00XDfVnPGh7NItdtfuK74y+bmxPw==
X-Received: by 2002:a63:3e8f:: with SMTP id
 l137mr18659342pga.360.1581967060860; 
 Mon, 17 Feb 2020 11:17:40 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 u126sm1166804pfu.182.2020.02.17.11.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:17:40 -0800 (PST)
Subject: Re: [PATCH v5 29/79] arm/raspi: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-30-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <98ddecf4-2e96-3b4c-2f1d-e1c769a00862@linaro.org>
Date: Mon, 17 Feb 2020 11:17:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-30-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Andrew.Baumann@microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>     MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



