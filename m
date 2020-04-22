Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCADC38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADED5206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="serzzMeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADED5206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR6py-0001Sc-T9
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR6os-0000uc-GL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR6oq-0000kO-Ka
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:17:06 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR6op-0000Oz-Sq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:17:04 -0400
Received: by mail-pl1-x643.google.com with SMTP id n24so406139plp.13
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r0r79z2+nHaVF1DxyvosXpCQZ6Jr5rWQhT/IjvDPz4I=;
 b=serzzMeGhqQZmOQ2t1vtrzrIrG0kKyBSeUcGTAvh27MxIDlO7RV1PwLXMblQI76ufO
 Lkjsw3PmJS4KDCQLQCsjUflFu0KYAsOnebkCAgrFF7DguMXipxrssT39ytmZH85hlrxJ
 01FFLN34mr88jjGX7i6hqucgjIjo0U2P+YSquvfof27ECIQQXGTD+uy/x/mZJsT11hAr
 4vI0NOw+5hVTZokWuA5v0dSKlNBmaVFGpS5orYeWO6xcgxN0NtvZu3WULNVPqhzp7bmW
 smyHZhfHLYgOJE+RQFMzwkd1aKCXY0BDGdJO61jzPnjgSPyah136xsqpsi/vuEH+BmCg
 IZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r0r79z2+nHaVF1DxyvosXpCQZ6Jr5rWQhT/IjvDPz4I=;
 b=Agzlxlapjm7m8TUHHghqG3xf6FASysn4u4aslULiyDHMdxRXVjmdsHiVmTR+6Hm7EF
 GzOOG8KqfGRmZLpBWYnOmCgHQKkv2LheHpYHvlB89V90cX9U2HweP0VEphjtAWbzmyer
 5gD3eayiSAUxsGeIlvQNALZ3sZupzO5SWUS8UnIsH52SJ4TVXAdOPS7PG72pgQG+a7os
 E6ProIzimmoX533JSTlJLlHpguMgwM4GexaWpIN1MVTM/X4QbvP3jRGpak6i+Uyo2CuC
 GujZyN3HI5wKJc1oTVhC1+lCoh/npCGcwqIAE/mAhAsTKuZaLYu3FY7hEMOq2zhNnLFl
 F2MA==
X-Gm-Message-State: AGi0Pub673V5wPElkWZgITC+36oRvDBu7Yqo/3Rwsykv8VubfwVn4/FR
 zI9vE+2RtqLb0CAsE+hGNoB/Ug==
X-Google-Smtp-Source: APiQypK5+At1qq3Ibyfmj/gfHCR7szpnadgM+ZFGZky3UUV44gUSzgz3AmjIIINgVfNbQhXbQTu3Nw==
X-Received: by 2002:a17:90a:37c4:: with SMTP id
 v62mr6536388pjb.177.1587529021721; 
 Tue, 21 Apr 2020 21:17:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d20sm3912113pjs.12.2020.04.21.21.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2020 21:17:00 -0700 (PDT)
Subject: Re: [PATCH 4/6] target/arm/cpu: Use ARRAY_SIZE() to iterate over
 ARMCPUInfo[]
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200421131926.12116-1-philmd@redhat.com>
 <20200421131926.12116-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7e4ef1af-64bf-9eed-6a57-8aff5e67a5ef@linaro.org>
Date: Tue, 21 Apr 2020 21:16:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421131926.12116-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 6:19 AM, Philippe Mathieu-Daudé wrote:
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/cpu.c   | 8 +++-----
>  target/arm/cpu64.c | 8 +++-----
>  2 files changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

