Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B039C34026
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393E720578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhOMNygR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393E720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mHI-0002e3-Fw
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3mFd-0000NH-IT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3mFc-00089M-Lv
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:40:17 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3mFc-00088g-FC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:40:16 -0500
Received: by mail-pg1-x543.google.com with SMTP id j4so9754896pgi.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HfjpU993keNytdlm8Mj/4zy5Wh8B12M0AR8IhUKOOqk=;
 b=VhOMNygR2WuFyjbREJcwyOT1o1QSqFyhPMcUPyot0fkVitUycnc+TYtQLf0l0thZpz
 nvzjFx0fGBIn0KawX3hbU1Ah8/jOjoA9m8AcbbixQkLPkUw4DrSqRbg/YCBw8bz6NfR+
 NxJg69B1M4jcwIYvznarnTnpGpku+peJNH8ksyjPlaIxVkycY/nhCGfhyiXg9YdAzUJm
 he+ltx8OHLIx0kZi/27X9p017BRof++ElqJwijAiI8t6KCEL6Nx9KKR0NxC+EzedDIHo
 eVfOhVelGASr7e36C/RormHJnmYGPrXSae10tRtCeXwuJeQKEZJ3XNW6htPyu39Z+6h3
 zj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HfjpU993keNytdlm8Mj/4zy5Wh8B12M0AR8IhUKOOqk=;
 b=Z3Pb8t08/+/oOy+yQoWode1bqr/MGnGD+cGd13zcJ65HsV+tZQrsoV6KStBfl2zBhI
 MSfD0OZXYJcwvTrQgDf320mOL5bq6lMTftODmLUlMJSqf/AEcJje8Lvu19JRTgEshCYl
 4mTre25BpVaOnOtK/6gl+OwpDHJVz2ewP/PW5tqrvaB8FfCjOW1R9gTWe5k3aPrhtRs7
 glsf1XgLVkeu4iKIAvIZvI3ls50TlDqbrlVjBdXPVhUD5yLAjBM97FAtZNINN+Epr0w2
 LRvDk0Yp9waQxwfUOsfi4J2hzhCU/OsMTA29KIQrYZ0eDWitE8ZVqjMvp2asSdg6WMtJ
 Dy0Q==
X-Gm-Message-State: APjAAAVTuWMnaKSo0+AHZ/1izpmAvu6596awCP0NiqS3GJuV1AlnWJgB
 M0PHRvTqkEE73N8KDiwSko5I3Q==
X-Google-Smtp-Source: APXvYqwozuUsdi5QOPFjU46yLtl8S6/hKpc6MUInckibxyGMERCYitNJI6WFr0ZqwYccKY8WEk86Nw==
X-Received: by 2002:a63:591f:: with SMTP id n31mr18937257pgb.108.1581968415107; 
 Mon, 17 Feb 2020 11:40:15 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z10sm53944pgj.73.2020.02.17.11.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:40:14 -0800 (PST)
Subject: Re: [PATCH v5 68/79] ppc/virtex_ml507: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-69-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ba694eb7-bb22-dfb1-509f-c5cda8544588@linaro.org>
Date: Mon, 17 Feb 2020 11:40:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-69-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


