Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C89C35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 07:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2753F20714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 07:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="PeLPqiwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2753F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j67y2-0006lC-Ac
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 02:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1j67xC-0006G5-3F
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 02:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1j67x9-0001ao-P4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 02:14:57 -0500
Received: from mail-yw1-xc2c.google.com ([2607:f8b0:4864:20::c2c]:41494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1j67x9-0001aa-IJ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 02:14:55 -0500
Received: by mail-yw1-xc2c.google.com with SMTP id l22so4789470ywc.8
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 23:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SY2KCuTHZ2BVkejnTFnLy0QzJ9qP8e654o6nrkeiEMw=;
 b=PeLPqiwEnokU/FBxZDZDdzUr5JAeWblU5U+cJ/A4XHiwsa5RWCqYsMQCdpOiCArw7C
 E/0NRjQUZOn4t3DuvaIqON35WxQTf6itxmPaISRkVRpasMSHInGpeAsSa2xnzXgQZu1/
 wqZ8y+P8Ve3C81QiVEhmY9oCQJbbDNVHVWDB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SY2KCuTHZ2BVkejnTFnLy0QzJ9qP8e654o6nrkeiEMw=;
 b=aCB7wP88lehODNdmzws0hZT1OY+5sD+5hvDIF2nE7NRIC1eO3jLOivzjlLdp8qM3nK
 mDvt4WjWnHstGalM9ccn8fZZ7RqJ6LjZCAg0+GdW3PsRqgsRycTdeHlS0eo9YutcXLuG
 AJup+raGUQCXo/6zy8/SftsOGL6auR/j2jFlDOleGHI9QP5XSOhZUHEIk85b/X89fipo
 stEOc5smvFjornqJaksciLc16paEyBdFUGziAJCY4GzMAZkb/jG2xygOFSeFDaAj0QLg
 q8CnB9q44Y8c8FNem52OD4fjejhLlENjai/zvY314DAWFk0CJNqO3LYQjWaZ793Dim1e
 R7Tg==
X-Gm-Message-State: APjAAAV6VXlN3pvhmnPlJ8OccQ8fY0OSAIvkik+dJBbR88jfhzgjAQKd
 8hlg2jv3+Ebltg9dAw92NqVwb9L1F16wu6wxA1Z/EA==
X-Google-Smtp-Source: APXvYqzpjLSB/TlzgK/XRKBAGG8dZSc5oYY0VQZ/+17wNXihh3ulJ3j+a9NUzhKAZ5rnDK3kxOCaZCPB1VlMU39VSq8=
X-Received: by 2002:a81:25d8:: with SMTP id
 l207mr42792966ywl.391.1582528494466; 
 Sun, 23 Feb 2020 23:14:54 -0800 (PST)
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
 <CA+XQNE49wq2nRKJ0CA4uHDZ4OUEbFGPKBfAWB4+UwPYgiZkrCw@mail.gmail.com>
 <5d030380-76d6-67c6-39a1-82c197e320b4@intel.com>
 <CA+XQNE6riKARXtP9oZaQjK9Gqgfh-+Ae8qX+WsWhGfMB0hf8tg@mail.gmail.com>
 <0c69b913bf1047c4b7d5edac50f3988b@intel.com>
In-Reply-To: <0c69b913bf1047c4b7d5edac50f3988b@intel.com>
From: Daniel Cho <danielcho@qnap.com>
Date: Mon, 24 Feb 2020 15:14:41 +0800
Message-ID: <CA+XQNE6tZv0uhGoqqnS2ki=ZjP_YFaE53ZZntKPAbCxGnO1V8A@mail.gmail.com>
Subject: Re: The issues about architecture of the COLO checkpoint
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jason Wang <jasowang@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zhang,

Thanks for your help.
However, did you occur the error which the function qemu_hexdump in
colo-compare.c will crash the qemu process while doing operation with
network?

We are working on VM fault tolerance study and COLO function
evalutation first. Currently we did not have a confirmed plan on it.

Best regard,
Daniel Cho

Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=882:43=E5=AF=AB=E9=81=93=EF=BC=9A

>
>
>
>
>
> From: Daniel Cho <danielcho@qnap.com>
> Sent: Thursday, February 20, 2020 11:49 AM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>; Zhanghailiang <zhang.zh=
anghailiang@huawei.com>; qemu-devel@nongnu.org; Jason Wang <jasowang@redhat=
.com>
> Subject: Re: The issues about architecture of the COLO checkpoint
>
>
>
> Hi Zhang,
>
>
>
> Thanks, I will configure on code for testing first.
>
> However, if you have free time, could you please send the patch file to u=
s, Thanks.
>
>
>
> OK, I will send this patch recently.
>
> By the way, can you share QNAP=E2=80=99s plan and status for COLO?
>
>
>
> Best Regard,
>
> Daniel Cho
>
>
>
>
>
> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
>
>
> On 2/18/2020 5:22 PM, Daniel Cho wrote:
>
> Hi Hailiang,
>
> Thanks for your help. If we have any problems we will contact you for you=
r favor.
>
>
>
>
>
> Hi Zhang,
>
>
>
> " If colo-compare got a primary packet without related secondary packet i=
n a certain time , it will automatically trigger checkpoint.  "
>
> As you said, the colo-compare will trigger checkpoint, but does it need t=
o limit checkpoint times?
>
> There is a problem about doing many checkpoints while we use fio to rando=
m write files. Then it will cause low throughput on PVM.
>
> Is this situation is normal on COLO?
>
>
>
> Hi Daniel,
>
> The checkpoint time is designed to be user adjustable based on user envir=
onment(workload/network status/business conditions...).
>
> In net/colo-compare.c
>
> /* TODO: Should be configurable */
> #define REGULAR_PACKET_CHECK_MS 3000
>
> If you need, I can send a patch for this issue. Make users can change the=
 value by QMP and qemu monitor commands.
>
> Thanks
>
> Zhang Chen
>
>
>
>
>
> Best regards,
>
> Daniel Cho
>
>
>
> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 2/15/2020 11:35 AM, Daniel Cho wrote:
>
> Hi Dave,
>
>
>
> Yes, I agree with you, it does need a timeout.
>
>
>
> Hi Daniel and Dave,
>
> Current colo-compare already have the timeout mechanism.
>
> Named packet_check_timer,  It will scan primary packet queue to make sure=
 all the primary packet not stay too long time.
>
> If colo-compare got a primary packet without related secondary packet in =
a certain time , it will automatic trigger checkpoint.
>
> https://github.com/qemu/qemu/blob/master/net/colo-compare.c#L847
>
>
>
> Thanks
>
> Zhang Chen
>
>
>
>
>
> Hi Hailiang,
>
>
>
> We base on qemu-4.1.0 for using COLO feature, in your patch, we found a l=
ot of difference  between your version and ours.
>
> Could you give us a latest release version which is close your developing=
 code?
>
>
>
> Thanks.
>
>
>
> Regards
>
> Daniel Cho
>
>
>
> Dr. David Alan Gilbert <dgilbert@redhat.com> =E6=96=BC 2020=E5=B9=B42=E6=
=9C=8813=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:38=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> * Daniel Cho (danielcho@qnap.com) wrote:
> > Hi Hailiang,
> >
> > 1.
> >     OK, we will try the patch
> > =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=80=9D,
> > and thanks for your help.
> >
> > 2.
> >     We understand the reason to compare PVM and SVM's packet. However, =
the
> > empty of SVM's packet queue might happened on setting COLO feature and =
SVM
> > broken.
> >
> > On situation 1 ( setting COLO feature ):
> >     We could force do checkpoint after setting COLO feature finish, the=
n it
> > will protect the state of PVM and SVM . As the Zhang Chen said.
> >
> > On situation 2 ( SVM broken ):
> >     COLO will do failover for PVM, so it might not cause any wrong on P=
VM.
> >
> > However, those situations are our views, so there might be a big differ=
ence
> > between reality and our views.
> > If we have any wrong views and opinions, please let us know, and correc=
t
> > us.
>
> It does need a timeout; the SVM being broken or being in a state where
> it never sends the corresponding packet (because of a state difference)
> can happen and COLO needs to timeout when the packet hasn't arrived
> after a while and trigger the checkpoint.
>
> Dave
>
> > Thanks.
> >
> > Best regards,
> > Daniel Cho
> >
> > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8813=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:17=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > > Add cc Jason Wang, he is a network expert.
> > >
> > > In case some network things goes wrong.
> > >
> > >
> > >
> > > Thanks
> > >
> > > Zhang Chen
> > >
> > >
> > >
> > > *From:* Zhang, Chen
> > > *Sent:* Thursday, February 13, 2020 10:10 AM
> > > *To:* 'Zhanghailiang' <zhang.zhanghailiang@huawei.com>; Daniel Cho <
> > > danielcho@qnap.com>
> > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>; qemu-devel@nongnu=
.org
> > > *Subject:* RE: The issues about architecture of the COLO checkpoint
> > >
> > >
> > >
> > > For the issue 2:
> > >
> > >
> > >
> > > COLO need use the network packets to confirm PVM and SVM in the same =
state,
> > >
> > > Generally speaking, we can=E2=80=99t send PVM packets without compare=
d with SVM
> > > packets.
> > >
> > > But to prevent jamming, I think COLO can do force checkpoint and send=
 the
> > > PVM packets in this case.
> > >
> > >
> > >
> > > Thanks
> > >
> > > Zhang Chen
> > >
> > >
> > >
> > > *From:* Zhanghailiang <zhang.zhanghailiang@huawei.com>
> > > *Sent:* Thursday, February 13, 2020 9:45 AM
> > > *To:* Daniel Cho <danielcho@qnap.com>
> > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com>; qemu-devel@nongnu=
.org;
> > > Zhang, Chen <chen.zhang@intel.com>
> > > *Subject:* RE: The issues about architecture of the COLO checkpoint
> > >
> > >
> > >
> > > Hi,
> > >
> > >
> > >
> > > 1.       After re-walked through the codes, yes, you are right, actua=
lly,
> > > after the first migration, we will keep dirty log on in primary side,
> > >
> > > And only send the dirty pages in PVM to SVM. The ram cache in seconda=
ry
> > > side is always a backup of PVM, so we don=E2=80=99t have to
> > >
> > > Re-send the none-dirtied pages.
> > >
> > > The reason why the first checkpoint takes longer time is we have to b=
ackup
> > > the whole VM=E2=80=99s ram into ram cache, that is colo_init_ram_cach=
e().
> > >
> > > It is time consuming, but I have optimized in the second patch
> > > =E2=80=9C0001-COLO-Optimize-memory-back-up-process.patch=E2=80=9D whi=
ch you can find in my
> > > previous reply.
> > >
> > >
> > >
> > > Besides, I found that, In my previous reply =E2=80=9CWe can only copy=
 the pages
> > > that dirtied by PVM and SVM in last checkpoint.=E2=80=9D,
> > >
> > > We have done this optimization in current upstream codes.
> > >
> > >
> > >
> > > 2=EF=BC=8EI don=E2=80=99t quite understand this question. For COLO, w=
e always need both
> > > network packets of PVM=E2=80=99s and SVM=E2=80=99s to compare before =
send this packets to
> > > client.
> > >
> > > It depends on this to decide whether or not PVM and SVM are in same s=
tate.
> > >
> > >
> > >
> > > Thanks,
> > >
> > > hailiang
> > >
> > >
> > >
> > > *From:* Daniel Cho [mailto:danielcho@qnap.com <danielcho@qnap.com>]
> > > *Sent:* Wednesday, February 12, 2020 4:37 PM
> > > *To:* Zhang, Chen <chen.zhang@intel.com>
> > > *Cc:* Zhanghailiang <zhang.zhanghailiang@huawei.com>; Dr. David Alan
> > > Gilbert <dgilbert@redhat.com>; qemu-devel@nongnu.org
> > > *Subject:* Re: The issues about architecture of the COLO checkpoint
> > >
> > >
> > >
> > > Hi Hailiang,
> > >
> > >
> > >
> > > Thanks for your replaying and explain in detail.
> > >
> > > We will try to use the attachments to enhance memory copy.
> > >
> > >
> > >
> > > However, we have some questions for your replying.
> > >
> > >
> > >
> > > 1.  As you said, "for each checkpoint, we have to send the whole PVM'=
s
> > > pages To SVM", why the only first checkpoint will takes more pause ti=
me?
> > >
> > > In our observing, the first checkpoint will take more time for pausin=
g,
> > > then other checkpoints will takes a few time for pausing. Does it mea=
ns
> > > only the first checkpoint will send the whole pages to SVM, and the o=
ther
> > > checkpoints send the dirty pages to SVM for reloading?
> > >
> > >
> > >
> > > 2. We notice the COLO-COMPARE component will stuck the packet until
> > > receive packets from PVM and SVM, as this rule, when we add the
> > > COLO-COMPARE to PVM, its network will stuck until SVM start. So it is=
 an
> > > other issue to make PVM stuck while setting COLO feature. With this i=
ssue,
> > > could we let colo-compare to pass the PVM's packet when the SVM's pac=
ket
> > > queue is empty? Then, the PVM's network won't stock, and "if PVM runs
> > > firstly, it still need to wait for The network packets from SVM to
> > > compare before send it to client side" won't happened either.
> > >
> > >
> > >
> > > Best regard,
> > >
> > > Daniel Cho
> > >
> > >
> > >
> > > Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=881=
2=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:45=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> > > > Sent: Wednesday, February 12, 2020 11:18 AM
> > > > To: Dr. David Alan Gilbert <dgilbert@redhat.com>; Daniel Cho
> > > > <danielcho@qnap.com>; Zhang, Chen <chen.zhang@intel.com>
> > > > Cc: qemu-devel@nongnu.org
> > > > Subject: RE: The issues about architecture of the COLO checkpoint
> > > >
> > > > Hi,
> > > >
> > > > Thank you Dave,
> > > >
> > > > I'll reply here directly.
> > > >
> > > > -----Original Message-----
> > > > From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> > > > Sent: Wednesday, February 12, 2020 1:48 AM
> > > > To: Daniel Cho <danielcho@qnap.com>; chen.zhang@intel.com;
> > > > Zhanghailiang <zhang.zhanghailiang@huawei.com>
> > > > Cc: qemu-devel@nongnu.org
> > > > Subject: Re: The issues about architecture of the COLO checkpoint
> > > >
> > > >
> > > > cc'ing in COLO people:
> > > >
> > > >
> > > > * Daniel Cho (danielcho@qnap.com) wrote:
> > > > > Hi everyone,
> > > > >      We have some issues about setting COLO feature. Hope somebod=
y
> > > > > could give us some advice.
> > > > >
> > > > > Issue 1:
> > > > >      We dynamic to set COLO feature for PVM(2 core, 16G memory), =
 but
> > > > > the Primary VM will pause a long time(based on memory size) for
> > > > > waiting SVM start. Does it have any idea to reduce the pause time=
?
> > > > >
> > > >
> > > > Yes, we do have some ideas to optimize this downtime.
> > > >
> > > > The main problem for current version is, for each checkpoint, we ha=
ve to
> > > > send the whole PVM's pages
> > > > To SVM, and then copy the whole VM's state into SVM from ram cache,=
 in
> > > > this process, we need both of them be paused.
> > > > Just as you said, the downtime is based on memory size.
> > > >
> > > > So firstly, we need to reduce the sending data while do checkpoint,
> > > actually,
> > > > we can migrate parts of PVM's dirty pages in background
> > > > While both of VMs are running. And then we load these pages into ra=
m
> > > > cache (backup memory) in SVM temporarily. While do checkpoint,
> > > > We just send the last dirty pages of PVM to slave side and then cop=
y the
> > > ram
> > > > cache into SVM. Further on, we don't have
> > > > To send the whole PVM's dirty pages, we can only send the pages tha=
t
> > > > dirtied by PVM or SVM during two checkpoints. (Because
> > > > If one page is not dirtied by both PVM and SVM, the data of this pa=
ges
> > > will
> > > > keep same in SVM, PVM, backup memory). This method can reduce
> > > > the time that consumed in sending data.
> > > >
> > > > For the second problem, we can reduce the memory copy by two method=
s,
> > > > first one, we don't have to copy the whole pages in ram cache,
> > > > We can only copy the pages that dirtied by PVM and SVM in last
> > > checkpoint.
> > > > Second, we can use userfault missing function to reduce the
> > > > Time consumed in memory copy. (For the second time, in theory, we c=
an
> > > > reduce time consumed in memory into ms level).
> > > >
> > > > You can find the first optimization in attachment, it is based on a=
n old
> > > qemu
> > > > version (qemu-2.6), it should not be difficult to rebase it
> > > > Into master or your version. And please feel free to send the new
> > > version if
> > > > you want into community ;)
> > > >
> > > >
> > >
> > > Thanks Hailiang!
> > > By the way, Do you have time to push the patches to upstream?
> > > I think this is a better and faster option.
> > >
> > > Thanks
> > > Zhang Chen
> > >
> > > > >
> > > > > Issue 2:
> > > > >      In
> > > > > https://github.com/qemu/qemu/blob/master/migration/colo.c#L503,
> > > > > could we move start_vm() before Line 488? Because at first checkp=
oint
> > > > > PVM will wait for SVM's reply, it cause PVM stop for a while.
> > > > >
> > > >
> > > > No, that makes no sense, because if PVM runs firstly, it still need=
 to
> > > wait for
> > > > The network packets from SVM to compare before send it to client si=
de.
> > > >
> > > >
> > > > Thanks,
> > > > Hailiang
> > > >
> > > > >      We set the COLO feature on running VM, so we hope the runnin=
g VM
> > > > > could continuous service for users.
> > > > > Do you have any suggestions for those issues?
> > > > >
> > > > > Best regards,
> > > > > Daniel Cho
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

