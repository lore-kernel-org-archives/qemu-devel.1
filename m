Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFFCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4540F20771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f2PjZbSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4540F20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6VaY-0008St-D2
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k6VZI-0007v0-DL
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:00:08 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:35505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k6VZF-0008Ar-8Y
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:00:07 -0400
Received: by mail-io1-xd44.google.com with SMTP id s189so10136062iod.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wNl7MW7UNuWUgtIFdq+w147P+AyRH+CrZHAmp2fodZ4=;
 b=f2PjZbSUefG9AcR3E2PNE6CqJeDtWMAqL8SAbxYUtanm/n3zzaPosRj2lkZ64t2OSu
 Qsibdahcb3isQ63AH18+V7ZbmTFRmtUyoSAoWK3S/DnudXWJzPLGBZrSWylSvhC4cgBT
 Au03hKZfDXWxjR9JlGzPbN/b3dpYwLQr8rWlgxwLYcVYH/1lWN5+7NhjlNXDJ/bGRha0
 Vr4Wa6pCyLT54USN8edKWChD+PgrmGiSmNR0F+KI0HvMksJA7Tte+2x/czbHeJFF7jSs
 Sqw1zD+nV64B8WKvusJPHAN4vgvhzeTQQ7s3qn+l4dgIReJA7zGZ8cEofRXTQpsj1YRQ
 DEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wNl7MW7UNuWUgtIFdq+w147P+AyRH+CrZHAmp2fodZ4=;
 b=GNoPP4G6da0vSk1j6HnVXQaMlgC2mSPUoHGJ7Z/9Pl4l8ki8HxgoaJuBZlK5OOaGNr
 c0ENIr8wQ0uUol3D43JyOX0iftbbEM0k8xvOwHvy9pKkMma9FLf4AuAWlpBz4xo98aFz
 /ZNuZk8O3fwAy+L3EoengAGDwvwWFxpHVz3VcjKyg4RG7WCihYnG12wEAEGA2w/Y1Eny
 YJQOLbrp3gWcKSF/mHfDBaNGkvR8oUb0t5agYO9JWQz/t6O8pxNG71pAHCZ8rhGHLh4E
 687vlMaN6hHlAoHUxuzjU53Ri8ravQQRzKIT123THl1loOdwU0SaeCiWi4eg6Fo2IJ4C
 WubQ==
X-Gm-Message-State: AOAM530O2Ko/fZm/YuTJ6hRkEHopvQ0Mdgls8g6BKFCXJ/RDcpJO2si1
 qaKPmJMGpjWaDpfygvO2A+In8Zw202yrOlS2q8SPTg==
X-Google-Smtp-Source: ABdhPJwilnTYuHbw6YbWyxmaWNs9M2bR5g0Z6eDTAm6A2A9t/p1KBfvPK+FMGWltY7MW3lt/W/kTZEALVvjV0YDemNE=
X-Received: by 2002:a05:6602:cb:: with SMTP id
 z11mr1351179ioe.96.1597395603968; 
 Fri, 14 Aug 2020 02:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com>
 <1596102747-20226-3-git-send-email-chihmin.chao@sifive.com>
 <aa334be5-e325-8d96-a3ee-00c82cfe2c4d@linaro.org>
In-Reply-To: <aa334be5-e325-8d96-a3ee-00c82cfe2c4d@linaro.org>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Fri, 14 Aug 2020 16:59:53 +0800
Message-ID: <CAEiOBXXOj5TcseHqpCaB-vR=3wFquP2ScjKGSrPXombesyD1jg@mail.gmail.com>
Subject: Re: [PATCH 2/3] softfloat: add APIs to handle alternative sNaN
 propagation
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008a79fb05acd2a5dc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=chihmin.chao@sifive.com; helo=mail-io1-xd44.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008a79fb05acd2a5dc
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 14, 2020 at 1:21 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/30/20 2:52 AM, Chih-Min Chao wrote:
> > For "fmax/fmin ft0, ft1, ft2" and if one of the inputs is sNaN,
> >   The original logic
> >     return NaN and set invalid flag if ft1 == sNaN || ft2 == sNan
> >
> >   The alternative path
> >     set invalid flag if ft1 == sNaN || ft2 == sNaN
> >     return NaN if ft1 == sNaN && ft2 == sNaN
> >
> >    The ieee754 spec allows both implementation and some architecture such
> >    as riscv choose differenct defintion in two spec versions.
> >    (riscv-spec-v2.2 use original version, riscv-spec-20191213 changes to
> >     alternative)
> >
> > Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
>
> If both ft1 and ft2 are SNaN, surely the returned result is silenced?
> That is
> something that is handled by pick_nan, but is not handled here.
>
 Yes, it returns the default_nan, qNaN.


>
> Also, the patch subject should be modified to emphasize that this only
> applies
> to min/max and not propagation of all SNaN.
>
> Will be fixed in the next version.
By the way,  the other patches have been queued in softfloat-next.
Do I need to resend the other two patches in the next version or just this
one ?

Chih-Min Chao

>

>
> r~
>
>
>

--0000000000008a79fb05acd2a5dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 14, 2020 at 1:21 AM Richa=
rd Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"=
_blank">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On 7/30/20 2:52 AM, Chih-Min Chao wrote=
:<br>
&gt; For &quot;fmax/fmin ft0, ft1, ft2&quot; and if one of the inputs is sN=
aN,<br>
&gt;=C2=A0 =C2=A0The original logic<br>
&gt;=C2=A0 =C2=A0 =C2=A0return NaN and set invalid flag if ft1 =3D=3D sNaN =
|| ft2 =3D=3D sNan<br>
&gt; <br>
&gt;=C2=A0 =C2=A0The alternative path<br>
&gt;=C2=A0 =C2=A0 =C2=A0set invalid flag if ft1 =3D=3D sNaN || ft2 =3D=3D s=
NaN<br>
&gt;=C2=A0 =C2=A0 =C2=A0return NaN if ft1 =3D=3D sNaN &amp;&amp; ft2 =3D=3D=
 sNaN<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 The ieee754 spec allows both implementation and some arch=
itecture such<br>
&gt;=C2=A0 =C2=A0 as riscv choose differenct defintion in two spec versions=
.<br>
&gt;=C2=A0 =C2=A0 (riscv-spec-v2.2 use original version, riscv-spec-2019121=
3 changes to<br>
&gt;=C2=A0 =C2=A0 =C2=A0alternative)<br>
&gt; <br>
&gt; Signed-off-by: Chih-Min Chao &lt;<a href=3D"mailto:chihmin.chao@sifive=
.com" target=3D"_blank">chihmin.chao@sifive.com</a>&gt;<br>
<br>
If both ft1 and ft2 are SNaN, surely the returned result is silenced?=C2=A0=
 That is<br>
something that is handled by pick_nan, but is not handled here.<br></blockq=
uote><div>=C2=A0Yes, it returns the default_nan, qNaN.</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Also, the patch subject should be modified to emphasize that this only appl=
ies<br>
to min/max and not propagation of all SNaN.<br>
<br></blockquote><div>Will be fixed in the next version.</div><div>By the w=
ay,=C2=A0 the other patches have been queued in softfloat-next.=C2=A0</div>=
<div>Do I need to resend the other two patches in the next version or just =
this one ?</div><div><br></div><div>Chih-Min Chao</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"></blockquote><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
r~<br>
<br>
<br>
</blockquote></div></div>

--0000000000008a79fb05acd2a5dc--

