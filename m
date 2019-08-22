Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC97C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2005D2145D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9T1Pu3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2005D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0eOT-0007dV-Bc
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 00:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0eNi-0006rq-8i
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0eNg-0000pQ-DB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:07:26 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0eNg-0000oi-62
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:07:24 -0400
Received: by mail-oi1-x241.google.com with SMTP id a127so3367100oii.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 21:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=C33cyYISANK3igbfcO0HawXvy1gBx6QQasmt3jyewqM=;
 b=Q9T1Pu3NkpuN2eGkdiuSxG85dCcKhBYXnTxP4/tw3e7X747aC3qENULGcq2WY6NBth
 TVyfkPGFDUiukrIlNYJLx1z61VrEmeeMdPwRPPFU0PHtrds1d3SWYJuL+cufZqrXbwpv
 tFnKWjmDlHKl/3X0joDUz5XN9mN4GbpjkBQN3+pddl9EHv3JFXB+QuqIoPuWN8/tx2d8
 lL4gNLNl2fIApdCpOnNtcy3Shota3OvVfGAbMU6crOx8/oN0g6SPQNkbrRoFTgets8Tq
 s9nz02d6cD8BwIYUghu9gl6YnXnY25KsRGGzQQvD8s8xzqfMjQ6huY897579lIgcRXnL
 0bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=C33cyYISANK3igbfcO0HawXvy1gBx6QQasmt3jyewqM=;
 b=C5LNvqMOk7oOOxRhgTM+9WwNv+Px7vS79D9Gapqmgb3C6sdf0nIBydyiGl2VIIYLR0
 1WDflv9+28wxX+bO90lPaBtj5QeOpDZYcQXapfkP+LkXUXx2HquzcjhWHX8SjT+7Y9E7
 KVx2Wy0npvA/3Y+v6jhvahXI5OtDSSPXgI4NDuLxeV3IGYcnUaCNo6lBweZ403sL/DTl
 oZ+WEX722xUQ1L+uqNEDfH+EcCFKKmR5xheY+2PWSvkf1s323XU47RJiwR8x/rvAdLuC
 ELQ/Ozzk9F+0p+ay6/O9uGU0gI2on6syAOjnnRR1Fylo7vXQw32Ody/dB7rW6LdXBHTU
 aceA==
X-Gm-Message-State: APjAAAW27hfMSPSAKUQxdRnixiuJTpLgCWMhH7qwSf+B9zwms3ToEj4V
 PjrshDfc4n2opPfaSelwiuL+clyUtQHSOM1TkEc=
X-Google-Smtp-Source: APXvYqzo9FwdR9mamV4PpJg6QzuDs/y8/Sc3H8uG51sxLLo3bi9USTI9BJUi5VMiYAuoeB5zyZsJjrcpznWsiniPXIY=
X-Received: by 2002:aca:fd92:: with SMTP id b140mr2208353oii.79.1566446843251; 
 Wed, 21 Aug 2019 21:07:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 21:07:22
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 21:07:22
 -0700 (PDT)
In-Reply-To: <20190821172951.15333-3-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
 <20190821172951.15333-3-jan.bobek@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 22 Aug 2019 06:07:22 +0200
Message-ID: <CAL1e-=gNF_6AbzVWw0T=vgKGNva1ebpAY1eJxjNSFLGxoTxSJQ@mail.gmail.com>
To: Jan Bobek <jan.bobek@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v4 02/75] target/i386: Push rex_w into
 DisasContext
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.08.2019. 19.41, "Jan Bobek" <jan.bobek@gmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Richard Henderson <rth@twiddle.net>
>
> Treat this the same as we already do for other rex bits.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---

I keep my previous opinion that this is an example of a low-quality commit
message that needlessly introduces unclarity.

Thanks,
Aleksandar

>  target/i386/translate.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 3aac84e5b0..9ec1c79371 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -44,11 +44,13 @@
>  #define REX_X(s) ((s)->rex_x)
>  #define REX_B(s) ((s)->rex_b)
>  #define REX_R(s) ((s)->rex_r)
> +#define REX_W(s) ((s)->rex_w)
>  #else
>  #define CODE64(s) 0
>  #define REX_X(s) 0
>  #define REX_B(s) 0
>  #define REX_R(s) 0
> +#define REX_W(s) -1
>  #endif
>
>  #ifdef TARGET_X86_64
> @@ -100,7 +102,7 @@ typedef struct DisasContext {
>  #ifdef TARGET_X86_64
>      int lma;    /* long mode active */
>      int code64; /* 64 bit code segment */
> -    int rex_x, rex_b, rex_r;
> +    int rex_x, rex_b, rex_r, rex_w;
>  #endif
>      int vex_l;  /* vex vector length */
>      int vex_v;  /* vex vvvv register, without 1's complement.  */
> @@ -4495,7 +4497,6 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      int modrm, reg, rm, mod, op, opreg, val;
>      target_ulong next_eip, tval;
>      target_ulong pc_start =3D s->base.pc_next;
> -    int rex_w;
>
>      s->pc_start =3D s->pc =3D pc_start;
>      s->override =3D -1;
> @@ -4503,6 +4504,7 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      s->rex_x =3D 0;
>      s->rex_b =3D 0;
>      s->rex_r =3D 0;
> +    s->rex_w =3D -1;
>      s->x86_64_hregs =3D false;
>  #endif
>      s->rip_offset =3D 0; /* for relative ip address */
> @@ -4514,7 +4516,6 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      }
>
>      prefixes =3D 0;
> -    rex_w =3D -1;
>
>   next_byte:
>      b =3D x86_ldub_code(env, s);
> @@ -4557,7 +4558,7 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      case 0x40 ... 0x4f:
>          if (CODE64(s)) {
>              /* REX prefix */
> -            rex_w =3D (b >> 3) & 1;
> +            s->rex_w =3D (b >> 3) & 1;
>              s->rex_r =3D (b & 0x4) << 1;
>              s->rex_x =3D (b & 0x2) << 2;
>              s->rex_b =3D (b & 0x1) << 3;
> @@ -4606,7 +4607,9 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>                  s->rex_b =3D (~vex2 >> 2) & 8;
>  #endif
>                  vex3 =3D x86_ldub_code(env, s);
> -                rex_w =3D (vex3 >> 7) & 1;
> +#ifdef TARGET_X86_64
> +                s->rex_w =3D (vex3 >> 7) & 1;
> +#endif
>                  switch (vex2 & 0x1f) {
>                  case 0x01: /* Implied 0f leading opcode bytes.  */
>                      b =3D x86_ldub_code(env, s) | 0x100;
> @@ -4631,9 +4634,9 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>      /* Post-process prefixes.  */
>      if (CODE64(s)) {
>          /* In 64-bit mode, the default data size is 32-bit.  Select
64-bit
> -           data with rex_w, and 16-bit data with 0x66; rex_w takes
precedence
> +           data with REX_W, and 16-bit data with 0x66; REX_W takes
precedence
>             over 0x66 if both are present.  */
> -        dflag =3D (rex_w > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_16 :
MO_32);
> +        dflag =3D (REX_W(s) > 0 ? MO_64 : prefixes & PREFIX_DATA ? MO_16=
 :
MO_32);
>          /* In 64-bit mode, 0x67 selects 32-bit addressing.  */
>          aflag =3D (prefixes & PREFIX_ADR ? MO_32 : MO_64);
>      } else {
> @@ -5029,7 +5032,7 @@ static target_ulong disas_insn(DisasContext *s,
CPUState *cpu)
>                  /* operand size for jumps is 64 bit */
>                  ot =3D MO_64;
>              } else if (op =3D=3D 3 || op =3D=3D 5) {
> -                ot =3D dflag !=3D MO_16 ? MO_32 + (rex_w =3D=3D 1) : MO_=
16;
> +                ot =3D dflag !=3D MO_16 ? MO_32 + (REX_W(s) =3D=3D 1) : =
MO_16;
>              } else if (op =3D=3D 6) {
>                  /* default push size is 64 bit */
>                  ot =3D mo_pushpop(s, dflag);
> --
> 2.20.1
>
>
