Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E2C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67672464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0JW6vvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67672464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEhc-0004ZW-V0
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idENY-0000JC-SE
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idENX-0008WS-M7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:14:44 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idENX-0008VD-Dk
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:14:43 -0500
Received: by mail-pf1-x443.google.com with SMTP id s18so3416213pfm.4
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nJ3Ty/hziDCgTO/SCbkDbEcjoRLOPPW5sJ3nnbViC+Q=;
 b=J0JW6vvSXD/EiBndUYVjjeDnd6O/kiE19EKi/U4mByJ+0DjF3TXyLxl7ggZr0Y2Pli
 HIHUe8W8BrWNJGHta8aqatQsQStJV2xYUC50ZA3Lcdm0CJaSSzWoJvg06OsuxcADvuNV
 L2NAR1krBb3CUvdAGHTz6pflbjvS2CZbwci6eazXIIxQAHrcJj084iO1IRM5dPuPfJs2
 Xm6RfAKnQZNxUJ4IKwwh4vYUP/0+prjnHAoAogIZJ745ryxrckzm0i2eleJfNjESCRpL
 Td66N/F2o5BdBADf3cHkkgI/2OAjQWjTfT1O3hAv6+VNkYEp+RkAdm9Kl/7hlia7ESEX
 7iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nJ3Ty/hziDCgTO/SCbkDbEcjoRLOPPW5sJ3nnbViC+Q=;
 b=oFpQZ5TZlr+Ip4kFPugNe3MAJ0cJSMbCc1rGL0Kx9Ns/GY3IpQApofkdnVW66o3p+5
 +fe9ebP/p29FaHxsNLr8FE307CwAgq3EGUJif4G3bEnsmJ3sodOpCRum8KpZJv6Ll6Ar
 xvWG4/xcdRUzbSWv6xlVtr9iRGXITbW0+6UyXoaaqYJkzB/lsVJzhcm2rpOnsVtD8Q5i
 jVFtIEzeT3dne9aTBk6Ogpoz0Ij1htjd0I1Qh4I1dSImYIUplpCTMlCp0rFXkVe1rM58
 a3HvDQwJBBmlPpqpUN7AD5UeAp0nJ5uoRhMWENm9afI8Zt+zmsgMe6s/MDyllP0tzC0i
 +RfA==
X-Gm-Message-State: APjAAAVmpglyMSLtnJQaj0hcNhF0uXQsu1Z/35Ez5Jyq1Q5iydc0bYgE
 4Y4gwblnqP28//yf6wWBS45Akg==
X-Google-Smtp-Source: APXvYqw2VUCUqiDrh0YcV3Nfd4Ek4u6fuowiGYaF6ikD90eoixb9AIIrgUW4b6V2htGh5FutXd0VCQ==
X-Received: by 2002:a62:bd08:: with SMTP id a8mr14542107pff.84.1575641682271; 
 Fri, 06 Dec 2019 06:14:42 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q12sm10864147pfh.158.2019.12.06.06.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 06:14:41 -0800 (PST)
Subject: Re: [PATCH v5 22/22] target/arm: Add allocation tag storage for
 system mode
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-23-richard.henderson@linaro.org>
 <CAFEAcA8AaCOBKSgVrpMxAiEGN0+JmJjJtMY-=M4ed06SAoe69g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da1cbc50-e2a1-c51a-82c3-3fcdba75e13f@linaro.org>
Date: Fri, 6 Dec 2019 06:14:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8AaCOBKSgVrpMxAiEGN0+JmJjJtMY-=M4ed06SAoe69g@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 5:02 AM, Peter Maydell wrote:
>> +    /*
>> +     * Find the physical address for the virtual access.
>> +     *
>> +     * TODO: It should be possible to have the tag mmu_idx map
>> +     * from main memory ram_addr to tag memory host address.
>> +     * that would allow this lookup step to be cached as well.
>> +     */
>> +    section = iotlb_to_section(cs, iotlbentry->addr, iotlbentry->attrs);
>> +    physaddr = ((iotlbentry->addr & TARGET_PAGE_MASK) + ptr
>> +                + section->offset_within_address_space
>> +                - section->offset_within_region);
> 
> I'm surprised that going from vaddr to (physaddr, attrs) requires
> this much effort, it seems like the kind of thing we would
> already have a function to do.

There are very few places that need to talk about the actual physical address.
 Mostly because that doesn't mean much within qemu -- physical address within
which address space?  Usually we want the ramaddr_t (which is a sort of
combination of pa + as), or the host address, or the device the exists at the
pa + as.

>> +    /*
>> +     * FIXME: Get access length and type so that we can use
>> +     * probe_access, so that pages are marked dirty for migration.
>> +     */
>> +    return tlb_vaddr_to_host(env, tag_physaddr, MMU_DATA_LOAD, mmu_idx);
> 
> Hmm, does that mean that a setup with MemTag is not migratable?
> If so, we should at least install a migration-blocker for CPUs
> in that configuration.

It probably does as written.  I intend to fix this properly before final.


r~

