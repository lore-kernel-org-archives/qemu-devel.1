Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1540C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1A820756
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="lWJiO/GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1A820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI084-0002Ql-47
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 21:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kI078-0001mU-QB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:50:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kI076-0000LX-9r
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:50:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id o5so1475062wrn.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 18:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E/CDQCgm4HVBMrHcmRFd1ROVOufveO8X9rBEXUcFflA=;
 b=lWJiO/GCylQ1ARtec9prX3XB4iTpKVaEMBltGeg9TVeHnDbcLobw3AHr2ViSuiznlC
 /VR6u4lvD5+dU+1TLmoFeTuUgIcgny/qg7aRkhSTI6syEbVF3oxHJwBtXpMXqOUeNo3B
 wa/rrzy/YxPxrhOFDs3IFeQKnxjCfYUR8SKTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E/CDQCgm4HVBMrHcmRFd1ROVOufveO8X9rBEXUcFflA=;
 b=TCvMNRcPRxndQA6wSSwp0t9MnhaxtFd6yEK4bmMWclo55G+kCeW1Y8As5ISa7CLWG4
 P37aE28jyIIcnig2ai9z2y5+R+1RW7b2TsM5TRbr8MjmE0gJHSylJBLMbW0DuYJ3R3f9
 7ggDyZOSlvMogzWjNSVxUGO4m9KLvZbWwPjkPJpITwXj/paFptoZ5dscVOiGSJbn9dsy
 Ud/sYuZX2hlCjg3Go6j4LNNRJf57qW95xtDIIhuWg4zT1KGTEGrrP30T0s8ztPZ+vHkX
 Z5bw9alTM2DdimFuTzpJmppidio18E4qiuuFptL9HkzwM7x0Ttr91/X+bXTvSnUeqd4d
 LmKg==
X-Gm-Message-State: AOAM533tGBIcPxh378Gtk0ySUiU/8xgEfUHACIZXjUV17pxZfo2xx5Rx
 8xfl/YB4bY4eh8k8DqZVAAqWkK8unGc0XIujhz4ZkA==
X-Google-Smtp-Source: ABdhPJx/OE80DO0rTJ7q/gvTjt1QXYT8ISPEueF/E0kMgXbZ0wT/HKmLe4zIf7u7oaEtADwfGHVAyhWD8JHdfgSDy/E=
X-Received: by 2002:adf:ef48:: with SMTP id c8mr19002197wrp.370.1600134629240; 
 Mon, 14 Sep 2020 18:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200911190508.1316487-1-dereksu@qnap.com>
 <20200911190508.1316487-3-dereksu@qnap.com>
 <817fd011098a4fc6a6790c17414a71a8@intel.com>
 <0bf192578764481e8757c6595094eb28@intel.com>
 <CAKEOLWUVzX4nudNBKJhqYqAxJFRq4BXPDiDynAEd_K-h5DDTpA@mail.gmail.com>
 <60290833ad3243a48fd558ccc86c3640@intel.com>
 <CAKEOLWWh7oLWTTK-nV63dG9KA1wZfYGaSU2uJR7mxSm9nnHjfQ@mail.gmail.com>
 <1a2b098b271048568257ca416c106965@intel.com>
In-Reply-To: <1a2b098b271048568257ca416c106965@intel.com>
From: Derek Su <dereksu@qnap.com>
Date: Tue, 15 Sep 2020 09:50:17 +0800
Message-ID: <CAKEOLWXJm6gyz5X_BkrXWhM=rKA0FfLb9ZyJVowyGRE655vCbg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] colo-compare: Record packet creation time by
 QEMU_CLOCK_REALTIME
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="0000000000002b60db05af50608b"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=dereksu@qnap.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "C.H. Yang" <chyang@qnap.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>,
 CT Cheng <ctcheng@qnap.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002b60db05af50608b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Chen

Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=888:09=E5=AF=AB=E9=81=93=EF=BC=9A

> Hi Derek,
>
>
>
> Looks qemu vl.c, migration/migration.c=E2=80=A6etc use the =E2=80=9CQEMU_=
CLOCK_HOST=E2=80=9D too.
>
It will also affected by host NTP. Do you means we should change all the
> QEMU_CLOCK_HOST to QEMU_CLOCK_REALTIME?
>

No, I think it depends on the purpose. For example, the setup_time/end_time
in migration/migraion.c are for statistical information.

There is maybe a low probability of the issue I mentioned. It would be
classified as a known issue in practical applications.
QEMU_CLOCK_HOST seems enough as you said.


> And use the QEMU_CLOCK_VIRTUAL is not correct, because we need to know
> time changes during VM stop.
>

Thanks.

Regards,
Derek



> Thanks
>
> Zhang Chen
>
>
>
> *From:* Derek Su <dereksu@qnap.com>
> *Sent:* Tuesday, September 15, 2020 12:24 AM
> *To:* Zhang, Chen <chen.zhang@intel.com>
> *Cc:* jasowang@redhat.com; lizhijian@cn.fujitsu.com; qemu-devel@nongnu.or=
g;
> C.H. Yang <chyang@qnap.com>; CT Cheng <ctcheng@qnap.com>
> *Subject:* Re: [PATCH v1 2/2] colo-compare: Record packet creation time
> by QEMU_CLOCK_REALTIME
>
>
>
>
> Hello, Chen
>
>
>
> My humble opinion is that the `creation_ms` and `now` fixed in my patch
> should be OK in colo-compare and performs well in my test if used
> QEMU_CLOCK_REALTIME. Though the vm state is changed in COLO scenario, the
> record and comparison of `creation_ms` and `now` are not affected by thes=
e
> vm changes.
>
>
>
> In net/colo.c and net/colo-compare.c functions using timer_mod(),
> using QEMU_CLOCK_HOST is dangerous if users change the host clock. The
> timer might not be fired on time as expected. The original time_mod using
> QEMU_CLOCK_VIRTUAL seems OK currently.
>
> Thanks.
>
>
>
> Regards,
>
> Derek
>
>
>
>
>
> Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
>
>
> *From:* Derek Su <dereksu@qnap.com>
> *Sent:* Monday, September 14, 2020 9:00 AM
> *To:* Zhang, Chen <chen.zhang@intel.com>
> *Cc:* jasowang@redhat.com; lizhijian@cn.fujitsu.com; qemu-devel@nongnu.or=
g
> *Subject:* Re: [PATCH v1 2/2] colo-compare: Record packet creation time
> by QEMU_CLOCK_REALTIME
>
>
>
>
>
>
>
> Zhang, Chen <chen.zhang@intel.com>=E6=96=BC 2020=E5=B9=B49=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=B8=80=EF=BC=8C=E4=B8=8A=E5=8D=884:06=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
>
>
>
>
> > -----Original Message-----
>
> > From: Zhang, Chen
>
> > Sent: Monday, September 14, 2020 4:02 AM
>
> > To: 'Derek Su' <dereksu@qnap.com>; qemu-devel@nongnu.org
>
> > Cc: lizhijian@cn.fujitsu.com; jasowang@redhat.com
>
> > Subject: RE: [PATCH v1 2/2] colo-compare: Record packet creation time b=
y
>
> > QEMU_CLOCK_REALTIME
>
> >
>
> >
>
> >
>
> > > -----Original Message-----
>
> > > From: Derek Su <dereksu@qnap.com>
>
> > > Sent: Saturday, September 12, 2020 3:05 AM
>
> > > To: qemu-devel@nongnu.org
>
> > > Cc: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
>
> > > jasowang@redhat.com; Derek Su <dereksu@qnap.com>
>
> > > Subject: [PATCH v1 2/2] colo-compare: Record packet creation time by
>
> > > QEMU_CLOCK_REALTIME
>
> > >
>
> > > Record packet creation time by QEMU_CLOCK_REALTIME instead of
>
> > > QEMU_CLOCK_HOST. The time difference between `now` and packet
>
> > > `creation_ms` has the possibility of an unexpected negative value and
>
> > > results in wrong comparison after changing the host clock.
>
> > >
>
> >
>
> > Hi Derek,
>
> >
>
> > I think this issue caused by other code in this file use the
>
> > qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>
> > I will change all code to QEMU_CLOCK_HOST to fix it with the patch 1/2.
>
>
>
> If you feel OK, or you can send the new version.  :-)
>
>
>
> Hello, Chen
>
>
>
> Is the monotonically increasing clock better than host clock in the COLO
> compare framework?
>
> The host clock is sometimes changed by the users manually or NTP
> synchronization automatically, and the cases may lead to the relative tim=
e
> be disordered.
>
> For example, the `creation_time` of one packet is advanced to the `now` i=
n
> our tests.
>
>
>
> I incline to replace QEMU_CLOCK_REALTIME and QEMU_CLOCK_VIRTUAL with
> the monotonically increasing clock QEMU_CLOCK_REALTIME in COLO compare
> framework.
>
> How about your thoughts?
>
>
>
> Hi Derek,
>
>
>
> /**
>
> * QEMUClockType:
>
> *
>
> * The following clock types are available:
>
> *
>
> * @QEMU_CLOCK_REALTIME: Real time clock
>
> *
>
> * The real time clock should be used only for stuff which does not
>
> * change the virtual machine state, as it runs even if the virtual
>
> * machine is stopped.
>
> *
>
> * @QEMU_CLOCK_VIRTUAL: virtual clock
>
> *
>
> * The virtual clock only runs during the emulation. It stops
>
> * when the virtual machine is stopped.
>
> *
>
> * @QEMU_CLOCK_HOST: host clock
>
> *
>
> * The host clock should be used for device models that emulate accurate
>
> * real time sources. It will continue to run when the virtual machine
>
> * is suspended, and it will reflect system time changes the host may
>
> * undergo (e.g. due to NTP).
>
>
>
>
>
> When COLO running, it will change the virtual machine state.
>
> So I think use the QEMU_CLOCK_HOST is better.
>
>
>
> Thanks
>
> Zhang Chen
>
>
>
> If OK, I will send the new version again, thanks. :)
>
> Thank you.
>
>
>
> Regards,
>
> Derek
>
>
>
>
>
>
> >
>
> > Thanks
>
> > Zhang Chen
>
> >
>
> > > Signed-off-by: Derek Su <dereksu@qnap.com>
>
> > > ---
>
> > >  net/colo-compare.c | 2 +-
>
> > >  net/colo.c         | 2 +-
>
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
>
> > >
>
> > > diff --git a/net/colo-compare.c b/net/colo-compare.c index
>
> > > c4de86ef34..29d7f986e3 100644
>
> > > --- a/net/colo-compare.c
>
> > > +++ b/net/colo-compare.c
>
> > > @@ -621,7 +621,7 @@ static int colo_packet_compare_other(Packet *spkt=
,
>
> > > Packet *ppkt)
>
> > >
>
> > >  static int colo_old_packet_check_one(Packet *pkt, void *user_data)  =
{
>
> > > -    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>
> > > +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>
> > >      uint32_t check_time =3D *(uint32_t *)user_data;
>
> > >
>
> > >      if ((now - pkt->creation_ms) > check_time) { diff --git
>
> > > a/net/colo.c b/net/colo.c index a6c66d829a..0441910169 100644
>
> > > --- a/net/colo.c
>
> > > +++ b/net/colo.c
>
> > > @@ -164,7 +164,7 @@ Packet *packet_new(const void *data, int size, in=
t
>
> > > vnet_hdr_len)
>
> > >
>
> > >      pkt->data =3D g_memdup(data, size);
>
> > >      pkt->size =3D size;
>
> > > -    pkt->creation_ms =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>
> > > +    pkt->creation_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>
> > >      pkt->vnet_hdr_len =3D vnet_hdr_len;
>
> > >      pkt->tcp_seq =3D 0;
>
> > >      pkt->tcp_ack =3D 0;
>
> > > --
>
> > > 2.25.1
>
>

--0000000000002b60db05af50608b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"=
><div dir=3D"ltr"><div><br></div></div></div></div></div></div><div>Hello, =
Chen<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com">che=
n.zhang@intel.com</a>&gt; =E6=96=BC 2020=E5=B9=B49=E6=9C=8815=E6=97=A5 =E9=
=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=888:09=E5=AF=AB=E9=81=93=EF=BC=9A<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div class=3D"gmail-m_7698823301063423738WordSection1">
<p class=3D"MsoNormal">Hi Derek,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Looks qemu vl.c, migration/migration.c=E2=80=A6etc u=
se the =E2=80=9CQEMU_CLOCK_HOST=E2=80=9D too.</p></div></div></blockquote><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div lang=3D"EN-US"><div c=
lass=3D"gmail-m_7698823301063423738WordSection1"><p class=3D"MsoNormal"><u>=
</u><u></u></p>
<p class=3D"MsoNormal">It will also affected by host NTP. Do you means we s=
hould change all the QEMU_CLOCK_HOST to QEMU_CLOCK_REALTIME?</p></div></div=
></blockquote><div><div><br></div><div>No, I think it depends on the purpos=
e. For example, the=C2=A0setup_time/end_time in migration/migraion.c are fo=
r statistical information.</div><div><br></div><div>There is maybe a low pr=
obability of the issue I mentioned. It would be classified as a known issue=
 in practical applications.</div><div>QEMU_CLOCK_HOST seems enough as you s=
aid.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div lang=3D"EN-US"><div class=3D"gmail-m_7698823301063423738WordSe=
ction1"><p class=3D"MsoNormal"><u></u><u></u></p>
<p class=3D"MsoNormal">And use the QEMU_CLOCK_VIRTUAL is not correct, becau=
se we need to know time changes during VM stop.</p></div></div></blockquote=
><div><div><div><br></div><div>Thanks.<br></div><div><br></div><div>Regards=
,</div><div>Derek=C2=A0</div></div><div><br></div></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div lang=3D"EN-US"><div cl=
ass=3D"gmail-m_7698823301063423738WordSection1"><p class=3D"MsoNormal"><u><=
/u></p>
<p class=3D"MsoNormal">Thanks<u></u><u></u></p>
<p class=3D"MsoNormal">Zhang Chen<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Derek Su &lt;<a href=3D"mailto:dereksu@=
qnap.com" target=3D"_blank">dereksu@qnap.com</a>&gt; <br>
<b>Sent:</b> Tuesday, September 15, 2020 12:24 AM<br>
<b>To:</b> Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=
=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowan=
g@redhat.com</a>; <a href=3D"mailto:lizhijian@cn.fujitsu.com" target=3D"_bl=
ank">lizhijian@cn.fujitsu.com</a>; <a href=3D"mailto:qemu-devel@nongnu.org"=
 target=3D"_blank">qemu-devel@nongnu.org</a>; C.H. Yang &lt;<a href=3D"mail=
to:chyang@qnap.com" target=3D"_blank">chyang@qnap.com</a>&gt;; CT Cheng &lt=
;<a href=3D"mailto:ctcheng@qnap.com" target=3D"_blank">ctcheng@qnap.com</a>=
&gt;<br>
<b>Subject:</b> Re: [PATCH v1 2/2] colo-compare: Record packet creation tim=
e by QEMU_CLOCK_REALTIME<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal"><br clear=3D"all">
<u></u><u></u></p>
<div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif;color:black">Hello, Chen</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">My humble opinion is that the `creation_ms` and `now=
` fixed in my patch should be OK in colo-compare and performs well in my te=
st if used QEMU_CLOCK_REALTIME. Though the vm state is changed in COLO scen=
ario, the record and comparison of
 `creation_ms` and `now` are not affected by these vm changes.<u></u><u></u=
></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">In net/colo.c and net/colo-compare.c functions using=
=C2=A0timer_mod(), using=C2=A0QEMU_CLOCK_HOST is dangerous if users change =
the host clock. The timer might not be fired on time as expected. The origi=
nal time_mod using QEMU_CLOCK_VIRTUAL seems
 OK currently.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Derek<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.c=
om" target=3D"_blank">chen.zhang@intel.com</a>&gt;
<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E6=96=BC</span> 2020<s=
pan lang=3D"ZH-CN" style=3D"font-family:DengXian">=E5=B9=B4</span>9<span la=
ng=3D"ZH-CN" style=3D"font-family:DengXian">=E6=9C=88</span>14<span lang=3D=
"ZH-CN" style=3D"font-family:DengXian">=E6=97=A5</span><span lang=3D"ZH-CN"=
>
</span><span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E9=80=B1=E4=B8=
=80</span><span lang=3D"ZH-CN">
</span><span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E4=B8=8B=E5=8D=
=88</span>3:42<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E5=AF=AB=
=E9=81=93=EF=BC=9A</span><u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin-left:4=
.8pt;margin-right:0in">
<div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Derek Su &lt;<a href=3D"mailto:dereksu@=
qnap.com" target=3D"_blank">dereksu@qnap.com</a>&gt;
<br>
<b>Sent:</b> Monday, September 14, 2020 9:00 AM<br>
<b>To:</b> Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=
=3D"_blank">chen.zhang@intel.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowan=
g@redhat.com</a>;
<a href=3D"mailto:lizhijian@cn.fujitsu.com" target=3D"_blank">lizhijian@cn.=
fujitsu.com</a>;
<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongn=
u.org</a><br>
<b>Subject:</b> Re: [PATCH v1 2/2] colo-compare: Record packet creation tim=
e by QEMU_CLOCK_REALTIME<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.c=
om" target=3D"_blank">chen.zhang@intel.com</a>&gt;<span lang=3D"ZH-CN" styl=
e=3D"font-family:DengXian">=E6=96=BC</span> 2020<span lang=3D"ZH-CN" style=
=3D"font-family:DengXian">=E5=B9=B4</span>9<span lang=3D"ZH-CN" style=3D"fo=
nt-family:DengXian">=E6=9C=88</span>14<span lang=3D"ZH-CN" style=3D"font-fa=
mily:DengXian">=E6=97=A5</span><span lang=3D"ZH-CN">
</span><span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E9=80=B1=E4=B8=
=80=EF=BC=8C=E4=B8=8A=E5=8D=88</span>4:06<span lang=3D"ZH-CN" style=3D"font=
-family:DengXian">=E5=AF=AB=E9=81=93=EF=BC=9A</span><u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin:5pt 0i=
n 5pt 4.8pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><br>
<br>
<br>
<br>
&gt; -----Original Message-----<br>
<br>
&gt; From: Zhang, Chen<br>
<br>
&gt; Sent: Monday, September 14, 2020 4:02 AM<br>
<br>
&gt; To: &#39;Derek Su&#39; &lt;<a href=3D"mailto:dereksu@qnap.com" target=
=3D"_blank">dereksu@qnap.com</a>&gt;;
<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongn=
u.org</a><br>
<br>
&gt; Cc: <a href=3D"mailto:lizhijian@cn.fujitsu.com" target=3D"_blank">lizh=
ijian@cn.fujitsu.com</a>;
<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.co=
m</a><br>
<br>
&gt; Subject: RE: [PATCH v1 2/2] colo-compare: Record packet creation time =
by<br>
<br>
&gt; QEMU_CLOCK_REALTIME<br>
<br>
&gt; <br>
<br>
&gt; <br>
<br>
&gt; <br>
<br>
&gt; &gt; -----Original Message-----<br>
<br>
&gt; &gt; From: Derek Su &lt;<a href=3D"mailto:dereksu@qnap.com" target=3D"=
_blank">dereksu@qnap.com</a>&gt;<br>
<br>
&gt; &gt; Sent: Saturday, September 12, 2020 3:05 AM<br>
<br>
&gt; &gt; To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qe=
mu-devel@nongnu.org</a><br>
<br>
&gt; &gt; Cc: Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" targe=
t=3D"_blank">chen.zhang@intel.com</a>&gt;;
<a href=3D"mailto:lizhijian@cn.fujitsu.com" target=3D"_blank">lizhijian@cn.=
fujitsu.com</a>;<br>
<br>
&gt; &gt; <a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang=
@redhat.com</a>; Derek Su &lt;<a href=3D"mailto:dereksu@qnap.com" target=3D=
"_blank">dereksu@qnap.com</a>&gt;<br>
<br>
&gt; &gt; Subject: [PATCH v1 2/2] colo-compare: Record packet creation time=
 by<br>
<br>
&gt; &gt; QEMU_CLOCK_REALTIME<br>
<br>
&gt; &gt;<br>
<br>
&gt; &gt; Record packet creation time by QEMU_CLOCK_REALTIME instead of<br>
<br>
&gt; &gt; QEMU_CLOCK_HOST. The time difference between `now` and packet<br>
<br>
&gt; &gt; `creation_ms` has the possibility of an unexpected negative value=
 and<br>
<br>
&gt; &gt; results in wrong comparison after changing the host clock.<br>
<br>
&gt; &gt;<br>
<br>
&gt; <br>
<br>
&gt; Hi Derek,<br>
<br>
&gt; <br>
<br>
&gt; I think this issue caused by other code in this file use the<br>
<br>
&gt; qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);<br>
<br>
&gt; I will change all code to QEMU_CLOCK_HOST to fix it with the patch 1/2=
.<br>
<br>
<br>
<br>
If you feel OK, or you can send the new version.=C2=A0 :-)<u></u><u></u></p=
>
</blockquote>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Hello, Chen<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Is the monotonically increasing clock better than ho=
st clock in the COLO compare framework?<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">The host clock is sometimes changed by the users man=
ually or NTP synchronization automatically, and the cases may lead to the r=
elative time be disordered.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">For example, the `creation_time` of one packet is ad=
vanced to the `now` in our tests.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I incline to replace QEMU_CLOCK_REALTIME and QEMU_CL=
OCK_VIRTUAL with the=C2=A0monotonically increasing clock QEMU_CLOCK_REALTIM=
E in COLO compare framework.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">How about your thoughts?<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">Hi Derek,</spa=
n><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">=C2=A0</span><=
u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">/**</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* QEMUClockType:</span><u></u><u></u>=
</p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">*</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* The following clock types are avail=
able:</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">*</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* @QEMU_CLOCK_REALTIME: Real time clo=
ck</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">*</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* The real time clock should be used =
only for stuff which does not</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* change the virtual machine state, a=
s it runs even if the virtual</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* machine is stopped.</span><u></u><u=
></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">*</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* @QEMU_CLOCK_VIRTUAL: virtual clock<=
/span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">*</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* The virtual clock only runs during =
the emulation. It stops</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* when the virtual machine is stopped=
.</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">*</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* @QEMU_CLOCK_HOST: host clock</span>=
<u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">*</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* The host clock should be used for d=
evice models that emulate accurate</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* real time sources. It will continue=
 to run when the virtual machine</span><u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:5.25pt">
<span style=3D"color:rgb(68,114,196)">* is suspended, and it will reflect s=
ystem time changes the host may</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">* undergo (e.g=
. due to NTP).</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">=C2=A0</span><=
u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">=C2=A0</span><=
u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">When COLO runn=
ing, it will change the virtual machine state.</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">So I think use=
 the QEMU_CLOCK_HOST is better.</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">=C2=A0</span><=
u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">Thanks</span><=
u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:rgb(68,114,196)">Zhang Chen</sp=
an><u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">If OK, I will send the new version again, thanks. :)=
<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thank you.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Derek<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin:5pt 0i=
n 5pt 4.8pt">
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</blockquote>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin:5pt 0i=
n 5pt 4.8pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><br>
&gt; <br>
<br>
&gt; Thanks<br>
<br>
&gt; Zhang Chen<br>
<br>
&gt; <br>
<br>
&gt; &gt; Signed-off-by: Derek Su &lt;<a href=3D"mailto:dereksu@qnap.com" t=
arget=3D"_blank">dereksu@qnap.com</a>&gt;<br>
<br>
&gt; &gt; ---<br>
<br>
&gt; &gt;=C2=A0 net/colo-compare.c | 2 +-<br>
<br>
&gt; &gt;=C2=A0 net/colo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
<br>
&gt; &gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
&gt; &gt;<br>
<br>
&gt; &gt; diff --git a/net/colo-compare.c b/net/colo-compare.c index<br>
<br>
&gt; &gt; c4de86ef34..29d7f986e3 100644<br>
<br>
&gt; &gt; --- a/net/colo-compare.c<br>
<br>
&gt; &gt; +++ b/net/colo-compare.c<br>
<br>
&gt; &gt; @@ -621,7 +621,7 @@ static int colo_packet_compare_other(Packet *=
spkt,<br>
<br>
&gt; &gt; Packet *ppkt)<br>
<br>
&gt; &gt;<br>
<br>
&gt; &gt;=C2=A0 static int colo_old_packet_check_one(Packet *pkt, void *use=
r_data)=C2=A0 {<br>
<br>
&gt; &gt; -=C2=A0 =C2=A0 int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST)=
;<br>
<br>
&gt; &gt; +=C2=A0 =C2=A0 int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_REALT=
IME);<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t check_time =3D *(uint32_t *)user_dat=
a;<br>
<br>
&gt; &gt;<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if ((now - pkt-&gt;creation_ms) &gt; check_ti=
me) { diff --git<br>
<br>
&gt; &gt; a/net/colo.c b/net/colo.c index a6c66d829a..0441910169 100644<br>
<br>
&gt; &gt; --- a/net/colo.c<br>
<br>
&gt; &gt; +++ b/net/colo.c<br>
<br>
&gt; &gt; @@ -164,7 +164,7 @@ Packet *packet_new(const void *data, int size=
, int<br>
<br>
&gt; &gt; vnet_hdr_len)<br>
<br>
&gt; &gt;<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;data =3D g_memdup(data, size);<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;size =3D size;<br>
<br>
&gt; &gt; -=C2=A0 =C2=A0 pkt-&gt;creation_ms =3D qemu_clock_get_ms(QEMU_CLO=
CK_HOST);<br>
<br>
&gt; &gt; +=C2=A0 =C2=A0 pkt-&gt;creation_ms =3D qemu_clock_get_ms(QEMU_CLO=
CK_REALTIME);<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;vnet_hdr_len =3D vnet_hdr_len;<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;tcp_seq =3D 0;<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;tcp_ack =3D 0;<br>
<br>
&gt; &gt; --<br>
<br>
&gt; &gt; 2.25.1<br>
<br>
<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</div>
</div>

</blockquote></div></div>

--0000000000002b60db05af50608b--

