Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AA4C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9401208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBoNkcIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9401208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJ7Y-0002to-8R
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 13:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNJ2O-0000Nm-Pe
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNJ2L-0000le-0M
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:03:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601398994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GzNbDCj84bCflfGFacDU+KxoDMUHFw95DB0y/IFb5Hs=;
 b=BBoNkcIrMeFy0HVh4yMnN9UPeiw3E3W1/jUxRZE/HAkDsXx/NIRNRTTKkwsTOEEtKfmQxz
 6g68NS32eKnxA+CziK4whWZWLEl4ervrHzlDu3Zp/VUV4ipEqi1ocaVUmuUC+7Ku5aNrI0
 vHKnDVp2wLYVPFouefefsZ7+Zf1owzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-FI4kE3F-NSq3c4CxUu6MNg-1; Tue, 29 Sep 2020 13:03:02 -0400
X-MC-Unique: FI4kE3F-NSq3c4CxUu6MNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BA4064141;
 Tue, 29 Sep 2020 17:03:01 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C8667366C;
 Tue, 29 Sep 2020 17:02:41 +0000 (UTC)
Date: Tue, 29 Sep 2020 18:02:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH PROTOTYPE 0/6] virtio-mem: vfio support
Message-ID: <20200929170238.GN2826@work-vm>
References: <20200924160423.106747-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924160423.106747-1-david@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>,
 Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> This is a quick and dirty (1.5 days of hacking) prototype to make
> vfio and virtio-mem play together. The basic idea was the result of Alex
> brainstorming with me on how to tackle this.
> 
> A virtio-mem device manages a memory region in guest physical address
> space, represented as a single (currently large) memory region in QEMU.
> Before the guest is allowed to use memory blocks, it must coordinate with
> the hypervisor (plug blocks). After a reboot, all memory is usually
> unplugged - when the guest comes up, it detects the virtio-mem device and
> selects memory blocks to plug (based on requests from the hypervisor).
> 
> Memory hot(un)plug consists of (un)plugging memory blocks via a virtio-mem
> device (triggered by the guest). When unplugging blocks, we discard the
> memory. In contrast to memory ballooning, we always know which memory
> blocks a guest may use - especially during a reboot, after a crash, or
> after kexec.
> 
> The issue with vfio is, that it cannot deal with random discards - for this
> reason, virtio-mem and vfio can currently only run mutually exclusive.
> Especially, vfio would currently map the whole memory region (with possible
> only little/no plugged blocks), resulting in all pages getting pinned and
> therefore resulting in a higher memory consumption than expected (turning
> virtio-mem basically useless in these environments).
> 
> To make vfio work nicely with virtio-mem, we have to map only the plugged
> blocks, and map/unmap properly when plugging/unplugging blocks (including
> discarding of RAM when unplugging). We achieve that by using a new notifier
> mechanism that communicates changes.
> 
> It's important to map memory in the granularity in which we could see
> unmaps again (-> virtio-mem block size) - so when e.g., plugging
> consecutive 100 MB with a block size of 2MB, we need 50 mappings. When
> unmapping, we can use a single vfio_unmap call for the applicable range.
> We expect that the block size of virtio-mem devices will be fairly large
> in the future (to not run out of mappings and to improve hot(un)plug
> performance), configured by the user, when used with vfio (e.g., 128MB,
> 1G, ...) - Linux guests will still have to be optimized for that.

This seems pretty painful for those few TB mappings.
Also the calls seem pretty painful; maybe it'll be possible to have
calls that are optimised for making multiple consecutive mappings.

Dave

> We try to handle errors when plugging memory (mapping in VFIO) gracefully
> - especially to cope with too many mappings in VFIO.
> 
> 
> As I basically have no experience with vfio, all I did for testing is
> passthrough a secondary GPU (NVIDIA GK208B) via vfio-pci to my guest
> and saw it pop up in dmesg. I did *not* actually try to use it (I know
> ...), so there might still be plenty of BUGs regarding the actual mappings
> in the code. When I resize virtio-mem devices (resulting in
> memory hot(un)plug), I can spot the memory consumption of my host adjusting
> accordingly - in contrast to before, wehreby my machine would always
> consume the maximum size of my VM, as if all memory provided by
> virtio-mem devices were fully plugged.
> 
> I even tested it with 2MB huge pages (sadly for the first time with
> virtio-mem ever) - and it worked like a charm on the hypervisor side as
> well. The number of free hugepages adjusted accordingly. (again, did not
> properly test the device in the guest ...).
> 
> If anybody wants to play with it and needs some guidance, please feel
> free to ask. I might add some vfio-related documentation to
> https://virtio-mem.gitlab.io/ (but it really isn't that special - only
> the block size limitations have to be considered).
> 
> David Hildenbrand (6):
>   memory: Introduce sparse RAM handler for memory regions
>   virtio-mem: Impelement SparseRAMHandler interface
>   vfio: Implement support for sparse RAM memory regions
>   memory: Extend ram_block_discard_(require|disable) by two discard
>     types
>   virtio-mem: Require only RAM_BLOCK_DISCARD_T_COORDINATED discards
>   vfio: Disable only RAM_BLOCK_DISCARD_T_UNCOORDINATED discards
> 
>  exec.c                         | 109 +++++++++++++++++----
>  hw/vfio/common.c               | 169 ++++++++++++++++++++++++++++++++-
>  hw/virtio/virtio-mem.c         | 164 +++++++++++++++++++++++++++++++-
>  include/exec/memory.h          | 151 ++++++++++++++++++++++++++++-
>  include/hw/vfio/vfio-common.h  |  12 +++
>  include/hw/virtio/virtio-mem.h |   3 +
>  softmmu/memory.c               |   7 ++
>  7 files changed, 583 insertions(+), 32 deletions(-)
> 
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


