Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40749C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F212E20661
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="SmOq8IHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F212E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1nX3-0001oj-PD
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 03:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1j1nWM-0001GY-Rd
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1j1nWK-0004EO-R7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:37:22 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c]:44578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1j1nWK-0004Df-K5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:37:20 -0500
Received: by mail-il1-x12c.google.com with SMTP id s85so1008514ill.11
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4jq6VaJR8fXEnHtQIovi73Cj6aPVDoPSueCNE4uxRYs=;
 b=SmOq8IHMXLH17bWRnLQzWI0djtshELHGluWawkMH3XfC3oQJisBwrDgQNGYBvTgca5
 C8QUglgIR4yTnHqMm2HEpAJD12oAfzYlYnJJ9nCrUGs8t/juQYz/WUOP/7GoWNIiCA9i
 Ut694gDPPh8jXwR/HbgdLzSHzMfs7SCbkoOVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4jq6VaJR8fXEnHtQIovi73Cj6aPVDoPSueCNE4uxRYs=;
 b=mPClQvG+NiG66nEVq8CUHasxvSpn8Doj2vwIIUhaxWMVMSdYcC56qeLG+YOcOZvTYg
 +ztptfSm3zHS4NCtT3YpeYeB0JkB3yiqOTHvCDrLJqURBkJ2FJCE/sdomAEH3Dc3O5//
 3nuxr54l4KN8TtcgCZUpblZ3Eqbm5h+PAtOTLWkld6lcWoLd+o540pxcu0YuylFumtgq
 s4qqbhSCboy23Bfiecp/9H1N0pa8iTq9mEJgrbypkQ8ULFoTXvhYqJ+/ECm1vaaNCAcA
 E2ZbSVU3VgaSBuJ6YZr/UR9b2bp+Wije0S3FBMSncIGf2m2zPx83wbrp+ltpVLVMFs8/
 D3hA==
X-Gm-Message-State: APjAAAXFAIri/42Zn9+E12vcN2Td2GImE1hTbNk8HJJKAnE95pU6A1Va
 hP9ODHpWgBrVPj55S+epnsTgRMqsR/TAGwtW27nTXQ==
X-Google-Smtp-Source: APXvYqxSbTDWUv7FsIDknHXEk4wZBDQ8+0YQHxnGX4I2zo8GBQtzHIKbjgKwQoS3kYsWkkmpMmDlvm7wZaM6PCClgmc=
X-Received: by 2002:a92:d244:: with SMTP id v4mr10520062ilg.114.1581496639411; 
 Wed, 12 Feb 2020 00:37:19 -0800 (PST)
MIME-Version: 1.0
References: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
 <20200211174756.GA2798@work-vm> <8737854e2826400fa4d14dc408cfd947@huawei.com>
 <2b09c8650b944c908c0c95fefe6d759f@intel.com>
In-Reply-To: <2b09c8650b944c908c0c95fefe6d759f@intel.com>
From: Daniel Cho <danielcho@qnap.com>
Date: Wed, 12 Feb 2020 16:37:07 +0800
Message-ID: <CA+XQNE5hn=FJh7cq5YP0ydYEHkap-a-9AXeTLJd=24sQ1DWkwg@mail.gmail.com>
Subject: Re: The issues about architecture of the COLO checkpoint
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="00000000000067eeb9059e5ce169"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12c
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000067eeb9059e5ce169
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hailiang,

Thanks for your replaying and explain in detail.
We will try to use the attachments to enhance memory copy.

However, we have some questions for your replying.

1.  As you said, "for each checkpoint, we have to send the whole PVM's
pages To SVM", why the only first checkpoint will takes more pause time?
In our observing, the first checkpoint will take more time for pausing,
then other checkpoints will takes a few time for pausing. Does it means
only the first checkpoint will send the whole pages to SVM, and the other
checkpoints send the dirty pages to SVM for reloading?

2. We notice the COLO-COMPARE component will stuck the packet until
receive packets from PVM and SVM, as this rule, when we add the
COLO-COMPARE to PVM, its network will stuck until SVM start. So it is an
other issue to make PVM stuck while setting COLO feature. With this issue,
could we let colo-compare to pass the PVM's packet when the SVM's packet
queue is empty? Then, the PVM's network won't stock, and "if PVM runs
firstly, it still need to wait for The network packets from SVM to compare
before send it to client side" won't happened either.

Best regard,
Daniel Cho

Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:45=E5=AF=AB=E9=81=93=EF=BC=9A

>
>
> > -----Original Message-----
> > From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Sent: Wednesday, February 12, 2020 11:18 AM
> > To: Dr. David Alan Gilbert <dgilbert@redhat.com>; Daniel Cho
> > <danielcho@qnap.com>; Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel@nongnu.org
> > Subject: RE: The issues about architecture of the COLO checkpoint
> >
> > Hi,
> >
> > Thank you Dave,
> >
> > I'll reply here directly.
> >
> > -----Original Message-----
> > From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> > Sent: Wednesday, February 12, 2020 1:48 AM
> > To: Daniel Cho <danielcho@qnap.com>; chen.zhang@intel.com;
> > Zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Cc: qemu-devel@nongnu.org
> > Subject: Re: The issues about architecture of the COLO checkpoint
> >
> >
> > cc'ing in COLO people:
> >
> >
> > * Daniel Cho (danielcho@qnap.com) wrote:
> > > Hi everyone,
> > >      We have some issues about setting COLO feature. Hope somebody
> > > could give us some advice.
> > >
> > > Issue 1:
> > >      We dynamic to set COLO feature for PVM(2 core, 16G memory),  but
> > > the Primary VM will pause a long time(based on memory size) for
> > > waiting SVM start. Does it have any idea to reduce the pause time?
> > >
> >
> > Yes, we do have some ideas to optimize this downtime.
> >
> > The main problem for current version is, for each checkpoint, we have t=
o
> > send the whole PVM's pages
> > To SVM, and then copy the whole VM's state into SVM from ram cache, in
> > this process, we need both of them be paused.
> > Just as you said, the downtime is based on memory size.
> >
> > So firstly, we need to reduce the sending data while do checkpoint,
> actually,
> > we can migrate parts of PVM's dirty pages in background
> > While both of VMs are running. And then we load these pages into ram
> > cache (backup memory) in SVM temporarily. While do checkpoint,
> > We just send the last dirty pages of PVM to slave side and then copy th=
e
> ram
> > cache into SVM. Further on, we don't have
> > To send the whole PVM's dirty pages, we can only send the pages that
> > dirtied by PVM or SVM during two checkpoints. (Because
> > If one page is not dirtied by both PVM and SVM, the data of this pages
> will
> > keep same in SVM, PVM, backup memory). This method can reduce
> > the time that consumed in sending data.
> >
> > For the second problem, we can reduce the memory copy by two methods,
> > first one, we don't have to copy the whole pages in ram cache,
> > We can only copy the pages that dirtied by PVM and SVM in last
> checkpoint.
> > Second, we can use userfault missing function to reduce the
> > Time consumed in memory copy. (For the second time, in theory, we can
> > reduce time consumed in memory into ms level).
> >
> > You can find the first optimization in attachment, it is based on an ol=
d
> qemu
> > version (qemu-2.6), it should not be difficult to rebase it
> > Into master or your version. And please feel free to send the new
> version if
> > you want into community ;)
> >
> >
>
> Thanks Hailiang!
> By the way, Do you have time to push the patches to upstream?
> I think this is a better and faster option.
>
> Thanks
> Zhang Chen
>
> > >
> > > Issue 2:
> > >      In
> > > https://github.com/qemu/qemu/blob/master/migration/colo.c#L503,
> > > could we move start_vm() before Line 488? Because at first checkpoint
> > > PVM will wait for SVM's reply, it cause PVM stop for a while.
> > >
> >
> > No, that makes no sense, because if PVM runs firstly, it still need to
> wait for
> > The network packets from SVM to compare before send it to client side.
> >
> >
> > Thanks,
> > Hailiang
> >
> > >      We set the COLO feature on running VM, so we hope the running VM
> > > could continuous service for users.
> > > Do you have any suggestions for those issues?
> > >
> > > Best regards,
> > > Daniel Cho
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>

--00000000000067eeb9059e5ce169
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Hailiang,=C2=A0<div><br></div><div>Thanks for your repl=
aying and explain in detail.=C2=A0</div><div>We will try to use the attachm=
ents to enhance memory copy.</div><div><br></div><div>However, we have some=
 questions for your replying.=C2=A0=C2=A0</div><div><br></div><div>1.=C2=A0=
 As you said, &quot;<font color=3D"#ff0000">for each checkpoint, we have to=
 send=C2=A0<span class=3D"gmail-il">the</span>=C2=A0whole PVM&#39;s pages T=
o SVM</font>&quot;, why the only first checkpoint will takes more pause tim=
e?</div><div>In our observing, the first checkpoint will take more time for=
 pausing, then other checkpoints will takes a few time for pausing. Does it=
 means only the first checkpoint=C2=A0will send the whole pages to SVM, and=
 the other checkpoints send the dirty pages to SVM for reloading?</div><div=
><br></div><div>2. We notice the COLO-COMPARE component=C2=A0will stuck the=
 packet until receive=C2=A0packets from PVM and SVM, as this rule, when we =
add the COLO-COMPARE to PVM, its network=C2=A0will stuck until SVM start. S=
o it is an other issue to make PVM stuck while setting COLO feature. With t=
his issue, could we let colo-compare to pass the PVM&#39;s packet when the =
SVM&#39;s packet queue is empty? Then, the PVM&#39;s network won&#39;t stoc=
k, and &quot;<font color=3D"#ff0000">if PVM runs firstly, it still need to =
wait for=C2=A0<span class=3D"gmail-il">The</span>=C2=A0network packets from=
 SVM to compare before send it to client side</font>&quot; won&#39;t happen=
ed either.</div><div><br></div><div>Best regard,=C2=A0</div><div>Daniel Cho=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com">chen.zhang@in=
tel.com</a>&gt; =E6=96=BC 2020=E5=B9=B42=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=
=B8=89 =E4=B8=8B=E5=8D=881:45=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Zhanghailiang &lt;<a href=3D"mailto:zhang.zhanghailiang@huawei.c=
om" target=3D"_blank">zhang.zhanghailiang@huawei.com</a>&gt;<br>
&gt; Sent: Wednesday, February 12, 2020 11:18 AM<br>
&gt; To: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com" =
target=3D"_blank">dgilbert@redhat.com</a>&gt;; Daniel Cho<br>
&gt; &lt;<a href=3D"mailto:danielcho@qnap.com" target=3D"_blank">danielcho@=
qnap.com</a>&gt;; Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" t=
arget=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-de=
vel@nongnu.org</a><br>
&gt; Subject: RE: The issues about architecture of the COLO checkpoint<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; Thank you Dave,<br>
&gt; <br>
&gt; I&#39;ll reply here directly.<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Dr. David Alan Gilbert [mailto:<a href=3D"mailto:dgilbert@redhat=
.com" target=3D"_blank">dgilbert@redhat.com</a>]<br>
&gt; Sent: Wednesday, February 12, 2020 1:48 AM<br>
&gt; To: Daniel Cho &lt;<a href=3D"mailto:danielcho@qnap.com" target=3D"_bl=
ank">danielcho@qnap.com</a>&gt;; <a href=3D"mailto:chen.zhang@intel.com" ta=
rget=3D"_blank">chen.zhang@intel.com</a>;<br>
&gt; Zhanghailiang &lt;<a href=3D"mailto:zhang.zhanghailiang@huawei.com" ta=
rget=3D"_blank">zhang.zhanghailiang@huawei.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-de=
vel@nongnu.org</a><br>
&gt; Subject: Re: The issues about architecture of the COLO checkpoint<br>
&gt; <br>
&gt; <br>
&gt; cc&#39;ing in COLO people:<br>
&gt; <br>
&gt; <br>
&gt; * Daniel Cho (<a href=3D"mailto:danielcho@qnap.com" target=3D"_blank">=
danielcho@qnap.com</a>) wrote:<br>
&gt; &gt; Hi everyone,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 We have some issues about setting COLO featur=
e. Hope somebody<br>
&gt; &gt; could give us some advice.<br>
&gt; &gt;<br>
&gt; &gt; Issue 1:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 We dynamic to set COLO feature for PVM(2 core=
, 16G memory),=C2=A0 but<br>
&gt; &gt; the Primary VM will pause a long time(based on memory size) for<b=
r>
&gt; &gt; waiting SVM start. Does it have any idea to reduce the pause time=
?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes, we do have some ideas to optimize this downtime.<br>
&gt; <br>
&gt; The main problem for current version is, for each checkpoint, we have =
to<br>
&gt; send the whole PVM&#39;s pages<br>
&gt; To SVM, and then copy the whole VM&#39;s state into SVM from ram cache=
, in<br>
&gt; this process, we need both of them be paused.<br>
&gt; Just as you said, the downtime is based on memory size.<br>
&gt; <br>
&gt; So firstly, we need to reduce the sending data while do checkpoint, ac=
tually,<br>
&gt; we can migrate parts of PVM&#39;s dirty pages in background<br>
&gt; While both of VMs are running. And then we load these pages into ram<b=
r>
&gt; cache (backup memory) in SVM temporarily. While do checkpoint,<br>
&gt; We just send the last dirty pages of PVM to slave side and then copy t=
he ram<br>
&gt; cache into SVM. Further on, we don&#39;t have<br>
&gt; To send the whole PVM&#39;s dirty pages, we can only send the pages th=
at<br>
&gt; dirtied by PVM or SVM during two checkpoints. (Because<br>
&gt; If one page is not dirtied by both PVM and SVM, the data of this pages=
 will<br>
&gt; keep same in SVM, PVM, backup memory). This method can reduce<br>
&gt; the time that consumed in sending data.<br>
&gt; <br>
&gt; For the second problem, we can reduce the memory copy by two methods,<=
br>
&gt; first one, we don&#39;t have to copy the whole pages in ram cache,<br>
&gt; We can only copy the pages that dirtied by PVM and SVM in last checkpo=
int.<br>
&gt; Second, we can use userfault missing function to reduce the<br>
&gt; Time consumed in memory copy. (For the second time, in theory, we can<=
br>
&gt; reduce time consumed in memory into ms level).<br>
&gt; <br>
&gt; You can find the first optimization in attachment, it is based on an o=
ld qemu<br>
&gt; version (qemu-2.6), it should not be difficult to rebase it<br>
&gt; Into master or your version. And please feel free to send the new vers=
ion if<br>
&gt; you want into community ;)<br>
&gt; <br>
&gt; <br>
<br>
Thanks Hailiang!<br>
By the way, Do you have time to push the patches to upstream?<br>
I think this is a better and faster option.<br>
<br>
Thanks<br>
Zhang Chen<br>
<br>
&gt; &gt;<br>
&gt; &gt; Issue 2:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 In<br>
&gt; &gt; <a href=3D"https://github.com/qemu/qemu/blob/master/migration/col=
o.c#L503" rel=3D"noreferrer" target=3D"_blank">https://github.com/qemu/qemu=
/blob/master/migration/colo.c#L503</a>,<br>
&gt; &gt; could we move start_vm() before Line 488? Because at first checkp=
oint<br>
&gt; &gt; PVM will wait for SVM&#39;s reply, it cause PVM stop for a while.=
<br>
&gt; &gt;<br>
&gt; <br>
&gt; No, that makes no sense, because if PVM runs firstly, it still need to=
 wait for<br>
&gt; The network packets from SVM to compare before send it to client side.=
<br>
&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; Hailiang<br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 We set the COLO feature on running VM, so we =
hope the running VM<br>
&gt; &gt; could continuous service for users.<br>
&gt; &gt; Do you have any suggestions for those issues?<br>
&gt; &gt;<br>
&gt; &gt; Best regards,<br>
&gt; &gt; Daniel Cho<br>
&gt; --<br>
&gt; Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=
=3D"_blank">dgilbert@redhat.com</a> / Manchester, UK<br>
<br>
</blockquote></div>

--00000000000067eeb9059e5ce169--

