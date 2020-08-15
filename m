Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B69C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C29206B6
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eJecjkNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C29206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k74DZ-0003x5-3K
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 18:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k74Cz-0003VZ-0Z
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 17:59:25 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k74Cx-0001B0-0O
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 17:59:24 -0400
Received: by mail-ot1-x342.google.com with SMTP id a65so10493289otc.8
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bCin6TmgTSZWrgtfO6/BybfYU3ZQRUite8vCDBRZoh0=;
 b=eJecjkNW4Wcw/UhB9GuLXR4D3b7PrzJHOLR7tuXHWmnpq/yMJQ86cFq4eZG1lOEcpa
 yz7wjE6DkXg0FWB2lKdPsvjfw5OLnvKdZXEjLsurIiszZAExWw0ycSIdB4Nh5BOzwQrG
 HFBMlFwfikjJ2g1ngZWi4N6FNMoZ3uZr0f+SFknHUSbFrt+tAYCT8Vv8O10A09pG4Jbi
 +BgVPZgLYr2Fwczx80tLk8omfH7jRG0jeDlxzuUlp64gVejo1VWo/HGhdW12r5H5KujF
 4lIFBWywg4p/cJ3bfAZBSt61S9iB/qoGobhsFCZE+u7Fd+vZhImZfIuAxt1NHfyr5dmK
 SD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bCin6TmgTSZWrgtfO6/BybfYU3ZQRUite8vCDBRZoh0=;
 b=mC1tIzRhAQW1xW4/UG3DMMXArYcbP+Sie0RFCqwlsgfG/8P5gKzjd3UAZa3ceCOo3r
 /Do3KQtJ8mczrFayi3iSxTOrF7EL6+kHLPR3CumhZ68AyG9yhIDPZhjTYXV98dqvGpHw
 6b7dT4IgB4CRIoRuj82MKae+2Za8zaBSEVXS3zcchHagNM/BiSU+Zva72ANUB6Gz2wh4
 qP6JDQPVK0QckuSLHXGBXSWUf2aEAg/jnKCzt13B6oipzLycgcChYmS5E5+50wzC8UZx
 EjVQ4EYZNi0VKaOsY8gdaHaSYfxGKaW21fRqp7BrfqpSY40J1YLRcIfcp2aefTkIEp3d
 oXcA==
X-Gm-Message-State: AOAM533li4AqdNU1nEvkhx6HXtpFFJc6W70mWw7mATabWfVFqkI3N70N
 hZj26dR/Frtbl4kpg52N+8gaR98+3O3klVftPCVfDg==
X-Google-Smtp-Source: ABdhPJwPblhMNoruxqo35v5uX6B3U+67Y5PP4TdGgzqC+ww6k1Wmg3iRQ4SmixoygJCeKis4Dana91XL9Ngohyc8IX4=
X-Received: by 2002:a9d:3443:: with SMTP id v61mr6693131otb.139.1597528761661; 
 Sat, 15 Aug 2020 14:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-27-frank.chang@sifive.com>
 <90f01984-54a4-2a56-c52f-d1f4332b39d4@linaro.org>
 <CAE_xrPiJRRV3FYtfve6LMOF6LNEYGfhmi9CiabxqUBEew9igLg@mail.gmail.com>
 <5706a1ca-1dd9-22cd-08ce-c70780111bfc@linaro.org>
 <CAE_xrPgSbzzJqHYTeSND4wQDJUMoMYPmmcH97VE6hRcxh2S54A@mail.gmail.com>
 <de85d715-924a-8156-7424-5c35fd585fb3@linaro.org>
In-Reply-To: <de85d715-924a-8156-7424-5c35fd585fb3@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Sun, 16 Aug 2020 05:59:12 +0800
Message-ID: <CAE_xrPiwcFCNaj0cBhWRo_uqPA7DgTOoxB5V6BgYQOXrMR6VTg@mail.gmail.com>
Subject: Re: [RFC v3 26/71] target/riscv: rvv-1.0: update vext_max_elems() for
 load/store insns
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005b929805acf1a63e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

--0000000000005b929805acf1a63e
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 15, 2020 at 1:29 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/14/20 7:52 PM, Frank Chang wrote:
> >     probe_pages(env, base + stride * i, nf * esz, ra, access_type);
> > and
> >     target_ulong addr = base + stride * i + k * esz;
> >
> > If we pass ctzl(sizeof(type)) in GEN_VEXT_LD_STRIDE(),
> > I would still have to do: (1 << esz) to get the correct element size in
> the
> > above calculations.
> > Would it eliminate the performance gain we have in vext_max_elems()
> instead?
>
> Well, no, it will improve performance, because you'll write
>
>   addr = base + stride * i + (k << esz)
>
> I.e. strength-reduce the multiply to a shift.
>
>
This works like a charm.
Thanks for the advice.

Frank Chang



> r~
>
>

--0000000000005b929805acf1a63e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Aug 15, 2020 at 1:29 PM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 8/14/20 7:52 PM, Frank Chang wr=
ote:<br>
&gt; =C2=A0 =C2=A0 probe_pages(env, base + stride * i, nf * esz, ra, access=
_type);<br>
&gt; and<br>
&gt; =C2=A0 =C2=A0 target_ulong addr =3D base + stride * i + k * esz;<br>
&gt; <br>
&gt; If we pass ctzl(sizeof(type)) in=C2=A0GEN_VEXT_LD_STRIDE(),<br>
&gt; I would still have to do: (1 &lt;&lt; esz) to get the correct element =
size in the<br>
&gt; above calculations.<br>
&gt; Would it eliminate the performance gain we have in=C2=A0vext_max_elems=
() instead?<br>
<br>
Well, no, it will improve performance, because you&#39;ll write<br>
<br>
=C2=A0 addr =3D base + stride * i + (k &lt;&lt; esz)<br>
<br>
I.e. strength-reduce the multiply to a shift.<br><br></blockquote><div><br>=
</div><div>This works like a charm.</div><div>Thanks for the advice.</div><=
div><br></div><div>Frank Chang=C2=A0</div><div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
r~<br>
<br>
</blockquote></div></div>

--0000000000005b929805acf1a63e--

