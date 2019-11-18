Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9875C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7659120740
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qd5A+Zzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7659120740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWcBN-0008WJ-IR
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcAM-0007sT-LL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcAL-0004kD-FI
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:13:46 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWcAL-0004jC-81
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:13:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id b18so16803195wrj.8
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 00:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KYB37jRrKDFjzSPC2jq3P1mV49LlLcqdzX2XOfgKfpE=;
 b=qd5A+ZzbsUQvagSuRgrZQxfzDWChS9eCt8dFJSOtP5ozZERhiY9AXLaqIwTnELYX2c
 I+s6891YEOMlVyZffA44oOBZWEXLta0+b2LGr00kzhbgDvs1MG9Kufqc5DiHn2iDNpwv
 k72L8ea5dm/nmuO17Vn/FlJ5d5SftAwxU6g8EibSlnuW2DaoqcGhgjgNncq/7wEasvf5
 /EOZxJm4t181e56uqM4gPtaGK3w1bHWMXFzkEsim8ExhMBl07Oko8WsS3vF1WDwX04pD
 6wSjI0K7raICswss2/0O+vDtaZ+XRP7TA9GX3xtcNB0xHX84HHZmpZn3ezwXC7+Y96Ug
 OgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KYB37jRrKDFjzSPC2jq3P1mV49LlLcqdzX2XOfgKfpE=;
 b=FWolNB12fL5pmICdCzRucM09J4w6pXXhcx7KZL41uTYPh1/mxFXp4UBNpFCDOOa8F4
 RRTWa9dx+R6ih4HqFFsA3geBlXlKHtlFkYLxNKzaWiS4IuocM6NCIfcaUuCnZU28zrW5
 /Swr6TnjFDq6DlXgJ+sT2e6alUkFbVn9LU3MyMoNdz7rBnnVfSu2CPeBn+qezewkXb7E
 iUbVegectz+w2ddztWSh8DmHWHsICkReP8KfPHRaMNl+OOfEZpSt9Sa8bSGV+fxksA9v
 4bE4LLfOy5NtizmVc7PvU1t3knl5xl7alXXoIfmtPLdrCOlQZKc+k1mDZ6am8SubqIyn
 kRrA==
X-Gm-Message-State: APjAAAU94frCaIO3Lk/F3+nsE/11JUL9QyuwXHklTzukxqhzILNpv03z
 79FgTlkqTRc9L9nBsRvfCr/TZw==
X-Google-Smtp-Source: APXvYqySa7J7s3Did2LGbsy2R/CQYbkO9/TokJfsNwKj7zAP6F5s+35B8tUaWCTjAJDgKzs0kLcjGg==
X-Received: by 2002:adf:e94e:: with SMTP id m14mr29344876wrn.233.1574064823964; 
 Mon, 18 Nov 2019 00:13:43 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id n17sm21342097wrp.40.2019.11.18.00.13.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 00:13:43 -0800 (PST)
Subject: Re: [RFC PATCH 05/11] gdbstub: add helper for 128 bit registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8a0c054d-6881-40e4-6bc8-6e7179701cd3@linaro.org>
Date: Mon, 18 Nov 2019 09:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 6:29 PM, Alex Bennée wrote:
> +static inline int gdb_get_reg128(uint8_t *mem_buf, uint64_t val_hi,
> +                                 uint64_t val_lo)
> +{
> +    stq_p(mem_buf, val_hi);
> +    stq_p(mem_buf + 8, val_lo);
> +    return 16;

Since stq_p itself depends on TARGET_WORDS_BIGENDIAN,
I think the word ordering here should as well.


r~

