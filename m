Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC8FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92AF205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="SHZgUwK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92AF205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic4LG-0006zQ-EC
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 04:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1ic4BC-0001vD-SY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1ic4B4-0000q6-9A
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:09:07 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c]:35085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1ic4B3-0000fv-Ul
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:09:02 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id h23so1261193ybg.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2EDstYWvyppakp3BW4JhWmESr54YJdoNQCna91s3fJg=;
 b=SHZgUwK4Cu91Tp8dtrbN/b16Dd8YqpsFpOjmGKMUG9ucaoVVjihMyw6oeUQiasUgO5
 5Gmd8Xgj7aLmHh3x3Hdq+Z7gywKOXCeTZ2o9cFxBjwpi0H9G0GgTV7HCk6eQzgBG7rEn
 sXem4vi6nZ6lTUBis0Y4ewP8yVn4AY3rvy7RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2EDstYWvyppakp3BW4JhWmESr54YJdoNQCna91s3fJg=;
 b=j6hL5eHCCFFw4+4SGCcit5Zzkm+lPW4EaRrHbh9Is/HVF7D5YKGz52Jt1Rw+PhShL8
 v7Aq7o0C06J4HVfTn88YMAx/aizUglaO+5vd9taLbMZyyAdJbA781aNlKwuoqYfUnYtB
 IWlW7LfKW/9uefInGOw2miOGC8AFS/E6A6yhjHA6M/jn/6+tMpZpkYh+csPOCoFeHhOm
 m/3ZRGL0QI8ZCyCw7xemT1p1n13nht3gPa3iiAJSlhD7xDDbaPhGYPr2GasOtEfGYH1A
 4aD9gb6M8CgtlTnpSQq3Gyc6moyhp4zd0NpoHspHZNOw2UTzhHZORlelpFShZ144M91i
 /IKA==
X-Gm-Message-State: APjAAAUaJBxQD/x3zGXrR/s4+OEtDzc6hdIYFNBOwBVS2CcedpOjvWBK
 77LnIjlswqLJ7cGPFEfxZoDMao+LvT8x9sF0/XIEwQ==
X-Google-Smtp-Source: APXvYqzHz1b1isdUTD0I0VySLX7GefYSlhYxS0tvjvZxbqIiLdfS51AmYn1C4AylmhzT4BFxLucbrbJNj0pvog1+H/g=
X-Received: by 2002:a25:d00f:: with SMTP id h15mr3788313ybg.70.1575364138593; 
 Tue, 03 Dec 2019 01:08:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
 <20191127105121.GA3017@work-vm>
 <9CFF81C0F6B98A43A459C9EDAD400D780631A02A@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4hY4TkeDM3EOhbLBTc5_P-PdF5ED3QR-C2CrfCV56aZA@mail.gmail.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780631C682@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4N0_K2zQ1NDToJgu+Toy1X3iqOZyYyvtScMMsdVARACg@mail.gmail.com>
 <20191202095806.GA2904@work-vm>
In-Reply-To: <20191202095806.GA2904@work-vm>
From: Daniel Cho <danielcho@qnap.com>
Date: Tue, 3 Dec 2019 17:08:39 +0800
Message-ID: <CA+XQNE6pmj=-tMxCUamY3U4jNuBNR7=rjeFwhbps7a6YNAsYog@mail.gmail.com>
Subject: Re: Network connection with COLO VM
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000df813b0598c90b37"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b2c
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>,
 "lukasstraub2@web.de" <lukasstraub2@web.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000df813b0598c90b37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

We could use the exist interface to add netfilter and chardev, it might not
have the problem you said.

However, the netfilter and chardev on the primary at the start, that means
we could not dynamic set COLO
feature to VM?

We try to change this chardev to prevent primary VM will stuck to wait
secondary VM.

-chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,wait \

to

-chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,nowait \

But it will make primary VM's network not works. (Can't get ip), until
starting connect with secondary VM.


Otherwise, the primary VM with netfileter / chardev and without netfilter /
chardev , they takes very different
booting time.
Without  netfilter / chardev : about 1 mins
With   netfilter / chardev : about 5 mins
Is this an issue?

Best regards,
Daniel Cho


Dr. David Alan Gilbert <dgilbert@redhat.com> =E6=96=BC 2019=E5=B9=B412=E6=
=9C=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:58=E5=AF=AB=E9=81=
=93=EF=BC=9A

> * Daniel Cho (danielcho@qnap.com) wrote:
> > Hi Zhang,
> >
> > We use qemu-4.1.0 release on this case.
> >
> > I think we need use block mirror to sync the disk to secondary node
> first,
> > then stop the primary VM and build COLO system.
> >
> > In the stop moment, you need add some netfilter and chardev socket node
> for
> > COLO, maybe you need re-check this part.
> >
> >
> > Our test was already follow those step. Maybe I could describe the deta=
il
> > of the test flow and issues.
> >
> >
> > Step 1:
> >
> > Create primary VM without any netfilter and chardev for COLO, and using
> > other host ping primary VM continually.
> >
> >
> > Step 2:
> >
> > Create secondary VM (the same device/drive with primary VM), and do blo=
ck
> > mirror sync ( ping to primary VM normally )
> >
> >
> > Step 3:
> >
> > After block mirror sync finish, add those netfilter and chardev to
> primary
> > VM and secondary VM for COLO ( *Can't* ping to primary VM but those
> packets
> > will be received later )
> >
> >
> > Step 4:
> >
> > Start migrate primary VM to secondary VM, and primary VM & secondary VM
> are
> > running ( ping to primary VM works and receive those packets on step 3
> > status )
> >
> >
> >
> >
> > Between Step 3 to Step 4, it will take 10~20 seconds in our environment=
.
> >
> > I could image this issue (delay reply packets) is because of setting CO=
LO
> > proxy for temporary status,
> >
> > but we thought 10~20 seconds might a little long. (If primary VM is
> already
> > doing some jobs, it might lose the data.)
> >
> >
> > Could we reduce those time? or those delay is depends on different VM?
>
> I think you need to set up the netfilter and chardev on the primary at
> the start;  the filter contains the state of the TCP connections working
> with the VM, so adding it later can't gain that state for existing
> connections.
>
> Dave
>
> >
> > Best Regard,
> >
> > Daniel Cho.
> >
> >
> >
> > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > >
> > >
> > >
> > >
> > > *From:* Daniel Cho <danielcho@qnap.com>
> > > *Sent:* Friday, November 29, 2019 10:43 AM
> > > *To:* Zhang, Chen <chen.zhang@intel.com>
> > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>;
> lukasstraub2@web.de;
> > > qemu-devel@nongnu.org
> > > *Subject:* Re: Network connection with COLO VM
> > >
> > >
> > >
> > > Hi David,  Zhang,
> > >
> > >
> > >
> > > Thanks for replying my question.
> > >
> > > We know why will occur this issue.
> > >
> > > As you said, the COLO VM's network needs
> > >
> > > colo-proxy to control packets, so the guest's
> > >
> > > interface should set the filter to solve the problem.
> > >
> > >
> > >
> > > But we found another question, when we set the
> > >
> > > fault-tolerance feature to guest (primary VM is running,
> > >
> > > secondary VM is pausing), the guest's network would not
> > >
> > > responds any request for a while (in our environment
> > >
> > > about 20~30 secs) after secondary VM runs.
> > >
> > >
> > >
> > > Does it be a normal situation, or a known issue?
> > >
> > >
> > >
> > > Our test is creating primary VM for a while, then creating
> > >
> > > secondary VM to make it with COLO feature.
> > >
> > >
> > >
> > > Hi Daniel,
> > >
> > >
> > >
> > > Happy to hear you have solved ssh disconnection issue.
> > >
> > >
> > >
> > > Do you use Lukas=E2=80=99s patch on this case?
> > >
> > > I think we need use block mirror to sync the disk to secondary node
> first,
> > > then stop the primary VM and build COLO system.
> > >
> > > In the stop moment, you need add some netfilter and chardev socket no=
de
> > > for COLO, maybe you need re-check this part.
> > >
> > >
> > >
> > > Best Regard,
> > >
> > > Daniel Cho
> > >
> > >
> > >
> > > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=88=
28=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:26=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > Sent: Wednesday, November 27, 2019 6:51 PM
> > > > To: Daniel Cho <danielcho@qnap.com>; Zhang, Chen
> > > > <chen.zhang@intel.com>; lukasstraub2@web.de
> > > > Cc: qemu-devel@nongnu.org
> > > > Subject: Re: Network connection with COLO VM
> > > >
> > > > * Daniel Cho (danielcho@qnap.com) wrote:
> > > > > Hello everyone,
> > > > >
> > > > > Could we ssh to colo VM (means PVM & SVM are starting)?
> > > > >
> > > >
> > > > Lets cc in Zhang Chen and Lukas Straub.
> > >
> > > Thanks Dave.
> > >
> > > >
> > > > > SSH will connect to colo VM for a while, but it will disconnect
> with
> > > > > error
> > > > > *client_loop: send disconnect: Broken pipe*
> > > > >
> > > > > It seems to colo VM could not keep network session.
> > > > >
> > > > > Does it be a known issue?
> > > >
> > > > That sounds like the COLO proxy is getting upset; it's supposed to
> > > compare
> > > > packets sent by the primary and secondary and only send one to the
> > > outside
> > > > - you shouldn't be talking directly to the guest, but always via th=
e
> > > proxy.  See
> > > > docs/colo-proxy.txt
> > > >
> > >
> > > Hi Daniel,
> > >
> > > I have try ssh to COLO guest with 8 hours, not occurred this issue.
> > > Please check your network/qemu configuration.
> > > But I found another problem maybe related this issue, if no network
> > > communication for a period of time(maybe 10min), the first message
> send to
> > > guest have a chance with delay(maybe 1-5 sec), I will try to fix it
> when I
> > > have time.
> > >
> > > Thanks
> > > Zhang Chen
> > >
> > > > Dave
> > > >
> > > > > Best Regard,
> > > > > Daniel Cho
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>

--000000000000df813b0598c90b37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Dave,=C2=A0</div><div><br></div><div>We could use =
the exist interface to add netfilter and chardev, it might not have the pro=
blem you said.</div><div><br></div><div>However,=C2=A0<font color=3D"#ff000=
0">the netfilter and chardev on the primary at the start</font>, that means=
 we could not dynamic set COLO</div><div>feature to VM?</div><div><br></div=
><div>We try to change this chardev to prevent primary VM will stuck to wai=
t secondary VM.</div><div><pre style=3D"font-family:monospace,Courier;paddi=
ng:1em;border:1px solid rgb(221,221,221);background-color:rgb(249,249,249);=
line-height:1.3em;font-size:14px"><span style=3D"color:black">-chardev sock=
et,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,</span><font color=3D"=
#ff0000">wait</font><font color=3D"#000000"> \</font></pre></div><div>to</d=
iv><div><pre style=3D"font-family:monospace,Courier;padding:1em;border:1px =
solid rgb(221,221,221);background-color:rgb(249,249,249);line-height:1.3em;=
font-size:14px"><span style=3D"color:black">-chardev socket,id=3Dcompare1,h=
ost=3D127.0.0.1,port=3D9004,server,</span><font color=3D"#ff0000">nowait</f=
ont><font color=3D"#000000"> \</font></pre></div><div>But it will make prim=
ary VM&#39;s network=C2=A0not works. (Can&#39;t get ip), until starting con=
nect with secondary VM.</div><div><br></div><div><br></div><div>Otherwise, =
the primary VM with netfileter / chardev and without netfilter / chardev , =
they takes very different=C2=A0</div><div>booting time.</div><div><font col=
or=3D"#ff0000">Without</font>=C2=A0

netfilter / chardev : about 1 mins</div><div><font color=3D"#ff0000">With</=
font>=C2=A0 =C2=A0netfilter / chardev : about 5 mins=C2=A0=C2=A0<br></div><=
div>Is this an issue?</div><div><br></div><div>Best=C2=A0regards,</div><div=
>Daniel Cho</div><div><br></div><div><br></div><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">Dr. David Alan Gilbert &lt;<a href=3D"=
mailto:dgilbert@redhat.com">dgilbert@redhat.com</a>&gt; =E6=96=BC 2019=E5=
=B9=B412=E6=9C=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:58=E5=AF=
=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">* Daniel Cho (<a href=3D"mailto:danielcho@qnap.com" target=3D"_blank"=
>danielcho@qnap.com</a>) wrote:<br>
&gt; Hi Zhang,<br>
&gt; <br>
&gt; We use qemu-4.1.0 release on this case.<br>
&gt; <br>
&gt; I think we need use block mirror to sync the disk to secondary node fi=
rst,<br>
&gt; then stop the primary VM and build COLO system.<br>
&gt; <br>
&gt; In the stop moment, you need add some netfilter and chardev socket nod=
e for<br>
&gt; COLO, maybe you need re-check this part.<br>
&gt; <br>
&gt; <br>
&gt; Our test was already follow those step. Maybe I could describe the det=
ail<br>
&gt; of the test flow and issues.<br>
&gt; <br>
&gt; <br>
&gt; Step 1:<br>
&gt; <br>
&gt; Create primary VM without any netfilter and chardev for COLO, and usin=
g<br>
&gt; other host ping primary VM continually.<br>
&gt; <br>
&gt; <br>
&gt; Step 2:<br>
&gt; <br>
&gt; Create secondary VM (the same device/drive with primary VM), and do bl=
ock<br>
&gt; mirror sync ( ping to primary VM normally )<br>
&gt; <br>
&gt; <br>
&gt; Step 3:<br>
&gt; <br>
&gt; After block mirror sync finish, add those netfilter and chardev to pri=
mary<br>
&gt; VM and secondary VM for COLO ( *Can&#39;t* ping to primary VM but thos=
e packets<br>
&gt; will be received later )<br>
&gt; <br>
&gt; <br>
&gt; Step 4:<br>
&gt; <br>
&gt; Start migrate primary VM to secondary VM, and primary VM &amp; seconda=
ry VM are<br>
&gt; running ( ping to primary VM works and receive those packets on step 3=
<br>
&gt; status )<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Between Step 3 to Step 4, it will take 10~20 seconds in our environmen=
t.<br>
&gt; <br>
&gt; I could image this issue (delay reply packets) is because of setting C=
OLO<br>
&gt; proxy for temporary status,<br>
&gt; <br>
&gt; but we thought 10~20 seconds might a little long. (If primary VM is al=
ready<br>
&gt; doing some jobs, it might lose the data.)<br>
&gt; <br>
&gt; <br>
&gt; Could we reduce those time? or those delay is depends on different VM?=
<br>
<br>
I think you need to set up the netfilter and chardev on the primary at<br>
the start;=C2=A0 the filter contains the state of the TCP connections worki=
ng<br>
with the VM, so adding it later can&#39;t gain that state for existing<br>
connections.<br>
<br>
Dave<br>
<br>
&gt; <br>
&gt; Best Regard,<br>
&gt; <br>
&gt; Daniel Cho.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=3D"_bla=
nk">chen.zhang@intel.com</a>&gt; =E6=96=BC 2019=E5=B9=B411=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:04=E5=AF=AB=E9=81=93=EF=BC=9A<br=
>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; *From:* Daniel Cho &lt;<a href=3D"mailto:danielcho@qnap.com" targ=
et=3D"_blank">danielcho@qnap.com</a>&gt;<br>
&gt; &gt; *Sent:* Friday, November 29, 2019 10:43 AM<br>
&gt; &gt; *To:* Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" tar=
get=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
&gt; &gt; *Cc:* Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redha=
t.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;; <a href=3D"mailto:luk=
asstraub2@web.de" target=3D"_blank">lukasstraub2@web.de</a>;<br>
&gt; &gt; <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-d=
evel@nongnu.org</a><br>
&gt; &gt; *Subject:* Re: Network connection with COLO VM<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Hi David,=C2=A0 Zhang,<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks for replying my question.<br>
&gt; &gt;<br>
&gt; &gt; We know why will occur this issue.<br>
&gt; &gt;<br>
&gt; &gt; As you said, the COLO VM&#39;s network needs<br>
&gt; &gt;<br>
&gt; &gt; colo-proxy to control packets, so the guest&#39;s<br>
&gt; &gt;<br>
&gt; &gt; interface should set the filter to solve the problem.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; But we found another question, when we set the<br>
&gt; &gt;<br>
&gt; &gt; fault-tolerance feature to guest (primary VM is running,<br>
&gt; &gt;<br>
&gt; &gt; secondary VM is pausing), the guest&#39;s network would not<br>
&gt; &gt;<br>
&gt; &gt; responds any request for a while (in our environment<br>
&gt; &gt;<br>
&gt; &gt; about 20~30 secs) after secondary VM runs.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Does it be a normal situation, or a known issue?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Our test is creating primary VM for a while, then creating<br>
&gt; &gt;<br>
&gt; &gt; secondary VM to make it with COLO feature.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Hi Daniel,<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Happy to hear you have solved ssh disconnection issue.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Do you use Lukas=E2=80=99s patch on this case?<br>
&gt; &gt;<br>
&gt; &gt; I think we need use block mirror to sync the disk to secondary no=
de first,<br>
&gt; &gt; then stop the primary VM and build COLO system.<br>
&gt; &gt;<br>
&gt; &gt; In the stop moment, you need add some netfilter and chardev socke=
t node<br>
&gt; &gt; for COLO, maybe you need re-check this part.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Best Regard,<br>
&gt; &gt;<br>
&gt; &gt; Daniel Cho<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=3D=
"_blank">chen.zhang@intel.com</a>&gt; =E6=96=BC 2019=E5=B9=B411=E6=9C=8828=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:26=E5=AF=AB=E9=81=93=EF=BC=
=9A<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; -----Original Message-----<br>
&gt; &gt; &gt; From: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@=
redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;<br>
&gt; &gt; &gt; Sent: Wednesday, November 27, 2019 6:51 PM<br>
&gt; &gt; &gt; To: Daniel Cho &lt;<a href=3D"mailto:danielcho@qnap.com" tar=
get=3D"_blank">danielcho@qnap.com</a>&gt;; Zhang, Chen<br>
&gt; &gt; &gt; &lt;<a href=3D"mailto:chen.zhang@intel.com" target=3D"_blank=
">chen.zhang@intel.com</a>&gt;; <a href=3D"mailto:lukasstraub2@web.de" targ=
et=3D"_blank">lukasstraub2@web.de</a><br>
&gt; &gt; &gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blan=
k">qemu-devel@nongnu.org</a><br>
&gt; &gt; &gt; Subject: Re: Network connection with COLO VM<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; * Daniel Cho (<a href=3D"mailto:danielcho@qnap.com" target=
=3D"_blank">danielcho@qnap.com</a>) wrote:<br>
&gt; &gt; &gt; &gt; Hello everyone,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Could we ssh to colo VM (means PVM &amp; SVM are starti=
ng)?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Lets cc in Zhang Chen and Lukas Straub.<br>
&gt; &gt;<br>
&gt; &gt; Thanks Dave.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; SSH will connect to colo VM for a while, but it will di=
sconnect with<br>
&gt; &gt; &gt; &gt; error<br>
&gt; &gt; &gt; &gt; *client_loop: send disconnect: Broken pipe*<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; It seems to colo VM could not keep network session.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Does it be a known issue?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; That sounds like the COLO proxy is getting upset; it&#39;s s=
upposed to<br>
&gt; &gt; compare<br>
&gt; &gt; &gt; packets sent by the primary and secondary and only send one =
to the<br>
&gt; &gt; outside<br>
&gt; &gt; &gt; - you shouldn&#39;t be talking directly to the guest, but al=
ways via the<br>
&gt; &gt; proxy.=C2=A0 See<br>
&gt; &gt; &gt; docs/colo-proxy.txt<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Hi Daniel,<br>
&gt; &gt;<br>
&gt; &gt; I have try ssh to COLO guest with 8 hours, not occurred this issu=
e.<br>
&gt; &gt; Please check your network/qemu configuration.<br>
&gt; &gt; But I found another problem maybe related this issue, if no netwo=
rk<br>
&gt; &gt; communication for a period of time(maybe 10min), the first messag=
e send to<br>
&gt; &gt; guest have a chance with delay(maybe 1-5 sec), I will try to fix =
it when I<br>
&gt; &gt; have time.<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt; Zhang Chen<br>
&gt; &gt;<br>
&gt; &gt; &gt; Dave<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Best Regard,<br>
&gt; &gt; &gt; &gt; Daniel Cho<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.c=
om" target=3D"_blank">dgilbert@redhat.com</a> / Manchester, UK<br>
&gt; &gt;<br>
&gt; &gt;<br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank">dgilbert@redhat.com</a> / Manchester, UK<br>
<br>
</blockquote></div></div>

--000000000000df813b0598c90b37--

