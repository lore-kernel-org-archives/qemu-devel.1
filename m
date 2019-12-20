Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA4C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059B321655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keiYS+cJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059B321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiN6V-0003u1-7h
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiN5j-0003Qw-Qh
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiN5h-00013E-9i
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:33:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiN5g-0000zt-VM
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:33:33 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so10315523wre.10
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/2GibOZTuCfZCQGcLoydIqhLkWY0ZYWAy0LuelEX3Qw=;
 b=keiYS+cJHd9O3X371Bbp2OgITkPC5aaZvnZfHXX1XdmKY2ZTeSCxA2MoXWhPQBL5Z+
 9FmB4FPZRUA8bOMTz3IOUt6Elaq1pIF8dhsyennbxsaxRDTB5pMuGs9GGC5o5Gj0h94e
 a/7CTcurWCD8bCjs+v2Z9o5N0lwtjLQa6JbbLMLKKKk9qq1UAwotbRlwZzJI9LUkon6o
 8rPtrzZw4hUe12Cr30MRWEAm0aAbsnPiB8XxR7Zk22OhrROydsmkfZuyV4VTTcsWLvt6
 FWO2fy+fDhdARXyJC4xCgRkezT5bDI1N0mgZjN337YebZlP6L6cY0nwkhc+EI+DRmAZx
 nLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/2GibOZTuCfZCQGcLoydIqhLkWY0ZYWAy0LuelEX3Qw=;
 b=OEFHFC+0u6wthb9G5QaCgDRkVEuzIFO5pISFdjLfXDjo/43qw9qJF4tqlCCVO0476N
 CN1WTjYwiei01p9YVNSit8ztHEHoYbrHiGYfIB4gIBsyBHm6ywVocTjje11eoM/IPzr0
 3AulsH+NPOLMlaJ9H2LOBFq/Tj1CDdIshHHWA85lUk0oSXjebQ9VQCjXtbJ2mqilYajc
 +BuIl/AzXMh7uQJTpuXAj1AtwYFcHOLwwM//w5potM7qJooBlUkhVH3iUd3M+gHMjJYR
 SEO1W9J7aPpQSsP0wE1G1PXTbFGywoCTXPJLJLPq/sonldA4kKHoNlPmn6nXie42Ha0p
 K6sQ==
X-Gm-Message-State: APjAAAVTLcIVx+YnrHhZMLtjtqPBPmtFpMMrqh8Us2J6cPJc/f7M/Oe1
 t/f6R9eDDNmcss/LyerEwNnCcEQXUEE=
X-Google-Smtp-Source: APXvYqzXBxsEqgyX1ndIyzdu5Z8u0jcOLRcIAqoInEAzZjDqeSMvKP8ZXsJ6W/XmUmMbCuIHDec/og==
X-Received: by 2002:adf:cd03:: with SMTP id w3mr16136859wrm.191.1576866810423; 
 Fri, 20 Dec 2019 10:33:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x14sm10299271wmj.42.2019.12.20.10.33.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 10:33:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 296B11FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 18:33:28 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-5-richard.henderson@linaro.org>
 <87zhfnc4d8.fsf@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 04/28] cputlb: Move body of cpu_ldst_template.h out
 of line
In-reply-to: <87zhfnc4d8.fsf@linaro.org>
Date: Fri, 20 Dec 2019 18:33:28 +0000
Message-ID: <87mubmc0ef.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> With the tracing hooks, the inline functions are no longer
>> so simple.  Once out-of-line, the current tlb_entry lookup
>> is redundant with the one in the main load/store_helper.
>>
>> This also begins the introduction of a new target facing
>> interface, with suffix *_mmuidx_ra.  This is not yet
>> official because the interface is not done for user-only.
>>
>> Use abi_ptr instead of target_ulong in preparation for
>> user-only; the two types are identical for softmmu.
>>
>> What remains in cpu_ldst_template.h are the expansions
>> for _code, _data, and MMU_MODE<N>_SUFFIX.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Although this seems to have broken --enable-plugins builds:

    CC      aarch64-softmmu/plugins/api.o
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c: In function =E2=80=98qemu_=
plugin_mem_size_shift=E2=80=99:
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:229:19: error: =E2=80=98TRA=
CE_MEM_SZ_SHIFT_MASK=E2=80=99 undeclared (first use in this function)
       return info & TRACE_MEM_SZ_SHIFT_MASK;
                     ^~~~~~~~~~~~~~~~~~~~~~~
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:229:19: note: each undeclar=
ed identifier is reported only once for each function it appears in
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c: In function =E2=80=98qemu_=
plugin_mem_is_sign_extended=E2=80=99:
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:234:22: error: =E2=80=98TRA=
CE_MEM_SE=E2=80=99 undeclared (first use in this function)
       return !!(info & TRACE_MEM_SE);
                        ^~~~~~~~~~~~
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c: In function =E2=80=98qemu_=
plugin_mem_is_big_endian=E2=80=99:
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:239:22: error: =E2=80=98TRA=
CE_MEM_BE=E2=80=99 undeclared (first use in this function)
       return !!(info & TRACE_MEM_BE);
                        ^~~~~~~~~~~~
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c: In function =E2=80=98qemu_=
plugin_mem_is_store=E2=80=99:
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:244:22: error: =E2=80=98TRA=
CE_MEM_ST=E2=80=99 undeclared (first use in this function)
       return !!(info & TRACE_MEM_ST);
                        ^~~~~~~~~~~~
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c: In function =E2=80=98qemu_=
plugin_get_hwaddr=E2=80=99:
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:258:36: error: =E2=80=98TRA=
CE_MEM_MMU_SHIFT=E2=80=99 undeclared (first use in this function); did you =
mean =E2=80=98TCP_MAX_WINSHIFT=E2=80=99?
       unsigned int mmu_idx =3D info >> TRACE_MEM_MMU_SHIFT;
                                      ^~~~~~~~~~~~~~~~~~~
                                      TCP_MAX_WINSHIFT
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:259:35: error: =E2=80=98TRA=
CE_MEM_ST=E2=80=99 undeclared (first use in this function); did you mean =
=E2=80=98TRACE_MEM_MMU_SHIFT=E2=80=99?
       hwaddr_info.is_store =3D info & TRACE_MEM_ST;
                                     ^~~~~~~~~~~~
                                     TRACE_MEM_MMU_SHIFT
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c: In function =E2=80=98qemu_=
plugin_mem_size_shift=E2=80=99:
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:230:1: error: control reach=
es end of non-void function [-Werror=3Dreturn-type]
   }
   ^
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c: In function =E2=80=98qemu_=
plugin_mem_is_sign_extended=E2=80=99:
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:235:1: error: control reach=
es end of non-void function [-Werror=3Dreturn-type]
   }
   ^
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c: In function =E2=80=98qemu_=
plugin_mem_is_big_endian=E2=80=99:
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:240:1: error: control reach=
es end of non-void function [-Werror=3Dreturn-type]
   }
   ^
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c: In function =E2=80=98qemu_=
plugin_mem_is_store=E2=80=99:
  /home/alex.bennee/lsrc/qemu.git/plugins/api.c:245:1: error: control reach=
es end of non-void function [-Werror=3Dreturn-type]
   }
   ^
  cc1: all warnings being treated as errors
  /home/alex.bennee/lsrc/qemu.git/rules.mak:69: recipe for target 'plugins/=
api.o' failed
  make[1]: *** [plugins/api.o] Error 1
  Makefile:491: recipe for target 'aarch64-softmmu/all' failed
  make: *** [aarch64-softmmu/all] Error 2


>
>> ---
>>  include/exec/cpu_ldst.h          |  25 ++++++-
>>  include/exec/cpu_ldst_template.h | 125 +++++++------------------------
>>  accel/tcg/cputlb.c               | 116 ++++++++++++++++++++++++++++
>>  3 files changed, 166 insertions(+), 100 deletions(-)
>>
>> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
>> index fd499f7e2f..cf8af36dbc 100644
>> --- a/include/exec/cpu_ldst.h
>> +++ b/include/exec/cpu_ldst.h
>> @@ -152,7 +152,7 @@ static inline void clear_helper_retaddr(void)
>>=20=20
>>  #else
>>=20=20
>> -/* The memory helpers for tcg-generated code need tcg_target_long etc. =
 */
>> +/* Needed for TCG_OVERSIZED_GUEST */
>>  #include "tcg.h"
>>=20=20
>>  static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
>> @@ -185,6 +185,29 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *=
env, uintptr_t mmu_idx,
>>      return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr=
)];
>>  }
>>=20=20
>> +uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                            int mmu_idx, uintptr_t ra);
>> +uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                            int mmu_idx, uintptr_t ra);
>> +uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                           int mmu_idx, uintptr_t ra);
>> +uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                           int mmu_idx, uintptr_t ra);
>> +
>> +int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                       int mmu_idx, uintptr_t ra);
>> +int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                       int mmu_idx, uintptr_t ra);
>> +
>> +void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
>> +                       int mmu_idx, uintptr_t retaddr);
>> +void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
>> +                       int mmu_idx, uintptr_t retaddr);
>> +void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
>> +                       int mmu_idx, uintptr_t retaddr);
>> +void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
>> +                       int mmu_idx, uintptr_t retaddr);
>> +
>>  #ifdef MMU_MODE0_SUFFIX
>>  #define CPU_MMU_INDEX 0
>>  #define MEMSUFFIX MMU_MODE0_SUFFIX
>> diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_te=
mplate.h
>> index 0ad5de3ef9..ea39e29c19 100644
>> --- a/include/exec/cpu_ldst_template.h
>> +++ b/include/exec/cpu_ldst_template.h
>> @@ -24,13 +24,6 @@
>>   * License along with this library; if not, see <http://www.gnu.org/lic=
enses/>.
>>   */
>>=20=20
>> -#if !defined(SOFTMMU_CODE_ACCESS)
>> -#include "trace-root.h"
>> -#endif
>> -
>> -#include "qemu/plugin.h"
>> -#include "trace/mem.h"
>> -
>>  #if DATA_SIZE =3D=3D 8
>>  #define SUFFIX q
>>  #define USUFFIX q
>> @@ -63,56 +56,40 @@
>>  #define RES_TYPE uint32_t
>>  #endif
>>=20=20
>> +/* generic load/store macros */
>> +
>>  #ifdef SOFTMMU_CODE_ACCESS
>> -#define ADDR_READ addr_code
>> -#define MMUSUFFIX _cmmu
>> -#define URETSUFFIX USUFFIX
>> -#define SRETSUFFIX glue(s, SUFFIX)
>> -#else
>> -#define ADDR_READ addr_read
>> -#define MMUSUFFIX _mmu
>> -#define URETSUFFIX USUFFIX
>> -#define SRETSUFFIX glue(s, SUFFIX)
>> +
>> +static inline RES_TYPE
>> +glue(glue(cpu_ld, USUFFIX), _code)(CPUArchState *env, target_ulong ptr)
>> +{
>> +    TCGMemOpIdx oi =3D make_memop_idx(MO_TE | SHIFT, CPU_MMU_INDEX);
>> +    return glue(glue(helper_ret_ld, USUFFIX), _cmmu)(env, ptr, oi, 0);
>> +}
>> +
>> +#if DATA_SIZE <=3D 2
>> +static inline int
>> +glue(glue(cpu_lds, SUFFIX), _code)(CPUArchState *env, target_ulong ptr)
>> +{
>> +    return (DATA_STYPE)glue(glue(cpu_ld, USUFFIX), _code)(env, ptr);
>> +}
>>  #endif
>>=20=20
>> -/* generic load/store macros */
>> +#else
>>=20=20
>>  static inline RES_TYPE
>>  glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
>>                                                    target_ulong ptr,
>>                                                    uintptr_t retaddr)
>>  {
>> -    CPUTLBEntry *entry;
>> -    RES_TYPE res;
>> -    target_ulong addr;
>> -    int mmu_idx =3D CPU_MMU_INDEX;
>> -    MemOp op =3D MO_TE | SHIFT;
>> -#if !defined(SOFTMMU_CODE_ACCESS)
>> -    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, false);
>> -    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>> -#endif
>> -
>> -    addr =3D ptr;
>> -    entry =3D tlb_entry(env, mmu_idx, addr);
>> -    if (unlikely(entry->ADDR_READ !=3D
>> -                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
>> -        TCGMemOpIdx oi =3D make_memop_idx(op, mmu_idx);
>> -        res =3D glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, a=
ddr,
>> -                                                               oi, reta=
ddr);
>> -    } else {
>> -        uintptr_t hostaddr =3D addr + entry->addend;
>> -        res =3D glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
>> -    }
>> -#ifndef SOFTMMU_CODE_ACCESS
>> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
>> -#endif
>> -    return res;
>> +    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_IN=
DEX,
>> +                                                   retaddr);
>>  }
>>=20=20
>>  static inline RES_TYPE
>>  glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong =
ptr)
>>  {
>> -    return glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(env, ptr, =
0);
>> +    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_IN=
DEX, 0);
>>  }
>>=20=20
>>  #if DATA_SIZE <=3D 2
>> @@ -121,42 +98,17 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(C=
PUArchState *env,
>>                                                    target_ulong ptr,
>>                                                    uintptr_t retaddr)
>>  {
>> -    CPUTLBEntry *entry;
>> -    int res;
>> -    target_ulong addr;
>> -    int mmu_idx =3D CPU_MMU_INDEX;
>> -    MemOp op =3D MO_TE | MO_SIGN | SHIFT;
>> -#ifndef SOFTMMU_CODE_ACCESS
>> -    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, false);
>> -    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>> -#endif
>> -
>> -    addr =3D ptr;
>> -    entry =3D tlb_entry(env, mmu_idx, addr);
>> -    if (unlikely(entry->ADDR_READ !=3D
>> -                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
>> -        TCGMemOpIdx oi =3D make_memop_idx(op & ~MO_SIGN, mmu_idx);
>> -        res =3D (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
>> -                               MMUSUFFIX)(env, addr, oi, retaddr);
>> -    } else {
>> -        uintptr_t hostaddr =3D addr + entry->addend;
>> -        res =3D glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
>> -    }
>> -#ifndef SOFTMMU_CODE_ACCESS
>> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
>> -#endif
>> -    return res;
>> +    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_IN=
DEX,
>> +                                                   retaddr);
>>  }
>>=20=20
>>  static inline int
>>  glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong =
ptr)
>>  {
>> -    return glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(env, ptr, =
0);
>> +    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_IN=
DEX, 0);
>>  }
>>  #endif
>>=20=20
>> -#ifndef SOFTMMU_CODE_ACCESS
>> -
>>  /* generic store macro */
>>=20=20
>>  static inline void
>> @@ -164,36 +116,15 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(C=
PUArchState *env,
>>                                                   target_ulong ptr,
>>                                                   RES_TYPE v, uintptr_t =
retaddr)
>>  {
>> -    CPUTLBEntry *entry;
>> -    target_ulong addr;
>> -    int mmu_idx =3D CPU_MMU_INDEX;
>> -    MemOp op =3D MO_TE | SHIFT;
>> -#if !defined(SOFTMMU_CODE_ACCESS)
>> -    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, true);
>> -    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>> -#endif
>> -
>> -    addr =3D ptr;
>> -    entry =3D tlb_entry(env, mmu_idx, addr);
>> -    if (unlikely(tlb_addr_write(entry) !=3D
>> -                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
>> -        TCGMemOpIdx oi =3D make_memop_idx(op, mmu_idx);
>> -        glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
>> -                                                     retaddr);
>> -    } else {
>> -        uintptr_t hostaddr =3D addr + entry->addend;
>> -        glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
>> -    }
>> -#ifndef SOFTMMU_CODE_ACCESS
>> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
>> -#endif
>> +    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX,
>> +                                           retaddr);
>>  }
>>=20=20
>>  static inline void
>>  glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong p=
tr,
>>                                        RES_TYPE v)
>>  {
>> -    glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(env, ptr, v, 0);
>> +    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX, =
0);
>>  }
>>=20=20
>>  #endif /* !SOFTMMU_CODE_ACCESS */
>> @@ -204,8 +135,4 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *=
env, target_ulong ptr,
>>  #undef SUFFIX
>>  #undef USUFFIX
>>  #undef DATA_SIZE
>> -#undef MMUSUFFIX
>> -#undef ADDR_READ
>> -#undef URETSUFFIX
>> -#undef SRETSUFFIX
>>  #undef SHIFT
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index 98221948d6..ddd19718bf 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -34,6 +34,9 @@
>>  #include "qemu/atomic.h"
>>  #include "qemu/atomic128.h"
>>  #include "translate-all.h"
>> +#include "trace-root.h"
>> +#include "qemu/plugin.h"
>> +#include "trace/mem.h"
>>  #ifdef CONFIG_PLUGIN
>>  #include "qemu/plugin-memory.h"
>>  #endif
>> @@ -1625,6 +1628,75 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState =
*env, target_ulong addr,
>>      return (int32_t)helper_be_ldul_mmu(env, addr, oi, retaddr);
>>  }
>>=20=20
>> +/*
>> + * Load helpers for cpu_ldst.h.
>> + */
>> +
>> +static inline uint64_t cpu_load_helper(CPUArchState *env, abi_ptr addr,
>> +                                       int mmu_idx, uintptr_t retaddr,
>> +                                       MemOp op, FullLoadHelper *full_l=
oad)
>> +{
>> +    uint16_t meminfo;
>> +    TCGMemOpIdx oi;
>> +    uint64_t ret;
>> +
>> +    meminfo =3D trace_mem_get_info(op, mmu_idx, false);
>> +    trace_guest_mem_before_exec(env_cpu(env), addr, meminfo);
>> +
>> +    op &=3D ~MO_SIGN;
>> +    oi =3D make_memop_idx(op, mmu_idx);
>> +    ret =3D full_load(env, addr, oi, retaddr);
>> +
>> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, meminfo);
>> +
>> +    return ret;
>> +}
>> +
>> +uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                            int mmu_idx, uintptr_t ra)
>> +{
>> +    return cpu_load_helper(env, addr, mmu_idx, ra, MO_UB, full_ldub_mmu=
);
>> +}
>> +
>> +int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                       int mmu_idx, uintptr_t ra)
>> +{
>> +    return (int8_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_SB,
>> +                                   full_ldub_mmu);
>> +}
>> +
>> +uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                            int mmu_idx, uintptr_t ra)
>> +{
>> +    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUW,
>> +                           MO_TE =3D=3D MO_LE
>> +                           ? full_le_lduw_mmu : full_be_lduw_mmu);
>> +}
>> +
>> +int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                       int mmu_idx, uintptr_t ra)
>> +{
>> +    return (int16_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_TESW,
>> +                                    MO_TE =3D=3D MO_LE
>> +                                    ? full_le_lduw_mmu : full_be_lduw_m=
mu);
>> +}
>> +
>> +uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                           int mmu_idx, uintptr_t ra)
>> +{
>> +    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUL,
>> +                           MO_TE =3D=3D MO_LE
>> +                           ? full_le_ldul_mmu : full_be_ldul_mmu);
>> +}
>> +
>> +uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>> +                           int mmu_idx, uintptr_t ra)
>> +{
>> +    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEQ,
>> +                           MO_TE =3D=3D MO_LE
>> +                           ? helper_le_ldq_mmu : helper_be_ldq_mmu);
>> +}
>> +
>>  /*
>>   * Store Helpers
>>   */
>> @@ -1854,6 +1926,50 @@ void helper_be_stq_mmu(CPUArchState *env, target_=
ulong addr, uint64_t val,
>>      store_helper(env, addr, val, oi, retaddr, MO_BEQ);
>>  }
>>=20=20
>> +/*
>> + * Store Helpers for cpu_ldst.h
>> + */
>> +
>> +static inline void QEMU_ALWAYS_INLINE
>> +cpu_store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>> +                 int mmu_idx, uintptr_t retaddr, MemOp op)
>> +{
>> +    TCGMemOpIdx oi;
>> +    uint16_t meminfo;
>> +
>> +    meminfo =3D trace_mem_get_info(op, mmu_idx, true);
>> +    trace_guest_mem_before_exec(env_cpu(env), addr, meminfo);
>> +
>> +    oi =3D make_memop_idx(op, mmu_idx);
>> +    store_helper(env, addr, val, oi, retaddr, op);
>> +
>> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, meminfo);
>> +}
>> +
>> +void cpu_stb_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t v=
al,
>> +                       int mmu_idx, uintptr_t retaddr)
>> +{
>> +    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_UB);
>> +}
>> +
>> +void cpu_stw_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t v=
al,
>> +                       int mmu_idx, uintptr_t retaddr)
>> +{
>> +    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUW);
>> +}
>> +
>> +void cpu_stl_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t v=
al,
>> +                       int mmu_idx, uintptr_t retaddr)
>> +{
>> +    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUL);
>> +}
>> +
>> +void cpu_stq_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t v=
al,
>> +                       int mmu_idx, uintptr_t retaddr)
>> +{
>> +    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEQ);
>> +}
>> +
>>  /* First set of helpers allows passing in of OI and RETADDR.  This makes
>>     them callable from other helpers.  */


--=20
Alex Benn=C3=A9e

