Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C120C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 15:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87120206F6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtCKB9nU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87120206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIDhL-000498-GE
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 11:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jIDgN-0003OT-24
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jIDgL-0005TY-Nh
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:47:34 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jIDgL-0005SF-HH
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:47:33 -0400
Received: by mail-pg1-x543.google.com with SMTP id k5so3993394pga.2
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MKbwnij1Ha6LFvUE+TJiFwc9ex2AHAFEXUHvJ/Nk2/Y=;
 b=EtCKB9nUSZWH4LaiVi77fJ5e1tt/X5VQ0gFLAIlMT8agUeSyJtOvSRZ1po/S2uwpmj
 HHytkgT5hbrkN5W0aouKxeDwKYvl3ZjXMo745TXhw8+H8lqLOoVWJhaQK3wLF8/ttlgN
 m0Ka4t6+q/frvFQm2HXBO31HTzFiaLo/N1mgNmDdPcCU+OpNeGKPwWUuMmxJtM/dShMf
 qWzOGLMLPViIHoULX01dxt1MEgvaSg4wfG3JCgptCQPmhydNgQKDCVXeHvPvyaHE1Dj+
 z5CZQ6/qEGB0YEzabRaR/aWG4jsehyXcvhZyKwlIjkQkpn1+Od/pIi/ENcE9O0HB0EnN
 GjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MKbwnij1Ha6LFvUE+TJiFwc9ex2AHAFEXUHvJ/Nk2/Y=;
 b=NNz6REXyrnYqJroT12xl3vRtPzFrkVL/2F///yWt5XrcGyjUn04CskHSDn9u4kztq3
 TN7NHzV0TMBAwq+TyYBP6Ji79KrZxymtiVeItnxZZHCWV4ikQgV5kgVZ7AjvuZ3ZnUmB
 v20/uSvuWh9jv+j3JXZMQmrnYf23X3fKcg8tbUsHh6hiLvuzUaf6Q4G2sUb1Je3Ipz2Y
 GsS7FHP7GGtKWHf88kkT1Kfub0ECarBWXy+Pu8176c35D6qeBbQZKsdBLCK+9+s4F9fL
 WOonqqturyPwmN4/k66Y3KnQYCmrE+WCVArQ6SWvW41hyeMU2+G1ezw10Q0fA06lFuyR
 ECXA==
X-Gm-Message-State: ANhLgQ0Yly2ckdAFWja9ofSfjH7tnaeFljJqn27tyQ6pDSa5YYD9iqkw
 RLNuDNc93PwPqFZPtjyw4MBbEg==
X-Google-Smtp-Source: ADFU+vv4P+rKlx09u8UdPUvWe42R01ortUoubS9w34kNzLyflGp33C1CKpcizn1WhKveHTvobtV1jQ==
X-Received: by 2002:aa7:8ec1:: with SMTP id b1mr4706927pfr.125.1585410452262; 
 Sat, 28 Mar 2020 08:47:32 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id u21sm6112769pjy.8.2020.03.28.08.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Mar 2020 08:47:31 -0700 (PDT)
Subject: Re: [PATCH v6 18/61] target/riscv: vector single-width integer
 multiply instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-19-zhiwei_liu@c-sky.com>
 <1a5900d9-dc26-04f2-74b2-0bada246a0e7@linaro.org>
 <8be612c0-4345-c1f2-3b82-73a9a1ea4133@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <53209745-9b54-00b3-2b1f-1271f0843021@linaro.org>
Date: Sat, 28 Mar 2020 08:47:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8be612c0-4345-c1f2-3b82-73a9a1ea4133@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

On 3/28/20 8:17 AM, LIU Zhiwei wrote:
>> Missed the improvement here.  See tcg_gen_mulsu2_i64.
> Though I have not gotten the principle, the code in tcg_gen_mulsu2_i64 is much
> tidier.

Let A = signed operand,
    B = unsigned operand
    P = unsigned product

If the sign bit A is set, then P is too large.
In that case we subtract 2**64 * B to fix that:

    HI_P -= (A < 0 ? B : 0)

where the conditional is computed as (A >> 63) & B.


r~

