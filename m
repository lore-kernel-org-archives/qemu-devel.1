Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448BEC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AC220840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AC220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51246 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFAm-0001gk-CJ
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZF8d-0008Ow-Iw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZF8c-0000Xi-6y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZF8c-0000Vx-0q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:42:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so1987477wmm.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yCG7Yt8uUDAWBkXAC2yPPcNymwOgDBvncNCirPjCf1o=;
 b=s0Tgst1e4IOUedjjTcvdniUlUFL6tjlKPN2Tc8N+tNQeNKlx3KJiL3yVwXi4snn66w
 BDlA2wvxdJ+M/GWf06Id8fEo4xV9X872Ugz2wctGUQgkD2PsGIMPZjC5uvB+xpSNaUEQ
 z2TS45aTAFWxUm24s96MkLyVASD9l6y6OlbZoAHV3RJYN84LNqHldoLcHn/Wv5jKRc9b
 VNXGl6c13nvOxckG9g61GPumZvyT4AXrdai2UBcpWwqCltpayvQwRfh2Z5SG08G1d1Bq
 7oY9T1V2IZ3tiisZimPZRjkdz4AET6nam1kJB8W909Hhsf0dIBqwLR9iD7041kQ8wLLz
 4SVg==
X-Gm-Message-State: APjAAAWe51oHECMLnTZ6Xyy10puTx77GnvY3DJWeSED9URW+CXGVswxC
 UyzwxP+geAGQMyZFEBkGC6JdXQ==
X-Google-Smtp-Source: APXvYqwiYwqbjJcQgMYkUQBLopgshP1QmxkKDg56DUcCrRs2372yiEKG7AYOGGypoyBMxiGE71KqcA==
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr3465320wmh.24.1559914952800; 
 Fri, 07 Jun 2019 06:42:32 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id a139sm2650940wmd.18.2019.06.07.06.42.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:42:32 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-22-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c8c70e34-e5f3-b7fd-9b7c-266326f019de@redhat.com>
Date: Fri, 7 Jun 2019 15:42:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607091116.49044-22-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v17 21/24] target/rx: Emit all disassembly
 in one prt()
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
> Many of the multi-part prints have been eliminated by previous
> patches.  Eliminate the rest of them.
> 
> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Again:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/disas.c | 75 +++++++++++++++++++++++++++++--------------------------
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

