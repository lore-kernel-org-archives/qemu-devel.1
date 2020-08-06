Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3531CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B9922D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bzmMoSiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B9922D02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ZM1-0000IP-Mu
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 02:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k3ZL0-0007lA-MX
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 02:25:14 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k3ZKx-0002AG-6Y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 02:25:14 -0400
Received: by mail-io1-xd43.google.com with SMTP id s189so41229490iod.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 23:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D03pH4/RHWhvDXCkl4s6Xg7HWl5SAcWRrXSEuLtG1mU=;
 b=bzmMoSiy8t7wWj4sJ4h0n9xU8i4wA1ST2IQ/2dK5TWKRAr+Jam4n3qxfUeIM9jGBkf
 KhkLgMtMbUy+LODoOzbLqzjZnSf4aq/Rkl/hGm4vxKbpheU4HECnANJqFolJ9sZVlxS8
 YvkEFbooot0rEyLijHoPeicm0GeIo1uNDoZ1wkappbWLf5tNZElgdQd0ieCoH5u6zHza
 hwXEfL1/OqowjMA0b2SV8+0xNW2H71FsHsKMonx+WUwNeKf9j+ysTzDMaD940nBB1NA6
 A7rtuPfHCgFvE8oOaMqTs6YJEdNOovKj34DZ360vFS50oyjizPJ5Ba3OeXttLpV83j5v
 F2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D03pH4/RHWhvDXCkl4s6Xg7HWl5SAcWRrXSEuLtG1mU=;
 b=GrPisl/MuGPwA4L6tMaew6F5Awcf9/rxFwqn4AzOcWKA59u07MNwDAKmi+8vZPgOk+
 MO6OiWq+TNz84HW8fWnu++FGBtMpRCobWAHtWvoLRrPop9GJuu5n7rfuFRLa12cp9tob
 oypsGealPQJg0H0PMjZu6KIaBKd4B56xv6z+HckUvDrlMYpo7ygAsEhyhN+TX7bCLE8A
 uknRiqKiWo3WE51P1ItYUEuEy2h8ru6CWOc0NDn7KGvJueE7P9egS9Gfbcop3if6bDCD
 Pd+cK3Jrt4g32+ynjLeT3PDN4vFTiRYu9VPI62Zd+54GdxxGVl1fR8WFKFU0gR3YAqQa
 ZvQQ==
X-Gm-Message-State: AOAM531jmtxW/9L0Q074OCZPZAXBReWlRKiQ//xkIUMP6rSJpkYLcfyY
 oZjqv8AVvkIzQm+IcTP/8qddVpSxCfrojaP0ykJ4qw==
X-Google-Smtp-Source: ABdhPJww8BmqDQCGA1QvvorDSd7dRANSkDTtd7M9//xyYS2zGYAJedgJLR2F1MY/sc+2Sc/RTaD4guoXO8FCtMcV4wM=
X-Received: by 2002:a05:6602:2549:: with SMTP id
 j9mr7557298ioe.89.1596695109002; 
 Wed, 05 Aug 2020 23:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-4-richard.henderson@linaro.org>
In-Reply-To: <20200724002807.441147-4-richard.henderson@linaro.org>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 6 Aug 2020 14:24:58 +0800
Message-ID: <CAEiOBXV8A65PzDExGXwFWDJqQCShK_93ZpBAzeqAP0U4C3s3UA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] target/riscv: Generate nanboxed results from
 trans_rvf.inc.c
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c97c4805ac2f8c01"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=chihmin.chao@sifive.com; helo=mail-io1-xd43.google.com
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

--000000000000c97c4805ac2f8c01
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 24, 2020 at 8:28 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Make sure that all results from inline single-precision scalar
> operations are properly nan-boxed to 64-bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/insn_trans/trans_rvf.inc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c
> b/target/riscv/insn_trans/trans_rvf.inc.c
> index c7057482e8..264d3139f1 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -167,6 +167,7 @@ static bool trans_fsgnj_s(DisasContext *ctx,
> arg_fsgnj_s *a)
>          tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2],
> cpu_fpr[a->rs1],
>                              0, 31);
>      }
> +    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>      mark_fs_dirty(ctx);
>      return true;
>  }
> @@ -183,6 +184,7 @@ static bool trans_fsgnjn_s(DisasContext *ctx,
> arg_fsgnjn_s *a)
>          tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
>          tcg_temp_free_i64(t0);
>      }
> +    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>      mark_fs_dirty(ctx);
>      return true;
>  }
> @@ -199,6 +201,7 @@ static bool trans_fsgnjx_s(DisasContext *ctx,
> arg_fsgnjx_s *a)
>          tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
>          tcg_temp_free_i64(t0);
>      }
> +    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>      mark_fs_dirty(ctx);
>      return true;
>  }
> @@ -369,6 +372,7 @@ static bool trans_fmv_w_x(DisasContext *ctx,
> arg_fmv_w_x *a)
>  #else
>      tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
>  #endif
> +    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
>
>      mark_fs_dirty(ctx);
>      tcg_temp_free(t0);
> --
> 2.25.1
>
>
>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>

Chih-Min Chao

--000000000000c97c4805ac2f8c01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div></div><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 24, 2020 at 8:28 A=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Make sure that all results from inline single-prec=
ision scalar<br>
operations are properly nan-boxed to 64-bits.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/riscv/insn_trans/trans_rvf.inc.c | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_tr=
ans/trans_rvf.inc.c<br>
index c7057482e8..264d3139f1 100644<br>
--- a/target/riscv/insn_trans/trans_rvf.inc.c<br>
+++ b/target/riscv/insn_trans/trans_rvf.inc.c<br>
@@ -167,6 +167,7 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_=
s *a)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_deposit_i64(cpu_fpr[a-&gt;rd], cp=
u_fpr[a-&gt;rs2], cpu_fpr[a-&gt;rs1],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 31);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 gen_nanbox_s(cpu_fpr[a-&gt;rd], cpu_fpr[a-&gt;rd]);<br>
=C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
@@ -183,6 +184,7 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnj=
n_s *a)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_deposit_i64(cpu_fpr[a-&gt;rd], t0=
, cpu_fpr[a-&gt;rs1], 0, 31);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(t0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 gen_nanbox_s(cpu_fpr[a-&gt;rd], cpu_fpr[a-&gt;rd]);<br>
=C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
@@ -199,6 +201,7 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnj=
x_s *a)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_xor_i64(cpu_fpr[a-&gt;rd], cpu_fp=
r[a-&gt;rs1], t0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_temp_free_i64(t0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 gen_nanbox_s(cpu_fpr[a-&gt;rd], cpu_fpr[a-&gt;rd]);<br>
=C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
@@ -369,6 +372,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_=
x *a)<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0tcg_gen_extu_i32_i64(cpu_fpr[a-&gt;rd], t0);<br>
=C2=A0#endif<br>
+=C2=A0 =C2=A0 gen_nanbox_s(cpu_fpr[a-&gt;rd], cpu_fpr[a-&gt;rd]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0mark_fs_dirty(ctx);<br>
=C2=A0 =C2=A0 =C2=A0tcg_temp_free(t0);<br>
-- <br>
2.25.1<br>
<br>
<br></blockquote><div><br></div><div>Reviewed-by: Chih-Min Chao &lt;<a href=
=3D"mailto:chihmin.chao@sifive.com">chihmin.chao@sifive.com</a>&gt;</div><d=
iv><br></div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"lt=
r"><span style=3D"color:rgb(136,136,136)">Chih-Min Chao</span><div style=3D=
"color:rgb(136,136,136)"></div></div></div></div><div>=C2=A0</div></div></d=
iv>

--000000000000c97c4805ac2f8c01--

