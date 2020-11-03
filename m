Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB646C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5073221556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARU18EPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5073221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2vd-0007PX-9H
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ka2uZ-0006XA-ES
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ka2uW-0005hr-Md
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604435287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//EwluFxECYvddt8H5V2R2oqW8PUpEfuJCRVinHXjYM=;
 b=ARU18EPH+mldFtB69GKrrhwVWp0ujnOi47Ytwy1Hp0GW6De2se8opj9tKEePmikSVnn2yU
 YBSd2STUqKYphhjr2QpXi9PjNrrBHs1OnMbO/ixv6nj8k7jJ9DgwCpWlZ7RwzOUtTP4Atk
 TuEc44retL0uTw4MY/pF7tTGZboa+s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-sCX-1tH-P_6nTcARDEj7GQ-1; Tue, 03 Nov 2020 15:28:05 -0500
X-MC-Unique: sCX-1tH-P_6nTcARDEj7GQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 234511007469;
 Tue,  3 Nov 2020 20:28:04 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B26219D61;
 Tue,  3 Nov 2020 20:28:01 +0000 (UTC)
Date: Tue, 3 Nov 2020 13:27:58 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v1] docs/devel: Add VFIO device migration documentation
Message-ID: <20201103132758.04b18f5c@w520.home>
In-Reply-To: <47f8ccea-f75a-dfb7-b646-28d5123b322f@nvidia.com>
References: <1603950791-27236-1-git-send-email-kwankhede@nvidia.com>
 <20201029125221.69352b48.cohuck@redhat.com>
 <9479dffd-e434-e336-6ed8-07fc2edd2453@nvidia.com>
 <20201029130519.7eb1e704@w520.home>
 <47f8ccea-f75a-dfb7-b646-28d5123b322f@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 4 Nov 2020 01:18:12 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 10/30/2020 12:35 AM, Alex Williamson wrote:
> > On Thu, 29 Oct 2020 23:11:16 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> 
> <snip>
> 
> >>>> +System memory dirty pages tracking
> >>>> +----------------------------------
> >>>> +
> >>>> +A ``log_sync`` memory listener callback is added to mark system memory pages  
> >>>
> >>> s/is added to mark/marks those/
> >>>      
> >>>> +as dirty which are used for DMA by VFIO device. Dirty pages bitmap is queried  
> >>>
> >>> s/by/by the/
> >>> s/Dirty/The dirty/
> >>>      
> >>>> +per container. All pages pinned by vendor driver through vfio_pin_pages()  
> >>>
> >>> s/by/by the/
> >>>      
> >>>> +external API have to be marked as dirty during migration. When there are CPU
> >>>> +writes, CPU dirty page tracking can identify dirtied pages, but any page pinned
> >>>> +by vendor driver can also be written by device. There is currently no device  
> >>>
> >>> s/by/by the/ (x2)
> >>>      
> >>>> +which has hardware support for dirty page tracking. So all pages which are
> >>>> +pinned by vendor driver are considered as dirty.
> >>>> +Dirty pages are tracked when device is in stop-and-copy phase because if pages
> >>>> +are marked dirty during pre-copy phase and content is transfered from source to
> >>>> +destination, there is no way to know newly dirtied pages from the point they
> >>>> +were copied earlier until device stops. To avoid repeated copy of same content,
> >>>> +pinned pages are marked dirty only during stop-and-copy phase.  
> >>
> >>  
> >>> Let me take a quick stab at rewriting this paragraph (not sure if I
> >>> understood it correctly):
> >>>
> >>> "Dirty pages are tracked when the device is in the stop-and-copy phase.
> >>> During the pre-copy phase, it is not possible to distinguish a dirty
> >>> page that has been transferred from the source to the destination from
> >>> newly dirtied pages, which would lead to repeated copying of the same
> >>> content. Therefore, pinned pages are only marked dirty during the
> >>> stop-and-copy phase." ?
> >>>      
> >>
> >> I think above rephrase only talks about repeated copying in pre-copy
> >> phase. Used "copied earlier until device stops" to indicate both
> >> pre-copy and stop-and-copy till device stops.  
> > 
> > 
> > Now I'm confused, I thought we had abandoned the idea that we can only
> > report pinned pages during stop-and-copy.  Doesn't the device needs to
> > expose its dirty memory footprint during the iterative phase regardless
> > of whether that causes repeat copies?  If QEMU iterates and sees that
> > all memory is still dirty, it may have transferred more data, but it
> > can actually predict if it can achieve its downtime tolerances.  Which
> > is more important, less data transfer or predictability?  Thanks,
> >   
> 
> Even if QEMU copies and transfers content of all sys mem pages during 
> pre-copy (worst case with IOMMU backed mdev device when its vendor 
> driver is not smart to pin pages explicitly and all sys mem pages are 
> marked dirty), then also its prediction about downtime tolerance will 
> not be correct, because during stop-and-copy again all pages need to be 
> copied as device can write to any of those pinned pages.

I think you're only reiterating my point.  If QEMU copies all of guest
memory during the iterative phase and each time it sees that all memory
is dirty, such as if CPUs or devices (including assigned devices) are
dirtying pages as fast as it copies them (or continuously marks them
dirty), then QEMU can predict that downtime will require copying all
pages.  If instead devices don't mark dirty pages until the VM is
stopped, then QEMU might iterate through memory copy and predict a short
downtime because not much memory is dirty, only to be surprised that
all of memory is suddenly dirty.  At that point it's too late, the VM
is already stopped, the predicted short downtime takes far longer than
expected.  This is exactly why we made the kernel interface mark pinned
pages persistently dirty when it was proposed that we only report
pinned pages once.  Thanks,

Alex


