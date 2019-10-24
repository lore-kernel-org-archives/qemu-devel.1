Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B13BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A0C20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="U1x/3X9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A0C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaJi-0006FI-8z
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clement.deschamps@greensocs.com>) id 1iNZua-00058p-HT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clement.deschamps@greensocs.com>) id 1iNZuY-0001w8-4U
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:00:07 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:55092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clement.deschamps@greensocs.com>)
 id 1iNZuX-0001sh-FP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:00:05 -0400
Received: from [172.16.11.101] (chartreuse.bar.greensocs.com [172.16.11.101])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 4707996EF0;
 Thu, 24 Oct 2019 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1571911202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9gx3x/BV5uVw/llW58jAcbuCRS44fJUYLcMjg4xA5I=;
 b=U1x/3X9Eep/HzxRJ4s/kSK3zPKkybeF5bKo/TAwEeJlC/qwej4f42+tbQWVXaK8C/lyTZ1
 TxlxQ5ZJ/oyuBCwa/til5ht2JZYF4OOFsbPBkgjDaqtbp8aw8s95CCzbuMeVaWohMS1dvU
 /Y2Yfak6z0Jd07Rvx89LO1WDkaXEuwQ=
Subject: Re: [PATCH] translate-all: Remove tb_alloc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191023164645.5518-1-richard.henderson@linaro.org>
From: Clement Deschamps <clement.deschamps@greensocs.com>
Message-ID: <3ecf74c2-379f-65bc-0442-83b9d9b1ddec@greensocs.com>
Date: Thu, 24 Oct 2019 11:59:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023164645.5518-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1571911202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9gx3x/BV5uVw/llW58jAcbuCRS44fJUYLcMjg4xA5I=;
 b=J+YnZTjFdfyQuuwaUayTvmzN5A2jkDOREl8qiwe7DuoXOqwU/F1Mhn4HFYv5ld+xnePb5b
 E9C8jMOTh5M57seTJfLQULwnY4nSopphmZ9OMbirHF7T9j/n7s14UEQqvynfJ2OMsM0dXP
 GB5l7D+o0HfmKVZRawoXhHIDyp1ImZo=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1571911202; a=rsa-sha256; cv=none;
 b=aKN8N58anbqJdtqQ7UDlb6KzxOAX4k/03aiViw6yvCBLSIw4899o2fdwKgPZTRItlpOkqk
 4lItt26wP4wKvz2FUvcOWJwPf9mMdOWGno2VfA1gwzvYIcLJFHrgsqrcyoOY+zF+LG0SRY
 sZdmEcKg1T2V6wemN7zEbsagTNevWOY=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=clement smtp.mailfrom=clement.deschamps@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 6:46 PM, Richard Henderson wrote:
> Since 2ac01d6dafab, this function does only two things: assert a
> lock is held, and call tcg_tb_alloc.  It is used exactly once,
> and its user has already done the assert.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Clement Deschamps <clement.deschamps@greensocs.com>

> 
> I noticed that this function was essentially a stub while
> reviewing Clement's tb->orig_tb fix.
> 
> Note that the added newline in tb_gen_code both adds the
> missing break after the variable declaration block and
> also happens to highlight the assert mentioned above.  ;-)
> 
> 
> r~
> 
> ---
>   accel/tcg/translate-all.c | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index f9b7ba159d..ae063b53f9 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1156,23 +1156,6 @@ void tcg_exec_init(unsigned long tb_size)
>   #endif
>   }
>   
> -/*
> - * Allocate a new translation block. Flush the translation buffer if
> - * too many translation blocks or too much generated code.
> - */
> -static TranslationBlock *tb_alloc(target_ulong pc)
> -{
> -    TranslationBlock *tb;
> -
> -    assert_memory_lock();
> -
> -    tb = tcg_tb_alloc(tcg_ctx);
> -    if (unlikely(tb == NULL)) {
> -        return NULL;
> -    }
> -    return tb;
> -}
> -
>   /* call with @p->lock held */
>   static inline void invalidate_page_bitmap(PageDesc *p)
>   {
> @@ -1681,6 +1664,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       TCGProfile *prof = &tcg_ctx->prof;
>       int64_t ti;
>   #endif
> +
>       assert_memory_lock();
>   
>       phys_pc = get_page_addr_code(env, pc);
> @@ -1706,7 +1690,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       }
>   
>    buffer_overflow:
> -    tb = tb_alloc(pc);
> +    tb = tcg_tb_alloc(tcg_ctx);
>       if (unlikely(!tb)) {
>           /* flush must be done */
>           tb_flush(cpu);
> 

