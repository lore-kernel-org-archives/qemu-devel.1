Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5062077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiEjThez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5062077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifDmd-00007A-Pg
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 21:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1ifDli-0007iE-JR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1ifDlh-0005yz-95
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:59:54 -0500
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f]:36743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1ifDlh-0005y9-2H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:59:53 -0500
Received: by mail-io1-xd2f.google.com with SMTP id a22so1007349ios.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 17:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g2MEStZHgklXECG0Fp6oGTbxRX0/dGtbYQ71kbrKYe4=;
 b=MiEjThezEyyFeIFwc8T6v64ifPczZhf8AH8bB5YfNacKbcjFixeN1kmIHryN/O+pCN
 sI28qodzMVt/XJr6tG7JAziarYKip8QX9H3hw6p/tRYB4cVH8NQoMrVJhRmfSdRvMvPu
 Rgzsjryz7VjtQOLOVIB48vHM5Dw6H066itTelTizIqgUE4953qZCzEAHw4DwMFMAQtsI
 uYsXIW4a7ZvsmI1OwDuQ1+tPRcrOCPTMmpmNxvRXCJH4NL0YCMytghtAamJL8WLpc4tF
 YgZfJQgmimSi7HhFmANMyk7jhKFIbvCzTZpW0FKavwC7UgWpFc8spcfqvEK/dKvTU9aC
 gvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g2MEStZHgklXECG0Fp6oGTbxRX0/dGtbYQ71kbrKYe4=;
 b=AgNsXpBqxpMGYowdnMxqJZuFrIabM+HL9lW2FvxRR1O2Zwx6rjxzNN1fbxNUzotRZz
 KzMVe/BKD0FgZbu2ciwbXwdC0EGT+eyRHoCGj6cOEdHS5O2bBi5vODqve8bkp+iP5HCs
 GOM7IKAkGw1CPVBRxvHU/NEIRaVQDhQAZkc6ufEcVyeFF32UH7xtkl+SNtO9EmbmNQY8
 f7APe4EWVgb2SVk2MGVIEXEeH/6lkZbmQgJ66F+3jMTSXzmHRdrIYUfOc3dQ4WFyWpZe
 aiqRNGROjithrmhWWTsMLZTmJ7Qx0k/bgCPP5v/smKa3RgCvv33kzyA8qeu1ZeTBHnqB
 1q9g==
X-Gm-Message-State: APjAAAWeIgruzWadASlPURm0OkBARWYqtVidrs80ULrBLccoFvtdn0ia
 O90ps7vro5x5WqEYmAvSmWhxxfj9B1KbqZ6FSQoyX5x0
X-Google-Smtp-Source: APXvYqxryzILs5Q21DypDjETgh9W5WaayW4S7GUlpzHqp3zuTIczMJ5Wvbk8mAi+WmukppK8MhaGQf9PSRRYrnVgKiM=
X-Received: by 2002:a02:aa10:: with SMTP id r16mr6267123jam.48.1576115991943; 
 Wed, 11 Dec 2019 17:59:51 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nrhkOhiJDxnANGmAu2140-TP0a9pY58i_PN1k9xAWGz9A@mail.gmail.com>
 <76b207cd-09ce-b3df-e288-a515df40677e@redhat.com>
In-Reply-To: <76b207cd-09ce-b3df-e288-a515df40677e@redhat.com>
From: Wayne Li <waynli329@gmail.com>
Date: Wed, 11 Dec 2019 19:59:40 -0600
Message-ID: <CAM2K0nph2GZQkAv3tCgoP+ciPMWSzVJp0rHDXJJ2Gtqeq2Bgug@mail.gmail.com>
Subject: Re: QEMU VM crashes when enabling KVM
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d3257e0599781922"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2f
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d3257e0599781922
Content-Type: text/plain; charset="UTF-8"

We wrote a project that is created on top of the QEMU source code; it calls
functions from the QEMU code.  I run the executable created by compiling
that project/QEMU code.  Anyway, looking at the following documentation:

https://www.kernel.org/doc/Documentation/powerpc/cpu_families.txt

It looks like the PowerPC 7457 is Book3S and the PowerPC e6500 is BookE.
Is that why you think I require a Book3S KVM?  Exactly why do you feel this
way?  Also would that mean my team would need to go and buy a board with a
Book3S processor?

-Thanks!, Wayne Li

From my understanding

On Wed, Dec 11, 2019 at 7:16 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/12/19 22:23, Wayne Li wrote:
> >
> > Now I am fairly sure KVM is actually enabled on the system.  Finding
> > that out was another story that spanned a couple of months.  But long
> > story short, lsmod doesn't show that the KVM kernel module is running.
> > But that's because KVM is built-in and it can't actually be built as a
> > loadable kernel module in this particular system.
> >
> > So I'm not really sure what could be the problem.  Though I was thinking
> > if I understood the error better that might help?  Following the code I
> > see that the "Missing PVR setting capability." is called when a variable
> > called "cap_segstate" is 0:
> >
> > if (!cap_segstate) {
> >             fprintf(stderr, "kvm error: missing PVR setting
> capability\n");
> >             return -ENOSYS;
> > }
> >
> > And the cap_segstate variable is set by the following function:
> >
> > cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
>
> You are not saying how you are running QEMU.  I think you are using a
> CPU model that requires a Book3S KVM.
>
> Paolo
>
>

--000000000000d3257e0599781922
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>We wrote a project that is created on top of the QEMU=
 source code; it calls functions from the QEMU code.=C2=A0 I run the execut=
able created by compiling that project/QEMU code.=C2=A0 Anyway, looking at =
the following documentation:</div><div><br></div><div><a href=3D"https://ww=
w.kernel.org/doc/Documentation/powerpc/cpu_families.txt">https://www.kernel=
.org/doc/Documentation/powerpc/cpu_families.txt</a></div><div><br></div><di=
v>It looks like the PowerPC 7457 is Book3S and the PowerPC e6500 is BookE.=
=C2=A0 Is that why you think I require a Book3S KVM?=C2=A0 Exactly why do y=
ou feel this way?=C2=A0 Also would that mean my team would need to go and b=
uy a board with a Book3S processor?</div><div><br></div><div>-Thanks!, Wayn=
e Li<br></div><div><br></div><div>From my understanding</div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 11=
, 2019 at 7:16 PM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">=
pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 11/12/19 22:23, Wayne Li wrote:<br>
&gt; <br>
&gt; Now I am fairly sure KVM is actually enabled on the system.=C2=A0 Find=
ing<br>
&gt; that out was another story that spanned a couple of months.=C2=A0 But =
long<br>
&gt; story short, lsmod doesn&#39;t show that the KVM kernel module is runn=
ing.=C2=A0<br>
&gt; But that&#39;s because KVM is built-in and it can&#39;t actually be bu=
ilt as a<br>
&gt; loadable kernel module in this particular system.<br>
&gt; <br>
&gt; So I&#39;m not really sure what could be the problem.=C2=A0 Though I w=
as thinking<br>
&gt; if I understood the error better that might help?=C2=A0 Following the =
code I<br>
&gt; see that the &quot;Missing PVR setting capability.&quot; is called whe=
n a variable<br>
&gt; called &quot;cap_segstate&quot; is 0:<br>
&gt; <br>
&gt; if (!cap_segstate) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;kvm er=
ror: missing PVR setting capability\n&quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOSYS;<br>
&gt; }<br>
&gt; <br>
&gt; And the cap_segstate variable is set by the following function:<br>
&gt; <br>
&gt; cap_segstate =3D kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);<br>
<br>
You are not saying how you are running QEMU.=C2=A0 I think you are using a<=
br>
CPU model that requires a Book3S KVM.<br>
<br>
Paolo<br>
<br>
</blockquote></div>

--000000000000d3257e0599781922--

