Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05199C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB7D206A4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaSZv37c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB7D206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaICG-0000mY-6J
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kaIAW-00088o-6v
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:45:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kaIAO-0003On-VX
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604493931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcvkI9DvDmyyKLWQws3E4fQ6f20REhQ20ObKduBEhxs=;
 b=VaSZv37c9XZ97CDOlgfdJaUfp80AkW8KgxkLNFYicbjgaTYZzSdBrNuyF8t+8a9HYkVJp/
 9RHNefDCHP0Ul2sFke28HqopH/zN/V0DGWiUe7fBfOtTUrzKQtP1Gs2K+9J3G+XRcZwRBc
 i2r4iBEhXLkMhdUZQKRErb0dVeRg8y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-48mmDB5jO4mXx0KoRKrFIg-1; Wed, 04 Nov 2020 07:45:29 -0500
X-MC-Unique: 48mmDB5jO4mXx0KoRKrFIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 215371868403;
 Wed,  4 Nov 2020 12:45:28 +0000 (UTC)
Received: from x1.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D88F6EF73;
 Wed,  4 Nov 2020 12:45:27 +0000 (UTC)
Date: Wed, 4 Nov 2020 05:45:27 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v1] docs/devel: Add VFIO device migration documentation
Message-ID: <20201104054527.22bbace7@x1.home>
In-Reply-To: <a27dee38-2fa9-a6ae-de30-eb7b57629393@nvidia.com>
References: <1603950791-27236-1-git-send-email-kwankhede@nvidia.com>
 <20201029125221.69352b48.cohuck@redhat.com>
 <9479dffd-e434-e336-6ed8-07fc2edd2453@nvidia.com>
 <20201029130519.7eb1e704@w520.home>
 <47f8ccea-f75a-dfb7-b646-28d5123b322f@nvidia.com>
 <20201103132758.04b18f5c@w520.home>
 <a27dee38-2fa9-a6ae-de30-eb7b57629393@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: mcrossley@nvidia.com, cjia@nvidia.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, dnigam@nvidia.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 13:25:40 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 11/4/2020 1:57 AM, Alex Williamson wrote:
> > On Wed, 4 Nov 2020 01:18:12 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 10/30/2020 12:35 AM, Alex Williamson wrote:  
> >>> On Thu, 29 Oct 2020 23:11:16 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>      
> >>
> >> <snip>
> >>  
> >>>>>> +System memory dirty pages tracking
> >>>>>> +----------------------------------
> >>>>>> +
> >>>>>> +A ``log_sync`` memory listener callback is added to mark system memory pages  
> >>>>>
> >>>>> s/is added to mark/marks those/
> >>>>>         
> >>>>>> +as dirty which are used for DMA by VFIO device. Dirty pages bitmap is queried  
> >>>>>
> >>>>> s/by/by the/
> >>>>> s/Dirty/The dirty/
> >>>>>         
> >>>>>> +per container. All pages pinned by vendor driver through vfio_pin_pages()  
> >>>>>
> >>>>> s/by/by the/
> >>>>>         
> >>>>>> +external API have to be marked as dirty during migration. When there are CPU
> >>>>>> +writes, CPU dirty page tracking can identify dirtied pages, but any page pinned
> >>>>>> +by vendor driver can also be written by device. There is currently no device  
> >>>>>
> >>>>> s/by/by the/ (x2)
> >>>>>         
> >>>>>> +which has hardware support for dirty page tracking. So all pages which are
> >>>>>> +pinned by vendor driver are considered as dirty.
> >>>>>> +Dirty pages are tracked when device is in stop-and-copy phase because if pages
> >>>>>> +are marked dirty during pre-copy phase and content is transfered from source to
> >>>>>> +destination, there is no way to know newly dirtied pages from the point they
> >>>>>> +were copied earlier until device stops. To avoid repeated copy of same content,
> >>>>>> +pinned pages are marked dirty only during stop-and-copy phase.  
> >>>>
> >>>>     
> >>>>> Let me take a quick stab at rewriting this paragraph (not sure if I
> >>>>> understood it correctly):
> >>>>>
> >>>>> "Dirty pages are tracked when the device is in the stop-and-copy phase.
> >>>>> During the pre-copy phase, it is not possible to distinguish a dirty
> >>>>> page that has been transferred from the source to the destination from
> >>>>> newly dirtied pages, which would lead to repeated copying of the same
> >>>>> content. Therefore, pinned pages are only marked dirty during the
> >>>>> stop-and-copy phase." ?
> >>>>>         
> >>>>
> >>>> I think above rephrase only talks about repeated copying in pre-copy
> >>>> phase. Used "copied earlier until device stops" to indicate both
> >>>> pre-copy and stop-and-copy till device stops.  
> >>>
> >>>
> >>> Now I'm confused, I thought we had abandoned the idea that we can only
> >>> report pinned pages during stop-and-copy.  Doesn't the device needs to
> >>> expose its dirty memory footprint during the iterative phase regardless
> >>> of whether that causes repeat copies?  If QEMU iterates and sees that
> >>> all memory is still dirty, it may have transferred more data, but it
> >>> can actually predict if it can achieve its downtime tolerances.  Which
> >>> is more important, less data transfer or predictability?  Thanks,
> >>>      
> >>
> >> Even if QEMU copies and transfers content of all sys mem pages during
> >> pre-copy (worst case with IOMMU backed mdev device when its vendor
> >> driver is not smart to pin pages explicitly and all sys mem pages are
> >> marked dirty), then also its prediction about downtime tolerance will
> >> not be correct, because during stop-and-copy again all pages need to be
> >> copied as device can write to any of those pinned pages.  
> > 
> > I think you're only reiterating my point.  If QEMU copies all of guest
> > memory during the iterative phase and each time it sees that all memory
> > is dirty, such as if CPUs or devices (including assigned devices) are
> > dirtying pages as fast as it copies them (or continuously marks them
> > dirty), then QEMU can predict that downtime will require copying all
> > pages.   
> 
> But as of now there is no way to know if device has dirtied pages during 
> iterative phase.


This claim doesn't make any sense, pinned pages are considered
persistently dirtied, during the iterative phase and while stopped.

 
> > If instead devices don't mark dirty pages until the VM is
> > stopped, then QEMU might iterate through memory copy and predict a short
> > downtime because not much memory is dirty, only to be surprised that
> > all of memory is suddenly dirty.  At that point it's too late, the VM
> > is already stopped, the predicted short downtime takes far longer than
> > expected.  This is exactly why we made the kernel interface mark pinned
> > pages persistently dirty when it was proposed that we only report
> > pinned pages once.  Thanks,
> >   
> 
> Since there is no way to know if device dirtied pages during iterative 
> phase, QEMU should query pinned pages in stop-and-copy phase.


As above, I don't believe this is true.


> Whenever there will be hardware support or some software mechanism to 
> report pages dirtied by device then we will add a capability bit in 
> migration capability and based on that capability bit qemu/user space 
> app should decide to query dirty pages in iterative phase.


Yes, we could advertise support for fine granularity dirty page
tracking, but I completely disagree that we should consider pinned
pages clean until suddenly exposing them as dirty once the VM is
stopped.  Thanks,

Alex


