Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2BBC4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225962081B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xz448RXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225962081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i99a4-0004F5-Ad
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 11:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i99XC-0002d9-NH
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i99XB-0003Tl-Ow
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:00:22 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i99XB-0003TY-IX
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:00:21 -0400
Received: by mail-ed1-x543.google.com with SMTP id f24so11831816edv.2
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7RZvnREOuSEbzUwnK/zVUTIkqTWybDOAg1+ekjJlqec=;
 b=xz448RXtJxvb+QJQ9bIMnHhw2raz8r/wsir/RW/gZy1w6YEaQvhzmRVCY/jWvBmr5s
 iySG9r/2g3EkBg80GkXUQ772vFF5BNlKpEXXiDV3Yo1p7EBQqgz3plWwg08i44CqL7DK
 F7Ljivec+JkZQ6qNvoBC5hYLdwc6bBQIrd9xUNrJ4Q+SKiA2SA5LxGoSOAH0vvC/rjFc
 3VWSVZBliNkeYBriyg4Jrf2o1Z6+Ts7MMoQO+Q9hP5c/sDUg+b14jl+WAjPR+6lqCQDo
 9Qz3NOK2C+svEe1jdORqvV78hV4xt2BSxRgNvMencu2GrRbK4u4OtvxH5MiVf59CqBEG
 kasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7RZvnREOuSEbzUwnK/zVUTIkqTWybDOAg1+ekjJlqec=;
 b=sF6YNvI63CN6vX7XSpMrSkzy4rTcRBMXv5Myta+bfGGEFfqoV9sHJItXsw4od4uGxM
 EI8VEUj3aHMmcin49+d/UDGcNO1VhnY1NgUEKv4VfUkbLNw0qrERGk3xECPUu+vIphHF
 qWfBLzolKh7twm/dS/3ZQSZTWR1/XRzKV/F1Kp+b6cEb7qtCMp9WKbg2nswHABHPiBv7
 SjFmqDtcagHLRdEfPOiq6Owj1F9p9JzzhJi/28e+Lsy0S9scba0mjajPvsZlASfwH86l
 S8NqxMw7aGTK1I/Oqec1M9yezms2G6m9+dnshhm2gZhTdlVYgCEOfUSELLpPh9NWYhwz
 nRsQ==
X-Gm-Message-State: APjAAAUeALF6kB6ugOYEywzC3VKs5TtuGj5gZhYjAQbfLRQdbZMrou5u
 n4x/BC+e1/WASAZVLI0Rbt9+WQ==
X-Google-Smtp-Source: APXvYqzV6UdrLbVM3RGrkc5XWTgoO3pPzpfki+89EBzxXPwDmDs8DKroqlIyPmyQjrUFnwJU5urnIQ==
X-Received: by 2002:a17:906:6618:: with SMTP id
 b24mr43959708ejp.215.1568473220618; 
 Sat, 14 Sep 2019 08:00:20 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.18])
 by smtp.gmail.com with ESMTPSA id x42sm5960122ede.24.2019.09.14.08.00.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 08:00:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: "Paul A. Clarke" <pc@us.ibm.com>, qemu-devel@nongnu.org
References: <1568292860-4928-1-git-send-email-pc@us.ibm.com>
 <5778f6fc-f9bd-13e1-b09f-0f24ac8ec404@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <abde429a-ce48-e986-ebe3-685dc164820c@linaro.org>
Date: Sat, 14 Sep 2019 11:00:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5778f6fc-f9bd-13e1-b09f-0f24ac8ec404@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v2] ppc: Add support for 'mffscrn',
 'mffscrni' instructions
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/19 10:58 AM, Richard Henderson wrote:
> On 9/12/19 8:54 AM, Paul A. Clarke wrote:
>> +static void gen_helper_mffscrn(DisasContext *ctx, TCGv_i64 t1)
>> +{
>> +    TCGv_i64 t0 = tcg_temp_new_i64();
>> +    TCGv_i32 mask = tcg_const_i32(0x0001);
>> +
>> +    gen_reset_fpstatus();
>> +    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>> +    tcg_gen_andi_i64(t0, t0, FP_MODE | FP_ENABLES);
> 
> Missing the decimal rounding mode (DRN) field at 29:31.
> 
> Otherwise,

Dang it, <ctrl-v><ctrl-enter> in the wrong order.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

