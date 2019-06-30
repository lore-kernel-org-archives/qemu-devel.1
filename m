Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE2EC5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 09:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17F7204EC
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 09:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zres0i4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17F7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhWSL-00048Z-Re
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 05:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41517)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhWQB-0003gc-E1
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 05:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhWQ8-0003Rd-Pm
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 05:46:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hhWQ8-0003Q5-3W
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 05:46:52 -0400
Received: by mail-ot1-x344.google.com with SMTP id n5so10486072otk.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=KQchPVb7jLG9nbB9noEuqyIUv+Jwb8X2cxfSWUMfmQM=;
 b=Zres0i4CngpsRv0njX/8RC6P6imaRE1D139hBd9TiJyqmV9+opH6EFTxPMy9fbLkiL
 Qb7f9dqJpMiDf0CeRzI1Impr5lC5gXDRQfYwPZT0eFX3Ip9YeFAXRn/bXBVJ4EPUDJ6Z
 ex/TB1diFUxfyrCnIAr4YaYQv8UbNJAu5QkSKMskBAVPJbL66FH09jkd500sRWMMJA4y
 a8G0MvLuUsSywurmUFNd+KqRyb8daTwl/3JjVdI71SqJAZ4BkaA9/8lZmnvdrdjwtWFW
 Ji8klzcAG/ZTSThKA3zIO7ff8ciyMVFGamzfQoSXEPestQk6dyFEwKsKu+qzReQGLnb4
 e2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=KQchPVb7jLG9nbB9noEuqyIUv+Jwb8X2cxfSWUMfmQM=;
 b=Ku98OfGz4vTBvsp5cQXi9Fwo+G9+bXLtCIZt48XJ6X22erRxKWglTYm1C8jIZyfOCU
 qfSyMa5P8QpU4rGjvyRCoEOPOoRbKuXM1GrlUn3s4UJ8U/QgB/QIjmXoVaV8B5/Rdf9y
 hw/V8U97aV/zJdpdB61UtD8+3ijkxjU1uTOzcFstyGqtz85W6yM10sFAHtIBne7V6Q73
 rNfzZelO3ZqzAF8n+lBs7rhMlgW7UbGuJ3FCT/nMzOCayDcRAYoZelikCl4iNuqDKYAf
 qwJGzEod3s1dXjMAG48eNh3JF8SH+vlNfRQeJ5dB5Io5T6HVPnUzvt9qCjhBCwaVlT2r
 EyAg==
X-Gm-Message-State: APjAAAUpjO4qIIzvk7BuVXHXnLzjtHZrL+rtD9KC0jfCXG2+dXirWlZ7
 Zst7eReZ22gAHR8PH5ZdjIF4MgEySG+NAjL+zGw=
X-Google-Smtp-Source: APXvYqxr/65yI7dwet0XLipKQtWTXrKgyJjW8suWoY/qw0tdzk7mIk4Ms7BE9zfSzOICq8/01Wnh8PIMlZHKRcO6uhs=
X-Received: by 2002:a05:6830:11d4:: with SMTP id
 v20mr14604788otq.121.1561888011149; 
 Sun, 30 Jun 2019 02:46:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 02:46:50
 -0700 (PDT)
In-Reply-To: <20190629130017.2973-5-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-5-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 30 Jun 2019 11:46:50 +0200
Message-ID: <CAL1e-=i266juep8-7N1=At680eY3AE-_vyNL_5GO=VRAnH_tig@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 04/16] tcg/ppc: Enable tcg backend
 vector compilation
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
Cc: "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "hsp.cat7@gmail.com" <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Saturday, June 29, 2019, Richard Henderson <richard.henderson@linaro.org=
>
wrote:

> Introduce all of the flags required to enable tcg backend vector support,
> and a runtime flag to indicate the host supports Altivec instructions.
>
>
If two flags have different purpose and usage, it is better that they
have different
names. (perhaps one of them should have the suffix =E2=80=9C_runtime=E2=80=
=9C)

Also, I am not sure if Altiveec can be reffered as isa, it is a
part/extension of an isa, so =E2=80=9Cisa=E2=80=9D seems  superfluous here.

checkpatch warning should also be honored.


> For now, do not actually set have_isa_altivec to true, because we have no=
t
> yet added all of the code to actually generate all of the required insns.
> However, we must define these flags in order to disable ifndefs that crea=
te
> stub versions of the functions added here.
>
> The change to tcg_out_movi works around a buglet in tcg.c wherein if we
> do not define tcg_out_dupi_vec we get a declared but not defined Werror,
> but if we only declare it we get a defined but not used Werror.  We need
> to this change to tcg_out_movi eventually anyway, so it's no biggie.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  tcg/ppc/tcg-target.h     | 25 ++++++++++++++++
>  tcg/ppc/tcg-target.opc.h |  5 ++++
>  tcg/ppc/tcg-target.inc.c | 65 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 92 insertions(+), 3 deletions(-)
>  create mode 100644 tcg/ppc/tcg-target.opc.h
>
> diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
> index 690fa744e1..f6283f468b 100644
> --- a/tcg/ppc/tcg-target.h
> +++ b/tcg/ppc/tcg-target.h
> @@ -58,6 +58,7 @@ typedef enum {
>      TCG_AREG0 =3D TCG_REG_R27
>  } TCGReg;
>
> +extern bool have_isa_altivec;
>  extern bool have_isa_2_06;
>  extern bool have_isa_3_00;
>
> @@ -135,6 +136,30 @@ extern bool have_isa_3_00;
>  #define TCG_TARGET_HAS_mulsh_i64        1
>  #endif
>
> +/*
> + * While technically Altivec could support V64, it has no 64-bit store
> + * instruction and substituting two 32-bit stores makes the generated
> + * code quite large.
> + */
> +#define TCG_TARGET_HAS_v64              0
> +#define TCG_TARGET_HAS_v128             have_isa_altivec
> +#define TCG_TARGET_HAS_v256             0
> +
> +#define TCG_TARGET_HAS_andc_vec         0
> +#define TCG_TARGET_HAS_orc_vec          0
> +#define TCG_TARGET_HAS_not_vec          0
> +#define TCG_TARGET_HAS_neg_vec          0
> +#define TCG_TARGET_HAS_abs_vec          0
> +#define TCG_TARGET_HAS_shi_vec          0
> +#define TCG_TARGET_HAS_shs_vec          0
> +#define TCG_TARGET_HAS_shv_vec          0
> +#define TCG_TARGET_HAS_cmp_vec          0
> +#define TCG_TARGET_HAS_mul_vec          0
> +#define TCG_TARGET_HAS_sat_vec          0
> +#define TCG_TARGET_HAS_minmax_vec       0
> +#define TCG_TARGET_HAS_bitsel_vec       0
> +#define TCG_TARGET_HAS_cmpsel_vec       0
> +
>  void flush_icache_range(uintptr_t start, uintptr_t stop);
>  void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
>
> diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target.opc.h
> new file mode 100644
> index 0000000000..fa680dd6a0
> --- /dev/null
> +++ b/tcg/ppc/tcg-target.opc.h
> @@ -0,0 +1,5 @@
> +/*
> + * Target-specific opcodes for host vector expansion.  These will be
> + * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
> + * consider these to be UNSPEC with names.
> + */
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index cfbd7ff12c..b938e9aac5 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -64,6 +64,7 @@
>
>  static tcg_insn_unit *tb_ret_addr;
>
> +bool have_isa_altivec;
>  bool have_isa_2_06;
>  bool have_isa_3_00;
>
> @@ -717,10 +718,31 @@ static void tcg_out_movi_int(TCGContext *s, TCGType
> type, TCGReg ret,
>      }
>  }
>
> -static inline void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
> -                                tcg_target_long arg)
> +static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
> +                             tcg_target_long val)
>  {
> -    tcg_out_movi_int(s, type, ret, arg, false);
> +    g_assert_not_reached();
> +}
> +
> +static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg ret,
> +                         tcg_target_long arg)
> +{
> +    switch (type) {
> +    case TCG_TYPE_I32:
> +    case TCG_TYPE_I64:
> +        tcg_debug_assert(ret < TCG_REG_V0);
> +        tcg_out_movi_int(s, type, ret, arg, false);
> +        break;
> +
> +    case TCG_TYPE_V64:
> +    case TCG_TYPE_V128:
> +        tcg_debug_assert(ret >=3D TCG_REG_V0);
> +        tcg_out_dupi_vec(s, type, ret, arg);
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
>  }
>
>  static bool mask_operand(uint32_t c, int *mb, int *me)
> @@ -2605,6 +2627,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode
> opc, const TCGArg *args,
>      }
>  }
>
> +int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
> +                            TCGReg dst, TCGReg src)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
> +                             TCGReg out, TCGReg base, intptr_t offset)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
> +                           unsigned vecl, unsigned vece,
> +                           const TCGArg *args, const int *const_args)
> +{
> +    g_assert_not_reached();
> +}
> +
> +void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
> +                       TCGArg a0, ...)
> +{
> +    g_assert_not_reached();
> +}
> +
>  static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>  {
>      static const TCGTargetOpDef r =3D { .args_ct_str =3D { "r" } };
> @@ -2787,6 +2839,9 @@ static void tcg_target_init(TCGContext *s)
>      unsigned long hwcap =3D qemu_getauxval(AT_HWCAP);
>      unsigned long hwcap2 =3D qemu_getauxval(AT_HWCAP2);
>
> +    if (hwcap & /* PPC_FEATURE_HAS_ALTIVEC -- NOT YET */ 0) {
> +        have_isa_altivec =3D true;
> +    }
>      if (hwcap & PPC_FEATURE_ARCH_2_06) {
>          have_isa_2_06 =3D true;
>      }
> @@ -2798,6 +2853,10 @@ static void tcg_target_init(TCGContext *s)
>
>      tcg_target_available_regs[TCG_TYPE_I32] =3D 0xffffffff;
>      tcg_target_available_regs[TCG_TYPE_I64] =3D 0xffffffff;
> +    if (have_isa_altivec) {
> +        tcg_target_available_regs[TCG_TYPE_V64] =3D 0xffffffff00000000ul=
l;
> +        tcg_target_available_regs[TCG_TYPE_V128] =3D 0xffffffff00000000u=
ll;
> +    }
>
>      tcg_target_call_clobber_regs =3D 0;
>      tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R0);
> --
> 2.17.1
>
>
>
