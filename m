Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9490AC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0EE20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="U9X4v6i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0EE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j24me-00041F-Ft
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1j24lt-0003MK-6e
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1j24lp-00046e-71
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:02:33 -0500
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135]:40814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1j24lo-00045f-Rw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:02:29 -0500
Received: by mail-il1-x135.google.com with SMTP id i7so3677238ilr.7
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bgm+XLUbXPjFMRlyuCkOpdJtOnu1inFRU+dLjPtRo/g=;
 b=U9X4v6i3xkK14t55LuVVcKMZDVkweXpfULSWwacChAz05zl7BJS/2bfdfaHVMChQF1
 rYLHHOIDUp18iRQtxY+3UDx9OMbDDeeVMU6brUylx1hxd2YdHoOm/jKZwlmZ3/bnOKjc
 TiPp52Eh4/tip+htdqC2DKwSS+pGgvuCzAzzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bgm+XLUbXPjFMRlyuCkOpdJtOnu1inFRU+dLjPtRo/g=;
 b=V1TMbySyE7jhwdVR5VkE1CCE1Gj1ocSM8oTYSwFe4PqI74/EKLwxQyKWMdgOe5mIWI
 toGxyW2OOqfpe+EoRUhJEEppZrvKJkHcrWxrMobhvtZeT5ItIrVkOJLKgggf8Z/Qf0lU
 vrKFOhtxeUZQaVfnaGjIHAUG8Xmk1CRP0pg3Ce+3J9v9KidbXEXvm+rpCN0mNinaNuGV
 Wwitjb5KkClm6Jwa0I5iFl/bULY7yx2Lse/Pa40s/3HnKPi/bGAq2PIo9+ALMUsBD6kJ
 1/LVNBc0rCOm2AN/I6E3QDGv8XTlZkblm6gAX54UriOn6ISPe97SqqPTiGC8nUUT3Xpb
 u+Hg==
X-Gm-Message-State: APjAAAUfdpDGu2eOuf5VhndisvMxaM4PWw8bkCVXS4N5VnqxDmh8I09d
 KJ7rGzbCWwN9Ea3PsIn/m+Gqp2OekWbbgN78E5sp0g==
X-Google-Smtp-Source: APXvYqxWxosdYUcmsc5t2RdP54L6PhCiTIZ1cdM64J0Vg1hqdFTfhwYTdnfVM0YPbPM4UhoPvkz5rm8yfozC7RucOUM=
X-Received: by 2002:a92:d244:: with SMTP id v4mr14737525ilg.114.1581562947895; 
 Wed, 12 Feb 2020 19:02:27 -0800 (PST)
MIME-Version: 1.0
References: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
 <20200211174756.GA2798@work-vm> <8737854e2826400fa4d14dc408cfd947@huawei.com>
 <2b09c8650b944c908c0c95fefe6d759f@intel.com>
 <CA+XQNE5hn=FJh7cq5YP0ydYEHkap-a-9AXeTLJd=24sQ1DWkwg@mail.gmail.com>
 <1bf96353e8e2490098a71d0d1182986a@huawei.com>
 <51f95ec9ed4a4cc682e63abf1414979b@intel.com>
 <b440cfb28e6c4aa38d79b93ed04a106f@intel.com>
In-Reply-To: <b440cfb28e6c4aa38d79b93ed04a106f@intel.com>
From: Daniel Cho <danielcho@qnap.com>
Date: Thu, 13 Feb 2020 11:02:16 +0800
Message-ID: <CA+XQNE78cE-wMtNZBrXa+HQmuXmRGtjKJr_0JXaYPCEFEhXgwQ@mail.gmail.com>
Subject: Re: The issues about architecture of the COLO checkpoint
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="000000000000b32486059e6c5158"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::135
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
 Jason Wang <jasowang@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b32486059e6c5158
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hailiang,

1.
    OK, we will try the patch
=E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=80=9D,
and thanks for your help.

2.
    We understand the reason to compare PVM and SVM's packet. However, the
empty of SVM's packet queue might happened on setting COLO feature and SVM
broken.

On situation 1 ( setting COLO feature ):
    We could force do checkpoint after setting COLO feature finish, then it
will protect the state of PVM and SVM . As the Zhang Chen said.

On situation 2 ( SVM broken ):
    COLO will do failover for PVM, so it might not cause any wrong on PVM.

However, those situations are our views, so there might be a big difference
between reality and our views.
If we have any wrong views and opinions, please let us know, and correct
us.
Thanks.

Best regards,
Daniel Cho

Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:17=E5=AF=AB=E9=81=93=EF=BC=
=9A

> Add cc Jason Wang, he is a network expert.
>
> In case some network things goes wrong.
>
>
>
> Thanks
>
> Zhang Chen
>
>
>
> *From:* Zhang, Chen
> *Sent:* Thursday, February 13, 2020 10:10 AM
> *To:* 'Zhanghailiang' <zhang.zhanghailiang@huawei.com>; Daniel Cho <
> danielcho@qnap.com>
> *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>; qemu-devel@nongnu.org
> *Subject:* RE: The issues about architecture of the COLO checkpoint
>
>
>
> For the issue 2:
>
>
>
> COLO need use the network packets to confirm PVM and SVM in the same stat=
e,
>
> Generally speaking, we can=E2=80=99t send PVM packets without compared wi=
th SVM
> packets.
>
> But to prevent jamming, I think COLO can do force checkpoint and send the
> PVM packets in this case.
>
>
>
> Thanks
>
> Zhang Chen
>
>
>
> *From:* Zhanghailiang <zhang.zhanghailiang@huawei.com>
> *Sent:* Thursday, February 13, 2020 9:45 AM
> *To:* Daniel Cho <danielcho@qnap.com>
> *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>; qemu-devel@nongnu.org=
;
> Zhang, Chen <chen.zhang@intel.com>
> *Subject:* RE: The issues about architecture of the COLO checkpoint
>
>
>
> Hi,
>
>
>
> 1.       After re-walked through the codes, yes, you are right, actually,
> after the first migration, we will keep dirty log on in primary side,
>
> And only send the dirty pages in PVM to SVM. The ram cache in secondary
> side is always a backup of PVM, so we don=E2=80=99t have to
>
> Re-send the none-dirtied pages.
>
> The reason why the first checkpoint takes longer time is we have to backu=
p
> the whole VM=E2=80=99s ram into ram cache, that is colo_init_ram_cache().
>
> It is time consuming, but I have optimized in the second patch
> =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=80=9D which y=
ou can find in my
> previous reply.
>
>
>
> Besides, I found that, In my previous reply =E2=80=9CWe can only copy the=
 pages
> that dirtied by PVM and SVM in last checkpoint.=E2=80=9D,
>
> We have done this optimization in current upstream codes.
>
>
>
> 2=EF=BC=8EI don=E2=80=99t quite understand this question. For COLO, we al=
ways need both
> network packets of PVM=E2=80=99s and SVM=E2=80=99s to compare before send=
 this packets to
> client.
>
> It depends on this to decide whether or not PVM and SVM are in same state=
.
>
>
>
> Thanks,
>
> hailiang
>
>
>
> *From:* Daniel Cho [mailto:danielcho@qnap.com <danielcho@qnap.com>]
> *Sent:* Wednesday, February 12, 2020 4:37 PM
> *To:* Zhang, Chen <chen.zhang@intel.com>
> *Cc:* Zhanghailiang <zhang.zhanghailiang@huawei.com>; Dr. David Alan
> Gilbert <dgilbert@redhat.com>; qemu-devel@nongnu.org
> *Subject:* Re: The issues about architecture of the COLO checkpoint
>
>
>
> Hi Hailiang,
>
>
>
> Thanks for your replaying and explain in detail.
>
> We will try to use the attachments to enhance memory copy.
>
>
>
> However, we have some questions for your replying.
>
>
>
> 1.  As you said, "for each checkpoint, we have to send the whole PVM's
> pages To SVM", why the only first checkpoint will takes more pause time?
>
> In our observing, the first checkpoint will take more time for pausing,
> then other checkpoints will takes a few time for pausing. Does it means
> only the first checkpoint will send the whole pages to SVM, and the other
> checkpoints send the dirty pages to SVM for reloading?
>
>
>
> 2. We notice the COLO-COMPARE component will stuck the packet until
> receive packets from PVM and SVM, as this rule, when we add the
> COLO-COMPARE to PVM, its network will stuck until SVM start. So it is an
> other issue to make PVM stuck while setting COLO feature. With this issue=
,
> could we let colo-compare to pass the PVM's packet when the SVM's packet
> queue is empty? Then, the PVM's network won't stock, and "if PVM runs
> firstly, it still need to wait for The network packets from SVM to
> compare before send it to client side" won't happened either.
>
>
>
> Best regard,
>
> Daniel Cho
>
>
>
> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
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

--000000000000b32486059e6c5158
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Hailiang,=C2=A0<div><br></div><div></d=
iv><div>1.</div><div>=C2=A0 =C2=A0 OK, we will try the patch=C2=A0<span sty=
le=3D"font-family:Calibri,sans-serif;font-size:14px">=E2=80=9C0001-COLO-Opt=
imize-memory-</span><span style=3D"font-family:Calibri,sans-serif;font-size=
:14px">back-up-process.patch=E2=80=9D, and thanks for your help.</span></di=
v><div><span style=3D"font-family:Calibri,sans-serif;font-size:14px"><br></=
span></div><div>2.</div><div>=C2=A0 =C2=A0 We understand the reason to comp=
are PVM and SVM&#39;s packet. However, the empty of SVM&#39;s packet queue =
might happened on <font color=3D"#ff0000">setting COLO feature</font> and <=
font color=3D"#ff0000">SVM broken</font>.=C2=A0</div><div></div><div><br></=
div><div>On situation 1 (

setting COLO feature ):=C2=A0</div><div>=C2=A0 =C2=A0 We could force do che=
ckpoint after setting COLO feature finish, then it will protect the state o=
f PVM and SVM . As the Zhang Chen said.</div><div><br></div><div>On situati=
on 2 (

SVM broken

 ):=C2=A0 =C2=A0<br></div><div>=C2=A0 =C2=A0 COLO will do failover for PVM,=
 so it might not cause any wrong on PVM.</div><div><br></div><div>However, =
those situations are our views, so there might be a big difference between =
reality and our views.</div><div>If we have any wrong views and opinions, p=
lease=C2=A0let us know, and correct us.=C2=A0</div><div></div><div>Thanks.<=
br></div><div><br></div><div>Best regards,</div><div>Daniel Cho</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Zhang,=
 Chen &lt;<a href=3D"mailto:chen.zhang@intel.com">chen.zhang@intel.com</a>&=
gt; =E6=96=BC 2020=E5=B9=B42=E6=9C=8813=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=
=8A=E5=8D=8810:17=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div class=3D"gmail-m_1776842754425724004WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">Add cc Jason Wang, he is a network expert.<u></u><u></u></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">In case some network things goes wrong.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">Thanks<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">Zhang Chen<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><a name=3D"m_1776842754425724004______replyseparator=
"></a><b><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">From=
:</span></b><span style=3D"font-size:11pt;font-family:Calibri,sans-serif"> =
Zhang, Chen
<br>
<b>Sent:</b> Thursday, February 13, 2020 10:10 AM<br>
<b>To:</b> &#39;Zhanghailiang&#39; &lt;<a href=3D"mailto:zhang.zhanghailian=
g@huawei.com" target=3D"_blank">zhang.zhanghailiang@huawei.com</a>&gt;; Dan=
iel Cho &lt;<a href=3D"mailto:danielcho@qnap.com" target=3D"_blank">danielc=
ho@qnap.com</a>&gt;<br>
<b>Cc:</b> Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com=
" target=3D"_blank">dgilbert@redhat.com</a>&gt;; <a href=3D"mailto:qemu-dev=
el@nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a><br>
<b>Subject:</b> RE: The issues about architecture of the COLO checkpoint<u>=
</u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">For the issue 2:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">COLO need use the network packets to confirm PVM and SVM in the s=
ame state,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">Generally speaking, we can=E2=80=99t send PVM packets without com=
pared with SVM packets.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">But to prevent jamming, I think COLO can do force checkpoint and =
send the PVM packets in this case.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">Thanks<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif">Zhang Chen<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:Calibri=
,sans-serif">From:</span></b><span style=3D"font-size:11pt;font-family:Cali=
bri,sans-serif"> Zhanghailiang &lt;<a href=3D"mailto:zhang.zhanghailiang@hu=
awei.com" target=3D"_blank">zhang.zhanghailiang@huawei.com</a>&gt;
<br>
<b>Sent:</b> Thursday, February 13, 2020 9:45 AM<br>
<b>To:</b> Daniel Cho &lt;<a href=3D"mailto:danielcho@qnap.com" target=3D"_=
blank">danielcho@qnap.com</a>&gt;<br>
<b>Cc:</b> Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com=
" target=3D"_blank">dgilbert@redhat.com</a>&gt;;
<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongn=
u.org</a>; Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=
=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
<b>Subject:</b> RE: The issues about architecture of the COLO checkpoint<u>=
</u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif">Hi,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"gmail-m_1776842754425724004MsoListParagraph" style=3D"margin-le=
ft:0.25in">
<u></u><span style=3D"font-size:10.5pt;font-family:Calibri,sans-serif"><spa=
n>1.<span style=3D"font:7pt &quot;Times New Roman&quot;">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
</span></span></span><u></u><span style=3D"font-size:10.5pt;font-family:Cal=
ibri,sans-serif">After re-walked through the codes, yes, you are right, act=
ually, after the first migration, we will keep dirty log on in primary side=
,<u></u><u></u></span></p>
<p class=3D"gmail-m_1776842754425724004MsoListParagraph" style=3D"margin-le=
ft:0.25in;text-indent:0in"><span style=3D"font-size:10.5pt;font-family:Cali=
bri,sans-serif">And only send the dirty pages in PVM to SVM. The ram cache =
in secondary side is always a backup of PVM, so we don=E2=80=99t have to<u>=
</u><u></u></span></p>
<p class=3D"gmail-m_1776842754425724004MsoListParagraph" style=3D"margin-le=
ft:0.25in;text-indent:0in"><span style=3D"font-size:10.5pt;font-family:Cali=
bri,sans-serif">Re-send the none-dirtied pages.<u></u><u></u></span></p>
<p class=3D"gmail-m_1776842754425724004MsoListParagraph" style=3D"margin-le=
ft:0.25in;text-indent:0in"><span style=3D"font-size:10.5pt;font-family:Cali=
bri,sans-serif">The reason why the first checkpoint takes longer time is we=
 have to backup the whole VM=E2=80=99s ram into ram cache, that is colo_ini=
t_ram_cache().<u></u><u></u></span></p>
<p class=3D"gmail-m_1776842754425724004MsoListParagraph" style=3D"margin-le=
ft:0.25in;text-indent:0in"><span style=3D"font-size:10.5pt;font-family:Cali=
bri,sans-serif">It is time consuming, but I have optimized in the second pa=
tch =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=80=9D which=
 you
 can find in my previous reply.<u></u><u></u></span></p>
<p class=3D"gmail-m_1776842754425724004MsoListParagraph" style=3D"margin-le=
ft:0.25in;text-indent:0in"><span style=3D"font-size:10.5pt;font-family:Cali=
bri,sans-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"gmail-m_1776842754425724004MsoListParagraph" style=3D"margin-le=
ft:0.25in;text-indent:0in"><span style=3D"font-size:10.5pt;font-family:Cali=
bri,sans-serif">Besides, I found that, In my previous reply =E2=80=9C</span=
><span style=3D"color:red">We can only copy the pages that dirtied by PVM
 and SVM in last checkpoint</span>.<span style=3D"font-size:10.5pt;font-fam=
ily:Calibri,sans-serif">=E2=80=9D,<u></u><u></u></span></p>
<p class=3D"gmail-m_1776842754425724004MsoListParagraph" style=3D"margin-le=
ft:0.25in;text-indent:0in"><span style=3D"font-size:10.5pt;font-family:Cali=
bri,sans-serif">We have done this optimization in current upstream codes.
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif">2</span><span lang=3D"ZH-CN" style=3D"font-size:10.5pt">=EF=BC=
=8E</span><span style=3D"font-size:10.5pt;font-family:Calibri,sans-serif">I=
 don=E2=80=99t quite understand this question. For COLO,
 we always need both network packets of PVM=E2=80=99s and SVM=E2=80=99s to =
compare before send this packets to client.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif">It depends on this to decide whether or not PVM and SVM are in =
same state.
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif">Thanks,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif">hailiang<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:Calibri=
,sans-serif">From:</span></b><span style=3D"font-size:11pt;font-family:Cali=
bri,sans-serif"> Daniel Cho [<a href=3D"mailto:danielcho@qnap.com" target=
=3D"_blank">mailto:danielcho@qnap.com</a>]
<br>
<b>Sent:</b> Wednesday, February 12, 2020 4:37 PM<br>
<b>To:</b> Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=
=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
<b>Cc:</b> Zhanghailiang &lt;<a href=3D"mailto:zhang.zhanghailiang@huawei.c=
om" target=3D"_blank">zhang.zhanghailiang@huawei.com</a>&gt;; Dr. David Ala=
n Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com" target=3D"_blank">dgil=
bert@redhat.com</a>&gt;;
<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongn=
u.org</a><br>
<b>Subject:</b> Re: The issues about architecture of the COLO checkpoint<u>=
</u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Hi Hailiang,=C2=A0<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks for your replaying and explain in detail.=C2=
=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">We will try to use the attachments to enhance memory=
 copy.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">However, we have some questions for your replying.=
=C2=A0=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">1.=C2=A0 As you said, &quot;<span style=3D"color:red=
">for each checkpoint, we have to send=C2=A0<span class=3D"gmail-m_17768427=
54425724004gmail-il">the</span>=C2=A0whole PVM&#39;s pages To SVM</span>&qu=
ot;, why the only first checkpoint will takes more pause time?<u></u><u></u=
></p>
</div>
<div>
<p class=3D"MsoNormal">In our observing, the first checkpoint will take mor=
e time for pausing, then other checkpoints will takes a few time for pausin=
g. Does it means only the first checkpoint=C2=A0will send the whole pages t=
o SVM, and the other checkpoints send the
 dirty pages to SVM for reloading?<span style=3D"color:rgb(31,73,125)"><u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:Calibri,=
sans-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal">2. We notice the COLO-COMPARE component=C2=A0will st=
uck the packet until receive=C2=A0packets from PVM and SVM, as this rule, w=
hen we add the COLO-COMPARE to PVM, its network=C2=A0will stuck until SVM s=
tart. So it is an other issue to make PVM stuck while
 setting COLO feature. With this issue, could we let colo-compare to pass t=
he PVM&#39;s packet when the SVM&#39;s packet queue is empty? Then, the PVM=
&#39;s network won&#39;t stock, and &quot;<span style=3D"color:red">if PVM =
runs firstly, it still need to wait for=C2=A0<span class=3D"gmail-m_1776842=
754425724004gmail-il">The</span>=C2=A0network
 packets from SVM to compare before send it to client side</span>&quot; won=
&#39;t happened either.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Best regard,=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Daniel Cho<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.c=
om" target=3D"_blank">chen.zhang@intel.com</a>&gt;
<span lang=3D"ZH-CN">=E6=96=BC</span> 2020<span lang=3D"ZH-CN">=E5=B9=B4</s=
pan>2<span lang=3D"ZH-CN">=E6=9C=88</span>12<span lang=3D"ZH-CN">=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=88</span>1:45<span lang=3D"ZH-CN">=E5=AF=
=AB=E9=81=93=EF=BC=9A</span><u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin:5pt 0i=
n 5pt 4.8pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><br>
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
ank">danielcho@qnap.com</a>&gt;;
<a href=3D"mailto:chen.zhang@intel.com" target=3D"_blank">chen.zhang@intel.=
com</a>;<br>
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
o.c#L503" target=3D"_blank">
https://github.com/qemu/qemu/blob/master/migration/colo.c#L503</a>,<br>
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
=3D"_blank">dgilbert@redhat.com</a> / Manchester, UK<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>
</div>
</div>
</div>

</blockquote></div></div>

--000000000000b32486059e6c5158--

