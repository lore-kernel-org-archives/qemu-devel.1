Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373E0C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 22:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BAB20872
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 22:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHwFAtTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BAB20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8BAw-0002gT-Ut
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 18:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8BAF-00020M-EM
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8BAE-00063T-7U
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:32:39 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:32957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8BAE-00063E-1m
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 18:32:38 -0400
Received: by mail-qt1-x842.google.com with SMTP id r5so27374604qtd.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sivu36cH7Xseu597XdT8OApYiI7Cp7qF6DgK2C8aQSU=;
 b=bHwFAtTr2IFBVwFr3aN0llMblxTOM88hJgkpKh2FjwyjYa+6iGp79uL/tFeRDRX8XT
 YmoBORDoGqSSMoQc2eEt+uxyIme0E9PsE4clGvUgDy5l99rcLfyUFL5R7Qa1YT6Svi6+
 iMv0qPJHQUY+GegDsWIBD8IBhzCf17i2/HeCC4WIMvq29yNl7ht03OEM3nojAWwcy2kZ
 84PDV7LICb0FqmudbTKyazWodXBoCTb/hKK6bCBJWMihQFjWJM9fT7UtSrwI95gUrRY8
 SieJfHp8xgXvBDPTQH5u9SXgXJBzEBXTGo0szSjOo7N05YqngRwF4qkPjVerzDURdWbZ
 yenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sivu36cH7Xseu597XdT8OApYiI7Cp7qF6DgK2C8aQSU=;
 b=kZAn0FZexhVV6i9/iQlV4fGgDwulXwXZ+A2cel7Y1YFirDH0rtQ+cO5+NvHscxFpG7
 dWBsjiCkhhwHx8HPC4y6+HcuuER0DjtKJ09m/maSEtjoaFJ2+QKIVrHK011gVkBmjxPh
 h9lnxz3DEu4yvTiUvaWZoRNSNMil3wBZXw6fQEiDEb3DpCLjmNJlLqL/G7qmV6uFTaRU
 y5n6etoEiPp04VfyZfJqoPPO+iYWBWtckt/V/0QlX1gMefAVeyQLaaPxVcTCco7zSvuT
 hAzzatUVmuZ6rJ7KhPVLr0Socs3Bn+ze5C7dvK0ZRdifwtZQz0gihv1ha32iwWuzdBlW
 MxAA==
X-Gm-Message-State: APjAAAWNY9P0gYXb1drRA5/zEpCA9lyz6cWRywyYBcU3kW81UNq6Cf2Z
 UK1bWkL3lCbqfI/0j8HAc3zToQ==
X-Google-Smtp-Source: APXvYqx3rZ9Tc2eBC1xZTZqQ1tRZZ5+9k94jnnuKfO9maawFvg+AOjh1wHNXCvRKontL5EUdfG4jzw==
X-Received: by 2002:ac8:67ce:: with SMTP id r14mr39065685qtp.338.1568241156985; 
 Wed, 11 Sep 2019 15:32:36 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id h29sm14019397qtb.46.2019.09.11.15.32.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 15:32:36 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 riku.voipio@iki.fi, laurent@vivier.eu, wenmeng_zhang@c-sky.com
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-2-git-send-email-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2a802977-2f73-1857-1fe3-c9571ed1b34f@linaro.org>
Date: Wed, 11 Sep 2019 18:32:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568183141-67641-2-git-send-email-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH v2 01/17] RISC-V: add vfp field in
 CPURISCVState
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
>      uint64_t fpr[32]; /* assume both F and D extensions */
> +
> +    /* vector coprocessor state.  */
> +    struct {
> +        union VECTOR {
> +            float64  f64[VUNIT(64)];
> +            float32  f32[VUNIT(32)];
> +            float16  f16[VUNIT(16)];
> +            uint64_t u64[VUNIT(64)];
> +            int64_t  s64[VUNIT(64)];
> +            uint32_t u32[VUNIT(32)];
> +            int32_t  s32[VUNIT(32)];
> +            uint16_t u16[VUNIT(16)];
> +            int16_t  s16[VUNIT(16)];
> +            uint8_t  u8[VUNIT(8)];
> +            int8_t   s8[VUNIT(8)];
> +        } vreg[32];
> +        target_ulong vxrm;
> +        target_ulong vxsat;
> +        target_ulong vl;
> +        target_ulong vstart;
> +        target_ulong vtype;
> +        float_status fp_status;
> +    } vfp;

Is there a good reason why you're putting all of these into a sub-structure?
And more, a sub-structure whose name, vfp, looks like it is copied from ARM?

Why are the vxrm, vxsat, vl, vstart, vtype fields sized target_ulong?  I would
think that most could be uint32_t.  Although I suppose frm is also target_ulong
and need not be...

Why are you adding a new fp_status field?  The new vector floating point
instructions set the exact same fflags exception bits as normal fp instructions.


r~

