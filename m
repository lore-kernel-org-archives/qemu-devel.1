Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C12AC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3261321851
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8W5lJhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3261321851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSN5U-0008Us-Cm
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 10:46:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSN4W-00087g-1N
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSN4U-0003kO-7h
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:45:55 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSN4T-0003jr-UD
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:45:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id t22so5514110pgi.10
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mjfoKK613SwjpbU4Y4YPJUTjmsypIxBmGTN8u6ADyOI=;
	b=L8W5lJhAMwQFjwkt/5BKiUOJIETJy4kqItD7diK0qDTYbttUslo8Rks2hiPOIm+K65
	a7uEY9G3+OsrOW1keplngzaFDgxxst3vM1UUM+kIHKDja2kF9pNcjd1orqAaLW2XmAiu
	ek39AT+mq0hfRdWQkvR9Rt7/rMoe653kaONt8bPg+Al6d5nG3qY6CUHhTtuaertIJYvV
	9PK/5X6Ou676cFDffthCwpb0dyiP6ay8qZXl57XifNqLEFcpb4PAi4VS6Ld3uH7G/LnT
	qCJ9NtdlB40uvxV1hu841yz57GxDNVZc0DbeuL87v3kOnkiMOqrj2NCzv7lBDgnoTzoM
	WlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mjfoKK613SwjpbU4Y4YPJUTjmsypIxBmGTN8u6ADyOI=;
	b=OO193QKe0VOtaTPTXrFO1GDEnN2L5axR6AAZ6fDTtg79QZsuxCavWVAfwtlIZT5kz2
	rVc6YW5AEFrqja19Bh76nwmUj+lKDKWbJsNr8fCSmSmQXvXWzYrthW5XxnM9rPNVq5pH
	A1NK9ZuQR29M4kP5fvgxNvKC7qt7Ax5S8OCQV9lm4jXN0ilN09mgMe1JwVIGk8K0oKlh
	+a1NR53LZ2t2v7pt6LPUw65Ikd+gDS/k9duExTsu8GiwRwvS7dU9thrQ89arRbkfoIUD
	fQJFK8/XJ1/HDxldw9MTcR1UjsiR3UoQk7UcMjM2cSqnxci0zssapbSWwVII9FbODSd4
	cw6Q==
X-Gm-Message-State: APjAAAV4geYprjdF0yNAN8sq/8Af/n+3i7qAwDEWO8n7vBU/BSxWSstH
	z+MlcGnAvlMDjprhVRHPoI4iWotUlkU=
X-Google-Smtp-Source: APXvYqz6KF9UoxObJR+Pvb2dgULxoLUx0GZ/+lOeRRWHemLrBtUtU2FpyggZ6RYRHFlS8hpPuSG7+Q==
X-Received: by 2002:a63:2943:: with SMTP id p64mr70577486pgp.151.1558277151870;
	Sun, 19 May 2019 07:45:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	m1sm28520720pga.22.2019.05.19.07.45.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 07:45:50 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
	<20190519041522.12327-4-richard.henderson@linaro.org>
	<CAL1e-=hc6xgfEPjAgrf6ctOFonriunT8OerU0BwfD0OjZLROww@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6acda761-9e5c-9e9c-f7a5-2346995200de@linaro.org>
Date: Sun, 19 May 2019 07:45:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hc6xgfEPjAgrf6ctOFonriunT8OerU0BwfD0OjZLROww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v4 3/7] tcg/ppc: Support vector multiply
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/19 10:05 PM, Aleksandar Markovic wrote:
> 
> On May 19, 2019 6:35 AM, "Richard Henderson" <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
>>
>> For Altivec, this is always an expansion.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>>
>> ---
> 
> Large portions of this patch have nothing to do with what title or commit
> message say.Reorganize.


I beg to differ.  Absolutely nothing in this patch is unrelated to supporting
vector multiply for Altivec.


> 
> 
> For Altivec, this is always an expansion.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.h     |   2 +-
>  tcg/ppc/tcg-target.opc.h |   8 +++
>  tcg/ppc/tcg-target.inc.c | 112 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 120 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
> index 766706fd30..a130192cbd 100644
> --- a/tcg/ppc/tcg-target.h
> +++ b/tcg/ppc/tcg-target.h
> @@ -154,7 +154,7 @@ extern bool have_isa_3_00;
>  #define TCG_TARGET_HAS_shs_vec          0
>  #define TCG_TARGET_HAS_shv_vec          1
>  #define TCG_TARGET_HAS_cmp_vec          1
> -#define TCG_TARGET_HAS_mul_vec          0
> +#define TCG_TARGET_HAS_mul_vec          1

Enable middle-end expansion of multiply.


>  #define TCG_TARGET_HAS_sat_vec          1
>  #define TCG_TARGET_HAS_minmax_vec       1
>  #define TCG_TARGET_HAS_bitsel_vec       0
> diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target.opc.h
> index 4816a6c3d4..5c6a5ad52c 100644
> --- a/tcg/ppc/tcg-target.opc.h
> +++ b/tcg/ppc/tcg-target.opc.h
> @@ -1,3 +1,11 @@
>  /* Target-specific opcodes for host vector expansion.  These will be
>     emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
>     consider these to be UNSPEC with names.  */
> +
> +DEF(ppc_mrgh_vec, 1, 2, 0, IMPLVEC)
> +DEF(ppc_mrgl_vec, 1, 2, 0, IMPLVEC)
> +DEF(ppc_msum_vec, 1, 3, 0, IMPLVEC)
> +DEF(ppc_muleu_vec, 1, 2, 0, IMPLVEC)
> +DEF(ppc_mulou_vec, 1, 2, 0, IMPLVEC)
> +DEF(ppc_pkum_vec, 1, 2, 0, IMPLVEC)
> +DEF(ppc_rotl_vec, 1, 2, 0, IMPLVEC)

Define Altivec-specifc tcg opcodes needed for expansion of multiply.
These directly correspond to...

> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 62a8c428e0..9d58db9eb1 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -526,6 +526,25 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
>  #define VSRAB      VX4(772)
>  #define VSRAH      VX4(836)
>  #define VSRAW      VX4(900)
> +#define VRLB       VX4(4)
> +#define VRLH       VX4(68)
> +#define VRLW       VX4(132)
> +
> +#define VMULEUB    VX4(520)
> +#define VMULEUH    VX4(584)
> +#define VMULOUB    VX4(8)
> +#define VMULOUH    VX4(72)
> +#define VMSUMUHM   VX4(38)
> +
> +#define VMRGHB     VX4(12)
> +#define VMRGHH     VX4(76)
> +#define VMRGHW     VX4(140)
> +#define VMRGLB     VX4(268)
> +#define VMRGLH     VX4(332)
> +#define VMRGLW     VX4(396)
> +
> +#define VPKUHUM    VX4(14)
> +#define VPKUWUM    VX4(78)

The Altivec instruction opcodes for multiply, plus a few others needed for the
expansion.

>  
>  #define VAND       VX4(1028)
>  #define VANDC      VX4(1092)
> @@ -2892,6 +2911,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
>      case INDEX_op_sarv_vec:
>          return vece <= MO_32;
>      case INDEX_op_cmp_vec:
> +    case INDEX_op_mul_vec:

Enable expansion of multiply.

>      case INDEX_op_shli_vec:
>      case INDEX_op_shri_vec:
>      case INDEX_op_sari_vec:
> @@ -3005,7 +3025,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>          smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 },
>          shlv_op[4] = { VSLB, VSLH, VSLW, 0 },
>          shrv_op[4] = { VSRB, VSRH, VSRW, 0 },
> -        sarv_op[4] = { VSRAB, VSRAH, VSRAW, 0 };
> +        sarv_op[4] = { VSRAB, VSRAH, VSRAW, 0 },
> +        mrgh_op[4] = { VMRGHB, VMRGHH, VMRGHW, 0 },
> +        mrgl_op[4] = { VMRGLB, VMRGLH, VMRGLW, 0 },
> +        muleu_op[4] = { VMULEUB, VMULEUH, 0, 0 },
> +        mulou_op[4] = { VMULOUB, VMULOUH, 0, 0 },
> +        pkum_op[4] = { VPKUHUM, VPKUWUM, 0, 0 },
> +        rotl_op[4] = { VRLB, VRLH, VRLW, 0 };

Map tcg opcodes to Altivec instructions used by multiply expansion.

>  
>      TCGType type = vecl + TCG_TYPE_V64;
>      TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
> @@ -3094,6 +3120,29 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>          }
>          break;
>  
> +    case INDEX_op_ppc_mrgh_vec:
> +        insn = mrgh_op[vece];
> +        break;
> +    case INDEX_op_ppc_mrgl_vec:
> +        insn = mrgl_op[vece];
> +        break;
> +    case INDEX_op_ppc_muleu_vec:
> +        insn = muleu_op[vece];
> +        break;
> +    case INDEX_op_ppc_mulou_vec:
> +        insn = mulou_op[vece];
> +        break;
> +    case INDEX_op_ppc_pkum_vec:
> +        insn = pkum_op[vece];
> +        break;
> +    case INDEX_op_ppc_rotl_vec:
> +        insn = rotl_op[vece];
> +        break;
> +    case INDEX_op_ppc_msum_vec:
> +        tcg_debug_assert(vece == MO_16);
> +        tcg_out32(s, VMSUMUHM | VRT(a0) | VRA(a1) | VRB(a2) | VRC(args[3]));
> +        return;

Emit said multiply instructions.

> +
>      case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
>      case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
> @@ -3163,6 +3212,53 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
>      }
>  }
>  
> +static void expand_vec_mul(TCGType type, unsigned vece, TCGv_vec v0,
> +                           TCGv_vec v1, TCGv_vec v2)
> +{
> +    TCGv_vec t1 = tcg_temp_new_vec(type);
> +    TCGv_vec t2 = tcg_temp_new_vec(type);
> +    TCGv_vec t3, t4;
> +
> +    switch (vece) {
> +    case MO_8:
> +    case MO_16:
> +        vec_gen_3(INDEX_op_ppc_muleu_vec, type, vece, tcgv_vec_arg(t1),
> +                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
> +        vec_gen_3(INDEX_op_ppc_mulou_vec, type, vece, tcgv_vec_arg(t2),
> +                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
> +        vec_gen_3(INDEX_op_ppc_mrgh_vec, type, vece + 1, tcgv_vec_arg(v0),
> +                  tcgv_vec_arg(t1), tcgv_vec_arg(t2));
> +        vec_gen_3(INDEX_op_ppc_mrgl_vec, type, vece + 1, tcgv_vec_arg(t1),
> +                  tcgv_vec_arg(t1), tcgv_vec_arg(t2));
> +        vec_gen_3(INDEX_op_ppc_pkum_vec, type, vece, tcgv_vec_arg(v0),
> +                  tcgv_vec_arg(v0), tcgv_vec_arg(t1));
> +	break;
> +
> +    case MO_32:
> +        t3 = tcg_temp_new_vec(type);
> +        t4 = tcg_temp_new_vec(type);
> +        tcg_gen_dupi_vec(MO_8, t4, -16);
> +        vec_gen_3(INDEX_op_ppc_rotl_vec, type, MO_32, tcgv_vec_arg(t1),
> +                  tcgv_vec_arg(v2), tcgv_vec_arg(t4));
> +        vec_gen_3(INDEX_op_ppc_mulou_vec, type, MO_16, tcgv_vec_arg(t2),
> +                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
> +        tcg_gen_dupi_vec(MO_8, t3, 0);
> +        vec_gen_4(INDEX_op_ppc_msum_vec, type, MO_16, tcgv_vec_arg(t3),
> +                  tcgv_vec_arg(v1), tcgv_vec_arg(t1), tcgv_vec_arg(t3));
> +        vec_gen_3(INDEX_op_shlv_vec, type, MO_32, tcgv_vec_arg(t3),
> +                  tcgv_vec_arg(t3), tcgv_vec_arg(t4));
> +        tcg_gen_add_vec(MO_32, v0, t2, t3);
> +        tcg_temp_free_vec(t3);
> +        tcg_temp_free_vec(t4);
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +    tcg_temp_free_vec(t1);
> +    tcg_temp_free_vec(t2);
> +}

Expand multiply operation, as advertised.

> +
>  void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
>                         TCGArg a0, ...)
>  {
> @@ -3189,6 +3285,10 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
>          v2 = temp_tcgv_vec(arg_temp(a2));
>          expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
>          break;
> +    case INDEX_op_mul_vec:
> +        v2 = temp_tcgv_vec(arg_temp(a2));
> +        expand_vec_mul(type, vece, v0, v1, v2);
> +        break;

Call the above expander.

>      default:
>          g_assert_not_reached();
>      }
> @@ -3235,6 +3335,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>      static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
>      static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
>      static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
> +    static const TCGTargetOpDef v_v_v_v
> +        = { .args_ct_str = { "v", "v", "v", "v" } };
>  
>      switch (op) {
>      case INDEX_op_goto_ptr:
> @@ -3390,6 +3492,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>      case INDEX_op_shlv_vec:
>      case INDEX_op_shrv_vec:
>      case INDEX_op_sarv_vec:
> +    case INDEX_op_ppc_mrgh_vec:
> +    case INDEX_op_ppc_mrgl_vec:
> +    case INDEX_op_ppc_muleu_vec:
> +    case INDEX_op_ppc_mulou_vec:
> +    case INDEX_op_ppc_pkum_vec:
> +    case INDEX_op_ppc_rotl_vec:
>          return &v_v_v;

Define constraints for the ppc opcodes defined earlier.

>      case INDEX_op_not_vec:
>      case INDEX_op_dup_vec:
> @@ -3398,6 +3506,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>      case INDEX_op_st_vec:
>      case INDEX_op_dupm_vec:
>          return &v_r;
> +    case INDEX_op_ppc_msum_vec:
> +        return &v_v_v_v;

Likewise.

>  
>      default:
>          return NULL;
> -- 
> 2.17.1
> 


What is left?  Nothing.

Thanks,


r~

