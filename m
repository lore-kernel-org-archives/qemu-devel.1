Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93148C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201A9207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201A9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFHx-0007EF-8i
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41275)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZF92-0000ao-D7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZF90-0001fK-Eu
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:43:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZF8y-0001Yi-6W
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so4116834wmd.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nAOQRIBD3C+d3XcVW4Ec5w2u9bjPn6YQ2czFeI0auhM=;
 b=HVNaouTBgEkS1ZhLQR0g1KxrXsJH5BovmmflYxMMlUslmh5uRBm8istkUNM1A6dSjK
 J98cU7f7iVKVwPyr8f4IvzHaK9DihGgAVBY3snV8zOG/4J4hFcMhY3eCnC8HEVSB/D7a
 On/HerAvdOVNFaPvQbnVd0kbyLDGVvgoEezM3/tOG3abRO5UirZf2ws2ZP2R1aidu1Pd
 ph+FZmvYlE5LwdwGctwT0drFyKC4HekD1R/9x31AnzhiTi4oreG2UYJr/iZMvVTO5rIr
 7lUwALb5c0yOJPsgddsV/b3LGvXZ7l6PvrFZVt8NAPWr7ZqLcY3EGxVoAVelSn8do+hx
 G5vw==
X-Gm-Message-State: APjAAAVvtfeGezDGCA8B3EM39P1ckED3lILtjP4CTkv+Xr+ClLPtalj4
 DNF9ToenV7EMcvj/XNOqbwtSOg==
X-Google-Smtp-Source: APXvYqwugNFLXuS3WfiOkKGAMDGnpssZzUDKl1/T6ojfxQPFaMRTNthCRxE4tNYwNCCRMzLAESkxwQ==
X-Received: by 2002:a1c:7dd3:: with SMTP id y202mr3720252wmc.30.1559914975325; 
 Fri, 07 Jun 2019 06:42:55 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id x9sm2027000wmj.27.2019.06.07.06.42.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:42:54 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-20-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e30e5562-6de8-80cb-7b88-8f30b89bb7a7@redhat.com>
Date: Fri, 7 Jun 2019 15:42:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607091116.49044-20-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v17 19/24] target/rx: Replace operand with
 prt_ldmi in disassembler
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 11:11 AM, Yoshinori Sato wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> This has consistency with prt_ri().  It loads all data before
> beginning output.  It uses exactly one call to prt() to emit
> the full instruction.
> 
> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Again:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/disas.c | 77 +++++++++++++++++++------------------------------------
>  1 file changed, 27 insertions(+), 50 deletions(-)
> 
> diff --git a/target/rx/disas.c b/target/rx/disas.c
> index 64342537ee..515b365528 100644
> --- a/target/rx/disas.c
> +++ b/target/rx/disas.c
> @@ -135,18 +135,18 @@ static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi)
>      sprintf(out, "%u", dsp << (mi < 3 ? mi : 4 - mi));
>  }
>  
> -static void operand(DisasContext *ctx, int ld, int mi, int rs, int rd)
> +static void prt_ldmi(DisasContext *ctx, const char *insn,
> +                     int ld, int mi, int rs, int rd)
>  {
>      static const char sizes[][4] = {".b", ".w", ".l", ".uw", ".ub"};
>      char dsp[8];
>  
>      if (ld < 3) {
>          rx_index_addr(ctx, dsp, ld, mi);
> -        prt("%s[r%d]%s", dsp, rs, sizes[mi]);
> +        prt("%s\t%s[r%d]%s, r%d", insn, dsp, rs, sizes[mi], rd);
>      } else {
> -        prt("r%d", rs);
> +        prt("%s\tr%d, r%d", insn, rs, rd);
>      }
> -    prt(", r%d", rd);
>  }
>  
>  static void prt_ir(DisasContext *ctx, const char *insn, int imm, int rd)
> @@ -416,8 +416,7 @@ static bool trans_AND_ir(DisasContext *ctx, arg_AND_ir *a)
>  /* and rs,rd */
>  static bool trans_AND_mr(DisasContext *ctx, arg_AND_mr *a)
>  {
> -    prt("and\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "and", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -440,8 +439,7 @@ static bool trans_OR_ir(DisasContext *ctx, arg_OR_ir *a)
>  /* or rs,rd */
>  static bool trans_OR_mr(DisasContext *ctx, arg_OR_mr *a)
>  {
> -    prt("or\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "or", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -463,8 +461,7 @@ static bool trans_XOR_ir(DisasContext *ctx, arg_XOR_ir *a)
>  /* xor rs,rd */
>  static bool trans_XOR_mr(DisasContext *ctx, arg_XOR_mr *a)
>  {
> -    prt("xor\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "xor", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -479,8 +476,7 @@ static bool trans_TST_ir(DisasContext *ctx, arg_TST_ir *a)
>  /* tst rs, rd */
>  static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
>  {
> -    prt("tst\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "tst", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -548,8 +544,7 @@ static bool trans_ADD_irr(DisasContext *ctx, arg_ADD_irr *a)
>  /* add dsp[rs], rd */
>  static bool trans_ADD_mr(DisasContext *ctx, arg_ADD_mr *a)
>  {
> -    prt("add\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "add", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -573,8 +568,7 @@ static bool trans_CMP_ir(DisasContext *ctx, arg_CMP_ir *a)
>  /* cmp dsp[rs], rs2 */
>  static bool trans_CMP_mr(DisasContext *ctx, arg_CMP_mr *a)
>  {
> -    prt("cmp\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "cmp", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -589,8 +583,7 @@ static bool trans_SUB_ir(DisasContext *ctx, arg_SUB_ir *a)
>  /* sub dsp[rs], rd */
>  static bool trans_SUB_mr(DisasContext *ctx, arg_SUB_mr *a)
>  {
> -    prt("sub\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "sub", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -611,8 +604,7 @@ static bool trans_SBB_rr(DisasContext *ctx, arg_SBB_rr *a)
>  /* sbb dsp[rs], rd */
>  static bool trans_SBB_mr(DisasContext *ctx, arg_SBB_mr *a)
>  {
> -    prt("sbb\t");
> -    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
> +    prt_ldmi(ctx, "sbb", a->ld, RX_IM_LONG, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -640,8 +632,7 @@ static bool trans_MAX_ir(DisasContext *ctx, arg_MAX_ir *a)
>  /* max dsp[rs], rd */
>  static bool trans_MAX_mr(DisasContext *ctx, arg_MAX_mr *a)
>  {
> -    prt("max\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "max", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -656,8 +647,7 @@ static bool trans_MIN_ir(DisasContext *ctx, arg_MIN_ir *a)
>  /* min dsp[rs], rd */
>  static bool trans_MIN_mr(DisasContext *ctx, arg_MIN_mr *a)
>  {
> -    prt("max\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "min", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -673,8 +663,7 @@ static bool trans_MUL_ir(DisasContext *ctx, arg_MUL_ir *a)
>  /* mul dsp[rs], rd */
>  static bool trans_MUL_mr(DisasContext *ctx, arg_MUL_mr *a)
>  {
> -    prt("mul\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "mul", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -696,8 +685,7 @@ static bool trans_EMUL_ir(DisasContext *ctx, arg_EMUL_ir *a)
>  /* emul dsp[rs], rd */
>  static bool trans_EMUL_mr(DisasContext *ctx, arg_EMUL_mr *a)
>  {
> -    prt("emul\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "emul", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -712,8 +700,7 @@ static bool trans_EMULU_ir(DisasContext *ctx, arg_EMULU_ir *a)
>  /* emulu dsp[rs], rd */
>  static bool trans_EMULU_mr(DisasContext *ctx, arg_EMULU_mr *a)
>  {
> -    prt("emulu\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "emulu", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -728,8 +715,7 @@ static bool trans_DIV_ir(DisasContext *ctx, arg_DIV_ir *a)
>  /* div dsp[rs], rd */
>  static bool trans_DIV_mr(DisasContext *ctx, arg_DIV_mr *a)
>  {
> -    prt("div\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "div", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -744,8 +730,7 @@ static bool trans_DIVU_ir(DisasContext *ctx, arg_DIVU_ir *a)
>  /* divu dsp[rs], rd */
>  static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
>  {
> -    prt("divu\t");
> -    operand(ctx, a->ld, a->mi, a->rs, a->rd);
> +    prt_ldmi(ctx, "divu", a->ld, a->mi, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -1089,8 +1074,7 @@ static bool trans_FADD_ir(DisasContext *ctx, arg_FADD_ir *a)
>  /* fadd rs, rd */
>  static bool trans_FADD_mr(DisasContext *ctx, arg_FADD_mr *a)
>  {
> -    prt("fadd\t");
> -    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
> +    prt_ldmi(ctx, "fadd", a->ld, RX_IM_LONG, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -1105,8 +1089,7 @@ static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir *a)
>  /* fcmp rs, rd */
>  static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
>  {
> -    prt("fcmp\t");
> -    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
> +    prt_ldmi(ctx, "fcmp", a->ld, RX_IM_LONG, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -1121,8 +1104,7 @@ static bool trans_FSUB_ir(DisasContext *ctx, arg_FSUB_ir *a)
>  /* fsub rs, rd */
>  static bool trans_FSUB_mr(DisasContext *ctx, arg_FSUB_mr *a)
>  {
> -    prt("fsub\t");
> -    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
> +    prt_ldmi(ctx, "fsub", a->ld, RX_IM_LONG, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -1130,8 +1112,7 @@ static bool trans_FSUB_mr(DisasContext *ctx, arg_FSUB_mr *a)
>  /* ftoi rs, rd */
>  static bool trans_FTOI(DisasContext *ctx, arg_FTOI *a)
>  {
> -    prt("ftoi\t");
> -    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
> +    prt_ldmi(ctx, "ftoi", a->ld, RX_IM_LONG, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -1146,8 +1127,7 @@ static bool trans_FMUL_ir(DisasContext *ctx, arg_FMUL_ir *a)
>  /* fmul rs, rd */
>  static bool trans_FMUL_mr(DisasContext *ctx, arg_FMUL_mr *a)
>  {
> -    prt("fmul\t");
> -    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
> +    prt_ldmi(ctx, "fmul", a->ld, RX_IM_LONG, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -1162,8 +1142,7 @@ static bool trans_FDIV_ir(DisasContext *ctx, arg_FDIV_ir *a)
>  /* fdiv rs, rd */
>  static bool trans_FDIV_mr(DisasContext *ctx, arg_FDIV_mr *a)
>  {
> -    prt("fdiv\t");
> -    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
> +    prt_ldmi(ctx, "fdiv", a->ld, RX_IM_LONG, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -1171,8 +1150,7 @@ static bool trans_FDIV_mr(DisasContext *ctx, arg_FDIV_mr *a)
>  /* round rs, rd */
>  static bool trans_ROUND(DisasContext *ctx, arg_ROUND *a)
>  {
> -    prt("round\t");
> -    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
> +    prt_ldmi(ctx, "round", a->ld, RX_IM_LONG, a->rs, a->rd);
>      return true;
>  }
>  
> @@ -1180,8 +1158,7 @@ static bool trans_ROUND(DisasContext *ctx, arg_ROUND *a)
>  /* itof dsp[rs], rd */
>  static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
>  {
> -    prt("itof\t");
> -    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
> +    prt_ldmi(ctx, "itof", a->ld, RX_IM_LONG, a->rs, a->rd);
>      return true;
>  }
>  
> 

