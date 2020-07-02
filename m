Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0434C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0A620780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpGLQw8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0A620780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxTm-0008Aa-PM
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqxIv-0004hd-PS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:22:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqxIu-0005uN-5a
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593688975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glITbbIFjSdFWE2tOz0GOAbU9DGa51+5b4U4Sz1oLYs=;
 b=RpGLQw8bogbQ6pNU94BVNEojLX+KBTTfox09yzKFrCdVdkQ7PSvmag2rF1BNDvMbNwk1Ur
 s90nmpeYeh2RLXAECMvrXg4pAWLnt2SweSU6Iyagbn4QQWrJJ6Y96JSeKCPy9P7FRlC/jf
 TPgLX9h0WncD/40UtYDGs5smoCFtblc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-yqSiduS8NeqFHUo32iiaUw-1; Thu, 02 Jul 2020 07:22:54 -0400
X-MC-Unique: yqSiduS8NeqFHUo32iiaUw-1
Received: by mail-wm1-f69.google.com with SMTP id t145so28402585wmt.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 04:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=glITbbIFjSdFWE2tOz0GOAbU9DGa51+5b4U4Sz1oLYs=;
 b=ZUfGYVdUuPknR0KxJmqO6bwUtvf8l2F0V5TejVbb0agwrtXt+7Nt7pvLgD/51Z91XH
 iJmr8NgkfzHD0VpuhFUOaURSfsYHr0LhSpgylCBOqxJ+HuMdFRlxRUvYUB8U9UPiiBDh
 XNam5PKeUTu+HF7Rd0HQRfvmNrUQmUrtHOAKBFbOD3pmPN4XloiOQM8NvW0qpR+MKkvg
 BjpHsrcaiNWtpUlNoVRCPogPJL1dpYtL8fupdS1A+geRiyPmwEbVXpFloui/WOzITF0A
 ru4yHWNwM6EOb9UOq9koZrYq23M1/d49Ldr+y/ocqG/g16T8I1ZjWg0NtGuYvPqk+5QW
 EfhQ==
X-Gm-Message-State: AOAM530KNMgUuQk1MJxlDYKZ6SDbH4/PNDPu6WzMithRszrRCM1jDnmD
 2tyszcMhnSjcAh3zro8bUnt/9drIYKsq8QaMz8v4KGIi+u+UQ37CiQeO2L6ZHqlUgfQDUQF4XUp
 IA+LGM40vpP5QJ8k=
X-Received: by 2002:a1c:8117:: with SMTP id c23mr29847574wmd.157.1593688972616; 
 Thu, 02 Jul 2020 04:22:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR7crz0nacv/vetwmKuOz8yhCMz690BDWcM7vk2nDXWJ0Czg75XQu/Z5oYC2yPGFMrATB93Q==
X-Received: by 2002:a1c:8117:: with SMTP id c23mr29847551wmd.157.1593688972397; 
 Thu, 02 Jul 2020 04:22:52 -0700 (PDT)
Received: from redhat.com ([93.157.82.4])
 by smtp.gmail.com with ESMTPSA id h84sm11037451wme.22.2020.07.02.04.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 04:22:51 -0700 (PDT)
Date: Thu, 2 Jul 2020 07:22:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200702071627-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200630121037.GC91444@stefanha-x1.localdomain>
 <20200630142504.688aa989.cohuck@redhat.com>
 <20200630090327-mutt-send-email-mst@kernel.org>
 <20200701181917.62538421.cohuck@redhat.com>
 <20200702060555-mutt-send-email-mst@kernel.org>
 <20200702124538.0ba5d334.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200702124538.0ba5d334.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Thu, Jul 02, 2020 at 12:45:38PM +0200, Cornelia Huck wrote:
> On Thu, 2 Jul 2020 06:16:06 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jul 01, 2020 at 06:19:17PM +0200, Cornelia Huck wrote:
> > > On Tue, 30 Jun 2020 09:04:38 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Tue, Jun 30, 2020 at 02:25:04PM +0200, Cornelia Huck wrote:  
> > >   
> > > > > What bothers me most is that you need to explicitly request a device to
> > > > > be modern-only, while that should be the default for any newly added
> > > > > device. Hence the approach with the centralized list of device types
> > > > > mentioned in a parallel thread. The main problem with that is that the
> > > > > proxy device starts getting realized before the virtio device with its
> > > > > id is present... I failed to find a solution so far. But I'd really
> > > > > like an approach that can work for all transports.    
> > > > 
> > > > So how about simply validating that the device is modern only,
> > > > unless it's one of the whitelist?  
> > > 
> > > Who would do the validation, the virtio core? How can it distinguish
> > > between transitional and non-transitional? But maybe I'm just not
> > > getting your idea.  
> > 
> > OK I've been thinking about two ideas, we can use them both:
> > 1. virtio core: that can detect VIRTIO_1 being clear
> > in virtio_validate_features.
> 
> After feature negotiation is complete? That feels like a regression in
> behaviour: You would be able to add a device that may not be usable
> (and you'll only find out after the guest tried to use it), instead of
> making sure that only a non-transitional device can be added to start
> with.

I mean, we can still have transports validate, that is point 2.
It seems prudent to check though, since guest could be buggy
ignoring bits that it got.

> (We do not validate if the guest did not negotiate VERSION_1, but we
> can certainly add a special case for the "guest did not accept offered
> VERSION_1" case.)

exaclty.

> 
> > 2. transports: could use a core API to detect whether
> > device can be a legacy one, to block device creation.
> 
> That would be the best, but how do we get around the "transport does
> not know the device type until it is too late" problem? Unless you want
> to redo the internal interfaces.

Oh. I think I am missing something.
So I'm considering virtio_pci_device_plugged for example.


static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
{
    VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
    VirtioBusState *bus = &proxy->bus;
    bool legacy = virtio_pci_legacy(proxy);
    bool modern;
    bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
    uint8_t *config;
    uint32_t size;
    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);

    /*

..

}

can't we check device type here and make sure it matches the "legacy"
flag?



> > 
> > 
> > > Also, ccw does not currently have a way to explicitly configure a
> > > device non-transitional; the revisions can be used to fence off newer
> > > features, going down to legacy-only, but fencing off older features is
> > > not possible (that is only done by the device, if it has no legacy
> > > support).  
> > 
> > I guess for ccw only option 1 works.
> > 
> 
> Or keep it as-is, and disallow legacy for the individual device types,
> with the validate check as a safety net during development.

Problem is people cut and paste from transitional devices.


-- 
MST


