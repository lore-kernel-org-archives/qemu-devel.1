Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0C5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F365621655
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="kDC30T37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F365621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHcPs-0004go-Un
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 20:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kHcP7-0003yd-VC
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:31:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kHcP5-0007MH-OS
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:31:33 -0400
Received: by mail-wm1-x341.google.com with SMTP id k18so9512842wmj.5
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 17:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xh0RNo0UJ+1PDOwIN+Fp0jsUoqFYRYp939o5pRjQBi0=;
 b=kDC30T37FdYJx0270Y2w+vsVg2k6kl52jIr3v78Umh+H83Wewtz2IUSyytUdTkbpZV
 rtDKcKr+4Ozpb2VRnJ4i5/AWlYaprWn92f6YaEmbYUBmRpt4TltQZLdSRX2cXB2YjH4P
 k2yWxZu4RCt2jwf97m7pcilFVYu2V520PiuYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xh0RNo0UJ+1PDOwIN+Fp0jsUoqFYRYp939o5pRjQBi0=;
 b=HHe/ssWBJ44Tfbpk88APhG/Jb25qFAJjcWyK/wjhlm/c3u9lkj02DGuTO+lyRrBfgz
 5azsaRLuS2AIq3WEwthn540XwERBHmXm/lbCF/7YL5qPNGVBWj/eoib/et4SIaeH/cJt
 Pxde9ogWUVzmFLbs9gGxDSJhZv0YwyOPG0uQ+fCTp8bJ38XYjzY1KYOOMlJy2ctZHBZC
 BQVSfZS3mBxarMsKpJuIFnB+IHc7/OXFVF795twY1xwqYQ6lWEamumizwaKG/RWOYOq/
 E2J0JxLdqvHbfJ07LXG6941P54JxllqMb1x0xlXcNv9xZrDNIFZU+MTEcPv8WY/GiuW4
 zCBQ==
X-Gm-Message-State: AOAM532ZG1VsIK6IJGMcDp/jnyoI80Z5Y7Sqxy5GA7EfInGU5LkqUzU6
 2q2LnkCioK5gi4PxBYUwpioMV0xKfQ9ttgHUH5Qfbw==
X-Google-Smtp-Source: ABdhPJyfbwPYN5nX8v14TOvibeh/2PNuVNAlyNMsdDZcmnEXB6GUkSxLd7KrxSCtivsCfRwdxspuhh+rcbaR8guBTBM=
X-Received: by 2002:a1c:770c:: with SMTP id t12mr13338382wmi.121.1600043488125; 
 Sun, 13 Sep 2020 17:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200911190508.1316487-1-dereksu@qnap.com>
 <20200911190508.1316487-2-dereksu@qnap.com>
 <3c5d8cfd966a415c896c0d8e814e4ab9@intel.com>
In-Reply-To: <3c5d8cfd966a415c896c0d8e814e4ab9@intel.com>
From: Derek Su <dereksu@qnap.com>
Date: Mon, 14 Sep 2020 08:31:17 +0800
Message-ID: <CAKEOLWVK5=AbTnxG4-udQQG8kizZ1xET+MDGcwbs0-83TBAxTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] colo-compare: Fix incorrect data type conversion
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="000000000000bc3be005af3b273c"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=dereksu@qnap.com; helo=mail-wm1-x341.google.com
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

--000000000000bc3be005af3b273c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chen

Got it, thank you :)

Regards,
Derek

Zhang, Chen <chen.zhang@intel.com>=E6=96=BC 2020=E5=B9=B49=E6=9C=8814=E6=97=
=A5 =E9=80=B1=E4=B8=80=EF=BC=8C=E4=B8=8A=E5=8D=884:02=E5=AF=AB=E9=81=93=EF=
=BC=9A

>
>
>
>
> > -----Original Message-----
>
> > From: Derek Su <dereksu@qnap.com>
>
> > Sent: Saturday, September 12, 2020 3:05 AM
>
> > To: qemu-devel@nongnu.org
>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
>
> > jasowang@redhat.com; Derek Su <dereksu@qnap.com>
>
> > Subject: [PATCH v1 1/2] colo-compare: Fix incorrect data type conversio=
n
>
> >
>
> > Fix data type conversion of compare_timeout. The incorrect conversion
>
> > results in a random compare_timeout value and unexpected stalls in pack=
et
>
> > comparison.
>
> >
>
>
>
> This bug already found on our internal test too. Just waiting to send.
>
> Good catch! But this patch not fixed the root cause.
>
> Change the compare_timeout from uint32_t to uint64_t is better.
>
> I will send a patch for this and tag reported by you.
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
> > Signed-off-by: Derek Su <dereksu@qnap.com>
>
> > ---
>
> >  net/colo-compare.c | 5 +++--
>
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> >
>
> > diff --git a/net/colo-compare.c b/net/colo-compare.c index
>
> > 2c20de1537..c4de86ef34 100644
>
> > --- a/net/colo-compare.c
>
> > +++ b/net/colo-compare.c
>
> > @@ -619,11 +619,12 @@ static int colo_packet_compare_other(Packet *spkt=
,
>
> > Packet *ppkt)
>
> >                                         ppkt->size - offset);  }
>
> >
>
> > -static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
>
> > +static int colo_old_packet_check_one(Packet *pkt, void *user_data)
>
> >  {
>
> >      int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>
> > +    uint32_t check_time =3D *(uint32_t *)user_data;
>
> >
>
> > -    if ((now - pkt->creation_ms) > (*check_time)) {
>
> > +    if ((now - pkt->creation_ms) > check_time) {
>
> >          trace_colo_old_packet_check_found(pkt->creation_ms);
>
> >          return 0;
>
> >      } else {
>
> > --
>
> > 2.25.1
>
>
>
> --

Best regards,

Derek Su
QNAP Systems, Inc.
Email: dereksu@qnap.com
Tel: (+886)-2-2393-5152 ext. 15017
Address: 13F., No.56, Sec. 1, Xinsheng S. Rd., Zhongzheng Dist., Taipei
City, Taiwan

--000000000000bc3be005af3b273c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto" style=3D"font-size:1rem;word-spacing:1px;border-colo=
r:rgb(49,49,49);color:rgb(49,49,49)">Hi, Chen</div><div dir=3D"auto" style=
=3D"word-spacing:1px;border-color:rgb(49,49,49);color:rgb(49,49,49)"><br></=
div><div dir=3D"auto" style=3D"font-size:1rem;word-spacing:1px;border-color=
:rgb(49,49,49);color:rgb(49,49,49)">Got it, thank you :)</div><div dir=3D"a=
uto" style=3D"word-spacing:1px;border-color:rgb(49,49,49);color:rgb(49,49,4=
9)"><br></div><div dir=3D"auto" style=3D"font-size:1rem;word-spacing:1px;bo=
rder-color:rgb(49,49,49);color:rgb(49,49,49)">Regards,</div><div dir=3D"aut=
o" style=3D"font-size:1rem;word-spacing:1px;border-color:rgb(49,49,49);colo=
r:rgb(49,49,49)">Derek</div></div><div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">Zhang, Chen &lt;<a href=3D"mailto:chen.zha=
ng@intel.com">chen.zhang@intel.com</a>&gt;=E6=96=BC 2020=E5=B9=B49=E6=9C=88=
14=E6=97=A5 =E9=80=B1=E4=B8=80=EF=BC=8C=E4=B8=8A=E5=8D=884:02=E5=AF=AB=E9=
=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-lef=
t:1ex;border-left-color:rgb(204,204,204)"><br><br><br><br>&gt; -----Origina=
l Message-----<br><br>&gt; From: Derek Su &lt;<a href=3D"mailto:dereksu@qna=
p.com" target=3D"_blank">dereksu@qnap.com</a>&gt;<br><br>&gt; Sent: Saturda=
y, September 12, 2020 3:05 AM<br><br>&gt; To: <a href=3D"mailto:qemu-devel@=
nongnu.org" target=3D"_blank">qemu-devel@nongnu.org</a><br><br>&gt; Cc: Zha=
ng, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=3D"_blank">chen=
.zhang@intel.com</a>&gt;; <a href=3D"mailto:lizhijian@cn.fujitsu.com" targe=
t=3D"_blank">lizhijian@cn.fujitsu.com</a>;<br><br>&gt; <a href=3D"mailto:ja=
sowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>; Derek Su &lt;=
<a href=3D"mailto:dereksu@qnap.com" target=3D"_blank">dereksu@qnap.com</a>&=
gt;<br><br>&gt; Subject: [PATCH v1 1/2] colo-compare: Fix incorrect data ty=
pe conversion<br><br>&gt; <br><br>&gt; Fix data type conversion of compare_=
timeout. The incorrect conversion<br><br>&gt; results in a random compare_t=
imeout value and unexpected stalls in packet<br><br>&gt; comparison.<br><br=
>&gt; <br><br><br><br>This bug already found on our internal test too. Just=
 waiting to send.<br><br>Good catch! But this patch not fixed the root caus=
e.<br><br>Change the compare_timeout from uint32_t to uint64_t is better.<b=
r><br>I will send a patch for this and tag reported by you.<br><br><br><br>=
Thanks<br><br>Zhang Chen<br><br><br><br><br><br>&gt; Signed-off-by: Derek S=
u &lt;<a href=3D"mailto:dereksu@qnap.com" target=3D"_blank">dereksu@qnap.co=
m</a>&gt;<br><br>&gt; ---<br><br>&gt;=C2=A0 net/colo-compare.c | 5 +++--<br=
><br>&gt;=C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)<br><br>&gt;=
 <br><br>&gt; diff --git a/net/colo-compare.c b/net/colo-compare.c index<br=
><br>&gt; 2c20de1537..c4de86ef34 100644<br><br>&gt; --- a/net/colo-compare.=
c<br><br>&gt; +++ b/net/colo-compare.c<br><br>&gt; @@ -619,11 +619,12 @@ st=
atic int colo_packet_compare_other(Packet *spkt,<br><br>&gt; Packet *ppkt)<=
br><br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ppkt-&gt;size - offset);=C2=A0 }<br><br>&gt; <br><br>&gt; -static=
 int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)<br><br>&gt=
; +static int colo_old_packet_check_one(Packet *pkt, void *user_data)<br><b=
r>&gt;=C2=A0 {<br><br>&gt;=C2=A0 =C2=A0 =C2=A0 int64_t now =3D qemu_clock_g=
et_ms(QEMU_CLOCK_HOST);<br><br>&gt; +=C2=A0 =C2=A0 uint32_t check_time =3D =
*(uint32_t *)user_data;<br><br>&gt; <br><br>&gt; -=C2=A0 =C2=A0 if ((now - =
pkt-&gt;creation_ms) &gt; (*check_time)) {<br><br>&gt; +=C2=A0 =C2=A0 if ((=
now - pkt-&gt;creation_ms) &gt; check_time) {<br><br>&gt;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 trace_colo_old_packet_check_found(pkt-&gt;creation_ms);<b=
r><br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br><br>&gt;=C2=A0 =
=C2=A0 =C2=A0 } else {<br><br>&gt; --<br><br>&gt; 2.25.1<br><br><br><br></b=
lockquote></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" dat=
a-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div=
><div dir=3D"ltr"><div><font face=3D"Arial, sans-serif" color=3D"#000000"><=
span style=3D"font-size:13.3333px"><br>Best regards,<br></span><br><span st=
yle=3D"font-size:13.3333px">Derek Su</span></font></div><div><font face=3D"=
Arial, sans-serif" color=3D"#000000"><span style=3D"font-size:13.3333px">QN=
AP Systems, Inc.</span></font></div><div><font face=3D"Arial, sans-serif" c=
olor=3D"#000000"><span style=3D"font-size:13.3333px">Email: <a href=3D"mail=
to:dereksu@qnap.com" target=3D"_blank">dereksu@qnap.com</a></span></font></=
div><div><font face=3D"Arial, sans-serif" color=3D"#000000"><span style=3D"=
font-size:13.3333px">Tel: (+886)-2-2393-5152 ext. 15017</span></font></div>=
<div><font face=3D"Arial, sans-serif" color=3D"#000000"><span style=3D"font=
-size:13.3333px">Address: 13F., No.56, Sec. 1, Xinsheng S. Rd., Zhongzheng =
Dist., Taipei City, Taiwan</span></font></div></div></div></div></div></div=
></div>

--000000000000bc3be005af3b273c--

