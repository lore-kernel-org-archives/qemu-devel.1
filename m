Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F0C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A8D21548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udKNGn37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A8D21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHijH-00072W-Uy
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHiig-0006W4-1E; Mon, 14 Sep 2020 03:16:10 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHiie-0001sz-56; Mon, 14 Sep 2020 03:16:09 -0400
Received: by mail-lf1-x144.google.com with SMTP id y17so12238162lfa.8;
 Mon, 14 Sep 2020 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=GMYz2WpBG5wDGzP/oQ7zm/3jvlWdBEAmyG2w/ei9Trs=;
 b=udKNGn37wMs2owm3AjiJDREf0z5oUo5EYgKuNLzSnfauI3upb4uqYRg40PcoysyNeB
 JcWA+nJX68+DfXrF+y+oNinj+nF2uAJ8O7imCTgfVOr5xuOB4JMRSGnNtz6V5coXJPy7
 TgWb282i7UF/GvWfe/5/h5VA9Zz27ClC3t7K5x9dPA93HckMhrduHw0IXHWe7tyqYEFb
 KjY/vl9mnc0BFrYDamLsVCFllo20euuY0kY89IVp3eO3ZH1g3uip2LO38umlCQOBZ/Ke
 dwHAi9Wwk9rKjLr5YuC5YbnSxkq85+Dmqu+mOFXKPDpZXJBsD9Kt4+p+3HB22OQjVRIU
 ZhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=GMYz2WpBG5wDGzP/oQ7zm/3jvlWdBEAmyG2w/ei9Trs=;
 b=X/b6AA3oAMnzuEZ3N0kFsJKt2Aso/am6YQnANLi4gXMDdA0+qI0DV+imGrqUvH+ZkK
 0ce/lZD4UEZfLZSB2vLVEGE77IEZiR1dJ8tloytFaQLDTJ3ImbOM4UmR1gP9Z31WCxea
 nwwIdguWqFeYv9rqDy5Nh24t09VWU3m8EzOOyPwENG+S//EHr6dCtqgPgT/p5fZs5SXY
 /JFAY/EioAtLwiCT4NiOXngr094FlX42rBa3vXnOFOPn3UCXffDH+fZ4R1goOZ+0Bota
 k1IGu1T68bEpWz08gVLSN8RR1C4JQH780muYSq3ozNmZv+mEOrPJ3f98OUpEsVmdl1S2
 /6fg==
X-Gm-Message-State: AOAM533xLriK8i9Ukq591b0lq2CqHko6ET0ymwt+Zxcb1IVnolgz4aaU
 SEV48tav7VqImQGlOUoZGJj68sQ0JpCsLXR17bk=
X-Google-Smtp-Source: ABdhPJzawAv+L7e4uSacApYMjfXF16l97dYAkl7vLO7mWl5wCRkM90RSfKTxD9fxR7Cfw5fkRLYjne7Tg6y/e9tFFGg=
X-Received: by 2002:a19:383:: with SMTP id 125mr4166417lfd.356.1600067765739; 
 Mon, 14 Sep 2020 00:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-4-luoyonggang@gmail.com>
 <4601317a-d110-e5f3-faf5-8b9b0278ffb9@redhat.com>
In-Reply-To: <4601317a-d110-e5f3-faf5-8b9b0278ffb9@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 15:15:56 +0800
Message-ID: <CAE2XoE98mgOmh7N4Z07xOU9a0yhMDQkzq+RhJ6r9v9Q-ap4ZtQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/27] ci: fixes msys2 build by upgrading capstone to
 4.0.2
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cb247e05af40cebc"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
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
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cb247e05af40cebc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 3:10 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 13/09/2020 00.44, Yonggang Luo wrote:
> > The currently random version capstone have the following compiling
issue:
> >   CC      /c/work/xemu/qemu/build/slirp/src/arp_table.o
> > make[1]: *** No rule to make target
=E2=80=9C/c/work/xemu/qemu/build/capstone/capstone.lib=E2=80=9D=E3=80=82 St=
op.
> >
> > Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1 are the
tagged version 4.0.2
> > when upgrading to this version, the folder structure of include are
changed to
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
-I${source_path}/capstone/include/capstone
> > for directly #include <capstone.h>, and the exist include path should
preserve, because
> > in capstone code there something like #include "capstone/capstone.h"
> >
> > If only using
> >     capstone_cflags=3D"-I${source_path}/capstone/include/capstone"
> > Then will cause the following compiling error:
> >
> >   CC      cs.o
> > cs.c:17:10: fatal error: 'capstone/capstone.h' file not found
> > #include <capstone/capstone.h>
> >          ^~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
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
>
> Richard has a patch series on the list now to update and improve the
> capstone submodule (see "capstone + disassembler patches") ... I think
> this patch here will then not be required anymore.
I've seen that, of cause, this patch need to be dropped.
>
>  Thomas
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000cb247e05af40cebc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 14, 2020 at 3:10 PM Thomas Huth &lt;<a=
 href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<b=
r>&gt; On 13/09/2020 00.44, Yonggang Luo wrote:<br>&gt; &gt; The currently =
random version capstone have the following compiling issue:<br>&gt; &gt; =
=C2=A0 CC =C2=A0 =C2=A0 =C2=A0/c/work/xemu/qemu/build/slirp/src/arp_table.o=
<br>&gt; &gt; make[1]: *** No rule to make target =E2=80=9C/c/work/xemu/qem=
u/build/capstone/capstone.lib=E2=80=9D=E3=80=82 Stop.<br>&gt; &gt;<br>&gt; =
&gt; Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1 are the tag=
ged version 4.0.2<br>&gt; &gt; when upgrading to this version, the folder s=
tructure of include are changed to<br>&gt; &gt; qemu\capstone\include<br>&g=
t; &gt; =E2=94=82 =C2=A0platform.h<br>&gt; &gt; =E2=94=82<br>&gt; &gt; =E2=
=94=9C=E2=94=80capstone<br>&gt; &gt; =E2=94=82 =C2=A0 =C2=A0 =C2=A0arm.h<br=
>&gt; &gt; =E2=94=82 =C2=A0 =C2=A0 =C2=A0arm64.h<br>&gt; &gt; =E2=94=82 =C2=
=A0 =C2=A0 =C2=A0capstone.h<br>&gt; &gt; =E2=94=82 =C2=A0 =C2=A0 =C2=A0evm.=
h<br>&gt; &gt; =E2=94=82 =C2=A0 =C2=A0 =C2=A0m680x.h<br>&gt; &gt; =E2=94=82=
 =C2=A0 =C2=A0 =C2=A0m68k.h<br>&gt; &gt; =E2=94=82 =C2=A0 =C2=A0 =C2=A0mips=
.h<br>&gt; &gt; =E2=94=82 =C2=A0 =C2=A0 =C2=A0platform.h<br>&gt; &gt; =E2=
=94=82 =C2=A0 =C2=A0 =C2=A0ppc.h<br>&gt; &gt; =E2=94=82 =C2=A0 =C2=A0 =C2=
=A0sparc.h<br>&gt; &gt; =E2=94=82 =C2=A0 =C2=A0 =C2=A0systemz.h<br>&gt; &gt=
; =E2=94=82 =C2=A0 =C2=A0 =C2=A0tms320c64x.h<br>&gt; &gt; =E2=94=82 =C2=A0 =
=C2=A0 =C2=A0x86.h<br>&gt; &gt; =E2=94=82 =C2=A0 =C2=A0 =C2=A0xcore.h<br>&g=
t; &gt; =E2=94=82<br>&gt; &gt; =E2=94=94=E2=94=80windowsce<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 intrin.h<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
stdint.h<br>&gt; &gt;<br>&gt; &gt; in capstone. so we need add extra includ=
e path -I${source_path}/capstone/include/capstone<br>&gt; &gt; for directly=
 #include &lt;capstone.h&gt;, and the exist include path should preserve, b=
ecause<br>&gt; &gt; in capstone code there something like #include &quot;ca=
pstone/capstone.h&quot;<br>&gt; &gt;<br>&gt; &gt; If only using<br>&gt; &gt=
; =C2=A0 =C2=A0 capstone_cflags=3D&quot;-I${source_path}/capstone/include/c=
apstone&quot;<br>&gt; &gt; Then will cause the following compiling error:<b=
r>&gt; &gt;<br>&gt; &gt; =C2=A0 CC =C2=A0 =C2=A0 =C2=A0cs.o<br>&gt; &gt; cs=
.c:17:10: fatal error: &#39;capstone/capstone.h&#39; file not found<br>&gt;=
 &gt; #include &lt;capstone/capstone.h&gt;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~<br>&gt; &gt; 1 error generated.<br>&=
gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luo=
yonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; =
&gt; =C2=A0capstone =C2=A0| 2 +-<br>&gt; &gt; =C2=A0configure | 2 +-<br>&gt=
; &gt; =C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>&gt; &gt;<=
br>&gt; &gt; diff --git a/capstone b/capstone<br>&gt; &gt; index 22ead3e0bf=
..1d23053284 160000<br>&gt; &gt; --- a/capstone<br>&gt; &gt; +++ b/capstone=
<br>&gt; &gt; @@ -1 +1 @@<br>&gt; &gt; -Subproject commit 22ead3e0bfdb87516=
656453336160e0a37b066bf<br>&gt; &gt; +Subproject commit 1d230532840a37ac032=
c6ab80128238fc930c6c1<br>&gt;<br>&gt; Richard has a patch series on the lis=
t now to update and improve the<br>&gt; capstone submodule (see &quot;capst=
one + disassembler patches&quot;) ... I think<br>&gt; this patch here will =
then not be required anymore.<div>I&#39;ve seen that, of cause, this patch =
need to be dropped.<br>&gt;<br>&gt; =C2=A0Thomas<br>&gt;<br><br><br>--<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
/div></div>

--000000000000cb247e05af40cebc--

