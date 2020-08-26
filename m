Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CDEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F33F2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaXgjOfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F33F2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxYN-0007M3-OX
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxWR-0005ic-Mx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:39:35 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxWM-0007jR-T7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:39:35 -0400
Received: by mail-lj1-x241.google.com with SMTP id m22so2886975ljj.5
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=8SX75HD5juJFAqla4kaWWrtF2jtCzcfDSK5N15Z+y6E=;
 b=LaXgjOfkmR3O0Qdis5+uQx74tsJlkZ3yBG7yOfnka6FRKT+qG9ao7Jjvh1NmkpYE7y
 KIU9j3kfLTvThCqjuryF/KcV1GKga8KCxCqPXbumD2bcor0abF8T4G22Lz2vmBYgw1Xn
 EVZFsTS3pzWA8dUG5fSuG75Mf/5iSPCG3Z1jl8CRGhT3ZCy/W8dgUjhkD1mNw7Cd+cgS
 cUV50tpaFoSTxZooCsBArWz6LR9IP/3o+nDGqMrvlOPVSeYRzikBL9ESTC7tZzknjLmR
 xw7/CZnwe32lg8cSNFkfD/JIeOj6heLlY+90fN0lygECXAceUAi1NyJ5KIX6Rg7SvWTj
 xrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=8SX75HD5juJFAqla4kaWWrtF2jtCzcfDSK5N15Z+y6E=;
 b=W4W2+g01Z2OG3zaeaw8MPXuNmuSYa4IS3nDYnZbJGhK4Wslqrrm+vGrH95OM0t0dMi
 0ZweST102ktRV37TQ7ioHPuPhg7liPMGfCL17clIIpS0lUaODfMvYA+NnQVUrOA5vw2r
 XXG9JLKFIlLabJdFUjAh1WxB11BMAYAqeXxegdc5a/TyGt6RRH5H0Zro97Ur9qy7rSCm
 v3JGrhvQxfrV6vzM3XAqB3uC1/A2csXvdE8EVK01T9xl45PSdLNF6rQ7yEEyu8UdvS1h
 3g2TKUf3WGIh3FqAiAFSAr805srGxGyPJh48mnP1s9GAmrfhMtWYNGrJ0y7m+qB7HiUL
 tivg==
X-Gm-Message-State: AOAM530xEZ+FNGem/tibet3fTVn0QiIZ7oS/DjM5qD6LWVbKBi7Kf20i
 2nwBRx+PhY0kO33tYOvLUISrhyvReGnD5mNumW0=
X-Google-Smtp-Source: ABdhPJwexyvz0cJeveXwh9/hdIKSA6/tr2LWOTNmfEkyLoVz/1gFd8AKE7l+6/X0Rr11GQcL2umtI+M6u30MnEccaQs=
X-Received: by 2002:a2e:7315:: with SMTP id o21mr805144ljc.120.1598456369236; 
 Wed, 26 Aug 2020 08:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
 <CAE2XoE-JKpqQj7H3wMt0+WNTBR1JS6ZyiLOhqOYkaVj5Zzgp5A@mail.gmail.com>
 <CABgObfYk8zG3TBB3UZhvmZLGqLO+bZF+AmL6hSQkCgiCKKW4ug@mail.gmail.com>
In-Reply-To: <CABgObfYk8zG3TBB3UZhvmZLGqLO+bZF+AmL6hSQkCgiCKKW4ug@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 26 Aug 2020 23:39:17 +0800
Message-ID: <CAE2XoE-U6Ls9gMSSDB4Qajn-m0vrBBP-+C0K4tncvzzr3Nwq9w@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000013cec705adc9a019"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000013cec705adc9a019
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 11:37 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Wed, Aug 26, 2020 at 5:31 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 <luoyonggang@gmail.com>
> wrote:
> >
> > I can tell you build.ninja can contains $: symbol, that's the escape fo=
r
> Ninja,
> > when ninjatool parse it, it will convert $: -> :, so that's not a
> problem.
> > This is part of the build.ninja on my computer
>
> Ok, that's useful. But can you just send the whole file (it's huge but
> you can gzip it or something similar)?
>
> Paolo
>
I am OK with that, but where should I post

>
> > ```
> > build version.rc_version.o: CUSTOM_COMMAND_DEP ../qemu.org/version.rc |
> C$:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE ../
> qemu.org/pc-bios/qemu-nsis.ico
> >  DEPFILE =3D "version.rc_version.o.d"
> >  DEPFILE_UNQUOTED =3D version.rc_version.o.d
> >  COMMAND =3D
> "C:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE" "-I./."
> "-I../qemu.org/." "../qemu.org/version.rc" "version.rc_version.o"
> "--preprocessor-arg=3D-MD" "--preprocessor-arg=3D-MQversion.rc_version.o"
> "--preprocessor-arg=3D-MFversion.rc_version.o.d"
> >  description =3D Generating$ Windows$ resource$ for$ file$ 'version.rc'=
$
> with$ a$ custom$ command
> > ```
> >
> > On Wed, Aug 26, 2020 at 11:28 PM Paolo Bonzini <pbonzini@redhat.com>
> wrote:
> >>
> >> On Wed, Aug 26, 2020 at 5:12 PM <luoyonggang@gmail.com> wrote:
> >> >
> >> > From: Yonggang Luo <luoyonggang@gmail.com>
> >> >
> >> > SIMPLE_PATH_RE should match the full path token.
> >> > Or the $ and : contained in path would not matched if the path are
> start with C:/ and E:/
> >>
> >> I don't understand this, SIMPLE_PATH_RE is used with re.match which
> >> only matches at the beginning of the string. Can you send me your
> >> build.ninja file offlist?
> >>
> >> Thanks,
> >>
> >> Paolo
> >>
> >
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000013cec705adc9a019
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 11:37 PM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Wed, Aug 26, 2020 at 5:31 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;=
<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmai=
l.com</a>&gt; wrote:<br>
&gt;<br>
&gt; I can tell you build.ninja can contains $: symbol, that&#39;s the esca=
pe for Ninja,<br>
&gt; when ninjatool parse it, it will convert $: -&gt; :, so that&#39;s not=
 a problem.<br>
&gt; This is part of the build.ninja on my computer<br>
<br>
Ok, that&#39;s useful. But can you just send the whole file (it&#39;s huge =
but<br>
you can gzip it or something similar)?<br>
<br>
Paolo<br></blockquote><div>I am OK with that, but where should I post=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; ```<br>
&gt; build version.rc_version.o: CUSTOM_COMMAND_DEP ../<a href=3D"http://qe=
mu.org/version.rc" rel=3D"noreferrer" target=3D"_blank">qemu.org/version.rc=
</a> | C$:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE ../<a=
 href=3D"http://qemu.org/pc-bios/qemu-nsis.ico" rel=3D"noreferrer" target=
=3D"_blank">qemu.org/pc-bios/qemu-nsis.ico</a><br>
&gt;=C2=A0 DEPFILE =3D &quot;version.rc_version.o.d&quot;<br>
&gt;=C2=A0 DEPFILE_UNQUOTED =3D version.rc_version.o.d<br>
&gt;=C2=A0 COMMAND =3D &quot;C:/CI-Tools/msys64/mingw64/bin/x86_64-w64-ming=
w32-windres.EXE&quot; &quot;-I./.&quot; &quot;-I../<a href=3D"http://qemu.o=
rg/" rel=3D"noreferrer" target=3D"_blank">qemu.org/</a>.&quot; &quot;../<a =
href=3D"http://qemu.org/version.rc" rel=3D"noreferrer" target=3D"_blank">qe=
mu.org/version.rc</a>&quot; &quot;version.rc_version.o&quot; &quot;--prepro=
cessor-arg=3D-MD&quot; &quot;--preprocessor-arg=3D-MQversion.rc_version.o&q=
uot; &quot;--preprocessor-arg=3D-MFversion.rc_version.o.d&quot;<br>
&gt;=C2=A0 description =3D Generating$ Windows$ resource$ for$ file$ &#39;v=
ersion.rc&#39;$ with$ a$ custom$ command<br>
&gt; ```<br>
&gt;<br>
&gt; On Wed, Aug 26, 2020 at 11:28 PM Paolo Bonzini &lt;<a href=3D"mailto:p=
bonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br=
>
&gt;&gt;<br>
&gt;&gt; On Wed, Aug 26, 2020 at 5:12 PM &lt;<a href=3D"mailto:luoyonggang@=
gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; From: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; SIMPLE_PATH_RE should match the full path token.<br>
&gt;&gt; &gt; Or the $ and : contained in path would not matched if the pat=
h are start with C:/ and E:/<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t understand this, SIMPLE_PATH_RE is used with re.match =
which<br>
&gt;&gt; only matches at the beginning of the string. Can you send me your<=
br>
&gt;&gt; build.ninja file offlist?<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt;<br>
&gt;&gt; Paolo<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =E6=AD=A4=E8=87=B4<br>
&gt; =E7=A4=BC<br>
&gt; =E7=BD=97=E5=8B=87=E5=88=9A<br>
&gt; Yours<br>
&gt;=C2=A0 =C2=A0 =C2=A0sincerely,<br>
&gt; Yonggang Luo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000013cec705adc9a019--

