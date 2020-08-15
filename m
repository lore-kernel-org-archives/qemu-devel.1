Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE77C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B4D23A6C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WS1wj6+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B4D23A6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zIt-00081q-Cg
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k6zID-0007bY-Bp
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:44:29 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k6zIB-00073r-Nz
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:44:28 -0400
Received: by mail-oi1-x244.google.com with SMTP id n128so7168228oif.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nNxcyvydBKW7um7acp/fp1BhM/4SQTbKf0bBRIbObWA=;
 b=WS1wj6+Luh3GU2QmWNRtvgIkTaGEaoC8uIU+t0s2qurInNUA6hZHkgBnShAy0vJYPp
 Fbpi9wQXm/eDVNcbPBl93Uyg5nhuqZrICobe41YTiipWlzCGwNZ4K69eKRgl0rLuSbcM
 dLYFpjmwPoNFrANxpQv0XxtXrjXALKinaF25h1BW7D5HqWa4qoR73Zf4Wl+48Av3Prhp
 bQvA71tsVmuyC2SsIAHSp15H7ct0pyS40A1rWICu2ztqDBjhTNQzNjSJbN4unaYqA1nr
 QzOIXb+PudAi0cjtSPIVS7KBO7N76fkWGUmWR951T4QZ+ljbMZ0Ijm4cVXl8JYDrs2rP
 Y3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nNxcyvydBKW7um7acp/fp1BhM/4SQTbKf0bBRIbObWA=;
 b=T6+LZNgQlqH5ovsIQFtBQXkt0FLzbPxMbYXFLPQpgdJkzPnwU7pW8VrYBuxaHNivsK
 ObWGsoVyECuH09PmFIl3qay76OB1x3CW90vLDiTvRQmoLtSKzK0SVkCKeAERNoxkUnWz
 f8ruJY9mAd5AkThJfMShaxy2nMJTsZ0eNysks2wJ1TfsuPCgP4cIYcXJ9qFS2Wq4BXAb
 ONUJbvYikloe3RxGBweLop9PbnTUycrXlBWl7hD8VXy7ZgoQqw6fZzYauo7bY8kqjrO6
 kB65YBdDKz76qWp0NPUb5L2yzCPAla4CB2t4mJT7db0fi+EqfmZCvwegacULySR6OkFF
 JBxw==
X-Gm-Message-State: AOAM533nm8rz0xFN3fFmSNfDPzZcEPTrdmSADt+3Kq9vzizKBEVodir3
 gYzciYKdCIo8JLkpVF7gYBquf3ebMUha8oN3aTDskmFqFas=
X-Google-Smtp-Source: ABdhPJwks7FCHLO+icCm1f/bxIWRNnwBbQGIm4b/hUFuy5n0R20aqcOqtkDL+DEury7bEBOne5qQYFbmVUy+gtIrJf0=
X-Received: by 2002:aca:bd89:: with SMTP id n131mr3125624oif.78.1597458353242; 
 Fri, 14 Aug 2020 19:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-27-frank.chang@sifive.com>
 <90f01984-54a4-2a56-c52f-d1f4332b39d4@linaro.org>
 <CAE_xrPiJRRV3FYtfve6LMOF6LNEYGfhmi9CiabxqUBEew9igLg@mail.gmail.com>
 <5706a1ca-1dd9-22cd-08ce-c70780111bfc@linaro.org>
In-Reply-To: <5706a1ca-1dd9-22cd-08ce-c70780111bfc@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Sat, 15 Aug 2020 10:25:42 +0800
Message-ID: <CAE_xrPi93pRQccEncy00SO6cax0_GGRw-HUFF0uFzQ0f2P67kA@mail.gmail.com>
Subject: Re: [RFC v3 26/71] target/riscv: rvv-1.0: update vext_max_elems() for
 load/store insns
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b0614605ace14148"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b0614605ace14148
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 15, 2020 at 2:36 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/13/20 7:48 PM, Frank Chang wrote:
> > esz is passed from e.g. GEN_VEXT_LD_STRIDE() macro:
> >
> >> #define GEN_VEXT_LD_STRIDE(NAME, ETYPE, LOAD_FN)        \
> >> void HELPER(NAME)(void *vd, void * v0, target_ulong base,  \
> >>                   target_ulong stride, CPURISCVState *env, \
> >>                   uint32_t desc)                           \
> >> {                                                          \
> >>     uint32_t vm = vext_vm(desc);                           \
> >>     vext_ldst_stride(vd, v0, base, stride, env, desc, vm, LOAD_FN, \
> >>                      sizeof(ETYPE), GETPC(), MMU_DATA_LOAD);       \
> >> }
> >>
> >> GEN_VEXT_LD_STRIDE(vlse8_v,  int8_t,  lde_b)
> >
> > which is calculated by sizeof(ETYPE), so the results would be: 1, 2, 4,
> 8.
> > and vext_max_elems() is called by e.g. vext_ldst_stride():
>
> Ah, yes.
>
> >> uint32_t max_elems = vext_max_elems(desc, esz);
> >
> > I can add another parameter to the macro and pass the hard-coded
> log2(esz) number
> > if it's the better way instead of using ctzl().
> > Or if there's another approach to get the log2(esz) number more
> elegantly?
>
> Using ctzl(sizeof(type)) in the GEN_VEXT_LD_STRIDE macro will work well.
> This
> will be constant folded by the compiler.
>
>
> r~
>

Nice, didn't come up with the compiler optimization.
Will fix the codes and send out a new version of patchset.
Thanks for the tips.

Frank Chang

--000000000000b0614605ace14148
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Aug 15, 2020 at 2:36 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 8/13/20 7:48 PM, Frank Chang wr=
ote:<br>
&gt; esz is passed from e.g.=C2=A0GEN_VEXT_LD_STRIDE() macro:<br>
&gt; <br>
&gt;&gt; #define GEN_VEXT_LD_STRIDE(NAME, ETYPE, LOAD_FN)=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>
&gt;&gt; void HELPER(NAME)(void *vd, void * v0, target_ulong base,=C2=A0 \<=
br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tar=
get_ulong stride, CPURISCVState *env, \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uin=
t32_t desc)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt; {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt; =C2=A0 =C2=A0 uint32_t vm =3D vext_vm(desc);=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
&gt;&gt; =C2=A0 =C2=A0 vext_ldst_stride(vd, v0, base, stride, env, desc, vm=
, LOAD_FN, \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sizeof(ETYPE), GETPC(), MMU_DATA_LOAD); =C2=A0 =C2=A0 =C2=A0 \<br=
>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0GEN_VEXT_LD_STRIDE(vlse8_v, =C2=A0int8_t, =C2=A0lde_b)<br>
&gt; <br>
&gt; which is calculated by sizeof(ETYPE), so the results would be: 1, 2, 4=
, 8.<br>
&gt; and vext_max_elems() is called by e.g. vext_ldst_stride():<br>
<br>
Ah, yes.<br>
<br>
&gt;&gt; uint32_t max_elems =3D vext_max_elems(desc, esz);<br>
&gt; <br>
&gt; I can add another parameter to the macro and pass the hard-coded log2(=
esz) number<br>
&gt; if it&#39;s the better way instead of using=C2=A0ctzl().<br>
&gt; Or if there&#39;s another approach to get the log2(esz) number more el=
egantly?<br>
<br>
Using ctzl(sizeof(type)) in the GEN_VEXT_LD_STRIDE macro will work well.=C2=
=A0 This<br>
will be constant folded by the compiler.<br>
<br>
<br>
r~<br></blockquote><div><br></div><div>Nice, didn&#39;t come up with the co=
mpiler optimization.</div><div>Will fix the codes and send out a new versio=
n of patchset.</div><div>Thanks for the tips.</div><div><br></div><div>Fran=
k Chang=C2=A0<br></div></div></div>

--000000000000b0614605ace14148--

