Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27688C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E410B20659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaZy7Vt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E410B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEVc-0008Ti-Nb
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idEK6-00054T-0z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idEK2-0003nM-TS
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:11:08 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:45303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idEK1-0003kU-Sd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:11:06 -0500
Received: by mail-pj1-x1044.google.com with SMTP id r11so2791918pjp.12
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MDx6Qja8k9iO2iMZ0zkpjgmnKBJUVDGQqQpKdzNgrsA=;
 b=GaZy7Vt6EpQ6XIHqCbkAL9sm3S7kHuDBabX0nFt5pWlu7YWutuz/yLfelbXgDZaibe
 b7XWRPZD42XdhFzY4ivKnpIGfjH5Swsfh/VQo5Xuyq7G63ZxgSvR20Fqei2ceQ+CCO6s
 AHLxsgUO/7PpIJfZYaEGb+9MLhQg1WK/PENZLZhviQzShTaMP8BbQXGrp6VvjYjhhGKB
 lkF8LchqB6cmOtHBRq9xjW9HCpOTiyw5fvpPlCQgePnzMVyNPACUgOl8L55p/P7IiFpd
 EGprwE2I8k5K6yDtVK4pHskOqU62aHa23AqSOxwwvQz3JEMdMYEpkGSDEcXfhPuK/zH+
 SKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MDx6Qja8k9iO2iMZ0zkpjgmnKBJUVDGQqQpKdzNgrsA=;
 b=j5vL5YxLTOIbSG+rfLsfovCvn5EKDPDc3UDZ1v6PdU8OA2e8O6+lnOPUfqPEumz/rm
 2Le2DWxptnkva4roIJMPbQkL40U36LufAEGXdNz1vR9l86zsZCznMDmgIJ+nYmMfGar4
 cq1/Htr5Py8FBxEUwf0aD3QKFzeat13FhA7ES9E9HgZvxMSJUZRSopD+/lajymPEGqhv
 IGwc3aIffCVnOUwsWeCt+0TLb2lxzIRvaZWUDfhQK/PazrPv9+QtJsI3tx/LnAe/rxmH
 msdKuaPDnCJn7sAhCRZJCBXibQPWYrbKSUzfQF4EIOA0QzxcoBpTc2fCGMdIq+cxq5x1
 41OA==
X-Gm-Message-State: APjAAAXUZHO53/9awrP78aFolQBqWxPTz5rqYDEJgOqH5m465qwEz6II
 o3ALqEoz3UXKeF+Pbs0IZdo1og==
X-Google-Smtp-Source: APXvYqz5uBL/kYalrP/SD9i7AucArhvaDvenhNXhCCuT6QJAsip91SEuOvpsgrbybp8nvRgpFDLvug==
X-Received: by 2002:a17:90a:32af:: with SMTP id
 l44mr15782016pjb.48.1575641029588; 
 Fri, 06 Dec 2019 06:03:49 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q3sm17495356pfc.114.2019.12.06.06.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 06:03:48 -0800 (PST)
Subject: Re: [PATCH v5 21/22] target/arm: Add mmu indexes for tag memory
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-22-richard.henderson@linaro.org>
 <CAFEAcA8aJZRMFEpKaUN_W4U5LXoWvvzYUe0FQYwTd=RiFHeFEQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <454d686b-e453-256e-7008-a2c00ea64148@linaro.org>
Date: Fri, 6 Dec 2019 06:03:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8aJZRMFEpKaUN_W4U5LXoWvvzYUe0FQYwTd=RiFHeFEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

On 12/6/19 3:46 AM, Peter Maydell wrote:
>> +    case ARMMMUIdx_TagS:
>> +    case ARMMMUIdx_TagNS:
>> +        /* Indicate tag memory to arm_asidx_from_attrs.  */
>> +        attrs->target_tlb_bit2 = true;
>> +        break;
> 
> So here we fall through to the "handle a stage 1 lookup" code, which:
>  * sets attrs->secure
>  * sets attrs->user (always false, so we could have left it alone)
>  * skips the FCSE handling (as we're v8)
>  * skips the PMSA handling
>  * hits the regime_translation_disabled() check, which fills in
>    *phys_ptr, *prot and *page_size and returns

Exactly.

> Maybe it would be clearer if this case here just did all of that:
> 
>     case ARMMMUIdx_TagS:
>         attrs->secure = true;
>         /* fall through */
>     case ARMMMUIdx_TagNS:
>         /* Indicate tag memory to arm_asidx_from_attrs.  */
>         attrs->target_tlb_bit2 = true;
>         *phys_ptr = address;
>         *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>         *page_size = TARGET_PAGE_SIZE;
>         return 0;
> 
> Did I miss anything out?

I think that's about it.  I thought about doing exactly this.

Also, this is a better location if I ever do something about the TODO in tne
next patch, wherein I talk about mapping not from physical address but from the
normal ram's ramaddr_t, so as to
cache that mapping step as well.


r~

