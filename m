Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EC9C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 23:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFAE2073B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 23:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLr4I8ZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFAE2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHxyl-0004dx-Td
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 19:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHxxv-0004DA-I5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHxxt-0005D2-Ux
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:00:39 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHxxt-0005CW-LC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:00:37 -0400
Received: by mail-pg1-x544.google.com with SMTP id a32so5302859pga.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aHqHkNfgmNh5RGhZ/6vfllNu1NYNMJPBQraWadnFqCk=;
 b=lLr4I8ZSMYNUS/txs8govnqlWJMChHxOIKjywpTiwUq8GHb2cg8JpOQTnsBEsEJORJ
 QDtIBeiOWZhJfKkjjq+t6c13/Gx8aBjPYBQab1SIwWPFkLb8CWRAOFxRxBO1vprOHH3W
 zPokN91BaGsejKYsoqLmN2BsmIv2BCMVsn705FyaApevjx+1V7N0Hh1a93QDKfwmWanp
 Wwm2mE80GZAV9G1Ijd5LOhhq45MbetM4q/+GQBAQcVMoN3DGXHBtotW3EssbkWgfWVD8
 72b59QhEBxVOULKsmCe9ATaIn4HteHxgXQf/Tm93qyoaDWA/Ad35FMGsfFSrdCA6dtW9
 +3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aHqHkNfgmNh5RGhZ/6vfllNu1NYNMJPBQraWadnFqCk=;
 b=QZy+3ij/EaaF86VdV/+1XGRHMP5KdPwFIndyUtKHdSQKRGb2ynwo4yDoP0PdW8Qh7j
 a5qZWoDoXJNGk8uCmycbVs4d6RQQMTsv9caayvEsqGxahcn72xupG8MZvai49uy9efbp
 XhZZH1yCc2MwUa5O6PytyTwdw2JZSXFRYeQL4fsiWDplrKA09xiz12vCR8pL0G8A/9ON
 jHmqPloYtogixBw2dPY/ciiSuqWfPiS5aHI6eMEU/qLQ9k11rsc8MGKaYoOYsj/ZSh7Y
 LO38ev+9zNvwRSmgj4YKco8m3Nx+P+w9KtNppdfgRQLgusJ+MEt9a4t/JIoeODDRGYS7
 GavA==
X-Gm-Message-State: ANhLgQ3v0vUrisqbEOz8jpztQ5v2cV+gHlOB82/7/kRLupFO+aGCLHr2
 6wsVwvBgCb5RpPMhenqC3ZBXiw==
X-Google-Smtp-Source: ADFU+vu7W2rXVHH+AJKigIOrkuPQ1Wzav51yX2s2KtX/TBRSD5Zg+h9J97Cmt31OzH2rqe689nJlSg==
X-Received: by 2002:aa7:9f94:: with SMTP id z20mr1448402pfr.261.1585350036412; 
 Fri, 27 Mar 2020 16:00:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id b24sm4917336pfi.52.2020.03.27.16.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 16:00:35 -0700 (PDT)
Subject: Re: [PATCH] qemu-user: fix build with LLVM lld 10
To: Laurent Vivier <laurent@vivier.eu>, Roger Pau Monne
 <roger.pau@citrix.com>, qemu-devel@nongnu.org
References: <20200326134316.36059-1-roger.pau@citrix.com>
 <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
 <4ec0e5b6-9ee5-f26e-8f2c-1c1812d6fc07@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b98f5b0e-a556-f091-03d0-4daca4c9c498@linaro.org>
Date: Fri, 27 Mar 2020 16:00:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4ec0e5b6-9ee5-f26e-8f2c-1c1812d6fc07@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Dimitry Andric <dim@FreeBSD.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 3:51 AM, Laurent Vivier wrote:
>> The Plan is still to drop this whole section of code.
>>
>> However, it's still blocked on getting the x86_64 vsyscall patches upstream.
> 
> Richard,
> 
> will you propose another fix to fix build with LLVM lld 10?

Sent.

r~

