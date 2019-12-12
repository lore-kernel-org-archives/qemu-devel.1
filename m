Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1734C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7894214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF+0KBFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7894214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSUl-0005lO-FX
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1ifRWM-0006sr-PB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1ifRWL-0003XD-9X
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:58 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a]:45566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1ifRWL-0003VY-2o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:57 -0500
Received: by mail-il1-x12a.google.com with SMTP id p8so2546679iln.12
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=upLgELSf8R+QsnNRw5FD11DZTxjBQGJ3nZZeCzba1TM=;
 b=GF+0KBFkLkZ10T96ryuhOhGA48mwVCmnEFLYFFeF2NtCvTSWvUcYOWnyT8yqnqCrRI
 PjAD/mbTlGyYrQWKwIGkzCkMmAfww3Mirn0+pZ8GkfdV19Vz6NJjIz8AJRWr6NXqtxE/
 BkDCfsDh1LY0msnl3yg3wXkfbeWV+b9NxuGh034vCHPd0T7bd0qWcQ+rT7lvDbsfXIQu
 pvsCLDNpdjHPlMR99LGEQjgq0MMNi3YAWbHsLs1GxeLrgZJW/zQ43FCkCGbXRl6IdRNZ
 0E+H+e9IQHL3QsBQmMqSUCRADzkL6k2+NAYg5kXUlWMNPPTcVClo2GOXaWABq60APUEN
 dung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=upLgELSf8R+QsnNRw5FD11DZTxjBQGJ3nZZeCzba1TM=;
 b=gd8NV5CSOk/k2RjgJbQmPPWqkNedMM5aj6u2aZJiZQ5J9pCQFbfisSaCxnu+bhzvU6
 hQku0RDwAt7CjLcP1RctBh03Enz++qJFL/UfU5WzSVWR77+tk4v4Qi4qG80C0uYON2eU
 4nc7jk62IFosXpYdtfGEvqqLb8PEqkYiScIxkKO4If83j8TzzP/jB4TpdVGUECRMHlfg
 Qsp2Bkt/rNp/euB0k2fWPU134Xl/hNSk71hzXBiG9S7WrjSYkcW1XjMSarwRq1SLaFVe
 R7FmpPbX2y1dGh4ntNVkN2oTZCR/TOIPJMj0/8+hc+B1m5WJgs/wyQCEEr6p7XLQpEMx
 ZzNQ==
X-Gm-Message-State: APjAAAUpr70ijD0G2TmWLl2Jqjp7DLgFUbHPajHTaMjnTVTrVps9m9nD
 CZfUAFAxmBejxiUa6y1ovo/hRugdUSZ3BbWREwo=
X-Google-Smtp-Source: APXvYqyfWEsqFudLcd0xX2ZJCiW+oAbGSynHEkd9ywLdtmn1sc7zuwpQOS2LL/70kDpHY5Qz33VcpCesX9yECV1sI8s=
X-Received: by 2002:a92:b749:: with SMTP id c9mr8854127ilm.143.1576168856071; 
 Thu, 12 Dec 2019 08:40:56 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nrhkOhiJDxnANGmAu2140-TP0a9pY58i_PN1k9xAWGz9A@mail.gmail.com>
 <76b207cd-09ce-b3df-e288-a515df40677e@redhat.com>
 <CAM2K0nph2GZQkAv3tCgoP+ciPMWSzVJp0rHDXJJ2Gtqeq2Bgug@mail.gmail.com>
 <c4e14191-efe5-7713-1eac-55a6bafb027a@redhat.com>
In-Reply-To: <c4e14191-efe5-7713-1eac-55a6bafb027a@redhat.com>
From: Wayne Li <waynli329@gmail.com>
Date: Thu, 12 Dec 2019 10:40:44 -0600
Message-ID: <CAM2K0no9-M9WRm-QKFBMRofUaNkfmMtDvop3KxrOQrU80YWSTA@mail.gmail.com>
Subject: Re: QEMU VM crashes when enabling KVM
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c5b38b0599846864"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12a
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
Cc: David Gibson <dgibson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c5b38b0599846864
Content-Type: text/plain; charset="UTF-8"

Dear David Gibson,

I know you are under no obligation to respond, but if it's possible for you
to find the time to respond to my question, I would be extremely grateful.
My team at Boeing has been stuck trying to get KVM working for our project
for the last few months.  A good explanation of why this isn't possible
would be absolutely critical.

-Thanks, Wayne Li

On Thu, Dec 12, 2019 at 1:17 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 12/12/19 02:59, Wayne Li wrote:
> > We wrote a project that is created on top of the QEMU source code; it
> > calls functions from the QEMU code.  I run the executable created by
> > compiling that project/QEMU code.  Anyway, looking at the following
> > documentation:
> >
> > https://www.kernel.org/doc/Documentation/powerpc/cpu_families.txt
> >
> > It looks like the PowerPC 7457 is Book3S and the PowerPC e6500 is
> > BookE.  Is that why you think I require a Book3S KVM?  Exactly why do
> > you feel this way?  Also would that mean my team would need to go and
> > buy a board with a Book3S processor?
>
> CCing the PPC maintainer.  There are aspects of BookE and Book3S that
> are different and not really interchangeable in the privileged interface.
>
> Paolo
>
> > -Thanks!, Wayne Li
> >
> > From my understanding
> >
> > On Wed, Dec 11, 2019 at 7:16 PM Paolo Bonzini <pbonzini@redhat.com
> > <mailto:pbonzini@redhat.com>> wrote:
> >
> >     On 11/12/19 22:23, Wayne Li wrote:
> >     >
> >     > Now I am fairly sure KVM is actually enabled on the system.
> Finding
> >     > that out was another story that spanned a couple of months.  But
> long
> >     > story short, lsmod doesn't show that the KVM kernel module is
> >     running.
> >     > But that's because KVM is built-in and it can't actually be built
> as a
> >     > loadable kernel module in this particular system.
> >     >
> >     > So I'm not really sure what could be the problem.  Though I was
> >     thinking
> >     > if I understood the error better that might help?  Following the
> >     code I
> >     > see that the "Missing PVR setting capability." is called when a
> >     variable
> >     > called "cap_segstate" is 0:
> >     >
> >     > if (!cap_segstate) {
> >     >             fprintf(stderr, "kvm error: missing PVR setting
> >     capability\n");
> >     >             return -ENOSYS;
> >     > }
> >     >
> >     > And the cap_segstate variable is set by the following function:
> >     >
> >     > cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
> >
> >     You are not saying how you are running QEMU.  I think you are using a
> >     CPU model that requires a Book3S KVM.
> >
> >     Paolo
> >
>
>

--000000000000c5b38b0599846864
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear David Gibson,</div><div><br></div><div>I know yo=
u are under no obligation to respond, but if it&#39;s possible for you to f=
ind the time to respond to my question, I would be extremely grateful.=C2=
=A0 My team at Boeing has been stuck trying to get KVM working for our proj=
ect for the last few months.=C2=A0 A good explanation of why this isn&#39;t=
 possible would be absolutely critical.</div><div><br></div><div>-Thanks, W=
ayne Li<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Thu, Dec 12, 2019 at 1:17 AM Paolo Bonzini &lt;<a href=
=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On 12/12/19 02:59, Wayne=
 Li wrote:<br>
&gt; We wrote a project that is created on top of the QEMU source code; it<=
br>
&gt; calls functions from the QEMU code.=C2=A0 I run the executable created=
 by<br>
&gt; compiling that project/QEMU code.=C2=A0 Anyway, looking at the followi=
ng<br>
&gt; documentation:<br>
&gt; <br>
&gt; <a href=3D"https://www.kernel.org/doc/Documentation/powerpc/cpu_famili=
es.txt" rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/Doc=
umentation/powerpc/cpu_families.txt</a><br>
&gt; <br>
&gt; It looks like the PowerPC 7457 is Book3S and the PowerPC e6500 is<br>
&gt; BookE.=C2=A0 Is that why you think I require a Book3S KVM?=C2=A0 Exact=
ly why do<br>
&gt; you feel this way?=C2=A0 Also would that mean my team would need to go=
 and<br>
&gt; buy a board with a Book3S processor?<br>
<br>
CCing the PPC maintainer.=C2=A0 There are aspects of BookE and Book3S that<=
br>
are different and not really interchangeable in the privileged interface.<b=
r>
<br>
Paolo<br>
<br>
&gt; -Thanks!, Wayne Li<br>
&gt; <br>
&gt; From my understanding<br>
&gt; <br>
&gt; On Wed, Dec 11, 2019 at 7:16 PM Paolo Bonzini &lt;<a href=3D"mailto:pb=
onzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pb=
onzini@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 11/12/19 22:23, Wayne Li wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Now I am fairly sure KVM is actually enabled o=
n the system.=C2=A0 Finding<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; that out was another story that spanned a coup=
le of months.=C2=A0 But long<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; story short, lsmod doesn&#39;t show that the K=
VM kernel module is<br>
&gt;=C2=A0 =C2=A0 =C2=A0running.=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; But that&#39;s because KVM is built-in and it =
can&#39;t actually be built as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; loadable kernel module in this particular syst=
em.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; So I&#39;m not really sure what could be the p=
roblem.=C2=A0 Though I was<br>
&gt;=C2=A0 =C2=A0 =C2=A0thinking<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; if I understood the error better that might he=
lp?=C2=A0 Following the<br>
&gt;=C2=A0 =C2=A0 =C2=A0code I<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; see that the &quot;Missing PVR setting capabil=
ity.&quot; is called when a<br>
&gt;=C2=A0 =C2=A0 =C2=A0variable<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; called &quot;cap_segstate&quot; is 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; if (!cap_segstate) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fpri=
ntf(stderr, &quot;kvm error: missing PVR setting<br>
&gt;=C2=A0 =C2=A0 =C2=A0capability\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn -ENOSYS;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; And the cap_segstate variable is set by the fo=
llowing function:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; cap_segstate =3D kvm_check_extension(s, KVM_CA=
P_PPC_SEGSTATE);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You are not saying how you are running QEMU.=C2=A0 =
I think you are using a<br>
&gt;=C2=A0 =C2=A0 =C2=A0CPU model that requires a Book3S KVM.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Paolo<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000c5b38b0599846864--

