Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B20C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 00:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72881206F1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 00:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHDj5P/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72881206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHz0l-00029B-L1
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 20:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHz02-0001YU-07
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 20:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHz01-0004WN-0h
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 20:06:53 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHz00-0004Ud-QB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 20:06:52 -0400
Received: by mail-pf1-x442.google.com with SMTP id c21so4642324pfo.5
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 17:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nyxUatUmri+viMWm0r2f0sQPHURgC/4b9MqoNbg8y0s=;
 b=aHDj5P/3jNH/z06nDrj7W5nM8MEF8+x4VHsSN+yqirKHuawfr67Uc3yTB6D8MDnvdv
 sAYhQWrMGF8bAq7uTULdwdMOG4Ags7JNg5CtTRXTx9HoY2bJ2JroL/JcM1sBtjbxCIQu
 7pYATaSXUPopSLq8hZFHo8ZPDYZ0LEEtQ+++UTCLS3LxZM/smhlVq+PCsahlRqYqL1DS
 ipd1Gghwdv21oK+s/lAa0WWe2PFgvEyN9NI38XgeOsd/mw4icoFpI95AKlAm7O2+gAPO
 bSdBInHKpMZo9h8kTtJiMBJqY8MAssEWHMkrGNs79m2LEPKq743XEKggs/DTe++RORND
 T0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nyxUatUmri+viMWm0r2f0sQPHURgC/4b9MqoNbg8y0s=;
 b=qPjdErQk1tpZXxEkq1I02gn9ec6sGv66YAIzP6ISxphMxNwfsC/nyNMZX0o3CsK2cR
 7pHxUEjOI2mbleWetMMUpGzvug4QoQQUCYX9tSDg7gUkO1NbQyy/dtQr26Wsfbiz4jl5
 iGJuhzsmATWjOaja7yoa3cJWVp9X3Gg+Kh8uz8QYRTllf6yH27jSwfs1H0nPBmOhrJeA
 yR1IfVqmRMmIbNzDdxnfn5ZV+uulJHh2MHwwlcC5msmByBg5yc+PF4jnxI1W9eyKEDZ4
 cyswzia+3f+S/Ln81lYf4hubZFHFxJ4eblZbzBIOV90MEELMwk1No9bX5C2olcZu7sVX
 zuOg==
X-Gm-Message-State: ANhLgQ0bQoIwaEXp0UTo+AwJ9+O2l9rH7m7VHvLqRWXWASoZ4qJjceIN
 K+FVPNhTNKVbrGoRDHqkLQGyyg==
X-Google-Smtp-Source: ADFU+vuhDh3MmhzFUhejTCYPiCxmLH/MDJG0IX1PD+8nAOkfCX2qVpWSMwvPYd01U7oaatNOUR0gIg==
X-Received: by 2002:a63:2b8d:: with SMTP id r135mr1820426pgr.329.1585354011295; 
 Fri, 27 Mar 2020 17:06:51 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id e26sm4991373pfj.61.2020.03.27.17.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 17:06:50 -0700 (PDT)
Subject: Re: [PATCH v6 18/61] target/riscv: vector single-width integer
 multiply instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-19-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a5900d9-dc26-04f2-74b2-0bada246a0e7@linaro.org>
Date: Fri, 27 Mar 2020 17:06:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-19-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> +static int64_t do_mulhsu_d(int64_t s2, uint64_t s1)
> +{
> +    uint64_t hi_64, lo_64, abs_s2 = s2;
> +
> +    if (s2 < 0) {
> +        abs_s2 = -s2;
> +    }
> +    mulu64(&lo_64, &hi_64, abs_s2, s1);
> +    if (s2 < 0) {
> +        lo_64 = ~lo_64;
> +        hi_64 = ~hi_64;
> +        if (lo_64 == UINT64_MAX) {
> +            lo_64 = 0;
> +            hi_64 += 1;
> +        } else {
> +            lo_64 += 1;
> +        }
> +    }
> +
> +    return hi_64;
> +}

Missed the improvement here.  See tcg_gen_mulsu2_i64.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


