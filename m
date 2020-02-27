Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434F7C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDEC2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8ZXOsYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDEC2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7POd-0002Qu-5G
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 15:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7PO2-0001zU-8M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7PO1-0006nx-36
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:03:57 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7PO0-0006nF-Rv
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:03:57 -0500
Received: by mail-pl1-x643.google.com with SMTP id g6so234060plp.6
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 12:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2WBG2RTr0qjTefzGTgfeJN1oG1HTTmoJ+yNPM/A6T10=;
 b=l8ZXOsYvG5faDbzB6+SADiSTbHsop8RnEdbFCEQh5/bOP8yBUa+XbvWAtvPk5qH8uH
 9zcRSqcn15d8RNblNSs17FJMKJwN7V0Hxgdq9f/V6I8FFR9RWuALTzMN22bgk2JdnHDJ
 w6ILVZIM9S1pWBihQzKBWn3u8d8i2OcOTUOfRyi6PpYOviTjcw+M367ejppTCbXPZeee
 EARhTKVXvvQhJfD4ohw+LMAnjTv25O2n586VceIl/xexvefHQTwq1Rk4u+sE7m47Zkb3
 2aF7zvhksEysO1AOUG+jRpxXh8PdOKHgsnqmztbGE/H0WPXUttbgctvQCK+t3S6t+k5q
 PVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2WBG2RTr0qjTefzGTgfeJN1oG1HTTmoJ+yNPM/A6T10=;
 b=CcYIjD0riBu2ANlt3V7jwVALZo/JfXlVbY5dHTcdmhdTzVKojZAZ42nLRAO5hqY6U8
 rMMTqevQ/mDcaotoLMoad6zMz1jao4tlJFNCjO97+se7m//Bu19walwxIiLsmaNrNzgu
 YD1GNuPsFwbLD9Yt0SEHFmDI1EhMmyG3On2Clpb2RY/sTtwE/1SsFFfnYrP6x0zaMxkg
 HlRXaBPEMWpmex2o5N2IhfDnHP2eNKlj2DjmwGSqynnkFFYPhgKr8kSBzxlXBYwYKw3H
 8p5Oqngfw7Dyu47sgtPNNOjF5GzzfbjNSvi8VIoUyCmCsyk+WtCOzq8S5586aXblrOu+
 G0Gw==
X-Gm-Message-State: APjAAAUPtuHYTjv6B4vteWCwkSKm/yBBDCs7pKvw58ghN3/i+/hR+P2S
 TJKNEFuoUPYlCN7ha1D1k+/huA==
X-Google-Smtp-Source: APXvYqyyoR6u4iTvjBo3zec75zYzVUCXcFwHVh61O+y1jSA18KzXIJdckFBffqPn4HAigPtdkybDqg==
X-Received: by 2002:a17:902:504:: with SMTP id 4mr403983plf.276.1582833835735; 
 Thu, 27 Feb 2020 12:03:55 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x4sm8341657pff.143.2020.02.27.12.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 12:03:55 -0800 (PST)
Subject: Re: [PATCH v4 4/5] target/riscv: add fault-only-first unit stride load
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-5-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2b7d7af1-61ee-edf6-5e57-1108428f920c@linaro.org>
Date: Thu, 27 Feb 2020 12:03:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225103508.7651-5-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, linux-csky@vger.kernel.org,
 wxy194768@alibaba-inc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 2:35 AM, LIU Zhiwei wrote:
> +GEN_VEXT_LD_ELEM(vlbff_v_b, int8_t,  int8_t,  H1, ldsb)
> +GEN_VEXT_LD_ELEM(vlbff_v_h, int8_t,  int16_t, H2, ldsb)
> +GEN_VEXT_LD_ELEM(vlbff_v_w, int8_t,  int32_t, H4, ldsb)
> +GEN_VEXT_LD_ELEM(vlbff_v_d, int8_t,  int64_t, H8, ldsb)
> +GEN_VEXT_LD_ELEM(vlhff_v_h, int16_t, int16_t, H2, ldsw)
> +GEN_VEXT_LD_ELEM(vlhff_v_w, int16_t, int32_t, H4, ldsw)
> +GEN_VEXT_LD_ELEM(vlhff_v_d, int16_t, int64_t, H8, ldsw)
> +GEN_VEXT_LD_ELEM(vlwff_v_w, int32_t, int32_t, H4, ldl)
> +GEN_VEXT_LD_ELEM(vlwff_v_d, int32_t, int64_t, H8, ldl)
> +GEN_VEXT_LD_ELEM(vleff_v_b, int8_t,  int8_t,  H1, ldsb)
> +GEN_VEXT_LD_ELEM(vleff_v_h, int16_t, int16_t, H2, ldsw)
> +GEN_VEXT_LD_ELEM(vleff_v_w, int32_t, int32_t, H4, ldl)
> +GEN_VEXT_LD_ELEM(vleff_v_d, int64_t, int64_t, H8, ldq)
> +GEN_VEXT_LD_ELEM(vlbuff_v_b, uint8_t,  uint8_t,  H1, ldub)
> +GEN_VEXT_LD_ELEM(vlbuff_v_h, uint8_t,  uint16_t, H2, ldub)
> +GEN_VEXT_LD_ELEM(vlbuff_v_w, uint8_t,  uint32_t, H4, ldub)
> +GEN_VEXT_LD_ELEM(vlbuff_v_d, uint8_t,  uint64_t, H8, ldub)
> +GEN_VEXT_LD_ELEM(vlhuff_v_h, uint16_t, uint16_t, H2, lduw)
> +GEN_VEXT_LD_ELEM(vlhuff_v_w, uint16_t, uint32_t, H4, lduw)
> +GEN_VEXT_LD_ELEM(vlhuff_v_d, uint16_t, uint64_t, H8, lduw)
> +GEN_VEXT_LD_ELEM(vlwuff_v_w, uint32_t, uint32_t, H4, ldl)
> +GEN_VEXT_LD_ELEM(vlwuff_v_d, uint32_t, uint64_t, H8, ldl)

We definitely should not have a 3rd copy of these.


> +        if (i == 0) {
> +            probe_read_access(env, addr, nf * msz, ra);
> +        } else {
> +            /* if it triggles an exception, no need to check watchpoint */

triggers.

> +            offset = -(addr | TARGET_PAGE_MASK);
> +            remain = nf * msz;
> +            while (remain > 0) {
> +                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmuidx);
> +                if (host) {
> +#ifdef CONFIG_USER_ONLY
> +                    if (page_check_range(addr, nf * msz, PAGE_READ) < 0) {
> +                        vl = i;
> +                        goto ProbeSuccess;
> +                    }
> +#else
> +                    probe_read_access(env, addr, nf * msz, ra);
> +#endif

Good job finding all of the corner cases.  I should invent a new cputlb
function that handles this better.  For now, this is the best we can do.


r~

