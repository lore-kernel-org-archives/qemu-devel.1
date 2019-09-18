Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB401C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704A021848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="pKPzZjRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704A021848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdHH-0002jv-PK
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iAcHm-0007OS-T7
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1iAcHk-0006LO-9B
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:54:30 -0400
Received: from zuban.uni-paderborn.de ([131.234.189.17]:45900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1iAcHg-0006HS-AE; Wed, 18 Sep 2019 11:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s4lpbnat6TSWjuKXDEHizuRR0GmBn3p4YXm2C/S1cFE=; b=pKPzZjRBFp39nQbzc9X+606ox+
 QWRZxzOy7YsUeAC1dRiLqbImMLs1XnDJQ5G3ebo8T4HrfEhbxG7C2103PGsfAMap0gOMQnoIjEvus
 KEZk6Bf0QDuLRPLb5OK5fb5T7B4N4nUkAcW1yif/FIrNrVgUpGlgoYEGqq9ovUBbadeQ=;
To: Peter Maydell <peter.maydell@linaro.org>,
 "Konopik, Andreas" <andreas.konopik@fau.de>
References: <9cf47438fa943b28ee987cea7b76a459@fau.de>
 <CAFEAcA-oP9QkYnQr1SQUvTks+9ySjDCn0G5yuULdOBepQi-PSw@mail.gmail.com>
 <75c41dce4fe333c0304f5e80e3ea6f34@fau.de>
 <CAFEAcA8q=QvwroUA3XQji5bqR5W4nXR=oUxbA16J0qP4Ch5sjA@mail.gmail.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <c60f34de-daef-3985-9bce-b780611222e7@mail.uni-paderborn.de>
Date: Wed, 18 Sep 2019 17:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8q=QvwroUA3XQji5bqR5W4nXR=oUxbA16J0qP4Ch5sjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.7.2805085, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.9.18.154817, AntiVirus-Engine: 5.65.0,
 AntiVirus-Data: 2019.9.9.5650001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.17
Subject: Re: [Qemu-devel] [Qemu-discuss] Segmentation fault on target tricore
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 9/17/19 3:45 PM, Peter Maydell wrote:
> On Tue, 17 Sep 2019 at 14:06, Konopik, Andreas <andreas.konopik@fau.de> wrote:
>>>> Using gdb and valgrind I found out that:
>>>> - 'gen_mtcr()' and 'gen_mfcr()' access uninitialized values, i.e.
>>>> CSFRs,
>>>> which leads to the Segfault
>>>> - The uninitialised values were created by stack allocation of
>>>> DisasContext in 'gen_intermediate_code()'
>>> This definitely sounds like a bug: do you have a stack
>>> backtrace from valgrind or gdb of the bad access and the
>>> segfault?
>>>
>>> [...]
>>> Thread 3 "qemu-system-tri" received signal SIGSEGV, Segmentation fault.
>>> [Switching to Thread 0x7ffff10a4700 (LWP 146730)]
>>> 0x00005555556edb67 in gen_mfcr (ret=0xab0, offset=<optimized out>,
>>>     ctx=<optimized out>)
>>>     at /home/akonopik/qemu_src/target/tricore/cpu.h:274
>>> 274       return (env->features & (1ULL << feature)) != 0;
>>> (gdb) bt
>>> #0  0x00005555556edb67 in gen_mfcr
>>>     (ret=0xab0, offset=<optimized out>, ctx=<optimized out>)
>>>     at /home/akonopik/qemu_src/target/tricore/cpu.h:274
> It looks like tricore_tr_init_disas_context() isn't
> initializing ctx->env. If this is the problem then this
> patch ought to fix it:
>
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index c574638c9f7..305d896cd2c 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -8793,6 +8793,7 @@ static void
> tricore_tr_init_disas_context(DisasContextBase *dcbase,
>       CPUTriCoreState *env = cs->env_ptr;
>       ctx->mem_idx = cpu_mmu_index(env, false);
>       ctx->hflags = (uint32_t)ctx->base.tb->flags;
> +    ctx->env = env;
>   }
>
>   static void tricore_tr_tb_start(DisasContextBase *db, CPUState *cpu)

thanks for the patch. I'll add it to my queue.


>
>
> Aside to Bastian: passing the CPU env pointer into the
> DisasContext isn't ideal, because it makes it quite easy
> for translate.c code to accidentally use fields of the
> env struct that aren't valid for use at translate time.
> I think the only uses of ctx->env you have are for checking
> feature bits -- I recommend following what target/arm does here:
>   * in tricore_tr_init_disas_context(), instead of copying the
>     env pointer, just copy env->features into ctx->features
>   * have a tricore_dc_feature(DisasContext *dc, int feature)
>     that checks for the feature bit in dc->features
>
> That way you only have access in translate.c code to
> information that's safe to bake into generated code, and
> it's harder to accidentally introduce bugs where generated
> code depends on CPU state that isn't kept in the TB flags.


Yes, this is not intended to stay this way. However, it was a necessary 
change for the translate_loop conversion. I'll try removing ctx->env 
from TriCore.

Cheers,

Bastian


>
> thanks
> -- PMM
>

