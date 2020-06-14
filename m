Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87953C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4645B20714
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgcUYg1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4645B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkOEn-0001AN-Gz
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 04:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkOEC-0000hX-AQ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:42:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37504)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkOEA-00032D-7g
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:42:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id y20so11842788wmi.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zqP1AXG0VVOb1WbYskiDLfkoVHUMuZp2YS5bto0j4EE=;
 b=pgcUYg1MBVZN1Ma0TLRLIZaKbIKytfevY4pjr1wBRq6q9Qr4O3ULN7Hryb+cPNF3F2
 Oifq1Fh1SS/WTXIX8MO2SQlRnMZeF3PXVFP6ZLloxIvtt9JMNOWFCOIpfS9tZ4lxX55H
 uJRvb990jLRXRVzt3zvr9VGpdbAgIomE4wQUxIUh1HXUwXiwTAM7RE69nqH45ewEN0jg
 8ljEdXXozo3+OoGbFov9ox2YJnkDbsnGXoboxKvVstXudI94VDmnjhIpHZKyysTmL+rh
 mqeq1ZdUhw1DKUu2JvUXdeHZpXaW2zSCqBLFTpMbV9FWjX0h1WxM+95lHPvluoOHgmLn
 G/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zqP1AXG0VVOb1WbYskiDLfkoVHUMuZp2YS5bto0j4EE=;
 b=swIh0z+uUGrqBLFe/stO0ae5dL3BWp55YcytuMzW+wr8kd6uUCQ+r+gz0gpmpwsJQl
 E97RsYfkVLbfStacB9zUFujgXGH/LwvujmHTUPmowqV555JsBwUqWMo2AY70ramRMlSz
 tHDvvLrzvFy0YabCTXV4LzFJ6sVbuiWGXYsd5dqPjy2xuY64F5k1nPFnCuicFbQ1OpPM
 S0qjMvW74/ewJ/RZo4S0ApUZAnqb8M4Z5HpUPv4GmMgibTjAWZAjuZCpIRbo+qZFk1MP
 hx/Ty5mptjL2QdA1KOkdemJm5miD5mgLkNWjslxUBcPbQ6cxhDjwCej+9v8I6XVbHKum
 1o+w==
X-Gm-Message-State: AOAM53136xN0UstWkSsUryoGLQBRPXiQpZ8LeDC1NkC2sxKqKTsu/CFX
 ZmZZKPy1tcS9zLbAK/9fBxAq269bya4Oeff5No0=
X-Google-Smtp-Source: ABdhPJziwD4eWGvANE106pMEyAFPhru+DT3CA00dNuDz8n5EK2albDpE2SBo7ZqtMNHRhJlCeFmNPlNbLHqATnRGSTU=
X-Received: by 2002:a05:600c:22c1:: with SMTP id
 1mr7776567wmg.50.1592124166606; 
 Sun, 14 Jun 2020 01:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200614080049.31134-1-jiaxun.yang@flygoat.com>
 <20200614080049.31134-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20200614080049.31134-2-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 14 Jun 2020 10:42:33 +0200
Message-ID: <CAHiYmc4WMeHODfEKHeKsucqqB5a2vEcGdO4F=g-nsS+C0zsH1Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/mips: Legalize Loongson insn flags
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 14. =D1=98=D1=83=D0=BD 2020. =D1=83 10:03 Jiaxun Yang <=
jiaxun.yang@flygoat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
>
> To match the actual status of Loongson insn, we split flags
> for LMMI and LEXT from INSN_LOONGSON2F.
>
> As Loongson-2F only implemented interger part of LEXT, we'll
> not enable LEXT for the processor, but instead we're still using
> INSN_LOONGSON2F as switch flag of these instructions.
>
> All multimedia instructions have been moved to LMMI flag. Loongson-2F
> and Loongson-3A are sharing these instructions.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Applied to the next mips queue.

>  target/mips/mips-defs.h |  4 ++--
>  target/mips/translate.c | 13 +++++++------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index 0c129106c8..f1b833f947 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -70,7 +70,7 @@
>  #define CPU_VR54XX      (CPU_MIPS4 | INSN_VR54XX)
>  #define CPU_R5900       (CPU_MIPS3 | INSN_R5900)
>  #define CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
> -#define CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
> +#define CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F | ASE_LMMI)
>
>  #define CPU_MIPS5       (CPU_MIPS4 | ISA_MIPS5)
>
> @@ -97,7 +97,7 @@
>  /* Wave Computing: "nanoMIPS" */
>  #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
>
> -#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
> +#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A | ASE_LMMI | ASE=
_LEXT)
>
>  /*
>   * Strictly follow the architecture standard:
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 2caf4cba5a..e49f32f6ae 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1046,7 +1046,7 @@ enum {
>      OPC_BC2NEZ  =3D (0x0D << 21) | OPC_CP2,
>  };
>
> -#define MASK_LMI(op)    (MASK_OP_MAJOR(op) | (op & (0x1F << 21)) | (op &=
 0x1F))
> +#define MASK_LMMI(op)    (MASK_OP_MAJOR(op) | (op & (0x1F << 21)) | (op =
& 0x1F))
>
>  enum {
>      OPC_PADDSH      =3D (24 << 21) | (0x00) | OPC_CP2,
> @@ -3421,7 +3421,8 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
>      TCGv t0, t1, t2;
>      int mem_idx =3D ctx->mem_idx;
>
> -    if (rt =3D=3D 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSO=
N2F)) {
> +    if (rt =3D=3D 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSO=
N2F |
> +                                      INSN_LOONGSON3A)) {
>          /*
>           * Loongson CPU uses a load to zero register for prefetch.
>           * We emulate it as a NOP. On other CPU we must perform the
> @@ -5531,7 +5532,7 @@ static void gen_loongson_multimedia(DisasContext *c=
tx, int rd, int rs, int rt)
>      TCGv_i64 t0, t1;
>      TCGCond cond;
>
> -    opc =3D MASK_LMI(ctx->opcode);
> +    opc =3D MASK_LMMI(ctx->opcode);
>      switch (opc) {
>      case OPC_ADD_CP2:
>      case OPC_SUB_CP2:
> @@ -27161,7 +27162,7 @@ static void decode_opc_special2_legacy(CPUMIPSSta=
te *env, DisasContext *ctx)
>      case OPC_MULTU_G_2F:
>      case OPC_MOD_G_2F:
>      case OPC_MODU_G_2F:
> -        check_insn(ctx, INSN_LOONGSON2F);
> +        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
>          gen_loongson_integer(ctx, op1, rd, rs, rt);
>          break;
>      case OPC_CLO:
> @@ -27194,7 +27195,7 @@ static void decode_opc_special2_legacy(CPUMIPSSta=
te *env, DisasContext *ctx)
>      case OPC_DDIVU_G_2F:
>      case OPC_DMOD_G_2F:
>      case OPC_DMODU_G_2F:
> -        check_insn(ctx, INSN_LOONGSON2F);
> +        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
>          gen_loongson_integer(ctx, op1, rd, rs, rt);
>          break;
>  #endif
> @@ -30641,7 +30642,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
>          }
>          break;
>      case OPC_CP2:
> -        check_insn(ctx, INSN_LOONGSON2F);
> +        check_insn(ctx, ASE_LMMI);
>          /* Note that these instructions use different fields.  */
>          gen_loongson_multimedia(ctx, sa, rd, rt);
>          break;
> --
> 2.27.0

