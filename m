Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518FCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2954E2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 08:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2954E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0hGg-0007k1-Dc
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 04:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k0hG6-0007KX-WB
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 04:16:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:52111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k0hG3-00008f-QD
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 04:16:18 -0400
IronPort-SDR: wGbWRx4a0oUw7aExuSIH/gltE5G5b5FHzgBTJ87nA8yTpiN4ZEbHoWO5ROtmOUFoQQqxvF/8i6
 wRFABqiugEiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="169495745"
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; d="scan'208";a="169495745"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 01:16:08 -0700
IronPort-SDR: 1dL7eESQy3S4CzfY0WiUsDLDiOlAS45EurNMq3Y+lv4o7dmE0K2wEsCoqwcOeE19T0vO6BzkO6
 fFnV9lZCim5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; d="scan'208";a="434613735"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 01:16:02 -0700
Date: Wed, 29 Jul 2020 16:05:03 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200729080503.GB28676@joy-OptiPlex-7040>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <9bfa8700-91f5-ebb4-3977-6321f0487a63@redhat.com>
 <20200716083230.GA25316@joy-OptiPlex-7040>
 <20200717101258.65555978@x1.home>
 <20200721005113.GA10502@joy-OptiPlex-7040>
 <20200727072440.GA28676@joy-OptiPlex-7040>
 <20200727162321.7097070e@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727162321.7097070e@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.88; envelope-from=yan.y.zhao@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 04:16:09
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, eskultet@redhat.com, jian-feng.ding@intel.com,
 dgilbert@redhat.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org,
 berrange@redhat.com, cohuck@redhat.com, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 04:23:21PM -0600, Alex Williamson wrote:
> On Mon, 27 Jul 2020 15:24:40 +0800
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > > > As you indicate, the vendor driver is responsible for checking version
> > > > information embedded within the migration stream.  Therefore a
> > > > migration should fail early if the devices are incompatible.  Is it  
> > > but as I know, currently in VFIO migration protocol, we have no way to
> > > get vendor specific compatibility checking string in migration setup stage
> > > (i.e. .save_setup stage) before the device is set to _SAVING state.
> > > In this way, for devices who does not save device data in precopy stage,
> > > the migration compatibility checking is as late as in stop-and-copy
> > > stage, which is too late.
> > > do you think we need to add the getting/checking of vendor specific
> > > compatibility string early in save_setup stage?
> > >  
> > hi Alex,
> > after an offline discussion with Kevin, I realized that it may not be a
> > problem if migration compatibility check in vendor driver occurs late in
> > stop-and-copy phase for some devices, because if we report device
> > compatibility attributes clearly in an interface, the chances for
> > libvirt/openstack to make a wrong decision is little.
> 
> I think it would be wise for a vendor driver to implement a pre-copy
> phase, even if only to send version information and verify it at the
> target.  Deciding you have no device state to send during pre-copy does
> not mean your vendor driver needs to opt-out of the pre-copy phase
> entirely.  Please also note that pre-copy is at the user's discretion,
> we've defined that we can enter stop-and-copy at any point, including
> without a pre-copy phase, so I would recommend that vendor drivers
> validate compatibility at the start of both the pre-copy and the
> stop-and-copy phases.
>
ok. got it!

> > so, do you think we are now arriving at an agreement that we'll give up
> > the read-and-test scheme and start to defining one interface (perhaps in
> > json format), from which libvirt/openstack is able to parse and find out
> > compatibility list of a source mdev/physical device?
> 
> Based on the feedback we've received, the previously proposed interface
> is not viable.  I think there's agreement that the user needs to be
> able to parse and interpret the version information.  Using json seems
> viable, but I don't know if it's the best option.  Is there any
> precedent of markup strings returned via sysfs we could follow?
I found some examples of using formatted string under /sys, mostly under
tracing. maybe we can do a similar implementation.

#cat /sys/kernel/debug/tracing/events/kvm/kvm_mmio/format

name: kvm_mmio
ID: 32
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:u32 type; offset:8;       size:4; signed:0;
        field:u32 len;  offset:12;      size:4; signed:0;
        field:u64 gpa;  offset:16;      size:8; signed:0;
        field:u64 val;  offset:24;      size:8; signed:0;

print fmt: "mmio %s len %u gpa 0x%llx val 0x%llx", __print_symbolic(REC->type, { 0, "unsatisfied-read" }, { 1, "read" }, { 2, "write" }), REC->len, REC->gpa, REC->val


#cat /sys/devices/pci0000:00/0000:00:02.0/uevent
DRIVER=vfio-pci
PCI_CLASS=30000
PCI_ID=8086:591D
PCI_SUBSYS_ID=8086:2212
PCI_SLOT_NAME=0000:00:02.0
MODALIAS=pci:v00008086d0000591Dsv00008086sd00002212bc03sc00i00

> 
> Your idea of having both a "self" object and an array of "compatible"
> objects is perhaps something we can build on, but we must not assume
> PCI devices at the root level of the object.  Providing both the
> mdev-type and the driver is a bit redundant, since the former includes
> the latter.  We can't have vendor specific versioning schemes though,
> ie. gvt-version. We need to agree on a common scheme and decide which
> fields the version is relative to, ex. just the mdev type?
what about making all comparing fields vendor specific?
userspace like openstack only needs to parse and compare if target
device is within source compatible list without understanding the meaning
of each field.

> I had also proposed fields that provide information to create a
> compatible type, for example to create a type_x2 device from a type_x1
> mdev type, they need to know to apply an aggregation attribute.  If we
> need to explicitly list every aggregation value and the resulting type,
> I think we run aground of what aggregation was trying to avoid anyway,
> so we might need to pick a language that defines variable substitution
> or some kind of tagging.  For example if we could define ${aggr} as an
> integer within a specified range, then we might be able to define a type
> relative to that value (type_x${aggr}) which requires an aggregation
> attribute using the same value.  I dunno, just spit balling.  Thanks,
what about a migration_compatible attribute under device node like
below?

#cat /sys/bus/pci/devices/0000\:00\:02.0/UUID1/migration_compatible
SELF:
	device_type=pci
	device_id=8086591d
	mdev_type=i915-GVTg_V5_2
	aggregator=1
	pv_mode="none+ppgtt+context"
	interface_version=3
COMPATIBLE:
	device_type=pci
	device_id=8086591d
	mdev_type=i915-GVTg_V5_{val1:int:1,2,4,8}
	aggregator={val1}/2
	pv_mode={val2:string:"none+ppgtt","none+context","none+ppgtt+context"} 
	interface_version={val3:int:2,3}
COMPATIBLE:
	device_type=pci
	device_id=8086591d
	mdev_type=i915-GVTg_V5_{val1:int:1,2,4,8}
	aggregator={val1}/2
	pv_mode=""  #"" meaning empty, could be absent in a compatible device
	interface_version=1


#cat /sys/bus/pci/devices/0000\:00\:02.0/UUID2/migration_compatible
SELF:
	device_type=pci
	device_id=8086591d
	mdev_type=i915-GVTg_V5_4
	aggregator=2
	interface_version=1
COMPATIBLE: 
	device_type=pci
	device_id=8086591d
	mdev_type=i915-GVTg_V5_{val1:int:1,2,4,8}
	aggregator={val1}/2
	interface_version=1


Notes:
- A COMPATIBLE object is a line starting with COMPATIBLE.
  It specifies a list of compatible devices that are allowed to migrate
  in.
  The reason to allow multiple COMPATIBLE objects is that when it
  is hard to express a complex compatible logic in one COMPATIBLE
  object, a simple enumeration is still a fallback.
  in the above example, device UUID2 is in the compatible list of
  device UUID1, but device UUID1 is not in the compatible list of device
  UUID2, so device UUID2 is able to migrate to device UUID1, but device
  UUID1 is not able to migrate to device UUID2.

- fields under each object are of "and" relationship to each other,  meaning
  all fields of SELF object of a target device must be equal to corresponding
  fields of a COMPATIBLE object of source device, otherwise it is regarded as not
  compatible.

- each field, however, is able to specify multiple allowed values, using
  variables as explained below.

- variables are represented with {}, the first appearance of one variable
  specifies its type and allowed list. e.g.
  {val1:int:1,2,4,8} represents var1 whose type is integer and allowed
  values are 1, 2, 4, 8.

- vendors are able to specify which fields are within the comparing list
  and which fields are not. e.g. for physical VF migration, it may not
  choose mdev_type as a comparing field, and maybe use driver name instead.
 

Thanks
Yan



