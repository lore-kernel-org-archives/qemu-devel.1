Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0450EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C461520781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOPhTvm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C461520781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5um6-0001FB-Ut
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ujm-0007Zd-A7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:40:30 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:44905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ujh-0003lA-Qf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:40:30 -0400
Received: by mail-pg1-x533.google.com with SMTP id m34so1398599pgl.11
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J7dNLV60rejtTxHVsRr+GYTyxBbI122oQu32kcp48dA=;
 b=gOPhTvm1aJr5D+dzCrakVQHBNjwRXsr1un1sMd7JiIqKqW00owCsE61Kp/Vh7MiDqb
 OGpVgpjGhEAVf716J+QUVyCDy674JHjNGPsQ1hd9gFqF6QTdGeZLYW/zR3aZdtWxBdH5
 mZy/RcE+cZYwLWlYVTDaxvCGYDg5RHLys8magleIvQBqrUzPE1nuCOGL25yKht8uUPZ9
 v92WnIC9NvXoLetaHXGKtY5+SHkv04VLkBbXr4HysbW/FyPLod6V7rHyrrhmi59ti2yk
 4BuGpZ8XqdSksqRjmX5j7s4H19oIrbn7bTlCgaIZ2ZNwwRqSQtR+5SXyxlFbeIXSz5f9
 kgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J7dNLV60rejtTxHVsRr+GYTyxBbI122oQu32kcp48dA=;
 b=cFd6XBOKyNiANsQksLG6BCnBdy/P5K2C8MSSoDUZmjfq9Sp6nO4r+JaBvqMbSvhdlS
 J7K66RIVlT7Jus3jIwZTRlDhiL7KP30qtBvfwsbMl7UST44ERJjewcCQ9zkozRrUT+Xq
 qbq383jiT1SIi5IdDnwLvyzM1EyGSxDtgZS/y9tQoZBxZY2K6NAQr4zH7e4s61poSVut
 pHSbyQ7RssCratnKUqykvD8cSOIV8oDDJ36aHGRvlRMOORq9KI7wFUD0Nm/JONcbnRto
 t+aoPsgWG1J/vVfC0p04+IRPo7JMma2IFmupfy7FTOmi4BdskyrqAYi1bYF67q/fdgcb
 /NbQ==
X-Gm-Message-State: AOAM532uVvgU5vaJoVJflM/4CXwNcfxJfs1AJEZLgh9crqGqgZ2nHRAz
 90DS5b+GFpWPRtrwSeXjBTuivw==
X-Google-Smtp-Source: ABdhPJzgOI2Njm3a4HCuq5tG7UEesjrBfMda4T4q74sZ46olmTewp37ya3Rq1UNw8UGI2TJeSkaxFg==
X-Received: by 2002:a63:4450:: with SMTP id t16mr223898pgk.3.1597254024354;
 Wed, 12 Aug 2020 10:40:24 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2917978pgb.23.2020.08.12.10.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:40:23 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 3/3] hw/clock: Only propagate clock changes if the
 clock is changed
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200806123858.30058-1-f4bug@amsat.org>
 <20200806123858.30058-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0203ff2-6284-b5a4-7c31-92f639910ef3@linaro.org>
Date: Wed, 12 Aug 2020 10:40:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806123858.30058-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 5:38 AM, Philippe Mathieu-Daudé wrote:
> Avoid propagating the clock change when the clock does not change.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/clock.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

