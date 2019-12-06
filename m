Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72637C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E26420659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="FHuHR9Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E26420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGaJ-0005pY-1g
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1idFPZ-0005Oh-7E
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1idFPW-0002bs-Fe
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:20:53 -0500
Received: from mail-yw1-xc2c.google.com ([2607:f8b0:4864:20::c2c]:45047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1idFPW-0002YJ-3f
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:20:50 -0500
Received: by mail-yw1-xc2c.google.com with SMTP id t141so2782185ywc.11
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MkqGu/9SEpSHPvM0w3KGikWqCzM12K55Lr4YbJrSVEo=;
 b=FHuHR9RyUlOHMyUdskuwMtey4Xhd7U9o+Fd2ADDFeDt/m+XIQwLvqnYnM5B0VA4M1f
 gQD4+Y4IQZ3VmCVU3ZYtN3qxACbCn+3klWm/uNDETZcCiZ6Im4DKwBG14AiouatNjjw0
 4izN03YDjg89BpHReJdaERon8F71N7JBnRzHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MkqGu/9SEpSHPvM0w3KGikWqCzM12K55Lr4YbJrSVEo=;
 b=j6GHC5oaq68bLJVp/nZz8+XKtfutDYxKHPgOgQWqON2EzckL1cW9jaqG3KkZoDVoSf
 cz07BTLftb3PX/Vb2w8JEleLv/hhZitxU8XPfgwFs00ukQBMaksKq+lW9f+n67lGAQCq
 9JLvnA2xSjHRJ2U9A75IL028fv9t6fWHUcJ3OO46HvU1DxlWIImIFuHl/yEkzwLDZSmP
 98jKq5hG91hw6JrvTtlTRM0GMVkM8SvqodE+2M6WME3u3XSJE6NCJiJsVfXxhX6TvVjS
 NByqqAaGxuyR3/nCqnZMaPLpPMTpS3FfCMYHyDrW5357NR4lk2jM3f/9A8Y69qRzxABZ
 j2Uw==
X-Gm-Message-State: APjAAAVdVxBhQIJ+KsGB8DgM7oZEUeoxvk7rU6AjWcdpnF128yaxstsc
 t8erMxl1GBSOabJVUgUkffrcP2yV70LeSCobdf5ohjfGqbUYLQ==
X-Google-Smtp-Source: APXvYqxZW50ZUPqe4dn5JYQxzKJjWMJ/jx/CgBZWkyY7ZGc1TMja9qtA+7GVJB4xakHLGprG8NFyOwjCfdnEyI8MIgc=
X-Received: by 2002:a25:d00f:: with SMTP id h15mr9568899ybg.70.1575613893274; 
 Thu, 05 Dec 2019 22:31:33 -0800 (PST)
MIME-Version: 1.0
References: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
 <20191127105121.GA3017@work-vm>
 <9CFF81C0F6B98A43A459C9EDAD400D780631A02A@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4hY4TkeDM3EOhbLBTc5_P-PdF5ED3QR-C2CrfCV56aZA@mail.gmail.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780631C682@shsmsx102.ccr.corp.intel.com>
 <CA+XQNE4N0_K2zQ1NDToJgu+Toy1X3iqOZyYyvtScMMsdVARACg@mail.gmail.com>
 <20191202095806.GA2904@work-vm>
 <CA+XQNE6pmj=-tMxCUamY3U4jNuBNR7=rjeFwhbps7a6YNAsYog@mail.gmail.com>
 <20191203132504.GH3078@work-vm>
 <f6bf1e64-a66e-9df8-04f6-b543753eda79@intel.com>
In-Reply-To: <f6bf1e64-a66e-9df8-04f6-b543753eda79@intel.com>
From: Daniel Cho <danielcho@qnap.com>
Date: Fri, 6 Dec 2019 14:31:13 +0800
Message-ID: <CA+XQNE6+KALuWf1NqOg_KjET1XcBsudb9tSBFGJiEN_-JxVbtw@mail.gmail.com>
Subject: Re: Network connection with COLO VM
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="00000000000069977305990332ed"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c2c
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

--00000000000069977305990332ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,  Zhang,

Thanks for your help. I will try your recommendations.

Best Regard,
Daniel Cho

Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B412=E6=9C=884=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:32=E5=AF=AB=E9=81=93=EF=BC=9A

>
> On 12/3/2019 9:25 PM, Dr. David Alan Gilbert wrote:
> > * Daniel Cho (danielcho@qnap.com) wrote:
> >> Hi Dave,
> >>
> >> We could use the exist interface to add netfilter and chardev, it migh=
t
> not
> >> have the problem you said.
> >>
> >> However, the netfilter and chardev on the primary at the start, that
> means
> >> we could not dynamic set COLO
> >> feature to VM?
> > I wasn't expecting that to be possible - I'd expect you to be able
> > to start in a state that looks the same as a primary+failed secondary;
> > but I'm not sure.
>
> Current COLO (with Lukas's patch) can support dynamic set COLO system.
>
> This status is same like the secondary has triggered failover, the
> primary node need to find new secondary
>
> node to combine new COLO system.
>
>
> >> We try to change this chardev to prevent primary VM will stuck to wait
> >> secondary VM.
> >>
> >> -chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,wait=
 \
> >>
> >> to
> >>
> >> -chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,nowa=
it \
> >>
> >> But it will make primary VM's network not works. (Can't get ip), until
> >> starting connect with secondary VM.
>
> I think you need to check the port 9004 if already connect to the pair
> node.
>
> > I'm not sure of the answer to this; I've not tried doing it - I'm not
> > sure anyone has!
> > But, the colo components do track the state of tcp connections, so I'm
> > expecting that they have to already exist to have the state of those
> > connections available for when you start the secondary.
>
> Yes, you are right.
>
> For this status, we don't need to sync the state of tcp connections,
> because after failover
>
> (or just solo COLO primary node), we have empty all the tcp connections
> state in COLO module.
>
> In the processing of build new COLO pair, we will sync all the VM state
> to secondary node and re-build
>
> new track things in COLO module.
>
>
> >
> >
> >> Otherwise, the primary VM with netfileter / chardev and without
> netfilter /
> >> chardev , they takes very different
> >> booting time.
> >> Without  netfilter / chardev : about 1 mins
> >> With   netfilter / chardev : about 5 mins
> >> Is this an issue?
> > that sounds like it needs investigating.
> >
> > Dave
>
> Yes, In previous COLO use cases, we need make primary node and secondary
> node boot in the same time.
>
> I did't expect such a big difference on netfilter/chardev.
>
> I think you can try without netfilter/chardev, after VM boot, re-build
> the netfilter/chardev related work with chardev server nowait.
>
>
> Thanks
>
> Zhang Chen
>
> >
> >> Best regards,
> >> Daniel Cho
> >>
> >>
> >> Dr. David Alan Gilbert <dgilbert@redhat.com> =E6=96=BC 2019=E5=B9=B412=
=E6=9C=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:58=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >>
> >>> * Daniel Cho (danielcho@qnap.com) wrote:
> >>>> Hi Zhang,
> >>>>
> >>>> We use qemu-4.1.0 release on this case.
> >>>>
> >>>> I think we need use block mirror to sync the disk to secondary node
> >>> first,
> >>>> then stop the primary VM and build COLO system.
> >>>>
> >>>> In the stop moment, you need add some netfilter and chardev socket
> node
> >>> for
> >>>> COLO, maybe you need re-check this part.
> >>>>
> >>>>
> >>>> Our test was already follow those step. Maybe I could describe the
> detail
> >>>> of the test flow and issues.
> >>>>
> >>>>
> >>>> Step 1:
> >>>>
> >>>> Create primary VM without any netfilter and chardev for COLO, and
> using
> >>>> other host ping primary VM continually.
> >>>>
> >>>>
> >>>> Step 2:
> >>>>
> >>>> Create secondary VM (the same device/drive with primary VM), and do
> block
> >>>> mirror sync ( ping to primary VM normally )
> >>>>
> >>>>
> >>>> Step 3:
> >>>>
> >>>> After block mirror sync finish, add those netfilter and chardev to
> >>> primary
> >>>> VM and secondary VM for COLO ( *Can't* ping to primary VM but those
> >>> packets
> >>>> will be received later )
> >>>>
> >>>>
> >>>> Step 4:
> >>>>
> >>>> Start migrate primary VM to secondary VM, and primary VM & secondary
> VM
> >>> are
> >>>> running ( ping to primary VM works and receive those packets on step=
 3
> >>>> status )
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> Between Step 3 to Step 4, it will take 10~20 seconds in our
> environment.
> >>>>
> >>>> I could image this issue (delay reply packets) is because of setting
> COLO
> >>>> proxy for temporary status,
> >>>>
> >>>> but we thought 10~20 seconds might a little long. (If primary VM is
> >>> already
> >>>> doing some jobs, it might lose the data.)
> >>>>
> >>>>
> >>>> Could we reduce those time? or those delay is depends on different V=
M?
> >>> I think you need to set up the netfilter and chardev on the primary a=
t
> >>> the start;  the filter contains the state of the TCP connections
> working
> >>> with the VM, so adding it later can't gain that state for existing
> >>> connections.
> >>>
> >>> Dave
> >>>
> >>>> Best Regard,
> >>>>
> >>>> Daniel Cho.
> >>>>
> >>>>
> >>>>
> >>>> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=
=8830=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:04=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> *From:* Daniel Cho <danielcho@qnap.com>
> >>>>> *Sent:* Friday, November 29, 2019 10:43 AM
> >>>>> *To:* Zhang, Chen <chen.zhang@intel.com>
> >>>>> *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>;
> >>> lukasstraub2@web.de;
> >>>>> qemu-devel@nongnu.org
> >>>>> *Subject:* Re: Network connection with COLO VM
> >>>>>
> >>>>>
> >>>>>
> >>>>> Hi David,  Zhang,
> >>>>>
> >>>>>
> >>>>>
> >>>>> Thanks for replying my question.
> >>>>>
> >>>>> We know why will occur this issue.
> >>>>>
> >>>>> As you said, the COLO VM's network needs
> >>>>>
> >>>>> colo-proxy to control packets, so the guest's
> >>>>>
> >>>>> interface should set the filter to solve the problem.
> >>>>>
> >>>>>
> >>>>>
> >>>>> But we found another question, when we set the
> >>>>>
> >>>>> fault-tolerance feature to guest (primary VM is running,
> >>>>>
> >>>>> secondary VM is pausing), the guest's network would not
> >>>>>
> >>>>> responds any request for a while (in our environment
> >>>>>
> >>>>> about 20~30 secs) after secondary VM runs.
> >>>>>
> >>>>>
> >>>>>
> >>>>> Does it be a normal situation, or a known issue?
> >>>>>
> >>>>>
> >>>>>
> >>>>> Our test is creating primary VM for a while, then creating
> >>>>>
> >>>>> secondary VM to make it with COLO feature.
> >>>>>
> >>>>>
> >>>>>
> >>>>> Hi Daniel,
> >>>>>
> >>>>>
> >>>>>
> >>>>> Happy to hear you have solved ssh disconnection issue.
> >>>>>
> >>>>>
> >>>>>
> >>>>> Do you use Lukas=E2=80=99s patch on this case?
> >>>>>
> >>>>> I think we need use block mirror to sync the disk to secondary node
> >>> first,
> >>>>> then stop the primary VM and build COLO system.
> >>>>>
> >>>>> In the stop moment, you need add some netfilter and chardev socket
> node
> >>>>> for COLO, maybe you need re-check this part.
> >>>>>
> >>>>>
> >>>>>
> >>>>> Best Regard,
> >>>>>
> >>>>> Daniel Cho
> >>>>>
> >>>>>
> >>>>>
> >>>>> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2019=E5=B9=B411=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:26=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>>>>
> >>>>>
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>>>>> Sent: Wednesday, November 27, 2019 6:51 PM
> >>>>>> To: Daniel Cho <danielcho@qnap.com>; Zhang, Chen
> >>>>>> <chen.zhang@intel.com>; lukasstraub2@web.de
> >>>>>> Cc: qemu-devel@nongnu.org
> >>>>>> Subject: Re: Network connection with COLO VM
> >>>>>>
> >>>>>> * Daniel Cho (danielcho@qnap.com) wrote:
> >>>>>>> Hello everyone,
> >>>>>>>
> >>>>>>> Could we ssh to colo VM (means PVM & SVM are starting)?
> >>>>>>>
> >>>>>> Lets cc in Zhang Chen and Lukas Straub.
> >>>>> Thanks Dave.
> >>>>>
> >>>>>>> SSH will connect to colo VM for a while, but it will disconnect
> >>> with
> >>>>>>> error
> >>>>>>> *client_loop: send disconnect: Broken pipe*
> >>>>>>>
> >>>>>>> It seems to colo VM could not keep network session.
> >>>>>>>
> >>>>>>> Does it be a known issue?
> >>>>>> That sounds like the COLO proxy is getting upset; it's supposed to
> >>>>> compare
> >>>>>> packets sent by the primary and secondary and only send one to the
> >>>>> outside
> >>>>>> - you shouldn't be talking directly to the guest, but always via t=
he
> >>>>> proxy.  See
> >>>>>> docs/colo-proxy.txt
> >>>>>>
> >>>>> Hi Daniel,
> >>>>>
> >>>>> I have try ssh to COLO guest with 8 hours, not occurred this issue.
> >>>>> Please check your network/qemu configuration.
> >>>>> But I found another problem maybe related this issue, if no network
> >>>>> communication for a period of time(maybe 10min), the first message
> >>> send to
> >>>>> guest have a chance with delay(maybe 1-5 sec), I will try to fix it
> >>> when I
> >>>>> have time.
> >>>>>
> >>>>> Thanks
> >>>>> Zhang Chen
> >>>>>
> >>>>>> Dave
> >>>>>>
> >>>>>>> Best Regard,
> >>>>>>> Daniel Cho
> >>>>>> --
> >>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>>>
> >>> --
> >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>
> >>>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
>

--00000000000069977305990332ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Dave,=C2=A0 Zhang,<div><br></div><div>Thanks for your h=
elp. I will try your recommendations.=C2=A0</div><div><br></div><div>Best R=
egard,=C2=A0</div><div>Daniel Cho</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">Zhang, Chen &lt;<a href=3D"mailto:ch=
en.zhang@intel.com">chen.zhang@intel.com</a>&gt; =E6=96=BC 2019=E5=B9=B412=
=E6=9C=884=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:32=E5=AF=AB=E9=
=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<br>
On 12/3/2019 9:25 PM, Dr. David Alan Gilbert wrote:<br>
&gt; * Daniel Cho (<a href=3D"mailto:danielcho@qnap.com" target=3D"_blank">=
danielcho@qnap.com</a>) wrote:<br>
&gt;&gt; Hi Dave,<br>
&gt;&gt;<br>
&gt;&gt; We could use the exist interface to add netfilter and chardev, it =
might not<br>
&gt;&gt; have the problem you said.<br>
&gt;&gt;<br>
&gt;&gt; However, the netfilter and chardev on the primary at the start, th=
at means<br>
&gt;&gt; we could not dynamic set COLO<br>
&gt;&gt; feature to VM?<br>
&gt; I wasn&#39;t expecting that to be possible - I&#39;d expect you to be =
able<br>
&gt; to start in a state that looks the same as a primary+failed secondary;=
<br>
&gt; but I&#39;m not sure.<br>
<br>
Current COLO (with Lukas&#39;s patch) can support dynamic set COLO system.<=
br>
<br>
This status is same like the secondary has triggered failover, the <br>
primary node need to find new secondary<br>
<br>
node to combine new COLO system.<br>
<br>
<br>
&gt;&gt; We try to change this chardev to prevent primary VM will stuck to =
wait<br>
&gt;&gt; secondary VM.<br>
&gt;&gt;<br>
&gt;&gt; -chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,=
wait \<br>
&gt;&gt;<br>
&gt;&gt; to<br>
&gt;&gt;<br>
&gt;&gt; -chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,=
nowait \<br>
&gt;&gt;<br>
&gt;&gt; But it will make primary VM&#39;s network not works. (Can&#39;t ge=
t ip), until<br>
&gt;&gt; starting connect with secondary VM.<br>
<br>
I think you need to check the port 9004 if already connect to the pair node=
.<br>
<br>
&gt; I&#39;m not sure of the answer to this; I&#39;ve not tried doing it - =
I&#39;m not<br>
&gt; sure anyone has!<br>
&gt; But, the colo components do track the state of tcp connections, so I&#=
39;m<br>
&gt; expecting that they have to already exist to have the state of those<b=
r>
&gt; connections available for when you start the secondary.<br>
<br>
Yes, you are right.<br>
<br>
For this status, we don&#39;t need to sync the state of tcp connections, <b=
r>
because after failover<br>
<br>
(or just solo COLO primary node), we have empty all the tcp connections <br=
>
state in COLO module.<br>
<br>
In the processing of build new COLO pair, we will sync all the VM state <br=
>
to secondary node and re-build<br>
<br>
new track things in COLO module.<br>
<br>
<br>
&gt;<br>
&gt;<br>
&gt;&gt; Otherwise, the primary VM with netfileter / chardev and without ne=
tfilter /<br>
&gt;&gt; chardev , they takes very different<br>
&gt;&gt; booting time.<br>
&gt;&gt; Without=C2=A0 netfilter / chardev : about 1 mins<br>
&gt;&gt; With=C2=A0 =C2=A0netfilter / chardev : about 5 mins<br>
&gt;&gt; Is this an issue?<br>
&gt; that sounds like it needs investigating.<br>
&gt;<br>
&gt; Dave<br>
<br>
Yes, In previous COLO use cases, we need make primary node and secondary <b=
r>
node boot in the same time.<br>
<br>
I did&#39;t expect such a big difference on netfilter/chardev.<br>
<br>
I think you can try without netfilter/chardev, after VM boot, re-build <br>
the netfilter/chardev related work with chardev server nowait.<br>
<br>
<br>
Thanks<br>
<br>
Zhang Chen<br>
<br>
&gt;<br>
&gt;&gt; Best regards,<br>
&gt;&gt; Daniel Cho<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com" =
target=3D"_blank">dgilbert@redhat.com</a>&gt; =E6=96=BC 2019=E5=B9=B412=E6=
=9C=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:58=E5=AF=AB=E9=81=
=93=EF=BC=9A<br>
&gt;&gt;<br>
&gt;&gt;&gt; * Daniel Cho (<a href=3D"mailto:danielcho@qnap.com" target=3D"=
_blank">danielcho@qnap.com</a>) wrote:<br>
&gt;&gt;&gt;&gt; Hi Zhang,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; We use qemu-4.1.0 release on this case.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I think we need use block mirror to sync the disk to secon=
dary node<br>
&gt;&gt;&gt; first,<br>
&gt;&gt;&gt;&gt; then stop the primary VM and build COLO system.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; In the stop moment, you need add some netfilter and charde=
v socket node<br>
&gt;&gt;&gt; for<br>
&gt;&gt;&gt;&gt; COLO, maybe you need re-check this part.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Our test was already follow those step. Maybe I could desc=
ribe the detail<br>
&gt;&gt;&gt;&gt; of the test flow and issues.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Step 1:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Create primary VM without any netfilter and chardev for CO=
LO, and using<br>
&gt;&gt;&gt;&gt; other host ping primary VM continually.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Step 2:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Create secondary VM (the same device/drive with primary VM=
), and do block<br>
&gt;&gt;&gt;&gt; mirror sync ( ping to primary VM normally )<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Step 3:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; After block mirror sync finish, add those netfilter and ch=
ardev to<br>
&gt;&gt;&gt; primary<br>
&gt;&gt;&gt;&gt; VM and secondary VM for COLO ( *Can&#39;t* ping to primary=
 VM but those<br>
&gt;&gt;&gt; packets<br>
&gt;&gt;&gt;&gt; will be received later )<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Step 4:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Start migrate primary VM to secondary VM, and primary VM &=
amp; secondary VM<br>
&gt;&gt;&gt; are<br>
&gt;&gt;&gt;&gt; running ( ping to primary VM works and receive those packe=
ts on step 3<br>
&gt;&gt;&gt;&gt; status )<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Between Step 3 to Step 4, it will take 10~20 seconds in ou=
r environment.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I could image this issue (delay reply packets) is because =
of setting COLO<br>
&gt;&gt;&gt;&gt; proxy for temporary status,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; but we thought 10~20 seconds might a little long. (If prim=
ary VM is<br>
&gt;&gt;&gt; already<br>
&gt;&gt;&gt;&gt; doing some jobs, it might lose the data.)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Could we reduce those time? or those delay is depends on d=
ifferent VM?<br>
&gt;&gt;&gt; I think you need to set up the netfilter and chardev on the pr=
imary at<br>
&gt;&gt;&gt; the start;=C2=A0 the filter contains the state of the TCP conn=
ections working<br>
&gt;&gt;&gt; with the VM, so adding it later can&#39;t gain that state for =
existing<br>
&gt;&gt;&gt; connections.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Dave<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Best Regard,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Daniel Cho.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" ta=
rget=3D"_blank">chen.zhang@intel.com</a>&gt; =E6=96=BC 2019=E5=B9=B411=E6=
=9C=8830=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:04=E5=AF=AB=E9=81=
=93=EF=BC=9A<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; *From:* Daniel Cho &lt;<a href=3D"mailto:danielcho@qna=
p.com" target=3D"_blank">danielcho@qnap.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; *Sent:* Friday, November 29, 2019 10:43 AM<br>
&gt;&gt;&gt;&gt;&gt; *To:* Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@int=
el.com" target=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; *Cc:* Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgi=
lbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;;<br>
&gt;&gt;&gt; <a href=3D"mailto:lukasstraub2@web.de" target=3D"_blank">lukas=
straub2@web.de</a>;<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_bl=
ank">qemu-devel@nongnu.org</a><br>
&gt;&gt;&gt;&gt;&gt; *Subject:* Re: Network connection with COLO VM<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Hi David,=C2=A0 Zhang,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Thanks for replying my question.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; We know why will occur this issue.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; As you said, the COLO VM&#39;s network needs<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; colo-proxy to control packets, so the guest&#39;s<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; interface should set the filter to solve the problem.<=
br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; But we found another question, when we set the<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; fault-tolerance feature to guest (primary VM is runnin=
g,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; secondary VM is pausing), the guest&#39;s network woul=
d not<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; responds any request for a while (in our environment<b=
r>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; about 20~30 secs) after secondary VM runs.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Does it be a normal situation, or a known issue?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Our test is creating primary VM for a while, then crea=
ting<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; secondary VM to make it with COLO feature.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Hi Daniel,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Happy to hear you have solved ssh disconnection issue.=
<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Do you use Lukas=E2=80=99s patch on this case?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I think we need use block mirror to sync the disk to s=
econdary node<br>
&gt;&gt;&gt; first,<br>
&gt;&gt;&gt;&gt;&gt; then stop the primary VM and build COLO system.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; In the stop moment, you need add some netfilter and ch=
ardev socket node<br>
&gt;&gt;&gt;&gt;&gt; for COLO, maybe you need re-check this part.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Best Regard,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Daniel Cho<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com=
" target=3D"_blank">chen.zhang@intel.com</a>&gt; =E6=96=BC 2019=E5=B9=B411=
=E6=9C=8828=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:26=E5=AF=AB=E9=
=81=93=EF=BC=9A<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt;&gt;&gt; From: Dr. David Alan Gilbert &lt;<a href=3D"mailto=
:dgilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Sent: Wednesday, November 27, 2019 6:51 PM<br>
&gt;&gt;&gt;&gt;&gt;&gt; To: Daniel Cho &lt;<a href=3D"mailto:danielcho@qna=
p.com" target=3D"_blank">danielcho@qnap.com</a>&gt;; Zhang, Chen<br>
&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:chen.zhang@intel.com" target=
=3D"_blank">chen.zhang@intel.com</a>&gt;; <a href=3D"mailto:lukasstraub2@we=
b.de" target=3D"_blank">lukasstraub2@web.de</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" targe=
t=3D"_blank">qemu-devel@nongnu.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; Subject: Re: Network connection with COLO VM<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; * Daniel Cho (<a href=3D"mailto:danielcho@qnap.com=
" target=3D"_blank">danielcho@qnap.com</a>) wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hello everyone,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Could we ssh to colo VM (means PVM &amp; SVM a=
re starting)?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Lets cc in Zhang Chen and Lukas Straub.<br>
&gt;&gt;&gt;&gt;&gt; Thanks Dave.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; SSH will connect to colo VM for a while, but i=
t will disconnect<br>
&gt;&gt;&gt; with<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; error<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; *client_loop: send disconnect: Broken pipe*<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; It seems to colo VM could not keep network ses=
sion.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Does it be a known issue?<br>
&gt;&gt;&gt;&gt;&gt;&gt; That sounds like the COLO proxy is getting upset; =
it&#39;s supposed to<br>
&gt;&gt;&gt;&gt;&gt; compare<br>
&gt;&gt;&gt;&gt;&gt;&gt; packets sent by the primary and secondary and only=
 send one to the<br>
&gt;&gt;&gt;&gt;&gt; outside<br>
&gt;&gt;&gt;&gt;&gt;&gt; - you shouldn&#39;t be talking directly to the gue=
st, but always via the<br>
&gt;&gt;&gt;&gt;&gt; proxy.=C2=A0 See<br>
&gt;&gt;&gt;&gt;&gt;&gt; docs/colo-proxy.txt<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Hi Daniel,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I have try ssh to COLO guest with 8 hours, not occurre=
d this issue.<br>
&gt;&gt;&gt;&gt;&gt; Please check your network/qemu configuration.<br>
&gt;&gt;&gt;&gt;&gt; But I found another problem maybe related this issue, =
if no network<br>
&gt;&gt;&gt;&gt;&gt; communication for a period of time(maybe 10min), the f=
irst message<br>
&gt;&gt;&gt; send to<br>
&gt;&gt;&gt;&gt;&gt; guest have a chance with delay(maybe 1-5 sec), I will =
try to fix it<br>
&gt;&gt;&gt; when I<br>
&gt;&gt;&gt;&gt;&gt; have time.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Thanks<br>
&gt;&gt;&gt;&gt;&gt; Zhang Chen<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Dave<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Best Regard,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Daniel Cho<br>
&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt; Dr. David Alan Gilbert / <a href=3D"mailto:dgilber=
t@redhat.com" target=3D"_blank">dgilbert@redhat.com</a> / Manchester, UK<br=
>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com=
" target=3D"_blank">dgilbert@redhat.com</a> / Manchester, UK<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt; --<br>
&gt; Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=
=3D"_blank">dgilbert@redhat.com</a> / Manchester, UK<br>
&gt;<br>
</blockquote></div>

--00000000000069977305990332ed--

