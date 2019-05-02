Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B089C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 20:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3427A2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 20:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgH/m51K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3427A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58359 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMIYQ-0000LR-7Y
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 16:43:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMIXZ-0008Pl-I5
	for qemu-devel@nongnu.org; Thu, 02 May 2019 16:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMIXV-0005b0-HA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 16:42:49 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hMIXT-0005Xl-Iq; Thu, 02 May 2019 16:42:45 -0400
Received: by mail-lj1-x242.google.com with SMTP id f23so3487275ljc.0;
	Thu, 02 May 2019 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=BRd30Yiz1Odef2cbFvWAJUuLlEYfE4w1j/sm4FJf1dY=;
	b=cgH/m51KOqoAj1ohdYS68pR+3vTnlGe7CPLLbMek4rMXYx6+Z2FAsXNsjEJpsO9QGG
	yjws980b0NQPo6FdjTxym3nar9DcjX5QzVpnnMIXKzTQGXEPnllKsF8tJttuzPgKe6DY
	jySazu/7H++2pOfSh9dfoi4vBHt4cacTWCdIeMiWhTVjPe5rXKhdZXhHEJk6dhdnjP7/
	GvR/qP3xv7oFVulxQU+4bzOwpoqHU2BB/qpkMm65mDEeS+UU5QBR65lSazyD6SDbaSqO
	Rt2LbzEbTnQ/o7RdYCBjqif4iFQKLh7Xa+KnombzLIExag/0cVivuoweWJxCrtgPreKI
	trMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=BRd30Yiz1Odef2cbFvWAJUuLlEYfE4w1j/sm4FJf1dY=;
	b=bd7mzlOA9GJCxm5TQXGdUPyDWA/pSsiBgfueYPNpIW93sB7Wp/mhlt0GF4uy4+8TyM
	W7GA21fc9kumu9sGEKDD8ZhDkAxocESYOmUjc6Q7kZl6vs01YIr1sCSWrq2STv0dglct
	Ysnnvg09E5kKwJYLpkk0us8NO3NSmXJnCtCEA/XVdx8d/NSYf+79Ref0+4v1d1GfoADa
	hJzhh7R9lGG/0TgvQZKABOJUPoOMRtEiytohWkb18r9Xewnrcl3IGZAprimm2uOW2zEt
	Z2p5KuELD/dUoQVsaUGzWh0XM5jNNnu7wZMgnwEgCKcB/UD0VK+JzkfPKB84EQAAYDhv
	FPEw==
X-Gm-Message-State: APjAAAWEJd0QORrxp4/M69LKhv0auRLEAnHYG/d1GuGTsRTPAgN0PzEn
	qjfM6/bZsjjXy4mWuN4nU34WvcoZTWhTvXC5cTk=
X-Google-Smtp-Source: APXvYqx3a8g3Mv09+54WVTnxrg/RNxxPVHLnkHsTMOvRNwVutbj8mBHLyisbWYhtQJ1ZarYMa8siu45+BtF82xHG/SA=
X-Received: by 2002:a2e:9118:: with SMTP id m24mr2973413ljg.89.1556829761322; 
	Thu, 02 May 2019 13:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190401031155.21293-7-richard.henderson@linaro.org>
	<mhng-4618def7-9294-4a34-bed4-1c8d94531e91@palmer-si-x1e>
In-Reply-To: <mhng-4618def7-9294-4a34-bed4-1c8d94531e91@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 May 2019 13:40:45 -0700
Message-ID:
 <CAKmqyKOXSiumA+FXfB_L3OEueAcDvvBp0VAEpd3L1hLs7pBQvA@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for-4.1 6/8] target/riscv: Split RVC32 and
 RVC64 insns into separate files
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502204045.wKAlfuEA3TWSHmyh_OVaEbYOmal3PDX1kKr8VdsBTRE@z>

On Thu, Apr 25, 2019 at 9:04 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Sun, 31 Mar 2019 20:11:53 PDT (-0700), richard.henderson@linaro.org wrote:
> > This eliminates all functions in insn_trans/trans_rvc.inc.c,
> > so the entire file can be removed.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

You need to remove the line in: target/riscv/translate.c:710
    #include "insn_trans/trans_rvc.inc.c"

otherwise this patch doesn't compile.

Alistair

> > ---
> >  target/riscv/insn_trans/trans_rvc.inc.c | 115 ------------------------
> >  target/riscv/translate.c                |   2 -
> >  target/riscv/Makefile.objs              |   9 +-
> >  target/riscv/insn16-32.decode           |  28 ++++++
> >  target/riscv/insn16-64.decode           |  30 +++++++
> >  target/riscv/insn16.decode              |  35 +-------
> >  6 files changed, 67 insertions(+), 152 deletions(-)
> >  delete mode 100644 target/riscv/insn_trans/trans_rvc.inc.c
> >  create mode 100644 target/riscv/insn16-32.decode
> >  create mode 100644 target/riscv/insn16-64.decode
> >
> > diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
> > deleted file mode 100644
> > index 43bff97f66..0000000000
> > --- a/target/riscv/insn_trans/trans_rvc.inc.c
> > +++ /dev/null
> > @@ -1,115 +0,0 @@
> > -/*
> > - * RISC-V translation routines for the RVC Compressed Instruction Set.
> > - *
> > - * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
> > - * Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
> > - *                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
> > - *
> > - * This program is free software; you can redistribute it and/or modify it
> > - * under the terms and conditions of the GNU General Public License,
> > - * version 2 or later, as published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope it will be useful, but WITHOUT
> > - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > - * more details.
> > - *
> > - * You should have received a copy of the GNU General Public License along with
> > - * this program.  If not, see <http://www.gnu.org/licenses/>.
> > - */
> > -
> > -static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
> > -{
> > -#ifdef TARGET_RISCV32
> > -    /* C.FLW ( RV32FC-only ) */
> > -    REQUIRE_FPU;
> > -    REQUIRE_EXT(ctx, RVF);
> > -
> > -    arg_i arg;
> > -    decode_insn16_extract_cl_w(&arg, ctx->opcode);
> > -    return trans_flw(ctx, &arg);
> > -#else
> > -    /* C.LD ( RV64C/RV128C-only ) */
> > -    arg_i arg;
> > -    decode_insn16_extract_cl_d(&arg, ctx->opcode);
> > -    return trans_ld(ctx, &arg);
> > -#endif
> > -}
> > -
> > -static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
> > -{
> > -#ifdef TARGET_RISCV32
> > -    /* C.FSW ( RV32FC-only ) */
> > -    REQUIRE_FPU;
> > -    REQUIRE_EXT(ctx, RVF);
> > -
> > -    arg_s arg;
> > -    decode_insn16_extract_cs_w(&arg, ctx->opcode);
> > -    return trans_fsw(ctx, &arg);
> > -#else
> > -    /* C.SD ( RV64C/RV128C-only ) */
> > -    arg_s arg;
> > -    decode_insn16_extract_cs_d(&arg, ctx->opcode);
> > -    return trans_sd(ctx, &arg);
> > -#endif
> > -}
> > -
> > -static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
> > -{
> > -#ifdef TARGET_RISCV32
> > -    /* C.JAL */
> > -    arg_j tmp;
> > -    decode_insn16_extract_cj(&tmp, ctx->opcode);
> > -    arg_jal arg = { .rd = 1, .imm = tmp.imm };
> > -    return trans_jal(ctx, &arg);
> > -#else
> > -    /* C.ADDIW */
> > -    arg_addiw arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
> > -    return trans_addiw(ctx, &arg);
> > -#endif
> > -}
> > -
> > -static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
> > -{
> > -#ifdef TARGET_RISCV64
> > -    return trans_subw(ctx, a);
> > -#else
> > -    return false;
> > -#endif
> > -}
> > -
> > -static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a)
> > -{
> > -#ifdef TARGET_RISCV64
> > -    return trans_addw(ctx, a);
> > -#else
> > -    return false;
> > -#endif
> > -}
> > -
> > -static bool trans_c_flwsp_ldsp(DisasContext *ctx, arg_c_flwsp_ldsp *a)
> > -{
> > -#ifdef TARGET_RISCV32
> > -    /* C.FLWSP */
> > -    arg_flw arg_flw = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_flwsp };
> > -    return trans_flw(ctx, &arg_flw);
> > -#else
> > -    /* C.LDSP */
> > -    arg_ld arg_ld = { .rd = a->rd, .rs1 = 2, .imm = a->uimm_ldsp };
> > -    return trans_ld(ctx, &arg_ld);
> > -#endif
> > -    return false;
> > -}
> > -
> > -static bool trans_c_fswsp_sdsp(DisasContext *ctx, arg_c_fswsp_sdsp *a)
> > -{
> > -#ifdef TARGET_RISCV32
> > -    /* C.FSWSP */
> > -    arg_fsw a_fsw = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm_fswsp };
> > -    return trans_fsw(ctx, &a_fsw);
> > -#else
> > -    /* C.SDSP */
> > -    arg_sd a_sd = { .rs1 = 2, .rs2 = a->rs2, .imm = a->uimm_sdsp };
> > -    return trans_sd(ctx, &a_sd);
> > -#endif
> > -}
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index a1cd29f80f..50d8f58e4b 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -685,8 +685,6 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
> >
> >  #pragma GCC diagnostic pop
> >
> > -#include "insn_trans/trans_rvc.inc.c"
> > -
> >  static void decode_opc(DisasContext *ctx)
> >  {
> >      /* check for compressed insn */
> > diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> > index c7a1b063ed..b1c79bc1d1 100644
> > --- a/target/riscv/Makefile.objs
> > +++ b/target/riscv/Makefile.objs
> > @@ -5,16 +5,19 @@ DECODETREE = $(SRC_PATH)/scripts/decodetree.py
> >  decode32-y = $(SRC_PATH)/target/riscv/insn32.decode
> >  decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn32-64.decode
> >
> > +decode16-y = $(SRC_PATH)/target/riscv/insn16.decode
> > +decode16-$(TARGET_RISCV32) += $(SRC_PATH)/target/riscv/insn16-32.decode
> > +decode16-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn16-64.decode
> > +
> >  target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
> >       $(call quiet-command, \
> >         $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
> >            $(decode32-y), "GEN", $(TARGET_DIR)$@)
> >
> > -target/riscv/decode_insn16.inc.c: \
> > -  $(SRC_PATH)/target/riscv/insn16.decode $(DECODETREE)
> > +target/riscv/decode_insn16.inc.c: $(decode16-y) $(DECODETREE)
> >       $(call quiet-command, \
> >         $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
> > -          --insnwidth 16 $<, "GEN", $(TARGET_DIR)$@)
> > +          --insnwidth 16 $(decode16-y), "GEN", $(TARGET_DIR)$@)
> >
> >  target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
> >       target/riscv/decode_insn16.inc.c
> > diff --git a/target/riscv/insn16-32.decode b/target/riscv/insn16-32.decode
> > new file mode 100644
> > index 0000000000..0819b17028
> > --- /dev/null
> > +++ b/target/riscv/insn16-32.decode
> > @@ -0,0 +1,28 @@
> > +#
> > +# RISC-V translation routines for the RVXI Base Integer Instruction Set.
> > +#
> > +# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
> > +#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
> > +#
> > +# This program is free software; you can redistribute it and/or modify it
> > +# under the terms and conditions of the GNU General Public License,
> > +# version 2 or later, as published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope it will be useful, but WITHOUT
> > +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > +# more details.
> > +#
> > +# You should have received a copy of the GNU General Public License along with
> > +# this program.  If not, see <http://www.gnu.org/licenses/>.
> > +
> > +# *** RV32C Standard Extension (Quadrant 0) ***
> > +flw               011  ... ... .. ... 00 @cl_w
> > +fsw               111  ... ... .. ... 00 @cs_w
> > +
> > +# *** RV32C Standard Extension (Quadrant 1) ***
> > +jal               001     ........... 01 @cj    rd=1  # C.JAL
> > +
> > +# *** RV32C Standard Extension (Quadrant 2) ***
> > +flw               011 .  .....  ..... 10 @c_lwsp
> > +fsw               111 .  .....  ..... 10 @c_swsp
> > diff --git a/target/riscv/insn16-64.decode b/target/riscv/insn16-64.decode
> > new file mode 100644
> > index 0000000000..055859d29f
> > --- /dev/null
> > +++ b/target/riscv/insn16-64.decode
> > @@ -0,0 +1,30 @@
> > +#
> > +# RISC-V translation routines for the RVXI Base Integer Instruction Set.
> > +#
> > +# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
> > +#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
> > +#
> > +# This program is free software; you can redistribute it and/or modify it
> > +# under the terms and conditions of the GNU General Public License,
> > +# version 2 or later, as published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope it will be useful, but WITHOUT
> > +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > +# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > +# more details.
> > +#
> > +# You should have received a copy of the GNU General Public License along with
> > +# this program.  If not, see <http://www.gnu.org/licenses/>.
> > +
> > +# *** RV64C Standard Extension (Quadrant 0) ***
> > +ld                011  ... ... .. ... 00 @cl_d
> > +sd                111  ... ... .. ... 00 @cs_d
> > +
> > +# *** RV64C Standard Extension (Quadrant 1) ***
> > +addiw             001 .  .....  ..... 01 @ci
> > +subw              100 1 11 ... 00 ... 01 @cs_2
> > +addw              100 1 11 ... 01 ... 01 @cs_2
> > +
> > +# *** RV64C Standard Extension (Quadrant 2) ***
> > +ld                011 .  .....  ..... 10 @c_ldsp
> > +sd                111 .  .....  ..... 10 @c_sdsp
> > diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> > index 3c79edf1c9..433c0e8c68 100644
> > --- a/target/riscv/insn16.decode
> > +++ b/target/riscv/insn16.decode
> > @@ -50,30 +50,12 @@
> >  &u         imm rd       !extern
> >  &shift     shamt rs1 rd !extern
> >
> > -# Argument sets:
> > -&cl               rs1 rd
> > -&cl_dw     uimm   rs1 rd
> > -&ciw       nzuimm     rd
> > -&cs               rs1 rs2
> > -&cs_dw     uimm   rs1 rs2
> > -&cb        imm    rs1
> > -&cr               rd  rs2
> > -&c_shift   shamt      rd
> > -
> > -&c_ld      uimm  rd
> > -&c_sd      uimm  rs2
> > -
> > -&caddi16sp_lui  imm_lui imm_addi16sp rd
> > -&cflwsp_ldsp    uimm_flwsp uimm_ldsp rd
> > -&cfswsp_sdsp    uimm_fswsp uimm_sdsp rs2
> >
> >  # Formats 16:
> >  @cr        ....  ..... .....  .. &r      rs2=%rs2_5       rs1=%rd     %rd
> >  @ci        ... . ..... .....  .. &i      imm=%imm_ci      rs1=%rd     %rd
> >  @cl_d      ... ... ... .. ... .. &i      imm=%uimm_cl_d   rs1=%rs1_3  rd=%rs2_3
> >  @cl_w      ... ... ... .. ... .. &i      imm=%uimm_cl_w   rs1=%rs1_3  rd=%rs2_3
> > -@cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
> > -@cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
> >  @cs_2      ... ... ... .. ... .. &r      rs2=%rs2_3       rs1=%rs1_3  rd=%rs1_3
> >  @cs_d      ... ... ... .. ... .. &s      imm=%uimm_cl_d   rs1=%rs1_3  rs2=%rs2_3
> >  @cs_w      ... ... ... .. ... .. &s      imm=%uimm_cl_w   rs1=%rs1_3  rs2=%rs2_3
> > @@ -91,10 +73,6 @@
> >
> >  @c_addi4spn     ... .  ..... ..... .. &i imm=%nzuimm_ciw rs1=2 rd=%rs2_3
> >  @c_addi16sp     ... .  ..... ..... .. &i imm=%imm_addi16sp rs1=2 rd=2
> > -@c_flwsp_ldsp   ... .  ..... ..... .. &cflwsp_ldsp uimm_flwsp=%uimm_6bit_lw \
> > -    uimm_ldsp=%uimm_6bit_ld %rd
> > -@c_fswsp_sdsp   ... .  ..... ..... .. &cfswsp_sdsp uimm_fswsp=%uimm_6bit_sw \
> > -    uimm_sdsp=%uimm_6bit_sd rs2=%rs2_5
> >
> >  @c_shift        ... . .. ... ..... .. \
> >                  &shift rd=%rs1_3 rs1=%rs1_3 shamt=%shimm_6bit
> > @@ -103,7 +81,7 @@
> >
> >  @c_andi         ... . .. ... ..... .. &i imm=%imm_ci rs1=%rs1_3 rd=%rs1_3
> >
> > -# *** RV64C Standard Extension (Quadrant 0) ***
> > +# *** RV32/64C Standard Extension (Quadrant 0) ***
> >  {
> >    # Opcode of all zeros is illegal; rd != 0, nzuimm == 0 is reserved.
> >    illegal         000  000 000 00 --- 00
> > @@ -111,14 +89,11 @@
> >  }
> >  fld               001  ... ... .. ... 00 @cl_d
> >  lw                010  ... ... .. ... 00 @cl_w
> > -c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
> >  fsd               101  ... ... .. ... 00 @cs_d
> >  sw                110  ... ... .. ... 00 @cs_w
> > -c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
> >
> > -# *** RV64C Standard Extension (Quadrant 1) ***
> > +# *** RV32/64C Standard Extension (Quadrant 1) ***
> >  addi              000 .  .....  ..... 01 @ci
> > -c_jal_addiw       001 .  .....  ..... 01 @ci #Note: parse rd and/or imm manually
> >  addi              010 .  .....  ..... 01 @c_li
> >  {
> >    addi            011 .  00010  ..... 01 @c_addi16sp
> > @@ -131,17 +106,14 @@ sub               100 0 11 ... 00 ... 01 @cs_2
> >  xor               100 0 11 ... 01 ... 01 @cs_2
> >  or                100 0 11 ... 10 ... 01 @cs_2
> >  and               100 0 11 ... 11 ... 01 @cs_2
> > -c_subw            100 1 11 ... 00 ... 01 @cs_2
> > -c_addw            100 1 11 ... 01 ... 01 @cs_2
> >  jal               101     ........... 01 @cj    rd=0  # C.J
> >  beq               110  ... ...  ..... 01 @cb_z
> >  bne               111  ... ...  ..... 01 @cb_z
> >
> > -# *** RV64C Standard Extension (Quadrant 2) ***
> > +# *** RV32/64C Standard Extension (Quadrant 2) ***
> >  slli              000 .  .....  ..... 10 @c_shift2
> >  fld               001 .  .....  ..... 10 @c_ldsp
> >  lw                010 .  .....  ..... 10 @c_lwsp
> > -c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
> >  {
> >    jalr            100 0  .....  00000 10 @c_jalr rd=0  # C.JR
> >    addi            100 0  .....  ..... 10 @c_mv
> > @@ -153,4 +125,3 @@ c_flwsp_ldsp      011 .  .....  ..... 10 @c_flwsp_ldsp #C.LDSP:RV64;C.FLWSP:RV32
> >  }
> >  fsd               101   ......  ..... 10 @c_sdsp
> >  sw                110 .  .....  ..... 10 @c_swsp
> > -c_fswsp_sdsp      111 .  .....  ..... 10 @c_fswsp_sdsp #C.SDSP:RV64;C.FSWSP:RV32
>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>

