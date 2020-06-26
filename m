Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714F0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406CC20768
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2DTDAY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406CC20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopas-0000dl-D1
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jopa5-00089B-1I
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:43:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jopa2-0001D3-8E
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593182627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60Pvw55P+ZMxxyJs/eBlq7gwVpmUgGC2zwh0x8cPgZE=;
 b=J2DTDAY59mFEWviCCRuEncFnenp4LyKpOhsqa9P/2j47+3UAxDXyPpxDP6cnQ8/Y94d4W/
 tknbO4KNkP963oOtxnweB5RNo4K4aKDABjS0s/lItVDJUbEiPKTNi99nCGtFKW+Yy8Dswx
 NZea//HTg7/MjEEhMacJo9zR4lX334Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-TH0hqz-OPrCKEYfusYW61g-1; Fri, 26 Jun 2020 10:43:45 -0400
X-MC-Unique: TH0hqz-OPrCKEYfusYW61g-1
Received: by mail-qv1-f69.google.com with SMTP id j18so6567512qvk.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 07:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=60Pvw55P+ZMxxyJs/eBlq7gwVpmUgGC2zwh0x8cPgZE=;
 b=C03YhwIi0nhIruFDAIGxo/6H4aCv+/0Ux/aVOh61lXkKCeGQNcCZaaRD1E/NcOI8JD
 jk/7rHyWoYA750Kgl/BHHvyW1wrNbTkFKEyFk7na7gA0JxZy/w4snXaZFIkduFRgM4lD
 Z25mPd3RkyqHyPXJeQuUFu9ZlJYsS0CX2w+8rhoQu0U9IlTXogABsdyvhKGGjyDfWlH0
 8A8qywApmy69aC8q8BsBjcX5EuYcuqGMYsqfXvqqjtk66xG+RFUOe7DACxpdac9c+edE
 kPcHrJA9dXwrzhU5TEg9t0ykh7JIn8k/uenvQPAAshfIrKGXswEd0m3emjjxKWPM4cgM
 JinQ==
X-Gm-Message-State: AOAM532PJgp6+eZmn2OEPmLu7fIEl+TrFLG5JNUhYXp3P+eFbFozR5TU
 eodlSWYgNdvoKAC7KFHFknQ4wiTixcncXsS+sKZPjOGFMTBdjo8EXY6C328ouXZFtQTeXsza83l
 gR/6jTUCnZdcxVBQ=
X-Received: by 2002:a05:620a:2153:: with SMTP id
 m19mr2876737qkm.1.1593182625164; 
 Fri, 26 Jun 2020 07:43:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbNgdGkWCi+QNt0uU+Zx2+GGcv1XGNpWfkF0XvLSo2N8QEAVQus8P5lLDyWAAfSA7tbNao0A==
X-Received: by 2002:a05:620a:2153:: with SMTP id
 m19mr2876697qkm.1.1593182624854; 
 Fri, 26 Jun 2020 07:43:44 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k26sm9856851qtk.55.2020.06.26.07.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 07:43:43 -0700 (PDT)
Date: Fri, 26 Jun 2020 10:43:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH QEMU v25 13/17] vfio: create mapped iova list when vIOMMU
 is enabled
Message-ID: <20200626144341.GL64004@xz-x1>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-14-git-send-email-kwankhede@nvidia.com>
 <20200624125526.5488954c@x1.home>
 <b0ee702d-02e5-4cd6-6dcc-047cfcb907b2@nvidia.com>
 <20200625114039.566b0914@x1.home>
MIME-Version: 1.0
In-Reply-To: <20200625114039.566b0914@x1.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 11:40:39AM -0600, Alex Williamson wrote:
> On Thu, 25 Jun 2020 20:04:08 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > On 6/25/2020 12:25 AM, Alex Williamson wrote:
> > > On Sun, 21 Jun 2020 01:51:22 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > >   
> > >> Create mapped iova list when vIOMMU is enabled. For each mapped iova
> > >> save translated address. Add node to list on MAP and remove node from
> > >> list on UNMAP.
> > >> This list is used to track dirty pages during migration.  
> > > 
> > > This seems like a lot of overhead to support that the VM might migrate.
> > > Is there no way we can build this when we start migration, for example
> > > replaying the mappings at that time?  Thanks,
> > >   
> > 
> > In my previous version I tried to go through whole range and find valid 
> > iotlb, as below:
> > 
> > +        if (memory_region_is_iommu(section->mr)) {
> > +            iotlb = address_space_get_iotlb_entry(container->space->as, 
> > iova,
> > +                                                 true, 
> > MEMTXATTRS_UNSPECIFIED);
> > 
> > When mapping doesn't exist, qemu throws error as below:
> > 
> > qemu-system-x86_64: vtd_iova_to_slpte: detected slpte permission error 
> > (iova=0x0, level=0x3, slpte=0x0, write=1)
> > qemu-system-x86_64: vtd_iommu_translate: detected translation failure 
> > (dev=00:03:00, iova=0x0)
> > qemu-system-x86_64: New fault is not recorded due to compression of faults
> 
> My assumption would have been that we use the replay mechanism, which
> is known to work because we need to use it when we hot-add a device.
> We'd make use of iommu_notifier_init() to create a new handler for this
> purpose, then we'd walk our container->giommu_list and call
> memory_region_iommu_replay() for each.
> 
> Peter, does this sound like the right approach to you?

(Sorry I may not have the complete picture of this series, please bear with
 me...)

This seems to be a workable approach to me.  However then we might have a
similar mapping entry cached the 3rd time...  VFIO kernel has a copy initially,
then QEMU vIOMMU has another one (please grep iova_tree in intel_iommu.c).

My wild guess is that the mapping should still be in control in most cases, so
even if we cache it multiple times (for better layering) it would still be
fine.  However since we're in QEMU right now, I'm also thinking whether we can
share the information with the vIOMMU somehow, because even if the page table
entry is wiped off at that time we may still have a chance to use the DMAMap
object that cached in vIOMMU when iommu notify() happens.  Though that may
require some vIOMMU change too (e.g., vtd_page_walk_one may need to postpone
the iova_tree_remove to be after the hook_fn is called, also we may need to
pass the DMAMap object or at least the previous translated addr to the hook
somehow before removal), so maybe that can also be done on top.

> 
> > Secondly, it iterates through whole range with IOMMU page size 
> > granularity which is 4K, so it takes long time resulting in large 
> > downtime. With this optimization, downtime with vIOMMU reduced 
> > significantly.
> 
> Right, but we amortize that overhead and the resulting bloat across the
> 99.9999% of the time that we're not migrating.  I wonder if we could
> startup another thread to handle this when we enable dirty logging.  We
> don't really need the result until we start processing the dirty
> bitmap, right?  Also, if we're dealing with this many separate pages,
> shouldn't we be using a tree rather than a list to give us O(logN)
> rather than O(N)?

Yep I agree.  At least the vIOMMU cache is using gtree.

Btw, IIUC we won't walk the whole range using 4K granularity always, not for
VT-d emulation.  Because vtd_page_walk_level() is smart enough to skip higher
levels of invalid entries so it can jump with 2M/1G/... chunks if the whole
chunk is invalid.

Thanks,

-- 
Peter Xu


