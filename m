Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60799C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E953D204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E953D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htaSm-0004yy-4r
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1htaRg-0004Rb-DX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1htaRf-0006GK-BT
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:30:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1htaRf-0006GC-1b
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:30:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so38110492edb.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IgZs9/bu+hNzUySYi56xoCCsgfcNUO/fADtUIzHzniE=;
 b=eyBBOD+Yumt69ClZIlbiRq4X0GyJgdFujJNYoCXlpuVjFN5quKWujfRWUQXFdHpjBM
 5aGtpcs1Q1BLnuI2QnS4vA25K4A4KXL9PuNBIBze9jR2jDY3iIG9edbvqtr8FFLzgfIO
 NDx9ynqDI2pWetIvZyrqmUKUwTJpKgR0TIAeJch9VxpVbMK70XnGxqpdu6l9dITkOmeK
 IIH7l3B7LPujE6puRdQvfEsAxSaZ7h2Ijo95oGYlZu6lhNPApzwtpIeIh77XoqTd2LQX
 MYhNriFVlc/lCB9TvFMVxSwQ/LrQwL/VyIk5chwAb6mDSqaBWKT49+yuvSI6WHqFprRB
 Hp9Q==
X-Gm-Message-State: APjAAAWUM9BV6YyC8dNYnt3S0FpctjNg9rgzlEhiO2rRfHQOSmQJM6nk
 Ucy7yHpMY9h6lO7ZITe+DiERvg==
X-Google-Smtp-Source: APXvYqyqEFopI6XouF/Hl/eiii1HpngwoBui/rZmQ7D7IPIaQuvKeyDBDlQbAvPBUZha+J2GFfH+hQ==
X-Received: by 2002:aa7:c999:: with SMTP id
 c25mr119387285edt.134.1564763418126; 
 Fri, 02 Aug 2019 09:30:18 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id r10sm18079209edp.25.2019.08.02.09.30.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:30:17 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190802160458.25681-1-peter.maydell@linaro.org>
 <20190802160458.25681-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <eacafaf4-07ff-48dc-f61f-92440e3809da@redhat.com>
Date: Fri, 2 Aug 2019 18:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190802160458.25681-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.66
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/mips/mips_jazz: Remove
 no-longer-necessary override of do_unassigned_access
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/2/19 6:04 PM, Peter Maydell wrote:
> Now that the MIPS CPU implementation uses the new
> do_transaction_failed hook, we can remove the old code that handled
> the do_unassigned_access hook.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/mips/mips_jazz.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index c64b4c78809..540943932fd 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -111,18 +111,6 @@ static const MemoryRegionOps dma_dummy_ops = {
>  #define MAGNUM_BIOS_SIZE_MAX 0x7e000
>  #define MAGNUM_BIOS_SIZE (BIOS_SIZE < MAGNUM_BIOS_SIZE_MAX ? BIOS_SIZE : MAGNUM_BIOS_SIZE_MAX)
>  
> -static CPUUnassignedAccess real_do_unassigned_access;
> -static void mips_jazz_do_unassigned_access(CPUState *cpu, hwaddr addr,
> -                                           bool is_write, bool is_exec,
> -                                           int opaque, unsigned size)
> -{
> -    if (!is_exec) {
> -        /* ignore invalid access (ie do not raise exception) */
> -        return;
> -    }
> -    (*real_do_unassigned_access)(cpu, addr, is_write, is_exec, opaque, size);
> -}
> -
>  static void (*real_do_transaction_failed)(CPUState *cpu, hwaddr physaddr,
>                                            vaddr addr, unsigned size,
>                                            MMUAccessType access_type,
> @@ -184,9 +172,8 @@ static void mips_jazz_init(MachineState *machine,
>       * However, we can't simply add a global memory region to catch
>       * everything, as this would make all accesses including instruction
>       * accesses be ignored and not raise exceptions.
> -     * So instead we hijack either the do_unassigned_access method or
> -     * the do_transaction_failed method on the CPU, and do not raise exceptions
> -     * for data access.
> +     * So instead we hijack the do_transaction_failed method on the CPU, and
> +     * do not raise exceptions for data access.
>       *
>       * NOTE: this behaviour of raising exceptions for bad instruction
>       * fetches but not bad data accesses was added in commit 54e755588cf1e9
> @@ -197,14 +184,8 @@ static void mips_jazz_init(MachineState *machine,
>       * memory region that catches all memory accesses, as we do on Malta.
>       */
>      cc = CPU_GET_CLASS(cpu);
> -    if (cc->do_unassigned_access) {
> -        real_do_unassigned_access = cc->do_unassigned_access;
> -        cc->do_unassigned_access = mips_jazz_do_unassigned_access;
> -    }
> -    if (cc->do_transaction_failed) {
> -        real_do_transaction_failed = cc->do_transaction_failed;
> -        cc->do_transaction_failed = mips_jazz_do_transaction_failed;
> -    }
> +    real_do_transaction_failed = cc->do_transaction_failed;
> +    cc->do_transaction_failed = mips_jazz_do_transaction_failed;
>  
>      /* allocate RAM */
>      memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

