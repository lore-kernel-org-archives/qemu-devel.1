Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0314EC32771
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C290324656
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovAVumUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C290324656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwEy6-0005O0-1G
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 19:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iwExT-0004zC-V1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iwExT-0006yl-1I
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:42:23 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iwExS-0006uP-QA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:42:22 -0500
Received: by mail-lf1-x144.google.com with SMTP id r14so7738208lfm.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 16:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5iXYFHN0FvkcAmF2i7ZkFRA/l7aBKsY+7TfEE1gKgGI=;
 b=ovAVumUbh3TE6zhdtpvKN2Htf9oWsdUBNCkwzTR+fh0LJX7Dn+Ve7PwxGtZrf1fxxp
 Wg0v+zwv8/e94q8TObLduic+YEUXSzeMZDamz37etM1VL8pQ4m/VOy9ckCmchieOnphx
 dv261lCCTzpZYW2ddxWBoqbn5OduClG5F9WtSU/Jw979vhBPc+4ovquEvAOAgjNfDzZf
 Z5G2WeZi+7+9IqqxY0GaO7boOFwObSZI5joqgqcaPDrzsI0osJ8RanvGbiRZ09v/JS0F
 pYOdNRVfWiwLbZg1UlSrV0PCPHIA72lFsLef4DZsPlfa3ecbQKAuKLEHam4n8+Z1bm9c
 Na+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5iXYFHN0FvkcAmF2i7ZkFRA/l7aBKsY+7TfEE1gKgGI=;
 b=H/9CIjiBphDUd12yRFuxrFY5x/+Ql4hyrro4U0xtwME+Y57NfLO7ARwesciZpgok/L
 /3ETR0Qk1/vWyEB9ja2nU6nlhpb9531EcAngSX7w6QVIL1VR1TDUQUmRZq9VSgZcDI69
 dOcpcHlw3sX7ii4U0vauY5KXdi/sQLL/qaw8UuE7X3n68hDGl3no19P/YOFU1l3yZvx4
 Y6C06z2ga9ylRtoVk/r4iB67Mfjsw8tLhiJk/nnrKIR/NZJh5k6AVLndsXk1JNLC3GxX
 VD7F6Y5csax17pw2SZoPIvQ8KEzonNP9iuupztS3ykdYrbo1cUAXV7dqtiogh6Wm1luJ
 u+Ow==
X-Gm-Message-State: APjAAAUK83p3CQbjV5eLh/CFHHl6J7dS3//3kTtoXLNbRxQ7NNX8ZkRa
 3ENLwIL/2T2VviX+/ocJlltgrGm1CDSaOB9kFbk=
X-Google-Smtp-Source: APXvYqzJbJ3a5t4haWHsgsUccAa3hPQJ7LzJQFlBBojS4w2t/3uz0YycAu+Q9JjXAmLTH4xCkHOk15cHOJ9ZGCaE3rg=
X-Received: by 2002:a19:5057:: with SMTP id z23mr753005lfj.132.1580172141285; 
 Mon, 27 Jan 2020 16:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20200128003707.17028-1-ianjiang.ict@gmail.com>
In-Reply-To: <20200128003707.17028-1-ianjiang.ict@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Jan 2020 16:41:54 -0800
Message-ID: <CAKmqyKMCdcrytWLQP4u1x9SdC4cSzonMstktHib_tXo00VUCOQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Add helper to make NaN-boxing for FP register
To: Ian Jiang <ianjiang.ict@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 4:37 PM Ian Jiang <ianjiang.ict@gmail.com> wrote:
>
> The function that makes NaN-boxing when a 32-bit value is assigned
> to a 64-bit FP register is split out to a helper gen_nanbox_fpr().
> Then it is applied in translating of the FLW instruction.
>
> Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
> index e23cd639a6..3bfd8881e7 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -23,6 +23,20 @@
>          return false;                       \
>  } while (0)
>
> +/*
> + * RISC-V requires NaN-boxing of narrower width floating
> + * point values.  This applies when a 32-bit value is
> + * assigned to a 64-bit FP register.  Thus this does not
> + * apply when the RVD extension is not present.
> + */
> +static void gen_nanbox_fpr(DisasContext *ctx, int regno)
> +{
> +    if (has_ext(ctx, RVD)) {
> +        tcg_gen_ori_i64(cpu_fpr[regno], cpu_fpr[regno],
> +                        MAKE_64BIT_MASK(32, 32));
> +    }
> +}
> +
>  static bool trans_flw(DisasContext *ctx, arg_flw *a)
>  {
>      TCGv t0 = tcg_temp_new();
> @@ -32,8 +46,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
>      tcg_gen_addi_tl(t0, t0, a->imm);
>
>      tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
> -    /* RISC-V requires NaN-boxing of narrower width floating point values */
> -    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
> +    gen_nanbox_fpr(ctx, a->rd);
>
>      tcg_temp_free(t0);
>      mark_fs_dirty(ctx);
> --
> 2.17.1
>
>

