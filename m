Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D4ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F1F21721
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWt+N6yp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F1F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0XO-0007iW-7l
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 09:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hikarupsp@gmail.com>) id 1iK0WW-0007Br-RN
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hikarupsp@gmail.com>) id 1iK0WV-0007KM-Bf
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:36:32 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hikarupsp@gmail.com>) id 1iK0WV-0007JA-2K
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:36:31 -0400
Received: by mail-lf1-x141.google.com with SMTP id w6so11844259lfl.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M7muMaRGdySjctJHLqn93iIPgEWy6N1snIXvbQwTFqU=;
 b=FWt+N6ypO/7yz9+Px3zz5p6RR4pATnNpVPq65oAx4JMf7K5NvRiEsePgfDELqDoAYl
 R/y/LI3UrIe4vHssqocHuREvVAoRh3Y5vDfeFlpU6vyV17IsCnYW20zPlgdpJ+LFofqs
 uniPAIw70aQWXfW+vdbm3zqBONXTWcyXU4bbjX13yatYVEGfCKI+oHq1hMDbfwRYOOiP
 W/PHpDPsq8VYkSU0mwX/3yOJgJwmz5tHOZsBdHJb7460Sytx653cGFo0cVOT4Y0/w+7i
 r0867kJfJbDYI61aVMSJRlywYVSMObiXULuvHwNO1EjyqM8OlUyQ+kghakVYu4GRSwRS
 InxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M7muMaRGdySjctJHLqn93iIPgEWy6N1snIXvbQwTFqU=;
 b=mjsoxCAxUbDxTrtoUmVCMRHYLRdsiVZNN0q/yikqQaTtObD2C2RNB/TubMeV7KEzyH
 vdBO7c9db8ojhjejeuHcOAwacRSyFbRRFSatKswK+lqZ5aX4kY3wfY26ykRf7sYDhX7W
 3kkFtVnx9TbabNC7Gbf5fHavjm8AJHQ6sXGVw7fvOqvXUjjj2Azg8loVfECEAktW5914
 mjCckcRy3EeBVZwchQv7kIFdkF6f/5UPGGfmJWE5WlIeTwHMcpX0CtvRB12au/+mKz0D
 XJRBzi8fXOvIDvcEdwso4AD7KA+UGyZQx67Ltz/ItebdTTGgfvMG6mgyef4CEvRK+D4j
 PmSw==
X-Gm-Message-State: APjAAAV6Wov1bL+IHS7VGWJqu/Qq8xOPJK9XvOMt45Lh/4M/LSu9zIDr
 sLPamLIsXMTGyp2eW3MWsI0EFQDCDajT4J8Cb4U=
X-Google-Smtp-Source: APXvYqyc8g1VxOUF8v3KkaNkWmCPblVaQJPJHu1NlhCOwe49xh4u6kvQiQXxRJ42xU1Nxh2Wtd8wjMMXZXe+Jncmi+U=
X-Received: by 2002:ac2:5219:: with SMTP id a25mr17900202lfl.62.1571060189148; 
 Mon, 14 Oct 2019 06:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191014125254.74913-1-hikarupsp@gmail.com>
 <CAFEAcA-iaUraj+AZuGcXw6pNy2aBQ2J0Cm9900COsY+quJc2tA@mail.gmail.com>
In-Reply-To: <CAFEAcA-iaUraj+AZuGcXw6pNy2aBQ2J0Cm9900COsY+quJc2tA@mail.gmail.com>
From: Hikaru Nishida <hikarupsp@gmail.com>
Date: Mon, 14 Oct 2019 22:36:17 +0900
Message-ID: <CAD-w0GC+MAr-tP=XuCtCGYeVcoSYTYFWw9Ud5Qm_1_cu=tg7nA@mail.gmail.com>
Subject: Re: [PATCH] This patch fixes hanging up Cocoa display on macOS 10.15
 (Catalina)
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000007ebaea0594def49b"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007ebaea0594def49b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your reply.

The event gets fired before applicationDidFinishLaunching is: (output of
 NSLog(@"event: %@", event);)
event: NSEvent: type=3DKitdefined loc=3D(0,1440) time=3D164310.0 flags=3D0x=
40
win=3D0x0 winNum=3D0 ctxt=3D0x0 subtype=3D1 data1=3D834 data2=3D0

I moved allow_events =3D true just before qemu_sem_post(&app_started_sem) a=
nd
it also works.


Hikaru Nishida

2019=E5=B9=B410=E6=9C=8814=E6=97=A5(=E6=9C=88) 22:19 Peter Maydell <peter.m=
aydell@linaro.org>:

> On Mon, 14 Oct 2019 at 13:53, <hikarupsp@gmail.com> wrote:
> >
> > From: Hikaru Nishida <hikarupsp@gmail.com>
> >
> > An NSEvent is fired before applicationDidFinishLaunching on macOS
> > Catalina. This causes deadlock of iothread_lock by calling
> > bool_with_iothread_lock in handleEvent while its already locked.
> > This patch prevents to call bool_with_iothread_lock until the
> > app_started_sem is released to prevent this deadlock.
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1847906
> > Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
> > ---
> >  ui/cocoa.m | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > index f12e21df6e..f16d341a0a 100644
> > --- a/ui/cocoa.m
> > +++ b/ui/cocoa.m
> > @@ -134,6 +134,7 @@
> >
> >  static QemuSemaphore display_init_sem;
> >  static QemuSemaphore app_started_sem;
> > +volatile sig_atomic_t allow_events;
> >
> >  // Utility functions to run specified code block with iothread lock he=
ld
> >  typedef void (^CodeBlock)(void);
> > @@ -729,6 +730,9 @@ - (void) handleMonitorInput:(NSEvent *)event
> >
> >  - (bool) handleEvent:(NSEvent *)event
> >  {
> > +    if(!allow_events) {
> > +        return false;
> > +    }
> >      return bool_with_iothread_lock(^{
> >          return [self handleEventLocked:event];
> >      });
> > @@ -1897,6 +1901,7 @@ static void cocoa_display_init(DisplayState *ds,
> DisplayOptions *opts)
> >      /* Tell main thread to go ahead and create the app and enter the
> run loop */
> >      qemu_sem_post(&display_init_sem);
> >      qemu_sem_wait(&app_started_sem);
> > +    allow_events =3D true;
> >      COCOA_DEBUG("cocoa_display_init: app start completed\n");
>
> If we do use a flag to fix this race, I think it would be
> better to set allow_events =3D true in the
> applicationDidFinishLaunching() function before posting
> the app_started_sem. Otherwise there's a window after
> applicationDidFinishLaunching() returns but before
> cocoa_display_init() resumes and sets the flag where we
> will unnecessarily drop events.
>
> Could you try that and check that it still fixes the hang?
>
> thanks
> -- PMM
>

--0000000000007ebaea0594def49b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for your reply.<div><br></div><div>The event get=
s fired before applicationDidFinishLaunching is: (output of =C2=A0NSLog(@&q=
uot;event: %@&quot;, event);)</div><div>event: NSEvent: type=3DKitdefined l=
oc=3D(0,1440) time=3D164310.0 flags=3D0x40 win=3D0x0 winNum=3D0 ctxt=3D0x0 =
subtype=3D1 data1=3D834 data2=3D0</div><div><br></div><div>I moved=C2=A0all=
ow_events =3D true just before qemu_sem_post(&amp;app_started_sem) and it a=
lso works.</div><div><br></div><div><br></div><div>Hikaru Nishida</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">2019=
=E5=B9=B410=E6=9C=8814=E6=97=A5(=E6=9C=88) 22:19 Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt;:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 14 Oct 2019 =
at 13:53, &lt;<a href=3D"mailto:hikarupsp@gmail.com" target=3D"_blank">hika=
rupsp@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Hikaru Nishida &lt;<a href=3D"mailto:hikarupsp@gmail.com" target=
=3D"_blank">hikarupsp@gmail.com</a>&gt;<br>
&gt;<br>
&gt; An NSEvent is fired before applicationDidFinishLaunching on macOS<br>
&gt; Catalina. This causes deadlock of iothread_lock by calling<br>
&gt; bool_with_iothread_lock in handleEvent while its already locked.<br>
&gt; This patch prevents to call bool_with_iothread_lock until the<br>
&gt; app_started_sem is released to prevent this deadlock.<br>
&gt;<br>
&gt; Buglink: <a href=3D"https://bugs.launchpad.net/qemu/+bug/1847906" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1847=
906</a><br>
&gt; Signed-off-by: Hikaru Nishida &lt;<a href=3D"mailto:hikarupsp@gmail.co=
m" target=3D"_blank">hikarupsp@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 ui/cocoa.m | 5 +++++<br>
&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt;<br>
&gt; diff --git a/ui/cocoa.m b/ui/cocoa.m<br>
&gt; index f12e21df6e..f16d341a0a 100644<br>
&gt; --- a/ui/cocoa.m<br>
&gt; +++ b/ui/cocoa.m<br>
&gt; @@ -134,6 +134,7 @@<br>
&gt;<br>
&gt;=C2=A0 static QemuSemaphore display_init_sem;<br>
&gt;=C2=A0 static QemuSemaphore app_started_sem;<br>
&gt; +volatile sig_atomic_t allow_events;<br>
&gt;<br>
&gt;=C2=A0 // Utility functions to run specified code block with iothread l=
ock held<br>
&gt;=C2=A0 typedef void (^CodeBlock)(void);<br>
&gt; @@ -729,6 +730,9 @@ - (void) handleMonitorInput:(NSEvent *)event<br>
&gt;<br>
&gt;=C2=A0 - (bool) handleEvent:(NSEvent *)event<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 if(!allow_events) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return bool_with_iothread_lock(^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return [self handleEventLocked:event=
];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 });<br>
&gt; @@ -1897,6 +1901,7 @@ static void cocoa_display_init(DisplayState *ds,=
 DisplayOptions *opts)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Tell main thread to go ahead and create the app=
 and enter the run loop */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_sem_post(&amp;display_init_sem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_sem_wait(&amp;app_started_sem);<br>
&gt; +=C2=A0 =C2=A0 allow_events =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 COCOA_DEBUG(&quot;cocoa_display_init: app start co=
mpleted\n&quot;);<br>
<br>
If we do use a flag to fix this race, I think it would be<br>
better to set allow_events =3D true in the<br>
applicationDidFinishLaunching() function before posting<br>
the app_started_sem. Otherwise there&#39;s a window after<br>
applicationDidFinishLaunching() returns but before<br>
cocoa_display_init() resumes and sets the flag where we<br>
will unnecessarily drop events.<br>
<br>
Could you try that and check that it still fixes the hang?<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000007ebaea0594def49b--

