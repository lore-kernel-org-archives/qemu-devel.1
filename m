Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B2EC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1173220715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1173220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaoqY-0006Fv-2g
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 18:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kaopz-0005iZ-Pz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:38:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:61726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kaopw-0004go-Hn
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:38:39 -0500
IronPort-SDR: aDLRRJnpr546baAbZbKJSbOXWwdf3nIIyJ/j+IGL/teiQddqA/SkxXSW6nnRo3mzdrdArN1Q/K
 rYI0z3hr9tOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="156476851"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; d="scan'208";a="156476851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 15:38:30 -0800
IronPort-SDR: qNheFEMmUO3d32eqVGnbgI0ML20D9/ICLWbSFn92x4P3HgrE4S9aA0yzUJbW7mp2Vpd9RfiZJl
 S4c9e/VT645w==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; d="scan'208";a="539608716"
Received: from joy-optiplex-7040.sh.intel.com (HELO yzhao56-desk)
 ([10.239.13.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 15:38:27 -0800
Date: Fri, 6 Nov 2020 07:37:03 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201105233702.GA1584@yzhao56-desk>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201102123823.066d156a@w520.home>
 <20201103110324.GA243332@stefanha-x1.localdomain>
 <20201103101305.10254ae4@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103101305.10254ae4@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.20; envelope-from=yan.y.zhao@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 18:38:31
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John G Johnson <john.g.johnson@oracle.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, mtsirkin@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 10:13:05AM -0700, Alex Williamson wrote:
> On Tue, 3 Nov 2020 11:03:24 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:

<...>
>  
> > Management tools need to match the device model/configuration from the
> > source device against the destination device. If the destination is
> > capable of supporting the source's device model/configuration then
> > migration can proceed safely.
> > 
> > Let's look at the case where we are migration from an older version of a
> > device to a newer version. On the source we have:
> > 
> >   model = https://vendor-a.com/my-nic
> > 
> > On the destination we have:
> > 
> >   model = https://vendor-a.com/my-nic
> >   rss = on
> > 
> > The two devices are incompatible because the destination exposes the RSS
> > feature that is not present on the source. The RSS feature involves
> > guest-visible hardware interface changes and a change to the device
> > state representation. It is not safe to migrate!
> > 
> > In this case an extra configuration step is necessary so that the
> > destination device can accept the device state from the source. The
> > management tool invokes a vendor-specific tool to put the device into
> > the right configuration:
> > 
> >   # vendor-tool set-migration-config --device 0000:00:04.0 \
> >                                      --model https://vendor-a.com/my-nic
> > 
> > (This tool only succeeds when the device is bound to VFIO but not yet
> > opened.)
> > 
> > The tool invokes ioctls on the vendor-specific VFIO driver that does two
> > things:
> > 1. Tells the device to present the old hardware interface without RSS
> > 2. Uses the old device state representation without RSS support
> > 
> > Does this approach fit?
> 
> 
> Should we not require that any sort of configuration like this occurs
> through sysfs?  We must be able to create an instance with a specific
> configuration without using vendor specific tools, therefore in the
> worse case we should be able to remove and recreate an instance as we
> desire without invoking vendor specific tools.  Thanks,
> 
hi Alex,
could mdevctl serve as a general configuration tool to create/destroy/config
mdev devices?

I think previously the main debate is on what is an easy way for management
tool to find and create a compatible target mdev device according to sysfs
info of source mdev device, is it?
as in [1], we have simplified the method to 1:1 matching of mdev_type
in src and target. and we can further force it to be 1:1 matching of
vendor_specific attributes (e.g. pci id) and dynamic resources
(e.g. aggregator, fps,...) and have mdevctl to create a compatible target
for management tools.

Given management tools like openstack are still in their preliminary
stage of supporting mdev devices, could we first settle down the
compatibility sysfs protocol and treat mdevctl as userspace tool
currently?

[1]: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg03273.html

Thanks
Yan

