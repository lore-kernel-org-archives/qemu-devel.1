Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D6C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B95E247E8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vle2r9pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B95E247E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXpaX-0007ag-8E
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 13:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXpZl-00077F-RB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 13:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXpZi-0002As-Vu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 13:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603907369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l3aiyZ/r9Q5P8xnLsJGdy8BxNWTk5ormKPQk+3EbSic=;
 b=Vle2r9pFs3qI38+LJQNNmGZhZgZdXvF4t0Lu4vlgOitWN69QEJtDfbiOTJJyf4GPTmqiHh
 kVhcQV3KpRAXXCX2kOVDxGnG1JSJhv5uQ6EtPhaDJKn70aerHCc2ZR8bEtGf7pkBpsXD39
 MqSi+g/7U4TL9yVOUSEDPtXdW/tNpUQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-ES70-ANhP4WE2X4c7ZTU7A-1; Wed, 28 Oct 2020 13:49:27 -0400
X-MC-Unique: ES70-ANhP4WE2X4c7ZTU7A-1
Received: by mail-wr1-f70.google.com with SMTP id 2so126166wrd.14
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 10:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l3aiyZ/r9Q5P8xnLsJGdy8BxNWTk5ormKPQk+3EbSic=;
 b=qQ8lNs00byyBYsR9sZSYNWbCv2deRQJb93YBwpg58kn3bIrFjAfYsd5KRKMnkog217
 UOAJcF+DtlzOVI9Sw6uu/YwYTkumxXo+UKiaHBut4MeL5ZFV6+9mDfQjFU+G8SAgdOX0
 +xVPa6j6pY6Oq5s8Scrdn3ElfEdTrh789YA+sremJOL10h2s5sN4CgtFUMzAUvYeZmez
 JQdg/0feF3vCtdOn5oOn1vK4Z04hWjvlKEtS5jtjorjhTFIuGGv1S+kJBj5POUxZzrRU
 ZG6kmnqeGAvFzlFkmhTMuhgdC+pHTD+vtjoZ9rG5H/z+pbqcHOfmdPpvijs1akaOMUmb
 0ZUg==
X-Gm-Message-State: AOAM530UP7BDU5Bx/P6l0kVHnBjzdZVuZ1wr8fASJPz8jGNfALJelnr3
 m21mchnsebqnPDCeLjzQ78ANiUm29FULN1Duf2w5QJpxDwj5Kc7RWaZG1JzAZO0waHUiQE33uoG
 QtuObbYPquNn9OaM=
X-Received: by 2002:adf:a50e:: with SMTP id i14mr496958wrb.121.1603907366392; 
 Wed, 28 Oct 2020 10:49:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUZ7idrveRaLEln6ib9//z9FnsVuP51LYksrrPz9wxDgsqQmoE84fEZYje4Hc5N4zSkti/RA==
X-Received: by 2002:adf:a50e:: with SMTP id i14mr496931wrb.121.1603907366150; 
 Wed, 28 Oct 2020 10:49:26 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id z4sm357147wrg.53.2020.10.28.10.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 10:49:25 -0700 (PDT)
Date: Wed, 28 Oct 2020 13:49:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201028134816-mutt-send-email-mst@kernel.org>
References: <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <CAC_L=vUgsh=08m8EEuEucRtdX73X5kw5ov4Ekg7jFjbHsU6f2w@mail.gmail.com>
 <20201026174537.128a4173@yekko.fritz.box>
 <20201027072430-mutt-send-email-mst@kernel.org>
 <20201027135426.765dd19b@redhat.com>
 <20201028143135.51c0a918@yekko.fritz.box>
 <20201028163945.64eacc81@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201028163945.64eacc81@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
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
Cc: David Gibson <dgibson@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 04:39:45PM +0100, Igor Mammedov wrote:
> On Wed, 28 Oct 2020 14:31:35 +1100
> David Gibson <dgibson@redhat.com> wrote:
> 
> > On Tue, 27 Oct 2020 13:54:26 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > > On Tue, 27 Oct 2020 07:26:44 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > >  [...]  
> > >  [...]  
> > >  [...]  
> > > [...]
> > >  [...]    
> > > > > 
> > > > > It certainly shouldn't wait an unbounded time.  But a wait with timeout
> > > > > seems worth investigating to me.      
> > > racy, timeout is bound to break once it's in overcommited env.  
> > 
> > Hm.  That's no less true at the management layer than it is at the qemu
> > layer.
> true, but it's user policy which is defined by user not by QEMU.
> 
> > 
> > > > If it's helpful, I'd add a query to check state
> > > > so management can figure out why doesn't guest see device yet.    
> > > that means mgmt would have to poll it and forward it to user
> > > somehow.  
> > 
> > If that even makes sense.  In the case of Kata, it's supposed to be
> > autonomously creating the VM, so there's nothing meaningful it can
> > forward to the user other than "failed to create the container because
> > of some hotplug problem that means nothing to you".
> > 
> > >  [...]  
> > > I have more questions wrt the suggestion/workflow:
> > > * at what place would you suggest buffering it?
> > > * what would be the request in this case, i.e. create PCI device anyways
> > > and try to signal hotplug event later?
> > > * what would baremethal do in such case?
> > > * what to do in case guest is never ready, what user should do in such case?
> > > * can be such device be removed?
> > > 
> > > not sure that all of this is worth of the effort and added complexity.
> > > 
> > > alternatively:
> > > maybe ports can send QMP events about it's state changes, which end user would
> > > be able to see + error like in this patch.
> > > 
> > > On top of it, mgmt could build a better UIx, like retry/notify logic if
> > > that's what user really wishes for and configures (it would be up to user to
> > > define behaviour).  
> > 
> > That kind of makes sense if the user is explicitly requesting hotplugs,
> > but that's not necessarily the case.
> user doesn't have to be a human, it could be some mgmt layer that would
> automate retry logic, depending on what actually user needs for particular task
> (i.e. fail immediately, retry N time then fail, retry with time out - then fail,
> don't care - succeed, ...). The point is for QEMU to provide means for mgmt to
> implement whatever policy user would need.

We are not coming up with new APIs here. Let's make existing ones
work reliably first. We can talk about a flag where it fails
instead of deferring hotplug, separately.

> PS:
> but then, I know close to nothing about PCI, so all of above might be nonsense.




