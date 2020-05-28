Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E76C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34672088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34672088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeDdi-0006hc-S2
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jeDdA-0005cN-V3
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:11:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:24438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jeDd8-0008Um-KV
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:11:12 -0400
IronPort-SDR: ROr7wZyacJah5MbawAOiQjsvv0hRb6P/Ul5OHWsbHazCFUNIYMDgJvdAJCVBRImnKnr0FgYB9E
 oaZJiJufF1Hg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 01:11:00 -0700
IronPort-SDR: bRgydiOtZ9X+tvZBEcFWcYWu54Zt+rX1J2USsgGjc8eh1+jjQqAJPCDIfAEtsekT/rDVTO77Ok
 B1JIGWLyQ/RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; d="scan'208";a="291916623"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga004.fm.intel.com with ESMTP; 28 May 2020 01:10:55 -0700
Date: Thu, 28 May 2020 04:01:02 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200528080101.GD1378@joy-OptiPlex-7040>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home>
 <20200525065925.GA698@joy-OptiPlex-7040>
 <426a5314-6d67-7cbe-bad0-e32f11d304ea@nvidia.com>
 <20200526141939.2632f100@x1.home>
 <20200527062358.GD19560@joy-OptiPlex-7040>
 <20200527084822.GC3001@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527084822.GC3001@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=yan.y.zhao@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 04:11:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Alex Williamson <alex.williamson@redhat.com>, eauger@redhat.com,
 felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > This is my understanding of the protocol as well, when the device is
> > > running, pending_bytes might drop to zero if no internal state has
> > > changed and may be non-zero on the next iteration due to device
> > > activity.  When the device is not running, pending_bytes reporting zero
> > > indicates the device is done, there is no further state to transmit.
> > > Does that meet your need/expectation?
> > >
> > (1) on one side, as in vfio_save_pending(),
> > vfio_save_pending()
> > {
> >     ...
> >     ret = vfio_update_pending(vbasedev);
> >     ...
> >     *res_precopy_only += migration->pending_bytes;
> >     ...
> > }
> > the pending_bytes tells migration thread how much data is still hold in
> > device side.
> > the device data includes
> > device internal data + running device dirty data + device state.
> > 
> > so the pending_bytes should include device state as well, right?
> > if so, the pending_bytes should never reach 0 if there's any device
> > state to be sent after device is stopped.
> 
> I hadn't expected the pending-bytes to include a fixed offset for device
> state (If you mean a few registers etc) - I'd expect pending to drop
> possibly to zero;  the heuristic as to when to switch from iteration to
> stop, is based on the total pending across all iterated devices; so it's
> got to be allowed to drop otherwise you'll never transition to stop.
> 
ok. got it.

> > (2) on the other side,
> > along side we updated the pending_bytes in vfio_save_pending() and
> > enter into the vfio_save_iterate(), if we repeatedly update
> > pending_bytes in vfio_save_iterate(), it would enter into a scenario
> > like
> > 
> > initially pending_bytes=500M.
> > vfio_save_iterate() -->
> >   round 1: transmitted 500M.
> >   round 2: update pending bytes, pending_bytes=50M (50M dirty data).
> >   round 3: update pending bytes, pending_bytes=50M.
> >   ...
> >   round N: update pending bytes, pending_bytes=50M.
> > 
> > If there're two vfio devices, the vfio_save_iterate() for the second device
> > may never get chance to be called because there's always pending_bytes
> > produced by the first device, even the size if small.
> 
> And between RAM and the vfio devices?

yes, is that right?

Thanks
Yan

