Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32124C3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BDE22B48
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiZyb+GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BDE22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nwy-0000c0-6d
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pfeiner@google.com>) id 1j8nwL-0008Vs-Ft
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pfeiner@google.com>) id 1j8nwJ-0007RY-Cg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:29:09 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35]:37298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pfeiner@google.com>) id 1j8nwJ-0007RH-6c
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:29:07 -0500
Received: by mail-vs1-xe35.google.com with SMTP id h5so330011vsc.4
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 08:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WK4ucfoiyoJNA2oSfqe135x1T0cG0PFm6WO5SspZ6+I=;
 b=KiZyb+GCYH4IBjs5Z+UN9QSyQsvNRrEGNAVauW+TJcDnXxiMtf/wllTcRe+x9JUTZa
 xePrfPJPd6nqysWRU42mYW/QH8kfNBCi/kcNst2Zhj6hH4T/p+nJ5q6kd65kkj5O1oqk
 WlyO4LEIoiE1bVYICbTR0dJQOGreeaRdWFSk8qkFBQbS/WtM5GG8FOFbUd0FyGQKbiy9
 2wrQz4wATMZFEi7EUY11dK47rXzkT8VnYadcFztJDECpnL9eKVle1ykE+9VxL4j1ONXt
 CZPxYPhWZh/M+rPU29H/06jWcx1iHli79Mlw/CMPKd7PZtCoyc2djjhiUcOBbCrc3UZf
 8z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WK4ucfoiyoJNA2oSfqe135x1T0cG0PFm6WO5SspZ6+I=;
 b=Bb84xyp/Ld8gHLLh6zPoSmDMOaTzxImSjhvLt5L8MlooR4F+xZkcO0ymhHt6UvVD8M
 HwHmvVtLuUI75UR5AXE4XoTDJdLxhnUDfjEFFMGcbm/Jgg29zjXey60UjS972EqByoUl
 IT+OOmEe4RB309DOZVaj58sFl1d5L0r39MF1B5CdDdu/PLvB3E98M758HHe9l4E7/pOi
 1mfdUq5xZwUUa0OUVYHP7Vpwpmxs/ZBZuQWXXLG1Cf66A/ZqrAE2yJVTz0yxdct4p02e
 vXDvdX/Bp8vE9Geg8gB0uYywiGc5jOkZ80TGn+3Td+rb+TYY9mGeNHHgW6fgEJJpHBkb
 Ljnw==
X-Gm-Message-State: ANhLgQ1j6LOjdY7eA+UKmxnrLYmBOaaVwSzBsEaUHBTeGhokCV6C/2sN
 Hcw9tav79yaFMPuHf7GYN1Zyll1A42lPKEyktzp9Pg==
X-Google-Smtp-Source: ADFU+vs8eZNPTtg1DGTH4l31nJbnkZ+cM4ubc2rl0ZX6NNaKZzA86+65X+Nq67+7PNYf+W/cO3/VXTlqh/oLsrRTYEE=
X-Received: by 2002:a05:6102:662:: with SMTP id
 z2mr9619594vsf.233.1583166545513; 
 Mon, 02 Mar 2020 08:29:05 -0800 (PST)
MIME-Version: 1.0
References: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
 <20200218174311.GE1408806@xz-x1>
 <B2D15215269B544CADD246097EACE7474BAFF835@DGGEMM528-MBX.china.huawei.com>
 <20200219171919.GA34517@xz-x1>
 <B2D15215269B544CADD246097EACE7474BB03772@DGGEMM528-MBX.china.huawei.com>
 <CANgfPd-P_=GqcMiwLSSkUhZDt42aMLUsCJt+CPdUN5yR3RLHmQ@mail.gmail.com>
 <cd4626a1-44b5-1a62-cf4b-716950a6db1b@google.com>
 <CAM3pwhGF3ABoew5UOd9xUxtm14VN_o0gr+D=KfR3ZEQjmKgUdQ@mail.gmail.com>
 <B2D15215269B544CADD246097EACE7474BB4A71D@DGGEMM528-MBX.china.huawei.com>
In-Reply-To: <B2D15215269B544CADD246097EACE7474BB4A71D@DGGEMM528-MBX.china.huawei.com>
From: Peter Feiner <pfeiner@google.com>
Date: Mon, 2 Mar 2020 08:28:54 -0800
Message-ID: <CAM3pwhH8xyisEq_=LFTy=sZNA2kRTQTbBqW6GA-0M-AiJy0q1g@mail.gmail.com>
Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, 
 "quintela@redhat.com" <quintela@redhat.com>,
 "Liujinsong (Paul)" <liu.jinsong@huawei.com>, 
 "linfeng (M)" <linfeng23@huawei.com>,
 "wangxin (U)" <wangxinxin.wang@huawei.com>, 
 "Huangweidong (C)" <weidong.huang@huawei.com>,
 Junaid Shahid <junaids@google.com>
Content-Type: multipart/alternative; boundary="0000000000009134f8059fe1afb2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e35
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009134f8059fe1afb2
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 2, 2020, 5:38 AM Zhoujian (jay) <jianjay.zhou@huawei.com> wrote:

>
>
> > -----Original Message-----
> > From: Peter Feiner [mailto:pfeiner@google.com]
> > Sent: Saturday, February 22, 2020 8:19 AM
> > To: Junaid Shahid <junaids@google.com>
> > Cc: Ben Gardon <bgardon@google.com>; Zhoujian (jay)
> > <jianjay.zhou@huawei.com>; Peter Xu <peterx@redhat.com>;
> > kvm@vger.kernel.org; qemu-devel@nongnu.org; pbonzini@redhat.com;
> > dgilbert@redhat.com; quintela@redhat.com; Liujinsong (Paul)
> > <liu.jinsong@huawei.com>; linfeng (M) <linfeng23@huawei.com>; wangxin
> (U)
> > <wangxinxin.wang@huawei.com>; Huangweidong (C)
> > <weidong.huang@huawei.com>
> > Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
> >
> > On Fri, Feb 21, 2020 at 2:08 PM Junaid Shahid <junaids@google.com>
> wrote:
> > >
> > > On 2/20/20 9:34 AM, Ben Gardon wrote:
> > > >
> > > > FWIW, we currently do this eager splitting at Google for live
> > > > migration. When the log-dirty-memory flag is set on a memslot we
> > > > eagerly split all pages in the slot down to 4k granularity.
> > > > As Jay said, this does not cause crippling lock contention because
> > > > the vCPU page faults generated by write protection / splitting can
> > > > be resolved in the fast page fault path without acquiring the MMU
> lock.
> > > > I believe +Junaid Shahid tried to upstream this approach at some
> > > > point in the past, but the patch set didn't make it in. (This was
> > > > before my time, so I'm hoping he has a link.) I haven't done the
> > > > analysis to know if eager splitting is more or less efficient with
> > > > parallel slow-path page faults, but it's definitely faster under the
> > > > MMU lock.
> > > >
> > >
> > > I am not sure if we ever posted those patches upstream. Peter Feiner
> would
> > know for sure. One notable difference in what we do compared to the
> approach
> > outlined by Jay is that we don't rely on tdp_page_fault() to do the
> splitting. So we
> > don't have to create a dummy VCPU and the specialized split function is
> also
> > much faster.
> >
> > We've been carrying these patches since 2015. I've never posted them.
> > Getting them in shape for upstream consumption will take some work. I
> can look
> > into this next week.
>
> Hi Peter Feiner,
>
> May I ask any new updates about your plan? Sorry to disturb.
>


Hi Jay,

I've been sick since I sent my last email, so I haven't gotten to this
patch set yet. I'll send it in the next week or two.

Peter


> Regards,
> Jay Zhou
>

--0000000000009134f8059fe1afb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Mar 2, 2020, 5:38 AM Zhoujian (jay) &lt;<a hre=
f=3D"mailto:jianjay.zhou@huawei.com">jianjay.zhou@huawei.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Peter Feiner [mailto:<a href=3D"mailto:pfeiner@google.com" targe=
t=3D"_blank" rel=3D"noreferrer">pfeiner@google.com</a>]<br>
&gt; Sent: Saturday, February 22, 2020 8:19 AM<br>
&gt; To: Junaid Shahid &lt;<a href=3D"mailto:junaids@google.com" target=3D"=
_blank" rel=3D"noreferrer">junaids@google.com</a>&gt;<br>
&gt; Cc: Ben Gardon &lt;<a href=3D"mailto:bgardon@google.com" target=3D"_bl=
ank" rel=3D"noreferrer">bgardon@google.com</a>&gt;; Zhoujian (jay)<br>
&gt; &lt;<a href=3D"mailto:jianjay.zhou@huawei.com" target=3D"_blank" rel=
=3D"noreferrer">jianjay.zhou@huawei.com</a>&gt;; Peter Xu &lt;<a href=3D"ma=
ilto:peterx@redhat.com" target=3D"_blank" rel=3D"noreferrer">peterx@redhat.=
com</a>&gt;;<br>
&gt; <a href=3D"mailto:kvm@vger.kernel.org" target=3D"_blank" rel=3D"norefe=
rrer">kvm@vger.kernel.org</a>; <a href=3D"mailto:qemu-devel@nongnu.org" tar=
get=3D"_blank" rel=3D"noreferrer">qemu-devel@nongnu.org</a>; <a href=3D"mai=
lto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redh=
at.com</a>;<br>
&gt; <a href=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">dgilbert@redhat.com</a>; <a href=3D"mailto:quintela@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">quintela@redhat.com</a>; Liujinsong (Paul)<=
br>
&gt; &lt;<a href=3D"mailto:liu.jinsong@huawei.com" target=3D"_blank" rel=3D=
"noreferrer">liu.jinsong@huawei.com</a>&gt;; linfeng (M) &lt;<a href=3D"mai=
lto:linfeng23@huawei.com" target=3D"_blank" rel=3D"noreferrer">linfeng23@hu=
awei.com</a>&gt;; wangxin (U)<br>
&gt; &lt;<a href=3D"mailto:wangxinxin.wang@huawei.com" target=3D"_blank" re=
l=3D"noreferrer">wangxinxin.wang@huawei.com</a>&gt;; Huangweidong (C)<br>
&gt; &lt;<a href=3D"mailto:weidong.huang@huawei.com" target=3D"_blank" rel=
=3D"noreferrer">weidong.huang@huawei.com</a>&gt;<br>
&gt; Subject: Re: RFC: Split EPT huge pages in advance of dirty logging<br>
&gt; <br>
&gt; On Fri, Feb 21, 2020 at 2:08 PM Junaid Shahid &lt;<a href=3D"mailto:ju=
naids@google.com" target=3D"_blank" rel=3D"noreferrer">junaids@google.com</=
a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On 2/20/20 9:34 AM, Ben Gardon wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; FWIW, we currently do this eager splitting at Google for liv=
e<br>
&gt; &gt; &gt; migration. When the log-dirty-memory flag is set on a memslo=
t we<br>
&gt; &gt; &gt; eagerly split all pages in the slot down to 4k granularity.<=
br>
&gt; &gt; &gt; As Jay said, this does not cause crippling lock contention b=
ecause<br>
&gt; &gt; &gt; the vCPU page faults generated by write protection / splitti=
ng can<br>
&gt; &gt; &gt; be resolved in the fast page fault path without acquiring th=
e MMU lock.<br>
&gt; &gt; &gt; I believe +Junaid Shahid tried to upstream this approach at =
some<br>
&gt; &gt; &gt; point in the past, but the patch set didn&#39;t make it in. =
(This was<br>
&gt; &gt; &gt; before my time, so I&#39;m hoping he has a link.) I haven&#3=
9;t done the<br>
&gt; &gt; &gt; analysis to know if eager splitting is more or less efficien=
t with<br>
&gt; &gt; &gt; parallel slow-path page faults, but it&#39;s definitely fast=
er under the<br>
&gt; &gt; &gt; MMU lock.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I am not sure if we ever posted those patches upstream. Peter Fei=
ner would<br>
&gt; know for sure. One notable difference in what we do compared to the ap=
proach<br>
&gt; outlined by Jay is that we don&#39;t rely on tdp_page_fault() to do th=
e splitting. So we<br>
&gt; don&#39;t have to create a dummy VCPU and the specialized split functi=
on is also<br>
&gt; much faster.<br>
&gt; <br>
&gt; We&#39;ve been carrying these patches since 2015. I&#39;ve never poste=
d them.<br>
&gt; Getting them in shape for upstream consumption will take some work. I =
can look<br>
&gt; into this next week.<br>
<br>
Hi Peter Feiner,<br>
<br>
May I ask any new updates about your plan? Sorry to disturb.<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Hi Jay,</div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#=
39;ve been sick since I sent my last email, so I haven&#39;t gotten to this=
 patch set yet. I&#39;ll send it in the next week or two.=C2=A0</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Peter</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
Regards,<br>
Jay Zhou<br>
</blockquote></div></div></div>

--0000000000009134f8059fe1afb2--

