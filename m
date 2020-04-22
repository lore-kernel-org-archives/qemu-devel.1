Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA8C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A728A20767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmzAk2On"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A728A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRL3m-00011b-P0
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRL3B-0000am-Hz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRL3A-0002xf-J7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:28:49 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRL3A-0002x4-1C
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:28:48 -0400
Received: by mail-wm1-x343.google.com with SMTP id x4so3792461wmj.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zGkNfCKUNENf3NNMIXzaOPVQSJO3n2WN36cOMWlYW1M=;
 b=UmzAk2Onq6QD+87UuQ635bjJ2WSeuiFgr5Wp7iQYDmsR3bLSysOtdzed1bs8tVpV27
 Kq9uv8wTI88e8KEUhA/oXrwKf6pX8T15C3U6Tsc35rWc3j/ClHUogBUkIUS9Ltr81vWk
 aNbWRPSKW9RD3cLljlyhQjcKuFQFra0E98GOGHrSZw0urSpqQ77SYpA1ZG3H5/91srK5
 aP2styDmjPWZbhppo6t3qqbphxt/mUwFqXwC6CjwhElOl7IMENQSi4wWEusQRoIchF7p
 oaKqQgsw57ssF/N7jFwiLZTyFj0ckH73ymTQs8c1o6zE0w4rkTynHdmwXyqFsygygjHK
 X3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zGkNfCKUNENf3NNMIXzaOPVQSJO3n2WN36cOMWlYW1M=;
 b=LU80G5BdQeVh01lqdQvzbiFJJDtQ+ZYNmTxIyRhbcdEvvpo993PF2qn6Lu1GfBloqg
 59hkBegaYMTXJ3BOVKdNs6DOPJCFmMSQ3UWXlA9I9VK7urmYYV0zB8kip5R2YQ2Aea9s
 FZBBNer7fKUDiJkz5d8IhcmYyZvsZ/Fh6wgK/8gOVyZhRpI0Fc0mECAd2BheQdic4meD
 Qg1GEiog/SfknvWMmFcqoGAGsLg+CfjmZk2tlcL7/g6thcN0rIWsNwToJLhG2uaulElq
 f3cgpkgmFrB6m+3YOJzLF63Q/i5kQl925ymYINDst2ulr+v8/v7ce95RutDJCbt0w45p
 vWjg==
X-Gm-Message-State: AGi0PuZS6HRzNTLFXwxSyQimKQmxb6u1iO+255hzKi1ffuwSpBJgnsiN
 HzvfDfJmFEK++R3NBmgf4vqpQw==
X-Google-Smtp-Source: APiQypJB98eDvbjIFOIVXy35ygpPqaIPLlDuKNWSWBf4/wGudEYCqAwFScM+6Zhan8JcistyR5O9BA==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr5381wmb.127.1587583726357;
 Wed, 22 Apr 2020 12:28:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q18sm325848wmj.11.2020.04.22.12.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 12:28:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B8DC21FF7E;
 Wed, 22 Apr 2020 20:28:44 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-22-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 21/36] tcg: Use tcg_out_dupi_vec from temp_load
In-reply-to: <20200422011722.13287-22-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 20:28:44 +0100
Message-ID: <87r1wfb9qr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Having dupi pass though movi is confusing and arguably wrong.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.inc.c |  7 ----
>  tcg/i386/tcg-target.inc.c    | 63 ++++++++++++++++++++++++------------
>  tcg/ppc/tcg-target.inc.c     |  6 ----
>  tcg/tcg.c                    |  8 ++++-
>  4 files changed, 49 insertions(+), 35 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 7918aeb9d5..e5c9ab70a9 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1009,13 +1009,6 @@ static void tcg_out_movi(TCGContext *s, TCGType ty=
pe, TCGReg rd,
>      case TCG_TYPE_I64:
>          tcg_debug_assert(rd < 32);
>          break;
> -
> -    case TCG_TYPE_V64:
> -    case TCG_TYPE_V128:
> -        tcg_debug_assert(rd >=3D 32);
> -        tcg_out_dupi_vec(s, type, rd, value);
> -        return;
> -
>      default:
>          g_assert_not_reached();
>      }
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 320a4bddd1..07424f7ef9 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -977,30 +977,32 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType=
 type,
>      }
>  }
>=20=20
> -static void tcg_out_movi(TCGContext *s, TCGType type,
> -                         TCGReg ret, tcg_target_long arg)
> +static void tcg_out_movi_vec(TCGContext *s, TCGType type,
> +                             TCGReg ret, tcg_target_long arg)
> +{
> +    if (arg =3D=3D 0) {
> +        tcg_out_vex_modrm(s, OPC_PXOR, ret, ret, ret);
> +        return;
> +    }
> +    if (arg =3D=3D -1) {
> +        tcg_out_vex_modrm(s, OPC_PCMPEQB, ret, ret, ret);
> +        return;
> +    }
> +
> +    int rexw =3D (type =3D=3D TCG_TYPE_I32 ? 0 : P_REXW);
> +    tcg_out_vex_modrm_pool(s, OPC_MOVD_VyEy + rexw, ret);
> +    if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +        new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
> +    } else {
> +        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
> +    }
> +}
> +
> +static void tcg_out_movi_int(TCGContext *s, TCGType type,
> +                             TCGReg ret, tcg_target_long arg)
>  {
>      tcg_target_long diff;
>=20=20
> -    switch (type) {
> -    case TCG_TYPE_I32:
> -#if TCG_TARGET_REG_BITS =3D=3D 64
> -    case TCG_TYPE_I64:
> -#endif
> -        if (ret < 16) {
> -            break;
> -        }
> -        /* fallthru */
> -    case TCG_TYPE_V64:
> -    case TCG_TYPE_V128:
> -    case TCG_TYPE_V256:
> -        tcg_debug_assert(ret >=3D 16);
> -        tcg_out_dupi_vec(s, type, ret, arg);
> -        return;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
>      if (arg =3D=3D 0) {
>          tgen_arithr(s, ARITH_XOR, ret, ret);
>          return;
> @@ -1029,6 +1031,25 @@ static void tcg_out_movi(TCGContext *s, TCGType ty=
pe,
>      tcg_out64(s, arg);
>  }
>=20=20
> +static void tcg_out_movi(TCGContext *s, TCGType type,
> +                         TCGReg ret, tcg_target_long arg)
> +{
> +    switch (type) {
> +    case TCG_TYPE_I32:
> +#if TCG_TARGET_REG_BITS =3D=3D 64
> +    case TCG_TYPE_I64:
> +#endif
> +        if (ret < 16) {
> +            tcg_out_movi_int(s, type, ret, arg);
> +        } else {
> +            tcg_out_movi_vec(s, type, ret, arg);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  static inline void tcg_out_pushi(TCGContext *s, tcg_target_long val)
>  {
>      if (val =3D=3D (int8_t)val) {
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index fb390ad978..7ab1e32064 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -987,12 +987,6 @@ static void tcg_out_movi(TCGContext *s, TCGType type=
, TCGReg ret,
>          tcg_out_movi_int(s, type, ret, arg, false);
>          break;
>=20=20
> -    case TCG_TYPE_V64:
> -    case TCG_TYPE_V128:
> -        tcg_debug_assert(ret >=3D TCG_REG_V0);
> -        tcg_out_dupi_vec(s, type, ret, arg);
> -        break;
> -
>      default:
>          g_assert_not_reached();
>      }
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index adb71f16ae..4f1ed1d2fe 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3359,7 +3359,13 @@ static void temp_load(TCGContext *s, TCGTemp *ts, =
TCGRegSet desired_regs,
>      case TEMP_VAL_CONST:
>          reg =3D tcg_reg_alloc(s, desired_regs, allocated_regs,
>                              preferred_regs, ts->indirect_base);
> -        tcg_out_movi(s, ts->type, reg, ts->val);
> +        if (ts->type <=3D TCG_TYPE_I64) {
> +            tcg_out_movi(s, ts->type, reg, ts->val);
> +        } else if (TCG_TARGET_REG_BITS =3D=3D 64) {
> +            tcg_out_dupi_vec(s, ts->type, reg, ts->val);
> +        } else {
> +            tcg_out_dupi_vec(s, ts->type, reg, dup_const(MO_32, ts->val)=
);
> +        }
>          ts->mem_coherent =3D 0;
>          break;
>      case TEMP_VAL_MEM:


--=20
Alex Benn=C3=A9e

