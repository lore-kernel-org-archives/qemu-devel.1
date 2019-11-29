Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA1AC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBFB21775
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="OB+lFIvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBFB21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaWLa-0005cp-Bx
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 21:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1iaWFz-0004V2-Fb
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 21:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1iaWFd-0001dj-RK
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 21:43:25 -0500
Received: from mail-yw1-xc36.google.com ([2607:f8b0:4864:20::c36]:39195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1iaWFd-0001LY-Ig
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 21:43:21 -0500
Received: by mail-yw1-xc36.google.com with SMTP id h126so670442ywc.6
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 18:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pojYrPaLY+pGB3vP+FxJ2gmH+MFEBgtRwKshl+iFh04=;
 b=OB+lFIvUtSNYgT8/DsaTeqaAh9jekesFiTtvROjOVlvcNST8LtLgqZd4hWileLtKgT
 QGR51A2sLeaedai+kLoUl7PkBcNopzgw2lJgXmrT+g6aixdYMCSozC+NC1alDmcR/yUC
 MxqZgwHq8SgkESGMbq/FDY4QCQ4TLePckRZPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pojYrPaLY+pGB3vP+FxJ2gmH+MFEBgtRwKshl+iFh04=;
 b=bgNd6/27jg2WgvkmlbREMLzM4P7YWtRQ0Km/lYPXEJh+HxVQXexJJQfAR0E/5BW8WR
 65SjzpKuAikFJop/hKAlOApQR5C2OwJFLviJC+9H0imeT8J4yd0+b3kB6yFxxva7JpW6
 BuX8PThjg8s2ceNCUvgYMzMVHWGw+ZkGwRjjlA+ap81Bl7f7D4m9PI0Oml34IyDDYxoi
 VomOPlSjmPNg23lbHWqvYGfyfeMIMFK5I2bJKdu4SvKDDwOyjL6Dn8AdpzkLrg1cR2Rn
 wst9KneOXHg33ABjUpo2cvN44w4g8cuMoqdyAcoDTMEDVyuYuMlgtM1xx9kg/8/UdtL/
 TcZA==
X-Gm-Message-State: APjAAAUW2/ot3JNwJHs7ZwyjpBx/HKa8KLzpDMVTu+YNGcy/PXXAzboU
 loxq1Zhd7LlbRNmfGU9pifyQpYB1Ae2nFtWqo6aPSg==
X-Google-Smtp-Source: APXvYqyyaPt3LmcJXn7cpPVcaTMivxMaAEGGdxd7BDqGkDjDRAW17wHxl/nxJVgAKkuMHmdCbLe/ZT58VfO9Cw/1Tvs=
X-Received: by 2002:a81:a188:: with SMTP id y130mr9230063ywg.63.1574995396673; 
 Thu, 28 Nov 2019 18:43:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
 <20191127105121.GA3017@work-vm>
 <9CFF81C0F6B98A43A459C9EDAD400D780631A02A@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D780631A02A@shsmsx102.ccr.corp.intel.com>
From: Daniel Cho <danielcho@qnap.com>
Date: Fri, 29 Nov 2019 10:42:59 +0800
Message-ID: <CA+XQNE4hY4TkeDM3EOhbLBTc5_P-PdF5ED3QR-C2CrfCV56aZA@mail.gmail.com>
Subject: Re: Network connection with COLO VM
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="000000000000245cba059873314e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c36
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

--000000000000245cba059873314e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,  Zhang,

Thanks for replying my question.
We know why will occur this issue.
As you said, the COLO VM's network needs
colo-proxy to control packets, so the guest's
interface should set the filter to solve the problem.

But we found another question, when we set the
fault-tolerance feature to guest (primary VM is running,
secondary VM is pausing), the guest's network would not
responds any request for a while (in our environment
about 20~30 secs) after secondary VM runs.

Does it be a normal situation, or a known issue?

Our test is creating primary VM for a while, then creating
secondary VM to make it with COLO feature.

Best Regard,
Daniel Cho

Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=8828=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:26=E5=AF=AB=E9=81=93=EF=BC=9A

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

--000000000000245cba059873314e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi David,=C2=A0 Zhang,=C2=A0</div><div><br></div><div=
>Thanks for replying my question.=C2=A0</div><div>We know why will occur th=
is issue.=C2=A0</div><div>As you said, the COLO VM&#39;s network needs=C2=
=A0</div><div>colo-proxy to control packets, so the guest&#39;s=C2=A0</div>=
<div>interface should set the filter to solve=C2=A0the problem.</div><div><=
br></div><div>But we found another question, when we set the=C2=A0</div><di=
v>fault-tolerance feature to guest (primary VM is running,=C2=A0</div><div>=
secondary VM is pausing), the guest&#39;s network would not=C2=A0</div><div=
>responds any request for a while (in our environment=C2=A0</div><div>about=
 20~30 secs) after secondary VM runs.</div><div><br></div><div>Does it be a=
 normal situation, or a known issue?=C2=A0=C2=A0<br></div><div><br></div><d=
iv>Our test is creating primary VM for a while, then creating=C2=A0<br></di=
v><div>secondary VM to make it with COLO feature.</div><div><br></div><div>=
Best Regard,=C2=A0</div><div>Daniel Cho=C2=A0</div><div><br></div><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Zhang, Chen &lt;<a =
href=3D"mailto:chen.zhang@intel.com">chen.zhang@intel.com</a>&gt; =E6=96=BC=
 2019=E5=B9=B411=E6=9C=8828=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889=
:26=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com=
" target=3D"_blank">dgilbert@redhat.com</a>&gt;<br>
&gt; Sent: Wednesday, November 27, 2019 6:51 PM<br>
&gt; To: Daniel Cho &lt;<a href=3D"mailto:danielcho@qnap.com" target=3D"_bl=
ank">danielcho@qnap.com</a>&gt;; Zhang, Chen<br>
&gt; &lt;<a href=3D"mailto:chen.zhang@intel.com" target=3D"_blank">chen.zha=
ng@intel.com</a>&gt;; <a href=3D"mailto:lukasstraub2@web.de" target=3D"_bla=
nk">lukasstraub2@web.de</a><br>
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
=3D"_blank">dgilbert@redhat.com</a> / Manchester, UK<br>
<br>
</blockquote></div></div>

--000000000000245cba059873314e--

