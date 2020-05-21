Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F54C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 07:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670C320748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 07:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670C320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbfPa-0005IN-L3
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 03:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jbfP3-0004rX-Az
 for qemu-devel@nongnu.org; Thu, 21 May 2020 03:14:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:34764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jbfP1-0008VW-Cl
 for qemu-devel@nongnu.org; Thu, 21 May 2020 03:14:04 -0400
IronPort-SDR: 8KPN+GQTo8WFQKhzXDAsvZLfrwmVY9Mz8aCI4r2nPIf3PrAo0ANz8iMtiNPaebtSNVJ3TsfejK
 NAbXP+WbHxxA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2020 00:14:00 -0700
IronPort-SDR: LQ8MjWYTp7h9aSGy/jLaCGkJsXgyctPbKDrMpNYYzHVS5RlaJ+L61TwssX5lovrM6K5fl1Rio0
 hd+IPpWevbyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; d="scan'208";a="412297953"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga004.jf.intel.com with ESMTP; 21 May 2020 00:13:54 -0700
Date: Thu, 21 May 2020 03:04:03 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200521070403.GD10369@joy-OptiPlex-7040>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home>
 <20200520025500.GA10369@joy-OptiPlex-7040>
 <97977ede-3c5b-c5a5-7858-7eecd7dd531c@nvidia.com>
 <20200520104612.03a32977@w520.home>
 <20200521050846.GC10369@joy-OptiPlex-7040>
 <d8b40fed-5f54-31ac-0b7c-e2ae74a0ad19@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b40fed-5f54-31ac-0b7c-e2ae74a0ad19@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.88; envelope-from=yan.y.zhao@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 03:14:00
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
 pasic@linux.ibm.com, aik@ozlabs.ru,
 Alex Williamson <alex.williamson@redhat.com>, eauger@redhat.com,
 felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 12:39:48PM +0530, Kirti Wankhede wrote:
> 
> 
> On 5/21/2020 10:38 AM, Yan Zhao wrote:
> > On Wed, May 20, 2020 at 10:46:12AM -0600, Alex Williamson wrote:
> > > On Wed, 20 May 2020 19:10:07 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > > 
> > > > On 5/20/2020 8:25 AM, Yan Zhao wrote:
> > > > > On Tue, May 19, 2020 at 10:58:04AM -0600, Alex Williamson wrote:
> > > > > > Hi folks,
> > > > > > 
> > > > > > My impression is that we're getting pretty close to a workable
> > > > > > implementation here with v22 plus respins of patches 5, 6, and 8.  We
> > > > > > also have a matching QEMU series and a proposal for a new i40e
> > > > > > consumer, as well as I assume GVT-g updates happening internally at
> > > > > > Intel.  I expect all of the latter needs further review and discussion,
> > > > > > but we should be at the point where we can validate these proposed
> > > > > > kernel interfaces.  Therefore I'd like to make a call for reviews so
> > > > > > that we can get this wrapped up for the v5.8 merge window.  I know
> > > > > > Connie has some outstanding documentation comments and I'd like to make
> > > > > > sure everyone has an opportunity to check that their comments have been
> > > > > > addressed and we don't discover any new blocking issues.  Please send
> > > > > > your Acked-by/Reviewed-by/Tested-by tags if you're satisfied with this
> > > > > > interface and implementation.  Thanks!
> > > > > hi Alex and Kirti,
> > > > > after porting to qemu v22 and kernel v22, it is found out that
> > > > > it can not even pass basic live migration test with error like
> > > > > 
> > > > > "Failed to get dirty bitmap for iova: 0xca000 size: 0x3000 err: 22"
> > > > 
> > > > Thanks for testing Yan.
> > > > I think last moment change in below cause this failure
> > > > 
> > > > https://lore.kernel.org/kvm/1589871178-8282-1-git-send-email-kwankhede@nvidia.com/
> > > > 
> > > >   > 	if (dma->iova > iova + size)
> > > >   > 		break;
> > > > 
> > > > Surprisingly with my basic testing with 2G sys mem QEMU didn't raise
> > > > abort on g_free, but I do hit this with large sys mem.
> > > > With above change, that function iterated through next vfio_dma as well.
> > > > Check should be as below:
> > > > 
> > > > -               if (dma->iova > iova + size)
> > > > +               if (dma->iova > iova + size -1)
> > > 
> > > 
> > > Or just:
> > > 
> > > 	if (dma->iova >= iova + size)
> > > 
> > > Thanks,
> > > Alex
> > > 
> > > 
> > > >                           break;
> > > > 
> > > > Another fix is in QEMU.
> > > > https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04751.html
> > > > 
> > > >   > > +        range->bitmap.size = ROUND_UP(pages, 64) / 8;
> > > >   >
> > > >   > ROUND_UP(npages/8, sizeof(u64))?
> > > >   >
> > > > 
> > > > If npages < 8, npages/8 is 0 and ROUND_UP(0, 8) returns 0.
> > > > 
> > > > Changing it as below
> > > > 
> > > > -        range->bitmap.size = ROUND_UP(pages / 8, sizeof(uint64_t));
> > > > +        range->bitmap.size = ROUND_UP(pages, sizeof(__u64) *
> > > > BITS_PER_BYTE) /
> > > > +                             BITS_PER_BYTE;
> > > > 
> > > > I'm updating patches with these fixes and Cornelia's suggestion soon.
> > > > 
> > > > Due to short of time I may not be able to address all the concerns
> > > > raised on previous versions of QEMU, I'm trying make QEMU side code
> > > > available for testing for others with latest kernel changes. Don't
> > > > worry, I will revisit comments on QEMU patches. Right now first priority
> > > > is to test kernel UAPI and prepare kernel patches for 5.8
> > > > 
> > > 
> > hi Kirti
> > by updating kernel/qemu to v23, still met below two types of errors.
> > just basic migration test.
> > (the guest VM size is 2G for all reported bugs).
> > 
> > "Failed to get dirty bitmap for iova: 0xfe011000 size: 0x3fb0 err: 22"
> > 
> 
> size doesn't look correct here, below check should be failing.
>  range.size & (iommu_pgsize - 1)
> 
> > or
> > 
> > "qemu-system-x86_64-lm: vfio_load_state: Error allocating buffer
> > qemu-system-x86_64-lm: error while loading state section id 49(vfio)
> > qemu-system-x86_64-lm: load of migration failed: Cannot allocate memory"
> > 
> > 
> 
> Above error is from:
>         buf = g_try_malloc0(data_size);
>         if (!buf) {
>             error_report("%s: Error allocating buffer ", __func__);
>             return -ENOMEM;
>         }
> 
> Seems you are running out of memory?
>
no. my host memory is about 60G.
just migrate with command "migrate -d xxx" without speed limit.
FYI.

Yan

