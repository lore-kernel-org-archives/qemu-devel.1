Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD68C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 06:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0285206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 06:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0285206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJXEl-0000Di-Oh
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 02:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jJXDw-0007p3-5M
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 02:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jJXDu-0001bv-6s
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 02:51:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:18113)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jJXDt-0001KR-Ud
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 02:51:38 -0400
IronPort-SDR: Jbb7OU63ZWqdYEyIgfc9i7PLzEwSY6gjg1mLcywWrFUdZ/OQr/+fPBP7OqOKpIj2feDEqWlS7f
 oinL48WJUCow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 23:51:34 -0700
IronPort-SDR: uK/EzLL2QMZRKQC6013kyR9isH7JIhLPe2zprQwqbOQISlpI/xkaZje7ZBCLPa91EZIi1bK8sW
 qeqljALQUYLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="395848161"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga004.jf.intel.com with ESMTP; 31 Mar 2020 23:51:27 -0700
Date: Wed, 1 Apr 2020 02:41:54 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v16 QEMU 00/16] Add migration support for VFIO devices
Message-ID: <20200401064153.GF6631@joy-OptiPlex-7040>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <20200331123424.3c28b30a@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331123424.3c28b30a@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.115
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 01, 2020 at 02:34:24AM +0800, Alex Williamson wrote:
> On Wed, 25 Mar 2020 02:38:58 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > Hi,
> > 
> > This Patch set adds migration support for VFIO devices in QEMU.
> 
> Hi Kirti,
> 
> Do you have any migration data you can share to show that this solution
> is viable and useful?  I was chatting with Dave Gilbert and there still
> seems to be a concern that we actually have a real-world practical
> solution.  We know this is inefficient with QEMU today, vendor pinned
> memory will get copied multiple times if we're lucky.  If we're not
> lucky we may be copying all of guest RAM repeatedly.  There are known
> inefficiencies with vIOMMU, etc.  QEMU could learn new heuristics to
> account for some of this and we could potentially report different
> bitmaps in different phases through vfio, but let's make sure that
> there are useful cases enabled by this first implementation.
> 
> With a reasonably sized VM, running a reasonable graphics demo or
> workload, can we achieve reasonably live migration?  What kind of
> downtime do we achieve and what is the working set size of the pinned
> memory?  Intel folks, if you've been able to port to this or similar
> code base, please report your results as well, open source consumers
> are arguably even more important.  Thanks,
> 
hi Alex
we're in the process of porting to this code, and now it's able to
migrate successfully without dirty pages.

when there're dirty pages, we met several issues.
one of them is reported here
(https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00004.html).
dirty pages for some regions are not able to be collected correctly,
especially for memory range from 3G to 4G.

even without this bug, qemu still got stuck in middle before
reaching stop-and-copy phase and cannot be killed by admin.
still in debugging of this problem.

Thanks
Yan


