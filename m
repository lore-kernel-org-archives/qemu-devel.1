Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438EEC34034
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0298120658
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="decQIUwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0298120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3z6X-00019s-5m
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1j3z5j-00006v-Hg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1j3z5g-00052C-6z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:22:55 -0500
Received: from mail-yw1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:43290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1j3z5f-000523-UI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:22:52 -0500
Received: by mail-yw1-xc2a.google.com with SMTP id f204so9096120ywc.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WL/B2Pa3O0PyKZCBowM1ZyvV7s8dv9a311MU+P/rmF4=;
 b=decQIUwlg0SXByx6SdknRve/RhBxlFRZTR44hwif3joEQxys09H3rddZq5kwSWIbQl
 h232oMDU4KP9k7NhoHTR13gGk1YbgKAmn7ki5SjHVvUjwYl7+ruhAOtQ0zRg0og48n3H
 Ja/Aq1C9idUZS+qwB62xFLoxB6kNJJvJHdboU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WL/B2Pa3O0PyKZCBowM1ZyvV7s8dv9a311MU+P/rmF4=;
 b=fXOtv70sT43pIWudRcZaT7HlI4y3a9JMHSzQ4CYXVNEEAUMdmym8TW0PtA8dRAjKcL
 ziocrOpRGJbj7k9VZ9Penz5dCtYwqFUYsHfTlWJgZx4Ox/nGJoJUZD5rNf6ZTdvikEwh
 J+yXwQQM8X51Q7aEXSNbq6KkM0HjGflxG+6ritQAfbjTblj7MeIc7aD1Oou/FaY7+cef
 PqxNuHe1j1IfmXmYBFZq3Hfl4BiDG3qyWGE7QSjQEC84DIJSC12QVLieNvwkojGAUjsM
 zqoVTI3y/uFvZh41i9dgsf7w96fL4CfbuAmHJdvujha81Jfh8j5V9dfqZrOSekMkF5wc
 Jb0w==
X-Gm-Message-State: APjAAAUXV+qMGhHIny5OSGYd0w1kLhC3mTvntaB89P0YLm8Tii3NO5En
 0YqKb5a5IlgOSC8Pyrte9Y8o7+Xv7TuT6NXaupQOBw==
X-Google-Smtp-Source: APXvYqydEK7mqPMQ24gW3HIs9ibl+Hi8jUyWDdZTWt4qUPgQPlC1ksi/07Qqn84AHTOibZCpGgJZzjPXlEQvAUqGHkY=
X-Received: by 2002:a0d:eb0d:: with SMTP id u13mr16222546ywe.257.1582017771004; 
 Tue, 18 Feb 2020 01:22:51 -0800 (PST)
MIME-Version: 1.0
References: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
 <20200211174756.GA2798@work-vm> <8737854e2826400fa4d14dc408cfd947@huawei.com>
 <2b09c8650b944c908c0c95fefe6d759f@intel.com>
 <CA+XQNE5hn=FJh7cq5YP0ydYEHkap-a-9AXeTLJd=24sQ1DWkwg@mail.gmail.com>
 <1bf96353e8e2490098a71d0d1182986a@huawei.com>
 <51f95ec9ed4a4cc682e63abf1414979b@intel.com>
 <b440cfb28e6c4aa38d79b93ed04a106f@intel.com>
 <CA+XQNE78cE-wMtNZBrXa+HQmuXmRGtjKJr_0JXaYPCEFEhXgwQ@mail.gmail.com>
 <20200213103752.GE2960@work-vm>
 <CA+XQNE7i15fTmwN6UL_fNi1e2sEb5v6+T05FaYdy0nS-DFC9HA@mail.gmail.com>
 <e820e35d-5b8a-18c8-736b-6c38cff9798e@intel.com>
In-Reply-To: <e820e35d-5b8a-18c8-736b-6c38cff9798e@intel.com>
From: Daniel Cho <danielcho@qnap.com>
Date: Tue, 18 Feb 2020 17:22:39 +0800
Message-ID: <CA+XQNE49wq2nRKJ0CA4uHDZ4OUEbFGPKBfAWB4+UwPYgiZkrCw@mail.gmail.com>
Subject: Re: The issues about architecture of the COLO checkpoint
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="000000000000450161059ed6370d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c2a
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000450161059ed6370d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hailiang,
Thanks for your help. If we have any problems we will contact you for your
favor.


Hi Zhang,

" If colo-compare got a primary packet without related secondary packet in
a certain time , it will automatically trigger checkpoint.  "
As you said, the colo-compare will trigger checkpoint, but does it need to
limit checkpoint times?
There is a problem about doing many checkpoints while we use fio to random
write files. Then it will cause low throughput on PVM.
Is this situation is normal on COLO?

Best regards,
Daniel Cho

Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:36=E5=AF=AB=E9=81=93=EF=BC=9A

>
> On 2/15/2020 11:35 AM, Daniel Cho wrote:
>
> Hi Dave,
>
> Yes, I agree with you, it does need a timeout.
>
>
> Hi Daniel and Dave,
>
> Current colo-compare already have the timeout mechanism.
>
> Named packet_check_timer,  It will scan primary packet queue to make sure
> all the primary packet not stay too long time.
>
> If colo-compare got a primary packet without related secondary packet in =
a
> certain time , it will automatic trigger checkpoint.
>
> https://github.com/qemu/qemu/blob/master/net/colo-compare.c#L847
>
>
> Thanks
>
> Zhang Chen
>
>
>
> Hi Hailiang,
>
> We base on qemu-4.1.0 for using COLO feature, in your patch, we found a
> lot of difference  between your version and ours.
> Could you give us a latest release version which is close your developing
> code?
>
> Thanks.
>
> Regards
> Daniel Cho
>
> Dr. David Alan Gilbert <dgilbert@redhat.com> =E6=96=BC 2020=E5=B9=B42=E6=
=9C=8813=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:38=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
>> * Daniel Cho (danielcho@qnap.com) wrote:
>> > Hi Hailiang,
>> >
>> > 1.
>> >     OK, we will try the patch
>> > =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=80=9D,
>> > and thanks for your help.
>> >
>> > 2.
>> >     We understand the reason to compare PVM and SVM's packet. However,
>> the
>> > empty of SVM's packet queue might happened on setting COLO feature and
>> SVM
>> > broken.
>> >
>> > On situation 1 ( setting COLO feature ):
>> >     We could force do checkpoint after setting COLO feature finish,
>> then it
>> > will protect the state of PVM and SVM . As the Zhang Chen said.
>> >
>> > On situation 2 ( SVM broken ):
>> >     COLO will do failover for PVM, so it might not cause any wrong on
>> PVM.
>> >
>> > However, those situations are our views, so there might be a big
>> difference
>> > between reality and our views.
>> > If we have any wrong views and opinions, please let us know, and corre=
ct
>> > us.
>>
>> It does need a timeout; the SVM being broken or being in a state where
>> it never sends the corresponding packet (because of a state difference)
>> can happen and COLO needs to timeout when the packet hasn't arrived
>> after a while and trigger the checkpoint.
>>
>> Dave
>>
>> > Thanks.
>> >
>> > Best regards,
>> > Daniel Cho
>> >
>> > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8813=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:17=E5=AF=AB=E9=81=93=EF=
=BC=9A
>> >
>> > > Add cc Jason Wang, he is a network expert.
>> > >
>> > > In case some network things goes wrong.
>> > >
>> > >
>> > >
>> > > Thanks
>> > >
>> > > Zhang Chen
>> > >
>> > >
>> > >
>> > > *From:* Zhang, Chen
>> > > *Sent:* Thursday, February 13, 2020 10:10 AM
>> > > *To:* 'Zhanghailiang' <zhang.zhanghailiang@huawei.com>; Daniel Cho <
>> > > danielcho@qnap.com>
>> > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>;
>> qemu-devel@nongnu.org
>> > > *Subject:* RE: The issues about architecture of the COLO checkpoint
>> > >
>> > >
>> > >
>> > > For the issue 2:
>> > >
>> > >
>> > >
>> > > COLO need use the network packets to confirm PVM and SVM in the same
>> state,
>> > >
>> > > Generally speaking, we can=E2=80=99t send PVM packets without compar=
ed with
>> SVM
>> > > packets.
>> > >
>> > > But to prevent jamming, I think COLO can do force checkpoint and sen=
d
>> the
>> > > PVM packets in this case.
>> > >
>> > >
>> > >
>> > > Thanks
>> > >
>> > > Zhang Chen
>> > >
>> > >
>> > >
>> > > *From:* Zhanghailiang <zhang.zhanghailiang@huawei.com>
>> > > *Sent:* Thursday, February 13, 2020 9:45 AM
>> > > *To:* Daniel Cho <danielcho@qnap.com>
>> > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>;
>> qemu-devel@nongnu.org;
>> > > Zhang, Chen <chen.zhang@intel.com>
>> > > *Subject:* RE: The issues about architecture of the COLO checkpoint
>> > >
>> > >
>> > >
>> > > Hi,
>> > >
>> > >
>> > >
>> > > 1.       After re-walked through the codes, yes, you are right,
>> actually,
>> > > after the first migration, we will keep dirty log on in primary side=
,
>> > >
>> > > And only send the dirty pages in PVM to SVM. The ram cache in
>> secondary
>> > > side is always a backup of PVM, so we don=E2=80=99t have to
>> > >
>> > > Re-send the none-dirtied pages.
>> > >
>> > > The reason why the first checkpoint takes longer time is we have to
>> backup
>> > > the whole VM=E2=80=99s ram into ram cache, that is colo_init_ram_cac=
he().
>> > >
>> > > It is time consuming, but I have optimized in the second patch
>> > > =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=80=9D wh=
ich you can find
>> in my
>> > > previous reply.
>> > >
>> > >
>> > >
>> > > Besides, I found that, In my previous reply =E2=80=9CWe can only cop=
y the
>> pages
>> > > that dirtied by PVM and SVM in last checkpoint.=E2=80=9D,
>> > >
>> > > We have done this optimization in current upstream codes.
>> > >
>> > >
>> > >
>> > > 2=EF=BC=8EI don=E2=80=99t quite understand this question. For COLO, =
we always need
>> both
>> > > network packets of PVM=E2=80=99s and SVM=E2=80=99s to compare before=
 send this
>> packets to
>> > > client.
>> > >
>> > > It depends on this to decide whether or not PVM and SVM are in same
>> state.
>> > >
>> > >
>> > >
>> > > Thanks,
>> > >
>> > > hailiang
>> > >
>> > >
>> > >
>> > > *From:* Daniel Cho [mailto:danielcho@qnap.com <danielcho@qnap.com>]
>> > > *Sent:* Wednesday, February 12, 2020 4:37 PM
>> > > *To:* Zhang, Chen <chen.zhang@intel.com>
>> > > *Cc:* Zhanghailiang <zhang.zhanghailiang@huawei.com>; Dr. David Alan
>> > > Gilbert <dgilbert@redhat.com>; qemu-devel@nongnu.org
>> > > *Subject:* Re: The issues about architecture of the COLO checkpoint
>> > >
>> > >
>> > >
>> > > Hi Hailiang,
>> > >
>> > >
>> > >
>> > > Thanks for your replaying and explain in detail.
>> > >
>> > > We will try to use the attachments to enhance memory copy.
>> > >
>> > >
>> > >
>> > > However, we have some questions for your replying.
>> > >
>> > >
>> > >
>> > > 1.  As you said, "for each checkpoint, we have to send the whole PVM=
's
>> > > pages To SVM", why the only first checkpoint will takes more pause
>> time?
>> > >
>> > > In our observing, the first checkpoint will take more time for
>> pausing,
>> > > then other checkpoints will takes a few time for pausing. Does it
>> means
>> > > only the first checkpoint will send the whole pages to SVM, and the
>> other
>> > > checkpoints send the dirty pages to SVM for reloading?
>> > >
>> > >
>> > >
>> > > 2. We notice the COLO-COMPARE component will stuck the packet until
>> > > receive packets from PVM and SVM, as this rule, when we add the
>> > > COLO-COMPARE to PVM, its network will stuck until SVM start. So it i=
s
>> an
>> > > other issue to make PVM stuck while setting COLO feature. With this
>> issue,
>> > > could we let colo-compare to pass the PVM's packet when the SVM's
>> packet
>> > > queue is empty? Then, the PVM's network won't stock, and "if PVM run=
s
>> > > firstly, it still need to wait for The network packets from SVM to
>> > > compare before send it to client side" won't happened either.
>> > >
>> > >
>> > >
>> > > Best regard,
>> > >
>> > > Daniel Cho
>> > >
>> > >
>> > >
>> > > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=88=
12=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:45=E5=AF=AB=E9=81=93=EF=
=BC=9A
>> > >
>> > >
>> > >
>> > > > -----Original Message-----
>> > > > From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
>> > > > Sent: Wednesday, February 12, 2020 11:18 AM
>> > > > To: Dr. David Alan Gilbert <dgilbert@redhat.com>; Daniel Cho
>> > > > <danielcho@qnap.com>; Zhang, Chen <chen.zhang@intel.com>
>> > > > Cc: qemu-devel@nongnu.org
>> > > > Subject: RE: The issues about architecture of the COLO checkpoint
>> > > >
>> > > > Hi,
>> > > >
>> > > > Thank you Dave,
>> > > >
>> > > > I'll reply here directly.
>> > > >
>> > > > -----Original Message-----
>> > > > From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
>> > > > Sent: Wednesday, February 12, 2020 1:48 AM
>> > > > To: Daniel Cho <danielcho@qnap.com>; chen.zhang@intel.com;
>> > > > Zhanghailiang <zhang.zhanghailiang@huawei.com>
>> > > > Cc: qemu-devel@nongnu.org
>> > > > Subject: Re: The issues about architecture of the COLO checkpoint
>> > > >
>> > > >
>> > > > cc'ing in COLO people:
>> > > >
>> > > >
>> > > > * Daniel Cho (danielcho@qnap.com) wrote:
>> > > > > Hi everyone,
>> > > > >      We have some issues about setting COLO feature. Hope somebo=
dy
>> > > > > could give us some advice.
>> > > > >
>> > > > > Issue 1:
>> > > > >      We dynamic to set COLO feature for PVM(2 core, 16G memory),
>> but
>> > > > > the Primary VM will pause a long time(based on memory size) for
>> > > > > waiting SVM start. Does it have any idea to reduce the pause tim=
e?
>> > > > >
>> > > >
>> > > > Yes, we do have some ideas to optimize this downtime.
>> > > >
>> > > > The main problem for current version is, for each checkpoint, we
>> have to
>> > > > send the whole PVM's pages
>> > > > To SVM, and then copy the whole VM's state into SVM from ram cache=
,
>> in
>> > > > this process, we need both of them be paused.
>> > > > Just as you said, the downtime is based on memory size.
>> > > >
>> > > > So firstly, we need to reduce the sending data while do checkpoint=
,
>> > > actually,
>> > > > we can migrate parts of PVM's dirty pages in background
>> > > > While both of VMs are running. And then we load these pages into r=
am
>> > > > cache (backup memory) in SVM temporarily. While do checkpoint,
>> > > > We just send the last dirty pages of PVM to slave side and then
>> copy the
>> > > ram
>> > > > cache into SVM. Further on, we don't have
>> > > > To send the whole PVM's dirty pages, we can only send the pages th=
at
>> > > > dirtied by PVM or SVM during two checkpoints. (Because
>> > > > If one page is not dirtied by both PVM and SVM, the data of this
>> pages
>> > > will
>> > > > keep same in SVM, PVM, backup memory). This method can reduce
>> > > > the time that consumed in sending data.
>> > > >
>> > > > For the second problem, we can reduce the memory copy by two
>> methods,
>> > > > first one, we don't have to copy the whole pages in ram cache,
>> > > > We can only copy the pages that dirtied by PVM and SVM in last
>> > > checkpoint.
>> > > > Second, we can use userfault missing function to reduce the
>> > > > Time consumed in memory copy. (For the second time, in theory, we
>> can
>> > > > reduce time consumed in memory into ms level).
>> > > >
>> > > > You can find the first optimization in attachment, it is based on
>> an old
>> > > qemu
>> > > > version (qemu-2.6), it should not be difficult to rebase it
>> > > > Into master or your version. And please feel free to send the new
>> > > version if
>> > > > you want into community ;)
>> > > >
>> > > >
>> > >
>> > > Thanks Hailiang!
>> > > By the way, Do you have time to push the patches to upstream?
>> > > I think this is a better and faster option.
>> > >
>> > > Thanks
>> > > Zhang Chen
>> > >
>> > > > >
>> > > > > Issue 2:
>> > > > >      In
>> > > > > https://github.com/qemu/qemu/blob/master/migration/colo.c#L503,
>> > > > > could we move start_vm() before Line 488? Because at first
>> checkpoint
>> > > > > PVM will wait for SVM's reply, it cause PVM stop for a while.
>> > > > >
>> > > >
>> > > > No, that makes no sense, because if PVM runs firstly, it still nee=
d
>> to
>> > > wait for
>> > > > The network packets from SVM to compare before send it to client
>> side.
>> > > >
>> > > >
>> > > > Thanks,
>> > > > Hailiang
>> > > >
>> > > > >      We set the COLO feature on running VM, so we hope the
>> running VM
>> > > > > could continuous service for users.
>> > > > > Do you have any suggestions for those issues?
>> > > > >
>> > > > > Best regards,
>> > > > > Daniel Cho
>> > > > --
>> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>> > >
>> > >
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>>

--000000000000450161059ed6370d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Hailiang,=C2=A0<div>Thanks for your help. If we have an=
y problems we will contact you for your favor.</div><div><br></div><div><br=
></div><div>Hi Zhang,=C2=A0</div><div><br></div><div>&quot; If colo-compare=
 got a primary packet without related secondary packet in a certain time , =
it will automatically trigger checkpoint.=C2=A0 &quot;<br></div><div>As you=
 said, the colo-compare will trigger checkpoint, but does it need to limit =
checkpoint=C2=A0times?</div><div>There is a problem about doing many checkp=
oints while we use fio to random write files. Then it will cause low throug=
hput on PVM.</div><div>Is this situation is normal=C2=A0on=C2=A0COLO?</div>=
<div><br></div><div>Best regards,</div><div>Daniel Cho</div><div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Zhang, Che=
n &lt;<a href=3D"mailto:chen.zhang@intel.com" target=3D"_blank">chen.zhang@=
intel.com</a>&gt; =E6=96=BC 2020=E5=B9=B42=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=
=B8=80 =E4=B8=8B=E5=8D=881:36=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    <p><br>
    </p>
    <div>On 2/15/2020 11:35 AM, Daniel Cho
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>Hi Dave,=C2=A0</div>
        <div><br>
        </div>
        <div>Yes, I agree with you, it does need a timeout. <br>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Hi Daniel and Dave,</p>
    <p>Current colo-compare already have the timeout mechanism.</p>
    <p>Named packet_check_timer,=C2=A0 It will scan primary packet queue to
      make sure all the primary packet not stay too long time.</p>
    <p>If colo-compare got a primary packet without related secondary
      packet in a certain time , it will automatic trigger checkpoint.<br>
    </p>
    <p><a href=3D"https://github.com/qemu/qemu/blob/master/net/colo-compare=
.c#L847" target=3D"_blank">https://github.com/qemu/qemu/blob/master/net/col=
o-compare.c#L847</a></p>
    <p><br>
    </p>
    <p>Thanks</p>
    <p>Zhang Chen</p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        Hi Hailiang,=C2=A0
        <div><br>
        </div>
        <div>We base on qemu-4.1.0 for using COLO feature, in your
          patch, we found a lot of difference=C2=A0 between your version an=
d
          ours.</div>
        <div>Could you give us a latest release version which is close
          your developing code?</div>
        <div><br>
        </div>
        <div>Thanks.=C2=A0</div>
        <div><br>
        </div>
        <div>Regards</div>
        <div>Daniel Cho</div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">Dr. David Alan Gilbert &lt;<a=
 href=3D"mailto:dgilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com<=
/a>&gt;
          =E6=96=BC 2020=E5=B9=B42=E6=9C=8813=E6=97=A5 =E9=80=B1=E5=9B=9B =
=E4=B8=8B=E5=8D=886:38=E5=AF=AB=E9=81=93=EF=BC=9A<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">*
          Daniel Cho (<a href=3D"mailto:danielcho@qnap.com" target=3D"_blan=
k">danielcho@qnap.com</a>)
          wrote:<br>
          &gt; Hi Hailiang,<br>
          &gt; <br>
          &gt; 1.<br>
          &gt;=C2=A0 =C2=A0 =C2=A0OK, we will try the patch<br>
          &gt; =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=
=80=9D,<br>
          &gt; and thanks for your help.<br>
          &gt; <br>
          &gt; 2.<br>
          &gt;=C2=A0 =C2=A0 =C2=A0We understand the reason to compare PVM a=
nd SVM&#39;s
          packet. However, the<br>
          &gt; empty of SVM&#39;s packet queue might happened on setting
          COLO feature and SVM<br>
          &gt; broken.<br>
          &gt; <br>
          &gt; On situation 1 ( setting COLO feature ):<br>
          &gt;=C2=A0 =C2=A0 =C2=A0We could force do checkpoint after settin=
g COLO
          feature finish, then it<br>
          &gt; will protect the state of PVM and SVM . As the Zhang Chen
          said.<br>
          &gt; <br>
          &gt; On situation 2 ( SVM broken ):<br>
          &gt;=C2=A0 =C2=A0 =C2=A0COLO will do failover for PVM, so it migh=
t not cause
          any wrong on PVM.<br>
          &gt; <br>
          &gt; However, those situations are our views, so there might
          be a big difference<br>
          &gt; between reality and our views.<br>
          &gt; If we have any wrong views and opinions, please let us
          know, and correct<br>
          &gt; us.<br>
          <br>
          It does need a timeout; the SVM being broken or being in a
          state where<br>
          it never sends the corresponding packet (because of a state
          difference)<br>
          can happen and COLO needs to timeout when the packet hasn&#39;t
          arrived<br>
          after a while and trigger the checkpoint.<br>
          <br>
          Dave<br>
          <br>
          &gt; Thanks.<br>
          &gt; <br>
          &gt; Best regards,<br>
          &gt; Daniel Cho<br>
          &gt; <br>
          &gt; Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" targ=
et=3D"_blank">chen.zhang@intel.com</a>&gt;
          =E6=96=BC 2020=E5=B9=B42=E6=9C=8813=E6=97=A5 =E9=80=B1=E5=9B=9B =
=E4=B8=8A=E5=8D=8810:17=E5=AF=AB=E9=81=93=EF=BC=9A<br>
          &gt; <br>
          &gt; &gt; Add cc Jason Wang, he is a network expert.<br>
          &gt; &gt;<br>
          &gt; &gt; In case some network things goes wrong.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks<br>
          &gt; &gt;<br>
          &gt; &gt; Zhang Chen<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; *From:* Zhang, Chen<br>
          &gt; &gt; *Sent:* Thursday, February 13, 2020 10:10 AM<br>
          &gt; &gt; *To:* &#39;Zhanghailiang&#39; &lt;<a href=3D"mailto:zha=
ng.zhanghailiang@huawei.com" target=3D"_blank">zhang.zhanghailiang@huawei.c=
om</a>&gt;;
          Daniel Cho &lt;<br>
          &gt; &gt; <a href=3D"mailto:danielcho@qnap.com" target=3D"_blank"=
>danielcho@qnap.com</a>&gt;<br>
          &gt; &gt; *Cc:* Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgil=
bert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;; <a href=3D"=
mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a><b=
r>
          &gt; &gt; *Subject:* RE: The issues about architecture of the
          COLO checkpoint<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; For the issue 2:<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; COLO need use the network packets to confirm PVM and
          SVM in the same state,<br>
          &gt; &gt;<br>
          &gt; &gt; Generally speaking, we can=E2=80=99t send PVM packets
          without compared with SVM<br>
          &gt; &gt; packets.<br>
          &gt; &gt;<br>
          &gt; &gt; But to prevent jamming, I think COLO can do force
          checkpoint and send the<br>
          &gt; &gt; PVM packets in this case.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks<br>
          &gt; &gt;<br>
          &gt; &gt; Zhang Chen<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; *From:* Zhanghailiang &lt;<a href=3D"mailto:zhang.zhang=
hailiang@huawei.com" target=3D"_blank">zhang.zhanghailiang@huawei.com</a>&g=
t;<br>
          &gt; &gt; *Sent:* Thursday, February 13, 2020 9:45 AM<br>
          &gt; &gt; *To:* Daniel Cho &lt;<a href=3D"mailto:danielcho@qnap.c=
om" target=3D"_blank">danielcho@qnap.com</a>&gt;<br>
          &gt; &gt; *Cc:* Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgil=
bert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;; <a href=3D"=
mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a>;<=
br>
          &gt; &gt; Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com"=
 target=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
          &gt; &gt; *Subject:* RE: The issues about architecture of the
          COLO checkpoint<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Hi,<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; 1.=C2=A0 =C2=A0 =C2=A0 =C2=A0After re-walked through th=
e codes, yes, you
          are right, actually,<br>
          &gt; &gt; after the first migration, we will keep dirty log on
          in primary side,<br>
          &gt; &gt;<br>
          &gt; &gt; And only send the dirty pages in PVM to SVM. The ram
          cache in secondary<br>
          &gt; &gt; side is always a backup of PVM, so we don=E2=80=99t hav=
e to<br>
          &gt; &gt;<br>
          &gt; &gt; Re-send the none-dirtied pages.<br>
          &gt; &gt;<br>
          &gt; &gt; The reason why the first checkpoint takes longer
          time is we have to backup<br>
          &gt; &gt; the whole VM=E2=80=99s ram into ram cache, that is
          colo_init_ram_cache().<br>
          &gt; &gt;<br>
          &gt; &gt; It is time consuming, but I have optimized in the
          second patch<br>
          &gt; &gt; =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patc=
h=E2=80=9D
          which you can find in my<br>
          &gt; &gt; previous reply.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Besides, I found that, In my previous reply =E2=80=9CWe=
 can
          only copy the pages<br>
          &gt; &gt; that dirtied by PVM and SVM in last checkpoint.=E2=80=
=9D,<br>
          &gt; &gt;<br>
          &gt; &gt; We have done this optimization in current upstream
          codes.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; 2=EF=BC=8EI don=E2=80=99t quite understand this questio=
n. For COLO,
          we always need both<br>
          &gt; &gt; network packets of PVM=E2=80=99s and SVM=E2=80=99s to c=
ompare before
          send this packets to<br>
          &gt; &gt; client.<br>
          &gt; &gt;<br>
          &gt; &gt; It depends on this to decide whether or not PVM and
          SVM are in same state.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks,<br>
          &gt; &gt;<br>
          &gt; &gt; hailiang<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; *From:* Daniel Cho [mailto:<a href=3D"mailto:danielcho@=
qnap.com" target=3D"_blank">danielcho@qnap.com</a> &lt;<a href=3D"mailto:da=
nielcho@qnap.com" target=3D"_blank">danielcho@qnap.com</a>&gt;]<br>
          &gt; &gt; *Sent:* Wednesday, February 12, 2020 4:37 PM<br>
          &gt; &gt; *To:* Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@inte=
l.com" target=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
          &gt; &gt; *Cc:* Zhanghailiang &lt;<a href=3D"mailto:zhang.zhangha=
iliang@huawei.com" target=3D"_blank">zhang.zhanghailiang@huawei.com</a>&gt;=
;
          Dr. David Alan<br>
          &gt; &gt; Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.com" targ=
et=3D"_blank">dgilbert@redhat.com</a>&gt;;
          <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-d=
evel@nongnu.org</a><br>
          &gt; &gt; *Subject:* Re: The issues about architecture of the
          COLO checkpoint<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Hi Hailiang,<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks for your replaying and explain in detail.<br>
          &gt; &gt;<br>
          &gt; &gt; We will try to use the attachments to enhance memory
          copy.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; However, we have some questions for your replying.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; 1.=C2=A0 As you said, &quot;for each checkpoint, we hav=
e to
          send the whole PVM&#39;s<br>
          &gt; &gt; pages To SVM&quot;, why the only first checkpoint will
          takes more pause time?<br>
          &gt; &gt;<br>
          &gt; &gt; In our observing, the first checkpoint will take
          more time for pausing,<br>
          &gt; &gt; then other checkpoints will takes a few time for
          pausing. Does it means<br>
          &gt; &gt; only the first checkpoint will send the whole pages
          to SVM, and the other<br>
          &gt; &gt; checkpoints send the dirty pages to SVM for
          reloading?<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; 2. We notice the COLO-COMPARE component will stuck
          the packet until<br>
          &gt; &gt; receive packets from PVM and SVM, as this rule, when
          we add the<br>
          &gt; &gt; COLO-COMPARE to PVM, its network will stuck until
          SVM start. So it is an<br>
          &gt; &gt; other issue to make PVM stuck while setting COLO
          feature. With this issue,<br>
          &gt; &gt; could we let colo-compare to pass the PVM&#39;s packet
          when the SVM&#39;s packet<br>
          &gt; &gt; queue is empty? Then, the PVM&#39;s network won&#39;t s=
tock,
          and &quot;if PVM runs<br>
          &gt; &gt; firstly, it still need to wait for The network
          packets from SVM to<br>
          &gt; &gt; compare before send it to client side&quot; won&#39;t
          happened either.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Best regard,<br>
          &gt; &gt;<br>
          &gt; &gt; Daniel Cho<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com"=
 target=3D"_blank">chen.zhang@intel.com</a>&gt; =E6=96=BC
          2020=E5=B9=B42=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=
=E5=8D=881:45=E5=AF=AB=E9=81=93=EF=BC=9A<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; &gt; -----Original Message-----<br>
          &gt; &gt; &gt; From: Zhanghailiang &lt;<a href=3D"mailto:zhang.zh=
anghailiang@huawei.com" target=3D"_blank">zhang.zhanghailiang@huawei.com</a=
>&gt;<br>
          &gt; &gt; &gt; Sent: Wednesday, February 12, 2020 11:18 AM<br>
          &gt; &gt; &gt; To: Dr. David Alan Gilbert &lt;<a href=3D"mailto:d=
gilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>&gt;; Daniel
          Cho<br>
          &gt; &gt; &gt; &lt;<a href=3D"mailto:danielcho@qnap.com" target=
=3D"_blank">danielcho@qnap.com</a>&gt;;
          Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=3D=
"_blank">chen.zhang@intel.com</a>&gt;<br>
          &gt; &gt; &gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" targe=
t=3D"_blank">qemu-devel@nongnu.org</a><br>
          &gt; &gt; &gt; Subject: RE: The issues about architecture of
          the COLO checkpoint<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; Hi,<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; Thank you Dave,<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; I&#39;ll reply here directly.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; -----Original Message-----<br>
          &gt; &gt; &gt; From: Dr. David Alan Gilbert [mailto:<a href=3D"ma=
ilto:dgilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>]<br>
          &gt; &gt; &gt; Sent: Wednesday, February 12, 2020 1:48 AM<br>
          &gt; &gt; &gt; To: Daniel Cho &lt;<a href=3D"mailto:danielcho@qna=
p.com" target=3D"_blank">danielcho@qnap.com</a>&gt;; <a href=3D"mailto:chen=
.zhang@intel.com" target=3D"_blank">chen.zhang@intel.com</a>;<br>
          &gt; &gt; &gt; Zhanghailiang &lt;<a href=3D"mailto:zhang.zhanghai=
liang@huawei.com" target=3D"_blank">zhang.zhanghailiang@huawei.com</a>&gt;<=
br>
          &gt; &gt; &gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" targe=
t=3D"_blank">qemu-devel@nongnu.org</a><br>
          &gt; &gt; &gt; Subject: Re: The issues about architecture of
          the COLO checkpoint<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; cc&#39;ing in COLO people:<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; * Daniel Cho (<a href=3D"mailto:danielcho@qnap.com=
" target=3D"_blank">danielcho@qnap.com</a>) wrote:<br>
          &gt; &gt; &gt; &gt; Hi everyone,<br>
          &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 We have some issues about=
 setting
          COLO feature. Hope somebody<br>
          &gt; &gt; &gt; &gt; could give us some advice.<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt; &gt; Issue 1:<br>
          &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 We dynamic to set COLO fe=
ature for
          PVM(2 core, 16G memory),=C2=A0 but<br>
          &gt; &gt; &gt; &gt; the Primary VM will pause a long
          time(based on memory size) for<br>
          &gt; &gt; &gt; &gt; waiting SVM start. Does it have any idea
          to reduce the pause time?<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; Yes, we do have some ideas to optimize this
          downtime.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; The main problem for current version is, for
          each checkpoint, we have to<br>
          &gt; &gt; &gt; send the whole PVM&#39;s pages<br>
          &gt; &gt; &gt; To SVM, and then copy the whole VM&#39;s state int=
o
          SVM from ram cache, in<br>
          &gt; &gt; &gt; this process, we need both of them be paused.<br>
          &gt; &gt; &gt; Just as you said, the downtime is based on
          memory size.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; So firstly, we need to reduce the sending data
          while do checkpoint,<br>
          &gt; &gt; actually,<br>
          &gt; &gt; &gt; we can migrate parts of PVM&#39;s dirty pages in
          background<br>
          &gt; &gt; &gt; While both of VMs are running. And then we load
          these pages into ram<br>
          &gt; &gt; &gt; cache (backup memory) in SVM temporarily. While
          do checkpoint,<br>
          &gt; &gt; &gt; We just send the last dirty pages of PVM to
          slave side and then copy the<br>
          &gt; &gt; ram<br>
          &gt; &gt; &gt; cache into SVM. Further on, we don&#39;t have<br>
          &gt; &gt; &gt; To send the whole PVM&#39;s dirty pages, we can
          only send the pages that<br>
          &gt; &gt; &gt; dirtied by PVM or SVM during two checkpoints.
          (Because<br>
          &gt; &gt; &gt; If one page is not dirtied by both PVM and SVM,
          the data of this pages<br>
          &gt; &gt; will<br>
          &gt; &gt; &gt; keep same in SVM, PVM, backup memory). This
          method can reduce<br>
          &gt; &gt; &gt; the time that consumed in sending data.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; For the second problem, we can reduce the
          memory copy by two methods,<br>
          &gt; &gt; &gt; first one, we don&#39;t have to copy the whole
          pages in ram cache,<br>
          &gt; &gt; &gt; We can only copy the pages that dirtied by PVM
          and SVM in last<br>
          &gt; &gt; checkpoint.<br>
          &gt; &gt; &gt; Second, we can use userfault missing function
          to reduce the<br>
          &gt; &gt; &gt; Time consumed in memory copy. (For the second
          time, in theory, we can<br>
          &gt; &gt; &gt; reduce time consumed in memory into ms level).<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; You can find the first optimization in
          attachment, it is based on an old<br>
          &gt; &gt; qemu<br>
          &gt; &gt; &gt; version (qemu-2.6), it should not be difficult
          to rebase it<br>
          &gt; &gt; &gt; Into master or your version. And please feel
          free to send the new<br>
          &gt; &gt; version if<br>
          &gt; &gt; &gt; you want into community ;)<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks Hailiang!<br>
          &gt; &gt; By the way, Do you have time to push the patches to
          upstream?<br>
          &gt; &gt; I think this is a better and faster option.<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks<br>
          &gt; &gt; Zhang Chen<br>
          &gt; &gt;<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt; &gt; Issue 2:<br>
          &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 In<br>
          &gt; &gt; &gt; &gt; <a href=3D"https://github.com/qemu/qemu/blob/=
master/migration/colo.c#L503" rel=3D"noreferrer" target=3D"_blank">https://=
github.com/qemu/qemu/blob/master/migration/colo.c#L503</a>,<br>
          &gt; &gt; &gt; &gt; could we move start_vm() before Line 488?
          Because at first checkpoint<br>
          &gt; &gt; &gt; &gt; PVM will wait for SVM&#39;s reply, it cause
          PVM stop for a while.<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; No, that makes no sense, because if PVM runs
          firstly, it still need to<br>
          &gt; &gt; wait for<br>
          &gt; &gt; &gt; The network packets from SVM to compare before
          send it to client side.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; Thanks,<br>
          &gt; &gt; &gt; Hailiang<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 We set the COLO feature o=
n running
          VM, so we hope the running VM<br>
          &gt; &gt; &gt; &gt; could continuous service for users.<br>
          &gt; &gt; &gt; &gt; Do you have any suggestions for those
          issues?<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt; &gt; Best regards,<br>
          &gt; &gt; &gt; &gt; Daniel Cho<br>
          &gt; &gt; &gt; --<br>
          &gt; &gt; &gt; Dr. David Alan Gilbert / <a href=3D"mailto:dgilber=
t@redhat.com" target=3D"_blank">dgilbert@redhat.com</a> / Manchester,
          UK<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          --<br>
          Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" t=
arget=3D"_blank">dgilbert@redhat.com</a>
          / Manchester, UK<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
  </div>

</blockquote></div></div>

--000000000000450161059ed6370d--

