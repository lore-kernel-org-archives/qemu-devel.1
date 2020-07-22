Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F75C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23B4207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGj20X/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23B4207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI0l-0003Z6-W2
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyI0C-00037J-KE
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:53:56 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:46586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyI0A-0001pm-V8
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:53:56 -0400
Received: by mail-pg1-x535.google.com with SMTP id s189so1581442pgc.13
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v02qBny/fBifeAWxA7VPDDvDbBoPApIkv4BMUuzXBqg=;
 b=LGj20X/siigpsn0RhYNdZVGP3MeKLD5+yU0se0y64yQkOmnsQ4zgH6dNqnmIzsqsxw
 Q2c4UCDw5ARGwkyxjA5q/m/2KIA2uBVsfR++ctz47TK5VYnbpmraKY4osv++bB6fiQBl
 n/1R6DjhYW5ITvb0le1Kgh3T8jCMdwNtmkHg71SqOejUmHtwWb5A06hsGGHE467FOWWS
 1pLdLKUmGVQ6XHOrpccjAL83ooEg8jdeKy9LjBodxk8kVOAb/9AanaFhxnjLz8fNDVzT
 neLIXWe+Sq/kzavgWChE/90+pAgDKVQZfHzU3gU9qN1ER0pNEM8ybI7aaB6gf4RYqORd
 8pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v02qBny/fBifeAWxA7VPDDvDbBoPApIkv4BMUuzXBqg=;
 b=lVlfsJGy5K2wSubIj2zliXfpn0KY/skzjlbeJgGVKBUVZoCQUDggTx+0OKT+z/4Ivw
 HoR0auNSyOOcF9itclnjrpHCqvlQOinuxzxLsXsMW3xgRiVqFuuM40AeGD3GgCLSLv4W
 glsfPrmp+MFAEQhPpebhiolKbrJXy9B8dcdjr1hVgeYqN3CHCw5Ok2crWhgwWZZt8sZx
 IBFW/UXMeYB26q6I/Iynt7kPEAnoy1rtypIpmjBUcB0Z+9vGmvTFo03LgFwOpqcEbfvq
 jybBDkbLl49BoP8dn1L7IVF3hURxfhFSkcPWSxVy1XGD059AssmCY/tj847Ghzok5aUD
 cteA==
X-Gm-Message-State: AOAM533Rmu5DLBLdbdDJ2Khi879TalGXG8EEuAHDobAhH7PXFcQLP7J/
 HaFxF2fUIcU+t3HlMXuDhQDf9Q==
X-Google-Smtp-Source: ABdhPJwuorP8VaPy5ozHNAS3P0FRtqgThvj8LRe9CB6Z5Nv0iss2iKrRxZzXLDCytLaFq/B+4B0vHg==
X-Received: by 2002:a63:4543:: with SMTP id u3mr610129pgk.398.1595436832805;
 Wed, 22 Jul 2020 09:53:52 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 137sm123506pgg.72.2020.07.22.09.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:53:52 -0700 (PDT)
Subject: Re: [RFC v2 10/76] target/riscv: rvv-0.9: add translation-time vector
 context status
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-11-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8bb5342f-fafb-cf31-d478-d0d61f18239f@linaro.org>
Date: Wed, 22 Jul 2020 09:53:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-11-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 69 ++++++++++++++++++++-----
>  target/riscv/translate.c                | 33 ++++++++++++
>  2 files changed, 90 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


