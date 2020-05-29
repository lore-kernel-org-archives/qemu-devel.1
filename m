Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F75AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 04:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80592074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 04:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80592074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeWb7-0000EN-VV
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 00:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jeWaB-00083J-Ow
 for qemu-devel@nongnu.org; Fri, 29 May 2020 00:25:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:1921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jeWaA-0005LT-EX
 for qemu-devel@nongnu.org; Fri, 29 May 2020 00:25:23 -0400
IronPort-SDR: pw7XQC2K6hECI5ys1Wu6BRnNXlDcnO9snl6Yzn0Vojzm5e1oq9cEQlX8giUNhupuaX0FtnTng1
 mp8M7/hjQ0Aw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 21:25:16 -0700
IronPort-SDR: LbimR6ujBCgASJuPZXnR+I9UPBzufB/aMJUq2aUy/HaeKwBGRfuKRCo7pz21sinVhhdMj1UGnA
 IJvBOc/sk6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; d="scan'208";a="414847654"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga004.jf.intel.com with ESMTP; 28 May 2020 21:25:11 -0700
Date: Fri, 29 May 2020 00:15:17 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200529041516.GE1378@joy-OptiPlex-7040>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home>
 <20200525065925.GA698@joy-OptiPlex-7040>
 <426a5314-6d67-7cbe-bad0-e32f11d304ea@nvidia.com>
 <20200526141939.2632f100@x1.home>
 <20200527062358.GD19560@joy-OptiPlex-7040>
 <20200527084822.GC3001@work-vm> <20200528165906.7d03f689@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528165906.7d03f689@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.20; envelope-from=yan.y.zhao@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 00:25:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 04:59:06PM -0600, Alex Williamson wrote:
> On Wed, 27 May 2020 09:48:22 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > > BTW, for viommu, the downtime data is as below. under the same network
> > > condition and guest memory size, and no running dirty data/memory produced
> > > by device.
> > > (1) viommu off
> > > single-round dirty query: downtime ~100ms   
> > 
> > Fine.
> > 
> > > (2) viommu on
> > > single-round dirty query: downtime 58s   
> > 
> > Youch.
> 
> Double Youch!  But we believe this is because we're getting the dirty
> bitmap one IOMMU leaf page at a time, right?  We've enable the kernel
> to get a dirty bitmap across multiple mappings, but QEMU isn't yet
> taking advantage of it.  Do I have this correct?  Thanks,
>
Yes, I think so, but I haven't looked into it yet.

Thanks
Yan

