Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D11C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE25205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EjwjLuPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE25205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRDf-0002DD-KY
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kPRCl-00013v-2j
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:11:07 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:35848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kPRCi-0002Ym-Ea
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:11:06 -0400
Received: by mail-oi1-x22b.google.com with SMTP id u17so2636034oie.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vn3cWMzj8No0YOUDRVC0yjTlOvcUrXvU8SxYLuZ/ifk=;
 b=EjwjLuPoaqkXcQo5R94b+YbIP0HU7b0m7VctbkYSYR/W3uKDb84YqvnanC8iJFRn4k
 dEFam5+0Pung7Pq9Ze6F1kqcKDQJXA1asamaPA23qDSGyzEzApUwalYTyy6xLR3gaLlp
 LyqT0zsyf9TqeJUj37BQ00Js6S4ZKdXPIuEwJcJiIvURSmKTyUExe19Y4M9T1dPEWBUr
 OK4HHuwHih5XctFMkbQW+yN0A4IELYF7p/cj0FN9ZGVdnoA21RINRqZtRoF434GqakGt
 zNio2ekRBi5pBpXMILs3+SrwXWlJ+OFqvxIyz4aVmvpW1tUk22Lt+Rd1hK3dO81co8an
 2iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vn3cWMzj8No0YOUDRVC0yjTlOvcUrXvU8SxYLuZ/ifk=;
 b=b0zwIqVOx8K5Eprj5VAUANtzDna+YM3isp91dcOS8sy58/EO21R3pm9qxv6HfGeZVB
 /pNwsGvWhkniRQtNSsxwj77VkTxDCl9Mh2zOYsaat5jFBgGHlu0EVjykv+WwBtmi9aLD
 UgX+RPrI4GmhhTwLw/1itRPxiNhBFbvSq/3aQaPmDy1C2jzN0JXRqpBM0kBY/fulvczZ
 0ynDRxHHW6dq0sN3lpQ3Y4/3taQgEshloNK4QUpvWcR1asAnWXXxTbiAdDsza9S4cNAm
 06lgE/AAq7HUEWXbO0+clITooaKRA1qrNxVsZ230XeOd/Ym4HTy+bUjMilFItP5mLpiT
 D+Mw==
X-Gm-Message-State: AOAM530EAHHawOIqpRty2BznddcJBs6QHl9WuUlVKR1vBhRJpgX/u+TQ
 g6mWE6cSBHr3F3IcQcDSgw5XNaMtAIMpU7NT/4zWRA==
X-Google-Smtp-Source: ABdhPJxf2Im1XGuoze5D/sgcmdIfYftLwb6C0QsjJsa23Cdi3qiWyyrQCCPrmg9Y5CB1Czp0qyIH+KWs4sVoWSjOUvk=
X-Received: by 2002:aca:4c0d:: with SMTP id z13mr4488018oia.78.1601907062963; 
 Mon, 05 Oct 2020 07:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200929190448.31116-1-frank.chang@sifive.com>
 <20200929190448.31116-7-frank.chang@sifive.com>
 <ad28385b-3e36-e33a-03c2-dabaaaea80bc@linaro.org>
 <CAE_xrPgK0ROiWo+Evan9uGFoBo8t0hV8vt0A2DxDb_Sws55-Ng@mail.gmail.com>
 <246985bc-98ff-0975-20d4-66c5864abc63@linaro.org>
In-Reply-To: <246985bc-98ff-0975-20d4-66c5864abc63@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 5 Oct 2020 22:10:52 +0800
Message-ID: <CAE_xrPiaSqGVTK4sjsSbgWAQyC4vua170FEuqAjmnuYShNbuzw@mail.gmail.com>
Subject: Re: [RFC v5 06/68] target/riscv: rvv-1.0: add translation-time vector
 context status
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007396f305b0ed0df3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x22b.google.com
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
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007396f305b0ed0df3
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 5, 2020 at 10:00 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 10/5/20 2:12 AM, Frank Chang wrote:
> >     I think you want to be sharing the code between vsetvl and vsetvli
> now.  Just
> >     pass in a TCGv value to a common helper.
> >
> >
> > The only difference now between vsetvl and vsetvli is the format of zimm
> and s2
> > fields.
> > But they have different formats and are queried by different functions,
> > i.e. s2 = tcg_const_tl(a->zimm); and gen_get_gpr(s2, a->rs2);
> >
> > Is there any elegant way to retrieve the values of zimm and s2 by shared
> common
> > codes?
>
> Yes, like I (too briefly) described:
>
> static bool do_vsetvl(DisasContext *ctx,
>                       int rd, int rs1, TCGv s2)
> {
>     // existing contents of trans_vsetvl
>     // do continue to free s2.
> }
>
> static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
> {
>     TCGv s2 = tcg_temp_new();
>     gen_get_gpr(s2, a->rs2);
>     return do_vsetvl(ctx, a->rd, a->rs1, s2);
> }
>
> static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
> {
>     TCGv s2 = tcg_const_tl(a->zimm);
>     return do_vsetvl(ctx, a->rd, a->rs1, s2);
> }
>
>
> r~
>

Oops, I misunderstood what the "helper function" you meant.
I thought it was the helper function in vector_helper.c.
I'll update the codes in the next version patchset.

Thanks,
Frank Chang

--0000000000007396f305b0ed0df3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Oct 5, 2020 at 10:00 PM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 10/5/20 2:12 AM, Frank Chang wr=
ote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0I think you want to be sharing the code between vse=
tvl and vsetvli now.=C2=A0 Just<br>
&gt;=C2=A0 =C2=A0 =C2=A0pass in a TCGv value to a common helper.<br>
&gt; <br>
&gt; <br>
&gt; The only difference now between vsetvl=C2=A0and vsetvli is the format =
of zimm and s2<br>
&gt; fields.<br>
&gt; But they have different formats and are queried by different functions=
,<br>
&gt; i.e. s2 =3D tcg_const_tl(a-&gt;zimm); and gen_get_gpr(s2, a-&gt;rs2);<=
br>
&gt; <br>
&gt; Is there any elegant way to retrieve the values of zimm and s2 by shar=
ed common<br>
&gt; codes?<br>
<br>
Yes, like I (too briefly) described:<br>
<br>
static bool do_vsetvl(DisasContext *ctx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int rd, int rs1, TCGv s2)<br>
{<br>
=C2=A0 =C2=A0 // existing contents of trans_vsetvl<br>
=C2=A0 =C2=A0 // do continue to free s2.<br>
}<br>
<br>
static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)<br>
{<br>
=C2=A0 =C2=A0 TCGv s2 =3D tcg_temp_new();<br>
=C2=A0 =C2=A0 gen_get_gpr(s2, a-&gt;rs2);<br>
=C2=A0 =C2=A0 return do_vsetvl(ctx, a-&gt;rd, a-&gt;rs1, s2);<br>
}<br>
<br>
static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)<br>
{<br>
=C2=A0 =C2=A0 TCGv s2 =3D tcg_const_tl(a-&gt;zimm);<br>
=C2=A0 =C2=A0 return do_vsetvl(ctx, a-&gt;rd, a-&gt;rs1, s2);<br>
}<br>
<br>
<br>
r~<br></blockquote><div><br></div><div>Oops, I misunderstood what the &quot=
;helper function&quot; you meant.</div><div>I thought=C2=A0it was the helpe=
r function in vector_helper.c.</div><div>I&#39;ll update the codes in the n=
ext version patchset.</div><div><br></div><div>Thanks,</div><div>Frank Chan=
g=C2=A0<br></div></div></div>

--0000000000007396f305b0ed0df3--

