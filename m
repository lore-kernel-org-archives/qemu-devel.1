Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DECC35250
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1908217BA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikBu6CjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1908217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06bF-0001TS-OH
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j06aA-0008Fq-5Q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j06a4-00061X-MT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:34:18 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j06a4-0005zh-Cx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:34:12 -0500
Received: by mail-lf1-x142.google.com with SMTP id 203so1904517lfa.12
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UTMAv6rzdbL/Zo/Vu84sRuIP+QwRS1wmkIfbvmMS5mk=;
 b=ikBu6CjMl6UHMgytb/IwD31sOfq6VGwJow2chcXTKb/110Y5Hf3R3LBcPISGn6vmpV
 +hN1d3zxiK+U9ZzRv3FnRTq57tuxOtsRv/KvoQFc5nMgjyWBo1NX8OUzuhHiZCqSBOZm
 jwPHsZ1VMEiufB4JFMCVLpUjR31O4kClgI3HXvN9IeFBNdbmwKScwS+ISWyRQXuvGvyE
 uvzEM4JwDaSQZuVmd+rTRy7pSFRbLwsXf2/VCrc9x86QNI5wnuxwFoTzwpI0H3d/Dv9T
 4LDg5da8L5AnBjEcz3S1dOSEFNOOgVfBJa6AFIarWNRJo7emcDaqkvb2U+dIVYFnQ6j/
 EEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UTMAv6rzdbL/Zo/Vu84sRuIP+QwRS1wmkIfbvmMS5mk=;
 b=YdFdEhmNEoG3Ic4mUKVNCSSzH9njtnpFMJazScQT8SvXykaquapCWUV8SOgRZorlve
 ZzLTKbi9FJ3X3/GmKtPQaaNbCPQsca96/FBCWvE8MZcm8maJ/Pk/PKlN+csCAMrF+vSm
 LFN7qGTYt/CogFqmDJtT2t3/dxicSNjvJqhw4FzCBW55HCGIeeqqcFXorJsqz6VqIB9g
 Dy5goS3sA8uzT0luIdk+UrlglQCOQhBAxXTUtXxXOd1SGMD7yeWVcIFjVLoN1MTbMmwB
 SBHo0K1zPjjJXaMHyQ5Qb/z3XolCHOOEtMHWFwiiacRWBQ6xJW4dt3I8vTwV5Sf5Hg7Z
 QGgA==
X-Gm-Message-State: APjAAAXI3cNUYBQIu4UsX79OzcffEFQO39siYJ0VL8esMic6XIqfJvfx
 i6a5Z3Ru8/9hy07280vPPb6ybozgEkiyZLd24NRPwA==
X-Google-Smtp-Source: APXvYqwLqn35kITPXh8/Ln+qXZaWC5KJKa+p7VWWFCUl1JhowP5FJFKwJWzksmgdoxXlemw9ODDAWfdJTICII5gHWLc=
X-Received: by 2002:a19:6445:: with SMTP id b5mr4848227lfj.187.1581093250498; 
 Fri, 07 Feb 2020 08:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20200207150118.23007-1-alex.bennee@linaro.org>
 <20200207150118.23007-5-alex.bennee@linaro.org>
In-Reply-To: <20200207150118.23007-5-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 7 Feb 2020 11:33:34 -0500
Message-ID: <CAEyhzFuaDk6CCO72UD0vE9j+Eo=StnoEpWEg5iqOubGhdzXxag@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] target/riscv: progressively load the instruction
 during decode
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 Palmer Dabbelt <palmer@dabbelt.com>, kuhn.chenqun@huawei.com,
 Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
On Fri, 7 Feb 2020 at 10:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> -static void decode_RV32_64C0(DisasContext *ctx)
> +static void decode_RV32_64C0(DisasContext *ctx, uint16_t opcode)
>  {
> -    uint8_t funct3 =3D extract32(ctx->opcode, 13, 3);
> -    uint8_t rd_rs2 =3D GET_C_RS2S(ctx->opcode);
> -    uint8_t rs1s =3D GET_C_RS1S(ctx->opcode);
> +    uint8_t funct3 =3D extract32(opcode, 13, 3);

We noticed that a uint16_t opcode is passed into this function and
then passed on to extract32().
This is a minor point, but the extract32() will validate the start and
length values passed in according to 32 bits, not 16 bits.
static inline uint32_t extract32(uint32_t value, int start, int length)
{
    assert(start >=3D 0 && length > 0 && length <=3D 32 - start);
Since we have an extract32() and extract64(), maybe we could add an
extract16() and use it here?

Thanks & Regards,
-Rob
> +    uint8_t rd_rs2 =3D GET_C_RS2S(opcode);
> +    uint8_t rs1s =3D GET_C_RS1S(opcode);
>
>      switch (funct3) {
>      case 3:
>  #if defined(TARGET_RISCV64)
>          /* C.LD(RV64/128) -> ld rd', offset[7:3](rs1')*/
>          gen_load_c(ctx, OPC_RISC_LD, rd_rs2, rs1s,
> -                 GET_C_LD_IMM(ctx->opcode));
> +                 GET_C_LD_IMM(opcode));
>  #else
>          /* C.FLW (RV32) -> flw rd', offset[6:2](rs1')*/
>          gen_fp_load(ctx, OPC_RISC_FLW, rd_rs2, rs1s,
> -                    GET_C_LW_IMM(ctx->opcode));
> +                    GET_C_LW_IMM(opcode));
>  #endif
>          break;
>      case 7:
>  #if defined(TARGET_RISCV64)
>          /* C.SD (RV64/128) -> sd rs2', offset[7:3](rs1')*/
>          gen_store_c(ctx, OPC_RISC_SD, rs1s, rd_rs2,
> -                  GET_C_LD_IMM(ctx->opcode));
> +                  GET_C_LD_IMM(opcode));
>  #else
>          /* C.FSW (RV32) -> fsw rs2', offset[6:2](rs1')*/
>          gen_fp_store(ctx, OPC_RISC_FSW, rs1s, rd_rs2,
> -                     GET_C_LW_IMM(ctx->opcode));
> +                     GET_C_LW_IMM(opcode));
>  #endif
>          break;
>      }
>  }
>
> -static void decode_RV32_64C(DisasContext *ctx)
> +static void decode_RV32_64C(DisasContext *ctx, uint16_t opcode)
>  {
> -    uint8_t op =3D extract32(ctx->opcode, 0, 2);
> +    uint8_t op =3D extract32(opcode, 0, 2);
>
>      switch (op) {
>      case 0:
> -        decode_RV32_64C0(ctx);
> +        decode_RV32_64C0(ctx, opcode);
>          break;
>      }
>  }
> @@ -709,22 +708,24 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode_insn16.inc.c"
>
> -static void decode_opc(DisasContext *ctx)
> +static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t o=
pcode)
>  {
>      /* check for compressed insn */
> -    if (extract32(ctx->opcode, 0, 2) !=3D 3) {
> +    if (extract32(opcode, 0, 2) !=3D 3) {
>          if (!has_ext(ctx, RVC)) {
>              gen_exception_illegal(ctx);
>          } else {
>              ctx->pc_succ_insn =3D ctx->base.pc_next + 2;
> -            if (!decode_insn16(ctx, ctx->opcode)) {
> +            if (!decode_insn16(ctx, opcode)) {
>                  /* fall back to old decoder */
> -                decode_RV32_64C(ctx);
> +                decode_RV32_64C(ctx, opcode);
>              }
>          }
>      } else {
> +        uint32_t opcode32 =3D opcode;
> +        opcode32 =3D deposit32(opcode32, 16, 16, translator_lduw(env, ct=
x->base.pc_next + 2));
>          ctx->pc_succ_insn =3D ctx->base.pc_next + 4;
> -        if (!decode_insn32(ctx, ctx->opcode)) {
> +        if (!decode_insn32(ctx, opcode32)) {
>              gen_exception_illegal(ctx);
>          }
>      }
> @@ -776,9 +777,9 @@ static void riscv_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cpu)
>  {
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
>      CPURISCVState *env =3D cpu->env_ptr;
> +    uint16_t opcode16 =3D translator_lduw(env, ctx->base.pc_next);
>
> -    ctx->opcode =3D translator_ldl(env, ctx->base.pc_next);
> -    decode_opc(ctx);
> +    decode_opc(env, ctx, opcode16);
>      ctx->base.pc_next =3D ctx->pc_succ_insn;
>
>      if (ctx->base.is_jmp =3D=3D DISAS_NEXT) {
> --
> 2.20.1
>

