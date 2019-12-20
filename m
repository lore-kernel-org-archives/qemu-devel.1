Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8074C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90733206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sx6sZFIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90733206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiN9E-00060H-OP
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiN8c-0005ZK-32
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiN8a-0006kS-JC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:36:33 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiN8a-0006ip-B2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:36:32 -0500
Received: by mail-wm1-x342.google.com with SMTP id q9so9921700wmj.5
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Td5Tt5v/QBljYvWLGWrUC9uoovYeIA19v3tcKumQbcw=;
 b=Sx6sZFIo+ZA+8S5nIbaVL+e4nfby/CyUCgjQeHEWzWwg4BpkTAYWDyiEdRzrl8GNF7
 2Ztcpq82iDyu7M7SAyem4euJKoRIphaaARpYZj15HytkIFapyLjfBstvZ8oQj502qwyT
 U9Q0vVgAvMKAo8SdXL+T/Dp3zet82rwZ5uXP4V3z5bSWHlXopnKG3r0vzuqRGVE4uUbT
 LImYb72vrXUF5b99ARbMPzehY1mSvSAhZKvzgJ4Uap91No12oA5PzaA0MyMQI7oO/Oyb
 2E9VFKcI8TsHMlNcU6z12fcNO703cH+8LaCyXpll9Qkjlu7Ue5mZAbxmrG0WsZ1ee5ZY
 AEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Td5Tt5v/QBljYvWLGWrUC9uoovYeIA19v3tcKumQbcw=;
 b=PEkRPxQFcPEWHTBlTeeIyHG5dyEOn3A1Jtowjld062Lnuv4pQ1pikONXOx28CQ+IgW
 Czsnkg2w73U5sfQ4vZm47tUgP9+/PZzFsEpaex7oB6zqiK4qtXapwN5UBgI7s4sETvW8
 3aqBc0t2IeLVJni3+YswlVW81r9KSl7kzEJklyxJS9uBkPzl+2Iqar81YHbJIjkDCegS
 U3va5ea+Axx3tQMeV34E2FmLNgu9IXV1rTQOvUum2V4H7uDAaHjBsJnmbGpMa/U0G9b5
 gtQ/Tm5TWh9vObqp7OPut1I5JG/2O1fZIJblhlciSLydywhXyKPTww4b8JdvtTMOhHXV
 YmHg==
X-Gm-Message-State: APjAAAV9UHEDXiD+AgiSKQKkP5zywGM6O951zmSqPAuziGy0eBEeZqsg
 km82I8yorL7vkncLrAokMq9023mARH4=
X-Google-Smtp-Source: APXvYqx4IWbcIjrH0pMlM7VTbmkDmocT+70AIIVhcQiY5qoBC/LDhQelwWXMucI9xTZh+df1WkFAaA==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr17529959wmh.94.1576866990316; 
 Fri, 20 Dec 2019 10:36:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm10563333wrq.22.2019.12.20.10.36.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 10:36:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE7261FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 18:36:27 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 04/28] cputlb: Move body of cpu_ldst_template.h out
 of line
In-reply-to: <20191216221158.29572-5-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 18:36:27 +0000
Message-ID: <87k16qc09g.fsf@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> With the tracing hooks, the inline functions are no longer
> so simple.  Once out-of-line, the current tlb_entry lookup
> is redundant with the one in the main load/store_helper.
>
> This also begins the introduction of a new target facing
> interface, with suffix *_mmuidx_ra.  This is not yet
> official because the interface is not done for user-only.
>
> Use abi_ptr instead of target_ulong in preparation for
> user-only; the two types are identical for softmmu.
>
> What remains in cpu_ldst_template.h are the expansions
> for _code, _data, and MMU_MODE<N>_SUFFIX.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h          |  25 ++++++-
>  include/exec/cpu_ldst_template.h | 125 +++++++------------------------
>  accel/tcg/cputlb.c               | 116 ++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+), 100 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index fd499f7e2f..cf8af36dbc 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -152,7 +152,7 @@ static inline void clear_helper_retaddr(void)
>=20=20
>  #else
>=20=20
> -/* The memory helpers for tcg-generated code need tcg_target_long etc.  =
*/
> +/* Needed for TCG_OVERSIZED_GUEST */
>  #include "tcg.h"
>=20=20
>  static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
> @@ -185,6 +185,29 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *e=
nv, uintptr_t mmu_idx,
>      return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr)=
];
>  }
>=20=20
> +uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                            int mmu_idx, uintptr_t ra);
> +uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                            int mmu_idx, uintptr_t ra);
> +uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                           int mmu_idx, uintptr_t ra);
> +uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                           int mmu_idx, uintptr_t ra);
> +
> +int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                       int mmu_idx, uintptr_t ra);
> +int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
> +                       int mmu_idx, uintptr_t ra);
> +
> +void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
> +                       int mmu_idx, uintptr_t retaddr);
> +void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
> +                       int mmu_idx, uintptr_t retaddr);
> +void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
> +                       int mmu_idx, uintptr_t retaddr);
> +void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
> +                       int mmu_idx, uintptr_t retaddr);
> +
>  #ifdef MMU_MODE0_SUFFIX
>  #define CPU_MMU_INDEX 0
>  #define MEMSUFFIX MMU_MODE0_SUFFIX
> diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_tem=
plate.h
> index 0ad5de3ef9..ea39e29c19 100644
> --- a/include/exec/cpu_ldst_template.h
> +++ b/include/exec/cpu_ldst_template.h
> @@ -24,13 +24,6 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>=20=20
> -#if !defined(SOFTMMU_CODE_ACCESS)
> -#include "trace-root.h"
> -#endif
> -
> -#include "qemu/plugin.h"
> -#include "trace/mem.h"

I think api.c needs to include trace/mem.h

--=20
Alex Benn=C3=A9e

