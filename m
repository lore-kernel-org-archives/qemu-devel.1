Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D11C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B2E2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B2E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Fzd-00079V-MU
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k3Fye-0006Du-CH
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:44:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:51396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k3Fyb-00070u-4V
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:44:51 -0400
IronPort-SDR: kMOrjC0g5Pgjs6xSycX5MIz0crsHQqqGO1tZ+QIPbw+5M6uunILqhndCJT/M9HIGsPt5eWf83Z
 t8a9sMpGxMJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="152468804"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; d="scan'208";a="152468804"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2020 02:44:45 -0700
IronPort-SDR: 7Rw+vlspXpYML9a63JeRkfX1j4VXbBA2Z/iOaMJP+a5uvKx+EoK1iNGHobBPgV7qCukX+dxwb7
 aq0Z2D68P5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; d="scan'208";a="492766035"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga006.fm.intel.com with ESMTP; 05 Aug 2020 02:44:40 -0700
Date: Wed, 5 Aug 2020 17:33:38 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200805093338.GC30485@joy-OptiPlex-7040>
References: <20200721005113.GA10502@joy-OptiPlex-7040>
 <20200727072440.GA28676@joy-OptiPlex-7040>
 <20200727162321.7097070e@x1.home>
 <20200729080503.GB28676@joy-OptiPlex-7040>
 <20200804183503.39f56516.cohuck@redhat.com>
 <c178a0d3-269d-1620-22b1-9010f602d8ff@redhat.com>
 <20200805021654.GB30485@joy-OptiPlex-7040>
 <2624b12f-3788-7e2b-2cb7-93534960bcb7@redhat.com>
 <20200805075647.GB2177@nanopsycho>
 <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yan.y.zhao@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 05:44:45
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, eskultet@redhat.com,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>, smooney@redhat.com,
 intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com, corbet@lwn.net,
 Jiri Pirko <jiri@mellanox.com>, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 05, 2020 at 04:02:48PM +0800, Jason Wang wrote:
> 
> On 2020/8/5 下午3:56, Jiri Pirko wrote:
> > Wed, Aug 05, 2020 at 04:41:54AM CEST, jasowang@redhat.com wrote:
> > > On 2020/8/5 上午10:16, Yan Zhao wrote:
> > > > On Wed, Aug 05, 2020 at 10:22:15AM +0800, Jason Wang wrote:
> > > > > On 2020/8/5 上午12:35, Cornelia Huck wrote:
> > > > > > [sorry about not chiming in earlier]
> > > > > > 
> > > > > > On Wed, 29 Jul 2020 16:05:03 +0800
> > > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > > > 
> > > > > > > On Mon, Jul 27, 2020 at 04:23:21PM -0600, Alex Williamson wrote:
> > > > > > (...)
> > > > > > 
> > > > > > > > Based on the feedback we've received, the previously proposed interface
> > > > > > > > is not viable.  I think there's agreement that the user needs to be
> > > > > > > > able to parse and interpret the version information.  Using json seems
> > > > > > > > viable, but I don't know if it's the best option.  Is there any
> > > > > > > > precedent of markup strings returned via sysfs we could follow?
> > > > > > I don't think encoding complex information in a sysfs file is a viable
> > > > > > approach. Quoting Documentation/filesystems/sysfs.rst:
> > > > > > 
> > > > > > "Attributes should be ASCII text files, preferably with only one value
> > > > > > per file. It is noted that it may not be efficient to contain only one
> > > > > > value per file, so it is socially acceptable to express an array of
> > > > > > values of the same type.
> > > > > > Mixing types, expressing multiple lines of data, and doing fancy
> > > > > > formatting of data is heavily frowned upon."
> > > > > > 
> > > > > > Even though this is an older file, I think these restrictions still
> > > > > > apply.
> > > > > +1, that's another reason why devlink(netlink) is better.
> > > > > 
> > > > hi Jason,
> > > > do you have any materials or sample code about devlink, so we can have a good
> > > > study of it?
> > > > I found some kernel docs about it but my preliminary study didn't show me the
> > > > advantage of devlink.
> > > 
> > > CC Jiri and Parav for a better answer for this.
> > > 
> > > My understanding is that the following advantages are obvious (as I replied
> > > in another thread):
> > > 
> > > - existing users (NIC, crypto, SCSI, ib), mature and stable
> > > - much better error reporting (ext_ack other than string or errno)
> > > - namespace aware
> > > - do not couple with kobject
> > Jason, what is your use case?
> 
> 
> I think the use case is to report device compatibility for live migration.
> Yan proposed a simple sysfs based migration version first, but it looks not
> sufficient and something based on JSON is discussed.
> 
> Yan, can you help to summarize the discussion so far for Jiri as a
> reference?
> 
yes.
we are currently defining an device live migration compatibility
interface in order to let user space like openstack and libvirt knows
which two devices are live migration compatible.
currently the devices include mdev (a kernel emulated virtual device)
and physical devices (e.g.  a VF of a PCI SRIOV device).

the attributes we want user space to compare including
common attribues:
    device_api: vfio-pci, vfio-ccw...
    mdev_type: mdev type of mdev or similar signature for physical device
               It specifies a device's hardware capability. e.g.
	       i915-GVTg_V5_4 means it's of 1/4 of a gen9 Intel graphics
	       device.
    software_version: device driver's version.
               in <major>.<minor>[.bugfix] scheme, where there is no
	       compatibility across major versions, minor versions have
	       forward compatibility (ex. 1-> 2 is ok, 2 -> 1 is not) and
	       bugfix version number indicates some degree of internal
	       improvement that is not visible to the user in terms of
	       features or compatibility,

vendor specific attributes: each vendor may define different attributes
   device id : device id of a physical devices or mdev's parent pci device.
               it could be equal to pci id for pci devices
   aggregator: used together with mdev_type. e.g. aggregator=2 together
               with i915-GVTg_V5_4 means 2*1/4=1/2 of a gen9 Intel
	       graphics device.
   remote_url: for a local NVMe VF, it may be configured with a remote
               url of a remote storage and all data is stored in the
	       remote side specified by the remote url.
   ...

Comparing those attributes by user space alone is not an easy job, as it
can't simply assume an equal relationship between source attributes and
target attributes. e.g.
for a source device of mdev_type=i915-GVTg_V5_4,aggregator=2, (1/2 of
gen9), it actually could find a compatible device of
mdev_type=i915-GVTg_V5_8,aggregator=4 (also 1/2 of gen9),
if mdev_type of i915-GVTg_V5_4 is not available in the target machine.

So, in our current proposal, we want to create two sysfs attributes
under a device sysfs node.
/sys/<path to device>/migration/self
/sys/<path to device>/migration/compatible

#cat /sys/<path to device>/migration/self
device_type=vfio_pci
mdev_type=i915-GVTg_V5_4
device_id=8086591d
aggregator=2
software_version=1.0.0

#cat /sys/<path to device>/migration/compatible
device_type=vfio_pci
mdev_type=i915-GVTg_V5_{val1:int:2,4,8}
device_id=8086591d
aggregator={val1}/2
software_version=1.0.0

The /sys/<path to device>/migration/self specifies self attributes of
a device.
The /sys/<path to device>/migration/compatible specifies the list of
compatible devices of a device. as in the example, compatible devices
could have
	device_type == vfio_pci &&
	device_id == 8086591d   &&
	software_version == 1.0.0 &&
        (
	(mdev_type of i915-GVTg_V5_2 && aggregator==1) ||
	(mdev_type of i915-GVTg_V5_4 && aggregator==2) ||
	(mdev_type of i915-GVTg_V5_8 && aggregator=4)
	)

by comparing whether a target device is in compatible list of source
device, the user space can know whether a two devices are live migration
compatible.

Additional notes:
1)software_version in the compatible list may not be necessary as it
already has a major.minor.bugfix scheme.
2)for vendor attribute like remote_url, it may not be statically
assigned and could be changed with a device interface.

So, as Cornelia pointed that it's not good to use complex format in
a sysfs attribute, we'd like to know whether there're other good ways to
our use case, e.g. splitting a single attribute to multiple simple sysfs
attributes as what Cornelia suggested or devlink that Jason has strongly
recommended.

Thanks
Yan




