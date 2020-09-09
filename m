Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4086BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B59218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0mw0gX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B59218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG21X-0006Ow-3m
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG20H-0004bd-CZ; Wed, 09 Sep 2020 11:27:21 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG20F-0005yb-7A; Wed, 09 Sep 2020 11:27:21 -0400
Received: by mail-lj1-x243.google.com with SMTP id k25so4065010ljg.9;
 Wed, 09 Sep 2020 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=/orM2YQHOAKYTAFTJn4+vg2bhJBYDzxo1r6i3k0QpWE=;
 b=K0mw0gX/D3gf/YVZNgYOqApxZr1FlHfz9GYUMgxWEqmEYygyhRXeR60DdqH0PMDXNr
 a2E5NYp6TVqBgaEw/7/Qe3rzEg6sRuqLqdcIlytykuqp382/5fBCB86e70ZBFdH6OCdv
 MAsPXt7kQExvThFqdrb6MiYJoBFzo3XeKjXmHa0w1qDbSPyfP7N+vtrtqtq1HTX00QBQ
 640Tomt++D9yLTtWs+KFnwHLH4urbAUeC6exZjLg3dZgSqmNZDQ4vfg70SvYSD6S2zDN
 L+nP+wj1y/VHBHUsNlj23sf614b3jJsv/eP29VrZ+vtXqA/cNi3CXrouMhftY49cXjLX
 ouAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=/orM2YQHOAKYTAFTJn4+vg2bhJBYDzxo1r6i3k0QpWE=;
 b=Qi3mO6gliHZZsSrqi0UOZgaFc4wiiHvWwY9xjqnb9Li6fr8R8NWHGqgP75+S+DWjOa
 gx8+9HGHsn1fYrz/beNQ4wShqBkSQ1Wua4x2Yu3N7vmYSmCwxcxj9aR8XCiGhixpCFCl
 iSgfNLHKQ7L549++HLKRA08RsxMrNO62qVVcwATEjOR2mzttWWb/0jUSBuhBx4egk68g
 wnz+Di6Lf0IRkXol2u7W+3u2RyPbuGLtfFUYyxx5N2FzAiYHtQpCty3ngHaXtFYPnx1I
 CMVtnXcKRmwNULPF9SP+LCaAi3EplVHCUzkChuwOgwdVuj9TIVXB3WjsKdLU+xdGbcYG
 NQMA==
X-Gm-Message-State: AOAM5301Y/z4TdYaNK9L1yiUj4T0rnQp5ORuSOil4RYg/+B9jE2YzK/s
 jZtOweqmhLSUq4q+t8QJOq0w/2DVZuwL9iC2byc=
X-Google-Smtp-Source: ABdhPJxc9cO3058j9bFTfUM7ycqczFEKQCNLla0Y4fOOREf7g7/SIrTPH3jSQ7u/58FE4hcY9ATes13VZ65LbNMdqbw=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr2337818ljj.447.1599665236793; 
 Wed, 09 Sep 2020 08:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-3-luoyonggang@gmail.com>
 <20200909122658.GT1011023@redhat.com>
In-Reply-To: <20200909122658.GT1011023@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 23:27:06 +0800
Message-ID: <CAE2XoE9tf01jZYt-BJBS4tdJWaJPOROJ0TCXGibQ_q1kkrL3RA@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] ci: fixes msys2 build by upgrading capstone to
 4.0.2
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000032deac05aee316db"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000032deac05aee316db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 8:27 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Wed, Sep 09, 2020 at 05:45:58PM +0800, Yonggang Luo wrote:
> > The currently random version capstone have the following compiling issu=
e:
> >   CC      /c/work/xemu/qemu/build/slirp/src/arp_table.o
> > make[1]: *** No rule to make target
> =E2=80=9C/c/work/xemu/qemu/build/capstone/capstone.lib=E2=80=9D=E3=80=82 =
Stop.
> >
> > Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1 are the
> tagged version 4.0.2
> > when upgrading to this version, the folder structure of include are
> changed to
> > qemu\capstone\include
> > =E2=94=82  platform.h
> > =E2=94=82
> > =E2=94=9C=E2=94=80capstone
> > =E2=94=82      arm.h
> > =E2=94=82      arm64.h
> > =E2=94=82      capstone.h
> > =E2=94=82      evm.h
> > =E2=94=82      m680x.h
> > =E2=94=82      m68k.h
> > =E2=94=82      mips.h
> > =E2=94=82      platform.h
> > =E2=94=82      ppc.h
> > =E2=94=82      sparc.h
> > =E2=94=82      systemz.h
> > =E2=94=82      tms320c64x.h
> > =E2=94=82      x86.h
> > =E2=94=82      xcore.h
> > =E2=94=82
> > =E2=94=94=E2=94=80windowsce
> >         intrin.h
> >         stdint.h
> >
> > in capstone. so we need add extra include path
> -I${source_path}/capstone/include/capstone
> > for directly #include <capstone.h>, and the exist include path should
> preserve, because
> > in capstone code there something like #include "capstone/capstone.h"
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  capstone  | 2 +-
> >  configure | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/capstone b/capstone
> > index 22ead3e0bf..1d23053284 160000
> > --- a/capstone
> > +++ b/capstone
> > @@ -1 +1 @@
> > -Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
> > +Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1
> > diff --git a/configure b/configure
> > index 4231d56bcc..f4f8bc3756 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5156,7 +5156,7 @@ case "$capstone" in
> >        LIBCAPSTONE=3Dlibcapstone.a
> >      fi
> >      capstone_libs=3D"-Lcapstone -lcapstone"
> > -    capstone_cflags=3D"-I${source_path}/capstone/include"
> > +    capstone_cflags=3D"-I${source_path}/capstone/include
> -I${source_path}/capstone/include/capstone"
>
> IIUC, the original -I arg can be removed - we just need the new one.
>
That's not correct, doing that will cause compiling failure
Please take a look at
https://cirrus-ci.com/task/6709042959613952?command=3Dmain#L384

>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000032deac05aee316db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 8:27 PM Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, Sep 09, 2020 at 05:45:58PM +0800, Yonggang Luo wrote:<br>
&gt; The currently random version capstone have the following compiling iss=
ue:<br>
&gt;=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 /c/work/xemu/qemu/build/slirp/src/a=
rp_table.o<br>
&gt; make[1]: *** No rule to make target =E2=80=9C/c/work/xemu/qemu/build/c=
apstone/capstone.lib=E2=80=9D=E3=80=82 Stop.<br>
&gt; <br>
&gt; Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1 are the tag=
ged version 4.0.2<br>
&gt; when upgrading to this version, the folder structure of include are ch=
anged to<br>
&gt; qemu\capstone\include<br>
&gt; =E2=94=82=C2=A0 platform.h<br>
&gt; =E2=94=82<br>
&gt; =E2=94=9C=E2=94=80capstone<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 arm.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 arm64.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 capstone.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 evm.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 m680x.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 m68k.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 mips.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 platform.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 ppc.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 sparc.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 systemz.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 tms320c64x.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 x86.h<br>
&gt; =E2=94=82=C2=A0 =C2=A0 =C2=A0 xcore.h<br>
&gt; =E2=94=82<br>
&gt; =E2=94=94=E2=94=80windowsce<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intrin.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdint.h<br>
&gt; <br>
&gt; in capstone. so we need add extra include path -I${source_path}/capsto=
ne/include/capstone<br>
&gt; for directly #include &lt;capstone.h&gt;, and the exist include path s=
hould preserve, because<br>
&gt; in capstone code there something like #include &quot;capstone/capstone=
.h&quot;<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 capstone=C2=A0 | 2 +-<br>
&gt;=C2=A0 configure | 2 +-<br>
&gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/capstone b/capstone<br>
&gt; index 22ead3e0bf..1d23053284 160000<br>
&gt; --- a/capstone<br>
&gt; +++ b/capstone<br>
&gt; @@ -1 +1 @@<br>
&gt; -Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf<br>
&gt; +Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1<br>
&gt; diff --git a/configure b/configure<br>
&gt; index 4231d56bcc..f4f8bc3756 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -5156,7 +5156,7 @@ case &quot;$capstone&quot; in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 LIBCAPSTONE=3Dlibcapstone.a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 capstone_libs=3D&quot;-Lcapstone -lcapstone&quot;<=
br>
&gt; -=C2=A0 =C2=A0 capstone_cflags=3D&quot;-I${source_path}/capstone/inclu=
de&quot;<br>
&gt; +=C2=A0 =C2=A0 capstone_cflags=3D&quot;-I${source_path}/capstone/inclu=
de -I${source_path}/capstone/include/capstone&quot;<br>
<br>
IIUC, the original -I arg can be removed - we just need the new one.<br></b=
lockquote><div>That&#39;s not correct, doing that will cause compiling fail=
ure</div><div>Please take a look at</div><div><a href=3D"https://cirrus-ci.=
com/task/6709042959613952?command=3Dmain#L384">https://cirrus-ci.com/task/6=
709042959613952?command=3Dmain#L384</a>=C2=A0<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000032deac05aee316db--

