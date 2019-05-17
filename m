Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A867C04E87
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C91206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C91206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXH8-0005nj-4o
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 03:27:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRXGI-0005UO-Az
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRXGH-0000Mf-8m
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:26:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRXGH-0000M1-32
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:26:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so5896834wrq.12
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 00:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cWWkZVSi7GZOa0XFhJo3Cf05ON8RDWKfXr/QqgwSOVg=;
	b=od7dcv9Cb/BO6jKbm4sBTao5VFOu5Rj1mMsm4J9ZM2FZ4Z5NRtobMc3+xny5LJtAcf
	t2KgBiVZ6QLpbQ+y2fWaj6+kIB6/9/1eKoaHUvi472MkxjixMbGgsbXW65lXgpFIlicL
	bzoZi83dAHijpeArmXaOYD70IQFe7KqQIMx7uZgKOprgLwnTkG4isNx54uCjazlejlHb
	Z89YRvE57Ft4LvzrVBkhltD+UdLiXZkYcOJLowOHZCY1AyXNQ+LPhhhVXmC4K/AMv4LK
	DPnI8iFheeYhzn8MV5w+zSX2QaKu4ZU3/0XdFCUHuZuNSuC4pAOhTGYijdSLD8EAgy8m
	zWGg==
X-Gm-Message-State: APjAAAWqJgNYQPBUSA4d7gjrCCOlc5AAxbuRBr3gXCpTRzCJoaZooPTX
	CFkN5Z4tPoccqJSE+/Np8lMG9g==
X-Google-Smtp-Source: APXvYqzXhaHiByIiinlzBJECfC/S28f7K26k48T5/el8+qkpT4dkSg8a2RGFcBfeaC93gjjGqKtRYg==
X-Received: by 2002:a5d:4d92:: with SMTP id b18mr31897914wru.212.1558077995745;
	Fri, 17 May 2019 00:26:35 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id o81sm8730882wmb.2.2019.05.17.00.26.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 00:26:35 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190517045136.3509-1-richard.henderson@linaro.org>
	<20190517045136.3509-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <241b5521-877a-0df3-78f2-cf50c40a8215@redhat.com>
Date: Fri, 17 May 2019 09:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517045136.3509-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v14 11/13] target/rx: Convert to
 CPUClass::tlb_fill
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 6:51 AM, Richard Henderson wrote:
> The interface for tlb_fill has changed very recently.
> Move the function into cpu.c so that it may be static
> while assigning to the CPUClass methods.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/rx/cpu.c       | 14 ++++++++++++++
>  target/rx/op_helper.c | 11 -----------
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 4b96f2e463..3268077d08 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -143,6 +143,19 @@ static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
>      info->print_insn = print_insn_rx;
>  }
>  
> +static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> +                            MMUAccessType access_type, int mmu_idx,
> +                            bool probe, uintptr_t retaddr)
> +{
> +    uint32_t address, physical, prot;
> +
> +    /* Linear mapping */
> +    address = physical = addr & TARGET_PAGE_MASK;
> +    prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
> +    return true;
> +}
> +
>  static void rx_cpu_init(Object *obj)
>  {
>      CPUState *cs = CPU(obj);
> @@ -177,6 +190,7 @@ static void rxcpu_class_init(ObjectClass *klass, void *data)
>      cc->get_phys_page_debug = rx_cpu_get_phys_page_debug;
>      cc->disas_set_info = rx_cpu_disas_set_info;
>      cc->tcg_initialize = rx_translate_init;
> +    cc->tlb_fill = rx_cpu_tlb_fill;
>  
>      cc->gdb_num_core_regs = 26;
>  }
> diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
> index 9a460070e9..fb7ae3c3ec 100644
> --- a/target/rx/op_helper.c
> +++ b/target/rx/op_helper.c
> @@ -468,14 +468,3 @@ void QEMU_NORETURN helper_rxbrk(CPURXState *env)
>  {
>      raise_exception(env, 0x100, 0);
>  }
> -
> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> -{
> -    uint32_t address, physical, prot;
> -
> -    /* Linear mapping */
> -    address = physical = addr & TARGET_PAGE_MASK;
> -    prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> -    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
> -}
> 

