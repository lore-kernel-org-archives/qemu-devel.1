Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E52C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3BA206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKtrdST2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3BA206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inUMQ-0003Xf-2A
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 16:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1inULo-00036m-VW
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1inULm-0008KY-7F
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:19:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47259
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1inULl-0008FO-Sa
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578086356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F+tgdWfjhUuWbIC4aYa2sI2tJO9KBcoynCGaF2Cjqvw=;
 b=GKtrdST2b4eph6F6UoF7ScniKVWMPTwF+V3e/vPyloykelYv0NEjkWNbWZQp8ajdzevPan
 YNUu3429ngxgUMayrk8SUZUvjk6j9iIlCySlmqjeiIoSjzzJomhtYlAGV3H78ZCRPmVGn1
 RulbiJQDJBSQkBSCzTvgqgQfeqeNiAE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-KHmnmpmQPLOSn_BBEUWitA-1; Fri, 03 Jan 2020 16:19:11 -0500
Received: by mail-ed1-f70.google.com with SMTP id v11so23423464edw.11
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 13:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7JbF2WXT/IQZJypA7NehdC4XcRnCjKx5BcmwH9wGSLo=;
 b=IltJMuwfCrDBTmzKCDfRUhgnPXSQMxC6xG7SIfc/fA3JCiYS264USZhYR/0HlD6S0c
 7jvpcozYhCpua68aL5hfG2lXH9v2fq0A3iqfSy2WM73EVjtycgMbhl6JDXeTpDQt2g5a
 vrl/pTctKa4ZIWiaOiZwZjozSisBkDGIIKByci7337JiOfSGzdM1wTrcb0s5dQAix6TE
 XtjTVWrIsfUDQJS/edeBEho6d5yIn9uSpFwCj9Wmqxb8U9KuMt4/u+iiGnXAKwJF4bMM
 mYvHaMn0reTQmocYYxsSH4uM7PaghxVTeEux3jXDouYUlJYGWkf7IWSy0FoGNeWNUp8z
 NaHA==
X-Gm-Message-State: APjAAAUF2mXZ2HnU4Nio9C+8fWOfzEBny3WB5SoObZSdu2Th3GJHjGz9
 xgbUk6/Uk78Ng88toBHwztEh0MohaxXSA7XySQAtdIYrHSjl/bf64Upm7PA98SysDMRNdMae+tc
 AwXNqIow0Dm6zwzGDL7ixmBuv+zVI5oU=
X-Received: by 2002:a17:906:560e:: with SMTP id
 f14mr95124509ejq.300.1578086350764; 
 Fri, 03 Jan 2020 13:19:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+UIz3hbDOwpnaqtfSTwNiQ/5+wklmBw1zBFQ4MqnFr3BfXGXTOCQxIZMt6cSO/T8uT4h109wzQ1h2siaEeCM=
X-Received: by 2002:a17:906:560e:: with SMTP id
 f14mr95124498ejq.300.1578086350567; 
 Fri, 03 Jan 2020 13:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20191223082813.28930-1-yang.zhong@intel.com>
 <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
 <20191223091856.GA8433@yangzhon-Virtual>
 <e13a5fcc-b861-1847-58a8-e3d6445f84b0@redhat.com>
 <20191223092508-mutt-send-email-mst@kernel.org>
 <187f02d9-1677-d232-a44a-ed7b1e5f6ee5@redhat.com>
 <20200103150145.GA24552@yangzhon-Virtual>
In-Reply-To: <20200103150145.GA24552@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 3 Jan 2020 22:18:58 +0100
Message-ID: <CABgObfZWq_d-R_j456yxipPnbcLzCOJwd=9mCBMiwHDOckaXYg@mail.gmail.com>
Subject: Re: [PATCH] virtio: add the queue number check
To: Yang Zhong <yang.zhong@intel.com>
X-MC-Unique: KHmnmpmQPLOSn_BBEUWitA-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="00000000000059d0d6059b42dccb"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000059d0d6059b42dccb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 3 gen 2020, 16:08 Yang Zhong <yang.zhong@intel.com> ha scritto:

>   I also tried virtio-blk device like below:
>   https://patchwork.kernel.org/cover/10873193/
>
>   The virtio-blk can work with this changes, but vhost-user-blk device
>   failed with this kernel patch.
>
>   in vhost_virtqueue_start() function, below operation to check if the
>   desc addr set by guest kernel. This will ignore the extra vqs.
>     a =3D virtio_queue_get_desc_addr(vdev, idx);
>     if (a =3D=3D 0) {
>         /* Queue might not be ready for start */
>         return 0;
>     }
>
>   If guest kernel add min(cpu,num_vqs), do we need add same check in
>   realize function of vhost-user-blk device?
>

No. If virtio-blk works, the bug is in vhost-user-blk; if virtio-blk needs
no check in cpu count, vhost-user-blk also doesn't.

You need to check first if the bug is in QEMU or the vhost-user-blk server.

Paolo

--00000000000059d0d6059b42dccb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 3 gen 2020, 16:08 Yang Zhong &lt;<a href=3D"mai=
lto:yang.zhong@intel.com">yang.zhong@intel.com</a>&gt; ha scritto:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">=C2=A0 I also tried virtio-blk device like =
below:<br>
=C2=A0 <a href=3D"https://patchwork.kernel.org/cover/10873193/" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">https://patchwork.kernel.org/cover/108=
73193/</a><br>
<br>
=C2=A0 The virtio-blk can work with this changes, but vhost-user-blk device=
<br>
=C2=A0 failed with this kernel patch.<br>
<br>
=C2=A0 in vhost_virtqueue_start() function, below operation to check if the=
<br>
=C2=A0 desc addr set by guest kernel. This will ignore the extra vqs.<br>
=C2=A0 =C2=A0 a =3D virtio_queue_get_desc_addr(vdev, idx);<br>
=C2=A0 =C2=A0 if (a =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Queue might not be ready for start */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 If guest kernel add min(cpu,num_vqs), do we need add same check in<b=
r>
=C2=A0 realize function of vhost-user-blk device?<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">No. If virtio-blk works, t=
he bug is in vhost-user-blk; if virtio-blk needs no check in cpu count, vho=
st-user-blk also doesn&#39;t.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">You need to check first if the bug is in QEMU or the vhost-user-blk s=
erver.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--00000000000059d0d6059b42dccb--


