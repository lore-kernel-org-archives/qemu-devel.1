Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665A2C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F173208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2/i9Rmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F173208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvJG-0007v2-9o
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hculL-0001an-18
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hculJ-0002RW-Rq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:45:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hculJ-0002LC-I6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:45:41 -0400
Received: by mail-pf1-x441.google.com with SMTP id x15so6007390pfq.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CzPEPYwv84ZFSF/W1LNEo+dAqIwIoLu41/sS6ZRas0I=;
 b=r2/i9RmxV10+Jr5r3Insrz2vsE/vzxxajCLPbVLt7UyxI5CzpIxuub/CWbn1GW60wz
 QlMvxzKZBEuyzP/WECCC0tlzDUqYTynjROqOuUNcMgQDz5MdK4OaJSw8DBJXfBQ3ypkZ
 7sso4fWGz6ZExxzNbR5EsMHXuF26FYKxnc4oXIOW5gVHJVKYHT1yXyUBsh290TZSfCF3
 vIeKN+hzW9q1CB4hEE5xn+lGMHFvFXKSImRkXZlNPoE8g+pzC5y1aIOeWLmqmtSteSB4
 MqGwhV5A4td1ofAZZu9QH7Gg/BJTFQdz/EDoS/ZQ/l1A9Oc+fms2RBc/TBbxpYDBD2/Z
 PbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CzPEPYwv84ZFSF/W1LNEo+dAqIwIoLu41/sS6ZRas0I=;
 b=iYuxVHRbunCsNZgsvErYpl4+F9HxccZ0Gao3hQWWEJvXjkAhJOHWMDRRkD3JO1my0Z
 TxEvIFtzv9iXyGj8xHBaXsax6wH36HB4BRlGxJAEfy0gqPzNQVKHcOYO/etFZkTAFKE0
 igAzJAHrRj6t8bQOryHAMmKweB16u7vmFvx6cZOh5JDyOBvJ4W3qVBfwpF6Dw2f4ppZo
 ETvQc0trLJzcdnT5yE94JFjAOV/0iEXl2xOjtM4P22iK3MjcEg/RBiyhO1PoCFT34O3i
 LoVy3I64pNmP0fIh82AiKe8tPDfyBhCxu4qJYa037d4i3BK8RWIpNgo3bX4q178a4Kt5
 xwgg==
X-Gm-Message-State: APjAAAUmhrJw6zTBsFm65yTsVHyjI50V+B1P71eBfBY0Oa0c2fXofg9w
 thli/qRr96HCeyK+vfglMyS8oQ==
X-Google-Smtp-Source: APXvYqxVXUZhXHWsSmQKcOFQwIJ86GuFIazu2BZwsarqnigWzXt0Dxmy9ssVyMDcKIbiu4LmvJyyVg==
X-Received: by 2002:aa7:8d50:: with SMTP id s16mr113359786pfe.96.1560789938872; 
 Mon, 17 Jun 2019 09:45:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id c11sm11938552pgg.2.2019.06.17.09.45.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:45:37 -0700 (PDT)
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20190617143533.15013-1-kbastian@mail.uni-paderborn.de>
 <20190617143533.15013-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b2f6e776-90e4-3809-350f-ce2bf6d69017@linaro.org>
Date: Mon, 17 Jun 2019 09:45:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617143533.15013-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 3/3] target/tricore: Use translate_loop
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
Cc: david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 7:35 AM, Bastian Koppelmann wrote:
> +static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
> +                                          CPUState *cs)
>  {
> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
>      CPUTriCoreState *env = cs->env_ptr;
> +    ctx->base.pc_next = ctx->base.pc_first;

This is already done in generic code.

I don't see an initialization of hflags & saved_hflags?
Although I don't see that either before or afterward...

> +static bool tricore_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
> +                                      const CPUBreakpoint *bp)
> +{
> +    return true;
> +}

Not supporting breakpoints, I think it's better to return false here.

Although it's not difficult -- just raise EXCP_DEBUG as an exception.
It'd be nice to follow up and fix this afterward.

> +static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
> +{
> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
> +    CPUTriCoreState *env = cpu->env_ptr;
> +
> +    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
> +    decode_opc(ctx);
> +    ctx->base.pc_next = ctx->pc_succ_insn;
> +
> +    if (ctx->base.is_jmp == DISAS_NEXT) {
> +        target_ulong page_start;
> +
> +        page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
> +        if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE) {
> +            ctx->base.is_jmp = DISAS_TOO_MANY;
>          }

This isn't perfect as an ending, but you didn't seem to have one at all before,
so I guess improvements can come incrementally afterward.

Have a look at the end of thumb_tr_translate_insn & insn_crosses_page to see
how to handle this properly.


r~

