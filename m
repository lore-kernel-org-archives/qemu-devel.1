Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679DC34026
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B233A208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTQEvp0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B233A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3luJ-00081n-GU
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3ltJ-00075w-Hd
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3ltI-0003ng-IH
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:17:13 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3ltI-0003l1-Bk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:17:12 -0500
Received: by mail-pg1-x542.google.com with SMTP id v23so6313961pgk.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nsvyWFFXLa3MvO9lgB8JS5BzAvrBpok/ikXE3YfspBc=;
 b=OTQEvp0z3D9sC8RbnGN/SsT7XfV2mNkYRqAF6ABNOPUy5WuMJHnanUZzbs/SKtZgrq
 /PillB2ONGmY7VcA5VRMkVwWF3Q4nvNaX7FiY4U7f0G1lDJtu7MjAA00xhED+tWX3kxE
 4vLTiu5mg15yBiSdCtZDzEdGz7gIOZLibwwMFDDDjc4MZ6MrtEJDbqQcRFGaqoe7JDmJ
 jEnqY5LFayAIkT7ema6fwG5vTuBvBf/7akQBWl1BrA0hZNY2lC0Te0pLmEm3fl3JuLPq
 pBj3OoCgYoYt0qdSEsjTySLlJ2dQuHHayKbVhHRJfoS6hSW/21pPkdLSDIehyLnM/pFJ
 lkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nsvyWFFXLa3MvO9lgB8JS5BzAvrBpok/ikXE3YfspBc=;
 b=uO56PeQ++QWryi8+SX7Jep+U9jVAna+wb0Rw2LH7lg8HwSbvMHKjuVZp2MeQb5ONCe
 nKdPrLsk4r8TZg/grnOgQM4468GTMLYRkVLQ9AobsFHvBmhGRTSwIu50HnF+u/uvvGSf
 DWmay/v5/pF5kMhBCbk6Qz+gJcZCirsQRhBLWIn2QYQckdRDXVvVbmzd0tTYycDagO8d
 aoXFLPU6z1O0JpzjmKVO4UjFnwBWFTfe/OCQx6FJ0W5xW5cmepY/WlyWp1ST+A5N+wdB
 JZ3FoMlBKepouGB8zzEf98nIKXAyBV1ppgNgP8kvKRaDD9JGbupeCWmviA7EcRUVtsV4
 dYzA==
X-Gm-Message-State: APjAAAU+YcPHTa8G3lRig7wOUvyTTpCkTyx9HUGkq3DqU5n5zxim7oo0
 +NOOuYO/0sihkvgUOIJPr5jV3w==
X-Google-Smtp-Source: APXvYqyYqAHG4lDwHh7QVdIm3lrl2T9tk4nt1fuMr/H6L8Eq4W0y7y6zsQJkGp6yBlJkTm+N7aaWZw==
X-Received: by 2002:a63:38b:: with SMTP id 133mr19004137pgd.153.1581967031373; 
 Mon, 17 Feb 2020 11:17:11 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g2sm1712714pgj.45.2020.02.17.11.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:17:10 -0800 (PST)
Subject: Re: [PATCH v5 28/79] arm/sabrelite: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-29-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b731a8e8-e275-7397-ec61-22e3359ca087@linaro.org>
Date: Mon, 17 Feb 2020 11:17:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-29-imammedo@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jcd@tribudubois.net
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
> PS:
>  remove no longer needed IMX6Sabrelite
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



