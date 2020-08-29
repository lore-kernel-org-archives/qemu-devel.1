Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4115C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 01:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F0B208CA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 01:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0RXAeMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F0B208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBpoX-0000nw-Ls
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 21:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBpo0-0000O4-Fg
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 21:37:20 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBpny-0002md-LC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 21:37:20 -0400
Received: by mail-pg1-x542.google.com with SMTP id l191so1252264pgd.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 18:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3TF8fW/oQcJFpiEMkhhsrcXa877aFiP3u202I1XIT2U=;
 b=J0RXAeMbLOT88nOehkRanVr0JAt0iATbCu5ubMykaNI08BSIIuVh0PQbz5kmcWcDVl
 fq7OEBPYTHzcWpi5se/SXG7xLqcZyyk1l/0BhTnR22kb/D1BPE+w/n8tldXY4SoNpflG
 zDZCJSdoZEjtK1gfz2biJImdx0xab9noYj2Z130zCqGF1eVedoS+MUnsux/yTb8qDc39
 Y+lOwJGHP/X6VhLSfRg5B43QegyfUdnBc/7x2dFwHP8wbFNakcOg74BNirEFLRcsWjG1
 aCGfyH7r3Z8HQRuc0MG/3lRpzQedrGLLVzO1IvJRc/rv0yBTW5X4bA2kpF7ZNp23bSfK
 iu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3TF8fW/oQcJFpiEMkhhsrcXa877aFiP3u202I1XIT2U=;
 b=XV4LAuAOOjRJg+hy11zooO22W4dPELkJH9kQS0msyR09tWTcV1Ovyz7/1aGlP5HqVn
 a7npdUSF6j1CFTi2TRbAYeUqa5RsNiR6zY9RyOOiAoEZ6X5WCVLDuZBg3L86+6+UmdrF
 DtaJotz2/LmWfzq0E0JFEJK94Bkxm7hrwl5OlOZhcIPIV6MI3bNhTAjURmrJk+cSjyhH
 M4O/XGsPICGjNzeRjznpMIW3NV2j6xObm2xbf47yMge9SMq9mCqqrovA6p1YUXhgCOjs
 eg1alBh7YoF37bd8qwJ6M6/6XjYniUeRKaXeDv/C4KQiG752Md6UufhGBrTxAi+zqgSe
 fUag==
X-Gm-Message-State: AOAM532YRMMqDRpKgk+YqEhq837VIK7+VWB2HvWgwBkxNNx4z3fGEOtt
 NYn7xaJ5tOiK42rcDsinenxeyw==
X-Google-Smtp-Source: ABdhPJxjaptmu7mMvSVqAcR5YGih2Zr93jDvuhtVv0r8+wh4ch9Bj501VJDhMxPpaFVBDZDrEHB1JA==
X-Received: by 2002:a62:cf85:: with SMTP id b127mr1411710pfg.89.1598665036322; 
 Fri, 28 Aug 2020 18:37:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y13sm701298pfr.142.2020.08.28.18.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 18:37:15 -0700 (PDT)
Subject: Re: [RFC PATCH v3 27/34] Hexagon (target/hexagon) instruction classes
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-28-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e360439e-7d6b-72eb-e5dd-026623e498b5@linaro.org>
Date: Fri, 28 Aug 2020 18:37:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-28-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> +} iclass_t;
...
> +extern const char *find_iclass_slots(opcode_t opcode, int itype);
...
> +typedef struct {
> +    const char * const slots;
> +} iclass_info_t;

I'll note that you aren't following our CODING_STYLE for types.  Which of these
need to match imported/ and which can you fix.

> +typedef enum {
> +
> +#define DEF_PP_ICLASS32(TYPE, SLOTS, UNITS)    ICLASS_FROM_TYPE(TYPE),
> +#define DEF_EE_ICLASS32(TYPE, SLOTS, UNITS)    /* nothing */
> +#include "imported/iclass.def"
> +#undef DEF_PP_ICLASS32
> +#undef DEF_EE_ICLASS32
> +
> +#define DEF_EE_ICLASS32(TYPE, SLOTS, UNITS)    ICLASS_FROM_TYPE(TYPE),
> +#define DEF_PP_ICLASS32(TYPE, SLOTS, UNITS)    /* nothing */
> +#include "imported/iclass.def"
> +#undef DEF_PP_ICLASS32
> +#undef DEF_EE_ICLASS32

Any particular reason why you're defining one as nothing, and doing this dance
twice?

> +const char *find_iclass_slots(opcode_t opcode, int itype)
> +{
> +    /* There are some exceptions to what the iclass dictates */
> +    if (GET_ATTRIB(opcode, A_ICOP)) {
> +        return "2";

Why are you returning a string and not a simple bitmask?

> +    [ICLASS_FROM_TYPE(TYPE)] = { .slots = #SLOTS },

This could be converted to the bitmask with

enum {
    SLOTS_0  = (1 << 0),
    SLOTS_1  = (1 << 1),
    SLOTS_23 = (1 << 2) | (1 << 3),
    ...
};

static const uint8_t iclass_info[] = {

#define DEF_ICLASS(TYPE, SLOTS) \
    [ICLASS_##TYPE] = SLOTS_##SLOTS
#define DEF_PP_ICLASS32(TYPE, SLOTS, UNITS) \
    DEF_ICLASS(TYPE, SLOTS)
#define DEF_EE_ICLASS32(TYPE, SLOTS, UNITS) \
    DEF_ICLASS(TYPE, SLOTS)

At which point the ultimate consumer,

>     for (i = 0, slot = 3; i < pkt->num_insns; i++) {
>         valid_slot_str = get_valid_slot_str(pkt, i);
> 
>         while (strchr(valid_slot_str, '0' + slot) == NULL) {
>             slot--;
>         }
>         pkt->insn[i].slot = slot;

becomes a simple integer mask check.


r~

