Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CDFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB422075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB422075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sdC-000758-1f
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k2scS-0006Ap-BC
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:48:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:6113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k2scM-0003Ps-Ok
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:48:23 -0400
IronPort-SDR: Qk64R7wKVCBGScT0MyHS2wGEBr9db/HcrOAwqKfLiSNKzXSPYrtozQyj6TR7lmvmjMqaCdjRSe
 rsdTohxUu+iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="132334457"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; d="scan'208";a="132334457"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2020 01:48:14 -0700
IronPort-SDR: irc5RID6ULqLZNetmbd2upm83OlouI5asaiOG3qd3M8sRHo28+PjSLXy2Sis8HfsZ5nGDWBkND
 2wytEYurr0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; d="scan'208";a="330538296"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2020 01:48:09 -0700
Date: Tue, 4 Aug 2020 16:37:08 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200804083708.GA30485@joy-OptiPlex-7040>
References: <20200716083230.GA25316@joy-OptiPlex-7040>
 <20200717101258.65555978@x1.home>
 <20200721005113.GA10502@joy-OptiPlex-7040>
 <20200727072440.GA28676@joy-OptiPlex-7040>
 <20200727162321.7097070e@x1.home>
 <20200729080503.GB28676@joy-OptiPlex-7040>
 <e8a973ea0bb2bc3eb15649fb1c44599ae3509e84.camel@redhat.com>
 <20200729131255.68730f68@x1.home>
 <20200730034104.GB32327@joy-OptiPlex-7040>
 <20200730112930.6f4c5762@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730112930.6f4c5762@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.151; envelope-from=yan.y.zhao@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 04:48:14
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, eskultet@redhat.com, jian-feng.ding@intel.com,
 dgilbert@redhat.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, Sean Mooney <smooney@redhat.com>,
 intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com, cohuck@redhat.com,
 dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > yes, include a device_api field is better.
> > for mdev, "device_type=vfio-mdev", is it right?
> 
> No, vfio-mdev is not a device API, it's the driver that attaches to the
> mdev bus device to expose it through vfio.  The device_api exposes the
> actual interface of the vfio device, it's also vfio-pci for typical
> mdev devices found on x86, but may be vfio-ccw, vfio-ap, etc...  See
> VFIO_DEVICE_API_PCI_STRING and friends.
> 
ok. got it.

> > > > > 	device_id=8086591d  
> > > 
> > > Is device_id interpreted relative to device_type?  How does this
> > > relate to mdev_type?  If we have an mdev_type, doesn't that fully
> > > defined the software API?
> > >   
> > it's parent pci id for mdev actually.
>
> If we need to specify the parent PCI ID then something is fundamentally
> wrong with the mdev_type.  The mdev_type should define a unique,
> software compatible interface, regardless of the parent device IDs.  If
> a i915-GVTg_V5_2 means different things based on the parent device IDs,
> then then different mdev_types should be reported for those parent
> devices.
>
hmm, then do we allow vendor specific fields?
or is it a must that a vendor specific field should have corresponding
vendor attribute?

another thing is that the definition of mdev_type in GVT only corresponds
to vGPU computing ability currently,
e.g. i915-GVTg_V5_2, is 1/2 of a gen9 IGD, i915-GVTg_V4_2 is 1/2 of a
gen8 IGD.
It is too coarse-grained to live migration compatibility.

Do you think we need to update GVT's definition of mdev_type?
And is there any guide in mdev_type definition?

> > > > > 	mdev_type=i915-GVTg_V5_2  
> > > 
> > > And how are non-mdev devices represented?
> > >   
> > non-mdev can opt to not include this field, or as you said below, a
> > vendor signature. 
> > 
> > > > > 	aggregator=1
> > > > > 	pv_mode="none+ppgtt+context"  
> > > 
> > > These are meaningless vendor specific matches afaict.
> > >   
> > yes, pv_mode and aggregator are vendor specific fields.
> > but they are important to decide whether two devices are compatible.
> > pv_mode means whether a vGPU supports guest paravirtualized api.
> > "none+ppgtt+context" means guest can not use pv, or use ppgtt mode pv or
> > use context mode pv.
> > 
> > > > > 	interface_version=3  
> > > 
> > > Not much granularity here, I prefer Sean's previous
> > > <major>.<minor>[.bugfix] scheme.
> > >   
> > yes, <major>.<minor>[.bugfix] scheme may be better, but I'm not sure if
> > it works for a complicated scenario.
> > e.g for pv_mode,
> > (1) initially,  pv_mode is not supported, so it's pv_mode=none, it's 0.0.0,
> > (2) then, pv_mode=ppgtt is supported, pv_mode="none+ppgtt", it's 0.1.0,
> > indicating pv_mode=none can migrate to pv_mode="none+ppgtt", but not vice versa.
> > (3) later, pv_mode=context is also supported,
> > pv_mode="none+ppgtt+context", so it's 0.2.0.
> > 
> > But if later, pv_mode=ppgtt is removed. pv_mode="none+context", how to
> > name its version? "none+ppgtt" (0.1.0) is not compatible to
> > "none+context", but "none+ppgtt+context" (0.2.0) is compatible to
> > "none+context".
> 
> If pv_mode=ppgtt is removed, then the compatible versions would be
> 0.0.0 or 1.0.0, ie. the major version would be incremented due to
> feature removal.
>  
> > Maintain such scheme is painful to vendor driver.
> 
> Migration compatibility is painful, there's no way around that.  I
> think the version scheme is an attempt to push some of that low level
> burden on the vendor driver, otherwise the management tools need to
> work on an ever growing matrix of vendor specific features which is
> going to become unwieldy and is largely meaningless outside of the
> vendor driver.  Instead, the vendor driver can make strategic decisions
> about where to continue to maintain a support burden and make explicit
> decisions to maintain or break compatibility.  The version scheme is a
> simplification and abstraction of vendor driver features in order to
> create a small, logical compatibility matrix.  Compromises necessarily
> need to be made for that to occur.
>
ok. got it.

> > > > > COMPATIBLE:
> > > > > 	device_type=pci
> > > > > 	device_id=8086591d
> > > > > 	mdev_type=i915-GVTg_V5_{val1:int:1,2,4,8}    
> > > > this mixed notation will be hard to parse so i would avoid that.  
> > > 
> > > Some background, Intel has been proposing aggregation as a solution to
> > > how we scale mdev devices when hardware exposes large numbers of
> > > assignable objects that can be composed in essentially arbitrary ways.
> > > So for instance, if we have a workqueue (wq), we might have an mdev
> > > type for 1wq, 2wq, 3wq,... Nwq.  It's not really practical to expose a
> > > discrete mdev type for each of those, so they want to define a base
> > > type which is composable to other types via this aggregation.  This is
> > > what this substitution and tagging is attempting to accomplish.  So
> > > imagine this set of values for cases where it's not practical to unroll
> > > the values for N discrete types.
> > >   
> > > > > 	aggregator={val1}/2  
> > > 
> > > So the {val1} above would be substituted here, though an aggregation
> > > factor of 1/2 is a head scratcher...
> > >   
> > > > > 	pv_mode={val2:string:"none+ppgtt","none+context","none+ppgtt+context"}  
> > > 
> > > I'm lost on this one though.  I think maybe it's indicating that it's
> > > compatible with any of these, so do we need to list it?  Couldn't this
> > > be handled by Sean's version proposal where the minor version
> > > represents feature compatibility?  
> > yes, it's indicating that it's compatible with any of these.
> > Sean's version proposal may also work, but it would be painful for
> > vendor driver to maintain the versions when multiple similar features
> > are involved.
> 
> This is something vendor drivers need to consider when adding and
> removing features.
> 
> > > > > 	interface_version={val3:int:2,3}  
> > > 
> > > What does this turn into in a few years, 2,7,12,23,75,96,...
> > >   
> > is a range better?
> 
> I was really trying to point out that sparseness becomes an issue if
> the vendor driver is largely disconnected from how their feature
> addition and deprecation affects migration support.  Thanks,
>
ok. we'll use the x.y.z scheme then.

Thanks
Yan

