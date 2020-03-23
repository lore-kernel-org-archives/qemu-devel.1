Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C986AC10F26
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 06:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8949220409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 06:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORbG3XI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8949220409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGGA2-00063B-Mr
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 02:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1jGG8m-0005d8-3t
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 02:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1jGG8k-00029g-Oa
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 02:00:47 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45703)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1jGG8k-00028J-GX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 02:00:46 -0400
Received: by mail-oi1-x244.google.com with SMTP id l22so2835417oii.12
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BrUE0MAicAO40w9zZq5MNKSA/x2ko2YxEj0pi5PQ55U=;
 b=ORbG3XI/LSMkdM4U2XrjUrXG5o0IZnjY4cF7RCP4GeRZNsbd1oMFbqxURUj0+yuldq
 czoe7g7Q01fHtZgE4uc3pcNB/FAR6fesYJPYJlHSnPppnBofa0G8+UqPIEviAwIEpRPR
 dwqQwGje7iVN1cthsjGVkT7nwHgUsp3W0INET08BXdNAHABoZTluPrRQyK7vDYVTjWoo
 YJY2YL96aVtYZjs+Y022n0MJkuaC84MQ2EVVfEv7PEXssjQki4thxfIPHFoyIPogFSjl
 vAXrni4hJeLT8z31MW8s7seRiyhuoobhXq9YuGjiK/QwP+LsuXuyEhap+4/6vWMlF2Y4
 b69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BrUE0MAicAO40w9zZq5MNKSA/x2ko2YxEj0pi5PQ55U=;
 b=IcpPs8lGQdaTshUz9aZ+UOhLqZkVKPMN70FRFlZtcqUgLCGDB8QPy+dw7H6CubdA0K
 E0HiP4x+PzMMDsayn+OblIX2fAQA5C/UCCpVgNf+zIV2C0n6IFjriu0GLIn/kYUaAFVj
 cTvrxhgZ+W92G4gaxhvFmyHocd6n7pzY4AqWSMkeHR10tHUkBv2yKLIBU8/2I0TD+K9j
 Gu1nLhOx0ogl20MkbKw2Uk730MLA4cQqwHnW7Ao3ikkg2qv/cOJWDKpR8QQwoIJXOybb
 /Tu8WyWZtFgHfyzJGe0LH5S3tTq5u0mtaXnoFflSt6th+FnJLPbNIiFN2ezCJaypWVE0
 gH5Q==
X-Gm-Message-State: ANhLgQ0+VNzVnX+QIYeTRgOICDMGRkwpkPgimCJ+QuyIqoYKbbqpIAj4
 9gsYZNgYzrkv910+Ve/nQup2AI37LTbZXF/ZaT4=
X-Google-Smtp-Source: ADFU+vtmd3mJ/rFq4kOPNT/tInR5YPsnp4eB24V89Vao/KYlpI+vsXnUJ6jfUA9Gm3PkNuF9iJlyCNuT3DJGosngsU0=
X-Received: by 2002:aca:a895:: with SMTP id
 r143mr15643184oie.150.1584943245156; 
 Sun, 22 Mar 2020 23:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200319174050.759794-1-ppandit@redhat.com>
 <20f29d89-6d52-2edc-ef7e-13124908256a@redhat.com>
In-Reply-To: <20f29d89-6d52-2edc-ef7e-13124908256a@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 23 Mar 2020 14:00:09 +0800
Message-ID: <CAKXe6S+rczw66d_wvf0w0AsdZxY=K+edRoik3jGedpHA+hMX3A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] net: tulip: add checks to avoid OOB access
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001de72705a17f5bcb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001de72705a17f5bcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jason Wang <jasowang@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:44=E5=86=99=E9=81=93=EF=BC=9A

>
> On 2020/3/20 =E4=B8=8A=E5=8D=881:40, P J P wrote:
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > Hello,
> >
> > * This series adds checks to avoid potential OOB access and infinite lo=
op
> >    issues while processing rx/tx data.
> >
> > * Tulip tx descriptors are capped at 128 to avoid infinite loop in
> >    tulip_xmit_list_update(), wrt Tulip kernel driver
> >    ->
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/ethernet/dec/tulip/tulip.h#n319
> >
> > * Update v3: add .can_receive routine
> >    ->
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
> >
> > * Update v4: flush queued packets once they are received
> >    ->
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg05868.html
> >
> > * Update v5: fixed a typo in patch commit message
> >    ->
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06209.html
> >
> > Thank you.
>
>
> Looks good to me.
>
> Qiang, any change to give a test with your reproducer?
>
>
Hi Jason,
Sorry for missing discussing this thread as so busy these days/weeks.

I will try to test this patch asap.

Thanks,
Li Qiang



> Thanks
>
>
> > --
> > Prasad J Pandit (3):
> >    net: tulip: check frame size and r/w data length
> >    net: tulip: add .can_receive routine
> >    net: tulip: flush queued packets post receive
> >
> >   hw/net/tulip.c | 51 +++++++++++++++++++++++++++++++++++++++++--------=
-
> >   1 file changed, 42 insertions(+), 9 deletions(-)
> >
> > --
> > 2.25.1
> >
> >
>
>
>

--0000000000001de72705a17f5bcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Jason Wang &lt;<a href=3D"mailto:jaso=
wang@redhat.com">jasowang@redhat.com</a>&gt; =E4=BA=8E2020=E5=B9=B43=E6=9C=
=8823=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:44=E5=86=99=E9=81=93=
=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/3/20 =E4=B8=8A=E5=8D=881:40, P J P wrote:<br>
&gt; From: Prasad J Pandit &lt;<a href=3D"mailto:pjp@fedoraproject.org" tar=
get=3D"_blank">pjp@fedoraproject.org</a>&gt;<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; * This series adds checks to avoid potential OOB access and infinite l=
oop<br>
&gt;=C2=A0 =C2=A0 issues while processing rx/tx data.<br>
&gt;<br>
&gt; * Tulip tx descriptors are capped at 128 to avoid infinite loop in<br>
&gt;=C2=A0 =C2=A0 tulip_xmit_list_update(), wrt Tulip kernel driver<br>
&gt;=C2=A0 =C2=A0 -&gt; <a href=3D"https://git.kernel.org/pub/scm/linux/ker=
nel/git/torvalds/linux.git/tree/drivers/net/ethernet/dec/tulip/tulip.h#n319=
" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub/scm/linux=
/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/dec/tulip/tulip.h#=
n319</a><br>
&gt;<br>
&gt; * Update v3: add .can_receive routine<br>
&gt;=C2=A0 =C2=A0 -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-=
devel/2020-02/msg06275.html" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html</a><br>
&gt;<br>
&gt; * Update v4: flush queued packets once they are received<br>
&gt;=C2=A0 =C2=A0 -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-=
devel/2020-03/msg05868.html" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.gnu.org/archive/html/qemu-devel/2020-03/msg05868.html</a><br>
&gt;<br>
&gt; * Update v5: fixed a typo in patch commit message<br>
&gt;=C2=A0 =C2=A0 -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-=
devel/2020-03/msg06209.html" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.gnu.org/archive/html/qemu-devel/2020-03/msg06209.html</a><br>
&gt;<br>
&gt; Thank you.<br>
<br>
<br>
Looks good to me.<br>
<br>
Qiang, any change to give a test with your reproducer?<br>
<br></blockquote><div><br></div><div>Hi Jason,</div><div>Sorry for missing =
discussing this thread as so busy these days/weeks.</div><div><br></div><di=
v>I will try to test this patch asap.</div><div><br></div><div>Thanks,</div=
><div>Li Qiang</div><div></div><div>=C2=A0</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
Thanks<br>
<br>
<br>
&gt; --<br>
&gt; Prasad J Pandit (3):<br>
&gt;=C2=A0 =C2=A0 net: tulip: check frame size and r/w data length<br>
&gt;=C2=A0 =C2=A0 net: tulip: add .can_receive routine<br>
&gt;=C2=A0 =C2=A0 net: tulip: flush queued packets post receive<br>
&gt;<br>
&gt;=C2=A0 =C2=A0hw/net/tulip.c | 51 ++++++++++++++++++++++++++++++++++++++=
+++---------<br>
&gt;=C2=A0 =C2=A01 file changed, 42 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
&gt;<br>
<br>
<br>
</blockquote></div></div>

--0000000000001de72705a17f5bcb--

