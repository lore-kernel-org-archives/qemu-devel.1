Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08535C31E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB263208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="Tvdp1Fvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB263208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56434 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCuy-0006ri-2h
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 08:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54877)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hdCsW-00056C-Sl
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hdCsU-0008Lq-EV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:06:20 -0400
Received: from zuban.uni-paderborn.de ([131.234.189.17]:56396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1hdCsT-0008JI-7X
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UpBc2gC0PNmBLe+ouO8lAHJvOj3PjD78VP1HxCCco7c=; b=Tvdp1FvmI+/zuNZ40kiLJmdg8g
 74JcVZASL4OB7y7Tuu9fnCyqF4RZx1bl7xyjc/4aOEAk3Q1L1R1fLoU3hxB7wiNhu9AKFNGSLxSDF
 1iRi2g5PkttID1tJBTgoO4ohqYWI0XreToqtXFz57QoSmUeMg86kSYaPp04RIkYkXoy4=;
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190617143533.15013-1-kbastian@mail.uni-paderborn.de>
 <20190617143533.15013-4-kbastian@mail.uni-paderborn.de>
 <b2f6e776-90e4-3809-350f-ce2bf6d69017@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <9d2149ef-57f5-c4b7-220c-81483b108f24@mail.uni-paderborn.de>
Date: Tue, 18 Jun 2019 14:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <b2f6e776-90e4-3809-350f-ce2bf6d69017@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.6.18.115716, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.6.4.5630002
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.17
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


On 6/17/19 6:45 PM, Richard Henderson wrote:
> On 6/17/19 7:35 AM, Bastian Koppelmann wrote:
>> +static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
>> +                                          CPUState *cs)
>>   {
>> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
>>       CPUTriCoreState *env = cs->env_ptr;
>> +    ctx->base.pc_next = ctx->base.pc_first;
> This is already done in generic code.
>
> I don't see an initialization of hflags & saved_hflags?
> Although I don't see that either before or afterward...
Yes, I mentioned this problem in David's patch 
(https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01058.html). 
If he doesn't fix it, I will in a follow-up patch.
>
>> +static bool tricore_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
>> +                                      const CPUBreakpoint *bp)
>> +{
>> +    return true;
>> +}
> Not supporting breakpoints, I think it's better to return false here.
>
> Although it's not difficult -- just raise EXCP_DEBUG as an exception.
> It'd be nice to follow up and fix this afterward.
Yes, I will do that.
>
>> +static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>> +{
>> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
>> +    CPUTriCoreState *env = cpu->env_ptr;
>> +
>> +    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
>> +    decode_opc(ctx);
>> +    ctx->base.pc_next = ctx->pc_succ_insn;
>> +
>> +    if (ctx->base.is_jmp == DISAS_NEXT) {
>> +        target_ulong page_start;
>> +
>> +        page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
>> +        if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE) {
>> +            ctx->base.is_jmp = DISAS_TOO_MANY;
>>           }
> This isn't perfect as an ending, but you didn't seem to have one at all before,
> so I guess improvements can come incrementally afterward.
>
> Have a look at the end of thumb_tr_translate_insn & insn_crosses_page to see
> how to handle this properly.

I copied it more or less from target/riscv. I guess that needs fixing as 
well :)

Cheers,

Bastian



