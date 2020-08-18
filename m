Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AACC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5895207DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 03:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEtmu7vA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5895207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7sG9-0002bn-VK
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 23:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k7sFN-00024x-Gj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 23:25:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k7sFL-0008CP-76
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 23:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597721109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NN8cpkmmzd+gIshGfVJZRN/csbLtvOwEsIlzPP5rJmg=;
 b=AEtmu7vAvX2y1RyQDP1gDc+HUpWZKE66CYAyhmlxOAwPym0BWsaCLQx8j3OaRnbPR/jhdY
 jeCIUt6T24PhIl5VuD2B8ouSnJ+bxzYJp3nXlAY7KsHWdACcyHWbSm3kUXg+t7sV+rm4V/
 88T9wePH8VvrpR07V8pmph+VQwzkeQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-Kx5BTRbaMhu7ueNFw8QxKA-1; Mon, 17 Aug 2020 23:24:52 -0400
X-MC-Unique: Kx5BTRbaMhu7ueNFw8QxKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 474AB18686C6;
 Tue, 18 Aug 2020 03:24:50 +0000 (UTC)
Received: from [10.72.13.202] (ovpn-13-202.pek2.redhat.com [10.72.13.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4EA65D9D2;
 Tue, 18 Aug 2020 03:24:31 +0000 (UTC)
Subject: Re: device compatibility interface for live migration with assigned
 devices
To: Yan Zhao <yan.y.zhao@intel.com>
References: <20200804183503.39f56516.cohuck@redhat.com>
 <c178a0d3-269d-1620-22b1-9010f602d8ff@redhat.com>
 <20200805021654.GB30485@joy-OptiPlex-7040>
 <2624b12f-3788-7e2b-2cb7-93534960bcb7@redhat.com>
 <20200805075647.GB2177@nanopsycho>
 <eb1d01c2-fbad-36b6-10cf-9e03483a736b@redhat.com>
 <20200805093338.GC30485@joy-OptiPlex-7040> <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
Date: Tue, 18 Aug 2020 11:24:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814051601.GD15344@joy-OptiPlex-7040>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: none client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 22:42:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 kwankhede@nvidia.com, eauger@redhat.com, xin-ran.wang@intel.com,
 corbet@lwn.net, openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn,
 Alex Williamson <alex.williamson@redhat.com>, eskultet@redhat.com,
 smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org, berrange@redhat.com,
 Cornelia Huck <cohuck@redhat.com>, Jiri Pirko <jiri@mellanox.com>,
 dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/14 下午1:16, Yan Zhao wrote:
> On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
>> On 2020/8/10 下午3:46, Yan Zhao wrote:
>>>> driver is it handled by?
>>> It looks that the devlink is for network device specific, and in
>>> devlink.h, it says
>>> include/uapi/linux/devlink.h - Network physical device Netlink
>>> interface,
>>
>> Actually not, I think there used to have some discussion last year and the
>> conclusion is to remove this comment.
>>
>> It supports IB and probably vDPA in the future.
>>
> hmm... sorry, I didn't find the referred discussion. only below discussion
> regarding to why to add devlink.
>
> https://www.mail-archive.com/netdev@vger.kernel.org/msg95801.html
> 	>This doesn't seem to be too much related to networking? Why can't something
> 	>like this be in sysfs?
> 	
> 	It is related to networking quite bit. There has been couple of
> 	iteration of this, including sysfs and configfs implementations. There
> 	has been a consensus reached that this should be done by netlink. I
> 	believe netlink is really the best for this purpose. Sysfs is not a good
> 	idea


See the discussion here:

https://patchwork.ozlabs.org/project/netdev/patch/20191115223355.1277139-1-jeffrey.t.kirsher@intel.com/


>
> https://www.mail-archive.com/netdev@vger.kernel.org/msg96102.html
> 	>there is already a way to change eth/ib via
> 	>echo 'eth' > /sys/bus/pci/drivers/mlx4_core/0000:02:00.0/mlx4_port1
> 	>
> 	>sounds like this is another way to achieve the same?
> 	
> 	It is. However the current way is driver-specific, not correct.
> 	For mlx5, we need the same, it cannot be done in this way. Do devlink is
> 	the correct way to go.
>
> https://lwn.net/Articles/674867/
> 	There a is need for some userspace API that would allow to expose things
> 	that are not directly related to any device class like net_device of
> 	ib_device, but rather chip-wide/switch-ASIC-wide stuff.
>
> 	Use cases:
> 	1) get/set of port type (Ethernet/InfiniBand)
> 	2) monitoring of hardware messages to and from chip
> 	3) setting up port splitters - split port into multiple ones and squash again,
> 	   enables usage of splitter cable
> 	4) setting up shared buffers - shared among multiple ports within one chip
>
>
>
> we actually can also retrieve the same information through sysfs, .e.g
>
> |- [path to device]
>    |--- migration
>    |     |--- self
>    |     |   |---device_api
>    |	|   |---mdev_type
>    |	|   |---software_version
>    |	|   |---device_id
>    |	|   |---aggregator
>    |     |--- compatible
>    |     |   |---device_api
>    |	|   |---mdev_type
>    |	|   |---software_version
>    |	|   |---device_id
>    |	|   |---aggregator
>

Yes but:

- You need one file per attribute (one syscall for one attribute)
- Attribute is coupled with kobject

All of above seems unnecessary.

Another point, as we discussed in another thread, it's really hard to 
make sure the above API work for all types of devices and frameworks. So 
having a vendor specific API looks much better.


>
>>>    I feel like it's not very appropriate for a GPU driver to use
>>> this interface. Is that right?
>>
>> I think not though most of the users are switch or ethernet devices. It
>> doesn't prevent you from inventing new abstractions.
> so need to patch devlink core and the userspace devlink tool?
> e.g. devlink migration


It quite flexible, you can extend devlink, invent your own or let mgmt 
to establish devlink directly.


>
>> Note that devlink is based on netlink, netlink has been widely used by
>> various subsystems other than networking.
> the advantage of netlink I see is that it can monitor device status and
> notify upper layer that migration database needs to get updated.


I may miss something, but why this is needed?

 From device point of view, the following capability should be 
sufficient to support live migration:

- set/get device state
- report dirty page tracking
- set/get capability


> But not sure whether openstack would like to use this capability.
> As Sean said, it's heavy for openstack. it's heavy for vendor driver
> as well :)


Well, it depends several factors. Just counting LOCs, sysfs based 
attributes is not lightweight.

Thanks


>
> And devlink monitor now listens the notification and dumps the state
> changes. If we want to use it, need to let it forward the notification
> and dumped info to openstack, right?
>
> Thanks
> Yan
>


