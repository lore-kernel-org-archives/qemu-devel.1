Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF2820727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9MKKizK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF2820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBkGZ-0003Ip-8o
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 15:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBkFx-0002oY-3v
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBkFw-0004QV-0x
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:09:33 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:44188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBkFv-0004Ow-Qf; Tue, 10 Mar 2020 15:09:31 -0400
Received: by mail-il1-x142.google.com with SMTP id j69so13033691ila.11;
 Tue, 10 Mar 2020 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WgUuyKjM3IhQD1E2N+STyZ/xweajPSeBqqEjx/rZUD4=;
 b=s9MKKizKrSglBl2D9krtypMPSDhYD2TQY2MRziSG7tCsr7UsbLT0XZAU87+5LhYnpQ
 XalgYtwJDybqvj8cc3uh7fryKpZ0feHHuYa2R92aLx9hZK6dtTe6nRHbhM0vMmFzJ06p
 GlXfmYr2XF++9ABJrVxXMb2Z5inNJlOPGxH5x9mX27sfskSSCab0JyCzx/lCuRLjeqk6
 mvbXRdFQRdDY8X9ohGXd2wz951ya80gZXO6TNjTv5FgjzscvmJYSRTiw/RwYbiBSdQlO
 ejCfiWdR2fVyFpiJB05kfsrB8cpC/rqU/So7dJbW6kIbWimLGRxlhyr+awSgpHHhKvoi
 sbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WgUuyKjM3IhQD1E2N+STyZ/xweajPSeBqqEjx/rZUD4=;
 b=rF9MkLVs+5KjttURdD8g3Cn5ZyILtibFTj/en2QTGmXogG5TATNqPL4SXAF2HsW6eA
 MtxD8Xa7yp6ycALKdoovWyFOH6PYgn4F+R0yeWOpKxVsyYUzQaoGcCevsuBXZoUHRgp2
 w/fQ3pY0QSIExfWrl70AgSLw4WA0O94G9ziendysoN9UTpN7YRHh74sTxu1dzWuDYJ5C
 AvvuQskSIFPWh9yUIYII0oWCpIklfZ0fUV0UWC6uWVcIRSG00un/HuPP0XAQuyHfJNiB
 PjzrLBiUm+yDyhWj5+OvxhA0CSQ68VH+NwojyFlWCHqQo5gBPB7AXWavXyBlB13Rl3VR
 2zEg==
X-Gm-Message-State: ANhLgQ06NV4XaRrz5XMI2GT9wF1KC2FUHiA94eWMprQEa92193ILPVPU
 qbEzveqvs3jsDE4CshkcXyNmpAPqT9miHfUtElY=
X-Google-Smtp-Source: ADFU+vsPIjdzOjLRgB94tHflqQ0OqbbNAqiDdywOxCPT0TaYJjKirsPbxVyAWmLViNd0Tk3CQmYdWWNgkRz9hMzxF2Q=
X-Received: by 2002:a92:9e99:: with SMTP id s25mr6348378ilk.306.1583867371063; 
 Tue, 10 Mar 2020 12:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
 <CAFEAcA_6Lm-JwbXFLWeetc7+fhnrc5m2+YU28ymFw0MSoKOhwg@mail.gmail.com>
 <CAPan3Wo2Nf_d4AxsV5=sfOxv66rmQNfN==rpMn9=FtM5cZG9rw@mail.gmail.com>
 <CAFEAcA-2-tz7F1vmbggpLnc1SSX+_W5pij-w8Vgjx+vqr-LRUA@mail.gmail.com>
 <CAPan3Wr-oS-QRxmCDPXLRBG81yqjnp56B2WNuxtBMOxr2b9D6A@mail.gmail.com>
 <CAFEAcA_rY1hXNbzsj6EJvKzODX_EWdTOK1Gfxi2Jbv+UsYxRtQ@mail.gmail.com>
 <CAFEAcA-m2GJ01=-aEW0VLrY-nJgOpAMFOBF8+0jXeW+H7wkM-A@mail.gmail.com>
In-Reply-To: <CAFEAcA-m2GJ01=-aEW0VLrY-nJgOpAMFOBF8+0jXeW+H7wkM-A@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Mar 2020 20:09:20 +0100
Message-ID: <CAPan3WrWND1w8QfPpemO_6brNuAaPKhns7TkbhBOfqfamPAnhg@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000060f9e05a084dcc6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000060f9e05a084dcc6
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

On Mon, Mar 9, 2020 at 11:01 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Mon, 9 Mar 2020 at 20:12, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> > If you're ready to send out the next version before that,
> > then leave it with the include:: directive and we can
> > fix it up to the new structure later.
>
> PS: in case you weren't aware, softfreeze for the 5.0 release
> is 17th March, so if this series is going to go in for 5.0
> then (a) people interested in reviewing it should hurry up
> and review patches 9..18 and (b) the final version would
> need to be on the list sometime this week so it can go into
> a pull request by the 17th.
>

Ah I was not aware of that date indeed! Yes, ofcourse, if we can get the
remaining parts reviewed as well to include it in 5.0, that would be great.

As a side note, I'm basically doing this project in my spare time in the
(late) evenings (Amsterdam timezone),
so I'll make sure to reserve some extra time the coming days so I can reply
and respin fast if needed.

I'm finalizing & testing the v7 update now and will send it out in a few
hours to the list.

Regards,
Niek


>
> It's no big deal if it goes into 5.1 instead I guess,
> but it feels like the series is nearly ready so I figured
> I'd set out the timeline if people want to push to get it
> into 5.0.
>

> thanks
> -- PMM
>


-- 
Niek Linnenbank

--000000000000060f9e05a084dcc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,<br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, 2020 at 11:01 PM Peter Ma=
ydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Mon, 9 Mar 2020 at 20:12, Peter Maydell &lt;<a href=3D"mailto:peter.m=
aydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote=
:<br>
&gt; If you&#39;re ready to send out the next version before that,<br>
&gt; then leave it with the include:: directive and we can<br>
&gt; fix it up to the new structure later.<br>
<br>
PS: in case you weren&#39;t aware, softfreeze for the 5.0 release<br>
is 17th March, so if this series is going to go in for 5.0<br>
then (a) people interested in reviewing it should hurry up<br>
and review patches 9..18 and (b) the final version would<br>
need to be on the list sometime this week so it can go into<br>
a pull request by the 17th.<br></blockquote><div><br></div><div>Ah I was no=
t aware of that date indeed! Yes, ofcourse, if we can get the</div><div>rem=
aining parts reviewed as well to include it in 5.0, that would be great.</d=
iv><div><br></div><div>As a side note, I&#39;m basically doing this project=
 in my spare time in the (late) evenings (Amsterdam timezone),</div><div>so=
 I&#39;ll make sure to reserve some extra time the coming days so I can rep=
ly and respin fast if needed.<br></div><div><br></div><div>I&#39;m finalizi=
ng &amp; testing the v7 update now and will send it out in a few hours to t=
he list.</div><div><br></div><div>Regards,</div><div>Niek<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
It&#39;s no big deal if it goes into 5.1 instead I guess,<br>
but it feels like the series is nearly ready so I figured<br>
I&#39;d set out the timeline if people want to push to get it<br>
into 5.0.<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000060f9e05a084dcc6--

