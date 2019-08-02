Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E268C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA0020644
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA0020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htaIr-0006ca-0G
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1htaI1-00069M-6v
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1htaHz-0000iJ-Mz
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:20:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1htaHz-0000hr-Ga
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:20:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so72923081edr.13
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=le200RFI3OKvTMiX6b6pdfhaK6ani0ZPTPHNw8uBXms=;
 b=fkPg5TadCAsKAH/oNZ1/S8GY0HfsQ9kTDgEyeBZVuwlStVYVTE0xf2K+7O9s9DC6+z
 cYZ/1/pqkQrp98BzuItopzETL9zGONmY/8YFaRDq325fSWVt08VhWGpfAPIQ9LYZ5KA2
 AkrovpdhDGi+T2k2wou4gIHQ7eIPeyH6q2YjY5FcTXELSaMJM80eJ6pIujDvN9PUIvCC
 ri7HEzc9KxA1XLprGGcEXzlFXIo+4BZTX4eDQnqgurEphznZO/+LIK3P4yVm569XtOvm
 MCfPlpPJ8/HMV6aVJ5GWOyV5mTy7C+Qgzfh2manyKM9kgtITXUhREAF7/9lsX0OdMUOk
 qWcA==
X-Gm-Message-State: APjAAAUxJFubkyEokLPWr4je09M+YhRLGM+ZToLgPaErWDut7lIcQz5m
 qrSHSt0nn37xDccXfOfgAS5Zbg==
X-Google-Smtp-Source: APXvYqxa1/W2Xbn1bjdQiEkk0WCYsei/Rty5FOaPVk/0W6F8AjAT/au7tzzINsZrVz6EIdfJbqar4w==
X-Received: by 2002:a17:907:20a6:: with SMTP id
 pw6mr95339302ejb.111.1564762817375; 
 Fri, 02 Aug 2019 09:20:17 -0700 (PDT)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id k8sm17808933edr.31.2019.08.02.09.20.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:20:16 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190802160458.25681-1-peter.maydell@linaro.org>
 <20190802160458.25681-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <02023d79-f128-1d9e-91aa-f789aff21bc7@redhat.com>
Date: Fri, 2 Aug 2019 18:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190802160458.25681-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.68
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/mips/mips_jazz: Override
 do_transaction_failed hook
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
> The MIPS Jazz ('magnum' and 'pica61') boards have some code which
> overrides the CPU's do_unassigned_access hook, so they can intercept
> it and not raise exceptions on data accesses to invalid addresses,
> only for instruction fetches.
> 
> We want to switch MIPS over to using the do_transaction_failed
> hook instead, so add an intercept for that as well, and make
> the board code install whichever hook the CPU is actually using.
> Once we've changed the CPU implementation we can remove the
> redundant code for the old hook.
> 
> Note: I am suspicious that the behaviour as implemented here may not
> be what the hardware really does.  It was added in commit
> 54e755588cf1e90f0b14 to restore the behaviour that was broken by
> commit c658b94f6e8c206c59d.  But prior to commit c658b94f6e8c206c59d
> every MIPS board generated exceptions for instruction access to
> invalid addresses but not for data accesses; and other boards,
> notably Malta, were fixed by making all invalid accesses behave as
> reads-as-zero (see the call to empty_slot_init() in
> mips_malta_init()).  Hardware that raises exceptions for instruction
> access and not data access seems to me to be an unlikely design, and
> it's possible that the right way to emulate this is to make the Jazz
> boards do what we did with Malta (or some variation of that).
> Nonetheless, since I don't have access to real hardware to test
> against I have taken the approach of "make QEMU continue to behave
> the same way it did before this commit".  I have updated the comment
> to correct the parts that are no longer accurate and note that
> the hardware might behave differently.
> 
> The test case for the need for the hook-hijacking is in
> https://bugs.launchpad.net/qemu/+bug/1245924 That BIOS will boot OK
> either with this overriding of both hooks, or with a simple "global
> memory region to ignore bad accesses of all types", so it doesn't
> provide evidence either way, unfortunately.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/mips/mips_jazz.c | 54 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index fa8775d4284..c64b4c78809 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -123,6 +123,28 @@ static void mips_jazz_do_unassigned_access(CPUState *cpu, hwaddr addr,
>      (*real_do_unassigned_access)(cpu, addr, is_write, is_exec, opaque, size);
>  }
>  
> +static void (*real_do_transaction_failed)(CPUState *cpu, hwaddr physaddr,
> +                                          vaddr addr, unsigned size,
> +                                          MMUAccessType access_type,
> +                                          int mmu_idx, MemTxAttrs attrs,
> +                                          MemTxResult response,
> +                                          uintptr_t retaddr);
> +
> +static void mips_jazz_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> +                                            vaddr addr, unsigned size,
> +                                            MMUAccessType access_type,
> +                                            int mmu_idx, MemTxAttrs attrs,
> +                                            MemTxResult response,
> +                                            uintptr_t retaddr)
> +{
> +    if (access_type != MMU_INST_FETCH) {
> +        /* ignore invalid access (ie do not raise exception) */
> +        return;
> +    }
> +    (*real_do_transaction_failed)(cs, physaddr, addr, size, access_type,
> +                                  mmu_idx, attrs, response, retaddr);
> +}
> +
>  static void mips_jazz_init(MachineState *machine,
>                             enum jazz_model_e jazz_model)
>  {
> @@ -157,16 +179,32 @@ static void mips_jazz_init(MachineState *machine,
>      env = &cpu->env;
>      qemu_register_reset(main_cpu_reset, cpu);
>  
> -    /* Chipset returns 0 in invalid reads and do not raise data exceptions.
> +    /*
> +     * Chipset returns 0 in invalid reads and do not raise data exceptions.
>       * However, we can't simply add a global memory region to catch
> -     * everything, as memory core directly call unassigned_mem_read/write
> -     * on some invalid accesses, which call do_unassigned_access on the
> -     * CPU, which raise an exception.
> -     * Handle that case by hijacking the do_unassigned_access method on
> -     * the CPU, and do not raise exceptions for data access. */
> +     * everything, as this would make all accesses including instruction
> +     * accesses be ignored and not raise exceptions.
> +     * So instead we hijack either the do_unassigned_access method or
> +     * the do_transaction_failed method on the CPU, and do not raise exceptions
> +     * for data access.
> +     *
> +     * NOTE: this behaviour of raising exceptions for bad instruction
> +     * fetches but not bad data accesses was added in commit 54e755588cf1e9
> +     * to restore behaviour broken by c658b94f6e8c206, but it is not clear
> +     * whether the real hardware behaves this way. It is possible that
> +     * real hardware ignores bad instruction fetches as well -- if so then
> +     * we could replace this hijacking of CPU methods with a simple global
> +     * memory region that catches all memory accesses, as we do on Malta.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +     */
>      cc = CPU_GET_CLASS(cpu);
> -    real_do_unassigned_access = cc->do_unassigned_access;
> -    cc->do_unassigned_access = mips_jazz_do_unassigned_access;
> +    if (cc->do_unassigned_access) {
> +        real_do_unassigned_access = cc->do_unassigned_access;
> +        cc->do_unassigned_access = mips_jazz_do_unassigned_access;
> +    }
> +    if (cc->do_transaction_failed) {
> +        real_do_transaction_failed = cc->do_transaction_failed;
> +        cc->do_transaction_failed = mips_jazz_do_transaction_failed;
> +    }
>  
>      /* allocate RAM */
>      memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
> 

