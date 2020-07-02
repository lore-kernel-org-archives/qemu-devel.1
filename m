Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9C1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4F42088E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbZDB8Br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4F42088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzBN-00026l-VE
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqzAe-0001ae-EE
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:22:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqzAc-00034w-HJ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593696149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kOKchWCsU9m3qyiSX5ZYSYb1UpvJi45eNR1o30K2pZc=;
 b=GbZDB8BrDJML5hznxakaixDJNylZc4qCOudQfLh2A+alXIWKOTmtq7Q1ECmpM971KaFABJ
 o+NWqhEyaNq9Ga53PGQOr3sMUs0isHVy3fe4Y5AyxrocLwVJ62ykNeMEFLWE6cYO3FbrJe
 SLIRdETwz+cbj6vrSYLq1FxxEmSLPZw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-t47vuU3hPRm6g4ALqjj_tw-1; Thu, 02 Jul 2020 09:22:28 -0400
X-MC-Unique: t47vuU3hPRm6g4ALqjj_tw-1
Received: by mail-wm1-f69.google.com with SMTP id f68so13568851wmf.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 06:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kOKchWCsU9m3qyiSX5ZYSYb1UpvJi45eNR1o30K2pZc=;
 b=J6cxd2GaaBeTeU8NvEsnGSwsB9Km6eBTsAMgt1cQUe+zE6d2BHGl7XBrVSFmwPANta
 kJ/OU1VyUIeOMxNOlThoAqRdxtmKSNwbjcObtH5z2G4BL2cxKHB896REj9fgmd6RWyJG
 TTuE6pHCHdtt1eBxMihFBBLGIKbLLOajEr7W7H0nctA/b6m5nJQwdSVpfWDo28dtd6kl
 FDhLG9BRXCz5/MURU5x5NfDpJBJoFGhtj/MCagveg58fUX36S9Sft9+TV5F5VJUSM1mM
 a2mJ95OeQN0l6YJK/Afo3FCphY8K3X9eYh421X7WML9yAcD5IyvFMIUXfPDuSEC+0K+j
 lS+Q==
X-Gm-Message-State: AOAM531L9sODmaB5FjI198yjzSY4bl09d1KHHoGNr73/i/xLNusAujkd
 nARc/xKobrjGv9oNC0MbEH0YEqTFa5eND6SLxAQRn+uQrK//s3bwFoVb5L03qVighb6s3CF00CA
 dg9t94R+7B+sK8QE=
X-Received: by 2002:adf:94a1:: with SMTP id 30mr2326341wrr.37.1593696142260;
 Thu, 02 Jul 2020 06:22:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJPmuszX68tqfE8LgYASyl/AFeFTWQvBXejhuLgMNVQVPWezhWXU/Xz2dZE/N5Vmp1vQ88Ag==
X-Received: by 2002:adf:94a1:: with SMTP id 30mr2326319wrr.37.1593696141988;
 Thu, 02 Jul 2020 06:22:21 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 y7sm10651991wrt.11.2020.07.02.06.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 06:22:20 -0700 (PDT)
Date: Thu, 2 Jul 2020 09:22:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200702091937-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200630121037.GC91444@stefanha-x1.localdomain>
 <20200630142504.688aa989.cohuck@redhat.com>
 <20200630090327-mutt-send-email-mst@kernel.org>
 <20200701181917.62538421.cohuck@redhat.com>
 <20200702060555-mutt-send-email-mst@kernel.org>
 <20200702124538.0ba5d334.cohuck@redhat.com>
 <20200702071627-mutt-send-email-mst@kernel.org>
 <20200702135559.761fb165.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200702135559.761fb165.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
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

On Thu, Jul 02, 2020 at 01:55:59PM +0200, Cornelia Huck wrote:
> On Thu, 2 Jul 2020 07:22:49 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Jul 02, 2020 at 12:45:38PM +0200, Cornelia Huck wrote:
> > > On Thu, 2 Jul 2020 06:16:06 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Wed, Jul 01, 2020 at 06:19:17PM +0200, Cornelia Huck wrote:  
> > > > > On Tue, 30 Jun 2020 09:04:38 -0400
> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > >     
> > > > > > On Tue, Jun 30, 2020 at 02:25:04PM +0200, Cornelia Huck wrote:    
> > > > >     
> > > > > > > What bothers me most is that you need to explicitly request a device to
> > > > > > > be modern-only, while that should be the default for any newly added
> > > > > > > device. Hence the approach with the centralized list of device types
> > > > > > > mentioned in a parallel thread. The main problem with that is that the
> > > > > > > proxy device starts getting realized before the virtio device with its
> > > > > > > id is present... I failed to find a solution so far. But I'd really
> > > > > > > like an approach that can work for all transports.      
> > > > > > 
> > > > > > So how about simply validating that the device is modern only,
> > > > > > unless it's one of the whitelist?    
> > > > > 
> > > > > Who would do the validation, the virtio core? How can it distinguish
> > > > > between transitional and non-transitional? But maybe I'm just not
> > > > > getting your idea.    
> > > > 
> > > > OK I've been thinking about two ideas, we can use them both:
> > > > 1. virtio core: that can detect VIRTIO_1 being clear
> > > > in virtio_validate_features.  
> > > 
> > > After feature negotiation is complete? That feels like a regression in
> > > behaviour: You would be able to add a device that may not be usable
> > > (and you'll only find out after the guest tried to use it), instead of
> > > making sure that only a non-transitional device can be added to start
> > > with.  
> > 
> > I mean, we can still have transports validate, that is point 2.
> > It seems prudent to check though, since guest could be buggy
> > ignoring bits that it got.
> > 
> > > (We do not validate if the guest did not negotiate VERSION_1, but we
> > > can certainly add a special case for the "guest did not accept offered
> > > VERSION_1" case.)  
> > 
> > exaclty.
> > 
> > >   
> > > > 2. transports: could use a core API to detect whether
> > > > device can be a legacy one, to block device creation.  
> > > 
> > > That would be the best, but how do we get around the "transport does
> > > not know the device type until it is too late" problem? Unless you want
> > > to redo the internal interfaces.  
> > 
> > Oh. I think I am missing something.
> > So I'm considering virtio_pci_device_plugged for example.
> > 
> > 
> > static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
> > {
> >     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
> >     VirtioBusState *bus = &proxy->bus;
> >     bool legacy = virtio_pci_legacy(proxy);
> >     bool modern;
> >     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
> >     uint8_t *config;
> >     uint32_t size;
> >     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> > 
> >     /*
> > 
> > ..
> > 
> > }
> > 
> > can't we check device type here and make sure it matches the "legacy"
> > flag?
> 
> It would be a change in behaviour: Currently, I can specify e.g.
> 
> -device virtio-gpu-pci,disable-legacy=off,disable-modern=true

I don't think we care about this at all.
User is explicitly asking for a non-compliant configuration,
user gets to keep both pieces.




> and the code in the realize function would force it to a modern-only
> device. Checking in the plugged function would cause it to fail. This
> might be preferable, but could break existing command lines.

> Note that ccw is different: if I specify
> 
> -device virtio-gpu-ccw,max_revision=0
> 
> it actually fails with
> 
> qemu-system-s390x: -device virtio-gpu-ccw,max_revision=0: Invalid value of property max_rev (is 0 expected >= 1)
> 
> so moving to the plugged function would not cause a change in behaviour
> from the user's point of view.
> 
> > 
> > 
> > 
> > > > 
> > > >   
> > > > > Also, ccw does not currently have a way to explicitly configure a
> > > > > device non-transitional; the revisions can be used to fence off newer
> > > > > features, going down to legacy-only, but fencing off older features is
> > > > > not possible (that is only done by the device, if it has no legacy
> > > > > support).    
> > > > 
> > > > I guess for ccw only option 1 works.
> > > >   
> > > 
> > > Or keep it as-is, and disallow legacy for the individual device types,
> > > with the validate check as a safety net during development.  
> > 
> > Problem is people cut and paste from transitional devices.
> 
> That should not be a problem for ccw (as transitional and
> non-transitional are the same on the command line); moreover, people
> are unlikely to set max_revision themselves (this is usually only done
> by compat machines).
> 
> If changing the behaviour for pci is acceptable, we can sure move to
> the plugged approach.


