Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A01FC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243B320767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZFh+QswI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243B320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRKfT-0000TC-Ao
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRKek-0008Jc-5n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRKej-00019j-72
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:03:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRKei-00017v-Oh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:03:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id g13so3801684wrb.8
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IhjFq+ETIXwKBvmYJwrgeP2VnashUHzpeuUQQjRyXug=;
 b=ZFh+QswIJLbGPt1XYDB9mbpnSXBhr/61FftrDRpi9TfJzfFXKl8BBTAZhpjp4SgIFY
 usvmceiMPz51Wz+UiY4Yib0UpNrqgMdfZKaAWuNc/oC4zmO4UD+4cKT3b2r2YjsYDlzX
 wY5SEXcLIV6NHbsg/0/L1iOH2jOHAZAsePb/lxFDqhFB+dRwE/XmxVXx6P2dCDiqPhqv
 bhZ4cmjny/ozolmoOnyvQLycNCQhHGxlf3I7a1WPu6Y1LOm7yhePfk/yB19NYMrvO+Gd
 JmbnpU4jKijdFoGi2dgI+ZFqXnno+zoz4ob/ovr4h/3ojv0+AhToz4aZXIsq9BbG9oNs
 vg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IhjFq+ETIXwKBvmYJwrgeP2VnashUHzpeuUQQjRyXug=;
 b=NYoENXqkAmI5hgSXSlBbT7eeMTnoAfAiiUZhBi9ob/TTWt9gBdCH+Xm5BWgGTdZF8J
 Uo8gQ2CjD7V9+qXmmHYZeS4GxgyuSvviLH4Sz5hJHYekDurEN84VFP8A33HGMMmLK4K+
 YH6Lxyqe1Zx+423taQaqVMAYFzz6XeAjyCBkUmQ2xamB2FRBxr6s/MxPmO5RU1AEHfJf
 AAzrTy9CH4FNc8l6QDlUORf5K9gaTawkQsOeeLPio8VVMQ74V8IDiXLSATheaP7dQU7S
 2+C5GED5McGEwpic2QSFyFzOj8fnbqeZWwo5U0fzi/tS8E68pyKsbKB0WDjeshY9CkSz
 gnOQ==
X-Gm-Message-State: AGi0PuY7uEGHFHzym45c956SR/L8AWef5hM0Ag0TuDws3mE3Uk2B6jO0
 KY3Q420pWedkox8xBCcnsqX8Khx+8hs=
X-Google-Smtp-Source: APiQypKspmzmPv/ud7A5L5xUjYTQ/c6IYE/coW8LuXAI3DeZw7ly13d2yOgR91fo4C6XDo/4aOt4uQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr542114wrw.318.1587582211121;
 Wed, 22 Apr 2020 12:03:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k17sm285274wmi.10.2020.04.22.12.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 12:03:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 044981FF7E;
 Wed, 22 Apr 2020 20:03:29 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-21-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 20/36] tcg: Remove movi and dupi opcodes
In-reply-to: <20200422011722.13287-21-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 20:03:29 +0100
Message-ID: <87tv1bbawu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> These are now completely covered by mov from a
> TYPE_CONST temporary.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/tcg/tcg-opc.h        |  3 ---
>  tcg/aarch64/tcg-target.inc.c |  3 ---
>  tcg/arm/tcg-target.inc.c     |  1 -
>  tcg/i386/tcg-target.inc.c    |  3 ---
>  tcg/mips/tcg-target.inc.c    |  2 --
>  tcg/optimize.c               |  4 ----
>  tcg/ppc/tcg-target.inc.c     |  3 ---
>  tcg/riscv/tcg-target.inc.c   |  2 --
>  tcg/s390/tcg-target.inc.c    |  2 --
>  tcg/sparc/tcg-target.inc.c   |  2 --
>  tcg/tcg-op-vec.c             |  1 -
>  tcg/tcg.c                    | 18 +-----------------
>  tcg/tci/tcg-target.inc.c     |  2 --
>  13 files changed, 1 insertion(+), 45 deletions(-)
>
> diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
> index 7dee9b38f7..4a9cbf5426 100644
> --- a/include/tcg/tcg-opc.h
> +++ b/include/tcg/tcg-opc.h
> @@ -45,7 +45,6 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END)
>  DEF(mb, 0, 0, 1, 0)
>=20=20
>  DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
> -DEF(movi_i32, 1, 0, 1, TCG_OPF_NOT_PRESENT)
>  DEF(setcond_i32, 1, 2, 1, 0)
>  DEF(movcond_i32, 1, 4, 1, IMPL(TCG_TARGET_HAS_movcond_i32))
>  /* load/store */
> @@ -110,7 +109,6 @@ DEF(ctz_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_ctz_i32))
>  DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
>=20=20
>  DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
> -DEF(movi_i64, 1, 0, 1, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
>  DEF(setcond_i64, 1, 2, 1, IMPL64)
>  DEF(movcond_i64, 1, 4, 1, IMPL64 | IMPL(TCG_TARGET_HAS_movcond_i64))
>  /* load/store */
> @@ -215,7 +213,6 @@ DEF(qemu_st_i64, 0, TLADDR_ARGS + DATA64_ARGS, 1,
>  #define IMPLVEC  TCG_OPF_VECTOR | IMPL(TCG_TARGET_MAYBE_vec)
>=20=20
>  DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
> -DEF(dupi_vec, 1, 0, 1, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
>=20=20
>  DEF(dup_vec, 1, 1, 0, IMPLVEC)
>  DEF(dup2_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_REG_BITS =3D=3D 32))
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 843fd0ca69..7918aeb9d5 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -2261,8 +2261,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>=20=20
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          g_assert_not_reached();
> @@ -2467,7 +2465,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode=
 opc,
>          break;
>=20=20
>      case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
> -    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
>      case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
>      default:
>          g_assert_not_reached();
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 6aa7757aac..b967499fa4 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -2068,7 +2068,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpc=
ode opc,
>          break;
>=20=20
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index ec083bddcf..320a4bddd1 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -2678,8 +2678,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpc=
ode opc,
>          break;
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> @@ -2965,7 +2963,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode=
 opc,
>          break;
>=20=20
>      case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
> -    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
>      case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
>      default:
>          g_assert_not_reached();
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 4d32ebc1df..09dc5a94fa 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -2155,8 +2155,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpc=
ode opc,
>          break;
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index dd5187be31..9a2c945dbe 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1099,10 +1099,6 @@ void tcg_optimize(TCGContext *s)
>          CASE_OP_32_64_VEC(mov):
>              tcg_opt_gen_mov(s, op, op->args[0], op->args[1]);
>              break;
> -        CASE_OP_32_64(movi):
> -        case INDEX_op_dupi_vec:
> -            tcg_opt_gen_movi(s, &temps_used, op, op->args[0], op->args[1=
]);
> -            break;
>=20=20
>          case INDEX_op_dup_vec:
>              if (arg_is_const(op->args[1])) {
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index ee1f9227c1..fb390ad978 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -2967,8 +2967,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc=
, const TCGArg *args,
>=20=20
>      case INDEX_op_mov_i32:   /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32:  /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> @@ -3310,7 +3308,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode=
 opc,
>          return;
>=20=20
>      case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
> -    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
>      case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
>      default:
>          g_assert_not_reached();
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index 2bc0ba71f2..ec609272ad 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -1606,8 +1606,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>=20=20
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          g_assert_not_reached();
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index b07e9ff7d6..f6b003a700 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -2310,8 +2310,6 @@ static inline void tcg_out_op(TCGContext *s, TCGOpc=
ode opc,
>=20=20
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index 65fddb310d..0808b79eee 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -1591,8 +1591,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>=20=20
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index 655b3ae32d..6343046e18 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -83,7 +83,6 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
>          case INDEX_op_xor_vec:
>          case INDEX_op_mov_vec:
>          case INDEX_op_dup_vec:
> -        case INDEX_op_dupi_vec:
>          case INDEX_op_dup2_vec:
>          case INDEX_op_ld_vec:
>          case INDEX_op_st_vec:
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 59beb2bf29..adb71f16ae 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1463,7 +1463,6 @@ bool tcg_op_supported(TCGOpcode op)
>          return TCG_TARGET_HAS_goto_ptr;
>=20=20
>      case INDEX_op_mov_i32:
> -    case INDEX_op_movi_i32:
>      case INDEX_op_setcond_i32:
>      case INDEX_op_brcond_i32:
>      case INDEX_op_ld8u_i32:
> @@ -1557,7 +1556,6 @@ bool tcg_op_supported(TCGOpcode op)
>          return TCG_TARGET_REG_BITS =3D=3D 32;
>=20=20
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i64:
>      case INDEX_op_setcond_i64:
>      case INDEX_op_brcond_i64:
>      case INDEX_op_ld8u_i64:
> @@ -1663,7 +1661,6 @@ bool tcg_op_supported(TCGOpcode op)
>=20=20
>      case INDEX_op_mov_vec:
>      case INDEX_op_dup_vec:
> -    case INDEX_op_dupi_vec:
>      case INDEX_op_dupm_vec:
>      case INDEX_op_ld_vec:
>      case INDEX_op_st_vec:
> @@ -3447,7 +3444,7 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCG=
RegSet allocated_regs)
>  }
>=20=20
>  /*
> - * Specialized code generation for INDEX_op_movi_*.
> + * Specialized code generation for INDEX_op_mov_* with a constant.
>   */
>  static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
>                                    tcg_target_ulong val, TCGLifeData arg_=
life,
> @@ -3470,14 +3467,6 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, T=
CGTemp *ots,
>      }
>  }
>=20=20
> -static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
> -{
> -    TCGTemp *ots =3D arg_temp(op->args[0]);
> -    tcg_target_ulong val =3D op->args[1];
> -
> -    tcg_reg_alloc_do_movi(s, ots, val, op->life, op->output_pref[0]);
> -}
> -
>  /*
>   * Specialized code generation for INDEX_op_mov_*.
>   */
> @@ -4263,11 +4252,6 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *=
tb)
>          case INDEX_op_mov_vec:
>              tcg_reg_alloc_mov(s, op);
>              break;
> -        case INDEX_op_movi_i32:
> -        case INDEX_op_movi_i64:
> -        case INDEX_op_dupi_vec:
> -            tcg_reg_alloc_movi(s, op);
> -            break;
>          case INDEX_op_dup_vec:
>              tcg_reg_alloc_dup(s, op);
>              break;
> diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
> index 1f1639df0d..b796f4fc19 100644
> --- a/tcg/tci/tcg-target.inc.c
> +++ b/tcg/tci/tcg-target.inc.c
> @@ -815,8 +815,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, =
const TCGArg *args,
>          break;
>      case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
>      case INDEX_op_mov_i64:
> -    case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
> -    case INDEX_op_movi_i64:
>      case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
>      default:
>          tcg_abort();


--=20
Alex Benn=C3=A9e

