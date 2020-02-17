Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2B3C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C941520637
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXqjSzi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C941520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m9T-00076A-Re
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m8K-0005Ze-Cy
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:32:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m8J-0004rk-9V
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:32:44 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m8I-0004rA-PB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:32:42 -0500
Received: by mail-pf1-x443.google.com with SMTP id 4so9411223pfz.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6K0fLeUCdjVsOzMfr+p4W+4kA8q4NQnenhV460crDkc=;
 b=BXqjSzi0UvcPJo6PyscwDhJWsktWmRf2MEx1fZLEbwS789H6jTTA2zrDIkwg1pJFll
 upcrnXwTMCoVwy6agBwl/Mic/F7Zot10tNHEDB7kXjTRsEs9gPVA4nqqs+t6Znu2z16v
 JpsfMLskUpeAoj+qR2ebnaSSus57GIkKKX1V2Yh3fuRPpT3/VnQxJm73BgZEPEsa0rjd
 8aJzEPVklagmd2hkUBUQ8EJpUfJP0nWXJLU1FltVkirnpHtFvI3yAl53T7Q2sy6hQTmZ
 yuOllOUbDogas/qyDsr3fTJcWdi98SteK6sp1XW06JjWEQWHTnoSgPjIvtgkNo3/ohoN
 IjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6K0fLeUCdjVsOzMfr+p4W+4kA8q4NQnenhV460crDkc=;
 b=U+LUtvuhHJulvHsYNExW7D0SaupRiO4TE60vf02k1n829Zv9P7oYBu1UpmXUEvYVSh
 4UN1t7ZkQZ3fBpbo2Do5D8M0nMibJuVXg2ZBxkdurm2IulYgfqaR9Updxv1SRt9Fuwyi
 WsOvVClxVAQUp3B4iLcQ6jXCR8qTLmdTZhT4Jk6ll9J85gH0xoMFVWTiO5b2leAzOswo
 pipPSvfU69uXUkOjoB5dhYwR5mbiOq5YD8mpkWsRT/qdW5XcH00YB7rLKdxHUeD6WbNp
 DRHz3BZ43dN2QuK7+3BDJdSCplxriL0rUcB7a/MLPHMzGdarEO3Tlfj8gMddzB9bWsZm
 qkjw==
X-Gm-Message-State: APjAAAVLGO78T0b2PydljRCDp7PA+1HRUxBvrdCR/4yTKvxBtMI2Mh7V
 de5eMhFvlJ4BV2lfosbp8xaQ0w==
X-Google-Smtp-Source: APXvYqyk5IDPc0y0B3WXscITWEw0Cbt81MPzb9B8Ek1ArnAUaaKmJIRw/xqReKMhS4jzY+68++ZlBQ==
X-Received: by 2002:a17:90a:1951:: with SMTP id
 17mr651684pjh.101.1581967961766; 
 Mon, 17 Feb 2020 11:32:41 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 t189sm102461pfd.168.2020.02.17.11.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:32:41 -0800 (PST)
Subject: Re: [PATCH v5 60/79] ppc/mac_newworld: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-61-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f7d27694-7136-0698-bc82-23b89eb91ef1@linaro.org>
Date: Mon, 17 Feb 2020 11:32:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-61-imammedo@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


