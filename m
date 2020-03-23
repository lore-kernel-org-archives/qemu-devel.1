Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC33C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4E920714
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnnpKquo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4E920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRB6-0004q2-Fj
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRAB-0004HB-Hf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRAA-0007nV-9L
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:46:59 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGRA9-0007mR-TX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:46:58 -0400
Received: by mail-pl1-x644.google.com with SMTP id b9so6207695pls.12
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cMdRFwPLdBBqdclOU1y4YXPpVW8UyO6JkyPnTNFzx4s=;
 b=XnnpKquo/U8iHf9JcdF6Le2PhpR0jSp5iBgyjeDo24Hxo/IDd8eZ82lNa8+DrGmFuc
 S2ZBCsZy0yqJAh7lyhMvjg439RSd95R8SADjNnu5J6swpDfvSg529FSBRTmrF13MB4r2
 D+9co0cgGh9IVIa42vlzWJXdS2xMxQZGaZS0SXdrQ2yls+WGaCqy7+NWN4c9OAaDpPvu
 vUMWEzEnqaFFzlyimtmuAq5fVG1LXSSTvzougyrEhGsUdJct6Mqtv5o+ca2CR6ErwSt4
 Qati1S+w6O28DgyiDSlW11HmhSXYEnPl7ptWhj21QWxnsG1fe9Ea7No0Y6i0nr/E6OWo
 ZGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cMdRFwPLdBBqdclOU1y4YXPpVW8UyO6JkyPnTNFzx4s=;
 b=QQhGJtmm0eSSj8dNhgDPENhYv5TEvz9jBYMOJ4sfY37qD+YtZhnU3m6v2cQot0UtEM
 iSgyqACPIyhu8m1HhEnBiHJ/evFNEYyTHjzVMUsCrT7MoB4m2ZIo14thRhvYF2bZOrk5
 P3dMq5P/Mf3VI0FgnxOfp4MJiU637MRYWuxTHHZNGQIfib7gfrOWjf1O0IY6Zv3rV18T
 tjXXisgnfVALqubBFUGFVpLgBuPaRlbOdZ9LSspHo+Ks3Celex1UPGDUH0+z1Db+qV7t
 c+NqY5XBQsDEC5CfwFfXWvAxWjINsDp7QpMvvPozTFGqIbh4zMsCRE9v6pQZ3zPq+kLa
 xy/A==
X-Gm-Message-State: ANhLgQ2efxPb6x0kl5sS/ESCl5zoOPmbEsLtyEVE+wQS17hSjKAKS9xb
 KiWaRSHUA1r8Smp0VS/CsDTnkg==
X-Google-Smtp-Source: ADFU+vvgtoXB0RsoDuY/KJ2O3Nt7k/PCssRJGf4lg0CrDwnEPeteVbeU5E3NTZPYlALmObz+8S16Tg==
X-Received: by 2002:a17:902:463:: with SMTP id
 90mr23970281ple.213.1584985616485; 
 Mon, 23 Mar 2020 10:46:56 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 nh4sm190696pjb.35.2020.03.23.10.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 10:46:55 -0700 (PDT)
Subject: Re: [PATCH v5 09/60] target/riscv: vector single-width integer add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-10-zhiwei_liu@c-sky.com>
 <49490839-077a-5bb6-c56e-95298c5ef74f@linaro.org>
 <f742e1d1-05ba-f051-a2bb-d8da15e7e947@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cda82320-f0c3-7fd7-1731-ecd251ae0904@linaro.org>
Date: Mon, 23 Mar 2020 10:46:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f742e1d1-05ba-f051-a2bb-d8da15e7e947@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On 3/23/20 1:10 AM, LIU Zhiwei wrote:
>> static void gen_gvec_rsubi(unsigned vece, uint32_t dofs,
>>     uint32_t aofs, int64_t c,
>>     uint32_t oprsz, uint32_t maxsz)
>> {
>>     tcg_debug_assert(vece <= MO_64);
>>     tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, c, &rsub_op[vece]);
>> }
> Hi Richard,
> 
> When I try to add GVEC IR rsubs，I find it is some difficult to keep it
> separate from tcg-runtime-gvec.c.
> 
> The .fno functions, e.g.,  gen_helper_gvec_rsubs8  need to be defined like
> 
>     void HELPER(gvec_subs8)(void *d, void *a, uint64_t b, uint32_t desc)
> 
>     {
> 
>         intptr_t oprsz = simd_oprsz(desc);
> 
>         vec8 vecb = (vec8)DUP16(b);
> 
>         intptr_t i;
> 
>         for (i = 0; i < oprsz; i += sizeof(vec8)) {
> 
>             *(vec8 *)(d + i) = vecb - *(vec8 *)(a + i);
> 
>         }
> 
>         clear_high(d, oprsz, desc);
> 
>     }
> 
>    
> The vec8 and DUP are defined in tcg-runtime-gvec.c. 

Update your branch -- they're gone since commit 0a83e43a9ee6.
Just use normal integer types.


r~

