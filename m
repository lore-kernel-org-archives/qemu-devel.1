Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C13220780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 21:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEZnt6IS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C13220780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPYo1-0004D7-QK
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 17:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPYmN-0002kt-3C
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPYmL-0002pu-S3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:44:07 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:45615)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPYmL-0002nr-MW
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 17:44:05 -0400
Received: by mail-il1-x141.google.com with SMTP id i2so3619571ils.12
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W+foWC3TBhMmgABgslrbCC5noK9w0MHB83ra8OT7FtE=;
 b=uEZnt6ISD9tRHuuKyz7wvw2322SOTh3fSM6e9A6oiAsZv0tx/UH/WrsvCyW1mmT2rN
 fEEDPEG/IoqYTsVApMN2DuyBK3IWjJcoVF0KXNaIZJj7wFxhHVlj209cYAx712z9DmYL
 4Y+qGsh9iWmAm1ZC2NjmBKU++ECg+yy8nrOfpm43ar1sCWMj3szX3GIvc2gGWQic118A
 tWT6bQnnK2ipmsOu5G12XFKG0hrrbz5qpIv4fRf4KD3SAdgPvFhT+q2rhd4EAahLLmIx
 8Z+rkKoXeFNboyjONGA5II0Fbd/BqkxG3ip4r6cRbkToLBjQAa8AiyNoh/mw0MygPiYv
 xbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W+foWC3TBhMmgABgslrbCC5noK9w0MHB83ra8OT7FtE=;
 b=LXAYK9kQYbRkFI2Hchzqgy0Udr2kimeCXUHskBsJCEq0leEWOK0mYHFVwbENiwnJCg
 02/0UNL71FRnD4oQZKnbXY00ivG+QMxoQVhSKTY8UKjlojzcHMaTLPT8SUtJfOjzjbNj
 ZYMZ8XSr6zdBTGq7oCfWzin+opIZdf0IBlk2RHdgryTRu53dYZTJn2xWaN2Q1SooL8qf
 CMcmrjW9I9q0S8XuejZHnbUXe4+0ZtiiCRhf9v6W+7qtnA/vm1n/6mCCh1K9+KcAZ24O
 OQ/U5bKIF/86F6p6eYTajCmophri8w4u0WD5FJ4IhUR5EO0rYVIbvjeVyf96Wv6ll5qy
 qqDw==
X-Gm-Message-State: AGi0PuZzSGrceEuicWrdNZnrcb1eADApbvqmbHIr3jtcyzgjZNcvyfEg
 763pe6qBIGMIlPvjlz/TdTLdxEP6nyWvTebmiGZ5dF3m
X-Google-Smtp-Source: APiQypIK2LHf23lMlMOAE1HBQhZQ5Zi+99r3OziEXsYy+8c6PQdxiQc0vP859F7A6eeY2eGp/gGRe4lLnDQlO2rAwuI=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr5323531ili.267.1587159844826; 
 Fri, 17 Apr 2020 14:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
 <20200417191022.5247-5-edgar.iglesias@gmail.com>
In-Reply-To: <20200417191022.5247-5-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 14:35:42 -0700
Message-ID: <CAKmqyKPy4JnHVG3-WZ0OmmCsDbz=7usst8UKFDDYwx37upBe6w@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] target/microblaze: Add the unaligned-exceptions
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 12:10 PM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add the unaligned-exceptions property to control if the core
> traps unaligned memory accesses.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.c       | 4 ++++
>  target/microblaze/cpu.h       | 1 +
>  target/microblaze/translate.c | 4 ++--
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 7a40e2fbad..a850c7b23c 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -209,6 +209,8 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
>                                                   PVR2_IOPB_BUS_EXC_MASK : 0) |
>                          (cpu->cfg.illegal_opcode_exception ?
>                                                  PVR2_ILL_OPCODE_EXC_MASK : 0) |
> +                        (cpu->cfg.unaligned_exceptions ?
> +                                                PVR2_UNALIGNED_EXC_MASK : 0) |
>                          (cpu->cfg.opcode_0_illegal ?
>                                                   PVR2_OPCODE_0x0_ILL_MASK : 0);
>
> @@ -282,6 +284,8 @@ static Property mb_properties[] = {
>                       cfg.illegal_opcode_exception, false),
>      DEFINE_PROP_BOOL("div-zero-exception", MicroBlazeCPU,
>                       cfg.div_zero_exception, false),
> +    DEFINE_PROP_BOOL("unaligned-exceptions", MicroBlazeCPU,
> +                     cfg.unaligned_exceptions, false),
>      DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
>                       cfg.opcode_0_illegal, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 3c07f9b3f7..ef9081db40 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -306,6 +306,7 @@ struct MicroBlazeCPU {
>          bool illegal_opcode_exception;
>          bool opcode_0_illegal;
>          bool div_zero_exception;
> +        bool unaligned_exceptions;
>          char *version;
>          uint8_t pvr;
>      } cfg;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index b4a78551ef..20b7427811 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -995,7 +995,7 @@ static void dec_load(DisasContext *dc)
>      v = tcg_temp_new_i32();
>      tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
>
> -    if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
> +    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
>          TCGv_i32 t0 = tcg_const_i32(0);
>          TCGv_i32 treg = tcg_const_i32(dc->rd);
>          TCGv_i32 tsize = tcg_const_i32(size - 1);
> @@ -1110,7 +1110,7 @@ static void dec_store(DisasContext *dc)
>      tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
>
>      /* Verify alignment if needed.  */
> -    if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
> +    if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
>          TCGv_i32 t1 = tcg_const_i32(1);
>          TCGv_i32 treg = tcg_const_i32(dc->rd);
>          TCGv_i32 tsize = tcg_const_i32(size - 1);
> --
> 2.20.1
>
>

