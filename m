Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663ABC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA7E2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA7E2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd7FM-0002WF-Dl
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 03:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jd7Eo-000270-N0
 for qemu-devel@nongnu.org; Mon, 25 May 2020 03:09:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:7753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jd7Em-0006vQ-P5
 for qemu-devel@nongnu.org; Mon, 25 May 2020 03:09:29 -0400
IronPort-SDR: B5iVdTKgxaGy1pB8W3TyoXvN9WTjLDelZmt/Ti4zXvLDMhTvS8kn2MaiPZ4PtkWAFuxdGyT2lV
 S+hhueyUg2EA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2020 00:09:23 -0700
IronPort-SDR: GTy/UgBSgNKAfK/Tie1LHQ85jj5tejRIkftRgh2WdVz7izBcCGWlnMKgGnNHVAAx3c9NP3mR+F
 JbT1DM0Am4Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; d="scan'208";a="413427539"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga004.jf.intel.com with ESMTP; 25 May 2020 00:09:18 -0700
Date: Mon, 25 May 2020 02:59:26 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200525065925.GA698@joy-OptiPlex-7040>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519105804.02f3cae8@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.88; envelope-from=yan.y.zhao@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 03:09:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 10:58:04AM -0600, Alex Williamson wrote:
> Hi folks,
> 
> My impression is that we're getting pretty close to a workable
> implementation here with v22 plus respins of patches 5, 6, and 8.  We
> also have a matching QEMU series and a proposal for a new i40e
> consumer, as well as I assume GVT-g updates happening internally at
> Intel.  I expect all of the latter needs further review and discussion,
> but we should be at the point where we can validate these proposed
> kernel interfaces.  Therefore I'd like to make a call for reviews so
> that we can get this wrapped up for the v5.8 merge window.  I know
> Connie has some outstanding documentation comments and I'd like to make
> sure everyone has an opportunity to check that their comments have been
> addressed and we don't discover any new blocking issues.  Please send
> your Acked-by/Reviewed-by/Tested-by tags if you're satisfied with this
> interface and implementation.  Thanks!
>
hi Alex
after porting gvt/i40e vf migration code to kernel/qemu v23, we spoted
two bugs.
1. "Failed to get dirty bitmap for iova: 0xfe011000 size: 0x3fb0 err: 22"
   This is a qemu bug that the dirty bitmap query range is not the same
   as the dma map range. It can be fixed in qemu. and I just have a little
   concern for kernel to have this restriction.

2. migration abortion, reporting
"qemu-system-x86_64-lm: vfio_load_state: Error allocating buffer
qemu-system-x86_64-lm: error while loading state section id 49(vfio)
qemu-system-x86_64-lm: load of migration failed: Cannot allocate memory"

It's still a qemu bug and we can fixed it by
"
if (migration->pending_bytes == 0) {
+            qemu_put_be64(f, 0);
+            qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
"
and actually there are some extra concerns about this part, as reported in
[1][2].

[1] data_size should be read ahead of data_offset
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02795.html.
[2] should not repeatedly update pending_bytes in vfio_save_iterate()
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02796.html.

but as those errors are all in qemu, and we have finished basic tests in
both gvt & i40e, we're fine with the kernel part interface in general now.
(except for my concern [1], which needs to update kernel patch 1)

so I wonder which way in your mind is better, to give our reviewed-by to
the kernel part now, or hold until next qemu fixes?
and as performance data from gvt is requested from your previous mail, is
that still required before the code is accepted?

BTW, we have also conducted some basic tests when viommu is on, and found out
errors like 
"qemu-system-x86_64-dt: vtd_iova_to_slpte: detected slpte permission error (iova=0x0, level=0x3, slpte=0x0, write=1)
qemu-system-x86_64-dt: vtd_iommu_translate: detected translation failure (dev=00:03:00, iova=0x0)
qemu-system-x86_64-dt: New fault is not recorded due to compression of faults".

Thanks
Yan





