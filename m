Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2101C34024
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81480207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5uF0suH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81480207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lVQ-0001eG-Kv
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lSV-0007VF-2S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lSU-0003tE-4u
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:49:31 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lST-0003t1-VP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:49:30 -0500
Received: by mail-pl1-x644.google.com with SMTP id ay11so7087528plb.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d7wx//9bio1NixrMm+gElquZt1ZCR0KIC7aC+r3c0y0=;
 b=P5uF0suHVA+C4aq71f6rK/O2H4+w45Qx3P3ONmctUQ0eKd9zSWyvzXjaaxvNnQC/yM
 5HYR3FO3dbmF27ISQSVT8bn48OkALJGEnjwY5D7pMVvICG40wTP7veMo/V7ipdkYBkau
 g5oRgeVbbQwi9VZku3Gt5nD6iAhCHawCXASfeiNvxAcaXB/Wqz9Yw1JtOxx2ayCVtxNh
 OYzxCYE9Pj0XYdcTz5eBg0thSFH+TJnkl1826eGsqMZGjRZlOiAobnU6dhjgy/ZlYsGH
 PPRuhtW57w1mofKN+QmvWhzuFeyZ69gL6XgwrcZg0q8NP8ylL886oqwQc54Rh0JVBtDJ
 NL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d7wx//9bio1NixrMm+gElquZt1ZCR0KIC7aC+r3c0y0=;
 b=raAQbwIfLlk/iwI56m7CZ7DdDNMIL6VwqYaos9YgBw4Aiwqk4vBpLqt20qd+zfKqjy
 9jcGRcT1ueexeSAjFUEwthttNETvvwMU5Q18f6XzgotF+bS70ZWXAqdMZXaEubqlIUBX
 lI4FRP5NUSycJ0lHBPaVgPVaeBVcue+egAo8DAZCKi6y4j8vb3mGUsgs7zJ70CqzVOI4
 Cd9EJnlckbRTEA2L8ageTpG6Bo6Spnp105gAD1HCK//t4YSof6hBs069gFXmZO0L7yc/
 ZxajegCK1GfE2lMEcMDcqOGkOURjc7dMgUk6Aq4/Rco2Ztd0ny2t9Ey1WIuqYcaUnF7t
 TCHg==
X-Gm-Message-State: APjAAAUEfx5JYjJG3u284j0ndzRn2DCUHfawSL2mbe12KUZNYQjlLcqg
 s0jcnpj56nMLGOtyM1aY0/dgGx5Gv7M=
X-Google-Smtp-Source: APXvYqxTJKSdMPZFrTY1lt4jI0unyU0B5enC1WUP3TsKe1g15qcAfZ5KLMhhxXFjnwEo697MIpIvKA==
X-Received: by 2002:a17:902:bb93:: with SMTP id
 m19mr17665820pls.310.1581965368974; 
 Mon, 17 Feb 2020 10:49:28 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 b25sm1162006pfo.38.2020.02.17.10.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:49:28 -0800 (PST)
Subject: Re: [PATCH v5 11/79] arm/collie: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-12-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <451b9506-20f7-c264-0352-4802e71fc72e@linaro.org>
Date: Mon, 17 Feb 2020 10:49:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-12-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> PS:
>  - while at it add check for user supplied RAM size and error
>    out if it mismatches board expected value.
>  - introduce RAM_ADDR_UFMT to avoid build errors on 32-bit hosts
>    when specifying format string for ram_addr_t type
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
> v2:
>   * fix format string causing build failure on 32-bit host
>     (Philippe Mathieu-Daudé <philmd@redhat.com>)
> v3:
>   * instead of RAM_ADDR_UFMT adding use size_to_str()
>      Philippe Mathieu-Daudé <philmd@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

