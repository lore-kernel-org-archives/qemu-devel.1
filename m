Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA31E22D3E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N6xoSPHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA31E22D3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ZOn-0003E5-05
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 02:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k3ZO3-0002ic-1H
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 02:28:23 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k3ZO1-0002cs-A2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 02:28:22 -0400
Received: by mail-io1-xd42.google.com with SMTP id g19so36419114ioh.8
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 23:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s7+dwA52LFgoqbPKABny4UMtQ9l1F6ipCaAgdhCX8nw=;
 b=N6xoSPHai76sHPjyfpAZGeaCbmvLHKagSrU7KCPM/Y1JcqBwdHBey9f63MIzZvz6ps
 UqkyRQQzAGm/h0sndJoa0cCfwoExQUlpDnl7B3viwjMKpMFrqv1k3gKpR/SPey1JgF9j
 QmDzG4H6XDelN2g1au4FzJcfTcDA1gquqjypM9m4HzFY5plz42UI6w7Z3kQwVxqg0Yfr
 ExHKeBGImsB+a5HAcyb/Ropac4L4fJbjL++A6qjmSskSaTsb1kYaxFIa/6AR5RZvts1f
 SOsdpElCYoh7tevKsoS1gWg2DZE5SJIoA9dZnEVBzq9MfEP3/KYNZX0ywEd6Ex6tW4OV
 ihZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s7+dwA52LFgoqbPKABny4UMtQ9l1F6ipCaAgdhCX8nw=;
 b=N2C8znE/wF9VopqGxhLhSF0pZ/kVl1pyqyIlXGH2XHgyW8BlIHsfa2bq5Z9eEEqFUa
 3/gHi3tBjI1HJ1DtEC5dOpMBR0XOpe1FGgfpxcwFOsW5+86uyIdh/hLK6a4973evWSDc
 7FeZaLMYuTs6y3G0UlJaL3UQpqVN+Ym1m9cIqxX3jetrnWp7H7SKZyoNaqNgrlXlrQrg
 MxMvxlJknMWpgZUZX4vSgnl0c6QhsoIjfw5HYba6DN5omMJAIg9QrISoS6yZYqsU9Ml7
 go2wopchcIa7ia0C4H3pKOaZrTOW9PnAgoAKlQLT/k2TlkhMRILHD9D2C/pY1c7lhbCh
 ptbA==
X-Gm-Message-State: AOAM533RK64No+Va468fUy7FKdzPXHDU3jQhpubWyYip0lZPeaDw80Br
 9RJ41lb+u8lEux/JNMR0+6LjN6TaJfMKW79GH5H2H76hP3U=
X-Google-Smtp-Source: ABdhPJw49kO7uOZkjhFABGivosEmmHg+x3lnwScAamW+08uLzUWhOA8uSFdBuoEfyrpGmTZ8rC4FPcDdw1bkuHOUEZA=
X-Received: by 2002:a5d:8a04:: with SMTP id w4mr8072540iod.15.1596695300397;
 Wed, 05 Aug 2020 23:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-7-richard.henderson@linaro.org>
In-Reply-To: <20200724002807.441147-7-richard.henderson@linaro.org>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 6 Aug 2020 14:28:09 +0800
Message-ID: <CAEiOBXVfY8KsXmfQ9htojsuWX_X3U0oFdis0YXoDmyj_G_JHGw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] target/riscv: Clean up fmv.w.x
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000031f73b05ac2f98cd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=chihmin.chao@sifive.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 liuzhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000031f73b05ac2f98cd
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 24, 2020 at 8:28 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
>
> Use tcg_gen_extu_tl_i64 to avoid the ifdef.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Message-Id: <20200626205917.4545-7-zhiwei_liu@c-sky.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/insn_trans/trans_rvf.inc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c
> b/target/riscv/insn_trans/trans_rvf.inc.c
> index f9a9e0643a..0d04677a02 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -406,11 +406,7 @@ static bool trans_fmv_w_x(DisasContext *ctx,
> arg_fmv_w_x *a)
>      TCGv t0 = tcg_temp_new();
>      gen_get_gpr(t0, a->rs1);
>
> -#if defined(TARGET_RISCV64)
> -    tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
> -#else
> -    tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
> -#endif
> +    tcg_gen_extu_tl_i64(cpu_fpr[a->rd], t0);
>      gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>
>      mark_fs_dirty(ctx);
> --
> 2.25.1
>
>
>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>

Chih-Min Chao

--00000000000031f73b05ac2f98cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 24, 2020 at 8:=
28 AM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">From: LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_=
liu@c-sky.com" target=3D"_blank">zhiwei_liu@c-sky.com</a>&gt;<br>
<br>
Use tcg_gen_extu_tl_i64 to avoid the ifdef.<br>
<br>
Signed-off-by: LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@c-sky.com" targe=
t=3D"_blank">zhiwei_liu@c-sky.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20200626205917.4545-7-zhiwei_liu@c-sky.co=
m" target=3D"_blank">20200626205917.4545-7-zhiwei_liu@c-sky.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/riscv/insn_trans/trans_rvf.inc.c | 6 +-----<br>
=C2=A01 file changed, 1 insertion(+), 5 deletions(-)<br>
<br>
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_tr=
ans/trans_rvf.inc.c<br>
index f9a9e0643a..0d04677a02 100644<br>
--- a/target/riscv/insn_trans/trans_rvf.inc.c<br>
+++ b/target/riscv/insn_trans/trans_rvf.inc.c<br>
@@ -406,11 +406,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w=
_x *a)<br>
=C2=A0 =C2=A0 =C2=A0TCGv t0 =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 =C2=A0gen_get_gpr(t0, a-&gt;rs1);<br>
<br>
-#if defined(TARGET_RISCV64)<br>
-=C2=A0 =C2=A0 tcg_gen_mov_i64(cpu_fpr[a-&gt;rd], t0);<br>
-#else<br>
-=C2=A0 =C2=A0 tcg_gen_extu_i32_i64(cpu_fpr[a-&gt;rd], t0);<br>
-#endif<br>
+=C2=A0 =C2=A0 tcg_gen_extu_tl_i64(cpu_fpr[a-&gt;rd], t0);<br>
=C2=A0 =C2=A0 =C2=A0gen_nanbox_s(cpu_fpr[a-&gt;rd], cpu_fpr[a-&gt;rd]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
-- <br>
2.25.1<br>
<br>
<br></blockquote><div><br></div><div>Reviewed-by: Chih-Min Chao &lt;<a href=
=3D"mailto:chihmin.chao@sifive.com">chihmin.chao@sifive.com</a>&gt;</div><d=
iv><br></div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"lt=
r"><span style=3D"color:rgb(136,136,136)">Chih-Min Chao</span><div style=3D=
"color:rgb(136,136,136)"></div></div></div></div><div>=C2=A0</div></div></d=
iv>

--00000000000031f73b05ac2f98cd--

