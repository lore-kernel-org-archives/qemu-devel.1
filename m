Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA446C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 05:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C26A20791
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 05:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C26A20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6SME-00024f-SR
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 01:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k6SLh-0001eZ-0w
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 01:33:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:34462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k6SLd-0002fi-W3
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 01:33:52 -0400
IronPort-SDR: CrRiXL5pNT7p+CEdQYeo6CqP2cUBFaIdXMzovgI0ik24CF9kblzHFuB1/jzRJoWcdK7kSIALTA
 oTjjOYrwEuvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="154323690"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="154323690"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 22:33:42 -0700
IronPort-SDR: 17ObhB5L4p5rZsodtaj4w23ZImAhmDiWJogmKa2wPSRra7i4k7Xor01hjtt9SY9BA0hx1EzUd4
 hSz/jzm8mpvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="325623341"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga008.jf.intel.com with ESMTP; 13 Aug 2020 22:33:36 -0700
Date: Fri, 14 Aug 2020 13:16:01 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200814051601.GD15344@joy-OptiPlex-7040>
References: <20200804183503.39f56516.cohuck@redhat.com>
 <c178a0d3-269d-1620-22b1-9010f602d8ff@redhat.com>
 <20200805021654.GB30485@joy-OptiPlex-7040>
 <2624b12f-3788-7e2b-2cb7-93534960bcb7@redhat.com>
 <20200805075647.GB2177@nanopsycho>
 <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
 <20200805093338.GC30485@joy-OptiPlex-7040>
 <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yan.y.zhao@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 01:33:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 kwankhede@nvidia.com, eauger@redhat.com, xin-ran.wang@intel.com,
 corbet@lwn.net, eskultet@redhat.com, openstack-discuss@lists.openstack.org,
 shaohe.feng@intel.com, kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>, smooney@redhat.com,
 intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com,
 Cornelia Huck <cohuck@redhat.com>, Jiri Pirko <jiri@mellanox.com>,
 dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
> 
> On 2020/8/10 下午3:46, Yan Zhao wrote:
> > > driver is it handled by?
> > It looks that the devlink is for network device specific, and in
> > devlink.h, it says
> > include/uapi/linux/devlink.h - Network physical device Netlink
> > interface,
> 
> 
> Actually not, I think there used to have some discussion last year and the
> conclusion is to remove this comment.
> 
> It supports IB and probably vDPA in the future.
>
hmm... sorry, I didn't find the referred discussion. only below discussion
regarding to why to add devlink.

https://www.mail-archive.com/netdev@vger.kernel.org/msg95801.html
	>This doesn't seem to be too much related to networking? Why can't something
	>like this be in sysfs?
	
	It is related to networking quite bit. There has been couple of
	iteration of this, including sysfs and configfs implementations. There
	has been a consensus reached that this should be done by netlink. I
	believe netlink is really the best for this purpose. Sysfs is not a good
	idea

https://www.mail-archive.com/netdev@vger.kernel.org/msg96102.html
	>there is already a way to change eth/ib via
	>echo 'eth' > /sys/bus/pci/drivers/mlx4_core/0000:02:00.0/mlx4_port1
	>
	>sounds like this is another way to achieve the same?
	
	It is. However the current way is driver-specific, not correct.
	For mlx5, we need the same, it cannot be done in this way. Do devlink is
	the correct way to go.

https://lwn.net/Articles/674867/
	There a is need for some userspace API that would allow to expose things
	that are not directly related to any device class like net_device of
	ib_device, but rather chip-wide/switch-ASIC-wide stuff.

	Use cases:
	1) get/set of port type (Ethernet/InfiniBand)
	2) monitoring of hardware messages to and from chip
	3) setting up port splitters - split port into multiple ones and squash again,
	   enables usage of splitter cable
	4) setting up shared buffers - shared among multiple ports within one chip



we actually can also retrieve the same information through sysfs, .e.g

|- [path to device]
  |--- migration
  |     |--- self
  |     |   |---device_api
  |	|   |---mdev_type
  |	|   |---software_version
  |	|   |---device_id
  |	|   |---aggregator
  |     |--- compatible
  |     |   |---device_api
  |	|   |---mdev_type
  |	|   |---software_version
  |	|   |---device_id
  |	|   |---aggregator



> 
> >   I feel like it's not very appropriate for a GPU driver to use
> > this interface. Is that right?
> 
> 
> I think not though most of the users are switch or ethernet devices. It
> doesn't prevent you from inventing new abstractions.
so need to patch devlink core and the userspace devlink tool?
e.g. devlink migration

> Note that devlink is based on netlink, netlink has been widely used by
> various subsystems other than networking.

the advantage of netlink I see is that it can monitor device status and
notify upper layer that migration database needs to get updated.
But not sure whether openstack would like to use this capability.
As Sean said, it's heavy for openstack. it's heavy for vendor driver
as well :)

And devlink monitor now listens the notification and dumps the state
changes. If we want to use it, need to let it forward the notification
and dumped info to openstack, right?

Thanks
Yan

