Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3034C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CC120707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/ZIZ8NX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CC120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixe02-00058z-Oo
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 16:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixdzR-0004fj-Nu
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixdzQ-0003fI-HW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:38:13 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixdzQ-0003Ys-8e
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:38:12 -0500
Received: by mail-pf1-x442.google.com with SMTP id k29so3985912pfp.13
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mdxohfEONQjOVEKLYnAaMlrDRr2Z9qPOiQ+uVP/XjJ4=;
 b=T/ZIZ8NXHIp+TNH7FPzKQ7OxnMYgskru5NDkKe2rawpZtepJ/j7yM1yPuCWbGleyjX
 CRgcIqvb3cN5eM49/gfTx09nJoxAG1/Pg+O9wa3wEcm1P4/XpVu+jyxbx46PlVPBrhlj
 koeGQiTbwd8JXZIpE9HPbTsXyV0I4ra6qMnfyvzRSHwPLmT1KR724Ob59hMThbM3KRzS
 lNcGfetAoRRehWQlJJM62dxx+XewZsSoWyPh0XqNXxWLJvAriBMCiYCG9vv6PGZovYyB
 g1S/4QbtrTVkfSak0ZBLHF7znLS46B+Y+zdtTVc+YkmTASz0Zjmtf+mvQJGRqVI5omvH
 UQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mdxohfEONQjOVEKLYnAaMlrDRr2Z9qPOiQ+uVP/XjJ4=;
 b=Smqf89GLRQQtLBVQJ6tWyTLW6IhBbJ9j+b2kmjbWPyfjasbAyvOc+7146Du2Cd4sJo
 SXvRKZ8hI4KSeZVpm8/NyiHCqhCm69bMdALUGuHZfW9FwYuaAMY6LNdLuy7wwwpjjy51
 J5XOjOSShDKmuAsokhkN0E65Zx5pxhCv1uavqhgfTTO5a4rnAnRHD8HHKEbxQhodpVe9
 If2HDvy58vEWe2jhzzqTKf/czeRyQh0Qto8IQbGnxWKpUd89JifctKHFh+BD5EQSFmiD
 zTwwPWPTiWk0rJPy+ea9fRt1OnowbrOH00df+BrZXOFh/WtFuGbr34fjpVDZEQDoL2Yn
 Zcfw==
X-Gm-Message-State: APjAAAU4hOnE/wDMiyrAtXNP+oCBg1dFsOYbQ4x1z5tfN4xUs1A6K6KU
 GVwHrMy3gx2fFcgP7B6LJdLO9qwLYeg=
X-Google-Smtp-Source: APXvYqzulhMNRjvEPCqxJNxxLfbpjGgYvuHfNL/aQ1nisY0JPCdpn43Eb9v45t2+GGWxSN/RuioYyQ==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr12602584pfo.114.1580506689566; 
 Fri, 31 Jan 2020 13:38:09 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y16sm11341719pfn.177.2020.01.31.13.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 13:38:08 -0800 (PST)
Subject: Re: [PATCH 10/11] target/arm: Implement ATS1E1 system registers
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
 <20191203225333.17055-11-richard.henderson@linaro.org>
 <CAFEAcA9s279rfuG3_b=7GpMwHKKF7U4vQ8sxh4wartet4pUWTQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e3ccdc0e-b856-f052-3800-038c1951f974@linaro.org>
Date: Fri, 31 Jan 2020 13:38:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9s279rfuG3_b=7GpMwHKKF7U4vQ8sxh4wartet4pUWTQ@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 5:41 AM, Peter Maydell wrote:
>>          case 1:
>> -            mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
>> +            if (ri->crm == 9 && (env->uncached_cpsr & CPSR_PAN)) {
>> +                mmu_idx = secure ? ARMMMUIdx_SE1_PAN : ARMMMUIdx_Stage1_E1_PAN;
>> +            } else {
>> +                mmu_idx = secure ? ARMMMUIdx_SE1 : ARMMMUIdx_Stage1_E1;
>> +            }
> 
> This way of writing it is fine, but just to check my understanding:
> if the CPSR_PAN bit isn't set, then will a lookup via Idx_SE1_PAN
> and a lookup via Idx_SE1 return the same results?

No.

> Or do we guarantee that we only use the _PAN versions of the indexes
> if the PAN bit is actually active?

Yes.  We enforce the PAN behaviour based on *_PAN deep within a
get_phys_addr_lpae subroutine.  See patch 8.


r~

