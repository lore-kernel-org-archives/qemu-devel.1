Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97149C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 23:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A542083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 23:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+dWu81t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A542083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTCMe-00028s-Rw
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 19:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kTCLk-0001g1-52
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 19:07:56 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:44605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kTCLi-0005Vd-5i
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 19:07:55 -0400
Received: by mail-ot1-x32e.google.com with SMTP id e20so743208otj.11
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 16:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WWegH+VmKXH9VrYzIa1Caa5TpR1/wpyyytySNxn1gUk=;
 b=L+dWu81tdcoqcQJAkNzhjVjs6n3gw/N7hs48J2bUxr2lzCG5qn+c00sjOHavIk65O4
 467Pxa+qLu5SFMqwjclZpkRnWeNFj6lr+f5/bM717zMibSKBPU64KoInQ0FGQwewovVb
 5lCqUvUDEyc4grNPuertQoVRkOp61B2vG00CFJjX/eSLpc7VAAx3kwUIF3FqLBhB/bKX
 eNs7rPqpFs7CjcDyxjveyplAks6Ra9JlZ2DJxeA/L7R9P9WgwCPKjdbC4K2O+BN4PvEY
 WzQD/65NlaxsiH2HWHJoKmGO/rxgo02d7j2NasrcOXh3uMaeGdE9cmsf5k9qXh/JiTlJ
 p0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WWegH+VmKXH9VrYzIa1Caa5TpR1/wpyyytySNxn1gUk=;
 b=Vs0huJvhPdnQOPY6/L2Hp8JDaD/vZO2QM1YQ3eDXhi08QfIEKeezwqrisS4iip7jpv
 6S+TLgtW10XeXNrRmuGXiUCOFRa7FXQ8sbYxNsY3cdwmEXaIYfL4E7Af4OO8p+BjeeYo
 2KqMQmfVmpUh96jAPDJdpcA84OU3myyVHVE53EO2SF3tKfq95k2h5h7weOmYdlej3McH
 wqsZWIECXeOLxpz4WFVj6yb/EQNcqWiExcNgqihz+IyWwEMTSWES38dusOyvf6DS8c83
 zM4AnekQvoD2Wzd3x14QPRWmJHV6wDKv5p8pe0ChyxjuJeJuu8gy3k5wnenU81gd7jBJ
 5SVg==
X-Gm-Message-State: AOAM531yCyZAtKYu1toxVS7CEzfQmciwBy4ofIfeRz0AMfX758we551F
 /YMX1Zt7+wKuNAhxOblxpm2RRJLCUQ/1+zxvMWI=
X-Google-Smtp-Source: ABdhPJz5WR/TNuGlagV2uSKF3W6vXP9fivDjo/WV7bzZImR90fMVOQUzMuMt1h30N6al+Mf5/cJGZOSgWU0czmqlGbo=
X-Received: by 2002:a9d:5d13:: with SMTP id b19mr586026oti.75.1602803272830;
 Thu, 15 Oct 2020 16:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <CABLmASGJOFbYUhSAbKhc9s1G00Jh0vN--WaFPtaoHqsL2WuvbQ@mail.gmail.com>
 <44d3eccf-3c64-82cd-b5b2-641de6960ab5@redhat.com>
 <CABLmASE55n6h=fr8UrKOHdu1Z_P-46a9t4L0KaRxvvf0hob01w@mail.gmail.com>
 <214e983c-b9e8-d03d-099e-d8fe506e6a7b@t-online.de>
In-Reply-To: <214e983c-b9e8-d03d-099e-d8fe506e6a7b@t-online.de>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 16 Oct 2020 01:07:41 +0200
Message-ID: <CABLmASHdvMG_XfV8sth=7=JFvr_mRAvKe94o-nb9YfZkrk54Eg@mail.gmail.com>
Subject: Re: [PATCH 0/7] build: replace ninjatool with ninja
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="000000000000b8d2d005b1bdb7d8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b8d2d005b1bdb7d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 7:39 PM Volker R=C3=BCmelin <vr_qemu@t-online.de> w=
rote:

>
> >
> > Thanks Paolo,
> >
> > Then only the issue regarding the pcbios/optionrom stuff remains ;-)
> >
> > make[1]: *** No rule to make target 'multiboot.bin', needed by 'all'.
> Stop.
> > make: *** [Makefile:171: pc-bios/optionrom/all] Error 2
> > make: *** Waiting for unfinished jobs....
> >
> > Best,
> > Howard
> >
>
> Hi Howard,
>
> one solution for this issue is to uncomment the following line in
> msys2_shell.cmd.
>
> rem To activate windows native symlinks uncomment next line
> set MSYS=3Dwinsymlinks:nativestrict
>
> Then tell Windows 10 it's okay to create symlinks without elevated rights=
.
> Here is a link with a description how to do this.
> https://www.joshkel.com/2018/01/18/symlinks-in-windows/
>
> I think since commit bf708f3c4a "optionrom: simplify Makefile"
> pc-bios/optionrom/Makefile in your build directory has to be a symbolic
> link. Without 'set MSYS=3Dwinsymlinks:nativestrict' msys2 ln -s copies th=
e
> Makefile instead of creating a symbolic link.
>
>
Thanks Volker!

I changed the Windows policy and setting in msys2_shell.cmd. However, I had
to edit ming64.ini to uncomment the MSYS=3Dwinsymlinks:nativestrict there a=
s
well to get things going.

While it is great to have this fix, I can't say I'm really happy with the
need to change the Windows policy and to have to fix msys2.

The patches Mark referred to and to which I also pointed earlier did fix
this problem without changing Windows/Msys2/Mingw64 settings.

Best regards,
Howard

--000000000000b8d2d005b1bdb7d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 15, 2020 at 7:39 PM Volke=
r R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de" target=3D"_blank"=
>vr_qemu@t-online.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><br>
&gt;<br>
&gt; Thanks Paolo,<br>
&gt;<br>
&gt; Then only the issue regarding the pcbios/optionrom stuff remains ;-)<b=
r>
&gt;<br>
&gt; make[1]: *** No rule to make target &#39;multiboot.bin&#39;, needed by=
 &#39;all&#39;.=C2=A0 Stop.<br>
&gt; make: *** [Makefile:171: pc-bios/optionrom/all] Error 2<br>
&gt; make: *** Waiting for unfinished jobs....<br>
&gt;<br>
&gt; Best,<br>
&gt; Howard<br>
&gt;<br>
<br>
Hi Howard,<br>
<br>
one solution for this issue is to uncomment the following line in msys2_she=
ll.cmd.<br>
<br>
rem To activate windows native symlinks uncomment next line<br>
set MSYS=3Dwinsymlinks:nativestrict<br>
<br>
Then tell Windows 10 it&#39;s okay to create symlinks without elevated righ=
ts. Here is a link with a description how to do this.<br>
<a href=3D"https://www.joshkel.com/2018/01/18/symlinks-in-windows/" rel=3D"=
noreferrer" target=3D"_blank">https://www.joshkel.com/2018/01/18/symlinks-i=
n-windows/</a><br>
<br>
I think since commit bf708f3c4a &quot;optionrom: simplify Makefile&quot; pc=
-bios/optionrom/Makefile in your build directory has to be a symbolic link.=
 Without &#39;set MSYS=3Dwinsymlinks:nativestrict&#39; msys2 ln -s copies t=
he Makefile instead of creating a symbolic link.<br>
<br></blockquote><div><br></div><div>Thanks Volker!</div><div><br> </div><d=
iv>I changed the Windows policy and setting in msys2_shell.cmd. However, I =
had to edit ming64.ini to uncomment the MSYS=3Dwinsymlinks:nativestrict the=
re as well to get things going.=C2=A0</div><div><br></div><div>While it is =
great to have this fix, I can&#39;t say I&#39;m really happy with the need =
to change the Windows policy and to have to fix msys2.</div><div><br></div>=
<div>The patches Mark referred to and to which I also pointed earlier did f=
ix this problem without changing Windows/Msys2/Mingw64 settings.<br></div><=
div><br></div><div>Best regards,</div><div>Howard<br></div><div><br></div><=
div><br></div></div></div>

--000000000000b8d2d005b1bdb7d8--

