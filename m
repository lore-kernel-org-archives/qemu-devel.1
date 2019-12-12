Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDADC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080FC2073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5zlIK3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080FC2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifUhY-0008Mi-1e
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ifUfI-0006VW-41
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ifUfD-0005AG-Pu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:02:24 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:46650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ifUfD-00058S-Do
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:02:19 -0500
Received: by mail-oi1-x231.google.com with SMTP id a124so52602oii.13
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 12:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jMIXdO1/Z7+yJmCndPIsEETjR6+6gcbhj7aQYL3K0ss=;
 b=d5zlIK3EhgiTyUYqDXUsK5fXfIfN4ylYlmHVFM34IRzDoNfZXitPClU4n6XctPXWor
 jMJ+wm0Jo3d5PwgEw2olx/6S7F/j85Ekr5kWScc1XHqI1f0yCf8JQYm+FClkoUWQG7g/
 VxQhTG7u+OZ8MmigkfgN8kw/x5uvKHXBva7Na2UKgY686Xt21BAJUBU72MbzxP5Rs5F6
 KoJklmHXAo2jBzibRKN6PqZ0qwqOmVhxpCTPEnxDS61trv+2YuXgNTCl0iEIT7a8HeWU
 pWv3q+2N1Vr1tqfBAY5uIG2T+txcNse+rZ9+wNKAvpih7jEBe/GZKNyFCR4ZoUGBBOoH
 bAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jMIXdO1/Z7+yJmCndPIsEETjR6+6gcbhj7aQYL3K0ss=;
 b=RkuOGJ+nXmOJV5ryaaQ1T6ZsLq7XpogaMBKsRFZyyEY1OaGUDtpfkPKncT0oG4+Xu/
 i4Ahm/CT8A8qO7ui6Y84p3Kch2DIX4Xv1OQ6YENliDWDRx8i7m7u+EIVT0E7+7FmXVL4
 VfX508/pf5seBHZuIdVHTOTicJD9cG3bIIhfLN0yvuzVki9YWyGzFYFKeqrqOOv19hEY
 9UzaXzj0An+LZAvH14TcjSNdWJ0OBIvhoy2wwinx15pZB9d6yl52yrNcmVNbrcUUHnm7
 2njI3s9kheD3wZ7aCoF0zjMEoTtGNZef+kHxWejzWye9carOaQ7BusAn6Jp7AxPAPmT3
 JWpQ==
X-Gm-Message-State: APjAAAWuuwoUhoG/OJ8C0XEEmz/+arNDNExslyXH30OgR6Q1ZMo1RjrY
 XlLUaCKr9FrIaFyiuoUmyfc2WWBrSVPVi12eeRQ=
X-Google-Smtp-Source: APXvYqyYnNs+XQ0TLBesJnN3ZT5Gdld82kIJGLlqCBzkW4AC4oXkDbSCbrnwg3Y639LHBci6wXu6s4Sqp/SQFl7WPKU=
X-Received: by 2002:aca:bd85:: with SMTP id n127mr6317136oif.136.1576180938368; 
 Thu, 12 Dec 2019 12:02:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 12 Dec 2019 12:02:17 -0800 (PST)
In-Reply-To: <20191212040039.26546-15-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
 <20191212040039.26546-15-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 12 Dec 2019 21:02:17 +0100
Message-ID: <CAL1e-=gigXmPTkb1oUR-TYBxAC2vGA2vbCFFsbf8Xm_LcxSAMQ@mail.gmail.com>
Subject: [PATCH 14/28] cputlb: Expand cpu_ldst_useronly_template.h in
 user-exec.c
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000eeec4b05998738b4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eeec4b05998738b4
Content-Type: text/plain; charset="UTF-8"

On Thursday, December 12, 2019, Richard Henderson <
richard.henderson@linaro.org> wrote:

> With the tracing hooks, the inline functions are no longer
> so simple.  Reduce the amount of preprocessor obfuscation
> by expanding the text of each of the functions generated.
> The result is only slightly larger than the original.
>
>
Hello, Richard.

Are you talking about source code size here?

I am truly interested in the size of exectutable - it should remain about
the same, no? Can you perhaps confirm that?

Thanks.


> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h                   |  54 +++--
>  include/exec/cpu_ldst_useronly_template.h | 159 ---------------
>  accel/tcg/user-exec.c                     | 236 ++++++++++++++++++++++
>  3 files changed, 262 insertions(+), 187 deletions(-)
>  delete mode 100644 include/exec/cpu_ldst_useronly_template.h
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 3b2c46bdf4..5a638fd8d6 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -124,35 +124,33 @@ static inline void clear_helper_retaddr(void)
>
>  /* In user-only mode we provide only the _code and _data accessors. */
>
> -#define MEMSUFFIX _data
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_useronly_template.h"
> +uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
> +uint32_t cpu_lduw_data(CPUArchState *env, abi_ptr ptr);
> +uint32_t cpu_ldl_data(CPUArchState *env, abi_ptr ptr);
> +uint64_t cpu_ldq_data(CPUArchState *env, abi_ptr ptr);
> +int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);
> +int cpu_ldsw_data(CPUArchState *env, abi_ptr ptr);
>
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_useronly_template.h"
> +uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t
> retaddr);
> +uint32_t cpu_lduw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t
> retaddr);
> +uint32_t cpu_ldl_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t
> retaddr);
> +uint64_t cpu_ldq_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t
> retaddr);
> +int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);
> +int cpu_ldsw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);
>
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_useronly_template.h"
> +void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> +void cpu_stw_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> +void cpu_stl_data(CPUArchState *env, abi_ptr ptr, uint32_t val);
> +void cpu_stq_data(CPUArchState *env, abi_ptr ptr, uint64_t val);
>
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_useronly_template.h"
> -#undef MEMSUFFIX
> -
> -#define MEMSUFFIX _code
> -#define CODE_ACCESS
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_useronly_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_useronly_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_useronly_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_useronly_template.h"
> -#undef MEMSUFFIX
> -#undef CODE_ACCESS
> +void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,
> +                     uint32_t val, uintptr_t retaddr);
> +void cpu_stw_data_ra(CPUArchState *env, abi_ptr ptr,
> +                     uint32_t val, uintptr_t retaddr);
> +void cpu_stl_data_ra(CPUArchState *env, abi_ptr ptr,
> +                     uint32_t val, uintptr_t retaddr);
> +void cpu_stq_data_ra(CPUArchState *env, abi_ptr ptr,
> +                     uint64_t val, uintptr_t retaddr);
>
>  /*
>   * Provide the same *_mmuidx_ra interface as for softmmu.
> @@ -524,6 +522,8 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr
> addr, uint64_t val,
>  #undef CPU_MMU_INDEX
>  #undef MEMSUFFIX
>
> +#endif /* defined(CONFIG_USER_ONLY) */
> +
>  uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
>  uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
>  uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
> @@ -539,8 +539,6 @@ static inline int cpu_ldsw_code(CPUArchState *env,
> abi_ptr addr)
>      return (int16_t)cpu_lduw_code(env, addr);
>  }
>
> -#endif /* defined(CONFIG_USER_ONLY) */
> -
>  /**
>   * tlb_vaddr_to_host:
>   * @env: CPUArchState
> diff --git a/include/exec/cpu_ldst_useronly_template.h
> b/include/exec/cpu_ldst_useronly_template.h
> deleted file mode 100644
> index e5a3d1983a..0000000000
> --- a/include/exec/cpu_ldst_useronly_template.h
> +++ /dev/null
> @@ -1,159 +0,0 @@
> -/*
> - *  User-only accessor function support
> - *
> - * Generate inline load/store functions for one data size.
> - *
> - * Generate a store function as well as signed and unsigned loads.
> - *
> - * Not used directly but included from cpu_ldst.h.
> - *
> - *  Copyright (c) 2015 Linaro Limited
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> - */
> -
> -#if !defined(CODE_ACCESS)
> -#include "trace-root.h"
> -#endif
> -
> -#include "trace/mem.h"
> -
> -#if DATA_SIZE == 8
> -#define SUFFIX q
> -#define USUFFIX q
> -#define DATA_TYPE uint64_t
> -#define SHIFT 3
> -#elif DATA_SIZE == 4
> -#define SUFFIX l
> -#define USUFFIX l
> -#define DATA_TYPE uint32_t
> -#define SHIFT 2
> -#elif DATA_SIZE == 2
> -#define SUFFIX w
> -#define USUFFIX uw
> -#define DATA_TYPE uint16_t
> -#define DATA_STYPE int16_t
> -#define SHIFT 1
> -#elif DATA_SIZE == 1
> -#define SUFFIX b
> -#define USUFFIX ub
> -#define DATA_TYPE uint8_t
> -#define DATA_STYPE int8_t
> -#define SHIFT 0
> -#else
> -#error unsupported data size
> -#endif
> -
> -#if DATA_SIZE == 8
> -#define RES_TYPE uint64_t
> -#else
> -#define RES_TYPE uint32_t
> -#endif
> -
> -static inline RES_TYPE
> -glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
> -{
> -    RES_TYPE ret;
> -#ifdef CODE_ACCESS
> -    set_helper_retaddr(1);
> -    ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
> -    clear_helper_retaddr();
> -#else
> -    MemOp op = MO_TE | SHIFT;
> -    uint16_t meminfo = trace_mem_get_info(op, MMU_USER_IDX, false);
> -    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> -    ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
> -#endif
> -    return ret;
> -}
> -
> -#ifndef CODE_ACCESS
> -static inline RES_TYPE
> -glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
> -                                                  abi_ptr ptr,
> -                                                  uintptr_t retaddr)
> -{
> -    RES_TYPE ret;
> -    set_helper_retaddr(retaddr);
> -    ret = glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);
> -    clear_helper_retaddr();
> -    return ret;
> -}
> -#endif
> -
> -#if DATA_SIZE <= 2
> -static inline int
> -glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
> -{
> -    int ret;
> -#ifdef CODE_ACCESS
> -    set_helper_retaddr(1);
> -    ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
> -    clear_helper_retaddr();
> -#else
> -    MemOp op = MO_TE | MO_SIGN | SHIFT;
> -    uint16_t meminfo = trace_mem_get_info(op, MMU_USER_IDX, false);
> -    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> -    ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> -#endif
> -    return ret;
> -}
> -
> -#ifndef CODE_ACCESS
> -static inline int
> -glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
> -                                                  abi_ptr ptr,
> -                                                  uintptr_t retaddr)
> -{
> -    int ret;
> -    set_helper_retaddr(retaddr);
> -    ret = glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);
> -    clear_helper_retaddr();
> -    return ret;
> -}
> -#endif /* CODE_ACCESS */
> -#endif /* DATA_SIZE <= 2 */
> -
> -#ifndef CODE_ACCESS
> -static inline void
> -glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
> -                                      RES_TYPE v)
> -{
> -    MemOp op = MO_TE | SHIFT;
> -    uint16_t meminfo = trace_mem_get_info(op, MMU_USER_IDX, true);
> -    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> -    glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
> -    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> -}
> -
> -static inline void
> -glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
> -                                                  abi_ptr ptr,
> -                                                  RES_TYPE v,
> -                                                  uintptr_t retaddr)
> -{
> -    set_helper_retaddr(retaddr);
> -    glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(env, ptr, v);
> -    clear_helper_retaddr();
> -}
> -#endif
> -
> -#undef RES_TYPE
> -#undef DATA_TYPE
> -#undef DATA_STYPE
> -#undef SUFFIX
> -#undef USUFFIX
> -#undef DATA_SIZE
> -#undef SHIFT
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index b09f7a1577..79da4219bb 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -26,6 +26,8 @@
>  #include "translate-all.h"
>  #include "exec/helper-proto.h"
>  #include "qemu/atomic128.h"
> +#include "trace-root.h"
> +#include "trace/mem.h"
>
>  #undef EAX
>  #undef ECX
> @@ -734,6 +736,240 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>
>  /* The softmmu versions of these helpers are in cputlb.c.  */
>
> +uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr)
> +{
> +    uint32_t ret;
> +    uint16_t meminfo = trace_mem_get_info(MO_UB, MMU_USER_IDX, false);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    ret = ldub_p(g2h(ptr));
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +    return ret;
> +}
> +
> +int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr)
> +{
> +    int ret;
> +    uint16_t meminfo = trace_mem_get_info(MO_SB, MMU_USER_IDX, false);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    ret = ldsb_p(g2h(ptr));
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +    return ret;
> +}
> +
> +uint32_t cpu_lduw_data(CPUArchState *env, abi_ptr ptr)
> +{
> +    uint32_t ret;
> +    uint16_t meminfo = trace_mem_get_info(MO_TEUW, MMU_USER_IDX, false);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    ret = lduw_p(g2h(ptr));
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +    return ret;
> +}
> +
> +int cpu_ldsw_data(CPUArchState *env, abi_ptr ptr)
> +{
> +    int ret;
> +    uint16_t meminfo = trace_mem_get_info(MO_TESW, MMU_USER_IDX, false);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    ret = ldsw_p(g2h(ptr));
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +    return ret;
> +}
> +
> +uint32_t cpu_ldl_data(CPUArchState *env, abi_ptr ptr)
> +{
> +    uint32_t ret;
> +    uint16_t meminfo = trace_mem_get_info(MO_TEUL, MMU_USER_IDX, false);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    ret = ldl_p(g2h(ptr));
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +    return ret;
> +}
> +
> +uint64_t cpu_ldq_data(CPUArchState *env, abi_ptr ptr)
> +{
> +    uint64_t ret;
> +    uint16_t meminfo = trace_mem_get_info(MO_TEQ, MMU_USER_IDX, false);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    ret = ldq_p(g2h(ptr));
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +    return ret;
> +}
> +
> +uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t
> retaddr)
> +{
> +    uint32_t ret;
> +
> +    set_helper_retaddr(retaddr);
> +    ret = cpu_ldub_data(env, ptr);
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
> +int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
> +{
> +    int ret;
> +
> +    set_helper_retaddr(retaddr);
> +    ret = cpu_ldsb_data(env, ptr);
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
> +uint32_t cpu_lduw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t
> retaddr)
> +{
> +    uint32_t ret;
> +
> +    set_helper_retaddr(retaddr);
> +    ret = cpu_lduw_data(env, ptr);
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
> +int cpu_ldsw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)
> +{
> +    int ret;
> +
> +    set_helper_retaddr(retaddr);
> +    ret = cpu_ldsw_data(env, ptr);
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
> +uint32_t cpu_ldl_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t
> retaddr)
> +{
> +    uint32_t ret;
> +
> +    set_helper_retaddr(retaddr);
> +    ret = cpu_ldl_data(env, ptr);
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
> +uint64_t cpu_ldq_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t
> retaddr)
> +{
> +    uint64_t ret;
> +
> +    set_helper_retaddr(retaddr);
> +    ret = cpu_ldq_data(env, ptr);
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
> +void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
> +{
> +    uint16_t meminfo = trace_mem_get_info(MO_UB, MMU_USER_IDX, true);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    stb_p(g2h(ptr), val);
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +}
> +
> +void cpu_stw_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
> +{
> +    uint16_t meminfo = trace_mem_get_info(MO_TEUW, MMU_USER_IDX, true);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    stw_p(g2h(ptr), val);
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +}
> +
> +void cpu_stl_data(CPUArchState *env, abi_ptr ptr, uint32_t val)
> +{
> +    uint16_t meminfo = trace_mem_get_info(MO_TEUL, MMU_USER_IDX, true);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    stl_p(g2h(ptr), val);
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +}
> +
> +void cpu_stq_data(CPUArchState *env, abi_ptr ptr, uint64_t val)
> +{
> +    uint16_t meminfo = trace_mem_get_info(MO_TEQ, MMU_USER_IDX, true);
> +
> +    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
> +    stq_p(g2h(ptr), val);
> +    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> +}
> +
> +void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,
> +                     uint32_t val, uintptr_t retaddr)
> +{
> +    set_helper_retaddr(retaddr);
> +    cpu_stb_data(env, ptr, val);
> +    clear_helper_retaddr();
> +}
> +
> +void cpu_stw_data_ra(CPUArchState *env, abi_ptr ptr,
> +                     uint32_t val, uintptr_t retaddr)
> +{
> +    set_helper_retaddr(retaddr);
> +    cpu_stw_data(env, ptr, val);
> +    clear_helper_retaddr();
> +}
> +
> +void cpu_stl_data_ra(CPUArchState *env, abi_ptr ptr,
> +                     uint32_t val, uintptr_t retaddr)
> +{
> +    set_helper_retaddr(retaddr);
> +    cpu_stl_data(env, ptr, val);
> +    clear_helper_retaddr();
> +}
> +
> +void cpu_stq_data_ra(CPUArchState *env, abi_ptr ptr,
> +                     uint64_t val, uintptr_t retaddr)
> +{
> +    set_helper_retaddr(retaddr);
> +    cpu_stq_data(env, ptr, val);
> +    clear_helper_retaddr();
> +}
> +
> +uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr ptr)
> +{
> +    uint32_t ret;
> +
> +    set_helper_retaddr(1);
> +    ret = ldub_p(g2h(ptr));
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
> +uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr ptr)
> +{
> +    uint32_t ret;
> +
> +    set_helper_retaddr(1);
> +    ret = lduw_p(g2h(ptr));
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
> +uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr ptr)
> +{
> +    uint32_t ret;
> +
> +    set_helper_retaddr(1);
> +    ret = ldl_p(g2h(ptr));
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
> +uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)
> +{
> +    uint64_t ret;
> +
> +    set_helper_retaddr(1);
> +    ret = ldq_p(g2h(ptr));
> +    clear_helper_retaddr();
> +    return ret;
> +}
> +
>  /* Do not allow unaligned operations to proceed.  Return the host
> address.  */
>  static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
>                                 int size, uintptr_t retaddr)
> --
> 2.20.1
>
>
>

--000000000000eeec4b05998738b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, December 12, 2019, Richard Henderson &lt;<a href=3D"ma=
ilto:richard.henderson@linaro.org" target=3D"_blank">richard.henderson@lina=
ro.org</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">With the tracing ho=
oks, the inline functions are no longer<br>
so simple.=C2=A0 Reduce the amount of preprocessor obfuscation<br>
by expanding the text of each of the functions generated.<br>
The result is only slightly larger than the original.<br>
<br></blockquote><div><br></div><div>Hello, Richard.</div><div><br></div><d=
iv>Are you talking about source code size here?</div><div><br></div><div>I =
am truly interested in the size of exectutable - it should remain about the=
 same, no? Can you perhaps confirm that?</div><div><br></div><div>Thanks.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/exec/cpu_ldst.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 54 +++--<br>
=C2=A0include/exec/cpu_ldst_useronl<wbr>y_template.h | 159 ---------------<=
br>
=C2=A0accel/tcg/user-exec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 236 ++++++++++++++++++++++<br>
=C2=A03 files changed, 262 insertions(+), 187 deletions(-)<br>
=C2=A0delete mode 100644 include/exec/cpu_ldst_useronly<wbr>_template.h<br>
<br>
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h<br>
index 3b2c46bdf4..5a638fd8d6 100644<br>
--- a/include/exec/cpu_ldst.h<br>
+++ b/include/exec/cpu_ldst.h<br>
@@ -124,35 +124,33 @@ static inline void clear_helper_retaddr(void)<br>
<br>
=C2=A0/* In user-only mode we provide only the _code and _data accessors. *=
/<br>
<br>
-#define MEMSUFFIX _data<br>
-#define DATA_SIZE 1<br>
-#include &quot;exec/cpu_ldst_useronly_templa<wbr>te.h&quot;<br>
+uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);<br>
+uint32_t cpu_lduw_data(CPUArchState *env, abi_ptr ptr);<br>
+uint32_t cpu_ldl_data(CPUArchState *env, abi_ptr ptr);<br>
+uint64_t cpu_ldq_data(CPUArchState *env, abi_ptr ptr);<br>
+int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr);<br>
+int cpu_ldsw_data(CPUArchState *env, abi_ptr ptr);<br>
<br>
-#define DATA_SIZE 2<br>
-#include &quot;exec/cpu_ldst_useronly_templa<wbr>te.h&quot;<br>
+uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retadd=
r);<br>
+uint32_t cpu_lduw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retadd=
r);<br>
+uint32_t cpu_ldl_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr=
);<br>
+uint64_t cpu_ldq_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr=
);<br>
+int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);<b=
r>
+int cpu_ldsw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr);<b=
r>
<br>
-#define DATA_SIZE 4<br>
-#include &quot;exec/cpu_ldst_useronly_templa<wbr>te.h&quot;<br>
+void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val);<br>
+void cpu_stw_data(CPUArchState *env, abi_ptr ptr, uint32_t val);<br>
+void cpu_stl_data(CPUArchState *env, abi_ptr ptr, uint32_t val);<br>
+void cpu_stq_data(CPUArchState *env, abi_ptr ptr, uint64_t val);<br>
<br>
-#define DATA_SIZE 8<br>
-#include &quot;exec/cpu_ldst_useronly_templa<wbr>te.h&quot;<br>
-#undef MEMSUFFIX<br>
-<br>
-#define MEMSUFFIX _code<br>
-#define CODE_ACCESS<br>
-#define DATA_SIZE 1<br>
-#include &quot;exec/cpu_ldst_useronly_templa<wbr>te.h&quot;<br>
-<br>
-#define DATA_SIZE 2<br>
-#include &quot;exec/cpu_ldst_useronly_templa<wbr>te.h&quot;<br>
-<br>
-#define DATA_SIZE 4<br>
-#include &quot;exec/cpu_ldst_useronly_templa<wbr>te.h&quot;<br>
-<br>
-#define DATA_SIZE 8<br>
-#include &quot;exec/cpu_ldst_useronly_templa<wbr>te.h&quot;<br>
-#undef MEMSUFFIX<br>
-#undef CODE_ACCESS<br>
+void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t val, uintptr_t retaddr);<br>
+void cpu_stw_data_ra(CPUArchState *env, abi_ptr ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t val, uintptr_t retaddr);<br>
+void cpu_stl_data_ra(CPUArchState *env, abi_ptr ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t val, uintptr_t retaddr);<br>
+void cpu_stq_data_ra(CPUArchState *env, abi_ptr ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t val, uintptr_t retaddr);<br>
<br>
=C2=A0/*<br>
=C2=A0 * Provide the same *_mmuidx_ra interface as for softmmu.<br>
@@ -524,6 +522,8 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr,=
 uint64_t val,<br>
=C2=A0#undef CPU_MMU_INDEX<br>
=C2=A0#undef MEMSUFFIX<br>
<br>
+#endif /* defined(CONFIG_USER_ONLY) */<br>
+<br>
=C2=A0uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);<br>
=C2=A0uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);<br>
=C2=A0uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);<br>
@@ -539,8 +539,6 @@ static inline int cpu_ldsw_code(CPUArchState *env, abi_=
ptr addr)<br>
=C2=A0 =C2=A0 =C2=A0return (int16_t)cpu_lduw_code(env, addr);<br>
=C2=A0}<br>
<br>
-#endif /* defined(CONFIG_USER_ONLY) */<br>
-<br>
=C2=A0/**<br>
=C2=A0 * tlb_vaddr_to_host:<br>
=C2=A0 * @env: CPUArchState<br>
diff --git a/include/exec/cpu_ldst_useron<wbr>ly_template.h b/include/exec/=
cpu_ldst_useron<wbr>ly_template.h<br>
deleted file mode 100644<br>
index e5a3d1983a..0000000000<br>
--- a/include/exec/cpu_ldst_useron<wbr>ly_template.h<br>
+++ /dev/null<br>
@@ -1,159 +0,0 @@<br>
-/*<br>
- *=C2=A0 User-only accessor function support<br>
- *<br>
- * Generate inline load/store functions for one data size.<br>
- *<br>
- * Generate a store function as well as signed and unsigned loads.<br>
- *<br>
- * Not used directly but included from cpu_ldst.h.<br>
- *<br>
- *=C2=A0 Copyright (c) 2015 Linaro Limited<br>
- *<br>
- * This library is free software; you can redistribute it and/or<br>
- * modify it under the terms of the GNU Lesser General Public<br>
- * License as published by the Free Software Foundation; either<br>
- * version 2 of the License, or (at your option) any later version.<br>
- *<br>
- * This library is distributed in the hope that it will be useful,<br>
- * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
- * Lesser General Public License for more details.<br>
- *<br>
- * You should have received a copy of the GNU Lesser General Public<br>
- * License along with this library; if not, see &lt;<a href=3D"http://www.=
gnu.org/licenses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<w=
br>.<br>
- */<br>
-<br>
-#if !defined(CODE_ACCESS)<br>
-#include &quot;trace-root.h&quot;<br>
-#endif<br>
-<br>
-#include &quot;trace/mem.h&quot;<br>
-<br>
-#if DATA_SIZE =3D=3D 8<br>
-#define SUFFIX q<br>
-#define USUFFIX q<br>
-#define DATA_TYPE uint64_t<br>
-#define SHIFT 3<br>
-#elif DATA_SIZE =3D=3D 4<br>
-#define SUFFIX l<br>
-#define USUFFIX l<br>
-#define DATA_TYPE uint32_t<br>
-#define SHIFT 2<br>
-#elif DATA_SIZE =3D=3D 2<br>
-#define SUFFIX w<br>
-#define USUFFIX uw<br>
-#define DATA_TYPE uint16_t<br>
-#define DATA_STYPE int16_t<br>
-#define SHIFT 1<br>
-#elif DATA_SIZE =3D=3D 1<br>
-#define SUFFIX b<br>
-#define USUFFIX ub<br>
-#define DATA_TYPE uint8_t<br>
-#define DATA_STYPE int8_t<br>
-#define SHIFT 0<br>
-#else<br>
-#error unsupported data size<br>
-#endif<br>
-<br>
-#if DATA_SIZE =3D=3D 8<br>
-#define RES_TYPE uint64_t<br>
-#else<br>
-#define RES_TYPE uint32_t<br>
-#endif<br>
-<br>
-static inline RES_TYPE<br>
-glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)<br>
-{<br>
-=C2=A0 =C2=A0 RES_TYPE ret;<br>
-#ifdef CODE_ACCESS<br>
-=C2=A0 =C2=A0 set_helper_retaddr(1);<br>
-=C2=A0 =C2=A0 ret =3D glue(glue(ld, USUFFIX), _p)(g2h(ptr));<br>
-=C2=A0 =C2=A0 clear_helper_retaddr();<br>
-#else<br>
-=C2=A0 =C2=A0 MemOp op =3D MO_TE | SHIFT;<br>
-=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(op, MMU_USER_IDX, fa=
lse);<br>
-=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
-=C2=A0 =C2=A0 ret =3D glue(glue(ld, USUFFIX), _p)(g2h(ptr));<br>
-#endif<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-<br>
-#ifndef CODE_ACCESS<br>
-static inline RES_TYPE<br>
-glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ptr ptr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t retaddr)<br>
-{<br>
-=C2=A0 =C2=A0 RES_TYPE ret;<br>
-=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
-=C2=A0 =C2=A0 ret =3D glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);<br=
>
-=C2=A0 =C2=A0 clear_helper_retaddr();<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-#endif<br>
-<br>
-#if DATA_SIZE &lt;=3D 2<br>
-static inline int<br>
-glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)<br>
-{<br>
-=C2=A0 =C2=A0 int ret;<br>
-#ifdef CODE_ACCESS<br>
-=C2=A0 =C2=A0 set_helper_retaddr(1);<br>
-=C2=A0 =C2=A0 ret =3D glue(glue(lds, SUFFIX), _p)(g2h(ptr));<br>
-=C2=A0 =C2=A0 clear_helper_retaddr();<br>
-#else<br>
-=C2=A0 =C2=A0 MemOp op =3D MO_TE | MO_SIGN | SHIFT;<br>
-=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(op, MMU_USER_IDX, fa=
lse);<br>
-=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
-=C2=A0 =C2=A0 ret =3D glue(glue(lds, SUFFIX), _p)(g2h(ptr));<br>
-=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
-#endif<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-<br>
-#ifndef CODE_ACCESS<br>
-static inline int<br>
-glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ptr ptr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t retaddr)<br>
-{<br>
-=C2=A0 =C2=A0 int ret;<br>
-=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
-=C2=A0 =C2=A0 ret =3D glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);<br=
>
-=C2=A0 =C2=A0 clear_helper_retaddr();<br>
-=C2=A0 =C2=A0 return ret;<br>
-}<br>
-#endif /* CODE_ACCESS */<br>
-#endif /* DATA_SIZE &lt;=3D 2 */<br>
-<br>
-#ifndef CODE_ACCESS<br>
-static inline void<br>
-glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RES_TYPE v)<br>
-{<br>
-=C2=A0 =C2=A0 MemOp op =3D MO_TE | SHIFT;<br>
-=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(op, MMU_USER_IDX, tr=
ue);<br>
-=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
-=C2=A0 =C2=A0 glue(glue(st, SUFFIX), _p)(g2h(ptr), v);<br>
-=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
-}<br>
-<br>
-static inline void<br>
-glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ptr ptr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RES_TYPE v,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t retaddr)<br>
-{<br>
-=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
-=C2=A0 =C2=A0 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(env, ptr, v);<br>
-=C2=A0 =C2=A0 clear_helper_retaddr();<br>
-}<br>
-#endif<br>
-<br>
-#undef RES_TYPE<br>
-#undef DATA_TYPE<br>
-#undef DATA_STYPE<br>
-#undef SUFFIX<br>
-#undef USUFFIX<br>
-#undef DATA_SIZE<br>
-#undef SHIFT<br>
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c<br>
index b09f7a1577..79da4219bb 100644<br>
--- a/accel/tcg/user-exec.c<br>
+++ b/accel/tcg/user-exec.c<br>
@@ -26,6 +26,8 @@<br>
=C2=A0#include &quot;translate-all.h&quot;<br>
=C2=A0#include &quot;exec/helper-proto.h&quot;<br>
=C2=A0#include &quot;qemu/atomic128.h&quot;<br>
+#include &quot;trace-root.h&quot;<br>
+#include &quot;trace/mem.h&quot;<br>
<br>
=C2=A0#undef EAX<br>
=C2=A0#undef ECX<br>
@@ -734,6 +736,240 @@ int cpu_signal_handler(int host_signum, void *pinfo,<=
br>
<br>
=C2=A0/* The softmmu versions of these helpers are in cputlb.c.=C2=A0 */<br=
>
<br>
+uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_UB, MMU_USER_IDX,=
 false);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 ret =3D ldub_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+int cpu_ldsb_data(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 int ret;<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_SB, MMU_USER_IDX,=
 false);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 ret =3D ldsb_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint32_t cpu_lduw_data(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_TEUW, MMU_USER_ID=
X, false);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 ret =3D lduw_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+int cpu_ldsw_data(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 int ret;<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_TESW, MMU_USER_ID=
X, false);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 ret =3D ldsw_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint32_t cpu_ldl_data(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_TEUL, MMU_USER_ID=
X, false);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 ret =3D ldl_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint64_t cpu_ldq_data(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t ret;<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_TEQ, MMU_USER_IDX=
, false);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 ret =3D ldq_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint32_t cpu_ldub_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retadd=
r)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 ret =3D cpu_ldub_data(env, ptr);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+int cpu_ldsb_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)<br=
>
+{<br>
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 ret =3D cpu_ldsb_data(env, ptr);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint32_t cpu_lduw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retadd=
r)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 ret =3D cpu_lduw_data(env, ptr);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+int cpu_ldsw_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr)<br=
>
+{<br>
+=C2=A0 =C2=A0 int ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 ret =3D cpu_ldsw_data(env, ptr);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint32_t cpu_ldl_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr=
)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 ret =3D cpu_ldl_data(env, ptr);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint64_t cpu_ldq_data_ra(CPUArchState *env, abi_ptr ptr, uintptr_t retaddr=
)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 ret =3D cpu_ldq_data(env, ptr);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+void cpu_stb_data(CPUArchState *env, abi_ptr ptr, uint32_t val)<br>
+{<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_UB, MMU_USER_IDX,=
 true);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 stb_p(g2h(ptr), val);<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+}<br>
+<br>
+void cpu_stw_data(CPUArchState *env, abi_ptr ptr, uint32_t val)<br>
+{<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_TEUW, MMU_USER_ID=
X, true);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 stw_p(g2h(ptr), val);<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+}<br>
+<br>
+void cpu_stl_data(CPUArchState *env, abi_ptr ptr, uint32_t val)<br>
+{<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_TEUL, MMU_USER_ID=
X, true);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 stl_p(g2h(ptr), val);<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+}<br>
+<br>
+void cpu_stq_data(CPUArchState *env, abi_ptr ptr, uint64_t val)<br>
+{<br>
+=C2=A0 =C2=A0 uint16_t meminfo =3D trace_mem_get_info(MO_TEQ, MMU_USER_IDX=
, true);<br>
+<br>
+=C2=A0 =C2=A0 trace_guest_mem_before_exec(en<wbr>v_cpu(env), ptr, meminfo)=
;<br>
+=C2=A0 =C2=A0 stq_p(g2h(ptr), val);<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_mem_cb(env_cp<wbr>u(env), ptr, meminfo);<br=
>
+}<br>
+<br>
+void cpu_stb_data_ra(CPUArchState *env, abi_ptr ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t val, uintptr_t retaddr)<br>
+{<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 cpu_stb_data(env, ptr, val);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+}<br>
+<br>
+void cpu_stw_data_ra(CPUArchState *env, abi_ptr ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t val, uintptr_t retaddr)<br>
+{<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 cpu_stw_data(env, ptr, val);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+}<br>
+<br>
+void cpu_stl_data_ra(CPUArchState *env, abi_ptr ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint32_t val, uintptr_t retaddr)<br>
+{<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 cpu_stl_data(env, ptr, val);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+}<br>
+<br>
+void cpu_stq_data_ra(CPUArchState *env, abi_ptr ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t val, uintptr_t retaddr)<br>
+{<br>
+=C2=A0 =C2=A0 set_helper_retaddr(retaddr);<br>
+=C2=A0 =C2=A0 cpu_stq_data(env, ptr, val);<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+}<br>
+<br>
+uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(1);<br>
+=C2=A0 =C2=A0 ret =3D ldub_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(1);<br>
+=C2=A0 =C2=A0 ret =3D lduw_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(1);<br>
+=C2=A0 =C2=A0 ret =3D ldl_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t ret;<br>
+<br>
+=C2=A0 =C2=A0 set_helper_retaddr(1);<br>
+=C2=A0 =C2=A0 ret =3D ldq_p(g2h(ptr));<br>
+=C2=A0 =C2=A0 clear_helper_retaddr();<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0/* Do not allow unaligned operations to proceed.=C2=A0 Return the hos=
t address.=C2=A0 */<br>
=C2=A0static void *atomic_mmu_lookup(CPUArchStat<wbr>e *env, target_ulong a=
ddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int size, uintptr_t retaddr)<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--000000000000eeec4b05998738b4--

