Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A74C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1742083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rq4MHoRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1742083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaeih-0002NK-J0
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaegP-0008MY-JZ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaegN-00029P-Ol
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604580483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5CHl/S+hEiH2iWRd5Esm3bXGJPIg4kCDs2NWTHhwsxo=;
 b=Rq4MHoRUG0NKPsOmW07y64MmXs/b/M1OOPOQvia3JNRajGmvpPkyjobhOgIj1CA3s1w24V
 yKSmiOw6UZEbBtXYGg0itLKTkj03CwIYQriIfdNIbCpEYmNhFBX0D6euxFeHGuv8RewQq7
 3zAdlSUf8NHJ2Eqc4k7q4xhtR3AK22M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-ISga7qA9PE-dTR8Yq9-WDA-1; Thu, 05 Nov 2020 07:48:00 -0500
X-MC-Unique: ISga7qA9PE-dTR8Yq9-WDA-1
Received: by mail-wr1-f71.google.com with SMTP id e11so662388wrw.14
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5CHl/S+hEiH2iWRd5Esm3bXGJPIg4kCDs2NWTHhwsxo=;
 b=qM/7Xx582gkvMxTKBQ8eD5HExRDgqAZX2YrDJMjbKzgBZ//KBytn5dCr5zWxebT4np
 ZCv0fYDaENtkOfMMlYn+sKk2BsJ8cfn1CqQlI5HRnadsnCllYbUZo7tU7BL5wA2MzLAg
 XULsXgEwJcSO34nQg/s5b+qWKGCYQp0OM1pXGY/Qil0KE82RFGb8DlOxnQYy+hK1fn1+
 FyUB4rPPIZKCN2NAmT4OzSx0o6byX1wtGOBW0g+I+b20w0qdk7ymX0AwZRmHTfUtrmG6
 CMGPrWpt6r2roanGCLmC+C4O0swG5i5SB5ACyJ08EJzPjuO+dPWAakQ7P+cjOpD2s5kr
 VFVw==
X-Gm-Message-State: AOAM5311bWEl9HbbLYz215kXBUeFNVCdsvIx34T3jWnkVcw3B7+W9ydE
 0C9JbpXbyCH0++z4a4whxfJi3lWFX/eRfG5JmWlj3Dm+XUYsCWnKjFI/5fCsQv/bU9t5j3f5ROf
 bn7pyzy4M2qY2D9c=
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr2721676wrv.359.1604580479633; 
 Thu, 05 Nov 2020 04:47:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8ZhQlAjLnDPtymaIWyfi66lzsNE52AAs2lnmY88z5nb8NbvdCgryGOAmVrjhZJstThJmSoQ==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr2721662wrv.359.1604580479487; 
 Thu, 05 Nov 2020 04:47:59 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id o17sm2442851wmd.34.2020.11.05.04.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 04:47:58 -0800 (PST)
Date: Thu, 5 Nov 2020 07:47:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201105074428-mutt-send-email-mst@kernel.org>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103121709.GD3566@work-vm>
 <20201103152752.GC253848@stefanha-x1.localdomain>
 <20201103184951.GM3566@work-vm>
 <20201104073636.GB390503@stefanha-x1.localdomain>
 <20201104101423.GB3896@work-vm>
 <20201104164744.GC425016@stefanha-x1.localdomain>
 <20201104173202.GG3896@work-vm>
 <20201105114037.GC462479@stefanha-x1.localdomain>
 <20201105121324.GH3186@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201105121324.GH3186@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 05, 2020 at 12:13:24PM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Wed, Nov 04, 2020 at 05:32:02PM +0000, Dr. David Alan Gilbert wrote:
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > Michael replied in another sub-thread wondering if versions are really
> > > > necessary since tools do the migration checks. Let's try dropping
> > > > versions to simplify things. We can bring them back if needed later.
> > > 
> > > What does a user facing tool do?  If I say I want one of these NICs
> > > and I'm on the latest QEMU machine type, who sets all these parameters?
> > 
> > The machine type is orthogonal since QEMU doesn't know about every
> > possible VFIO device. The device is like a PCI adapter that is added to
> > a physical machine aftermarket, it's not part of the base machine's
> > specs.
> 
> OK, but ignoring migration, I think the same problem holds; if I'm a
> tool creating one of these VMs, and I plug this device in, what do I do
> with all it's configuration parameters?  I'd assume most of the time
> that they don't know about or dont care about most of the parameters,
> they just want the sane defaults unless told otherwise.

I think that if you ignore migration then you can ignore parameters.

> > The migration tool queries the parameters from the source device.
> > VFIO/mdev will provide sysfs attrs. For vfio-user I'm not sure whether
> > to print the parameters during device instantiation, require a
> > VFIO-compatible FUSE directory, or to use a query-migration-params RPC
> > command.
> 
> But on VM creation we have to answer the question of what config do we
> want; so for example lets say I'm creating a new VM in my cluster,
> but I want to be sure that later I can migrate it.  I can read the 
> config off one of the other machines;  can I just use that even if my
> new machine has a later device implementation?
> 
> Dave

I don't think so - we need a tool that can query a set of machines and then
produce a safe configuration.

The same problem exists with vhost as well it will just
explode exponentially with lots more devices and backends ...
Talked about it a bit in my kvm forum preso ...

> > Let's discuss this more when the next revision of the document is sent
> > out, because it modifies the approach so that migration parameters are
> > logically separate from device configuration parameters. That changes
> > things a bit.
> > 
> > Stefan
> 
> 
> -- 
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


