Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D43C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 04:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E00B20739
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 04:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJXlrRjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E00B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCFd1-00028W-8Z
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 00:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCFcH-0001dO-Ut
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 00:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCFcG-0000Nj-VZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 00:38:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCFcG-0000Mv-OY
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 00:38:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id w3so2135819plz.5
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 21:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BPruapG5gkRbwPfWuXzqL/1TOcvgyX/vSJbSLtZKK5w=;
 b=iJXlrRjVQE2EKiA2R9VAb9bUhs8PkPkF7Pup4DzVvkXWkTMTVeqZvt5+6W8rOcbLNb
 /eXcYdzwVFnVT/4YEUC8q2zHAKslbDp1Rh2+iwmlpeW68uxjRD0+yMQAFsG5LiPjNI+M
 6WNSYposoa+CHbvyta58HskcPVwAJljQ209/AKCYc7M+jMgnJLXsw92+T1E+Qd9Wh9g7
 5LHag7dDVbK3BS7L4xFIBsHbYwyrd78G+EiZTRgCYtgLfYFETKEpRg1MnC2O7CkaaAs8
 ykMHOWLIds8OsXm77+JUIi0FQlBsaomwZtxzNUoy696Dz8kAIxiNTtQ405DlD3r1tQi7
 qyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BPruapG5gkRbwPfWuXzqL/1TOcvgyX/vSJbSLtZKK5w=;
 b=sk8jcXQ7Kj+HIKqKk3mRGItxbCkSbdbT3DDQwnKRFRwy6irlYrA2mTbKBTON3Td8DG
 km4K879Y0gQR6DKn4WIUHqVmeMLwrvr4Hc8NYhEaGXOCrYeMiYEwBIUWOjz7wDkdpUbv
 DZqqy2xJT3bDLoXFNnUpln9gTHENvMJJEmRV/oQtpouz7x7GnGjV9ErsfQyomMqlYA5c
 MRUD+6+EsjFVYqib5xdaqALqGL2JDP0JOEBlMR6sq2nemKlgf0yfOUL7owAHoNukq8Mn
 PHdpauD/bYwHkUIxx1hPBOBehLdxQXZDNaFKi6bM5lIMt0dUSnPs+h7QpyR14kPMJqi3
 JbHg==
X-Gm-Message-State: ANhLgQ2F2KuKSCOGghxYPmS5HlAPsuu89ihOVrhru3o4sN5VqIYuvwq9
 24HT8MWB7JcVx++rq43f5Lsgug==
X-Google-Smtp-Source: ADFU+vs/XghBeZg1QDfhxCmcWrB5DWYm8uO2l26iWep1oqiRTW3QBbWX3nUm2bTt4XMbk0zOc6oR/A==
X-Received: by 2002:a17:902:9890:: with SMTP id
 s16mr6007662plp.71.1583987919419; 
 Wed, 11 Mar 2020 21:38:39 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y125sm2205770pfy.195.2020.03.11.21.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 21:38:38 -0700 (PDT)
Subject: Re: [PATCH 02/16] accel/tcg: Add probe_access_flags
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-3-richard.henderson@linaro.org>
Message-ID: <9d7cd2d0-298b-74a1-94e7-cd6889627c6e@linaro.org>
Date: Wed, 11 Mar 2020 21:38:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311064420.30606-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/10/20 11:44 PM, Richard Henderson wrote:
> +int probe_access_flags(CPUArchState *env, target_ulong addr,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool nonfault, void **phost, uintptr_t retaddr)
> +{
> +    void *host;
> +    int flags;
> +
> +    flags = probe_access_internal(env, addr, 0, access_type, mmu_idx,
> +                                  nonfault, &host, retaddr);

Bug here.  Should have passed along phost to probe_access_internal instead of a
new local host variable.

I've sent a v2 for this patch, in-reply-to.  I'll not repost the whole patch
set until I've also addressed any review.


r~

