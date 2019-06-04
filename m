Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494E9C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFD624E04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFD624E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46069 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY29K-0006Lf-5c
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:38:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY27h-0005FM-Vp
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY27g-0008Vb-LA
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:36:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY27g-0008Ul-Bm
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:36:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so9098456wrw.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 22:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vgLOwtD6adiNOKe068CEj6N1u7Lq0M6X5fJeTMUe1lg=;
	b=E0xF0uyrMImNliXfWxv8xctIERY1YeZbne4/3OAXjQsWee/sArPgSeLiOG+X7oOm7v
	o6Ed77BnqYQTVqXwEDBx2siUFs/dDcEBEsHzpdXoma418efhizHacr7X3ubNCxQJ6P4X
	5fX0MK7jthY9Em/UhwjFEiKnji8w+NGHhh6HFA9Kjg57vHJrDiaCvhnEz7wCV9N3CGNO
	2X+F9W2Nf/WydT9UXl30lMCeHyrHhTBLSOXCMImtUfK0Rm46XXGrUaW/8QI6Gd3G9ANd
	madxWxyiCncvzuDHKmpmpq8gd/ALuqGLdtRLMCzC6hAkK1GWFivasII34U465EKMSwz9
	sA8w==
X-Gm-Message-State: APjAAAXp3zsw3Yn7eRM9JpSrw+yD9YQ8aaks/8spj+Ax5tbnCqDnbH0T
	CKrObpd3qo8N4xvyDpmVoplH1Q==
X-Google-Smtp-Source: APXvYqxfWfa1o8P6+xvC583gq9QW42E+0rUm2C/7uu6edm6l19MDxdFemQfz4Ezmi6mcbZ7OBdDigA==
X-Received: by 2002:adf:f003:: with SMTP id j3mr4839207wro.250.1559626595159; 
	Mon, 03 Jun 2019 22:36:35 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	i13sm8043278wrw.65.2019.06.03.22.36.34
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 22:36:34 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <48cf829e-3306-aed7-0623-498a4a4beb02@redhat.com>
Date: Tue, 4 Jun 2019 07:36:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531134315.4109-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v16 21/23] target/rx: Emit all disassembly
 in one prt()
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 3:43 PM, Richard Henderson wrote:
> Many of the multi-part prints have been eliminated by previous
> patches.  Eliminate the rest of them.
> 
> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/rx/disas.c | 75 ++++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 36 deletions(-)
> 
> diff --git a/target/rx/disas.c b/target/rx/disas.c
> index db10385fd0..ebc1a44249 100644
> --- a/target/rx/disas.c
> +++ b/target/rx/disas.c
> @@ -228,24 +228,21 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
>  /* mov.[bwl] rs,rd */
>  static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
>  {
> -    char dspd[8], dsps[8];
> +    char dspd[8], dsps[8], szc = size[a->sz];
>  
> -    prt("mov.%c\t", size[a->sz]);
>      if (a->lds == 3 && a->ldd == 3) {
>          /* mov.[bwl] rs,rd */
> -        prt("r%d, r%d", a->rs, a->rd);
> -        return true;
> -    }
> -    if (a->lds == 3) {
> +        prt("mov.%c\tr%d, r%d", szc, a->rs, a->rd);
> +    } else if (a->lds == 3) {
>          rx_index_addr(ctx, dspd, a->ldd, a->sz);
> -        prt("r%d, %s[r%d]", a->rs, dspd, a->rd);
> +        prt("mov.%c\tr%d, %s[r%d]", szc, a->rs, dspd, a->rd);
>      } else if (a->ldd == 3) {
>          rx_index_addr(ctx, dsps, a->lds, a->sz);
> -        prt("%s[r%d], r%d", dsps, a->rs, a->rd);
> +        prt("mov.%c\t%s[r%d], r%d", szc, dsps, a->rs, a->rd);
>      } else {
>          rx_index_addr(ctx, dsps, a->lds, a->sz);
>          rx_index_addr(ctx, dspd, a->ldd, a->sz);
> -        prt("%s[r%d], %s[r%d]", dsps, a->rs, dspd, a->rd);
> +        prt("mov.%c\t%s[r%d], %s[r%d]", szc, dsps, a->rs, dspd, a->rd);
>      }
>      return true;
>  }
> @@ -254,8 +251,11 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
>  /* mov.[bwl] rs,[-rd] */
>  static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
>  {
> -    prt("mov.%c\tr%d, ", size[a->sz], a->rs);
> -    prt((a->ad == 0) ? "[r%d+]" : "[-r%d]", a->rd);
> +    if (a->ad) {
> +        prt("mov.%c\tr%d, [-r%d]", size[a->sz], a->rs, a->rd);
> +    } else {
> +        prt("mov.%c\tr%d, [r%d+]", size[a->sz], a->rs, a->rd);
> +    }
>      return true;
>  }
>  
> @@ -263,9 +263,11 @@ static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
>  /* mov.[bwl] [-rd],rs */
>  static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
>  {
> -    prt("mov.%c\t", size[a->sz]);
> -    prt((a->ad == 0) ? "[r%d+]" : "[-r%d]", a->rd);
> -    prt(", r%d", a->rs);
> +    if (a->ad) {
> +        prt("mov.%c\t[-r%d], r%d", size[a->sz], a->rd, a->rs);
> +    } else {
> +        prt("mov.%c\t[r%d+], r%d", size[a->sz], a->rd, a->rs);
> +    }
>      return true;
>  }
>  
> @@ -299,9 +301,11 @@ static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
>  /* movu.[bw] [-rs],rd */
>  static bool trans_MOVU_pr(DisasContext *ctx, arg_MOVU_pr *a)
>  {
> -    prt("movu.%c\t", size[a->sz]);
> -    prt((a->ad == 0) ? "[r%d+]" : "[-r%d]", a->rd);
> -    prt(", r%d", a->rs);
> +    if (a->ad) {
> +        prt("movu.%c\t[-r%d], r%d", size[a->sz], a->rd, a->rs);
> +    } else {
> +        prt("movu.%c\t[r%d+], r%d", size[a->sz], a->rd, a->rs);
> +    }
>      return true;
>  }
>  
> @@ -478,11 +482,11 @@ static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
>  /* not rs, rd */
>  static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
>  {
> -    prt("not\t");
>      if (a->rs != a->rd) {
> -        prt("r%d, ", a->rs);
> +        prt("not\tr%d, r%d", a->rs, a->rd);
> +    } else {
> +        prt("not\tr%d", a->rs);
>      }
> -    prt("r%d", a->rd);
>      return true;
>  }
>  
> @@ -490,11 +494,11 @@ static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
>  /* neg rs, rd */
>  static bool trans_NEG_rr(DisasContext *ctx, arg_NEG_rr *a)
>  {
> -    prt("neg\t");
>      if (a->rs != a->rd) {
> -        prt("r%d, ", a->rs);
> +        prt("neg\tr%d, r%d", a->rs, a->rd);
> +    } else {
> +        prt("neg\tr%d", a->rs);
>      }
> -    prt("r%d", a->rd);
>      return true;
>  }
>  
> @@ -606,11 +610,10 @@ static bool trans_SBB_mr(DisasContext *ctx, arg_SBB_mr *a)
>  /* abs rs, rd */
>  static bool trans_ABS_rr(DisasContext *ctx, arg_ABS_rr *a)
>  {
> -    prt("abs\t");
> -    if (a->rs == a->rd) {
> -        prt("r%d", a->rd);
> +    if (a->rs != a->rd) {
> +        prt("abs\tr%d, r%d", a->rs, a->rd);
>      } else {
> -        prt("r%d, r%d", a->rs, a->rd);
> +        prt("abs\tr%d", a->rs);
>      }
>      return true;
>  }
> @@ -733,11 +736,11 @@ static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
>  /* shll #imm:5, rs, rd */
>  static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
>  {
> -    prt("shll\t#%d, ", a->imm);
>      if (a->rs2 != a->rd) {
> -        prt("r%d, ", a->rs2);
> +        prt("shll\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
> +    } else {
> +        prt("shll\t#%d, r%d", a->imm, a->rd);
>      }
> -    prt("r%d", a->rd);
>      return true;
>  }
>  
> @@ -752,11 +755,11 @@ static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
>  /* shar #imm:5, rs, rd */
>  static bool trans_SHAR_irr(DisasContext *ctx, arg_SHAR_irr *a)
>  {
> -    prt("shar\t#%d,", a->imm);
>      if (a->rs2 != a->rd) {
> -        prt("r%d, ", a->rs2);
> +        prt("shar\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
> +    } else {
> +        prt("shar\t#%d, r%d", a->imm, a->rd);
>      }
> -    prt("r%d", a->rd);
>      return true;
>  }
>  
> @@ -771,11 +774,11 @@ static bool trans_SHAR_rr(DisasContext *ctx, arg_SHAR_rr *a)
>  /* shlr #imm:5, rs, rd */
>  static bool trans_SHLR_irr(DisasContext *ctx, arg_SHLR_irr *a)
>  {
> -    prt("shlr\t#%d, ", a->imm);
>      if (a->rs2 != a->rd) {
> -        prt("r%d, ", a->rs2);
> +        prt("shlr\t#%d, r%d, r%d", a->imm, a->rs2, a->rd);
> +    } else {
> +        prt("shlr\t#%d, r%d", a->imm, a->rd);
>      }
> -    prt("r%d", a->rd);
>      return true;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

