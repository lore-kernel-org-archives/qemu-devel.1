Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 04:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D6720885
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 04:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U50AIHdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D6720885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWuLZ-0001Xi-93
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 00:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kWuKV-0000y5-F7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 00:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kWuKS-0004qG-Um
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 00:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603687313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WjVX+3Jur5SctexiqjWEpCCtsSwjXyWYrcdnTbu4uig=;
 b=U50AIHdGwRP0nR+Gy9jqdcNICLzY97jKDEyS269PVrc12I/SrTsxmvKHntGPpoKmnZ0sNo
 /bARloqc/AsayMWUqRs/+04vpvY5p/Vzm+NCffaY0BpmqbAOavvdOY2owUmY8LZLsHNneN
 3H7A5EXK7NtPZonKQTJd+4ZnSb3lxEk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Y_yaC-DXMyWHnUXYV3Pvlg-1; Mon, 26 Oct 2020 00:41:43 -0400
X-MC-Unique: Y_yaC-DXMyWHnUXYV3Pvlg-1
Received: by mail-pf1-f198.google.com with SMTP id f15so4949995pfj.19
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 21:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WjVX+3Jur5SctexiqjWEpCCtsSwjXyWYrcdnTbu4uig=;
 b=VS5Xda96Nax3wsCbNj4OrSvneeiafoXXwJwJwXYmRT+SbOEXohw0Iwtaycg7GY+tdm
 1xq7Tvt7i5vI97YpC7tzSMK3Uyr3au8GApiUGFXnQ5FBybrVeRMHUnknVN/w4P9bDMFh
 YSZH2xGhR50LR6fQovmuszrC7Wt5IvzVc/WF6Ahy7kMRHw77QRXDGb2qFE44q0k7Amxb
 1I9Wq7Kp1AJEfVkt6uvbIt/tuD5NcXim0ylrtTh7eIv77iP+pLOnfyTzDryRtBOFloEV
 OEBGRzEyp1cCSNNJ1il4L9XH6JHGAexhROzin8GoKFSOH6f2T6iddQvo5Jsc1CHc4MW7
 HIGQ==
X-Gm-Message-State: AOAM530oKsv8tJ+slaoUCwsc9xLsnCie/CVSW2HWzEOYmcahQ8cARu3e
 sE1RyVWNTjcsLNRW+tni5o6jRIJ08U0woFug2a+28TUM2lW8fHVqiRMEpA7yZ0Q2G+4OWFf7/Oo
 ATriuWhkTuBaKAEuyRBJZ3XYKlHFMGfc=
X-Received: by 2002:a17:90b:807:: with SMTP id
 bk7mr14236187pjb.166.1603687302207; 
 Sun, 25 Oct 2020 21:41:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZgnLHRXemzvDGWJD6xZvslhxPBv0pZ91r1wzUpre0Wx7AldDu1YDkmbTI8D0QrEM3eGFK+oyw7lVIuSd4gCE=
X-Received: by 2002:a17:90b:807:: with SMTP id
 bk7mr14236168pjb.166.1603687301921; 
 Sun, 25 Oct 2020 21:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201023091559.4858-1-lulu@redhat.com>
 <462e6df3-8a34-9cfb-0696-49481aba4d46@redhat.com>
 <1bd85488-7186-d869-9bc2-2536d23c1e78@redhat.com>
In-Reply-To: <1bd85488-7186-d869-9bc2-2536d23c1e78@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 26 Oct 2020 12:41:30 +0800
Message-ID: <CACLfguVsAtAe_KrKFH2wH+w62BbLahtRXU6nV53jFODPF6XxXw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Add check for mac address while peer is
 vdpa
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000f653b505b28b8b3a"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Tsirkin <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f653b505b28b8b3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi jason


On Mon, Oct 26, 2020 at 11:20 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/10/26 =E4=B8=8A=E5=8D=8810:43, Jason Wang wrote:
> >
> > On 2020/10/23 =E4=B8=8B=E5=8D=885:15, Cindy Lu wrote:
> >> Sometime vdpa get an all 0 mac address from the hardware, this will
> >> cause the traffic down
> >> So we add the check for this part.
> >> if we get an 0 mac address we will use the default mac address instead
> >>
> >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >> ---
> >>   hw/net/virtio-net.c | 7 ++++++-
> >>   1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 9179013ac4..f1648fc47d 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -126,6 +126,7 @@ static void virtio_net_get_config(VirtIODevice
> >> *vdev, uint8_t *config)
> >>       VirtIONet *n =3D VIRTIO_NET(vdev);
> >>       struct virtio_net_config netcfg;
> >>       NetClientState *nc =3D qemu_get_queue(n->nic);
> >> +    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> >>         int ret =3D 0;
> >>       memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> >> @@ -151,7 +152,11 @@ static void virtio_net_get_config(VirtIODevice
> >> *vdev, uint8_t *config)
> >>           ret =3D vhost_net_get_config(get_vhost_net(nc->peer),
> >> (uint8_t *)&netcfg,
> >>                                      n->config_size);
> >>           if (ret !=3D -1) {
> >> -            memcpy(config, &netcfg, n->config_size);
> >> +            if (memcmp(&netcfg.mac, &zero, sizeof(zero)) !=3D 0) {
> >> +                memcpy(config, &netcfg, n->config_size);
> >> +        } else {
> >> +                error_report("Get an all zero mac address from
> >> hardware");
> >> +            }
> >>           }
> >>       }
> >>   }
> >
> >
> > Applied.
> >
> > Thanks
> >
> >
>
> Speak too fast. Some questions:
>
> 1) Any reason that you do such check or get_config() instead of doing it
> once in device initalization
>
get_config()  was called before the device realized.  If we check in the
device initalization, the mac address is already overwritten to 0 and
we lost the default mac address
Also for my understanding. the mac address read from hardware should never
been 0, so we need to check it every time we got it, Just in case it will
change to 0 and overwrite the mac address while the qemu running or some
other case

> 2) the indentation looks wrong
>
sure will fix this

> 3) There's no need for an error here since we can workaround it

sure, I will change it to log

>
>


> Thanks
>
>

--000000000000f653b505b28b8b3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi jason=C2=A0<div><br></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct =
26, 2020 at 11:20 AM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com">=
jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
On 2020/10/26 =E4=B8=8A=E5=8D=8810:43, Jason Wang wrote:<br>
&gt;<br>
&gt; On 2020/10/23 =E4=B8=8B=E5=8D=885:15, Cindy Lu wrote:<br>
&gt;&gt; Sometime vdpa get an all 0 mac address from the hardware, this wil=
l <br>
&gt;&gt; cause the traffic down<br>
&gt;&gt; So we add the check for this part.<br>
&gt;&gt; if we get an 0 mac address we will use the default mac address ins=
tead<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.com" tar=
get=3D"_blank">lulu@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 hw/net/virtio-net.c | 7 ++++++-<br>
&gt;&gt; =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt;&gt; index 9179013ac4..f1648fc47d 100644<br>
&gt;&gt; --- a/hw/net/virtio-net.c<br>
&gt;&gt; +++ b/hw/net/virtio-net.c<br>
&gt;&gt; @@ -126,6 +126,7 @@ static void virtio_net_get_config(VirtIODevice=
 <br>
&gt;&gt; *vdev, uint8_t *config)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtIONet *n =3D VIRTIO_NET(vdev);<=
br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct virtio_net_config netcfg;<br=
>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NetClientState *nc =3D qemu_get_que=
ue(n-&gt;nic);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 static const MACAddr zero =3D { .a =3D { 0, 0,=
 0, 0, 0, 0 } };<br>
&gt;&gt; =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&amp;netcfg, 0 , sizeof(stru=
ct virtio_net_config));<br>
&gt;&gt; @@ -151,7 +152,11 @@ static void virtio_net_get_config(VirtIODevic=
e <br>
&gt;&gt; *vdev, uint8_t *config)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D vho=
st_net_get_config(get_vhost_net(nc-&gt;peer), <br>
&gt;&gt; (uint8_t *)&amp;netcfg,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 n-&gt;config_size);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=
=3D -1) {<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy(config, &amp;netcfg, n-&gt;config_size);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (memcmp(&amp;netcfg.mac, &amp;zero, sizeof(zero)) !=3D 0) {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(config, &amp;netcfg, n-&gt;config_size);=
<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report(&quot;Get an all zero mac address =
from <br>
&gt;&gt; hardware&quot;);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt; =C2=A0 }<br>
&gt;<br>
&gt;<br>
&gt; Applied.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt;<br>
<br>
Speak too fast. Some questions:<br>
<br>
1) Any reason that you do such check or get_config() instead of doing it <b=
r>
once in device initalization<br></blockquote><div>get_config()=C2=A0 was ca=
lled before the device realized.=C2=A0 If we check in the  device initaliza=
tion, the mac address is already overwritten=C2=A0to 0 and we=C2=A0lost the=
 default mac address</div><div>Also for my understanding. the mac address r=
ead from hardware should=C2=A0never been 0, so we need to check it every ti=
me we got it, Just in case it will change to 0 and overwrite the mac addres=
s while the qemu running or some other case=C2=A0=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
2) the indentation looks wrong<br></blockquote><div>sure will fix this=C2=
=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
3) There&#39;s no need for an error here since we can workaround it</blockq=
uote><div>sure, I will change it to log</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">=C2=A0<br></blockquote><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
Thanks<br>
<br>
</blockquote></div></div>

--000000000000f653b505b28b8b3a--


