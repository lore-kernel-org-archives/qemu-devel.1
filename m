Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1684ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AD321835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rF9yOofi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AD321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLBH2-0004xV-Qv
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iLBFw-0004Jf-SA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 15:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iLBFv-0006B7-Di
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 15:16:16 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iLBFv-0006Ax-7E
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 15:16:15 -0400
Received: by mail-qk1-x742.google.com with SMTP id z67so2917736qkb.12
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 12:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q/if/YzVY0vrpW+AaFUeX3Dxm+8GTftMrVh2HO2eTrM=;
 b=rF9yOofit9Y9booGKtBG3FMMwpyhe083yCIymAbazeJgdCOHF3g8NWnp5K5VqLInvD
 j4Wj2xOk1erxttsLl5uDU+pJEWpGMrkGaYG2kkjBeLAHJecLZuB6HIA/pbuO8pRTv3a9
 snrdXSJUhFMkOhCjr3FigFwfRRbXqw5/3RmEYo245OmzlXc/0KqB6outcL1+hSMQtR9w
 WM4Yw9j1mkfC15NyLZEUPz8PqMq1meJ5oSnimYmykJTxEGSU5PCiP4Jb91l3ylO4dbKj
 toJUloLMoEXk349ekQ1LSZpE0cqFko6FODhyx4U/W69UY5QPJtdN9MwmhnVhVaiF20SZ
 81sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q/if/YzVY0vrpW+AaFUeX3Dxm+8GTftMrVh2HO2eTrM=;
 b=WzbII6+qKaXMSmSFu57dirQldEeb4kfXph7jOoriWEpStlBM/NpCU+D3W33dJNYcx1
 ubnXm38vHmM8KxJoFYT03rxTH3u8DybPfrLTdlKic2Xh+flq7JEGagX4NnZYEV2c3WP/
 FUANonCjr8zLKTgmYgAgLWjRc0FH/1czqYXpT5bx2RRP0ei5vM85bwPRLzy3PtO0aJX5
 AnhcHOIG8YyrYacYFpN6n55a2tys/KwY0FzDrLVeKPSYn0PgVCDWAFxSEQHtkteX39p1
 YVW9KdATihPO6e4afu31q2dtRRDuRjRircHa2x6VUA/I5ByTAaK8Py4JLVex5IXh6/Fn
 VL6w==
X-Gm-Message-State: APjAAAWkWNu/8i9Y7YNUSUJFzUc3GKjYFsAG/mBfnsT9y0j/YnHzD4XK
 ZO+q753rtmfkM1Qd1RBTlq2e53RDPS9heb3u96s=
X-Google-Smtp-Source: APXvYqz/gsiyyeL5K5iQ/FU+YnLeC3+ReP786husyAKRYDtYNzYB/NTOfslW4eDqGHxyZoP2X08div4Fxlhes2Wx054=
X-Received: by 2002:a37:4a91:: with SMTP id x139mr5013910qka.103.1571339773749; 
 Thu, 17 Oct 2019 12:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191014161843.84845-1-mrolnik@gmail.com>
 <20191014161843.84845-5-mrolnik@gmail.com>
 <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
In-Reply-To: <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 17 Oct 2019 22:15:22 +0300
Message-ID: <CAK4993gm=8tVXyprjHPMiNZuKZRkx0iDYnXh76cQfMwUayqcWQ@mail.gmail.com>
Subject: Re: [PATCH v32 04/13] target/avr: Add instruction translation -
 Registers definition
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 8:25 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Monday, October 14, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> ---
>>  target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 132 insertions(+)
>>  create mode 100644 target/avr/translate.c
>>
>> diff --git a/target/avr/translate.c b/target/avr/translate.c
>> new file mode 100644
>> index 0000000000..53c9892a60
>> --- /dev/null
>> +++ b/target/avr/translate.c
>> @@ -0,0 +1,132 @@
>> +/*
>> + * QEMU AVR CPU
>> + *
>> + * Copyright (c) 2019 Michael Rolnik
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see
>> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/qemu-print.h"
>> +#include "tcg/tcg.h"
>> +#include "cpu.h"
>> +#include "exec/exec-all.h"
>> +#include "disas/disas.h"
>> +#include "tcg-op.h"
>> +#include "exec/cpu_ldst.h"
>> +#include "exec/helper-proto.h"
>> +#include "exec/helper-gen.h"
>> +#include "exec/log.h"
>> +#include "exec/gdbstub.h"
>> +#include "exec/translator.h"
>> +#include "exec/gen-icount.h"
>> +
>> +/*
>> + *  Define if you want a BREAK instruction translated to a breakpoint
>> + *  Active debugging connection is assumed
>> + *  This is for
>> + *  https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests
>> + *  tests
>> + */
>> +#undef BREAKPOINT_ON_BREAK
>> +
>> +static TCGv cpu_pc;
>> +
>> +static TCGv cpu_Cf;
>> +static TCGv cpu_Zf;
>> +static TCGv cpu_Nf;
>> +static TCGv cpu_Vf;
>> +static TCGv cpu_Sf;
>> +static TCGv cpu_Hf;
>> +static TCGv cpu_Tf;
>> +static TCGv cpu_If;
>> +
>
>
> Hello, Michael,
>
> Is there any particular reason or motivation beyond modelling status register flags as TCGv variables?
I think it's easier this way as I don't need to convert flag values to
bits or bits to flag values.
>
> A.
>
>
>
>>
>> +static TCGv cpu_rampD;
>> +static TCGv cpu_rampX;
>> +static TCGv cpu_rampY;
>> +static TCGv cpu_rampZ;
>> +
>> +static TCGv cpu_r[NO_CPU_REGISTERS];
>> +static TCGv cpu_eind;
>> +static TCGv cpu_sp;
>> +
>> +static TCGv cpu_skip;
>> +
>> +static const char reg_names[NO_CPU_REGISTERS][8] = {
>> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
>> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
>> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
>> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
>> +};
>> +#define REG(x) (cpu_r[x])
>> +
>> +enum {
>> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu main loop.  */
>> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition exit.  */
>> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition exit.  */
>> +};
>> +
>> +typedef struct DisasContext DisasContext;
>> +
>> +/* This is the state at translation time. */
>> +struct DisasContext {
>> +    TranslationBlock *tb;
>> +
>> +    CPUAVRState *env;
>> +    CPUState *cs;
>> +
>> +    target_long npc;
>> +    uint32_t opcode;
>> +
>> +    /* Routine used to access memory */
>> +    int memidx;
>> +    int bstate;
>> +    int singlestep;
>> +
>> +    TCGv skip_var0;
>> +    TCGv skip_var1;
>> +    TCGCond skip_cond;
>> +    bool free_skip_var0;
>> +};
>> +
>> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
>> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
>> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * 2; }
>> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
>> +
>> +static uint16_t next_word(DisasContext *ctx)
>> +{
>> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
>> +}
>> +
>> +static int append_16(DisasContext *ctx, int x)
>> +{
>> +    return x << 16 | next_word(ctx);
>> +}
>> +
>> +
>> +static bool avr_have_feature(DisasContext *ctx, int feature)
>> +{
>> +    if (!avr_feature(ctx->env, feature)) {
>> +        gen_helper_unsupported(cpu_env);
>> +        ctx->bstate = DISAS_NORETURN;
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
>> +#include "decode_insn.inc.c"
>> +
>> --
>> 2.17.2 (Apple Git-113)
>>


-- 
Best Regards,
Michael Rolnik

