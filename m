Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25424C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58D320879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvKeETXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58D320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZgl-0003Ww-74
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:49:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZff-00032r-Py
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQZfe-0001oW-9K
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:48:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQZfd-0001mT-U8
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:48:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id v11so1960984wru.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=QliX/gcLJ9eUChWcuj9RSp3lB6tBL211PbcgctmxdlA=;
	b=hvKeETXRhI32dR3mWOzGfGe+sAohEgkwEmop1APyCCkXkhMItdcb7DNJy2gDsjSDmf
	XMpiaih3KyVtevyaoReYsD16B1erYk9unDkPkaHAjdNOFR6p7YT0roNBgqLlxQ9JwPss
	ToxvjecrO+LfDVUiGMxB/fG2jd3TsBZ7QuVz3sJasUtNJastO0x6YKGrLSA/6Fdwv7K7
	1fTme7Dv89174DYfEvolng0+luTUYU1ZjQxAVO9vJwH3l16Ld3mTOFEHo8yc4Q4DTjB7
	bZ+iKyu24ykyjan3Rrsa1/Lu1OMYNgom+Xe9fzdF7l8a7fV9HWNHpzSWps/idO1+DX/u
	svIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=QliX/gcLJ9eUChWcuj9RSp3lB6tBL211PbcgctmxdlA=;
	b=qR4C/f9/NeY1yOtXolVBN/Px7QbugJBHVmIAIGobjFy8WMhEemexcrpUrfy2qSGQEK
	2bzWrTQ/HRYw9Y9hxpYhMZ/5mpn9nSN/D6tU4rO3U7OvSAgAjl0UhccxnaT365z5fH2Z
	nl1bKNVAnyInCuXUceCMooAiZUxJN8pC7jDfiZiXw2PR/QDMbKe0BwGWIwwC6Eb0Jg1D
	l8aRloJXf441uHAU7Ece+ZKdizIlHCDfz1xepF69W0bJPf8oMC/EKsYf3wU46QyQHllO
	TWNSF1DTd7Et4F4B/gBuI4IwH8CQOf0OVgh3RkFXUBdQvACbwg/V1DExj6VXA1Y0G5ux
	YstQ==
X-Gm-Message-State: APjAAAVY1k/0ubyHoAIFowf/IGBnzOMofdHrsZzjdHGIyLu28j5h8fmS
	CHzaEVhefMH3LDpvfcN3Jg+Z1Q==
X-Google-Smtp-Source: APXvYqy6THvZ6SRXcMDAnKldJngU8xND5FueBj816nIle41ppDPIJAQ1p926lq4rZnP6qrZUNIgUmA==
X-Received: by 2002:adf:dc8a:: with SMTP id r10mr22349551wrj.15.1557848925923; 
	Tue, 14 May 2019 08:48:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	f11sm10880737wrv.93.2019.05.14.08.48.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 08:48:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id BC7E81FF87;
	Tue, 14 May 2019 16:48:44 +0100 (BST)
References: <20190510185438.29533-1-richard.henderson@linaro.org>
	<20190510185438.29533-4-richard.henderson@linaro.org>
	<CAL1e-=hRXg7eykwjDxTDXt33FiFOAkkGQk23mEZRB3ChaZcAQA@mail.gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <CAL1e-=hRXg7eykwjDxTDXt33FiFOAkkGQk23mEZRB3ChaZcAQA@mail.gmail.com>
Date: Tue, 14 May 2019 16:48:44 +0100
Message-ID: <87bm05nijn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PULL v2 12/27] target/mips: Convert to
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, peter.maydell@linaro.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> On May 10, 2019 8:57 PM, "Richard Henderson" <richard.henderson@linaro.or=
g>
> wrote:
>>
>
> Please change the title to 'target/mips: Switch to using
> mips_cpu_tlb_fill()', or something along that line.

It does seem a little redundant as "target/mips:" already marks it as a
mips specific change and viewing the log you can see a series of
architectures being converted to a new API.

> Also, the reason for changing the field access_type to mips_access type
> should be explained in the commit message.

ok

> This commit message is generally poor, as it explains relatively
> unimportant logging issue, while not explaining the core of the
> change.

Surely the core of the change is explained in the main patches that
introduce the new API? I think it would be redundant to repeat that for
every individual architecture touched. It's a shame it's hard to
explicitly reference a patch in the same series as the commit hashes are
not yet permanent. At least when we fix things referring to the short
hash of the original commit is fairly easy.

Generally for an architecture conversion I want to know what might be
different from other architectures converted. If it is a broadly
mechanical change it doesn't need to be too detailed.

>
> Thanks,
> Aleksandar
>
>> Note that env->active_tc.PC is removed from the qemu_log as that value
>> is garbage.  The PC isn't recovered until cpu_restore_state, called from
>> cpu_loop_exit_restore, called from do_raise_exception_err.
>>
>> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
>> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/mips/internal.h  |  5 +++--
>>  target/mips/cpu.c       |  5 ++---
>>  target/mips/helper.c    | 45 ++++++++++++++++++++++-------------------
>>  target/mips/op_helper.c | 15 --------------
>>  4 files changed, 29 insertions(+), 41 deletions(-)
>>
>> diff --git a/target/mips/internal.h b/target/mips/internal.h
>> index 286e3888ab..b2b41a51ab 100644
>> --- a/target/mips/internal.h
>> +++ b/target/mips/internal.h
>> @@ -202,8 +202,9 @@ void cpu_mips_start_count(CPUMIPSState *env);
>>  void cpu_mips_stop_count(CPUMIPSState *env);
>>
>>  /* helper.c */
>> -int mips_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
> int rw,
>> -                              int mmu_idx);
>> +bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>> +                       MMUAccessType access_type, int mmu_idx,
>> +                       bool probe, uintptr_t retaddr);
>>
>>  /* op_helper.c */
>>  uint32_t float_class_s(uint32_t arg, float_status *fst);
>> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
>> index e217fb3e36..a33058609a 100644
>> --- a/target/mips/cpu.c
>> +++ b/target/mips/cpu.c
>> @@ -197,9 +197,7 @@ static void mips_cpu_class_init(ObjectClass *c, void
> *data)
>>      cc->synchronize_from_tb =3D mips_cpu_synchronize_from_tb;
>>      cc->gdb_read_register =3D mips_cpu_gdb_read_register;
>>      cc->gdb_write_register =3D mips_cpu_gdb_write_register;
>> -#ifdef CONFIG_USER_ONLY
>> -    cc->handle_mmu_fault =3D mips_cpu_handle_mmu_fault;
>> -#else
>> +#ifndef CONFIG_USER_ONLY
>>      cc->do_unassigned_access =3D mips_cpu_unassigned_access;
>>      cc->do_unaligned_access =3D mips_cpu_do_unaligned_access;
>>      cc->get_phys_page_debug =3D mips_cpu_get_phys_page_debug;
>> @@ -208,6 +206,7 @@ static void mips_cpu_class_init(ObjectClass *c, void
> *data)
>>      cc->disas_set_info =3D mips_cpu_disas_set_info;
>>  #ifdef CONFIG_TCG
>>      cc->tcg_initialize =3D mips_tcg_init;
>> +    cc->tlb_fill =3D mips_cpu_tlb_fill;
>>  #endif
>>
>>      cc->gdb_num_core_regs =3D 73;
>> diff --git a/target/mips/helper.c b/target/mips/helper.c
>> index 86e622efb8..3a4917ce7b 100644
>> --- a/target/mips/helper.c
>> +++ b/target/mips/helper.c
>> @@ -874,31 +874,25 @@ refill:
>>  #endif
>>  #endif
>>
>> -int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int
> rw,
>> -                              int mmu_idx)
>> +bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>> +                       MMUAccessType access_type, int mmu_idx,
>> +                       bool probe, uintptr_t retaddr)
>>  {
>>      MIPSCPU *cpu =3D MIPS_CPU(cs);
>>      CPUMIPSState *env =3D &cpu->env;
>>  #if !defined(CONFIG_USER_ONLY)
>>      hwaddr physical;
>>      int prot;
>> -    int access_type;
>> +    int mips_access_type;
>>  #endif
>>      int ret =3D TLBRET_BADADDR;
>>
>> -#if 0
>> -    log_cpu_state(cs, 0);
>> -#endif
>> -    qemu_log_mask(CPU_LOG_MMU,
>> -              "%s pc " TARGET_FMT_lx " ad %" VADDR_PRIx " rw %d mmu_idx
> %d\n",
>> -              __func__, env->active_tc.PC, address, rw, mmu_idx);
>> -
>>      /* data access */
>>  #if !defined(CONFIG_USER_ONLY)
>>      /* XXX: put correct access by using cpu_restore_state() correctly */
>> -    access_type =3D ACCESS_INT;
>> -    ret =3D get_physical_address(env, &physical, &prot,
>> -                               address, rw, access_type, mmu_idx);
>> +    mips_access_type =3D ACCESS_INT;
>> +    ret =3D get_physical_address(env, &physical, &prot, address,
>> +                               access_type, mips_access_type, mmu_idx);
>>      switch (ret) {
>>      case TLBRET_MATCH:
>>          qemu_log_mask(CPU_LOG_MMU,
>> @@ -915,7 +909,7 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr
> address, int size, int rw,
>>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>                       physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>>                       mmu_idx, TARGET_PAGE_SIZE);
>> -        return 0;
>> +        return true;
>>      }
>>  #if !defined(TARGET_MIPS64)
>>      if ((ret =3D=3D TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
>> @@ -926,27 +920,36 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr
> address, int size, int rw,
>>          int mode =3D (env->hflags & MIPS_HFLAG_KSU);
>>          bool ret_walker;
>>          env->hflags &=3D ~MIPS_HFLAG_KSU;
>> -        ret_walker =3D page_table_walk_refill(env, address, rw, mmu_idx=
);
>> +        ret_walker =3D page_table_walk_refill(env, address, access_type,
> mmu_idx);
>>          env->hflags |=3D mode;
>>          if (ret_walker) {
>> -            ret =3D get_physical_address(env, &physical, &prot,
>> -                                       address, rw, access_type,
> mmu_idx);
>> +            ret =3D get_physical_address(env, &physical, &prot, address,
>> +                                       access_type, mips_access_type,
> mmu_idx);=C2=BF
>>              if (ret =3D=3D TLBRET_MATCH) {
>>                  tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>                               physical & TARGET_PAGE_MASK, prot |
> PAGE_EXEC,
>>                               mmu_idx, TARGET_PAGE_SIZE);
>> -                return 0;
>> +                return true;
>>              }
>>          }
>>      }
>>  #endif
>> +    if (probe) {
>> +        return false;
>> +    }
>>  #endif
>>
>> -    raise_mmu_exception(env, address, rw, ret);
>> -    return 1;
>> +    raise_mmu_exception(env, address, access_type, ret);
>> +    do_raise_exception_err(env, cs->exception_index, env->error_code,
> retaddr);
>> +}
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +void tlb_fill(CPUState *cs, target_ulong addr, int size,
>> +              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
>> +{
>> +    mips_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false,
> retaddr);
>>  }
>>
>> -#if !defined(CONFIG_USER_ONLY)
>>  hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong
> address, int rw)
>>  {
>>      hwaddr physical;
>> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
>> index 0f272a5b93..6d86912958 100644
>> --- a/target/mips/op_helper.c
>> +++ b/target/mips/op_helper.c
>> @@ -2669,21 +2669,6 @@ void mips_cpu_do_unaligned_access(CPUState *cs,
> vaddr addr,
>>      do_raise_exception_err(env, excp, error_code, retaddr);
>>  }
>>
>> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
>> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
>> -{
>> -    int ret;
>> -
>> -    ret =3D mips_cpu_handle_mmu_fault(cs, addr, size, access_type,
> mmu_idx);
>> -    if (ret) {
>> -        MIPSCPU *cpu =3D MIPS_CPU(cs);
>> -        CPUMIPSState *env =3D &cpu->env;
>> -
>> -        do_raise_exception_err(env, cs->exception_index,
>> -                               env->error_code, retaddr);
>> -    }
>> -}
>> -
>>  void mips_cpu_unassigned_access(CPUState *cs, hwaddr addr,
>>                                  bool is_write, bool is_exec, int unused,
>>                                  unsigned size)
>> --
>> 2.17.1
>>
>>


--
Alex Benn=C3=A9e

