Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E0DC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F44421556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH52kEDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F44421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9B6G-00069j-6E
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j9B5Y-0005gn-5k
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j9B5X-00058y-1m
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:12:12 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:40159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1j9B5W-00058V-Pp
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:12:11 -0500
Received: by mail-lf1-x141.google.com with SMTP id p5so3415231lfc.7
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ysBssrAzjdlF3FokCr1PlHxwXkfGv5Dp71F6jylpGIY=;
 b=HH52kEDzeqCJIrFheUZ/tP2R2pTTNkSPfGwgj8/gTmSjradzPCIt467KsEYMrxfn38
 Yw+hb17+w6lOz2JFF2K026FUfrn3yV2Aj4NMfzrj6vq45IHmp/qEQA7OPkpbUSjSUsSg
 f06PPBWdm2Si4opV0aNaUSODQiRwM2UAEXlxNRHJXfTIVMRr2ehOZ3HKqAX5u0+hUPuB
 s5qiNxxVzCgq/U9NlVeS6N7ReEkaEZa5QnWPzjvxwJe5DoeJLne/Ahti+aUcS6AonuJf
 PhGpBnzXVrIGZSPa0NtV5jIc9NbJ5aAwiZOeQJ6F838Rum9YwGY9I2Lgs+UaL/BUlfOp
 nIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ysBssrAzjdlF3FokCr1PlHxwXkfGv5Dp71F6jylpGIY=;
 b=o4wLQzM3SeNywrkr4GiD0ukftFyNh5yVEw2TkaCaNPJ+X4mP8NKr9pDfW4zBAFrZk4
 J5TU0UjDOGwhI+taVDcwP2rn+TMH6tERcFFoZYdNwyRK9Nvco133UfRXo7ACRj06ZwEV
 azYopxxjecVL5CHOx3W2bG6aonb/8tms0mK+edY9Aviot9wcRMWl3Yb5gkpJf4BQi2Dr
 5Q2ArJBLkjhu+k34+6SkPJk1RBTHxOn7RmtjJPLqeT92fUvU2AmF9NcJjD8MEAQD6sPh
 0gyjWIJPIKGkh8y4SGvwMTyz1m2gF+1zwqmSaoeELWaCF/OtfDTqXcqs5AB1ApsZTvkF
 Iqwg==
X-Gm-Message-State: ANhLgQ0PwlwlLc8t2GLXAO3kKDmALHWfiGex+g3bCIY3HoW5K/C+hiba
 SoSfhW7Ar7WOo8e5Vc5oAODjtgPq7jhbJzT1Rus=
X-Google-Smtp-Source: ADFU+vsGFJQwchA+Oci+dsxiYTqo5RobrKMKh+pRMhBX7nSoN68rycYLyymqa1lhIvdy5Q6NaTxgwKC08DdW2LEYrK4=
X-Received: by 2002:a19:c70c:: with SMTP id x12mr3439967lff.210.1583255529427; 
 Tue, 03 Mar 2020 09:12:09 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
 <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
 <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
 <CAJSP0QW2ooLK_0Hr52h8HYdmm2j6CunTAnhFxS3De=azMutUeA@mail.gmail.com>
In-Reply-To: <CAJSP0QW2ooLK_0Hr52h8HYdmm2j6CunTAnhFxS3De=azMutUeA@mail.gmail.com>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Tue, 3 Mar 2020 22:41:57 +0530
Message-ID: <CAPV47zc6R1fX_RrEzLQkQuRtjKK87HNtmkgnxazZGOESGERwxw@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006b95d3059ff667c9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006b95d3059ff667c9
Content-Type: text/plain; charset="UTF-8"

 > These errors are probably due to the Makefile.objs changes in your
commit:

If I am not wrong, we need to add a rule i.e *"
common-obj-$(CONFIG_TESTPCI) += testpci.o "* in Makefile.objs to compile
custom device in Qemu.
Shall I should remove that rule to remove the errors?

On Tue, 3 Mar 2020 at 21:06, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Mar 3, 2020 at 12:45 PM Priyamvad Acharya
> <priyamvad.agnisys@gmail.com> wrote:
> > Thanks Stefan for explaining the method.
> > After following above method when I run below command to compile my
> custom device in Qemu source code , I get the output on terminal which is
> attached in a file for your reference.
> >
> > Command:- make -j8 -C build
> >
> > Most of the lines in attached file indicate that error might be due to
> helper.c file.
> >
> > How to resolve it?
>
> These errors are probably due to the Makefile.objs changes in your commit:
>
> https://github.com/PriyamvadAcharya/virtual_prototype_qemu/commit/4c71c2759a96cf1db83a74027b93c6ceeab24bf1#diff-a8f0482bb5eda5c20e2054e1b1d263f2
>
> Stefan
>

--0000000000006b95d3059ff667c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<div><span style=3D"color:rgb(142,124,195)">&gt; These errors are probably =
due to the Makefile.objs changes in your commit:</span></div><div><span sty=
le=3D"color:rgb(142,124,195)"><br></span></div><div><span style=3D"color:rg=
b(142,124,195)"><font color=3D"#000000">If I am not wrong, we need to add a=
 rule i.e <b>&quot;
<span>common-obj-$(CONFIG_TESTPCI) +=3D testpci.o</span>

&quot;</b> in Makefile.objs to compile custom device in Qemu.</font><br></s=
pan></div><div><span style=3D"color:rgb(142,124,195)"><font color=3D"#00000=
0">Shall I should remove that rule to remove the errors?</font></span></div=
>

</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Tue, 3 Mar 2020 at 21:06, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha=
@gmail.com" target=3D"_blank">stefanha@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Mar 3, 2020 at 12:4=
5 PM Priyamvad Acharya<br>
&lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=3D"_blank">priyam=
vad.agnisys@gmail.com</a>&gt; wrote:<br>
&gt; Thanks Stefan for explaining the method.<br>
&gt; After following above method when I run below command to compile my cu=
stom device in Qemu source code , I get the output on terminal which is att=
ached in a file for your reference.<br>
&gt;<br>
&gt; Command:- make -j8 -C build<br>
&gt;<br>
&gt; Most of the lines in attached file indicate that error might be due to=
 helper.c file.<br>
&gt;<br>
&gt; How to resolve it?<br>
<br>
These errors are probably due to the Makefile.objs changes in your commit:<=
br>
<a href=3D"https://github.com/PriyamvadAcharya/virtual_prototype_qemu/commi=
t/4c71c2759a96cf1db83a74027b93c6ceeab24bf1#diff-a8f0482bb5eda5c20e2054e1b1d=
263f2" rel=3D"noreferrer" target=3D"_blank">https://github.com/PriyamvadAch=
arya/virtual_prototype_qemu/commit/4c71c2759a96cf1db83a74027b93c6ceeab24bf1=
#diff-a8f0482bb5eda5c20e2054e1b1d263f2</a><br>
<br>
Stefan<br>
</blockquote></div>

--0000000000006b95d3059ff667c9--

