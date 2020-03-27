Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010AAC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 23:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF48120717
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 23:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urKI1jAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF48120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHybt-00042R-U6
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 19:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHybD-0003cX-2e
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHybB-00017C-Ly
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:41:14 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHybB-00016n-Aj
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:41:13 -0400
Received: by mail-pg1-x544.google.com with SMTP id 142so5337986pgf.11
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qeG8tHPoyBQGtuBGURzuRjGYY2ia9ii7TOQ/sAHBbTM=;
 b=urKI1jAq+l83+vWomL9VN1UlPZAmIvg6bAWOFMDGwhsKXswBnjyIogeKX8VxgtRPww
 wuWAgh1uz/xY5ye/cFvykfecDh3iR1QiYyAoXVHYF1e8IWuUasBn7zVbabJe7OBbs91u
 2nN0WrYMYz2KFATZjYRVlBvH/8oIwMt+h4EhlK7Dg4WAb/6vxWQQoDdy3Fz8YiWU3SI/
 GR6N2b4k9z4Dn10IOOrzVc+nL1J982OOm70w0zgNQedYv7xuwTW5Pt2ZVxju/cLMMIdD
 MmlRBQUyexbezpjg6sv9S+k/x9ylK7ZvRBZiKlGSvIsw3IAIvlezEmbS2T2QYh460cQB
 Amaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qeG8tHPoyBQGtuBGURzuRjGYY2ia9ii7TOQ/sAHBbTM=;
 b=mhdGAMRuKRo0mABJuuwMkyEZR45ryS9N/WRClf37sC4V33hCdPptq5vH+s9iRn0wcG
 fYFwX7s2ImToWI3nC9APjmQPKBxVTLfgv8A6+HEtu1XA0ctNxF9M1wFHza32XNP9axlC
 NIcma4CZBYG2X2P3V3PC8FFNBr9GLf84ZpsZizv9G0aEm62SghgcOU1f+BWAOBdpiwk7
 3GbS/UbiNbXeT4lWa3QQM1gOPYKViNcrnZOKR1iBSYYRW/GWBuPtSEYDzdawjJIskscl
 /LeDgMzTMr2Z3wghWrTPi4wuSU3ftCpHQMAtnRPZY7Q0leYPa6HVcC2m4FkWoafYCFdd
 1vKg==
X-Gm-Message-State: ANhLgQ0ZwSFwR+ryb3JbDGjB6ll1+xsXNC99pTkumpIYmkFUZSNXpZl3
 yVUjA5xx17L+nwnwtVVKQA0UkQ==
X-Google-Smtp-Source: ADFU+vuHbYpcAfh36gAuZ5ByiiHY7rwDzIVoSRpE4dmgiuzpGEl9Xo4PHOg9MFZSBnQvSoTClMi5Mw==
X-Received: by 2002:a63:a361:: with SMTP id v33mr1756798pgn.324.1585352472053; 
 Fri, 27 Mar 2020 16:41:12 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id h4sm4709852pgk.72.2020.03.27.16.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 16:41:10 -0700 (PDT)
Subject: Re: [PATCH v6 05/61] target/riscv: add an internals.h header
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-6-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07377f49-ff91-a6ed-3021-a20bb77ecb7a@linaro.org>
Date: Fri, 27 Mar 2020 16:41:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-6-zhiwei_liu@c-sky.com>
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 8:05 AM, LIU Zhiwei wrote:
> The internals.h keeps things that are not relevant to the actual architecture,
> only to the implementation, separate.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/internals.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 target/riscv/internals.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

