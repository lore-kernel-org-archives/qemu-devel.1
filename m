Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A751C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4749C206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5d0D2Iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4749C206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8KcX-00064R-Jy
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 05:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k8Kbf-0005Dr-AU
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k8Kbd-00030R-CW
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597830124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krA6GwoXETvw/+Dx+bQg8FPzweKaKAhvXBzivf1bST0=;
 b=I5d0D2IwQdGPP3LQqsTddkCh0cozeiKInuN3ldIx6tGlRSEraTAqRwPV2ewJFB/ucG0jCG
 75H6KtRfapuXUcC80jhOfWtbrjurxKGQJKQqA1ce50gWjbsoMbs6WX4KYH+2761ATQ0JNP
 wN7sP9HUabfLSUtgCK6WWZVjaeaNkeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-eW0SMPrGMC2JFTmteODetA-1; Wed, 19 Aug 2020 05:42:01 -0400
X-MC-Unique: eW0SMPrGMC2JFTmteODetA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F37D5186A56E;
 Wed, 19 Aug 2020 09:41:58 +0000 (UTC)
Received: from [10.72.13.88] (ovpn-13-88.pek2.redhat.com [10.72.13.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD78D7B90C;
 Wed, 19 Aug 2020 09:41:40 +0000 (UTC)
Subject: Re: device compatibility interface for live migration with assigned
 devices
To: Parav Pandit <parav@nvidia.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <BY5PR12MB4322C9D1A66C4657776A1383DC5C0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20200819033035.GA21172@joy-OptiPlex-7040>
 <BY5PR12MB43226CABD003285D0C77E2B7DC5D0@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b766fa9c-ed53-b6be-9c2b-ea8bbe85967b@redhat.com>
Date: Wed, 19 Aug 2020 17:41:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB43226CABD003285D0C77E2B7DC5D0@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 05:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "xin-ran.wang@intel.com" <xin-ran.wang@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "openstack-discuss@lists.openstack.org"
 <openstack-discuss@lists.openstack.org>,
 "shaohe.feng@intel.com" <shaohe.feng@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 Parav Pandit <parav@mellanox.com>,
 "jian-feng.ding@intel.com" <jian-feng.ding@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "hejie.xu@intel.com" <hejie.xu@intel.com>,
 "bao.yumeng@zte.com.cn" <bao.yumeng@zte.com.cn>,
 Alex Williamson <alex.williamson@redhat.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>,
 "smooney@redhat.com" <smooney@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Jiri Pirko <jiri@mellanox.com>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "devel@ovirt.org" <devel@ovirt.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/19 下午1:58, Parav Pandit wrote:
>
>> From: Yan Zhao <yan.y.zhao@intel.com>
>> Sent: Wednesday, August 19, 2020 9:01 AM
>> On Tue, Aug 18, 2020 at 09:39:24AM +0000, Parav Pandit wrote:
>>> Please refer to my previous email which has more example and details.
>> hi Parav,
>> the example is based on a new vdpa tool running over netlink, not based on
>> devlink, right?
> Right.
>
>> For vfio migration compatibility, we have to deal with both mdev and physical
>> pci devices, I don't think it's a good idea to write a new tool for it, given we are
>> able to retrieve the same info from sysfs and there's already an mdevctl from
> mdev attribute should be visible in the mdev's sysfs tree.
> I do not propose to write a new mdev tool over netlink. I am sorry if I implied that with my suggestion of vdpa tool.
>
> If underlying device is vdpa, mdev might be able to understand vdpa device and query from it and populate in mdev sysfs tree.


Note that vdpa is bus independent so it can't work now and the support 
of mdev on top of vDPA have been rejected (and duplicated with vhost-vDPA).

Thanks


>
> The vdpa tool I propose is usable even without mdevs.
> vdpa tool's role is to create one or more vdpa devices and place on the "vdpa" bus which is the lowest layer here.
> Additionally this tool let user query virtqueue stats, db stats.
> When a user creates vdpa net device, user may need to configure features of the vdpa device such as VIRTIO_NET_F_MAC, default VIRTIO_NET_F_MTU.
> These are vdpa level features, attributes. Mdev is layer above it.
>
>> Alex
>> (https://nam03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.
>> com%2Fmdevctl%2Fmdevctl&amp;data=02%7C01%7Cparav%40nvidia.com%7C
>> 0c2691d430304f5ea11308d843f2d84e%7C43083d15727340c1b7db39efd9ccc17
>> a%7C0%7C0%7C637334057571911357&amp;sdata=KxH7PwxmKyy9JODut8BWr
>> LQyOBylW00%2Fyzc4rEvjUvA%3D&amp;reserved=0).
>>
> Sorry for above link mangling. Our mail server is still transitioning due to company acquisition.
>
> I am less familiar on below points to comment.
>
>> hi All,
>> could we decide that sysfs is the interface that every VFIO vendor driver needs
>> to provide in order to support vfio live migration, otherwise the userspace
>> management tool would not list the device into the compatible list?
>>
>> if that's true, let's move to the standardizing of the sysfs interface.
>> (1) content
>> common part: (must)
>>     - software_version: (in major.minor.bugfix scheme)
>>     - device_api: vfio-pci or vfio-ccw ...
>>     - type: mdev type for mdev device or
>>             a signature for physical device which is a counterpart for
>> 	   mdev type.
>>
>> device api specific part: (must)
>>    - pci id: pci id of mdev parent device or pci id of physical pci
>>      device (device_api is vfio-pci)
>>    - subchannel_type (device_api is vfio-ccw)
>>
>> vendor driver specific part: (optional)
>>    - aggregator
>>    - chpid_type
>>    - remote_url
>>
>> NOTE: vendors are free to add attributes in this part with a restriction that this
>> attribute is able to be configured with the same name in sysfs too. e.g.
>> for aggregator, there must be a sysfs attribute in device node
>> /sys/devices/pci0000:00/0000:00:02.0/882cc4da-dede-11e7-9180-
>> 078a62063ab1/intel_vgpu/aggregator,
>> so that the userspace tool is able to configure the target device according to
>> source device's aggregator attribute.
>>
>>
>> (2) where and structure
>> proposal 1:
>> |- [path to device]
>>    |--- migration
>>    |     |--- self
>>    |     |    |-software_version
>>    |     |    |-device_api
>>    |     |    |-type
>>    |     |    |-[pci_id or subchannel_type]
>>    |     |    |-<aggregator or chpid_type>
>>    |     |--- compatible
>>    |     |    |-software_version
>>    |     |    |-device_api
>>    |     |    |-type
>>    |     |    |-[pci_id or subchannel_type]
>>    |     |    |-<aggregator or chpid_type>
>> multiple compatible is allowed.
>> attributes should be ASCII text files, preferably with only one value per file.
>>
>>
>> proposal 2: use bin_attribute.
>> |- [path to device]
>>    |--- migration
>>    |     |--- self
>>    |     |--- compatible
>>
>> so we can continue use multiline format. e.g.
>> cat compatible
>>    software_version=0.1.0
>>    device_api=vfio_pci
>>    type=i915-GVTg_V5_{val1:int:1,2,4,8}
>>    pci_id=80865963
>>    aggregator={val1}/2
>>
>> Thanks
>> Yan


