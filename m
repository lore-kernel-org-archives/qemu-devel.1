Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE06C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8AEB2083E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 21:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrzOGJAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AEB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCUXf-00073r-4h
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 17:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCUWu-0006eZ-Bm
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:06:24 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCUWs-0006wf-AS
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 17:06:23 -0400
Received: by mail-pl1-x641.google.com with SMTP id y6so2073125plk.10
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l/HNSL8YRGS37j39j0uice1uD2+LcwVkHCTKl9u7Kqo=;
 b=lrzOGJAPsNGJ1CAadyUFWubbBl6+IG4stntTHExYdxpidVxYma2a8pD7nHj3x2WFSq
 nxHub3gs0mf9UuVTQaK6aUxQmN5kDseQVwi0zEL8i8O+QXdK7p8My3E1U+HJ88T7EZjm
 KFuCzk3mbFST7kIWDuLn/KoNTMhTlakwtIOf6ZAQ8xA8i0AMH9qOYMXRV+EnWW9sc1MW
 ADtb06UPq76S/n7NSLxgsTJ3ezwHSLuI3BqZL2wzWQtILjf88G0jh9vSrri6LESRtu+h
 Iotr6pUwR8LP0sm9LA4dy8kzpgsj0GMHykydpD4mjxQfjfBWw3whmrYJtOB8zAfWlMkX
 7Duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l/HNSL8YRGS37j39j0uice1uD2+LcwVkHCTKl9u7Kqo=;
 b=cygf36ZaMjS/kdDDLXt0xkc3z0xr0xZpz6KyWH4CaI22ipn+pjVsRFr8AmyfU8eaHo
 5vqVxJLppPZu38ZbYBJZyjdZWCAzS2J8XQRlJO/pPvwF4Fw2XFtag8Yj3voE9bB7J6Qe
 ZWfCUyJDb9PmuurWNB617ysacsLUz7U78u5LyKZXCXUckKBkoEai3/O6rnXRJpmxQAjO
 5ALpEQ3Is7FWrM0nvTiRjGChr5c1H/aM2vbzdobDO58RovJM+HhUSKA6y9XkftMU7juT
 e4VoupWGxX6lRDYB3jHfaksFhco4eHvIpA0e5IelIwCV3C9EGWFB51E5aY9tmXj8+xy3
 p9qA==
X-Gm-Message-State: AOAM532eUXwOH6TEc1WHp9bJE5gekCdrcQAkYwZhrcn8fqpK0F8edcUM
 JffGc7+AAqh9sPwnHHTHubDsuw==
X-Google-Smtp-Source: ABdhPJz+vB0BhJwlrzB3Gf9154fr3ctguYCUmhGsyUYkxSnn0BV61LOYUOXyV0TrcAzb3KO7yF8iPA==
X-Received: by 2002:a17:90a:d808:: with SMTP id
 a8mr7933439pjv.127.1598821580686; 
 Sun, 30 Aug 2020 14:06:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o30sm5443166pgc.45.2020.08.30.14.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 14:06:19 -0700 (PDT)
Subject: Re: [RFC PATCH v3 26/34] Hexagon (target/hexagon) macros referenced
 in instruction semantics
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-27-git-send-email-tsimpson@quicinc.com>
 <75d5275b-76e5-38a5-f9a3-f36d1ee08c74@linaro.org>
 <BYAPR02MB4886F42C26BAEEC5CF00D0AADE500@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9ff75671-1b85-8fd1-2ee2-aeebd402f7a2@linaro.org>
Date: Sun, 30 Aug 2020 14:06:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886F42C26BAEEC5CF00D0AADE500@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.207,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 1:23 PM, Taylor Simpson wrote:
>> I think the merge stuff is a mistake.  I think you can get the semantics that
>> you want with
>>
>> probe_read(ld_addr, ld_len)
>> qemu_st(st_value, st_addr)
>> qemu_ld(ld_value, ld_addr)
>>
>> In this way, all exceptions are recognized before the store is complete, the
>> normal memory operations handle any possible overlap.
> 
> So, do this inside the helper?  Or is there a way to generate TCG code?

I was thinking TCG code, where you can look at the packet before any code gen,
and decide whether or not this situation actually applies.

The probe is a simple helper call, for which the generic machinery exists
(probe_access, probe_write, probe_read).  All you have to do is write the wrapper.

The loads and stores are, well, normal loads and stores.


r~

