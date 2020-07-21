Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C1C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 22:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9952073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 22:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e38JPTg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9952073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy0zv-0003e0-SI
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 18:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jy0yl-0002mh-Hu
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 18:43:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47791
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jy0yi-0001GU-Lj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 18:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595371394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQt7o/tu0J33BtVCH3pQiWNfrbS5094FWCur3ksI/04=;
 b=e38JPTg6lPZfxypSyr6YC8kjBkvJbiZ+PcnXIF0BegufHRwZIcSHi+nZiLmhyjx46XhLaP
 MfZn/rkAufnDuOwknfqgzUvQjEI2Yn1rVCZmC39FDCNioTFMLGWYnineVqSHYu9DmIxuHU
 /xWpkCyUjyZcnR3MuhVgnipChyjlS6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-1lYjGpvkPquHIeoGx1DyTg-1; Tue, 21 Jul 2020 18:43:10 -0400
X-MC-Unique: 1lYjGpvkPquHIeoGx1DyTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51457107ACCA;
 Tue, 21 Jul 2020 22:43:07 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D8E778547;
 Tue, 21 Jul 2020 22:43:05 +0000 (UTC)
Date: Tue, 21 Jul 2020 16:43:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [PATCH Kernel v24 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200721164304.0ce76b2e@x1.home>
In-Reply-To: <450612c3-2a92-9034-7958-ee7f3c1a8c52@huawei.com>
References: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
 <450612c3-2a92-9034-7958-ee7f3c1a8c52@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 18:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com,
 ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, Wang Haibin <wanghaibin.wang@huawei.com>,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, cohuck@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 10:43:21 +0800
Xiang Zheng <zhengxiang9@huawei.com> wrote:

> Hi Kirti,
> 
> Sorry to disturb you since this patch set has been merged, and I cannot
> receive the qemu-side emails about this patch set.
> 
> We are going to support migration for VFIO devices which support dirty
> pages tracking.
> 
> And we also plan to leverage SMMU HTTU feature to do the dirty pages
> tracking for the devices which don't support dirty pages tracking.
> 
> For the above two cases, which side determines to choose IOMMU driver or
> vendor driver to do dirty bitmap tracking, Qemu or VFIO?
> 
> In brief, if both IOMMU and VFIO devices support dirty pages tracking,
> we can check the capability and prefer to track dirty pages on device
> vendor driver which is more efficient.
> 
> The qusetion is which side to do the check and selection? In my opinion,
> Qemu/userspace seems more suitable.

Dirty page tracking is consolidated at the vfio container level.
Userspace has no basis for determining or interface for selecting a
dirty bitmap provider, so I would disagree that QEMU should play any
role here.  The container dirty bitmap tries to provide the finest
granularity available based on the support of all the devices/groups
managed by the container.  If there are groups attached to the
container that have not participated in page pinning, then we consider
all DMA mappings within the container as persistently dirty.  Once all
of the participants subscribe to page pinning, the dirty scope is
reduced to the pinned pages.  IOMMU support for dirty page logging would
introduce finer granularity yet, which we would probably prefer over
page pinning, but interfaces for this have not been devised.

Ideally userspace should be unaware of any of this, the benefit would
be seen transparently by having a more sparsely filled dirty bitmap,
which more accurately reflects how memory is actually being dirtied.
Thanks,

Alex


