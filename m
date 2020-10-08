Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C68C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F4C215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfILuJMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F4C215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQS9M-0000Py-NB
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 05:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQS8M-0008Bh-GE; Thu, 08 Oct 2020 05:22:46 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:39482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQS8K-0004cT-Du; Thu, 08 Oct 2020 05:22:46 -0400
Received: by mail-il1-x144.google.com with SMTP id q1so5041347ilt.6;
 Thu, 08 Oct 2020 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3kQmNNinowxqs25Y82Hf1yjNnmYqEqa8fStyGACofeg=;
 b=HfILuJMd/XPU77x+99VbiReeXuOEHQBji4cfNLbyi3nchL0Ni0FZRZ6R0xWyGCfVMb
 V1FoJGZC1739S0n+cYIFxW3W5JUHe9QOoIbrTrqHgkAUnW7iTbDDQmXfaEPQI2Tov5SY
 ZtN1OxB/Tus9ZeDhlAWaw5UsRWjLxBrTo69BniLLf1/KVT4dfdsw/bS9D/L3UT4gMDUA
 rUbPXIuzE2wacn/5Mb6LYNfm3lm38v/b1l1s5y/uCdmLr9lU/aRTh7ZHrnWHf4FPZldN
 nAClFHmj5K+VjpFn9PPRGGPfsp1Yyo/GuiZ8/LQphuwtA0BIYMCv2+QwpjUCHfbJWJaI
 WICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3kQmNNinowxqs25Y82Hf1yjNnmYqEqa8fStyGACofeg=;
 b=nKQMTPuC1FQWSpIkLgBF/xyIy77zISqfmExmuek7yTQqukCpp/dBlSdvpT9jQa6+8d
 LSdtC3dBfRHKlNBMQh3djbIaJcR9AVwKvYYwCkkAkjNyv+8L6cdjhZ7P0iu4hpsEvSOu
 h5o1b7C6vmjOIRSvV7HyP4Jp9jsx6AC09tWQ4AGwsmD06gmoDZN0fG6RLiqD0E97PxZy
 4rxwaV0VlLD5iy7I1ib182QjodWjYfGiD1cuSE71JbMupng/4pWRL86CM8Y8XS4Sf7OV
 H8Q0eqAZ586ceAnbYZeJEQXtrinihZdxVwoCg6qMHZ5s4vc97KL7FAyKlCLs6iajFQDl
 HOEg==
X-Gm-Message-State: AOAM530vBJsKR6zWsEQnLkmXs8kqZbWocfb4PD4udlTLzTkzwSkVXCYr
 JAWA/7N3zaBgtK7RXUHA/jz1lZLk055s12opcFc=
X-Google-Smtp-Source: ABdhPJxCTyU6M9IxoilO4P8zkbVVtjd/ALpPR0j56WV8qwHq2FzBO7oqoOShmrMBrKVyfbePDGR88RLJMU6y8Y0W9O8=
X-Received: by 2002:a05:6e02:ca2:: with SMTP id 2mr5943870ilg.51.1602148963119; 
 Thu, 08 Oct 2020 02:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201008060528.68579-1-chetan4windows@gmail.com>
 <1c24b564-9870-10f9-ac37-c4ebfacc74f0@redhat.com>
In-Reply-To: <1c24b564-9870-10f9-ac37-c4ebfacc74f0@redhat.com>
From: Chetan <chetan4windows@gmail.com>
Date: Thu, 8 Oct 2020 14:52:30 +0530
Message-ID: <CAPPKfOE2bOYjCPQSqAfOnvqfYhY1d5hJE-1MqO1VsuQ8qqwgCQ@mail.gmail.com>
Subject: Re: [PATCH] Fixing LGPL version number
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d2f51c05b1255fd3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=chetan4windows@gmail.com; helo=mail-il1-x144.google.com
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d2f51c05b1255fd3
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 8, 2020 at 2:18 PM Thomas Huth <thuth@redhat.com> wrote:
>I'm also not sure whether it's legally possible to replace the license text
>without agreement of all authors of the file ... so better don't do a
global
>patch for that right now, start with one subsystem instead and see whether
>it gets accepted... or maybe we should only add the SPDX tags, without
>removing the license text? ... this all might require some more discussions
>first ...

I'll put those changes on hold then, for now.

On Thu, Oct 8, 2020 at 2:34 PM Thomas Huth <thuth@redhat.com> wrote:
>Phew, that's a pretty huge patch, could you maybe split it by subsystem /
>folder so that it is easier to review?

Sorry about that. Sure, I'll split the patch in different versions folder
wise.

>I'm not sure whether we should update the version in the files that just
say
>"LGPL" (and do not mention "Lesser") ... they could also refer to the GNU
>*Library* GPL instead, which was available as version 2 (in the sense of
2.0).
>Could you please drop the hunks for the files that only mention LGPL for
now?

Ok. I'll exclude the files which mention just LGPL in the revision.

Chetan.

On Thu, Oct 8, 2020 at 2:34 PM Thomas Huth <thuth@redhat.com> wrote:

> On 08/10/2020 08.05, Chetan Pant wrote:
> > There is no "version 2" of the "Lesser" General Public License. It is
> > either "GPL version 2.0" or "LGPL version 2.1". This patch replaces all
> > occurrences of "LGPL version 2" with "LGPL version 2.1" in comment
> section.
> >
> > Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
>
> Phew, that's a pretty huge patch, could you maybe split it by subsystem /
> folder so that it is easier to review?
>
> [...]
> > diff --git a/net/hub.h b/net/hub.h
> > index ce45f7b..83e33e4 100644
> > --- a/net/hub.h
> > +++ b/net/hub.h
> > @@ -7,7 +7,7 @@
> >   *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
> >   *  Zhi Yong Wu       <wuzhy@linux.vnet.ibm.com>
> >   *
> > - * This work is licensed under the terms of the GNU LGPL, version 2 or
> later.
> > + * This work is licensed under the terms of the GNU LGPL, version 2.1
> or later.
> >   * See the COPYING.LIB file in the top-level directory.
> >   *
> >   */
>
> I'm not sure whether we should update the version in the files that just
> say
> "LGPL" (and do not mention "Lesser") ... they could also refer to the GNU
> *Library* GPL instead, which was available as version 2 (in the sense of
> 2.0).
> Could you please drop the hunks for the files that only mention LGPL for
> now?
>
> > diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> > index d3e289e..da570e3 100644
> > --- a/target/i386/hvf/x86_emu.c
> > +++ b/target/i386/hvf/x86_emu.c
> > @@ -5,7 +5,7 @@
> >   * This program is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This program is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > @@ -23,7 +23,7 @@
> >  //  This library is free software; you can redistribute it and/or
> >  //  modify it under the terms of the GNU Lesser General Public
> >  //  License as published by the Free Software Foundation; either
> > -//  version 2 of the License, or (at your option) any later version.
> > +//  version 2.1 of the License, or (at your option) any later version.
> >  //
> >  //  This library is distributed in the hope that it will be useful,
> >  //  but WITHOUT ANY WARRANTY; without even the implied warranty of
>
> That's an interesting file - the license text shows up twice here... I
> wonder whether we could scratch one of the two... but that's also something
> for a separate patch, I think.
>
>  Thomas
>
>

--000000000000d2f51c05b1255fd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Oct 8, 2020 at 2:18 PM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com=
">thuth@redhat.com</a>&gt; wrote:</div></div>

</div><div dir=3D"ltr">
&gt;I&#39;m also not sure whether it&#39;s legally possible to replace the =
license text<br>
&gt;without agreement of all authors of the file ... so better don&#39;t do=
 a global<br>
&gt;patch for that right now, start with one subsystem instead and see whet=
her<br>
&gt;it gets accepted... or maybe we should only add the SPDX tags, without<=
br>
&gt;removing the license text? ... this all might require some more discuss=
ions<br>
&gt;first ...

</div><div><br></div><div>I&#39;ll put those changes on hold then, for now.=
<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">
On Thu, Oct 8, 2020 at 2:34 PM Thomas Huth &lt;<a href=3D"mailto:thuth@redh=
at.com">thuth@redhat.com</a>&gt; wrote: <br>&gt;Phew, that&#39;s a pretty h=
uge patch, could you maybe split it by subsystem /<br>
&gt;folder so that it is easier to review?

</div><div><br></div><div>Sorry about that. Sure, I&#39;ll split the patch =
in different versions folder wise.</div><div><br></div><div>
&gt;I&#39;m not sure whether we should update the version in the files that=
 just say<br>
&gt;&quot;LGPL&quot; (and do not mention &quot;Lesser&quot;) ... they could=
 also refer to the GNU<br>
&gt;*Library* GPL instead, which was available as version 2 (in the sense o=
f 2.0).<br>
&gt;Could you please drop the hunks for the files that only mention LGPL fo=
r now?

</div><div><br></div><div>Ok. I&#39;ll exclude the files which mention just=
 LGPL in the revision.<br></div><div><br></div><div>Chetan.</div><div><br><=
/div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Th=
u, Oct 8, 2020 at 2:34 PM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.co=
m">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 08/10/2020 08.05, Chetan Pant wrote:<br>
&gt; There is no &quot;version 2&quot; of the &quot;Lesser&quot; General Pu=
blic License. It is<br>
&gt; either &quot;GPL version 2.0&quot; or &quot;LGPL version 2.1&quot;. Th=
is patch replaces all<br>
&gt; occurrences of &quot;LGPL version 2&quot; with &quot;LGPL version 2.1&=
quot; in comment section.<br>
&gt; <br>
&gt; Signed-off-by: Chetan Pant &lt;<a href=3D"mailto:chetan4windows@gmail.=
com" target=3D"_blank">chetan4windows@gmail.com</a>&gt;<br>
<br>
Phew, that&#39;s a pretty huge patch, could you maybe split it by subsystem=
 /<br>
folder so that it is easier to review?<br>
<br>
[...]<br>
&gt; diff --git a/net/hub.h b/net/hub.h<br>
&gt; index ce45f7b..83e33e4 100644<br>
&gt; --- a/net/hub.h<br>
&gt; +++ b/net/hub.h<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;=C2=A0 =C2=A0*=C2=A0 Stefan Hajnoczi=C2=A0 =C2=A0&lt;<a href=3D"mailto:=
stefanha@linux.vnet.ibm.com" target=3D"_blank">stefanha@linux.vnet.ibm.com<=
/a>&gt;<br>
&gt;=C2=A0 =C2=A0*=C2=A0 Zhi Yong Wu=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=
=3D"mailto:wuzhy@linux.vnet.ibm.com" target=3D"_blank">wuzhy@linux.vnet.ibm=
.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This work is licensed under the terms of the GNU LGPL, version 2 o=
r later.<br>
&gt; + * This work is licensed under the terms of the GNU LGPL, version 2.1=
 or later.<br>
&gt;=C2=A0 =C2=A0* See the COPYING.LIB file in the top-level directory.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0*/<br>
<br>
I&#39;m not sure whether we should update the version in the files that jus=
t say<br>
&quot;LGPL&quot; (and do not mention &quot;Lesser&quot;) ... they could als=
o refer to the GNU<br>
*Library* GPL instead, which was available as version 2 (in the sense of 2.=
0).<br>
Could you please drop the hunks for the files that only mention LGPL for no=
w?<br>
<br>
&gt; diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c<br>
&gt; index d3e289e..da570e3 100644<br>
&gt; --- a/target/i386/hvf/x86_emu.c<br>
&gt; +++ b/target/i386/hvf/x86_emu.c<br>
&gt; @@ -5,7 +5,7 @@<br>
&gt;=C2=A0 =C2=A0* This program is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This program is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; @@ -23,7 +23,7 @@<br>
&gt;=C2=A0 //=C2=A0 This library is free software; you can redistribute it =
and/or<br>
&gt;=C2=A0 //=C2=A0 modify it under the terms of the GNU Lesser General Pub=
lic<br>
&gt;=C2=A0 //=C2=A0 License as published by the Free Software Foundation; e=
ither<br>
&gt; -//=C2=A0 version 2 of the License, or (at your option) any later vers=
ion.<br>
&gt; +//=C2=A0 version 2.1 of the License, or (at your option) any later ve=
rsion.<br>
&gt;=C2=A0 //<br>
&gt;=C2=A0 //=C2=A0 This library is distributed in the hope that it will be=
 useful,<br>
&gt;=C2=A0 //=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warr=
anty of<br>
<br>
That&#39;s an interesting file - the license text shows up twice here... I<=
br>
wonder whether we could scratch one of the two... but that&#39;s also somet=
hing<br>
for a separate patch, I think.<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote></div></div>

--000000000000d2f51c05b1255fd3--

