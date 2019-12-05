Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B775BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A17206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCuRL7FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A17206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icwli-0003vD-O8
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 14:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icwkD-0003HD-H2
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icwkC-00050r-7o
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:24:57 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icwkB-0004uV-I7
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:24:55 -0500
Received: by mail-pf1-x442.google.com with SMTP id x185so2066477pfc.5
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 11:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hGPCjxihMUhKShcKlyxjNO+KotcaAPS/t36MNL94j40=;
 b=sCuRL7FNZbTsQZUuct5ez9ifzZWjyGajs5TFVPs/77bFu1207pMfPoGnNZoMpv8Jux
 F03/9NTrZ3ZT5R46NN9y76rTJKRuMTnU0Qu3YAD5JF8c/c4WuN1etVYR76lz2fJmBoS0
 mqZnM4n8EJP2pY4Wh/Kyz42XxEj4T0SEFMfBNbS6rSZNuU07SIRa8E5PRdHLp5HcEGKw
 jBgyc4kjWxzVvqdlIqrQvI97pvee1aezsSgF/SvOcmnarzItthIvAPFrFZNq14SDs1nP
 HQHoQSZ+MFZ0ZA3isDdOgVQS8Vs9v737DAj6JIzA7C/34sXNGO/gf9Sq9pinmFtpcOx/
 ewgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hGPCjxihMUhKShcKlyxjNO+KotcaAPS/t36MNL94j40=;
 b=YsT7WztVBO3gmw1Js1P/yORzgD3T500/CFOmc3VuppsLYQZWA9eo3uQXROdpPS6w2T
 YeqG8KHK77n1UPlu0n+TnSya5WOPvyzV5onXm+zmH11Z9x+2+rynrPBf1txVGghCzeUv
 MTRzU7VlhbZzRcRyBv/bpPC7Rby1MoBIFcJlN87nBoa0I+7Rf+cr0FMOQNHFOSZh2Hle
 9R1xmyTaw680pdq1trzMJ5PRiEo5eP9TFnkqGlovfXRGYGzQGAOZHHtUZC12LYew/EuZ
 hdCM/Fn+CP8Nm6LqeL/AGWaUM4rmrAbomqBU51FmTBjixuBwZ4w7k2al6Qpljcg11jzi
 cVOw==
X-Gm-Message-State: APjAAAXsXuAOfCp/bv0RKpcMdxCez22S9nsPVXjy5ox7gH6LxsBZMRpc
 u9RJBsLOzNdYlwRW73wlcNZk5g==
X-Google-Smtp-Source: APXvYqwa2JsImEpiPb1m2YgHmy9qu9dIPjnjWlmq7Bg7buy+yDAv99C8WudrjKFlTgvckeGfA8sNvA==
X-Received: by 2002:a65:5307:: with SMTP id m7mr11219160pgq.113.1575573893805; 
 Thu, 05 Dec 2019 11:24:53 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k16sm14110816pfh.97.2019.12.05.11.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 11:24:52 -0800 (PST)
Subject: Re: [PATCH v5 20/22] target/arm: Create tagged ram when MTE is enabled
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-21-richard.henderson@linaro.org>
 <CAFEAcA93AX9nikuqq9M1jZOxv1a7QJZpiocHnn=n-gSbsGBS7w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bcc3ff61-e737-2af2-5c0d-a6062cbaf083@linaro.org>
Date: Thu, 5 Dec 2019 11:24:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA93AX9nikuqq9M1jZOxv1a7QJZpiocHnn=n-gSbsGBS7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

On 12/5/19 10:40 AM, Peter Maydell wrote:
>> +         * If it is, we must allocate the ram to back that up.
>> +         */
>> +        if (object_property_find(cpuobj, "tag-memory", NULL)) {
>> +            if (!tag_sysmem) {
>> +                tag_sysmem = g_new(MemoryRegion, 1);
>> +                memory_region_init(tag_sysmem, OBJECT(machine),
>> +                                   "tag-memory", UINT64_MAX / 32);
>> +
>> +                if (vms->secure) {
>> +                    secure_tag_sysmem = g_new(MemoryRegion, 1);
>> +                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
>> +                                       "secure-tag-memory", UINT64_MAX / 32);
>> +
>> +                    /* As with ram, secure-tag takes precedence over tag.  */
>> +                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
>> +                                                        tag_sysmem, -1);
>> +                }
>> +            }
> 
> Are there really separate S and NS tag RAMs?

Implementation defined, I believe.  As with everything about tag storage, it
would seem.  But since there are separate S and NS normal RAMS, I create
separate tag spaces to match.


r~

