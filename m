Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017E7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 07:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB8E20738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 07:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axDbRtqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB8E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Iiz-0006Hf-VO
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 03:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k8Ihu-0005q9-U0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 03:40:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k8Ihp-0003wF-Pr
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 03:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597822820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uC3DFGkVt6r3mSTVqrFKRNpwFY1Onb0LazyhOhPaXvo=;
 b=axDbRtqi9Zn0/1KL7pIHB0Iy5RKzPuY+cBsI0wcOBiTZa9yf7QtbJZJ/YMh2mroyPva8Mh
 m8RjchHD36P3aAP1yrGek5rzFs3hihSMDfcV6o93m6nSgHpxUpqtjOxVcSLbGfbl6TTc8F
 RJZwKhDF28AyboxUxJBHwXH7fCZt1e4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-Vn1j6-jPN3Km2E2YjnB73w-1; Wed, 19 Aug 2020 03:40:18 -0400
X-MC-Unique: Vn1j6-jPN3Km2E2YjnB73w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 333631084C84;
 Wed, 19 Aug 2020 07:40:14 +0000 (UTC)
Received: from [10.72.13.88] (ovpn-13-88.pek2.redhat.com [10.72.13.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C91B59;
 Wed, 19 Aug 2020 07:39:51 +0000 (UTC)
Subject: Re: [ovirt-devel] Re: device compatibility interface for live
 migration with assigned devices
To: Yan Zhao <yan.y.zhao@intel.com>
References: <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <BY5PR12MB4322C9D1A66C4657776A1383DC5C0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20200819033035.GA21172@joy-OptiPlex-7040>
 <e20812b7-994b-b7f9-2df4-a78c4d116c7f@redhat.com>
 <20200819065951.GB21172@joy-OptiPlex-7040>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d6f9a51e-80b3-44c5-2656-614b327dc080@redhat.com>
Date: Wed, 19 Aug 2020 15:39:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819065951.GB21172@joy-OptiPlex-7040>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 "eskultet@redhat.com" <eskultet@redhat.com>, Parav Pandit <parav@nvidia.com>,
 "sm ooney@redhat.com" <smooney@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Jiri Pirko <jiri@mellanox.com>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "devel@ovirt.org" <devel@ovirt.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/19 下午2:59, Yan Zhao wrote:
> On Wed, Aug 19, 2020 at 02:57:34PM +0800, Jason Wang wrote:
>> On 2020/8/19 上午11:30, Yan Zhao wrote:
>>> hi All,
>>> could we decide that sysfs is the interface that every VFIO vendor driver
>>> needs to provide in order to support vfio live migration, otherwise the
>>> userspace management tool would not list the device into the compatible
>>> list?
>>>
>>> if that's true, let's move to the standardizing of the sysfs interface.
>>> (1) content
>>> common part: (must)
>>>      - software_version: (in major.minor.bugfix scheme)
>>
>> This can not work for devices whose features can be negotiated/advertised
>> independently. (E.g virtio devices)
>>
> sorry, I don't understand here, why virtio devices need to use vfio interface?


I don't see any reason that virtio devices can't be used by VFIO. Do you?

Actually, virtio devices have been used by VFIO for many years:

- passthrough a hardware virtio devices to userspace(VM) drivers
- using virtio PMD inside guest


> I think this thread is discussing about vfio related devices.
>
>>>      - device_api: vfio-pci or vfio-ccw ...
>>>      - type: mdev type for mdev device or
>>>              a signature for physical device which is a counterpart for
>>> 	   mdev type.
>>>
>>> device api specific part: (must)
>>>     - pci id: pci id of mdev parent device or pci id of physical pci
>>>       device (device_api is vfio-pci)API here.
>>
>> So this assumes a PCI device which is probably not true.
>>
> for device_api of vfio-pci, why it's not true?
>
> for vfio-ccw, it's subchannel_type.


Ok but having two different attributes for the same file is not good 
idea. How mgmt know there will be a 3rd type?


>
>>>     - subchannel_type (device_api is vfio-ccw)
>>> vendor driver specific part: (optional)
>>>     - aggregator
>>>     - chpid_type
>>>     - remote_url
>>
>> For "remote_url", just wonder if it's better to integrate or reuse the
>> existing NVME management interface instead of duplicating it here. Otherwise
>> it could be a burden for mgmt to learn. E.g vendor A may use "remote_url"
>> but vendor B may use a different attribute.
>>
> it's vendor driver specific.
> vendor specific attributes are inevitable, and that's why we are
> discussing here of a way to standardizing of it.


Well, then you will end up with a very long list to discuss. E.g for 
networking devices, you will have "mac", "v(x)lan" and a lot of other.

Note that "remote_url" is not vendor specific but NVME (class/subsystem) 
specific.

The point is that if vendor/class specific part is unavoidable, why not 
making all of the attributes vendor specific?


> our goal is that mgmt can use it without understanding the meaning of vendor
> specific attributes.


I'm not sure this is the correct design of uAPI. Is there something 
similar in the existing uAPIs?

And it might be hard to work for virtio devices.


>
>>> NOTE: vendors are free to add attributes in this part with a
>>> restriction that this attribute is able to be configured with the same
>>> name in sysfs too. e.g.
>>
>> Sysfs works well for common attributes belongs to a class, but I'm not sure
>> it can work well for device/vendor specific attributes. Does this mean mgmt
>> need to iterate all the attributes in both src and dst?
>>
> no. just attributes under migration directory.
>
>>> for aggregator, there must be a sysfs attribute in device node
>>> /sys/devices/pci0000:00/0000:00:02.0/882cc4da-dede-11e7-9180-078a62063ab1/intel_vgpu/aggregator,
>>> so that the userspace tool is able to configure the target device
>>> according to source device's aggregator attribute.
>>>
>>>
>>> (2) where and structure
>>> proposal 1:
>>> |- [path to device]
>>>     |--- migration
>>>     |     |--- self
>>>     |     |    |-software_version
>>>     |     |    |-device_api
>>>     |     |    |-type
>>>     |     |    |-[pci_id or subchannel_type]
>>>     |     |    |-<aggregator or chpid_type>
>>>     |     |--- compatible
>>>     |     |    |-software_version
>>>     |     |    |-device_api
>>>     |     |    |-type
>>>     |     |    |-[pci_id or subchannel_type]
>>>     |     |    |-<aggregator or chpid_type>
>>> multiple compatible is allowed.
>>> attributes should be ASCII text files, preferably with only one value
>>> per file.
>>>
>>>
>>> proposal 2: use bin_attribute.
>>> |- [path to device]
>>>     |--- migration
>>>     |     |--- self
>>>     |     |--- compatible
>>>
>>> so we can continue use multiline format. e.g.
>>> cat compatible
>>>     software_version=0.1.0
>>>     device_api=vfio_pci
>>>     type=i915-GVTg_V5_{val1:int:1,2,4,8}
>>>     pci_id=80865963
>>>     aggregator={val1}/2
>>
>> So basically two questions:
>>
>> - how hard to standardize sysfs API for dealing with compatibility check (to
>> make it work for most types of devices)
> sorry, I just know we are in the process of standardizing of it :)


It's not easy. As I said, the current design can't work for virtio 
devices and it's not hard to find other examples. I remember some Intel 
devices have bitmask based capability registers.


>
>> - how hard for the mgmt to learn with a vendor specific attributes (vs
>> existing management API)
> what is existing management API?


It depends on the type of devices. E.g for NVME, we've already had one 
(/sys/kernel/config/nvme)?

Thanks


>
> Thanks
>


