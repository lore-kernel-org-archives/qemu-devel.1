Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FE3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 03:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7255E20748
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 03:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="Zing5zcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7255E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibcox-00025I-Iz
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 22:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1ibco6-0001YM-Jm
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 22:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1ibco4-0005hF-M4
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 22:55:30 -0500
Received: from mail-yw1-xc29.google.com ([2607:f8b0:4864:20::c29]:45829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1ibco4-0005ev-DU
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 22:55:28 -0500
Received: by mail-yw1-xc29.google.com with SMTP id d12so342479ywl.12
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 19:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H+ptR2xnTCGhnDf7fx3Kk/lbKalfvDG+MZStBvWWW9o=;
 b=Zing5zcvOPg2zSqyiPvTT14+b5bDomN7PqoRneNqAiPwc/NelRvMkVCZfV5aSeWyo8
 xIHbugr9RCQaz7Vac6ZfjGGRIGmjysFOm21wKGxXnikjtjdcotpxYvoi6TLkt+5EIHk4
 tA7e4fTR2ELiCuMVZW+FzO4zSITEhlTqgD1zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H+ptR2xnTCGhnDf7fx3Kk/lbKalfvDG+MZStBvWWW9o=;
 b=mfuT7DhZ61lzYoTxe7bFC768NylNszBYh4Hp7uIkgJTsM6WS1NCfmr/Usod4RV7AMK
 6TA3fTMMTNFQ1k0EFkAGqNT5UcYFwavTsrCprv2d4tWNYnpCYRlaKlteWfrd/9ZoFQOe
 zPSE9h/FksvIostQgmGponDrcWPtCflM/3vcJhY/N6v4n9IZhdtKxOTjLFDE63NPcrLw
 xQmVF9bkgp07yOlioAqJOFGLs7BGkz1N2/Y47ey/scVZTC6N5tCCaK+6YhMivJcd+kmy
 1YEmybJHeKA3Km/2NKfGPylHY9prg8LDk0HFWbMqY3tY0dTCq8uDOySnnN/Smu2FaDmp
 63GQ==
X-Gm-Message-State: APjAAAVr8UnCNhWNOu57e0JOaCdjNzQt1FY1z3m+Gy6EIdyWCXVB/lL/
 MBf4DuqT11y54CPc5ter4CnfUW5CU5RQV38WZjvRHg==
X-Google-Smtp-Source: APXvYqxA8Kfnc+1E+nIXOtH3EMhIUroGt8OmpFONVnNClQO/QSpTKOepDDDxQD3ow9vkgnqLZdhYyX2gA9I3WDh13ng=
X-Received: by 2002:a0d:e84c:: with SMTP id r73mr20499585ywe.154.1575258926058; 
 Sun, 01 Dec 2019 19:55:26 -0800 (PST)
MIME-Version: 1.0
References: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
 <20191127105121.GA3017@work-vm>
 <9CFF81C0F6B98A43A459C9EDAD400D780631A02A@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4hY4TkeDM3EOhbLBTc5_P-PdF5ED3QR-C2CrfCV56aZA@mail.gmail.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780631C682@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D780631C682@shsmsx102.ccr.corp.intel.com>
From: Daniel Cho <danielcho@qnap.com>
Date: Mon, 2 Dec 2019 11:55:07 +0800
Message-ID: <CA+XQNE4N0_K2zQ1NDToJgu+Toy1X3iqOZyYyvtScMMsdVARACg@mail.gmail.com>
Subject: Re: Network connection with COLO VM
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="000000000000b7a8500598b08c2a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c29
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
Cc: "lukasstraub2@web.de" <lukasstraub2@web.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b7a8500598b08c2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhang,

We use qemu-4.1.0 release on this case.

I think we need use block mirror to sync the disk to secondary node first,
then stop the primary VM and build COLO system.

In the stop moment, you need add some netfilter and chardev socket node for
COLO, maybe you need re-check this part.


Our test was already follow those step. Maybe I could describe the detail
of the test flow and issues.


Step 1:

Create primary VM without any netfilter and chardev for COLO, and using
other host ping primary VM continually.


Step 2:

Create secondary VM (the same device/drive with primary VM), and do block
mirror sync ( ping to primary VM normally )


Step 3:

After block mirror sync finish, add those netfilter and chardev to primary
VM and secondary VM for COLO ( *Can't* ping to primary VM but those packets
will be received later )


Step 4:

Start migrate primary VM to secondary VM, and primary VM & secondary VM are
running ( ping to primary VM works and receive those packets on step 3
status )




Between Step 3 to Step 4, it will take 10~20 seconds in our environment.

I could image this issue (delay reply packets) is because of setting COLO
proxy for temporary status,

but we thought 10~20 seconds might a little long. (If primary VM is already
doing some jobs, it might lose the data.)


Could we reduce those time? or those delay is depends on different VM?


Best Regard,

Daniel Cho.



Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=8830=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:04=E5=AF=AB=E9=81=93=EF=BC=9A

>
>
>
>
> *From:* Daniel Cho <danielcho@qnap.com>
> *Sent:* Friday, November 29, 2019 10:43 AM
> *To:* Zhang, Chen <chen.zhang@intel.com>
> *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>; lukasstraub2@web.de;
> qemu-devel@nongnu.org
> *Subject:* Re: Network connection with COLO VM
>
>
>
> Hi David,  Zhang,
>
>
>
> Thanks for replying my question.
>
> We know why will occur this issue.
>
> As you said, the COLO VM's network needs
>
> colo-proxy to control packets, so the guest's
>
> interface should set the filter to solve the problem.
>
>
>
> But we found another question, when we set the
>
> fault-tolerance feature to guest (primary VM is running,
>
> secondary VM is pausing), the guest's network would not
>
> responds any request for a while (in our environment
>
> about 20~30 secs) after secondary VM runs.
>
>
>
> Does it be a normal situation, or a known issue?
>
>
>
> Our test is creating primary VM for a while, then creating
>
> secondary VM to make it with COLO feature.
>
>
>
> Hi Daniel,
>
>
>
> Happy to hear you have solved ssh disconnection issue.
>
>
>
> Do you use Lukas=E2=80=99s patch on this case?
>
> I think we need use block mirror to sync the disk to secondary node first=
,
> then stop the primary VM and build COLO system.
>
> In the stop moment, you need add some netfilter and chardev socket node
> for COLO, maybe you need re-check this part.
>
>
>
> Best Regard,
>
> Daniel Cho
>
>
>
> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:26=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
>
>
> > -----Original Message-----
> > From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Sent: Wednesday, November 27, 2019 6:51 PM
> > To: Daniel Cho <danielcho@qnap.com>; Zhang, Chen
> > <chen.zhang@intel.com>; lukasstraub2@web.de
> > Cc: qemu-devel@nongnu.org
> > Subject: Re: Network connection with COLO VM
> >
> > * Daniel Cho (danielcho@qnap.com) wrote:
> > > Hello everyone,
> > >
> > > Could we ssh to colo VM (means PVM & SVM are starting)?
> > >
> >
> > Lets cc in Zhang Chen and Lukas Straub.
>
> Thanks Dave.
>
> >
> > > SSH will connect to colo VM for a while, but it will disconnect with
> > > error
> > > *client_loop: send disconnect: Broken pipe*
> > >
> > > It seems to colo VM could not keep network session.
> > >
> > > Does it be a known issue?
> >
> > That sounds like the COLO proxy is getting upset; it's supposed to
> compare
> > packets sent by the primary and secondary and only send one to the
> outside
> > - you shouldn't be talking directly to the guest, but always via the
> proxy.  See
> > docs/colo-proxy.txt
> >
>
> Hi Daniel,
>
> I have try ssh to COLO guest with 8 hours, not occurred this issue.
> Please check your network/qemu configuration.
> But I found another problem maybe related this issue, if no network
> communication for a period of time(maybe 10min), the first message send t=
o
> guest have a chance with delay(maybe 1-5 sec), I will try to fix it when =
I
> have time.
>
> Thanks
> Zhang Chen
>
> > Dave
> >
> > > Best Regard,
> > > Daniel Cho
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>

--000000000000b7a8500598b08c2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Zhang,=C2=A0</div><div><br></div><div>We use qemu-=
4.1.0 release on this case.</div><div><br></div><div><p class=3D"MsoNormal"=
><font color=3D"#9900ff">I think we need use block mirror to sync the disk =
to secondary node first, then stop the primary VM and build COLO system.<u>=
</u><u></u></font></p>
<p class=3D"MsoNormal"><font color=3D"#9900ff">In the stop moment, you need=
 add some netfilter and chardev socket node for COLO, maybe you need re-che=
ck this part.</font></p><p class=3D"MsoNormal"><font color=3D"#9900ff"><br>=
</font></p><p class=3D"MsoNormal"><font color=3D"#000000">Our test was alre=
ady follow those step. Maybe I could describe the detail of the test flow a=
nd issues.</font></p><p class=3D"MsoNormal"><font color=3D"#000000"><br></f=
ont></p><p class=3D"MsoNormal"><font color=3D"#000000">Step 1:=C2=A0</font>=
</p><p class=3D"MsoNormal">Create primary VM without any netfilter and char=
dev for COLO, and<font color=3D"#ff0000"> using other host ping primary VM =
continually</font>.=C2=A0</p><p class=3D"MsoNormal"><br></p><p class=3D"Mso=
Normal">Step 2:=C2=A0</p><p class=3D"MsoNormal">Create secondary VM (the sa=
me device/drive with primary VM), and do block mirror sync (

<font color=3D"#ff0000">ping to primary VM normally </font>)</p><p class=3D=
"MsoNormal"><br></p><p class=3D"MsoNormal">Step 3:</p><p class=3D"MsoNormal=
">After block mirror sync finish, add those netfilter and chardev to primar=
y VM and secondary VM for COLO ( <font size=3D"4"><font color=3D"#ff0000"><=
b>Can&#39;t</b></font>=C2=A0</font><font color=3D"#ff0000">ping to primary =
VM but those packets will be received later=C2=A0</font>)</p><p class=3D"Ms=
oNormal"><br></p><p class=3D"MsoNormal">Step 4:=C2=A0</p><p class=3D"MsoNor=
mal">Start migrate primary VM to secondary VM, and primary VM &amp; seconda=
ry VM are running (

<font color=3D"#ff0000">ping to primary VM works and receive those packets =
on step 3 status=C2=A0</font>)</p><p class=3D"MsoNormal"><br></p><p class=
=3D"MsoNormal">=C2=A0<br></p><p class=3D"MsoNormal">Between Step 3 to Step =
4, it will take <font color=3D"#ff0000">10~20 seconds</font>=C2=A0in our en=
vironment.=C2=A0</p><p class=3D"MsoNormal">I could image this issue (delay =
reply packets) is because of setting COLO proxy for temporary status,</p><p=
 class=3D"MsoNormal">but we thought <font color=3D"#ff0000">10~20 seconds <=
/font><font color=3D"#000000">might a little long. (If primary VM is alread=
y doing some jobs, it might lose the data.)</font></p><p class=3D"MsoNormal=
"><font color=3D"#000000"><br></font></p><p class=3D"MsoNormal"><font color=
=3D"#000000">Could we reduce those time? or those delay is depends on diffe=
rent VM?</font></p><p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Be=
st Regard,</p><p class=3D"MsoNormal">Daniel Cho.</p><p class=3D"MsoNormal">=
<br></p></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com">chen.zhang@=
intel.com</a>&gt; =E6=96=BC 2019=E5=B9=B411=E6=9C=8830=E6=97=A5 =E9=80=B1=
=E5=85=AD =E4=B8=8A=E5=8D=882:04=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div class=3D"gmail-m_-7246858957356585846WordSection1">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><a name=3D"m_-7246858957356585846______replyseparato=
r"></a><b>From:</b> Daniel Cho &lt;<a href=3D"mailto:danielcho@qnap.com" ta=
rget=3D"_blank">danielcho@qnap.com</a>&gt;
<br>
<b>Sent:</b> Friday, November 29, 2019 10:43 AM<br>
<b>To:</b> Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=
=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
<b>Cc:</b> Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com=
" target=3D"_blank">dgilbert@redhat.com</a>&gt;; <a href=3D"mailto:lukasstr=
aub2@web.de" target=3D"_blank">lukasstraub2@web.de</a>; <a href=3D"mailto:q=
emu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a><br>
<b>Subject:</b> Re: Network connection with COLO VM<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Hi David,=C2=A0 Zhang,=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks for replying my question.=C2=A0<u></u><u></u>=
</p>
</div>
<div>
<p class=3D"MsoNormal">We know why will occur this issue.=C2=A0<u></u><u></=
u></p>
</div>
<div>
<p class=3D"MsoNormal">As you said, the COLO VM&#39;s network needs=C2=A0<u=
></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">colo-proxy to control packets, so the guest&#39;s=C2=
=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">interface should set the filter to solve=C2=A0the pr=
oblem.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">But we found another question, when we set the=C2=A0=
<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">fault-tolerance feature to guest (primary VM is runn=
ing,=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">secondary VM is pausing), the guest&#39;s network wo=
uld not=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">responds any request for a while (in our environment=
=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">about 20~30 secs) after secondary VM runs.<u></u><u>=
</u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Does it be a normal situation, or a known issue?=C2=
=A0=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Our test is creating primary VM for a while, then cr=
eating=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">secondary VM to make it with COLO feature.<u></u><u>=
</u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Hi Daniel,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Happy to hear you have solved ssh disconnection issu=
e.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Do you use Lukas=E2=80=99s patch on this case?<u></u=
><u></u></p>
<p class=3D"MsoNormal">I think we need use block mirror to sync the disk to=
 secondary node first, then stop the primary VM and build COLO system.<u></=
u><u></u></p>
<p class=3D"MsoNormal">In the stop moment, you need add some netfilter and =
chardev socket node for COLO, maybe you need re-check this part.<u></u><u><=
/u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Best Regard,=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Daniel Cho=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<div>
<p class=3D"MsoNormal">Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.c=
om" target=3D"_blank">chen.zhang@intel.com</a>&gt;
<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E6=96=BC</span> 2019<s=
pan lang=3D"ZH-CN" style=3D"font-family:DengXian">=E5=B9=B4</span>11<span l=
ang=3D"ZH-CN" style=3D"font-family:DengXian">=E6=9C=88</span>28<span lang=
=3D"ZH-CN" style=3D"font-family:DengXian">=E6=97=A5</span><span lang=3D"ZH-=
CN">
</span><span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E9=80=B1=E5=9B=
=9B</span><span lang=3D"ZH-CN">
</span><span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E4=B8=8A=E5=8D=
=88</span>9:26<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E5=AF=AB=
=E9=81=93=EF=BC=9A</span><u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin-left:4=
.8pt;margin-right:0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com=
" target=3D"_blank">dgilbert@redhat.com</a>&gt;<br>
&gt; Sent: Wednesday, November 27, 2019 6:51 PM<br>
&gt; To: Daniel Cho &lt;<a href=3D"mailto:danielcho@qnap.com" target=3D"_bl=
ank">danielcho@qnap.com</a>&gt;; Zhang, Chen<br>
&gt; &lt;<a href=3D"mailto:chen.zhang@intel.com" target=3D"_blank">chen.zha=
ng@intel.com</a>&gt;;
<a href=3D"mailto:lukasstraub2@web.de" target=3D"_blank">lukasstraub2@web.d=
e</a><br>
&gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-de=
vel@nongnu.org</a><br>
&gt; Subject: Re: Network connection with COLO VM<br>
&gt; <br>
&gt; * Daniel Cho (<a href=3D"mailto:danielcho@qnap.com" target=3D"_blank">=
danielcho@qnap.com</a>) wrote:<br>
&gt; &gt; Hello everyone,<br>
&gt; &gt;<br>
&gt; &gt; Could we ssh to colo VM (means PVM &amp; SVM are starting)?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Lets cc in Zhang Chen and Lukas Straub.<br>
<br>
Thanks Dave.<br>
<br>
&gt; <br>
&gt; &gt; SSH will connect to colo VM for a while, but it will disconnect w=
ith<br>
&gt; &gt; error<br>
&gt; &gt; *client_loop: send disconnect: Broken pipe*<br>
&gt; &gt;<br>
&gt; &gt; It seems to colo VM could not keep network session.<br>
&gt; &gt;<br>
&gt; &gt; Does it be a known issue?<br>
&gt; <br>
&gt; That sounds like the COLO proxy is getting upset; it&#39;s supposed to=
 compare<br>
&gt; packets sent by the primary and secondary and only send one to the out=
side<br>
&gt; - you shouldn&#39;t be talking directly to the guest, but always via t=
he proxy.=C2=A0 See<br>
&gt; docs/colo-proxy.txt<br>
&gt; <br>
<br>
Hi Daniel,<br>
<br>
I have try ssh to COLO guest with 8 hours, not occurred this issue.<br>
Please check your network/qemu configuration.<br>
But I found another problem maybe related this issue, if no network communi=
cation for a period of time(maybe 10min), the first message send to guest h=
ave a chance with delay(maybe 1-5 sec), I will try to fix it when I have ti=
me.<br>
<br>
Thanks<br>
Zhang Chen<br>
<br>
&gt; Dave<br>
&gt; <br>
&gt; &gt; Best Regard,<br>
&gt; &gt; Daniel Cho<br>
&gt; --<br>
&gt; Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=
=3D"_blank">dgilbert@redhat.com</a> / Manchester, UK<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>
</div>
</div>

</blockquote></div></div>

--000000000000b7a8500598b08c2a--

