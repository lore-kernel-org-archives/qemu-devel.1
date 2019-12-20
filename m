Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1017BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05D8206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6+xVirU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05D8206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiM3A-00072Z-Vs
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiM2C-0005NR-4f
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiM2A-00040x-HF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:25:51 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiM2A-0003yD-7u
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:25:50 -0500
Received: by mail-wm1-x342.google.com with SMTP id u2so10013688wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 09:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=K21r017gDulrh6T3JODsgXBSTYtPvjZ41nwKK+er0Gs=;
 b=a6+xVirUif60nZcm94IhOtlUBc+keYeTIJlUaCNFpYyyit/GESrXmfx+KnZLgcfomX
 aVob7R+1zYtmUeNaPv5lX5p/VHHNFtqLkVMdKra3fUI0G899OTeV3Ev6o47jvQzS13wP
 cVD2kf9ZS2mkbkCvqm9F0KOTZkkuU80jDMypC20nxaurVtgkKzNdpT2bkBtMTTQ4m5Bv
 gBPPuMxgCVtbpUq8mrXMoKTkTbXR63WHpDfNn1UW8ZVCQD7U9/FK1dvXf8SCzMDhnCLd
 iM53LOKhgT7Aa1qRc6n51tOuo3+kjLBNUWLfiDoOIFKelDebNNQXUgX0C/okM8VmmOAB
 dTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=K21r017gDulrh6T3JODsgXBSTYtPvjZ41nwKK+er0Gs=;
 b=l3Q1o2BD6dodSjSq4kjrEFIv6ffx/Dy9HamOZlecAniKIs/x8Ua8Y8zQ4r7wop7eR4
 yiWpxVJ2jxX6McsBwrmKZ8e9HCINvh8ETjCk+RRVa3VQEBf/fJ4XX/vm40z3uhY6L3cK
 UZMTi6g0DxGuUZvxlPrsuGkwwEzJOxLPtM3LF7UiIBDGsMuYGFsxzbu1GRyXzSPTJSzm
 4UBPDKZgzSFd1jNM8+nstJ408YUH5FdpJe5jPXIIHaCyN3UmwuhSNoLGwRjyBqKYjWwX
 Vpnjv132qwdwHYbw22knEE7jWTJMTHl7b4AaKXS/8N/IIVcfeL28yKyoMHnWJLOMALgz
 xFmQ==
X-Gm-Message-State: APjAAAU/RRtftnlSicfokkPBA6HcXMf7fg2kg/ShpWt/tesUaxnqyEDO
 gBj5PMd4ZGymNXm+aMSF0S7J/snqAts=
X-Google-Smtp-Source: APXvYqy4SK8B01jp1hxae/bG3BT5EOpI+Q02OW6LUFHLF3rRkDRNKqwFc6ouGJopGk2zJ7lifyLCFQ==
X-Received: by 2002:a1c:7ed0:: with SMTP id z199mr17365634wmc.58.1576862747927; 
 Fri, 20 Dec 2019 09:25:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r62sm6505145wma.32.2019.12.20.09.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 09:25:46 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 880F11FF87;
 Fri, 20 Dec 2019 17:25:45 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-7-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 06/28] cputlb: Rename helper_ret_ld*_cmmu to
 cpu_ld*_code
In-reply-to: <20191216221158.29572-7-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 17:25:45 +0000
Message-ID: <87tv5udi3q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> There are no uses of the *_cmmu names other than the bare wrapping
> within the *_code inlines.  Therefore rename the functions so we
> can drop the inlines.
>
> Use abi_ptr instead of target_ulong in preparation for user-only;
> the two types are identical for softmmu.
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h          | 29 ++++------
>  include/exec/cpu_ldst_template.h | 21 -------
>  tcg/tcg.h                        | 29 ----------
>  accel/tcg/cputlb.c               | 94 ++++++++------------------------
>  docs/devel/loads-stores.rst      |  4 +-
>  5 files changed, 36 insertions(+), 141 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 399ff6c3da..ef59ed61e4 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -450,25 +450,20 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr a=
ddr, uint64_t val,
>  #undef CPU_MMU_INDEX
>  #undef MEMSUFFIX
>
> -#define CPU_MMU_INDEX (cpu_mmu_index(env, true))
> -#define MEMSUFFIX _code
> -#define SOFTMMU_CODE_ACCESS
> +uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
> +uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
> +uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
> +uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr);
>
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> +static inline int cpu_ldsb_code(CPUArchState *env, abi_ptr addr)
> +{
> +    return (int8_t)cpu_ldub_code(env, addr);
> +}
<snip>
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -1290,27 +1290,6 @@ void helper_be_stl_mmu(CPUArchState *env, target_u=
long addr, uint32_t val,
>  void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t va=
l,
>                         TCGMemOpIdx oi, uintptr_t retaddr);
>
> -uint8_t helper_ret_ldub_cmmu(CPUArchState *env, target_ulong addr,
> -                            TCGMemOpIdx oi, uintptr_t retaddr);
> -int8_t helper_ret_ldsb_cmmu(CPUArchState *env, target_ulong addr,
> -                            TCGMemOpIdx oi, uintptr_t retaddr);
> -uint16_t helper_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
> -                             TCGMemOpIdx oi, uintptr_t retaddr);
> -int16_t helper_le_ldsw_cmmu(CPUArchState *env, target_ulong addr,
> -                             TCGMemOpIdx oi, uintptr_t retaddr);
> -uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
> -                            TCGMemOpIdx oi, uintptr_t retaddr);
> -uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
> -                            TCGMemOpIdx oi, uintptr_t retaddr);
> -uint16_t helper_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
> -                             TCGMemOpIdx oi, uintptr_t retaddr);
> -int16_t helper_be_ldsw_cmmu(CPUArchState *env, target_ulong addr,
> -                             TCGMemOpIdx oi, uintptr_t retaddr);
> -uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
> -                            TCGMemOpIdx oi, uintptr_t retaddr);
> -uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
> -                            TCGMemOpIdx oi, uintptr_t retaddr);
> -
<snip>

Why have we dropped the final type and stuck to uint32/64? Do we rely on
the caller truncating any data by casting the result of their eventual
cpu_ldFoo?

--
Alex Benn=C3=A9e

