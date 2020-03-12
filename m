Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932ABC4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697332072F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="xO8T2f5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697332072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJqF-0005vs-KK
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 05:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jCJpQ-0004wz-9G
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jCJpP-0001hZ-22
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:08:32 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:33301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jCJpO-0001gz-Lo
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:08:31 -0400
Received: by mail-yw1-xc42.google.com with SMTP id g66so2663422ywf.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2ZCCB0V5ITmL3JLDCm0vrSVolfwJ+Ce2a9w1M1kLyZ8=;
 b=xO8T2f5sMrItuUNjGRSEzVQVl+ALve0Osbcr3EfXNIwdPhp6u1uSHN2TQQtdigfAdL
 mLWuwuI8TPZLUTMgu9sx0FDUMBPjs4CGMODTrsAl4GVsOFfSPfKpXpBfGHVKzxhyRAWH
 cowLzHOtBCn+ee6yFU2GxuFDY/6wrwHt4u4Z64kAPbSyTsci5rEvPhSf5vezQrSxGd9g
 x6FCRWct80zjqx2+7Jh3fmJCST5bdCHLlOuuOs2APSSK3p5dpv/G2K64tSDPGryZlDUI
 26o105YgL+jPyh5aarRj8Id8bh9OXrTt8mo77VvIgAIuIZ5ANV7wdVx3icXZtbavXwbG
 CkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2ZCCB0V5ITmL3JLDCm0vrSVolfwJ+Ce2a9w1M1kLyZ8=;
 b=PaJXy1p7A5ng7p0eKOrrKBBnVf6zZK3grI9823kbjTf4hIa+/PNmW2b+fRB5tlgA0D
 coOW0yIHyvtthEuOpuLgeTcvQ1jH3tvFGW590toAVlI8cAD9frdgRY+jZp/nU0jAZchx
 d104P7adW+i51HmBi26UmL6ocQM2dcJN1X0Td/TxPl28zFWlHbmhTQFCgDntCVGcokbc
 oLpgXvDD8JxuA1MxxV6reCXq8gmuTX+VjOJRVHE7Ywmc3EyqjCj2bXaLw0AW0esrvj0b
 OQcoBVdPGCNqzEUUgUibeFVC1KrSTYvwdP04jcvqQPVhilZRRYNhOfifCsv2nuoygmiL
 cwIw==
X-Gm-Message-State: ANhLgQ21NjIC7ZmGtUJx6tSsEapaautLWeEbOXUaAk8qV3vBO+5Gd1LC
 bo3fns7JPGfc/+sntsAsCnCfx5K3rB2DdwiVHEaqiQ==
X-Google-Smtp-Source: ADFU+vsbbzOZX/A8TAAZ/WABERSD4EO6Z+RJuPAwAyLXCqdXjlkjxslnlwKx4neOx/VwudqB3YPPd27MHP328k7mzHc=
X-Received: by 2002:a0d:ca4e:: with SMTP id m75mr7449743ywd.36.1584004109619; 
 Thu, 12 Mar 2020 02:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-2-yuri.benditovich@daynix.com>
 <20200311094553-mutt-send-email-mst@kernel.org>
 <CAOEp5OdgDB5u-SeZO3y4iCTjFy6hpNfPA-ADaBbnvx=MHD_dTw@mail.gmail.com>
 <20200311161819-mutt-send-email-mst@kernel.org>
 <CAOEp5OcrWewBYNT8TT6r1oFc=diq-HoGfe-zXwXPNSP0RguFkQ@mail.gmail.com>
 <20200312031427-mutt-send-email-mst@kernel.org>
 <CAOEp5Od=GW1onOqchw3H8nYSUByuekYCvi6jsWO8v9SYiFF27Q@mail.gmail.com>
 <20200312042252-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200312042252-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 12 Mar 2020 11:08:20 +0200
Message-ID: <CAOEp5OdEAku2EZncVKVOHk++0GwMyUiNOGDA22_7S8Whcekqaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] virtio-net: introduce RSS and hash report features
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000046e7e405a0a4b22c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000046e7e405a0a4b22c
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 12, 2020 at 10:23 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Mar 12, 2020 at 09:42:20AM +0200, Yuri Benditovich wrote:
> >
> >
> > On Thu, Mar 12, 2020 at 9:21 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Thu, Mar 12, 2020 at 09:02:38AM +0200, Yuri Benditovich wrote:
> >     >     >     > +#define virtio_net_config virtio_net_config_with_rss
> >     >     >
> >     >     >     Do we have to? Let's just tweak code to do the right
> thing...
> >     >     >
> >     >     >
> >     >     > Are we going to update the virtio_net some time?
> >     >     > If yes, IMO makes sense to do less tweaking in the middle of
> the
> >     code.
> >     >     > Then, upon update of virtio_net.h - easily remove all these
> defines
> >     that
> >     >     were
> >     >     > added in virtio-net.c
> >     >
> >     >     We'll update it in a month or two. But I'd be reluctant to
> merge
> >     hacks
> >     >     since people tend to copy-paste code ...
> >     >
> >     >
> >     > I agree that merging hacks is very bad practice.
> >     > Which change is more looks like a hack: redefine the struct to its
> _real_
> >     > layout or change the type of the struct in 5 places?
> >
> >     Anything that would be unacceptable as a permanent solution is a
> hack.
> >     In this case how about
> >             virtio_net_config_rss {
> >                     struct virtio_net_config config;
> >                     /* RSS things */
> >             }
> >
> >
> > No problem.
> >
> > '#define virtio_net_config virtio_net_config_with_rss ' is OK?
> >
>
> I don't think it is, macros are supposed to be all upper case.
>

Michael, just tell me please what you want:
You prefer to change everywhere ' virtio_net_config' to
'virtio_net_config_rss' and two month later to change it back?
You prefer to change everywhere  ' virtio_net_config'  to
'VIRTIO_NET_CONFIG' and define it according to the needs?
Something other?





>
> >
> >
> >
> >     --
> >     MST
> >
> >
>
>

--00000000000046e7e405a0a4b22c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12, 2020 at 10:23 AM Mich=
ael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, =
Mar 12, 2020 at 09:42:20AM +0200, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Mar 12, 2020 at 9:21 AM Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Mar 12, 2020 at 09:02:38AM +0200, Yuri Bend=
itovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt=
; +#define virtio_net_config virtio_net_config_with_rss<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Do =
we have to? Let&#39;s just tweak code to do the right thing...<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Are we going to update=
 the virtio_net some time?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; If yes, IMO makes sens=
e to do less tweaking in the middle of the<br>
&gt;=C2=A0 =C2=A0 =C2=A0code.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; Then, upon update of v=
irtio_net.h - easily remove all these defines<br>
&gt;=C2=A0 =C2=A0 =C2=A0that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0were<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; added in virtio-net.c=
=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0We&#39;ll update it in a mo=
nth or two. But I&#39;d be reluctant to merge<br>
&gt;=C2=A0 =C2=A0 =C2=A0hacks<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0since people tend to copy-p=
aste code ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I agree that merging hacks is very bad practic=
e.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Which change is more looks like a hack: redefi=
ne the struct to its _real_<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; layout or change the type of the struct in 5 p=
laces?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Anything that would be unacceptable as a permanent =
solution is a hack.<br>
&gt;=C2=A0 =C2=A0 =C2=A0In this case how about<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_config_rss {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct virtio_net_config config;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* RSS things */<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; <br>
&gt; No problem.<br>
&gt; <br>
&gt; &#39;#define virtio_net_config virtio_net_config_with_rss &#39; is OK?=
<br>
&gt; <br>
<br>
I don&#39;t think it is, macros are supposed to be all upper case.<br></blo=
ckquote><div><br></div><div>Michael, just tell me please what you want:</di=
v><div>You prefer to change everywhere &#39;

virtio_net_config&#39; to &#39;virtio_net_config_rss&#39; and two month lat=
er to change it back?</div><div>You prefer to change everywhere=C2=A0

&#39;

virtio_net_config&#39;=C2=A0 to &#39;VIRTIO_NET_CONFIG&#39; and define it a=
ccording to the needs?</div><div>Something other?</div><div>=C2=A0<br></div=
><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A0MST<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000046e7e405a0a4b22c--

