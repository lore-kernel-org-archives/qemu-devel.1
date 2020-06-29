Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A052C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1119523158
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5BzOnqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1119523158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpnpK-0005H6-Cn
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 03:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpnok-0004p3-6z
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:03:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38334
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpnoi-0007hz-Ir
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593414179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wa8BCnBCUeXIgiVX5ZajiubVXjNmeHL+8/uwUF1dJP0=;
 b=N5BzOnqevGepWWnteRZMsu2/Ek7pHMG8ajmxftbV67qmyl2TFA/nNg2NRlttFnAi3icojL
 yqQeb2kN7bDGorH5fyLLuxS1HcnzZ0aN/WhhfxsLEJiKdSngsJKEcZhQ5KxJVYoHMVMWvH
 B1KMHICHGpMAJgSls6sWCIp916uK61Q=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-OXRq2LV-NYa1dKM7Jalf7w-1; Mon, 29 Jun 2020 03:02:55 -0400
X-MC-Unique: OXRq2LV-NYa1dKM7Jalf7w-1
Received: by mail-pg1-f198.google.com with SMTP id 75so8109803pga.20
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 00:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wa8BCnBCUeXIgiVX5ZajiubVXjNmeHL+8/uwUF1dJP0=;
 b=bL1Gdcx/CC3cROOpOx56W4K3U5Jd7pYEXAof4NQDcbF13uXLDpSTmjrVtLD0nVEjO4
 VUbLwF1ug1MLytu4UFGsLUvjFTjUkrzurCRfiIXIL2RwabUoMzWZg2excPBuG5OzWTQv
 Q8QrbeVetyu4oEcONtiinLL/4hfQqwn5cjKehS4rsWOJEQRjd0356QanmzXo8yD+EbSL
 P3dj0QvykLWvACuqM8oXeuOUcsrhPkk8M/aovgQaV1ww1RbhEp/X85Lpjw2tM0so3HtZ
 MzG1BmEHD42a91l1AcrvKpbKRtJ8FO7qY9juUPla7xQA341reva7qsDGWyybUQUFthZn
 vXbA==
X-Gm-Message-State: AOAM531xypZI+dKko0vMo7fhaegE07NptdrJGUSEbM8X+YrdoFug0o2N
 03HTtBuKaGR2vSeo+Ej7fwk5VnN1KeH1sa0UZHW/GPiYIGUBzPSusng3I5cLPCQU2DEC4wiF40R
 GIoGXHUSdA/3j5a0W8YKkFuCix+wpLoQ=
X-Received: by 2002:a17:90a:8a8b:: with SMTP id
 x11mr10542955pjn.127.1593414174296; 
 Mon, 29 Jun 2020 00:02:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAjeAGCXyvum/pX1Khp6oGviS52ccOWbYeY5pNFpLyZsmD8Sr8wDviUb6CYf8w1wG3nGKIHNrq2I8epzgtFD8=
X-Received: by 2002:a17:90a:8a8b:: with SMTP id
 x11mr10542937pjn.127.1593414174126; 
 Mon, 29 Jun 2020 00:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <20200622153756.19189-5-lulu@redhat.com>
 <2a5cf3dd-4dcd-e807-c28a-aaf2a901e8f8@redhat.com>
In-Reply-To: <2a5cf3dd-4dcd-e807-c28a-aaf2a901e8f8@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 29 Jun 2020 15:02:43 +0800
Message-ID: <CACLfguVGhK2Zo6zYpp6p-74D_ROsHnMQ3BPxSt6U=X7fFk_c_g@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] virtio-pci: implement queue_enabled method
To: Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 9:25 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 22/06/2020 17:37, Cindy Lu wrote:
> > From: Jason Wang <jasowang@redhat.com>
> >
> > With version 1, we can detect whether a queue is enabled via
> > queue_enabled.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 4cb784389c..3918aa9f6c 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1107,6 +1107,23 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
> >      return pci_get_address_space(dev);
> >  }
> >
> > +static bool  virtio_queue_check_enabled(VirtIODevice *vdev, int n)
> > +{
> > +    return  virtio_queue_get_desc_addr(vdev, n) != 0;
> > +}
>
> This function is already defined under a different name in
> hw/virtio/virtio.c:
>
>
>    3287 bool virtio_queue_enabled(VirtIODevice *vdev, int n)
>    3288 {
>    3289     return virtio_queue_get_desc_addr(vdev, n) != 0;
>    3290 }
>
> As this file includes "hw/virtio/virtio.h" you can use it directly.
>
Thanks Laurent, Will fix this
> Thanks,
> Laurent
>


