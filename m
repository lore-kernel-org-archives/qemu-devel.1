Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A109C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9112085B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JgYbxgTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9112085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLj15-0000CW-JU
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kLiz6-0006wJ-0F
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:21:40 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:34879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kLiz2-0001aU-Pl
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:21:39 -0400
Received: by mail-ot1-x32b.google.com with SMTP id s66so1560367otb.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TJeNo5RmevwgDoUGpwaeKOy7BJU1dN3YuFAGutV0TNY=;
 b=JgYbxgTB95S5AGCvhnPXG+clD9JIz9GX/8VtD7bBVrwwUGGLRoWooUfN0Egqr17XAe
 c6oOBmzIHzWR9DTfmTz3pAtS/tBv9FJznmJGyD5V6ehRIELXAhUAH+qmCsYeribMzYSA
 h02xbmUls4BGIJwJCoDeXLvxqT1pxWuvqPWU6NWV/zeeEkPXjcIhr8S0im559VgP7VyT
 zLeGebviiQL+djqMKoCo/HYRvPOmYDseAjaBsxutjHAOR1iEzNEwPjCCg21SY0jspGn7
 Wdwuj6CHMEDGS9Y+P59vtquoMU5v72bov1jcsxXr4JTO8pAaxkz00XKmmfJ8bMd+qB/o
 GymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TJeNo5RmevwgDoUGpwaeKOy7BJU1dN3YuFAGutV0TNY=;
 b=S2mu6249Hs549pUFSVt4q7YUf1kVaDs2MRl+FPeXGWKtSSXJH1KOSChHGST7OA1ei1
 akq2plRZcBQCDe+s3Uv+VW5MBneqdoEhfEpCBsgd1fYy88knBLpfBccyD723SCVjSSgV
 ELtspOw8ojqEYJa7NDbF9R/Wt9qN0SrdKNhCT4LwpXwG0qCkOyDtBITe5ZLl5kdmHq/Z
 wUPqKHGF65lJcs2luP20an9bLDapa/VnZ0iKiyVW8zR2JKr9KHCDcemyuyEdst6CwEbe
 uQLGeSKzrOv1a1sjSQsen8+r3BNiJW5liJGSMIENo9qMxNltsyntVzDDCvPvnuPOfDt0
 UmsQ==
X-Gm-Message-State: AOAM532XySs5Z6/KbmiAQBm1hc7NBRks0152BFjhYRGTGDy6mXwbN8JC
 lUv3q03/6P32wmCfgcT2lyuGlh2cZNQPaC1n8dK6Fw==
X-Google-Smtp-Source: ABdhPJwFadq4GiVeZJiqpQFAn6xktsDSt06+/TlcWgfDf7datSKyYg2JZIWEdBe1RsJKZSxgg3E+iVxieMMJso1W244=
X-Received: by 2002:a05:6830:14d9:: with SMTP id
 t25mr2221256otq.188.1601022095384; 
 Fri, 25 Sep 2020 01:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-54-frank.chang@sifive.com>
 <96b9fa44-5a1b-2ac0-04ae-fa4d2857096e@linaro.org>
In-Reply-To: <96b9fa44-5a1b-2ac0-04ae-fa4d2857096e@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 25 Sep 2020 16:21:24 +0800
Message-ID: <CAE_xrPhUXcMrBmRDwVBwmwA0m3QgaSAm56pYCs5QCJHOeK+S2Q@mail.gmail.com>
Subject: Re: [RFC v4 53/70] target/riscv: rvv-1.0: floating-point slide
 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000045fbc005b01f0130"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000045fbc005b01f0130
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 30, 2020 at 4:33 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> > +DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1up_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1down_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1down_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1down_vf_d, void, ptr, ptr, i64, ptr, env, i32)
>
> You shouldn't need any new helpers.
>
> The fp scalar argument can be passed to the existing helpers.
>

I'm happy to reuse vslide1up_vx helper functions.

However, opfvf_trans() takes helper prototype of:

*typedef void gen_helper_opfvf(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_ptr,
                        TCGv_env, TCGv_i32);*
but vslide1up_vx helper function's prototype is:

*typedef void gen_helper_opivx(TCGv_ptr, TCGv_ptr, TCGv, TCGv_ptr,
                    TCGv_env, TCGv_i32);*

The third argument has different types, not sure if it's worth it to sync
them
all to TCGv_i64.
But I'm afraid it would require more effort than keeping them in different
helper functions.

Frank Chang


>
> The manual doesn't explicitly say, but I assume the fp scalar needs to be
> nan-boxed (for sew > flen), or checked (for sew < flen), just like the
> scalar
> move instructions.
>
>
> r~

--00000000000045fbc005b01f0130
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sun, Aug 30, 2020 at 4:33 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 8/17/20 1:49 AM, <a href=3D"mai=
lto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a> wr=
ote:<br>
&gt; +DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)<br>
&gt; +DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)<br>
&gt; +DEF_HELPER_6(vfslide1up_vf_d, void, ptr, ptr, i64, ptr, env, i32)<br>
&gt; +DEF_HELPER_6(vfslide1down_vf_h, void, ptr, ptr, i64, ptr, env, i32)<b=
r>
&gt; +DEF_HELPER_6(vfslide1down_vf_w, void, ptr, ptr, i64, ptr, env, i32)<b=
r>
&gt; +DEF_HELPER_6(vfslide1down_vf_d, void, ptr, ptr, i64, ptr, env, i32)<b=
r>
<br>
You shouldn&#39;t need any new helpers.<br>
<br>
The fp scalar argument can be passed to the existing helpers.<br></blockquo=
te><div><br></div><div>I&#39;m happy=C2=A0to reuse vslide1up_vx helper func=
tions.<br></div><div><br></div><div>However,=C2=A0opfvf_trans() takes helpe=
r prototype of:<br><i>typedef void gen_helper_opfvf(TCGv_ptr, TCGv_ptr, TCG=
v_i64, TCGv_ptr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_env, TCGv_i32);</i><=
/div><div>but vslide1up_vx helper function&#39;s=C2=A0prototype is:</div><d=
iv><i>typedef void gen_helper_opivx(TCGv_ptr, TCGv_ptr, TCGv, TCGv_ptr,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv_env, TCGv_i32);</i><br></div><div><br>=
</div><div>The third argument has=C2=A0different=C2=A0types, not sure if it=
&#39;s worth it to sync them</div><div>all to=C2=A0TCGv_i64.</div><div>But =
I&#39;m afraid it would require more effort than keeping them in different<=
/div><div>helper functions.</div><div><br></div><div>Frank Chang</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
The manual doesn&#39;t explicitly say, but I assume the fp scalar needs to =
be<br>
nan-boxed (for sew &gt; flen), or checked (for sew &lt; flen), just like th=
e scalar<br>
move instructions.<br>
<br>
<br>
r~</blockquote><div></div></div></div>

--00000000000045fbc005b01f0130--

