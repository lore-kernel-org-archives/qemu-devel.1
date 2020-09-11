Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA1EC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372F82220F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1Ii8Oek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372F82220F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGrfA-0008P4-0b
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 18:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGreZ-0007ze-0p
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:36:23 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:39941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGreW-00087y-Vl
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:36:22 -0400
Received: by mail-lj1-x231.google.com with SMTP id s205so13737651lja.7
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=pc77C24ZyDhQ4ArF6ns+Nm01U91KLnWyVi/WlXnVvA4=;
 b=k1Ii8OekMRPkhf/PDAxwJmJQ1nCcCbbnmfZLQtAjg+CK3SVKX0vQV/p2BzzfYgIz6D
 Gp4KhNiLq1NN4vuXyhe4/PfipyLcBLb0YxmkRSQSeFBQQjfRgfftEhymknP5XPCabM2f
 xzG4qx89f7N/gG9NhQkfbdDGEyZ/nljNG8bdBNKh04CIYuw0XO+8ycgZeOGF8fQM7gdx
 lo0b4inBg+I/Z5HMaSTL1kwT5J3i3p+atP9Dq3JBZmEU6xP/gUIkjHvxa5o1QtVtemZQ
 wLB345+2Fzts4mV1o6jLvMhssqXlZ7ow5m3GBVLNEFWew6VsicGT8PNIhxuOwKFbxPBH
 kEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=pc77C24ZyDhQ4ArF6ns+Nm01U91KLnWyVi/WlXnVvA4=;
 b=k5bhIkU73PDLZArwawb42XMK+Gm/Z8s4rWWGYT9LO1rQ0nL7NJDkR9VbZjaggsVolN
 unIvWZ0rv6mebS76LaeJmI0bE5VSSX4O5mF4mmj69Q1vzzdGSWhZlUT8s6QLrTwhFW3b
 IWGTdMvBmmjgZ2EPTg0HzxZgB97Rdtka6aNdXqRhb24wyugHF2IGD6LdmYO05pDhlxvD
 vnGzqhPAgikgr+0hatdwwCWwJW3eiH2fZLhyYg6PAwGb9fTMbXmD8wjuAuukl4Rko+zG
 pHeYdZ5hV6dY+sES29fRrHJ92VujZFLnKX/ulhvPNidivLTomhhAwi9upe/skYkuHVsA
 v5fA==
X-Gm-Message-State: AOAM5318YGg5NN59nBIp5Ev1Lh4ffyck62C2gWhZNilDrs6Z1ruuJ/uN
 cmNe0O0IIal8q5h9DZ4l4c2Fkab6tmrApTpORoQ=
X-Google-Smtp-Source: ABdhPJwKYuN8J6JXpd4l3pBWzNeiEKXLwWXy3341/84PE5oRftUOA5yYUZwYzUWXVL9uuayJqAeIhTkaFzb5bXknIeM=
X-Received: by 2002:a2e:8983:: with SMTP id c3mr1577385lji.171.1599863777910; 
 Fri, 11 Sep 2020 15:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8yfPdJLmek=+1VOWY4DQGP0yhmbtTiARw+qMuENKet+w@mail.gmail.com>
 <bb48e978-71e3-8ea8-44da-36c7d540ec1b@linaro.org>
In-Reply-To: <bb48e978-71e3-8ea8-44da-36c7d540ec1b@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 12 Sep 2020 06:36:05 +0800
Message-ID: <CAE2XoE9CcU+Jxz_s3wCH3i7TbXLEQcZrrnR4ohn1V9fJ96eS+g@mail.gmail.com>
Subject: Re: qemu disassembler status
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002be54e05af115001"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x231.google.com
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
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002be54e05af115001
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2020 at 5:52 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Taking this to the mailing list, since there are others who have expresse=
d
> interest in the topic.
>
>
> On 9/7/20 11:36 AM, Peter Maydell wrote:
> > Hi; I have a feeling we've discussed this on irc at some point
> > in the past, but I've forgotten the details, so I figured if I
> > wrote an email I might be able to find it again later...
> >
> > So, currently we have:
> >  * some disassemblers in the tree (old binutils, and some other
> >    things)
> >  * in particular one of those is the aarch64 libvixl, which is
> >    3rd-party code that we occasionally manually import/update
> >  * capstone, which is a submodule
> >
> > Am I right in thinking that you've suggested that ideally we should
> > use libllvm directly as our disassembler (with the hope that that
> > will have better coverage of different architectures and be more
> > up-to-date than capstone)?
>
> I've spent a couple of days poking at the llvm disassembler.
>
> As a general-purpose disassembler, it's less than ideal.
>
> (1) The disassembler is not "inclusive".  You present it with
>     a specific cpu configuration, and anything that cpu does
>     not support is considered invalid.  There is no "maximum"
>     configuration that attempts to decode any insn in the ISA.
>
> (2) All configuration is done via strings, so you can't
>     programatically tell what's supported.  I think they're
>     expecting all of these strings to come from the
>     command line.
>
> (3) If you include a unrecognized cpu feature, an error is
>     printed to stderr.  Which suggests that we would easily
>     wind up with problems between llvm versions.
>
> (4) "Probing" what is supported with a particular version is
>     done via "+help", which prints what is supported to stdout.
>
>
> >> For llvm, I would most definitely not use a submodule.  Disassembly is
> for
> >> developers, not end users, and I think we can insist on support
> libraries being
> >> installed.
> >
> > Disassembly is for end users too.  I think we need a submodule.
> > (This also means we can have newer versions than whatever
> > Ubuntu LTS ships so we get useful disassembly for architecture
> > extensions that postdate that.)
>
> If we have a submodule, is it possible to have a local branch of that?  T=
he
> only thing I can see that would fix any of the above is to modify llvm to
> give
> us a more usable interface.
>
> In the short-term, I guess I'll look into updating our capstone branch.
> And
> possibly reject using the system version -- either use the git submodule =
or
> nothing.
>
I agree with this, use git submodule or nothing, to maintain less things
and have consistence experience

>
> Thoughts?
>
>
> r~
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000002be54e05af115001
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 12, 2020 at 5:52 AM Richa=
rd Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.he=
nderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Taking this to the mailing list, since there are others w=
ho have expressed<br>
interest in the topic.<br>
<br>
<br>
On 9/7/20 11:36 AM, Peter Maydell wrote:<br>
&gt; Hi; I have a feeling we&#39;ve discussed this on irc at some point<br>
&gt; in the past, but I&#39;ve forgotten the details, so I figured if I<br>
&gt; wrote an email I might be able to find it again later...<br>
&gt; <br>
&gt; So, currently we have:<br>
&gt;=C2=A0 * some disassemblers in the tree (old binutils, and some other<b=
r>
&gt;=C2=A0 =C2=A0 things)<br>
&gt;=C2=A0 * in particular one of those is the aarch64 libvixl, which is<br=
>
&gt;=C2=A0 =C2=A0 3rd-party code that we occasionally manually import/updat=
e<br>
&gt;=C2=A0 * capstone, which is a submodule<br>
&gt; <br>
&gt; Am I right in thinking that you&#39;ve suggested that ideally we shoul=
d<br>
&gt; use libllvm directly as our disassembler (with the hope that that<br>
&gt; will have better coverage of different architectures and be more<br>
&gt; up-to-date than capstone)?<br>
<br>
I&#39;ve spent a couple of days poking at the llvm disassembler.<br>
<br>
As a general-purpose disassembler, it&#39;s less than ideal.<br>
<br>
(1) The disassembler is not &quot;inclusive&quot;.=C2=A0 You present it wit=
h<br>
=C2=A0 =C2=A0 a specific cpu configuration, and anything that cpu does<br>
=C2=A0 =C2=A0 not support is considered invalid.=C2=A0 There is no &quot;ma=
ximum&quot;<br>
=C2=A0 =C2=A0 configuration that attempts to decode any insn in the ISA.<br=
>
<br>
(2) All configuration is done via strings, so you can&#39;t<br>
=C2=A0 =C2=A0 programatically tell what&#39;s supported.=C2=A0 I think they=
&#39;re<br>
=C2=A0 =C2=A0 expecting all of these strings to come from the<br>
=C2=A0 =C2=A0 command line.<br>
<br>
(3) If you include a unrecognized cpu feature, an error is<br>
=C2=A0 =C2=A0 printed to stderr.=C2=A0 Which suggests that we would easily<=
br>
=C2=A0 =C2=A0 wind up with problems between llvm versions.<br>
<br>
(4) &quot;Probing&quot; what is supported with a particular version is<br>
=C2=A0 =C2=A0 done via &quot;+help&quot;, which prints what is supported to=
 stdout.<br>
<br>
<br>
&gt;&gt; For llvm, I would most definitely not use a submodule.=C2=A0 Disas=
sembly is for<br>
&gt;&gt; developers, not end users, and I think we can insist on support li=
braries being<br>
&gt;&gt; installed.<br>
&gt; <br>
&gt; Disassembly is for end users too.=C2=A0 I think we need a submodule.<b=
r>
&gt; (This also means we can have newer versions than whatever<br>
&gt; Ubuntu LTS ships so we get useful disassembly for architecture<br>
&gt; extensions that postdate that.)<br>
<br>
If we have a submodule, is it possible to have a local branch of that?=C2=
=A0 The<br>
only thing I can see that would fix any of the above is to modify llvm to g=
ive<br>
us a more usable interface.<br>
<br>
In the short-term, I guess I&#39;ll look into updating our capstone branch.=
=C2=A0 And<br>
possibly reject using the system version -- either use the git submodule or=
<br>
nothing.<br></blockquote><div>I agree with this, use git submodule or nothi=
ng, to maintain less things and have consistence experience=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thoughts?<br>
<br>
<br>
r~<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000002be54e05af115001--

