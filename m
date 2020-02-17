Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23832C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C4120836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFM2GHRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lvR-0001UI-20
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3luC-0008Kd-VK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3luC-0004R8-0w
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:18:08 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3luB-0004QZ-R7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:18:07 -0500
Received: by mail-pf1-x441.google.com with SMTP id y73so9413563pfg.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0JXBjTsj59hubbgQEw+E94ZUzjwM8GP16u5Yl6V3o6I=;
 b=GFM2GHROdF+Fs77boh6u1194hdj4vIStinPl6dK4fQSzJeJ411iPd+/RnYFh/aB/kV
 EXmmTFr5wiQUn5qKzc/ylYhMs21Y0AF3NKhOdB8zZl7CzilmTDO0ZNoiNSYVLOhj5dsh
 LTP3RqlMaSDzOWUN51xlfLNUtWj2BX89CGa4an7YDDRPuzgpc5RCsLPLIZtcicRb5gwx
 FkgtuDTLkdEpgs147im5WGf+18HjTCzxmdkmi1W0tT2G4/VTyu7Ttq51qI45wjUN7Kps
 f66aRdnPIboL9/i0vtXKGSd2/7nul7pabflqPwn3q6KFrVMbWpDu2PrWFzQWnfSYIdKt
 +QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0JXBjTsj59hubbgQEw+E94ZUzjwM8GP16u5Yl6V3o6I=;
 b=sR93zCGU2lKTy6mx/bEniBXXGedpBTWXySs/xMYprg9Gt4EuBpNVfllTg4LAAN6xsD
 51xZQVkV8JNDXN70p2zIGA4KNNgifEBhutiaRgatwhgvhR+Z4WJ716KPU5QU0cM8iTe+
 YA5MJjGT+KVcYQh1kUqtNxVNRfnEhAC3oPwgEIpcEPFGVInVbSTZe1wS7IuW9e54W6GI
 h8Z0bdCahLIh1VtOR2nEIlV8++S6DUBAA6P8flDJFvB2Vlkis5FEj2nACPOKsb6bZP5p
 uyU9FfarF4OyPhg+Ca/1LkdZ8ja5+YMeD/OHsuK2hQMAxayrrlmuR8aEEqLj69WkIw3X
 314Q==
X-Gm-Message-State: APjAAAU9z9wkj64W2QvH0ZRKLvr+ZXADDUsd0AD6oA/rkIWLNbX5aHf1
 L8kxzr5guhuVdlS+Y10Vk+rWfDGjj/g=
X-Google-Smtp-Source: APXvYqxzn5HxG0ZzSKLz49Rd7HbARBdCtkUp3p9on9mpQU18ltzCVZ9f5Nm5c1Jox/NfDdKO/DVGXw==
X-Received: by 2002:a63:d003:: with SMTP id z3mr18452688pgf.448.1581967086859; 
 Mon, 17 Feb 2020 11:18:06 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 188sm1679856pgf.24.2020.02.17.11.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:18:06 -0800 (PST)
Subject: Re: [PATCH v5 30/79] arm/sbsa-ref: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-31-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca8dca93-1d7d-1163-83fe-71adf2771a27@linaro.org>
Date: Mon, 17 Feb 2020 11:18:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-31-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, radoslaw.biernacki@linaro.org,
 leif.lindholm@linaro.org
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
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



