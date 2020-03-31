Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA6CC2D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E66220784
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnNNXS5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E66220784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJLqk-0002Q1-6i
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 14:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jJLq1-0001w3-6I
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jJLpz-00037B-Hs
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:42:13 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jJLpz-00035g-D3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:42:11 -0400
Received: by mail-io1-xd42.google.com with SMTP id c16so8431134iod.6
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EIR2xRZ5lXKktT+YCqIrNDpU2mnXhtZCDKqmtaElynM=;
 b=UnNNXS5SAsG/yqKlpG9AwG6jMvNvWIv4+ehW6Yibnrs2r6E4t4AlIzmTpB2E4jjzVh
 ZZeHa9+yqLOOrDe0/ACXb3qC4dqHnc7MWI1lXRSzwnz6fbwDSXs0Nv+t//dOmRq5giKR
 I4+h1OqFzg0eXZoPLRkizq5DUpeJ4I/nPds+R2OMtRverpgOME+Anb8/HH1gCmKA4GYc
 XlIrX8SGxE5o3bkKwSk2U1086IaiCJKpVzzPIusu+gqDzL+LUqAj3oa+YwGjdqrH53VQ
 9HYh5STXFOeLvE0STNuZY9iun7cbNBvtWT6NOwCMgC+5W5KIQJhaSvPdt/bjSwN2cHjs
 WsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EIR2xRZ5lXKktT+YCqIrNDpU2mnXhtZCDKqmtaElynM=;
 b=ahZMp/lLw3cPsYGiAdR3DjRT6/PlEkTmx+ikmVWDGEafK7TZN5yVzS1Sdaiu8wOJBd
 2QWlh26Locj1sd4lzmYb6UhR318F8TyCp0HQW1cE8qZ86M3FpVJvUn6JnAHhvgfQtZXf
 nL5pfsVZBnof1XYwQ7lKDnf30v51RIBvYH7JX8L/OL770BM2yeHyvn3U0XpJmhWo2RRm
 nLDU4S6UhBO714721+h93hC/WzOB+V5wQVoIcziyAGBdenNu4GW0jAqbRNcb/R+JrYEM
 OUov/zSGnlnwem5LyVe7hsZKGc3j3UA81H2o4rfLsqpc42nHI2B/l9OyEoFZReKJ+2h4
 WWFw==
X-Gm-Message-State: ANhLgQ2X/W5F+lKsAfbDuLacR9rrR1tfusZS0ak7hFe/VEEObfs5WWN9
 TA1lUoB6xpdVHkTExMJtS6MduO0tjLvv7lWnxVE=
X-Google-Smtp-Source: ADFU+vs8TG3WqgbISEeSiqILWmYjfuvx4GBX4XB2SpREAlSun2nVWYMxoT1WBZyWIRS2GCJcoTZW7pFWvqaOIy2Q6aQ=
X-Received: by 2002:a05:6602:2434:: with SMTP id
 g20mr15940931iob.97.1585680130235; 
 Tue, 31 Mar 2020 11:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200329001705.15966-1-pauldzim@gmail.com>
 <20200331092831.4s2smc4wtbslzirw@sirius.home.kraxel.org>
 <8e9e419c-9249-1070-bbc7-d927ca69fda5@redhat.com>
In-Reply-To: <8e9e419c-9249-1070-bbc7-d927ca69fda5@redhat.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Tue, 31 Mar 2020 11:41:59 -0700
Message-ID: <CADBGO78vOypXTdw5adcdPb3f_k97_KLBq9E0nAKCscgbL5f1ow@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] dwc-hsotg (aka dwc2) USB host controller emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e3e64005a22aecb7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e3e64005a22aecb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 4:16 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 3/31/20 11:28 AM, Gerd Hoffmann wrote:
> > On Sat, Mar 28, 2020 at 05:16:59PM -0700, Paul Zimmerman wrote:
> >> This patch series adds emulation for the dwc-hsotg USB controller,
> >> which is used on the Raspberry Pi 3 and earlier, as well as a number
> >> of other development boards. The main benefit for Raspberry Pi is that
> >> this enables networking on these boards, since the network adapter is
> >> attached via USB.
> >>
> >> The emulation is working quite well, I have tested with USB network,
> >> mass storage, mouse, keyboard, and tablet. I have tested with the dwc2
> >> driver in the upstream Linux kernel, and with the dwc-otg driver in th=
e
> >> Raspbian kernel. One remaining issue is that USB redirection does not
> >> work, I tried connecting to a USB stick on the host, but the device
> >> generates babble errors and does not work. I will continue to work on
> >> this issue.
> >>
> >> The patch series also includes a very basic emulation of the MPHI
> >> device on the Raspberry Pi SOC, which provides the FIQ interrupt that
> >> is used by the dwc-otg driver in the Raspbian kernel. But that driver
> >> still does not work in full FIQ mode, so it is necessary to add a
> >> parameter to the kernel command line ("dwc_otg.fiq_fsm_enable=3D0") to
> >> make it work.
> >>
> >> I have used some on-line sources of information while developing
> >> this emulation, including:
> >>
> >> http://www.capital-micro.com/PDF/CME-M7_Family_User_Guide_EN.pdf
> >> has a pretty complete description of the controller starting on
> >> page 370.
> >>
> >>
> https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/docs/DataShee=
ts/RT3050_5x_V2.0_081408_0902.pdf
> >> has a description of the controller registers starting on page
> >> 130.
> >>
> >> Changes from v1:
> >>    - Fixed checkpatch errors/warnings, except for dwc2-regs.h since
> >>      that is a direct import from the Linux kernel.
> >>    - Switched from debug printfs to tracepoints in hcd-dwc2.c, on the
> >>      advice of Gerd. I just dropped the debug prints in bcm2835_mphi.c=
,
> >>      since I didn't consider them very useful.
> >>    - Updated a couple of the commit messages with more info.
> >>
> >> Thanks for your time,
> >> Paul
> >
> > Looks good to me.  We are in 5.0 freeze now though, so this has to wait
> > until the tree is open for 5.1 development.
>
> Plenty of time to complete this series with an acceptance test using
> your device :)
>
> As a starting point you can look at do_test_arm_raspi2() in
> tests/acceptance/boot_linux_console.py.
>
> Regards,
>
> Phil.
>
>
 Ok Phil, I will look into that.

Thanks,
Paul

--000000000000e3e64005a22aecb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>On Tue, Mar 31, 2020 at 4:16 AM Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br></div><d=
iv><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 3/31/20 11:=
28 AM, Gerd Hoffmann wrote:<br>
&gt; On Sat, Mar 28, 2020 at 05:16:59PM -0700, Paul Zimmerman wrote:<br>
&gt;&gt; This patch series adds emulation for the dwc-hsotg USB controller,=
<br>
&gt;&gt; which is used on the Raspberry Pi 3 and earlier, as well as a numb=
er<br>
&gt;&gt; of other development boards. The main benefit for Raspberry Pi is =
that<br>
&gt;&gt; this enables networking on these boards, since the network adapter=
 is<br>
&gt;&gt; attached via USB.<br>
&gt;&gt;<br>
&gt;&gt; The emulation is working quite well, I have tested with USB networ=
k,<br>
&gt;&gt; mass storage, mouse, keyboard, and tablet. I have tested with the =
dwc2<br>
&gt;&gt; driver in the upstream Linux kernel, and with the dwc-otg driver i=
n the<br>
&gt;&gt; Raspbian kernel. One remaining issue is that USB redirection does =
not<br>
&gt;&gt; work, I tried connecting to a USB stick on the host, but the devic=
e<br>
&gt;&gt; generates babble errors and does not work. I will continue to work=
 on<br>
&gt;&gt; this issue.<br>
&gt;&gt;<br>
&gt;&gt; The patch series also includes a very basic emulation of the MPHI<=
br>
&gt;&gt; device on the Raspberry Pi SOC, which provides the FIQ interrupt t=
hat<br>
&gt;&gt; is used by the dwc-otg driver in the Raspbian kernel. But that dri=
ver<br>
&gt;&gt; still does not work in full FIQ mode, so it is necessary to add a<=
br>
&gt;&gt; parameter to the kernel command line (&quot;dwc_otg.fiq_fsm_enable=
=3D0&quot;) to<br>
&gt;&gt; make it work.<br>
&gt;&gt;<br>
&gt;&gt; I have used some on-line sources of information while developing<b=
r>
&gt;&gt; this emulation, including:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://www.capital-micro.com/PDF/CME-M7_Family_User_Gui=
de_EN.pdf" rel=3D"noreferrer" target=3D"_blank">http://www.capital-micro.co=
m/PDF/CME-M7_Family_User_Guide_EN.pdf</a><br>
&gt;&gt; has a pretty complete description of the controller starting on<br=
>
&gt;&gt; page 370.<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/=
tree/docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf" rel=3D"noreferrer" tar=
get=3D"_blank">https://sourceforge.net/p/wive-ng/wive-ng-mt/ci/master/tree/=
docs/DataSheets/RT3050_5x_V2.0_081408_0902.pdf</a><br>
&gt;&gt; has a description of the controller registers starting on page<br>
&gt;&gt; 130.<br>
&gt;&gt;<br>
&gt;&gt; Changes from v1:<br>
&gt;&gt;=C2=A0 =C2=A0 - Fixed checkpatch errors/warnings, except for dwc2-r=
egs.h since<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 that is a direct import from the Linux kernel.=
<br>
&gt;&gt;=C2=A0 =C2=A0 - Switched from debug printfs to tracepoints in hcd-d=
wc2.c, on the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 advice of Gerd. I just dropped the debug print=
s in bcm2835_mphi.c,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 since I didn&#39;t consider them very useful.<=
br>
&gt;&gt;=C2=A0 =C2=A0 - Updated a couple of the commit messages with more i=
nfo.<br>
&gt;&gt;<br>
&gt;&gt; Thanks for your time,<br>
&gt;&gt; Paul<br>
&gt; <br>
&gt; Looks good to me.=C2=A0 We are in 5.0 freeze now though, so this has t=
o wait<br>
&gt; until the tree is open for 5.1 development.<br>
<br>
Plenty of time to complete this series with an acceptance test using <br>
your device :)<br>
<br>
As a starting point you can look at do_test_arm_raspi2() in <br>
tests/acceptance/boot_linux_console.py.<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=
=A0Ok Phil, I will look into that.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Thanks,</div><div dir=3D"auto">Paul</div><div dir=3D"auto"><br><=
/div>

--000000000000e3e64005a22aecb7--

