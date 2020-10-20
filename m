Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132FC388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B02E2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVUDyWw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B02E2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtLO-0007mv-31
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUtID-0003fV-34
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:11:17 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUtIB-0006UR-CV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:11:16 -0400
Received: by mail-pg1-x541.google.com with SMTP id t14so1266559pgg.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=How1s8vldAjAq1q7OzxOvlrtGvGHNZfb8tzuyxAXLng=;
 b=mVUDyWw/I0khaxb18+0WuCH1i6ACW/eNgY7DZLNjHXoB1qTcvNTjLcbjtMmwWsWIl/
 IPKH+XrJWwVetWCe0tXEuZKci1EuHHkTb1OWqFcj1iyOje3MTNo4J2ghLo0JFrj6em6i
 Xd3jDkdIDw6atCZXIS66B1KcjJ4u027lrg17a43u5uysS/euknx7dHR/Ir2LLMlojK/r
 gr7AQc4JnpgL+OpDRQPvSo7FMSG6aPKZNWJjobPzLJSPSHy8zojKiiD42vT3nKo3u/ns
 z9YYAy1dNNEM9nlxCduLuTVOYe3FLTCg7aauAsvsSjuFCvnCBbdBvNpeSglQf1DcY6cR
 kJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=How1s8vldAjAq1q7OzxOvlrtGvGHNZfb8tzuyxAXLng=;
 b=tKIAuvr0bRfyjrxg9pvN4WBiNVvn/GUmxtd9lfMSaiisKNsx3sRvTFoZJ6ej3yOkqL
 tfAAPlX0mtzDW8IEBrPABpJ7QEPq8yPEndtNstQ5CeNRoGuj/P5Fu3bDBI+ciJH+QVe5
 VOo7ed+diUCM7a4jzA3NC/B6vGU/wmFxDu6HQd4i7DYK2x9/8PgiotLMJFw6P9s47uD9
 BAYlhe8jH137w8f2rNPtSeKS7XRVd7QS1Qma7QzCJsSR3BaMEuilU55FPCYb2o+anuSh
 6jRzcqtOTPoDgLjSlheYTJ081MF6DbONrkrXKdPVxyQHAd8IPONQtp1Githx2NZ8D8Yj
 BBiA==
X-Gm-Message-State: AOAM533PmpPhv3p/Qo9GJCZu+wExHAEjbMmQZ/4aBLhNptASR8A82uMc
 cSnSrEw2eUnX/RwvPAA7+zY1sBU5qfs6XQ==
X-Google-Smtp-Source: ABdhPJy4wNscz7gGaFd3ZEKl+L+XYnlxQTz2y3M1yzG73oc5L1DC9RSa/n1wLuKQDXDztetd7ELA8A==
X-Received: by 2002:a62:32c5:0:b029:158:7361:58d3 with SMTP id
 y188-20020a6232c50000b0290158736158d3mr1591111pfy.75.1603206671024; 
 Tue, 20 Oct 2020 08:11:11 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g85sm2613447pfb.4.2020.10.20.08.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 08:11:09 -0700 (PDT)
Subject: Re: [PATCH 4/4] target/s390x: Improve SUB LOGICAL WITH BORROW
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20201017022901.78425-1-richard.henderson@linaro.org>
 <20201017022901.78425-5-richard.henderson@linaro.org>
 <e2bd9942-6fe3-1570-cdc1-2cfd1519e4be@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d014021-bf0c-c2d8-fcc1-a6a66a843353@linaro.org>
Date: Tue, 20 Oct 2020 08:11:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e2bd9942-6fe3-1570-cdc1-2cfd1519e4be@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 7:17 AM, David Hildenbrand wrote:
>> +    case CC_OP_ADDU:
> 
> Can you give me a hint how we're converting the carry into a borrow?
> 
> Can we apply something similar to compute_carry()?
> 
>> +        tcg_gen_subi_i64(cc_src, cc_src, 1);

Right here: subtract one.

  carry = {1,0} -> borrow = {0,-1}

I'll add some more comments for v2.


r~

