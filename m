Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9489AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 05:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B901D207D8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 05:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h2MKUlnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B901D207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM2PP-0001NR-Fx
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 01:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kM2Od-0000rF-3r
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 01:05:19 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:40402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kM2Oa-0007eW-O1
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 01:05:18 -0400
Received: by mail-oi1-x235.google.com with SMTP id t76so5091027oif.7
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 22:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UIp+NLYqOH0NJxbG6Yo1Z1acaKCGa7Wj87aMUN9mHh8=;
 b=h2MKUlndgmbd9i7mCB+FVwbqVuN5e00f7wnk98GB6DYMLnVcPHWVXMee7Grtn8Zr9P
 1J0R6ciY1NavZN9uh8rS2NcNDWu+jFBNnCIHGezJLvOb1QkhUJ/JDhf55wDsyinPB/1r
 Z+YINrXfCVu+fbn1DJ/MQN5EIiwIdw0XroNecaR19mJis5rfdONs34rMlcVFTV4FJoTN
 66A7NJq8KHWb3Unc6nYuCNC7yZcCDV08GqUh9/CIHZaq5FAiaMS0IqN6QnmHNGf2fNPB
 DmOhMWKM9pn6f1Avf4k7Z/kH0HkQwtasjlQ2Ug2uzXidTvWkJL9BBjwC01Z9I7+000gg
 eQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UIp+NLYqOH0NJxbG6Yo1Z1acaKCGa7Wj87aMUN9mHh8=;
 b=pPMq32d6QfkcUQZuCQczO6KJT/63dnaMmPNJiy9eSBHVE9jlBKXQuJsS5hofSK3Yh2
 PEfCjqVCw7u8pv9Y19uDlju7+gqpzFe+Qssrk/cPnqfJZ0cKNTptSTbXvi+sIwJLsMe7
 jeFXW9OY6zy7IiE+q/tj4JaPPtS2/xxWnIfwfD/LFdAfqoB/At/yfWOLGaoNuVzht9K6
 IJkJ5ohA26tBOGdqT0tWS8iUKHWILPBrJENinaOTnjXNT8XmZ5GdAOjvsbSJIlFiItYO
 oUHZ7FfEEIxYXOIeyfGZZXjKGCr2E2IWeFVCqzCAkLwnv538+o5uE9fsekz7DSoSepCp
 GjEg==
X-Gm-Message-State: AOAM530n1jihaGDc+oNFwiF6mhFHN0Hf2dCLueUoPgWota8k0QadwQl3
 3vHo6Ck5ZqbqohPFX6XPhkOb1jNbacqPVTS1iiQzNQ==
X-Google-Smtp-Source: ABdhPJxk3ic6Yapp6UITV0ZlTDQtKUqG+jz1G+cLjZqLeeeNgUNHNSllZJrMuHSXl1v2ZPlwIIkAoWnaVUIsOueG/eQ=
X-Received: by 2002:aca:cf88:: with SMTP id f130mr458922oig.122.1601096715170; 
 Fri, 25 Sep 2020 22:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-18-frank.chang@sifive.com>
 <CAE_xrPj_fb1NER3a68O1dwzM70wvmb+8+NyDo_9z=POCjYTvQw@mail.gmail.com>
 <faf5ad2f-5f00-e80d-761d-6d19b98ec238@linaro.org>
In-Reply-To: <faf5ad2f-5f00-e80d-761d-6d19b98ec238@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Sat, 26 Sep 2020 13:05:04 +0800
Message-ID: <CAE_xrPgN2q_FMaRuk=5mPnD_aaROoBqN=U3TDS_2ciw4s6BDMw@mail.gmail.com>
Subject: Re: [RFC v4 17/70] target/riscv: rvv-1.0: configure instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f58cda05b0306080"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000f58cda05b0306080
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 26, 2020 at 2:28 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/25/20 1:51 AM, Frank Chang wrote:
> > trans_vsetvli() uses gen_goto_tb() to save the computation in the link
> to the
> > next TB.
> > I know there was a discussion about this back in RVV v0.7.1:
> >
> https://patchew.org/QEMU/20200103033347.20909-1-zhiwei_liu@c-sky.com/20200103033347.20909-5-zhiwei_liu@c-sky.com/
> >
> > However, we had encountered an issue that looked like it was caused by
> the
> > linked TB.
> > The code snippet which cause the issue is:
> >
> > 00000000000104a8 <loop>: 104a8: 0122ffd7 vsetvli t6,t0,e32,m4,tu,mu,d1
> 104ac:
> > 02036407 vle32.v v8,(t1) 104b0: 028a0a57 vadd.vv v20,v8,v20 104b4:
> 41f282b3 sub
> > t0,t0,t6 104b8: 002f9893 slli a7,t6,0x2 104bc: 9346 add t1,t1,a7 104be:
> > fe0295e3 bnez t0,104a8 <loop> 104c2: 012f7057 vsetvli
> zero,t5,e32,m4,tu,mu,d1
> > .....
> >
> > If $t0 is given with the value, e.g. 68.
> > <loop> is expected to process 32 elements in each iteration.
> > That's it, the env->vl after vsetvli at 0x104a8 in each iteration would
> be:
> > 1st iteration: 32 (remaining elements to be processed: 68 - 32 = 36)
> > 2nd iteration: 32 (remaining elements to be processed: 36 - 32 = 4)
> > 3rd iteration: 4 (remaining elements to be processed: 4 - 4 = 0, will
> leave
> > <loop> after 0x104be)
> >
> > vadd.vv at 0x104b0 is implemented with gvec for acceleration:
> >
> > if (a->vm && s->vl_eq_vlmax) {
> >     gvec_fn(s->sew, vreg_ofs(s, a->rd),
> >             vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
> >             MAXSZ(s), MAXSZ(s));
> > } else {
> >     uint32_t data = 0;
> >
> >     data = FIELD_DP32(data, VDATA, VM, a->vm);
> >     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> >     tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
> >                        vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
> >                        cpu_env, 0, s->vlen / 8, data, fn);
> > }
> >
> > gvec function is used when a->vm and s->vl_eq_vlmax are both true.
> > However, s->vl_eq_vlmax, for the above case, is only true in 1st and 2nd
> > iterations.
> > In third iteration, env->vl is 4 which is not equal to vlmax = 32.
> > But as the TB where vadd.vv resides are already linked with vsetvli's TB,
> > it won't be retranslated and still use the same gvec function in the
> third
> > iteration.
> > The total elemented being proceeded would be: 32 + 32 + 32 = 96, instead
> of 68.
> >
> > I'm wondering under such conditions, is it still correct to use
> gen_goto_tb() here?
> > Or we should use lookup_and_goto_ptr() as in trans_vsetvl() to not link
> the TBs.
>
> You're correct -- because of vl_eq_vlmax we can't use goto_tb when using a
> variable input.
>
> It would be possible when using xN,x0 for VLMAX, or x0,x0 for reuse of the
> current vl, but I doubt it's worth special-casing that.
>
> I wonder if the goto_tb conversation happened before we introduced
> vl_eq_vlmax
> and forgot to re-evaluate, or if I just missed that in the first place.
> Anyway, thanks for finding this.
>
>
> r~
>

Thanks Richard, I'll include the fix in my next version patchset.

Frank Chang

--000000000000f58cda05b0306080
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Sep 26, 2020 at 2:28 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 9/25/20 1:51 AM, Frank Chang wr=
ote:<br>
&gt; trans_vsetvli() uses gen_goto_tb() to save the computation in the link=
 to the<br>
&gt; next TB.<br>
&gt; I know there was a discussion about this back in RVV v0.7.1:<br>
&gt; <a href=3D"https://patchew.org/QEMU/20200103033347.20909-1-zhiwei_liu@=
c-sky.com/20200103033347.20909-5-zhiwei_liu@c-sky.com/" rel=3D"noreferrer" =
target=3D"_blank">https://patchew.org/QEMU/20200103033347.20909-1-zhiwei_li=
u@c-sky.com/20200103033347.20909-5-zhiwei_liu@c-sky.com/</a><br>
&gt; <br>
&gt; However, we had encountered an issue that looked like it was caused by=
 the<br>
&gt; linked TB.<br>
&gt; The code snippet which cause the issue is:<br>
&gt; <br>
&gt; 00000000000104a8 &lt;loop&gt;: 104a8: 0122ffd7 vsetvli t6,t0,e32,m4,tu=
,mu,d1 104ac:<br>
&gt; 02036407 vle32.v v8,(t1) 104b0: 028a0a57 vadd.vv v20,v8,v20 104b4: 41f=
282b3 sub<br>
&gt; t0,t0,t6 104b8: 002f9893 slli a7,t6,0x2 104bc: 9346 add t1,t1,a7 104be=
:<br>
&gt; fe0295e3 bnez t0,104a8 &lt;loop&gt; 104c2: 012f7057 vsetvli zero,t5,e3=
2,m4,tu,mu,d1<br>
&gt; .....<br>
&gt; <br>
&gt; If $t0 is given with the value, e.g. 68.<br>
&gt; &lt;loop&gt; is expected to process 32 elements in each iteration.<br>
&gt; That&#39;s it, the env-&gt;vl after vsetvli at 0x104a8 in each iterati=
on would be:<br>
&gt; 1st iteration: 32 (remaining elements to be processed: 68 - 32 =3D 36)=
<br>
&gt; 2nd iteration: 32 (remaining elements to be processed: 36 - 32 =3D 4)<=
br>
&gt; 3rd iteration: 4=C2=A0(remaining elements to be processed: 4 - 4 =3D 0=
, will leave<br>
&gt; &lt;loop&gt; after 0x104be)<br>
&gt; <br>
&gt; vadd.vv at 0x104b0 is implemented with gvec for acceleration:<br>
&gt; <br>
&gt; if (a-&gt;vm &amp;&amp; s-&gt;vl_eq_vlmax) {<br>
&gt; =C2=A0 =C2=A0 gvec_fn(s-&gt;sew, vreg_ofs(s, a-&gt;rd),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vreg_ofs(s, a-&gt;rs2), vreg=
_ofs(s, a-&gt;rs1),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MAXSZ(s), MAXSZ(s));<br>
&gt; } else {<br>
&gt; =C2=A0 =C2=A0 uint32_t data =3D 0;<br>
&gt; <br>
&gt; =C2=A0 =C2=A0 data =3D FIELD_DP32(data, VDATA, VM, a-&gt;vm);<br>
&gt; =C2=A0 =C2=A0 data =3D FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);<br>
&gt; =C2=A0 =C2=A0 tcg_gen_gvec_4_ptr(vreg_ofs(s, a-&gt;rd), vreg_ofs(s, 0)=
,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0vreg_ofs(s, a-&gt;rs1), vreg_ofs(s, a-&gt;rs2),<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cpu_env, 0, s-&gt;vlen / 8, data, fn);<br>
&gt; }<br>
&gt; <br>
&gt; gvec function is used when a-&gt;vm and s-&gt;vl_eq_vlmax are both tru=
e.<br>
&gt; However, s-&gt;vl_eq_vlmax, for the above case, is only true in 1st an=
d 2nd<br>
&gt; iterations.<br>
&gt; In third iteration, env-&gt;vl is 4 which is not equal to vlmax =3D 32=
.<br>
&gt; But as the TB where vadd.vv resides are already linked with vsetvli&#3=
9;s TB,<br>
&gt; it won&#39;t be retranslated and still use the same gvec function in t=
he third<br>
&gt; iteration.<br>
&gt; The total elemented being proceeded would be: 32=C2=A0+ 32=C2=A0+ 32 =
=3D 96, instead of 68.<br>
&gt; <br>
&gt; I&#39;m wondering under such conditions, is it still correct to use ge=
n_goto_tb() here?<br>
&gt; Or we should use lookup_and_goto_ptr() as in trans_vsetvl() to not lin=
k the TBs.<br>
<br>
You&#39;re correct -- because of vl_eq_vlmax we can&#39;t use goto_tb when =
using a<br>
variable input.<br>
<br>
It would be possible when using xN,x0 for VLMAX, or x0,x0 for reuse of the<=
br>
current vl, but I doubt it&#39;s worth special-casing that.<br>
<br>
I wonder if the goto_tb conversation happened before we introduced vl_eq_vl=
max<br>
and forgot to re-evaluate, or if I just missed that in the first place.<br>
Anyway, thanks for finding this.<br>
<br>
<br>
r~<br></blockquote><div><br></div><div>Thanks Richard, I&#39;ll include the=
 fix in my next version patchset.</div><div><br></div><div>Frank Chang=C2=
=A0</div></div></div>

--000000000000f58cda05b0306080--

