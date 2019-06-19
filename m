Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9DDC43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35062080C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlJo1wew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35062080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdhLK-0004ng-El
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40359)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdhCw-0006bk-HW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdhCv-0005Mb-2J
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:29:26 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdhCu-0005Li-Tn; Wed, 19 Jun 2019 16:29:25 -0400
Received: by mail-io1-xd43.google.com with SMTP id s7so990128iob.11;
 Wed, 19 Jun 2019 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tJNIjE84BtegdMtCqC8OwSJECYQW8iiIXi7sWNQvQrc=;
 b=VlJo1wewOQVkAEiGoHLR6YW+8CG7VmxoRHApUeu5+6KfkgKlXVdkPsQk1IT1ryeRbZ
 ErMZVcdkgft/QtNvq1gAIHYshzOLs8ZFwP8sDSGK3tKdbhZgsfq+x9MjK84kPRyywJ8n
 8RzHWYWa+0sZFW5Vi9i5Jd2Fu9q8HMeU3hZIU0zyF05vgt7w+imsC0SluPvmCaVI0WyX
 Oy9dH0LeCrzVnLDLmW56QFSkyR/CYhpw/y8Q7Ihnwasz+MClsv8vyDcI/9KQ4m+t8sMK
 JJTZGd6gFG3vMGvKc5nSUdesdzsbRwoorp4w5JNWY8+A7SYYsnoBe/K8mhc04qWVpUeh
 oiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tJNIjE84BtegdMtCqC8OwSJECYQW8iiIXi7sWNQvQrc=;
 b=MWEjeUCgZZwF28MF9qwehMumuYd48WjcBxzDWZO0ks4CaX9Drcq8DEK8WmGgQq3EiP
 aMEiM7JmiTjFv1vqrZJmO+jQ5fmoLTJhCztNoF+3FC27EUIOTI/7l6888tz+3Nz+3YSD
 6+4PH1PDZZVEgjkswQAigiPMTypHRgJ0lNahghk5XTC2jVYf+sSZnZwKObnvthw8v0Rb
 eOeBrJ0RggD1QlRHPyrKnuXBd1PR51gsJPuuteOWn3FVQiIqci514IIru5koqkTUfomT
 +rngxOd2QTQl4JKu7pM5o1Ckyp+BsHytD4IG41vwRjLKyfZiOFjrMFvcIM/JNDjc4+EO
 8x4g==
X-Gm-Message-State: APjAAAVn0BOkoZTo7q2AHDkCwz3sW5pL9wCBRqpZWkvnTVVQfWKUB1yF
 TbHG9FRFA7prN/ELjUoZLHHnqNxvaUHicNosd0U=
X-Google-Smtp-Source: APXvYqz703AB7KXaPy74y6AnfRsuG54xLSvAhtHduqUB4713/yUFj0uRS2cltCjdXWIgE+nl7nMtbKT63q2kLIec+L4=
X-Received: by 2002:a5d:88c6:: with SMTP id i6mr78618232iol.107.1560976163811; 
 Wed, 19 Jun 2019 13:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <4e552352bb35b1f4b086e260be369464df7c490e.1558131003.git.alistair.francis@wdc.com>
 <mhng-96573692-b788-4185-85a6-435e87a7d7eb@palmer-si-x1e>
In-Reply-To: <mhng-96573692-b788-4185-85a6-435e87a7d7eb@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Jun 2019 13:26:35 -0700
Message-ID: <CAKmqyKOVYoqr2BATYVCDVj96S8cYtc0LqsY3nuCXv9+M29jWtQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH v1 2/4] disas/riscv: Disassemble reserved
 compressed encodings as illegal
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 14, 2019 at 2:18 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 17 May 2019 15:11:01 PDT (-0700), Alistair Francis wrote:
> > From: Michael Clark <mjc@sifive.com>
> >
> > Due to the design of the disassembler, the immediate is not
> > known during decoding of the opcode; so to handle compressed
> > encodings with reserved immediate values (non-zero), we need
> > to add an additional check during decompression to match
> > reserved encodings with zero immediates and translate them
> > into the illegal instruction.
> >
> > The following compressed opcodes have reserved encodings with
> > zero immediates: c.addi4spn, c.addi, c.lui, c.addi16sp, c.srli,
> > c.srai, c.andi and c.slli
> >
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  disas/riscv.c | 51 ++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 34 insertions(+), 17 deletions(-)
> >
> > diff --git a/disas/riscv.c b/disas/riscv.c
> > index 59a9b0437a..3ab4586f0a 100644
> > --- a/disas/riscv.c
> > +++ b/disas/riscv.c
> > @@ -504,14 +504,19 @@ typedef struct {
> >      const rvc_constraint *constraints;
> >  } rv_comp_data;
> >
> > +enum {
> > +    rvcd_imm_nz = 0x1
> > +};
> > +
> >  typedef struct {
> >      const char * const name;
> >      const rv_codec codec;
> >      const char * const format;
> >      const rv_comp_data *pseudo;
> > -    const int decomp_rv32;
> > -    const int decomp_rv64;
> > -    const int decomp_rv128;
> > +    const short decomp_rv32;
> > +    const short decomp_rv64;
> > +    const short decomp_rv128;
> > +    const short decomp_data;
> >  } rv_opcode_data;
> >
> >  /* register names */
> > @@ -1011,7 +1016,7 @@ const rv_opcode_data opcode_data[] = {
> >      { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1, NULL, 0, 0, 0 },
> >      { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1, NULL, 0, 0, 0 },
> >      { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1, NULL, 0, 0, 0 },
> > -    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
> > +    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi, rvcd_imm_nz },
> >      { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld, rv_op_fld, 0 },
> >      { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw, rv_op_lw },
> >      { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0, 0 },
> > @@ -1019,14 +1024,14 @@ const rv_opcode_data opcode_data[] = {
> >      { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw, rv_op_sw },
> >      { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0, 0 },
> >      { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
> > -    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
> > +    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi, rvcd_imm_nz },
> >      { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal, 0, 0 },
> >      { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
> > -    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi },
> > -    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui, rv_op_lui, rv_op_lui },
> > -    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli, rv_op_srli, rv_op_srli },
> > -    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai, rv_op_srai, rv_op_srai },
> > -    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi, rv_op_andi, rv_op_andi },
> > +    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi, rv_op_addi, rvcd_imm_nz },
> > +    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui, rv_op_lui, rv_op_lui, rvcd_imm_nz },
> > +    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli, rv_op_srli, rv_op_srli, rvcd_imm_nz },
> > +    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai, rv_op_srai, rv_op_srai, rvcd_imm_nz },
> > +    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi, rv_op_andi, rv_op_andi, rvcd_imm_nz },
>
> Unless I'm missing something, c.andi can have a zero immediate.

Yeah, I'll remove that.

Alistair

>
> >      { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub, rv_op_sub },
> >      { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor, rv_op_xor, rv_op_xor },
> >      { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or, rv_op_or, rv_op_or },
> > @@ -1036,7 +1041,7 @@ const rv_opcode_data opcode_data[] = {
> >      { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_jal, rv_op_jal, rv_op_jal },
> >      { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_beq, rv_op_beq, rv_op_beq },
> >      { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne, rv_op_bne, rv_op_bne },
> > -    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli, rv_op_slli, rv_op_slli },
> > +    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli, rv_op_slli, rv_op_slli, rvcd_imm_nz },
> >      { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld, rv_op_fld, rv_op_fld },
> >      { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw, rv_op_lw },
> >      { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0, 0 },
> > @@ -2795,8 +2800,12 @@ static void decode_inst_decompress_rv32(rv_decode *dec)
> >  {
> >      int decomp_op = opcode_data[dec->op].decomp_rv32;
> >      if (decomp_op != rv_op_illegal) {
> > -        dec->op = decomp_op;
> > -        dec->codec = opcode_data[decomp_op].codec;
> > +        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz) && dec->imm == 0) {
> > +            dec->op = rv_op_illegal;
> > +        } else {
> > +            dec->op = decomp_op;
> > +            dec->codec = opcode_data[decomp_op].codec;
> > +        }
> >      }
> >  }
> >
> > @@ -2804,8 +2813,12 @@ static void decode_inst_decompress_rv64(rv_decode *dec)
> >  {
> >      int decomp_op = opcode_data[dec->op].decomp_rv64;
> >      if (decomp_op != rv_op_illegal) {
> > -        dec->op = decomp_op;
> > -        dec->codec = opcode_data[decomp_op].codec;
> > +        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz) && dec->imm == 0) {
> > +            dec->op = rv_op_illegal;
> > +        } else {
> > +            dec->op = decomp_op;
> > +            dec->codec = opcode_data[decomp_op].codec;
> > +        }
> >      }
> >  }
> >
> > @@ -2813,8 +2826,12 @@ static void decode_inst_decompress_rv128(rv_decode *dec)
> >  {
> >      int decomp_op = opcode_data[dec->op].decomp_rv128;
> >      if (decomp_op != rv_op_illegal) {
> > -        dec->op = decomp_op;
> > -        dec->codec = opcode_data[decomp_op].codec;
> > +        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz) && dec->imm == 0) {
> > +            dec->op = rv_op_illegal;
> > +        } else {
> > +            dec->op = decomp_op;
> > +            dec->codec = opcode_data[decomp_op].codec;
> > +        }
> >      }
> >  }

