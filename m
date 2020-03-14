Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C90BC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0732073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCsox29K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0732073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2Gg-0006Ai-6v
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2Fo-0005ek-Ua
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2Fo-0006bf-3e
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:34:44 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2Fn-0006Wk-TK
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:34:44 -0400
Received: by mail-pj1-x1043.google.com with SMTP id np16so5359197pjb.4
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FkWKQ9CpMl5K5wDP2JsVelM6iwtzu/v8rvKosfZ1mHQ=;
 b=UCsox29KS74WfiuuC5H/V8fY3cajcjNHfR4h4kIq5rDEeQSefX8WrDvONXR75lRCb9
 42KtLP19++ZeY/L6hbj+r/wywLXU+QpSygXU687NU+CFUUV74bo/eo2MEvR9Cace6NWJ
 GwQ6HfN0c/mvst1cLJWLCkdYhbfBTrJQG7W7RcTRkkb3jH/0I07Gt0v16SZhwuG63CmJ
 ECleZshiAm3uC5KseFlCRI3AZwk4R7kZtmUsJQuDaynsx14k1v2kspRuUCsU+jNM9+ko
 8LsFPcKwFMTvqktAJIEHEnTEMQki81QRS/OV9ddxqOHWiQx3iuyx/40i/4bLnMUC9Q2W
 FOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FkWKQ9CpMl5K5wDP2JsVelM6iwtzu/v8rvKosfZ1mHQ=;
 b=fWjJ8183oj0VnyWhV7iV9/2KsOx3LSsDHgcPuavVSiwHWUToC0viJH45tZB0Hw9TpS
 9nc39h3egsaRVY0mayt4YVIKfr1ddJe5f0I7K9XgU2rgC5WtzcYzIkdueMyee14TRdHz
 Ho5pqJHUsd2dXsOIJ8iNRZlqIE1D8PLLKZFzVI02q7SPs0TT04QuJduir1yLbVs40dDW
 QtHJUvUV3qADGtvMvtapaYV2oHI+evwOmNXyX98CnAhVouMkN0CnXkZez/OK6bnpDcf/
 4mEDwhBdCI5Rd1PRC/kDvFiiRNe7/i7FPvfIzJ2zeGKpkoi8MOzXYxBgxuV6xub/kqxN
 VZ7A==
X-Gm-Message-State: ANhLgQ27kJolY8YkiB4Og7ipEUvuiWZqZaYzKjVZkI9dF63Wr4pvpWin
 /0jGroGHsfctL6P6sOcm0pY4yA==
X-Google-Smtp-Source: ADFU+vtbJWo8a9OuHM5Ur/MwPbb/XYr+ACsbCsWhOW/KHGAJLwWUgiRHKTIdybMFeBM9AZ3NmUJQLQ==
X-Received: by 2002:a17:90a:a48b:: with SMTP id
 z11mr14337450pjp.1.1584174882848; 
 Sat, 14 Mar 2020 01:34:42 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f4sm25343087pfn.116.2020.03.14.01.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:34:42 -0700 (PDT)
Subject: Re: [PATCH v5 27/60] target/riscv: vector single-width scaling shift
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-28-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7fb46386-5804-2a52-a682-56fdac2c8641@linaro.org>
Date: Sat, 14 Mar 2020 01:34:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-28-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
> +static uint8_t vssrl8(CPURISCVState *env, uint8_t a, uint8_t b)
> +{
> +    uint8_t round, shift = b & 0x7;
> +    uint8_t res;
> +
> +    round = get_round(env, a, shift);
> +    res   = (a >> shift)  + round;
> +    return res;
> +}
> +static uint16_t vssrl16(CPURISCVState *env, uint16_t a, uint16_t b)

Likewise.


r~

