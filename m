Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8737C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 02:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D392070E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 02:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1zfntrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D392070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtiSs-0001XH-OK
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 22:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jtiSJ-00018O-Vx
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 22:08:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36848
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jtiSH-0000kc-2t
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 22:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594346878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=klZ/SYEfFfZ9p7WW3ljBmx4ZXE5dn8I/W9Vms1/FYk0=;
 b=R1zfntrqomQROrAYbd/90lLY6VPhd0K9LZhpIr2V6cCpiOS2heNYt72GGJjpEWR55mieIm
 7yf4V7pWeSU10nRRQ3UkyTqj8Pksg0lBW19xLv0deqzeABV8D5aIkKyRxGGzYuohxhzxML
 nbtWk1sVlcm7tDCy5oPGL7VPlCoyUmQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-JDo39rXgODmn2-bjD1sK3w-1; Thu, 09 Jul 2020 22:07:56 -0400
X-MC-Unique: JDo39rXgODmn2-bjD1sK3w-1
Received: by mail-pl1-f198.google.com with SMTP id v8so2504001plo.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 19:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=klZ/SYEfFfZ9p7WW3ljBmx4ZXE5dn8I/W9Vms1/FYk0=;
 b=qHdKi8zwX0GvMV7sjeiIGJGfzgSQMX19N7Lb0E8f9oyLjC2siwErB8zIrhbP33dBoK
 TvVUNzjyIyAtsaZiGGYFIUxPesaevv5jlNYJLzqkpmmO06FcTrwEG/HxY/eqyvk6LYwf
 E7gKNX9NSNd3vbblU00gS7dy1CSMJMjd3gYamj+C3YKBw4WhrbPWj2Uu8yVZwZCA28lg
 FovvpTdDeEbsl3yMT98uO1FNaApGcpv68isqwGEQDNjKiRHTzNmtpMBz/z3Rza0gaXsz
 r1zyWm0mmDihx4BGvoli57czxf9bHNSwbU5VW18JeY6hKlvBYn5kIuWLiM44WKD9V9GT
 WDOQ==
X-Gm-Message-State: AOAM532bE/7ruYO5qpt201q9epALHpxb5kUeiMt2NpJS9sPP/Kw6rcbq
 GeL6U8zlrxLVCAG9m0CpXSWOf6d3aHcgEGXiWyf/GtTH4aciXyOo+OBnn4WLte/6fBIi/usgMQg
 3RUytC+nZ9oH2pcTPIE0lVpjjGkik770=
X-Received: by 2002:a17:90a:1d06:: with SMTP id
 c6mr3290937pjd.194.1594346875494; 
 Thu, 09 Jul 2020 19:07:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyIH021OfEe0CVT9e5kW7i+yK/fVHr/lweqJxILl+7tKCWwOsRZ7tM1JlO7JqdILqtoXDdqrIad7M7a+teUso=
X-Received: by 2002:a17:90a:1d06:: with SMTP id
 c6mr3290920pjd.194.1594346875256; 
 Thu, 09 Jul 2020 19:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200704182750.1088103-1-mst@redhat.com>
 <20200704182750.1088103-41-mst@redhat.com>
 <CAFEAcA-j5dgjCEEf7jOSYhezvzjQMZ0CiEaJJ8Xv1Zniq4VBZw@mail.gmail.com>
In-Reply-To: <CAFEAcA-j5dgjCEEf7jOSYhezvzjQMZ0CiEaJJ8Xv1Zniq4VBZw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 10 Jul 2020 10:07:44 +0800
Message-ID: <CACLfguWSP_=h9JPXfE7uqEzxEWWcnqWKpRuFSnLFkzYw3Snp5A@mail.gmail.com>
Subject: Re: [PULL v2 40/41] vhost-vdpa: introduce vhost-vdpa backend
To: Peter Maydell <peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000261b6605aa0ccfe9"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:07:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Lingshan zhu <lingshan.zhu@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Tiwei Bie <tiwei.bie@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000261b6605aa0ccfe9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2020=E5=B9=B47=E6=9C=889=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:15=E5=86=99=E9=81=93=EF=BC=
=9A

> On Sat, 4 Jul 2020 at 19:31, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Cindy Lu <lulu@redhat.com>
> >
> > Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> > vhost-user. The above patch provides a generic device for vDPA purpose,
> > this vDPA device exposes to user space a non-vendor-specific
> configuration
> > interface for setting up a vhost HW accelerator, this patch set
> introduces
> > a third vhost backend called vhost-vdpa based on the vDPA interface.
> >
> > Vhost-vdpa usage:
> >
> > qemu-system-x86_64 -cpu host -enable-kvm \
> >     ......
> >     -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-id,id=3Dvhost-=
vdpa0 \
> >     -device virtio-net-pci,netdev=3Dvhost-vdpa0,page-per-vq=3Don \
>
> Hi; Coverity reports some issues with this change:
>
>
> > +static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwadd=
r
> size,
> > +                              void *vaddr, bool readonly)
> > +{
> > +    struct vhost_msg_v2 msg;
> > +    int fd =3D v->device_fd;
> > +    int ret =3D 0;
> > +
> > +    msg.type =3D v->msg_type;
> > +    msg.iotlb.iova =3D iova;
> > +    msg.iotlb.size =3D size;
> > +    msg.iotlb.uaddr =3D (uint64_t)vaddr;
> > +    msg.iotlb.perm =3D readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
> > +    msg.iotlb.type =3D VHOST_IOTLB_UPDATE;
> > +
> > +    if (write(fd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
>
> Here we write the contents of the struct down the pipe,
> but we have not initialized all its fields; specifically,
> msg.reserved is not initialized and so those bytes will
> be random. We'll also transfer random contents from the
> stack in the padding, potentially.
>
> This is CID 1420267.
>
> The easy fix is to zero-initialize the whole struct at the start:
>
>    struct vhost_msg_v2 msg =3D {};
>
>
> > +        error_report("failed to write, fd=3D%d, errno=3D%d (%s)",
> > +            fd, errno, strerror(errno));
> > +        return -EIO ;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
> > +                                hwaddr size)
> > +{
> > +    struct vhost_msg_v2 msg;
> > +    int fd =3D v->device_fd;
> > +    int ret =3D 0;
> > +
> > +    msg.type =3D v->msg_type;
> > +    msg.iotlb.iova =3D iova;
> > +    msg.iotlb.size =3D size;
> > +    msg.iotlb.type =3D VHOST_IOTLB_INVALIDATE;
> > +
> > +    if (write(fd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
> > +        error_report("failed to write, fd=3D%d, errno=3D%d (%s)",
> > +            fd, errno, strerror(errno));
> > +        return -EIO ;
> > +    }
>
> Same here (CID 1430270)
>
> > +
> > +    return ret;
> > +}
> > +
>
> thanks
> -- PMM
>
> Thank you Peter, I will fix this soon

--000000000000261b6605aa0ccfe9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =E4=BA=8E2020=E5=
=B9=B47=E6=9C=889=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:15=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Sat, 4 Jul 2020 at 19:31, Michael S. Tsirkin &lt;<a href=3D"mailto=
:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.com" target=3D"_blank=
">lulu@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Currently we have 2 types of vhost backends in QEMU: vhost kernel and<=
br>
&gt; vhost-user. The above patch provides a generic device for vDPA purpose=
,<br>
&gt; this vDPA device exposes to user space a non-vendor-specific configura=
tion<br>
&gt; interface for setting up a vhost HW accelerator, this patch set introd=
uces<br>
&gt; a third vhost backend called vhost-vdpa based on the vDPA interface.<b=
r>
&gt;<br>
&gt; Vhost-vdpa usage:<br>
&gt;<br>
&gt; qemu-system-x86_64 -cpu host -enable-kvm \<br>
&gt;=C2=A0 =C2=A0 =C2=A0......<br>
&gt;=C2=A0 =C2=A0 =C2=A0-netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdp=
a-id,id=3Dvhost-vdpa0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0-device virtio-net-pci,netdev=3Dvhost-vdpa0,page-pe=
r-vq=3Don \<br>
<br>
Hi; Coverity reports some issues with this change:<br>
<br>
<br>
&gt; +static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwad=
dr size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *vaddr, bool readonly)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_msg_v2 msg;<br>
&gt; +=C2=A0 =C2=A0 int fd =3D v-&gt;device_fd;<br>
&gt; +=C2=A0 =C2=A0 int ret =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 msg.type =3D v-&gt;msg_type;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.iova =3D iova;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.size =3D size;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.uaddr =3D (uint64_t)vaddr;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.perm =3D readonly ? VHOST_ACCESS_RO : VHOST_A=
CCESS_RW;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.type =3D VHOST_IOTLB_UPDATE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (write(fd, &amp;msg, sizeof(msg)) !=3D sizeof(msg)) =
{<br>
<br>
Here we write the contents of the struct down the pipe,<br>
but we have not initialized all its fields; specifically,<br>
msg.reserved is not initialized and so those bytes will<br>
be random. We&#39;ll also transfer random contents from the<br>
stack in the padding, potentially.<br>
<br>
This is CID 1420267.<br>
<br>
The easy fix is to zero-initialize the whole struct at the start:<br>
<br>
=C2=A0 =C2=A0struct vhost_msg_v2 msg =3D {};<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;failed to write, fd=3D=
%d, errno=3D%d (%s)&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd, errno, strerror(errno))=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO ;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct vhost_msg_v2 msg;<br>
&gt; +=C2=A0 =C2=A0 int fd =3D v-&gt;device_fd;<br>
&gt; +=C2=A0 =C2=A0 int ret =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 msg.type =3D v-&gt;msg_type;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.iova =3D iova;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.size =3D size;<br>
&gt; +=C2=A0 =C2=A0 msg.iotlb.type =3D VHOST_IOTLB_INVALIDATE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (write(fd, &amp;msg, sizeof(msg)) !=3D sizeof(msg)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;failed to write, fd=3D=
%d, errno=3D%d (%s)&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd, errno, strerror(errno))=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO ;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Same here (CID 1430270)<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
<br>
thanks<br>
-- PMM<br>
<br></blockquote><div>Thank you Peter, I will fix this soon=C2=A0</div></di=
v></div>

--000000000000261b6605aa0ccfe9--


