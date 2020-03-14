Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5859FC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CF92073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUoO+8mA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CF92073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2JU-0002Ve-9q
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2HG-0006h0-VG
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2HF-0004yd-Qo
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:14 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2HF-0004t0-Jr
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:13 -0400
Received: by mail-pf1-x441.google.com with SMTP id z5so6745122pfn.5
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zewqT5/C3Y83vvxeyWUZWn8omH2OG4eAnBdgTFaVgTA=;
 b=uUoO+8mAsOsfan9bQd9BuWga7Xb/N9ZFVdyXPZXSEA1FGAzs7tQFRUsPjraFV1i8R/
 cTF5CWVGpMyvM0JSkJVpUwgIsISFy7nnxsTVv6f3fRrBUP/3M44Q88/F25qTH+P8ny9o
 a4ogZt4dEHw+/KwNCQcnoG5XPtRun3p8GWKezkcp2V2866LPnEI42WMQPsRXzH7OfqUZ
 iZZ0ozCD4dXOKgnLQxLezri1VQZLwEn3p8rACCuVH5WFOeAm8dfNB/yLOSv3iAIzce8c
 eCH/tI+XdjOspBejIIbzI+8niBS5R2RQbHyPXK5A73tTLQ7z351WpV2BIR5lIiplQ2qv
 PxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zewqT5/C3Y83vvxeyWUZWn8omH2OG4eAnBdgTFaVgTA=;
 b=IVQSiPglnoHaP+qu0Q6oTd6iZ/UnQsA6GywqqYTVLCG2N25SgQMJmlkF7Q5MF6nP+g
 cZS+7nJE60X18+kT8zq4Nu2AGNtENvz0CKxYpGQBGd4YBhsW+Q+sycsdPgm52azqgwzQ
 AVnA0WwO3LNI/R5ARack0+lZt3aJGfFYx9GQON1cvWYXW/LwpTPbHudAaq6gpqkzwzrw
 FLqg0iI4HK0a85CnzD0FyRXgbh+gNaQX8avmjm0gyiZKKUqzEG7b3wOuMYJD9+10t5l0
 930X8eOqtGsHLKu51LLXvv7S+qwYbMGnGIe5g6syZ0DV1EMhDqp/y1UWKOA4vEMHP7aT
 6ksw==
X-Gm-Message-State: ANhLgQ3CWaXXyr7BVWiu1gRYZ4tK5QuxqN3C8Dzj1+epONJPcyLzNP5P
 oDgSS3lalMismuanyrvkMcSj5w==
X-Google-Smtp-Source: ADFU+vv4JZ9dxc2jgYBn/k0lp44QS/DRuQp8rF7q05ysBnPGRklJm3sefbb2tUJtfyM31HnBYgogYQ==
X-Received: by 2002:aa7:83d7:: with SMTP id j23mr17105617pfn.77.1584174972314; 
 Sat, 14 Mar 2020 01:36:12 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p4sm111341pfg.163.2020.03.14.01.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:36:11 -0700 (PDT)
Subject: Re: [PATCH v5 28/60] target/riscv: vector narrowing fixed-point clip
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-29-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <149695d1-1bd2-2011-f467-ae35606dab40@linaro.org>
Date: Sat, 14 Mar 2020 01:36:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-29-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +static int8_t vnclip8(CPURISCVState *env, int16_t a, int8_t b)
> +{
> +    uint8_t round, shift = b & 0xf;
> +    int16_t res;
> +
> +    round = get_round(env, a, shift);
> +    res   = (a >> shift)  + round;
> +    if (res > INT8_MAX) {
> +        env->vxsat = 0x1;
> +        return INT8_MAX;
> +    } else if (res < INT8_MIN) {
> +        env->vxsat = 0x1;
> +        return INT8_MIN;
> +    } else {
> +        return res;
> +    }
> +}
> +static int16_t vnclip16(CPURISCVState *env, int32_t a, int16_t b)

Likewise.


r~

