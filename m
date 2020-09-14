Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A0EC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 01:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD502177B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 01:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="ZuXMZnYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD502177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHcru-000092-PP
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 21:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kHcrH-0008BG-0h
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:00:39 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:36468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kHcrE-0001zR-V8
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:00:38 -0400
Received: by mail-wr1-x42d.google.com with SMTP id z1so16845815wrt.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=haebYIPJkXkeCHqX6We1Jj3ofnRMob73pUCR4N47I4o=;
 b=ZuXMZnYITAWVJWujrg6S6JsZg+Jp4TGjFMz7xsdcZohtZ5uNjCki1WnOxCnYEOeMoI
 d/fQWaCmvwkN9RFEd0Bo1+RQvd4pnkA7VS4w3W6HNx0FT8PEQ3qixrCWkW6Gkt6aEGOW
 +yEc2fDb5p96f1Ib1gNIRR+aNnKcn62+aloLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=haebYIPJkXkeCHqX6We1Jj3ofnRMob73pUCR4N47I4o=;
 b=q3Ai0g7Wtk8sG4W1utoFn+/VqNIflmn1xJpBP0KfX7wnG0mvXD24YmCLtlxdzObZ4v
 XVtP1cXSn0eMUiBGLJzeO/IOtMhyFkdavdLnEp0XWn5ku+n2ZLT8o22m89TYRO8MkaJs
 GlIU69PQxpSaJhTLEMPT33THIBic4KiIxpvrkAuTbrlo6Ey9rde68GEQOQOGqMlQG/fX
 KNjooylypbKK9adxK2w82DSscv1jBuHTqP330DIQAyHm1PYarxi8c3Wi+EOY9d4nqgRr
 vVwsFcsJPUo9Bo+UMgrGT/Hciy9kFubEpxOIndyYkaJJKb1FH/Yz4gIxG0ReQpbw8owQ
 6Cjg==
X-Gm-Message-State: AOAM533Zi0QsCehadQceUHB34vtGbr4i7e9pJ1jSyLnKJLj61qseW7+u
 RD/IjASsAnwrfy82xxWEh54hbQEDG9eVOBhvLIXXXw==
X-Google-Smtp-Source: ABdhPJy58rErjOPqnsmnHFuHqOJy5xRcwusJl//WYBaw/00d+LD6p+z5Cd72Z4rTDL4qktsvyVuBdMf2/Nl7BwK91x0=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr13665632wrq.203.1600045235261; 
 Sun, 13 Sep 2020 18:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200911190508.1316487-1-dereksu@qnap.com>
 <20200911190508.1316487-3-dereksu@qnap.com>
 <817fd011098a4fc6a6790c17414a71a8@intel.com>
 <0bf192578764481e8757c6595094eb28@intel.com>
In-Reply-To: <0bf192578764481e8757c6595094eb28@intel.com>
From: Derek Su <dereksu@qnap.com>
Date: Mon, 14 Sep 2020 09:00:24 +0800
Message-ID: <CAKEOLWUVzX4nudNBKJhqYqAxJFRq4BXPDiDynAEd_K-h5DDTpA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] colo-compare: Record packet creation time by
 QEMU_CLOCK_REALTIME
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="000000000000df651a05af3b8fb1"
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=dereksu@qnap.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000df651a05af3b8fb1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Zhang, Chen <chen.zhang@intel.com>=E6=96=BC 2020=E5=B9=B49=E6=9C=8814=E6=97=
=A5 =E9=80=B1=E4=B8=80=EF=BC=8C=E4=B8=8A=E5=8D=884:06=E5=AF=AB=E9=81=93=EF=
=BC=9A

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
Hello, Chen

Is the monotonically increasing clock better than host clock in the COLO
compare framework?
The host clock is sometimes changed by the users manually or NTP
synchronization automatically, and the cases may lead to the relative time
be disordered.
For example, the `creation_time` of one packet is advanced to the `now` in
our tests.

I incline to replace QEMU_CLOCK_REALTIME and QEMU_CLOCK_VIRTUAL with
the monotonically increasing clock QEMU_CLOCK_REALTIME in COLO compare
framework.
How about your thoughts?

If OK, I will send the new version again, thanks. :)
Thank you.

Regards,
Derek


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
>
>

--000000000000df651a05af3b8fb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Zhang, Chen &lt;<a href=3D"mailto:chen.zhang=
@intel.com" target=3D"_blank">chen.zhang@intel.com</a>&gt;=E6=96=BC 2020=E5=
=B9=B49=E6=9C=8814=E6=97=A5 =E9=80=B1=E4=B8=80=EF=BC=8C=E4=B8=8A=E5=8D=884:=
06=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;padding-left:1ex;border-left-color:rgb(204,204,204)"><br><br><br><br>&gt=
; -----Original Message-----<br><br>&gt; From: Zhang, Chen<br><br>&gt; Sent=
: Monday, September 14, 2020 4:02 AM<br><br>&gt; To: &#39;Derek Su&#39; &lt=
;<a href=3D"mailto:dereksu@qnap.com" target=3D"_blank">dereksu@qnap.com</a>=
&gt;; <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel=
@nongnu.org</a><br><br>&gt; Cc: <a href=3D"mailto:lizhijian@cn.fujitsu.com"=
 target=3D"_blank">lizhijian@cn.fujitsu.com</a>; <a href=3D"mailto:jasowang=
@redhat.com" target=3D"_blank">jasowang@redhat.com</a><br><br>&gt; Subject:=
 RE: [PATCH v1 2/2] colo-compare: Record packet creation time by<br><br>&gt=
; QEMU_CLOCK_REALTIME<br><br>&gt; <br><br>&gt; <br><br>&gt; <br><br>&gt; &g=
t; -----Original Message-----<br><br>&gt; &gt; From: Derek Su &lt;<a href=
=3D"mailto:dereksu@qnap.com" target=3D"_blank">dereksu@qnap.com</a>&gt;<br>=
<br>&gt; &gt; Sent: Saturday, September 12, 2020 3:05 AM<br><br>&gt; &gt; T=
o: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@no=
ngnu.org</a><br><br>&gt; &gt; Cc: Zhang, Chen &lt;<a href=3D"mailto:chen.zh=
ang@intel.com" target=3D"_blank">chen.zhang@intel.com</a>&gt;; <a href=3D"m=
ailto:lizhijian@cn.fujitsu.com" target=3D"_blank">lizhijian@cn.fujitsu.com<=
/a>;<br><br>&gt; &gt; <a href=3D"mailto:jasowang@redhat.com" target=3D"_bla=
nk">jasowang@redhat.com</a>; Derek Su &lt;<a href=3D"mailto:dereksu@qnap.co=
m" target=3D"_blank">dereksu@qnap.com</a>&gt;<br><br>&gt; &gt; Subject: [PA=
TCH v1 2/2] colo-compare: Record packet creation time by<br><br>&gt; &gt; Q=
EMU_CLOCK_REALTIME<br><br>&gt; &gt;<br><br>&gt; &gt; Record packet creation=
 time by QEMU_CLOCK_REALTIME instead of<br><br>&gt; &gt; QEMU_CLOCK_HOST. T=
he time difference between `now` and packet<br><br>&gt; &gt; `creation_ms` =
has the possibility of an unexpected negative value and<br><br>&gt; &gt; re=
sults in wrong comparison after changing the host clock.<br><br>&gt; &gt;<b=
r><br>&gt; <br><br>&gt; Hi Derek,<br><br>&gt; <br><br>&gt; I think this iss=
ue caused by other code in this file use the<br><br>&gt; qemu_clock_get_ms(=
QEMU_CLOCK_VIRTUAL);<br><br>&gt; I will change all code to QEMU_CLOCK_HOST =
to fix it with the patch 1/2.<br><br><br><br>If you feel OK, or you can sen=
d the new version.=C2=A0 :-)<br><br></blockquote><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Hello, Chen</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Is the monotonically increasing clock better than host clock in t=
he COLO compare framework?<br></div><div dir=3D"auto">The host clock is som=
etimes changed by the users manually or NTP synchronization automatically, =
and the cases may lead to the relative time be disordered.</div><div>For ex=
ample, the `creation_time` of one packet is advanced to the `now` in our te=
sts.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I incline to replac=
e QEMU_CLOCK_REALTIME and QEMU_CLOCK_VIRTUAL with the=C2=A0monotonically in=
creasing clock QEMU_CLOCK_REALTIME in COLO compare framework.</div><div dir=
=3D"auto">How about your thoughts?</div><div dir=3D"auto"><br></div><div>If=
 OK, I will send the new version again, thanks. :)</div><div>Thank you.</di=
v><div><br></div><div>Regards,</div><div>Derek</div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wid=
th:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,2=
04,204)"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-le=
ft:1ex;border-left-color:rgb(204,204,204)"><br>&gt; <br><br>&gt; Thanks<br>=
<br>&gt; Zhang Chen<br><br>&gt; <br><br>&gt; &gt; Signed-off-by: Derek Su &=
lt;<a href=3D"mailto:dereksu@qnap.com" target=3D"_blank">dereksu@qnap.com</=
a>&gt;<br><br>&gt; &gt; ---<br><br>&gt; &gt;=C2=A0 net/colo-compare.c | 2 +=
-<br><br>&gt; &gt;=C2=A0 net/colo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-=
<br><br>&gt; &gt;=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)<br=
><br>&gt; &gt;<br><br>&gt; &gt; diff --git a/net/colo-compare.c b/net/colo-=
compare.c index<br><br>&gt; &gt; c4de86ef34..29d7f986e3 100644<br><br>&gt; =
&gt; --- a/net/colo-compare.c<br><br>&gt; &gt; +++ b/net/colo-compare.c<br>=
<br>&gt; &gt; @@ -621,7 +621,7 @@ static int colo_packet_compare_other(Pack=
et *spkt,<br><br>&gt; &gt; Packet *ppkt)<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 static int colo_old_packet_check_one(Packet *pkt, void *user_data)=
=C2=A0 {<br><br>&gt; &gt; -=C2=A0 =C2=A0 int64_t now =3D qemu_clock_get_ms(=
QEMU_CLOCK_HOST);<br><br>&gt; &gt; +=C2=A0 =C2=A0 int64_t now =3D qemu_cloc=
k_get_ms(QEMU_CLOCK_REALTIME);<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_=
t check_time =3D *(uint32_t *)user_data;<br><br>&gt; &gt;<br><br>&gt; &gt;=
=C2=A0 =C2=A0 =C2=A0 if ((now - pkt-&gt;creation_ms) &gt; check_time) { dif=
f --git<br><br>&gt; &gt; a/net/colo.c b/net/colo.c index a6c66d829a..044191=
0169 100644<br><br>&gt; &gt; --- a/net/colo.c<br><br>&gt; &gt; +++ b/net/co=
lo.c<br><br>&gt; &gt; @@ -164,7 +164,7 @@ Packet *packet_new(const void *da=
ta, int size, int<br><br>&gt; &gt; vnet_hdr_len)<br><br>&gt; &gt;<br><br>&g=
t; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;data =3D g_memdup(data, size);<br><br>&=
gt; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;size =3D size;<br><br>&gt; &gt; -=C2=
=A0 =C2=A0 pkt-&gt;creation_ms =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);<br><=
br>&gt; &gt; +=C2=A0 =C2=A0 pkt-&gt;creation_ms =3D qemu_clock_get_ms(QEMU_=
CLOCK_REALTIME);<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;vnet_hdr_len =
=3D vnet_hdr_len;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;tcp_seq =3D =
0;<br><br>&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pkt-&gt;tcp_ack =3D 0;<br><br>&gt; =
&gt; --<br><br>&gt; &gt; 2.25.1<br><br><br><br></blockquote></div></div>
</div>

--000000000000df651a05af3b8fb1--

