Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B19C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6F2206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJutxBhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6F2206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiO8c-0002sH-HZ
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiO7f-0002Ne-KY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiO7e-000130-At
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:39:39 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiO7e-0000yx-3N
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:39:38 -0500
Received: by mail-wm1-x341.google.com with SMTP id m24so10066799wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HsGpBMEgXVqGhtlTuyhQn7brBhIxVmbkyoMRTRwEcN0=;
 b=zJutxBhmzs6FvX9fAB4NWiRb4vPUwfrLGydC3WSSDu745cZX5XXyOt0Fg045UbPJkQ
 XevvDTLTS/iMjmUvsExDW11sXhdlu9akyTbwdxkIiCnArh2FgS+eLe3UkPhOjJgo1Fo0
 DmcF6Vgw7+WejNyazrIv0rqxJc9R/PUMxsAi2+y8sszPCBgCqx6MA+1qIoGh9EeOlkxx
 JifbkgBXlyNLQewoCTTfW8hLtQ7vT1Swn8sgeYYQ5NHWrpGCQabkncLy6nahbA18ron2
 PxBB3CLU0KnIh3H/i8sBKrbAwk9/xARuNnE1AoJg3wfYR/4ciapZ0fEEeYmmeM+0SyLl
 pjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HsGpBMEgXVqGhtlTuyhQn7brBhIxVmbkyoMRTRwEcN0=;
 b=r69FzR/YNfbF9J0yzlz8sS+hSVkJzZBOO5JJUMBtn9EGdabbTMy+BYUq1j46kJ9dXG
 4xU7wlJQ2urPL4+UxzJs4jln844wR76GeruQwbWnleuJrHaOqaowVOu1RY3+xOmyFYA3
 auJu9dLVFk0lnIO0nYbmase0Obs32Yc/Fj7yh6+gVLVgLRSLxEkRAIkJC8jVXIWXL8nE
 AMeJPOZQrG8GjVR8YV6CoN3W3GpFk+Ed2adTo1DE1AzYfMLt6sUE8+9kWOadWvHBetKr
 Qz9dPpGIq9pru9DBTBx1kt3YYtSuzI4xwApeJcss9/PhSdJkmuFtPsXpvzWHWrgIvykW
 ZyNw==
X-Gm-Message-State: APjAAAXd7VA7yORfZO2dEDovI+fGKj3jAUMos5VxUNCg8nZdny48uGXU
 by+Z5TtgGaTsucajT7C8cZKbj2gXy2I=
X-Google-Smtp-Source: APXvYqwYw3Ddp5cZF6u4yDggHkNI88IonNb5YAv7a1EGUiYnPwq7dAyN9HUTG8smzwkfpwnDpiIZNg==
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr18335795wml.43.1576870776212; 
 Fri, 20 Dec 2019 11:39:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f12sm10512645wmf.28.2019.12.20.11.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 11:39:34 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F7E71FF87;
 Fri, 20 Dec 2019 19:39:34 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-26-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 25/28] target/s390x: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
In-reply-to: <20191216221158.29572-26-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 19:39:34 +0000
Message-ID: <878sn6bxc9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The generated functions aside from *_real are unused.
> The *_real functions have a couple of users in mem_helper.c;
> use *_mmuidx_ra instead, with MMU_REAL_IDX.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

FYI there is a merge conflict with master as some of the helpers have
been replaced with inline code (by you ;-).

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Use *_mmuidx_ra directly, without intermediate macros.
> ---
>  target/s390x/cpu.h        |  5 -----
>  target/s390x/mem_helper.c | 21 ++++++++++++---------
>  2 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index aa829e954c..cfa8a81265 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -36,11 +36,6 @@
>=20=20
>  #define TARGET_INSN_START_EXTRA_WORDS 2
>=20=20
> -#define MMU_MODE0_SUFFIX _primary
> -#define MMU_MODE1_SUFFIX _secondary
> -#define MMU_MODE2_SUFFIX _home
> -#define MMU_MODE3_SUFFIX _real
> -
>  #define MMU_USER_IDX 0
>=20=20
>  #define S390_MAX_CPUS 248
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 57ce17c252..6f4a16b9b2 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -2026,7 +2026,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint=
64_t real_addr)
>      real_addr =3D wrap_address(env, real_addr) & TARGET_PAGE_MASK;
>=20=20
>      for (i =3D 0; i < TARGET_PAGE_SIZE; i +=3D 8) {
> -        cpu_stq_real_ra(env, real_addr + i, 0, ra);
> +        cpu_stq_mmuidx_ra(env, real_addr + i, 0, MMU_REAL_IDX, ra);
>      }
>=20=20
>      return 0;
> @@ -2260,11 +2260,11 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1=
, uint64_t r2, uint32_t m4)
>          for (i =3D 0; i < entries; i++) {
>              /* addresses are not wrapped in 24/31bit mode but table inde=
x is */
>              raddr =3D table + ((index + i) & 0x7ff) * sizeof(entry);
> -            entry =3D cpu_ldq_real_ra(env, raddr, ra);
> +            entry =3D cpu_ldq_mmuidx_ra(env, raddr, MMU_REAL_IDX, ra);
>              if (!(entry & REGION_ENTRY_I)) {
>                  /* we are allowed to not store if already invalid */
>                  entry |=3D REGION_ENTRY_I;
> -                cpu_stq_real_ra(env, raddr, entry, ra);
> +                cpu_stq_mmuidx_ra(env, raddr, entry, MMU_REAL_IDX, ra);
>              }
>          }
>      }
> @@ -2291,9 +2291,9 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto,=
 uint64_t vaddr,
>      pte_addr +=3D VADDR_PAGE_TX(vaddr) * 8;
>=20=20
>      /* Mark the page table entry as invalid */
> -    pte =3D cpu_ldq_real_ra(env, pte_addr, ra);
> +    pte =3D cpu_ldq_mmuidx_ra(env, pte_addr, MMU_REAL_IDX, ra);
>      pte |=3D PAGE_ENTRY_I;
> -    cpu_stq_real_ra(env, pte_addr, pte, ra);
> +    cpu_stq_mmuidx_ra(env, pte_addr, pte, MMU_REAL_IDX, ra);
>=20=20
>      /* XXX we exploit the fact that Linux passes the exact virtual
>         address here - it's not obliged to! */
> @@ -2333,18 +2333,21 @@ void HELPER(purge)(CPUS390XState *env)
>  /* load using real address */
>  uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
>  {
> -    return cpu_ldl_real_ra(env, wrap_address(env, addr), GETPC());
> +    return cpu_ldl_mmuidx_ra(env, wrap_address(env, addr),
> +                             MMU_REAL_IDX, GETPC());
>  }
>=20=20
>  uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
>  {
> -    return cpu_ldq_real_ra(env, wrap_address(env, addr), GETPC());
> +    return cpu_ldq_mmuidx_ra(env, wrap_address(env, addr),
> +                             MMU_REAL_IDX, GETPC());
>  }
>=20=20
>  /* store using real address */
>  void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
>  {
> -    cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
> +    cpu_stl_mmuidx_ra(env, wrap_address(env, addr), (uint32_t)v1,
> +                      MMU_REAL_IDX, GETPC());
>=20=20
>      if ((env->psw.mask & PSW_MASK_PER) &&
>          (env->cregs[9] & PER_CR9_EVENT_STORE) &&
> @@ -2357,7 +2360,7 @@ void HELPER(stura)(CPUS390XState *env, uint64_t add=
r, uint64_t v1)
>=20=20
>  void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
>  {
> -    cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
> +    cpu_stq_mmuidx_ra(env, wrap_address(env, addr), v1, MMU_REAL_IDX, GE=
TPC());
>=20=20
>      if ((env->psw.mask & PSW_MASK_PER) &&
>          (env->cregs[9] & PER_CR9_EVENT_STORE) &&


--=20
Alex Benn=C3=A9e

