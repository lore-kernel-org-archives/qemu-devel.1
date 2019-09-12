Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E05C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFEC20640
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eG5U4TOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFEC20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8SZl-0004hk-Gx
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 13:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8SYz-0004CM-7S
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8SYy-0005gs-0j
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:07:20 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:45049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8SYx-0005gb-R0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:07:19 -0400
Received: by mail-qk1-x741.google.com with SMTP id i78so25160161qke.11
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dvl3xnYMQe4Q0aFmgL3sxW994p/2Ghv+9EqA5fMqUgs=;
 b=eG5U4TOoaRY2eXIwP2DPTj9cT3E8YqBgeoE1nk4tQW9447tc3/cCA89wVdRFk1yqyY
 yNT8/Lqr3DSjSpNOnh7HkF50A9Xh1nBCbLAkpYMoc6/2cHixm5+UY+xamyE6PTt3Vr+3
 79+Ud1xN1QEuCnCRg8fRv959olnzjBpLIoy+zWnhY0fHF462PePGfHmB/TtndMfmU6RX
 7wTzB+NRPJhvvxmBXr+qCTtBxwRAFsxLA5tixhyBcwdSHPM8lOyGEyGfPeLMk250NVe7
 SGC5+e6zqmF4DGZVP1xZTgRdylwDzW8fLLSfOwwdUXwcs62csqIu9Gj1qS27HT+trYbd
 4Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dvl3xnYMQe4Q0aFmgL3sxW994p/2Ghv+9EqA5fMqUgs=;
 b=QKNyS4i2X3ljeKKUcPmvUbjtsSdQtghp9JEIpGCDKen8UICYaRacNY5n/o+B2J8XaP
 xEUO3e7JjsNdlQtT+9Fa0VL4voDtrfCOch+sOI52C6z5dNtpvhJwNZYBFpKXfk6pflyk
 dLxePJFo3DXzyEOtFQztrr3iWbiZhOBK858QFsvomn7IFNxtHWBW3mw9LsT2c59X+ioK
 ibEYR9BZYDirDDussJdTwKkfm8xJFT24Phw56AuIn/b7nCHQQ7mB64TBfMDDPXrrT2vI
 ilfBqNNLCNcZKrsrL2G3RhHvc5mkXxFzj2m35KYBd9HHIskoy7FA2S390iY6sGVJGMYE
 VTkg==
X-Gm-Message-State: APjAAAXHfPsInGEjo42h7cIdt/JZJvGKEbywB88mwSJlEnMwAhQRHKaN
 M0vEoWMLMLWaIzZLlW2ruJpCUw==
X-Google-Smtp-Source: APXvYqwZPAFCCdC9ja+l9h/lEnP9NlaqkQ7R74oVbeN0Ep2KgMtIZxhOVOhyUfM5R6DMrO8MAEolCw==
X-Received: by 2002:ae9:e111:: with SMTP id g17mr41254507qkm.411.1568308039082; 
 Thu, 12 Sep 2019 10:07:19 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id q8sm11214559qtj.76.2019.09.12.10.07.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 10:07:18 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 riku.voipio@iki.fi, laurent@vivier.eu, wenmeng_zhang@c-sky.com
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-17-git-send-email-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7a009ef1-bb8d-55d2-eeb5-2f44df2f71ab@linaro.org>
Date: Thu, 12 Sep 2019 13:07:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568183141-67641-17-git-send-email-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: Re: [Qemu-devel] [PATCH v2 16/17] RISC-V: add vector extension mask
 instructions
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 2:25 AM, liuzhiwei wrote:
> +    for (i = 0; i < vlmax; i++) {
> +        if (i < env->vfp.vstart) {
> +            continue;
> +        } else if (i < vl) {
> +            tmp = ~vector_mask_reg(env, rs1, width, lmul, i) &
> +                    vector_mask_reg(env, rs2, width, lmul, i);
> +            vector_mask_result(env, rd, width, lmul, i, tmp);
> +        } else {
> +            vector_mask_result(env, rd, width, lmul, i, 0);
> +        }
> +    }

These can be processed in uint64_t units, with a mask based on width:

   8: 0xffffffffffffffff
  16: 0x5555555555555555
  32: 0x1111111111111111
  64: 0x0101010101010101

  dest = ~in1 & in2 & mask;

with an additional final mask to handle vl not being a multiple of 64.

Again, I urge you not to bother with impossible vstart -- instructions like
this cannot be interrupted, and the spec allows you to not handle values of
vstart that cannot be produced by the implementation.


r~

