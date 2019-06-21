Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCFEC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3AA21530
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="n3qE3KQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3AA21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56986 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heFp1-0006WZ-Vl
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44091)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1heFl4-0003NM-6L
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1heFl0-0007Hl-6Z
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:22:57 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1heFky-0007EP-Is
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:22:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0ca1e80000>; Fri, 21 Jun 2019 02:22:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 21 Jun 2019 02:22:48 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 21 Jun 2019 02:22:48 -0700
Received: from [10.24.71.210] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 09:22:40 +0000
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <20190621002518.GF9303@joy-OptiPlex-7040>
 <20190621012404.GA4173@joy-OptiPlex-7040>
 <67726e08-f159-7054-57a7-36b08f691756@nvidia.com>
 <20190621084627.GC4304@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <583faf0d-55e7-0611-3e1c-b4925ca7e533@nvidia.com>
Date: Fri, 21 Jun 2019 14:52:37 +0530
MIME-Version: 1.0
In-Reply-To: <20190621084627.GC4304@joy-OptiPlex-7040>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561108968; bh=DIMZAU0sIH9KvGZdNGHoXRh3Pf50G7sAM96tl3OUn+c=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=n3qE3KQasShjbQ16SdBDefR6tIMWhndzTAYPYeiMBYZzlooCLORiKL1KkuXEN1e0Y
 MMHBRzm9Wz51Q7GeIO+7hi6awv9anFcef4zffArRxtosce8w87oBqsW8lADh5h4ZdO
 rx7TXif+IzJ0pSUjh/ZtO7E0o6NgkQZGxLMCZPYAp14LE7nCGwhjfzmvi7RVhpjMuL
 bmG6KmRGw9H3L9u/WnBbJK3pcq95FXWmxNagCIQKhOsUFvbHleZAorB79efU9CAHKF
 4vfN6/s3WDTMM3uZ5JNiX8AlW+EW6YRoGc84QhQTnXT6TF5XU44YPoopzUtzm/B+6Y
 oZBw4YOgEAcHA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.65
Subject: Re: [Qemu-devel] [PATCH v4 00/13] Add migration support for VFIO
 device
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/21/2019 2:16 PM, Yan Zhao wrote:
> On Fri, Jun 21, 2019 at 04:02:50PM +0800, Kirti Wankhede wrote:
>>
>>
>> On 6/21/2019 6:54 AM, Yan Zhao wrote:
>>> On Fri, Jun 21, 2019 at 08:25:18AM +0800, Yan Zhao wrote:
>>>> On Thu, Jun 20, 2019 at 10:37:28PM +0800, Kirti Wankhede wrote:
>>>>> Add migration support for VFIO device
>>>>>
>>>>> This Patch set include patches as below:
>>>>> - Define KABI for VFIO device for migration support.
>>>>> - Added save and restore functions for PCI configuration space
>>>>> - Generic migration functionality for VFIO device.
>>>>>   * This patch set adds functionality only for PCI devices, but can be
>>>>>     extended to other VFIO devices.
>>>>>   * Added all the basic functions required for pre-copy, stop-and-copy and
>>>>>     resume phases of migration.
>>>>>   * Added state change notifier and from that notifier function, VFIO
>>>>>     device's state changed is conveyed to VFIO device driver.
>>>>>   * During save setup phase and resume/load setup phase, migration region
>>>>>     is queried and is used to read/write VFIO device data.
>>>>>   * .save_live_pending and .save_live_iterate are implemented to use QEMU's
>>>>>     functionality of iteration during pre-copy phase.
>>>>>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
>>>>>     iteration to read data from VFIO device driver is implemented till pending
>>>>>     bytes returned by driver are not zero.
>>>>>   * Added function to get dirty pages bitmap for the pages which are used by
>>>>>     driver.
>>>>> - Add vfio_listerner_log_sync to mark dirty pages.
>>>>> - Make VFIO PCI device migration capable. If migration region is not provided by
>>>>>   driver, migration is blocked.
>>>>>
>>>>> Below is the flow of state change for live migration where states in brackets
>>>>> represent VM state, migration state and VFIO device state as:
>>>>>     (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)
>>>>>
>>>>> Live migration save path:
>>>>>         QEMU normal running state
>>>>>         (RUNNING, _NONE, _RUNNING)
>>>>>                         |
>>>>>     migrate_init spawns migration_thread.
>>>>>     (RUNNING, _SETUP, _RUNNING|_SAVING)
>>>>>     Migration thread then calls each device's .save_setup()
>>>>>                         |
>>>>>     (RUNNING, _ACTIVE, _RUNNING|_SAVING)
>>>>>     If device is active, get pending bytes by .save_live_pending()
>>>>>     if pending bytes >= threshold_size,  call save_live_iterate()
>>>>>     Data of VFIO device for pre-copy phase is copied.
>>>>>     Iterate till pending bytes converge and are less than threshold
>>>>>                         |
>>>>>     On migration completion, vCPUs stops and calls .save_live_complete_precopy
>>>>>     for each active device. VFIO device is then transitioned in
>>>>>      _SAVING state.
>>>>>     (FINISH_MIGRATE, _DEVICE, _SAVING)
>>>>>     For VFIO device, iterate in  .save_live_complete_precopy  until
>>>>>     pending data is 0.
>>>>>     (FINISH_MIGRATE, _DEVICE, _STOPPED)
>>>>
>>>> I suggest we also register to VMStateDescription, whose .pre_save
>>>> handler would get called after .save_live_complete_precopy in pre-copy
>>>> only case, and will called before .save_live_iterate in post-copy
>>>> enabled case.
>>>> In the .pre_save handler, we can save all device state which must be
>>>> copied after device stop in source vm and before device start in target vm.
>>>>
>>> hi
>>> to better describe this idea:
>>>
>>> in pre-copy only case, the flow is
>>>
>>> start migration --> .save_live_iterate (several round) -> stop source vm
>>> --> .save_live_complete_precopy --> .pre_save  -->start target vm
>>> -->migration complete
>>>
>>>
>>> in post-copy enabled case, the flow is
>>>
>>> start migration --> .save_live_iterate (several round) --> start post copy --> 
>>> stop source vm --> .pre_save --> start target vm --> .save_live_iterate (several round) 
>>> -->migration complete
>>>
>>> Therefore, we should put saving of device state in .pre_save interface
>>> rather than in .save_live_complete_precopy. 
>>> The device state includes pci config data, page tables, register state, etc.
>>>
>>> The .save_live_iterate and .save_live_complete_precopy should only deal
>>> with saving dirty memory.
>>>
>>
>> Vendor driver can decide when to save device state depending on the VFIO
>> device state set by user. Vendor driver doesn't have to depend on which
>> callback function QEMU or user application calls. In pre-copy case,
>> save_live_complete_precopy sets VFIO device state to
>> VFIO_DEVICE_STATE_SAVING which means vCPUs are stopped and vendor driver
>> should save all device state.
>>
> when post copy stops vCPUs and vfio device, vendor driver only needs to
> provide device state. but how vendor driver knows that, if no extra
> interface or no extra device state is provides?
> 

.save_live_complete_postcopy interface for post-copy will get called,
right?

Thanks,
Kirti

>>>
>>> I know current implementation does not support post-copy. but at least
>>> it should not require huge change when we decide to enable it in future.
>>>
>>
>> .has_postcopy and .save_live_complete_postcopy need to be implemented to
>> support post-copy. I think .save_live_complete_postcopy should be
>> similar to vfio_save_complete_precopy.
>>
>> Thanks,
>> Kirti
>>
>>> Thanks
>>> Yan
>>>

