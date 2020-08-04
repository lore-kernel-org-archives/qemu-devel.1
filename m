Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA15BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 02:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CBD2245C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 02:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TpBmFlZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CBD2245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2mte-0000nF-TW
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 22:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k2mst-0000Gu-QR
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 22:40:59 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:40861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k2msr-0005Nh-ME
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 22:40:59 -0400
Received: by mail-oi1-x232.google.com with SMTP id u24so25233145oiv.7
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 19:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0jASq426+euL7C0GEXz9F6pOVW8NNx56SU1j+gEtzyU=;
 b=TpBmFlZ1uRpI+Yr9wSVRa526s8UXbrCW7s9kxkxR2EFiyHPL9Pk9vnVbzLbkfCFpDL
 U2y1nP1Iwj0wcq2vN49Uf8MzkbjhnuB6+b9ISkLVAjEZSRdJn3O7gyqiWB2YfR0m8izS
 RJr0uXmrjG6P5VLcR2jtfE3uQx7rotnUfVUVXGa2erRQaKTn9NwTVAABzB6YLmILJt0B
 lihpOoiTM1QjUF/25cFuVYTG+kexdYYJvHwoZkVbsDS1uQZ661K67bvm4BYAwvsWhAmD
 MbbIx73dvVMY4hUHQwzsqDRiBKgi4W1w2vDdaamgNJDxix1Rf7QMRCpiLehzzzO4BrNu
 sQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0jASq426+euL7C0GEXz9F6pOVW8NNx56SU1j+gEtzyU=;
 b=Hafiyvo+wYFekgMIOrLThms2YNFzMWMFtdwJ4LGYcT6+/26cE4jPMBZFlG5k9WOh3R
 XtlDFrKgQG5wCQtHIAOX9adRQdvPZbcIZ6kA35l4AuSZ88+jWb3woYl0txPOxRaJWv3I
 0HfnuhA6bj8dItBqZJ4vlir1sVdYAZ0r56kiFQPKoDdxGTdyq/3Ck9gDX2FUwojho30O
 Si9UIfYfBWDL+AQ1yOE9XoYR4y8bu8N49DHzTRaiwbbblAyijtgq3jt5gs2UxMqwxO7y
 TO9wQCUeQ6NpnunwqlAZ/31iA+UYWbrBQyGf9FHqqoBa83z3SRUgezBpkkD0FzMyN56c
 oy7A==
X-Gm-Message-State: AOAM530xlrMBVm+nXrMcattlP3/H5agKeASXEQPgRrM4HXXHBzxJUTs8
 /VXHgIydZ+DOtxOcsA4vcD5cn47heRYn3tWFPCV1Ew==
X-Google-Smtp-Source: ABdhPJxCtkwPWH2Vr3TOM+tefE/IgbYjT9fKs1xroR4Gd8RAfoeEjJIhoQWg0+O8eIuFeRija8kvqEzs3khjeDzj/5M=
X-Received: by 2002:aca:bd89:: with SMTP id n131mr1709084oif.78.1596508856248; 
 Mon, 03 Aug 2020 19:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-51-frank.chang@sifive.com>
 <a9b14055-1e84-e8da-6901-4e3e863e121d@linaro.org>
In-Reply-To: <a9b14055-1e84-e8da-6901-4e3e863e121d@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 4 Aug 2020 10:40:44 +0800
Message-ID: <CAE_xrPjg=AAeDVT5GbT0mQsxVQ-O6DaYnCzgaxxor6nMZWENEA@mail.gmail.com>
Subject: Re: [RFC v2 50/76] target/riscv: rvv-0.9: single-width saturating add
 and subtract instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004205ab05ac042fb4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x232.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004205ab05ac042fb4
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 31, 2020 at 5:24 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > Sign-extend vsaddu.vi immediate value.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >  target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/insn_trans/trans_rvv.inc.c
> b/target/riscv/insn_trans/trans_rvv.inc.c
> > index 956ee90745..3018489536 100644
> > --- a/target/riscv/insn_trans/trans_rvv.inc.c
> > +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> > @@ -2374,7 +2374,7 @@ GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
> >  GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
> >  GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
> >  GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
> > -GEN_OPIVI_TRANS(vsaddu_vi, IMM_ZX, vsaddu_vx, opivx_check)
> > +GEN_OPIVI_TRANS(vsaddu_vi, IMM_SX, vsaddu_vx, opivx_check)
> >  GEN_OPIVI_TRANS(vsadd_vi, IMM_SX, vsadd_vx, opivx_check)
> >
> >  /* Vector Single-Width Averaging Add and Subtract */
> >
>
> This isn't what spike does.
>
> The manual could really stand to be more specific here...
>
>
> r~
>

Isn't Spike's vsaddu.vi immediate value also signed-extended?
*riscv/insns/vsaddu_vi.h:*
*vd = vs2 + (insn.v_simm5() & (UINT64_MAX >> (64 - P.VU.vsew))); *

From RVV 0.9 spec.:
*vsaddu.vi <http://vsaddu.vi> vd, vs2, imm, vm # vector-immediate*
It also mentions *imm* is sign-extended.
In contrast, *uimm* represents the immediate value to be zero-extended.

Frank Chang

--0000000000004205ab05ac042fb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Jul 31, 2020 at 5:24 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 7/22/20 2:16 AM, <a href=3D"mai=
lto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> wr=
ote:<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; <br>
&gt; Sign-extend <a href=3D"http://vsaddu.vi" rel=3D"noreferrer" target=3D"=
_blank">vsaddu.vi</a> immediate value.<br>
&gt; <br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/in=
sn_trans/trans_rvv.inc.c<br>
&gt; index 956ee90745..3018489536 100644<br>
&gt; --- a/target/riscv/insn_trans/trans_rvv.inc.c<br>
&gt; +++ b/target/riscv/insn_trans/trans_rvv.inc.c<br>
&gt; @@ -2374,7 +2374,7 @@ GEN_OPIVX_TRANS(vsaddu_vx,=C2=A0 opivx_check)<br=
>
&gt;=C2=A0 GEN_OPIVX_TRANS(vsadd_vx,=C2=A0 opivx_check)<br>
&gt;=C2=A0 GEN_OPIVX_TRANS(vssubu_vx,=C2=A0 opivx_check)<br>
&gt;=C2=A0 GEN_OPIVX_TRANS(vssub_vx,=C2=A0 opivx_check)<br>
&gt; -GEN_OPIVI_TRANS(vsaddu_vi, IMM_ZX, vsaddu_vx, opivx_check)<br>
&gt; +GEN_OPIVI_TRANS(vsaddu_vi, IMM_SX, vsaddu_vx, opivx_check)<br>
&gt;=C2=A0 GEN_OPIVI_TRANS(vsadd_vi, IMM_SX, vsadd_vx, opivx_check)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* Vector Single-Width Averaging Add and Subtract */<br>
&gt; <br>
<br>
This isn&#39;t what spike does.<br>
<br>
The manual could really stand to be more specific here...<br>
<br>
<br>
r~<br></blockquote><div><br></div><div>Isn&#39;t Spike&#39;s <a href=3D"htt=
p://vsaddu.vi">vsaddu.vi</a> immediate value also signed-extended?=C2=A0</d=
iv><div><i>riscv/insns/vsaddu_vi.h:</i><br></div><div><i>vd =3D vs2 + (insn=
.v_simm5() &amp; (UINT64_MAX &gt;&gt; (64 - P.VU.vsew)));=C2=A0</i></div><d=
iv><br></div><div>From RVV 0.9 spec.:</div><div><i><a href=3D"http://vsaddu=
.vi">vsaddu.vi</a> vd, vs2, imm, vm # vector-immediate</i></div><div>It als=
o mentions=C2=A0<i>imm</i> is sign-extended.</div><div>In contrast, <i>uimm=
</i> represents the immediate value to be zero-extended.</div><div><br></di=
v><div>Frank Chang</div></div></div>

--0000000000004205ab05ac042fb4--

