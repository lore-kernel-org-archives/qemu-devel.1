Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F01C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 00:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65424206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 00:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65424206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiovK-00045r-LE
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 20:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jiouH-0003RE-NK
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 20:47:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:8453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jiouC-0005rW-32
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 20:47:51 -0400
IronPort-SDR: Is+E6JNanilItMye2iSs3zVbyLcvt6RMiw3R+1+k3+O7QpqMBZCZ9X/w9k7t4/vbjpBSYyJBPK
 nRpU7HuFuvNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 17:47:37 -0700
IronPort-SDR: QHcPfuhEyFKZBZGjv+AHLb7yD2CX3AfJvttvnBGdLUuD6msGHxR475WDT/GQscKUbvJDThKhXl
 p/p9QbJDCm7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,494,1583222400"; d="scan'208";a="349688773"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga001.jf.intel.com with ESMTP; 09 Jun 2020 17:47:29 -0700
Date: Tue, 9 Jun 2020 20:37:31 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200610003731.GA13961@joy-OptiPlex-7040>
References: <20200429094844.GE2834@work-vm>
 <20200430003949.GN12879@joy-OptiPlex-7040>
 <20200602165527.34137955@x1.home>
 <20200603031948.GB12300@joy-OptiPlex-7040>
 <20200602215528.7a1008f0@x1.home>
 <20200603052443.GC12300@joy-OptiPlex-7040>
 <20200603102628.017e2896@x1.home> <20200605102224.GB2936@work-vm>
 <20200605083149.1809e783@x1.home> <20200605143950.GG2897@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605143950.GG2897@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=yan.y.zhao@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 20:47:37
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
Cc: Cornelia Huck <cohuck@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Yang, Ziye" <ziye.yang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
 "He, Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 05, 2020 at 03:39:50PM +0100, Dr. David Alan Gilbert wrote:
> > > > I tried to simplify the problem a bit, but we keep going backwards.  If
> > > > the requirement is that potentially any source device can migrate to any
> > > > target device and we cannot provide any means other than writing an
> > > > opaque source string into a version attribute on the target and
> > > > evaluating the result to determine compatibility, then we're requiring
> > > > userspace to do an exhaustive search to find a potential match.  That
> > > > sucks.   
> > >
hi Alex and Dave,
do you think it's good for us to put aside physical devices and mdev aggregation
for the moment, and use Alex's original idea that

+  Userspace should regard two mdev devices compatible when ALL of below
+  conditions are met:
+  (0) The mdev devices are of the same type
+  (1) success when reading from migration_version attribute of one mdev device.
+  (2) success when writing migration_version string of one mdev device to
+  migration_version attribute of the other mdev device.

and what about adding another sysfs attribute for vendors to put
recommended migration compatible device type. e.g.
#cat /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_8/migration_compatible_devices
parent id: 8086 591d
mdev_type: i915-GVTg_V5_8

vendors are free to define the format and conent of this migration_compatible_devices
and it's even not to be a full list.

before libvirt or user to do live migration, they have to read and test
migration_version attributes of src/target devices to check migration compatibility.

Thanks
Yan


> > > Why is the mechanism a 'write and test' why isn't it a 'write and ask'?
> > > i.e. the destination tells the driver what type it's received from the
> > > source, and the driver replies with a set of compatible configurations
> > > (in some preferred order).
> > 
> > A 'write and ask' interface would imply some sort of session in order
> > to not be racy with concurrent users.  More likely this would imply an
> > ioctl interface, which I don't think we have in sysfs.  Where do we
> > host this ioctl?
> 
> Or one fd?
>   f=open()
>   write(f, "The ID I want")
>   do {
>      read(f, ...)  -> The IDs we're offering that are compatible
>   } while (!eof)
> 
> > > It's also not clear to me why the name has to be that opaque;
> > > I agree it's only got to be understood by the driver but that doesn't
> > > seem to be a reason for the driver to make it purposely obfuscated.
> > > I wouldn't expect a user to be able to parse it necessarily; but would
> > > expect something that would be useful for an error message.
> > 
> > If the name is not opaque, then we're going to rat hole on the format
> > and the fields and evolving that format for every feature a vendor
> > decides they want the user to be able to parse out of the version
> > string.  Then we require a full specification of the string in order
> > that it be parsed according to a standard such that we don't break
> > users inferring features in subtly different ways.
> > 
> > This is a lot like the problems with mdev description attributes,
> > libvirt complains they can't use description because there's no
> > standard formatting, but even with two vendors describing the same class
> > of device we don't have an agreed set of things to expose in the
> > description attribute.  Thanks,
> 
> I'm not suggesting anything in anyway machine parsable; just something
> human readable that you can present in a menu/choice/configuration/error
> message.  The text would be down to the vendor, and I'd suggest it start
> with the vendor name just as a disambiguator and to make it obvious when
> we get it grossly wrong.
> 
> Dave
> 
> > Alex
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

