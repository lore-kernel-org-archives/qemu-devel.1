Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD2C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 10:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8305214D8
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 10:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJWspbo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8305214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH2cY-0002RZ-Or
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 06:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kH2bu-0001g5-TO
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 06:18:22 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a]:40173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kH2be-0006Xx-0O
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 06:18:22 -0400
Received: by mail-lf1-x12a.google.com with SMTP id m5so8376897lfp.7
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 03:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=hWhMdcBhOXPCVkzyCvCNIzneevGqddAu6pbGGNyQtf4=;
 b=OJWspbo7DKm6IisSeDm9EecC7jKV2rLbjxJl9FZnySNrthH9a5kW3kchpBk9E0kQhF
 qIEZVNQ6/eYaF88Fp+64uyui16rW4k3nIA0znpQa/jxN8ZNnAhip2SiJhMJh2voICvmr
 9/szMrQ9yErRSfaJVJYlFBUVPZFimCLO/SS8m5jcQNNBG1+FR3Da2umrqO8LKRhoAgsl
 LzUGCAdtOLE8/ejXFuFu9NNDhCzI2dCmDhIWGM/rcDaj9qUZroaT16as7xrU05l3aKyS
 adaSdv8DZYY81rTodXM6S3sLbGm/KLSu/rxgAVTlaNaEYjklRSXZM+RDrsBIsmQ4pdNi
 Fhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=hWhMdcBhOXPCVkzyCvCNIzneevGqddAu6pbGGNyQtf4=;
 b=ETtSsfzizKfid1Umw/th/G+RCv7tkr+7VlppOkybHYmitL3KJ46LfOoNHGztkovgRB
 0GZD8vqja3QYlpqqqnfcACKK8uZFlo1wy9vzOJBdgKQWQ9ooEBRsVn6HEB+OBUYDcjRO
 zofqUBPeugMwugC2ywAuZ6CgQiFa4qovULUg/ib8mU3Zv5CfalcSywie/cWN5nXPE0l0
 pbQbSCfrOfta3XCGYRCwk1HD3UYLqgwJJtbUy6ryMoO8nS5o0vGL/pLbRyOdaB3z2GMd
 QVzuXzJ0Ni6bQKX+lQ7AtoBQFlGQoBVqXlS7b79KJlegyrBXaHeFGuhA1sz7PWbUm/Ob
 gN9Q==
X-Gm-Message-State: AOAM532K8hogrfQthjfN5rJ9T5IvnqOlPOt4ljAkuworRwKB6WrrYyi0
 vN7PXXqAwFbpLNVePEL4n62TGfsXCOFEYhlqPFU=
X-Google-Smtp-Source: ABdhPJwzkscC0yttJtE4RLkPG5HXMuqU5bb89L1Acb56g5Fv+1gl9XM4FpXn0kzh80jNWeOzJPyJtoa66LlDC5TOe4o=
X-Received: by 2002:a19:674f:: with SMTP id e15mr1865334lfj.50.1599905884098; 
 Sat, 12 Sep 2020 03:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8yfPdJLmek=+1VOWY4DQGP0yhmbtTiARw+qMuENKet+w@mail.gmail.com>
 <bb48e978-71e3-8ea8-44da-36c7d540ec1b@linaro.org>
 <952fa7ef-a4b8-3945-dfe7-803cbdc35834@redhat.com>
In-Reply-To: <952fa7ef-a4b8-3945-dfe7-803cbdc35834@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 12 Sep 2020 18:17:52 +0800
Message-ID: <CAE2XoE-bC9A0D_kO4q4rJRWOhnLGqOBXOaD=61KEKFOr6Yq73w@mail.gmail.com>
Subject: Re: qemu disassembler status
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e5568405af1b1d87"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e5568405af1b1d87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2020 at 3:04 PM Thomas Huth <thuth@redhat.com> wrote:

> On 11/09/2020 23.50, Richard Henderson wrote:
> > Taking this to the mailing list, since there are others who have
> expressed
> > interest in the topic.
> >
> >
> > On 9/7/20 11:36 AM, Peter Maydell wrote:
> >> Hi; I have a feeling we've discussed this on irc at some point
> >> in the past, but I've forgotten the details, so I figured if I
> >> wrote an email I might be able to find it again later...
> >>
> >> So, currently we have:
> >>  * some disassemblers in the tree (old binutils, and some other
> >>    things)
> >>  * in particular one of those is the aarch64 libvixl, which is
> >>    3rd-party code that we occasionally manually import/update
> >>  * capstone, which is a submodule
> >>
> >> Am I right in thinking that you've suggested that ideally we should
> >> use libllvm directly as our disassembler (with the hope that that
> >> will have better coverage of different architectures and be more
> >> up-to-date than capstone)?
> >
> > I've spent a couple of days poking at the llvm disassembler.
> >
> > As a general-purpose disassembler, it's less than ideal.
> >
> > (1) The disassembler is not "inclusive".  You present it with
> >     a specific cpu configuration, and anything that cpu does
> >     not support is considered invalid.  There is no "maximum"
> >     configuration that attempts to decode any insn in the ISA.
> >
> > (2) All configuration is done via strings, so you can't
> >     programatically tell what's supported.  I think they're
> >     expecting all of these strings to come from the
> >     command line.
> >
> > (3) If you include a unrecognized cpu feature, an error is
> >     printed to stderr.  Which suggests that we would easily
> >     wind up with problems between llvm versions.
> >
> > (4) "Probing" what is supported with a particular version is
> >     done via "+help", which prints what is supported to stdout.
>
> Ouch, that sounds ugly, indeed.
>
> > In the short-term, I guess I'll look into updating our capstone branch.
> And
> > possibly reject using the system version -- either use the git submodul=
e
> or
> > nothing.
>
> Sounds like the best option right now.
>
> Is capstone good enough already to replace libvixl?
>
> And what about the other old disassemblers that we have in disasm/ ?
> Could some of them be replaced by capstone, too?
> Or shall we try to pursue the idea of adding a GPLv3 helper program that
> could link against recent versions of libopcode?
>
> And what about new disassembler files like the Loongson 2F disassembler
> that has been proposed two months ago? Shall we enforce that people try
> to add such stuff to capstone first?
>
less is more, enforce people to add such stull to capstone is a good idea,
unless there is a
better altrenative than capstone

>
>  Thomas
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000e5568405af1b1d87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 12, 2020 at 3:04 PM Thoma=
s Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 11/09/202=
0 23.50, Richard Henderson wrote:<br>
&gt; Taking this to the mailing list, since there are others who have expre=
ssed<br>
&gt; interest in the topic.<br>
&gt; <br>
&gt; <br>
&gt; On 9/7/20 11:36 AM, Peter Maydell wrote:<br>
&gt;&gt; Hi; I have a feeling we&#39;ve discussed this on irc at some point=
<br>
&gt;&gt; in the past, but I&#39;ve forgotten the details, so I figured if I=
<br>
&gt;&gt; wrote an email I might be able to find it again later...<br>
&gt;&gt;<br>
&gt;&gt; So, currently we have:<br>
&gt;&gt;=C2=A0 * some disassemblers in the tree (old binutils, and some oth=
er<br>
&gt;&gt;=C2=A0 =C2=A0 things)<br>
&gt;&gt;=C2=A0 * in particular one of those is the aarch64 libvixl, which i=
s<br>
&gt;&gt;=C2=A0 =C2=A0 3rd-party code that we occasionally manually import/u=
pdate<br>
&gt;&gt;=C2=A0 * capstone, which is a submodule<br>
&gt;&gt;<br>
&gt;&gt; Am I right in thinking that you&#39;ve suggested that ideally we s=
hould<br>
&gt;&gt; use libllvm directly as our disassembler (with the hope that that<=
br>
&gt;&gt; will have better coverage of different architectures and be more<b=
r>
&gt;&gt; up-to-date than capstone)?<br>
&gt; <br>
&gt; I&#39;ve spent a couple of days poking at the llvm disassembler.<br>
&gt; <br>
&gt; As a general-purpose disassembler, it&#39;s less than ideal.<br>
&gt; <br>
&gt; (1) The disassembler is not &quot;inclusive&quot;.=C2=A0 You present i=
t with<br>
&gt;=C2=A0 =C2=A0 =C2=A0a specific cpu configuration, and anything that cpu=
 does<br>
&gt;=C2=A0 =C2=A0 =C2=A0not support is considered invalid.=C2=A0 There is n=
o &quot;maximum&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0configuration that attempts to decode any insn in t=
he ISA.<br>
&gt; <br>
&gt; (2) All configuration is done via strings, so you can&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0programatically tell what&#39;s supported.=C2=A0 I =
think they&#39;re<br>
&gt;=C2=A0 =C2=A0 =C2=A0expecting all of these strings to come from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0command line.<br>
&gt; <br>
&gt; (3) If you include a unrecognized cpu feature, an error is<br>
&gt;=C2=A0 =C2=A0 =C2=A0printed to stderr.=C2=A0 Which suggests that we wou=
ld easily<br>
&gt;=C2=A0 =C2=A0 =C2=A0wind up with problems between llvm versions.<br>
&gt; <br>
&gt; (4) &quot;Probing&quot; what is supported with a particular version is=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0done via &quot;+help&quot;, which prints what is su=
pported to stdout.<br>
<br>
Ouch, that sounds ugly, indeed.<br>
<br>
&gt; In the short-term, I guess I&#39;ll look into updating our capstone br=
anch.=C2=A0 And<br>
&gt; possibly reject using the system version -- either use the git submodu=
le or<br>
&gt; nothing.<br>
<br>
Sounds like the best option right now.<br>
<br>
Is capstone good enough already to replace libvixl?<br>
<br>
And what about the other old disassemblers that we have in disasm/ ?<br>
Could some of them be replaced by capstone, too?<br>
Or shall we try to pursue the idea of adding a GPLv3 helper program that<br=
>
could link against recent versions of libopcode?<br>
<br>
And what about new disassembler files like the Loongson 2F disassembler<br>
that has been proposed two months ago? Shall we enforce that people try<br>
to add such stuff to capstone first?<br></blockquote><div>less is more, enf=
orce people to add such stull to capstone is a good idea, unless there is a=
=C2=A0</div><div>better altrenative than capstone=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000e5568405af1b1d87--

