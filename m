Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32543C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3B321655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHdu2B00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3B321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJqC-0005Xw-2r
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiJpM-0004fK-KW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiJpK-0006bs-Sr
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:04:28 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiJpK-0006Zx-Kn
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:04:26 -0500
Received: by mail-wr1-x443.google.com with SMTP id c14so9704888wrn.7
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 07:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=H+8c2VYbax3b29POhRM9jNqfIQ7zXedo9gqrF9LR77A=;
 b=vHdu2B00dyoESmpyOzf6STMnOG/CPUaRfz0c3Qzey3jMMnBRFqVKdT2M2DPcku1an6
 4ccg6uHxq5dwqN8w1zNUEPWLgOZbNh1DguwgzL3D7jseVR/5wZ2GuF9A0xUxSRLV/mBY
 xIdkOysicKff0kMYaRrmw6/PGfEJyNYd4RY37HNLdZCZWOp7C53gsw2tXBOCn6N/iFB4
 Q6+uKHCk9DNCp7tC0MVAQFIRtflth4UTxeo9mP6T86AkRBaaM/4BhkrSElJbbydw7rXQ
 U2zFDmbnkCQG7o7MhvltKTClrZBuvce791A0s21h3qEDxJ3m5U1vLQmYRUy8qua8BLAg
 OD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=H+8c2VYbax3b29POhRM9jNqfIQ7zXedo9gqrF9LR77A=;
 b=qFKNipfG72YGYUTKdVbNoqtxeAMh4PaqM7AwPMMa6E6b+SHBAAxzpWgKiVavl+h1Hw
 /Cq2SqR0Jy69REpw3bVFzfTEvX8nvh35eNUsO+b7tBMX1HvYLTLMGs/93VlW9I3XbaQa
 tizxZNR7Y0cFChoEyE2masIY9tWCT7h3onsnn7d5fNIWr6qyJqDoCg+XwPA3ns9Hf9Iy
 rqVqLQqx3Y80TMJz+o0o2a+dzp3bB7STPlExdRNLpTlevazRfQ0fgdamgi5jC13X7YYQ
 vpoadBLxzThbDsAogotbqdZNgkll0ZqWnPOAU7Ae3CVBsIU7XAt7NptkXQfR7HzX2FXo
 Uszg==
X-Gm-Message-State: APjAAAUTQSZJ4xD/8N9cqgoSAu5kte7VCWEqNJV4T34l2ttiU4NQFjCS
 2BxCp9IYyBAH6wyYl1ic9cmgIy1C4JY=
X-Google-Smtp-Source: APXvYqyJWY2wGHsO+qbCnHBnhlkxoYsxfOZ7CsqViEhACvVUtA1pXU19m2tBsQaLBiDe2nkyC664AA==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr15717847wrv.77.1576854263711; 
 Fri, 20 Dec 2019 07:04:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j12sm10846658wrw.54.2019.12.20.07.04.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 07:04:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D8051FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 15:04:21 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/28] cputlb: Use trace_mem_get_info instead of
 trace_mem_build_info
In-reply-to: <20191216221158.29572-3-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 15:04:21 +0000
Message-ID: <875zibdone.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

> In the cpu_ldst templates, we already require a MemOp, and it
> is cleaner and clearer to pass that instead of 3 separate
> arguments describing the memory operation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu_ldst_template.h          | 22 +++++++++++-----------
>  include/exec/cpu_ldst_useronly_template.h | 12 ++++++------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_tem=
plate.h
> index 54b5e858ce..0ad5de3ef9 100644
> --- a/include/exec/cpu_ldst_template.h
> +++ b/include/exec/cpu_ldst_template.h
> @@ -86,9 +86,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUAr=
chState *env,
>      RES_TYPE res;
>      target_ulong addr;
>      int mmu_idx =3D CPU_MMU_INDEX;
> -    TCGMemOpIdx oi;
> +    MemOp op =3D MO_TE | SHIFT;
>  #if !defined(SOFTMMU_CODE_ACCESS)
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, false=
, mmu_idx);
> +    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, false);
>      trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>  #endif
>=20=20
> @@ -96,9 +96,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUAr=
chState *env,
>      entry =3D tlb_entry(env, mmu_idx, addr);
>      if (unlikely(entry->ADDR_READ !=3D
>                   (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
> -        oi =3D make_memop_idx(SHIFT, mmu_idx);
> +        TCGMemOpIdx oi =3D make_memop_idx(op, mmu_idx);
>          res =3D glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, ad=
dr,
> -                                                            oi, retaddr);
> +                                                               oi, retad=
dr);
>      } else {
>          uintptr_t hostaddr =3D addr + entry->addend;
>          res =3D glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
> @@ -125,9 +125,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>      int res;
>      target_ulong addr;
>      int mmu_idx =3D CPU_MMU_INDEX;
> -    TCGMemOpIdx oi;
> -#if !defined(SOFTMMU_CODE_ACCESS)
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, true, MO_TE, false,=
 mmu_idx);
> +    MemOp op =3D MO_TE | MO_SIGN | SHIFT;
> +#ifndef SOFTMMU_CODE_ACCESS
> +    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, false);
>      trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>  #endif
>=20=20
> @@ -135,7 +135,7 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>      entry =3D tlb_entry(env, mmu_idx, addr);
>      if (unlikely(entry->ADDR_READ !=3D
>                   (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
> -        oi =3D make_memop_idx(SHIFT, mmu_idx);
> +        TCGMemOpIdx oi =3D make_memop_idx(op & ~MO_SIGN, mmu_idx);
>          res =3D (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
>                                 MMUSUFFIX)(env, addr, oi, retaddr);
>      } else {
> @@ -167,9 +167,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
>      CPUTLBEntry *entry;
>      target_ulong addr;
>      int mmu_idx =3D CPU_MMU_INDEX;
> -    TCGMemOpIdx oi;
> +    MemOp op =3D MO_TE | SHIFT;
>  #if !defined(SOFTMMU_CODE_ACCESS)
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, true,=
 mmu_idx);
> +    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, true);
>      trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>  #endif
>=20=20
> @@ -177,7 +177,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
>      entry =3D tlb_entry(env, mmu_idx, addr);
>      if (unlikely(tlb_addr_write(entry) !=3D
>                   (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
> -        oi =3D make_memop_idx(SHIFT, mmu_idx);
> +        TCGMemOpIdx oi =3D make_memop_idx(op, mmu_idx);
>          glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
>                                                       retaddr);
>      } else {
> diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu=
_ldst_useronly_template.h
> index dbdc7a845d..e5a3d1983a 100644
> --- a/include/exec/cpu_ldst_useronly_template.h
> +++ b/include/exec/cpu_ldst_useronly_template.h
> @@ -70,8 +70,8 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *en=
v, abi_ptr ptr)
>      ret =3D glue(glue(ld, USUFFIX), _p)(g2h(ptr));
>      clear_helper_retaddr();
>  #else
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, false,
> -                                            MMU_USER_IDX);
> +    MemOp op =3D MO_TE | SHIFT;
> +    uint16_t meminfo =3D trace_mem_get_info(op, MMU_USER_IDX, false);
>      trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>      ret =3D glue(glue(ld, USUFFIX), _p)(g2h(ptr));
>  #endif
> @@ -102,8 +102,8 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *=
env, abi_ptr ptr)
>      ret =3D glue(glue(lds, SUFFIX), _p)(g2h(ptr));
>      clear_helper_retaddr();
>  #else
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, true, MO_TE, false,
> -                                            MMU_USER_IDX);
> +    MemOp op =3D MO_TE | MO_SIGN | SHIFT;
> +    uint16_t meminfo =3D trace_mem_get_info(op, MMU_USER_IDX, false);
>      trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>      ret =3D glue(glue(lds, SUFFIX), _p)(g2h(ptr));
>      qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> @@ -131,8 +131,8 @@ static inline void
>  glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
>                                        RES_TYPE v)
>  {
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, true,
> -                                            MMU_USER_IDX);
> +    MemOp op =3D MO_TE | SHIFT;
> +    uint16_t meminfo =3D trace_mem_get_info(op, MMU_USER_IDX, true);
>      trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>      glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
>      qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);


--=20
Alex Benn=C3=A9e

