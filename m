Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0239FC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC9620706
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRjA3G8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC9620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRIfd-0004Cb-Rz
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRIed-0003Fk-3P
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRIec-0008QF-B1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:55:18 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jRIeb-0008L1-SY
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:55:17 -0400
Received: by mail-pg1-x543.google.com with SMTP id n16so1380416pgb.7
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VotDWNtk6pbmIEHR6x8tcsh4l5Uvdj5q5RNLJQshEvo=;
 b=LRjA3G8GvjDdEIn+GXm1uhq/rFV9HqPMHGya9ukOI9BouYpskeJgecCV0sULwfq3jB
 xkGvbtplLGfe+RyWeU87/vvdoZ1zzD3G/6eX5nEYaKDRsUnWkIWzqdK8sqb/DYTOKWRH
 vWImSI81tq5WLQCGFE32jumMiCRWcMhKHH/XsMcZu6r2EqbKxPpidGStiFMVDDJf/6LH
 tKRfGTmKfKscykL0IZHzX7rXD19Y18V4UCrSn+mcNlMhOw4xvLHqMesIytw35WhxAWZ8
 MsF2aXgB1GHTpN1XUGz+F3QI0HK2E1e8385lBdCYRTeygnuB35VZ0GQr9vjYdjwxpNHr
 DgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VotDWNtk6pbmIEHR6x8tcsh4l5Uvdj5q5RNLJQshEvo=;
 b=Qsu//ljjkiD/wI1e63vD9AHswpW17KH/+g/Ct6ecje1OviMhVM0+b/AXAy2YxPhgNu
 XrNIdxq9grpIxmoICzvyDwag5Fbal3FR2mvmprT2ql4B11CJi6WP6qK4enWo6OvfrTH9
 gc6FvhRXyo+HYES+sQxA6OiO8jJ7ebcteYMJeybp8eS7RtCrW2SURfaGIareIQ9cmQMa
 kSrRglf1k7Gu0m5Z9uEHlusijm0bIYecWv4YhHvCVyogqXCYqonz2Z6LWcIWvpC1Uupj
 Xw984iQ9gH9Il0Ci5w+X6Uj8IKOh/CSHw2gQ9MBMubv/te5jhlY9ayK6D+xhIeH/BcdR
 WzGQ==
X-Gm-Message-State: AGi0PuaGGIAL0vnwwgzfyYnDEfkUDqATkaekV3c6Amwc4SZrd2745Zq5
 z/+4evQLjbJfatwHB6l+qibnx8iMWXA=
X-Google-Smtp-Source: APiQypJS8U8/Y1NZpC9ur7JcPMc6MOgE6jwdkfqdcumNLDklox4aE8sXSZCPLHAJmrXZtgS64YvKag==
X-Received: by 2002:aa7:969b:: with SMTP id f27mr26850561pfk.116.1587574515701; 
 Wed, 22 Apr 2020 09:55:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y2sm8068pfq.16.2020.04.22.09.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 09:55:15 -0700 (PDT)
Subject: Re: [PATCH v2 11/36] tcg: Introduce TYPE_CONST temporaries
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-12-richard.henderson@linaro.org>
 <87pnbzczxs.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf797079-ccd5-0517-4c5e-05f8ca13743b@linaro.org>
Date: Wed, 22 Apr 2020 09:55:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87pnbzczxs.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 8:17 AM, Alex Bennée wrote:
>>  static inline bool temp_readonly(TCGTemp *ts)
>>  {
>> -    return ts->kind == TEMP_FIXED;
>> +    return ts->kind >= TEMP_FIXED;
> 
> I should have clarified in the previous patch - TEMP_FIXED is a fixed
> value, e.g. env or other internal pointer which we won't be overwriting
> or otherwise trashing anywhere in the block?

Correct.  Only env, actually.  There are (currently) no other internal pointers
that are fixed.


r~

