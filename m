Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207DCC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DBB25268
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkXR0APb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DBB25268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpw0C-0000yB-4J
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jpvyk-0007eq-KU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:45:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jpvyi-0005cp-Bw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593445550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZZtBcmf2BCAT9zQRM+mDlc4lUDY6h1McyLuc5cCZ2w=;
 b=HkXR0APbP14DZH0ZU5kBLjBMcCoXqJTqk+JDa25VJfxXdzK5g64Ybydz09srNEOSz9I4Fy
 IhF8OQfmw7nqHv0/dB15ZQ9kTpCyK2TuvwLfCa5Xg1gQfVkmvXURF94wlQY6JChxHi/Tnt
 mh3iBzJkOdoVA4PGfzmkOWsTF3BHZCo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-_YqwhUDkMq-zLdncyZxrVA-1; Mon, 29 Jun 2020 11:45:41 -0400
X-MC-Unique: _YqwhUDkMq-zLdncyZxrVA-1
Received: by mail-wr1-f72.google.com with SMTP id o12so16609220wrj.23
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wZZtBcmf2BCAT9zQRM+mDlc4lUDY6h1McyLuc5cCZ2w=;
 b=IpFoUVkf/6bRB9ohCyW9KJ57ajDH3+R8wEoiAYVfzUHZEiaRkFzJsr7ccPEs5tFyOG
 DvVGGkp7tDD70kyZ3SYda2KzR2QqhTQi5BUNU5egVSrMQXwm9QJmigEb/Hm1pyGAk3xo
 RzDEbqG2iucdg+PMgfc+0I48ZjPHYp4CN3ZE4ozRVIs8hcjRPxtsS1Mfe6asgTRgq6vB
 fYryCfMTl2o8ARgE6kZmVfLTKHj5vQKN5imvLYThoDUBlk4S3SwD4snoHmpgjpLhbUvq
 7pjeEIxJcbQ4YngJRFtG3QArRXT07Jzce+j6E0BDG79dU2VL2tvSAtFn+HhCBhhgc3To
 4m7Q==
X-Gm-Message-State: AOAM532lWeTVYwigfMUeSt59fbfYEdpphF1nsE02PQE9365uxBfYNdPC
 07btMl5ynY1zXNhp1j8Q8eavjSR/6uWnaRe3Qed8KJnKkkJJrjOsB8kDLti2l/R7jpFf0xdU0aN
 7voPQ/Md1VnbaGeY=
X-Received: by 2002:a1c:7fd7:: with SMTP id
 a206mr17246969wmd.104.1593445540414; 
 Mon, 29 Jun 2020 08:45:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvqR5iThZ7ct+VvOQ41Yo9V23fSM1Ll8ePqCPMYwHJB3aYLs+MERJte2n4SgvyhFPPI2ig7g==
X-Received: by 2002:a1c:7fd7:: with SMTP id
 a206mr17246947wmd.104.1593445540105; 
 Mon, 29 Jun 2020 08:45:40 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 207sm278946wme.13.2020.06.29.08.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 08:45:38 -0700 (PDT)
Date: Mon, 29 Jun 2020 11:45:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200629114515-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200629104948-mutt-send-email-mst@kernel.org>
 <20200629173933.35cea40f.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629173933.35cea40f.cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:10:03
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 05:39:33PM +0200, Cornelia Huck wrote:
> On Mon, 29 Jun 2020 10:53:23 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jun 29, 2020 at 12:27:58PM +0200, Cornelia Huck wrote:
> > > virtio-fs devices are only specified for virtio-1, so it is unclear
> > > how a legacy or transitional device should behave.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > > 
> > > Forcing off legacy now (after the virtio-fs device has already been
> > > available) may have unintended consequences, therefore RFC.
> > > 
> > > By default, a virtio-pci device uses 'AUTO' for disable_legacy, which
> > > will resolve to different values based upon which bus the device has
> > > been plugged. Therefore, forcing disable_legacy may result in the same
> > > device or a quite different one.
> > > 
> > > Even though pre-virtio-1 behaviour of virtio-fs devices is simply not
> > > specified, toggling disable_legacy will have implications for the BAR
> > > layout, IIRC, and therefore a guest might end up getting a different
> > > device, even if it always used it with virtio-1 anyway.
> > > 
> > > Not sure what the best way to solve this problem is. Adding a compat
> > > property for disable_legacy=AUTO may be the right thing to do, but I'm
> > > not quite clear if there are any further implications here.  
> > 
> > Well I notice that this device is not migrateable.
> > So I think that we can just switch it over and be done with it.
> 
> Oh, that makes things easier. (I'm wondering if libvirt already
> configures this correctly?)
> 
> > 
> > 
> > > Whatever we do here, we should make sure that the ccw incarnation of
> > > this device indeed forces virtio-1.  
> > 
> > I agree. I notice that the API virtio_pci_force_virtio_1 turned out
> > to be too fragile. I propose that instead we have a whitelist of
> > devices which can be legacy or transitional. Force rest to modern.
> 
> Also, there are further complications because the mechanism is per
> transport, and therefore easy to miss.
> 
> bool virtio_legacy_allowed(VirtIODevice *vdev)
> {
>     switch (vdev->device_id) {
>     case <...>:
>     <list of legacy-capable devices>
>         return true;
>     default:
>         return false;
> }
> 
> Seems straightforward enough.


Agreed. virtio spec has the list.

> > 
> > 
> > > ---
> > >  hw/virtio/vhost-user-fs-pci.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
> > > index e11c889d82b3..244205edf765 100644
> > > --- a/hw/virtio/vhost-user-fs-pci.c
> > > +++ b/hw/virtio/vhost-user-fs-pci.c
> > > @@ -44,6 +44,7 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> > >          vpci_dev->nvectors = dev->vdev.conf.num_request_queues + 2;
> > >      }
> > >  
> > > +    virtio_pci_force_virtio_1(vpci_dev);
> > >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> > >  }
> > >  
> > > -- 
> > > 2.25.4  
> > 


