Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1BEC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D1520EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFSn64Yi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D1520EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCpMT-0002ed-PT
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 15:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCpLu-00029S-3W
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:20:26 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCpLs-0003y5-Cv
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:20:25 -0400
Received: by mail-pg1-x542.google.com with SMTP id l191so1192670pgd.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nHeZs8nX2SKkvxEteWKhyGDQHbnVHABvxqgIWChCNJE=;
 b=VFSn64YijmEMqpBYd+Qb4Gv21W9j9nDF/1wnlypT8muIK8lO80lLggi7WPFItJLm5r
 tiudmgSF+kLLOupXbLHYApBHTOPS9byFE4T71xrw0CCx9nUUBbh+Wxeu88JVSkE/FiD9
 NsxVDqYTxm0egw1bU8F+BTGucooNkXOCB7yxDcNiYX6TmUmzRHBLqL7guXX02S1uUuOb
 xIZpPcv83XoIABp2l4qtr8/sdHugk4KNqX5ifXnomIrG5cWCBBZAhsULg7ZA0rf/ZQeF
 mKDtKb8TRRGnJ1QSkacGquwNrJdF58PknlpgiGPCDQiEfBhML6zWkvM99ADy0k2f0330
 D5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nHeZs8nX2SKkvxEteWKhyGDQHbnVHABvxqgIWChCNJE=;
 b=JLpyLf0BkD/qQdP6gadOmxRVArKWgtyMyqwxS++lsBVlfCStpQ6Ro7jgBQBD+BMDG/
 KfTwFURuvO988bKkjlvw+vq6040CNzkYBqDvE5uskpWfZ/evF37WH4RpvlA7ZGpmu7Bj
 6iuweQHKQDkdroRIw5kCxdntFQeYlBfoOYDsDXEPnFT/7P3czaQv0zd9oLQW6anGibxp
 yYbysrIeCXylQdcNqXIb5Z8poXx9Hf7AIjFBXw0BJ4ln3SSXSa/7+8DD4IhZuAvBHjnz
 XYD2NGDHMFg7h1RWoGT2ZYY8a2UzHVMt9bkUAi9vIJOGKMAg1bLTMPfyd9TXtK7BPaax
 O58Q==
X-Gm-Message-State: AOAM532OqrDD+HTIXxY8zsJwIN9vkI0GjP6IWSJrZydVqxfFQcl1NWCm
 BTUQpHKXpikU0U5F+ycUuRAiag==
X-Google-Smtp-Source: ABdhPJwod9xfFdEpgWG/BxfYRSDj/KhWgY3BESddArw90AKseumo4OQFCJrS2jQTXSPHCohk8Ikc/g==
X-Received: by 2002:aa7:8e9c:: with SMTP id a28mr2404577pfr.20.1598901622608; 
 Mon, 31 Aug 2020 12:20:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x25sm6646066pgk.26.2020.08.31.12.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 12:20:21 -0700 (PDT)
Subject: Re: [RFC PATCH v3 30/34] Hexagon (target/hexagon) TCG for
 instructions with multiple definitions
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-31-git-send-email-tsimpson@quicinc.com>
 <10127f7e-a2df-2f19-e897-9a874f9a5d82@linaro.org>
 <BYAPR02MB488691F539AD3A2BFA1C819DDE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <a0987bce-409b-cd14-7559-c63413ff2b6f@linaro.org>
 <BYAPR02MB4886985CC5CBF78F7D5DBFE5DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
 <fca34122-160d-8c13-d237-a87a917f341b@linaro.org>
 <BYAPR02MB4886D48EDC604CEEF65FDAA7DE510@BYAPR02MB4886.namprd02.prod.outlook.com>
 <1cf57f2b-a2c8-6fbc-2c1c-9945a5d77dd8@linaro.org>
 <BYAPR02MB4886F055CBD52DBEE5F269AEDE510@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0241f731-61de-41bc-9f58-bc43725eef74@linaro.org>
Date: Mon, 31 Aug 2020 12:20:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886F055CBD52DBEE5F269AEDE510@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/31/20 11:14 AM, Taylor Simpson wrote:
> Just to be explicit, the code that generates code is generated as
>     #ifdef fGEN_TCG_A2_add
>     fGEN_TCG_A2_add({ RdV=RsV+RtV;});
>     #else
>     do {
>     gen_helper_A2_add(RdV, cpu_env, RsV, RtV);
>     } while (0);
>     #endif
> If we're going to have the generator know if there is an override, this would be more readable as either
>     fGEN_TCG_A2_add({ RdV=RsV+RtV;});
> or
>     gen_helper_A2_add(RdV, cpu_env, RsV, RtV);

Not quite, see below.

> In genptr.c, there is
>     #define DEF_TCG_FUNC(TAG, GENFN) \
>     static void generate_##TAG(CPUHexagonState *env, DisasContext *ctx, \
>                                insn_t *insn, packet_t *pkt) \
>     { \
>         GENFN \
>     }
>     #include "tcg_funcs_generated.h"
>     #undef DEF_TCG_FUNC
> The generated code only has the body of the function.  It would be more
> readable to move the static void generate_##TAG ... into the generated
> code.

Yes.

The fGEN_TCG_A2_add macro does not require nor use that {...} argument.  What
it *does* need are the same arguments as are given to generate_<rtag>.  I
assume you are using those arguments implicitly in your current fGEN_TCG_<rtag>
instances?

It would be cleanest to only have the generate_* functions.

Either they are written by hand (replacing the current fGEN_TCG_*), or they are
generated.  In either case, there's just the one level of indirection from
opcode_genptr[].

I'd imagine

--- genptr.c

#define DEF_TCG_FUNC(TAG) \
static void generate_##TAG(CPUHexagonState *env, \
    DisasContext *ctx, insn_t *insn, packet_t *pkt)

/*
 * All IIDs with an explicit implementation,
 * overriding the auto-generated helper functions.
 */

DEF_TCG_FUNC(A2_add)
{
    /* { RdV=RsV+RtV;} */
    tcg_gen_add_tl(args...);
}

/*
 * Generate calls to the auto-generate helpers,
 * and slot everything into the opcode_genptr table.
 */
#include "genptr_generated.c.inc"

--- genptr_generated.c.inc

DEF_TCG_FUNC(A4_tlbmatch)
{
   gen_helper_A4_tlbmatch(args...);
}

// etc

const SemanticInsn opcode_genptr[] = {
    // All IID's, generated or not.
};

---

This leaves genptr.c as the file to grep for '^DEF_TCG_FUNC'.


r~

