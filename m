Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17AEC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 08:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5FA20673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 08:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HTlweUQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5FA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heFNz-0006Pc-Nk
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 04:59:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58042)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwankhede@nvidia.com>) id 1heEzZ-00044x-0m
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1heEoa-0001QB-6o
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:22:33 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1heEWT-0002pA-36
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:03:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d0c8f610001>; Fri, 21 Jun 2019 01:03:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 21 Jun 2019 01:03:46 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 21 Jun 2019 01:03:46 -0700
Received: from [10.24.71.210] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 08:02:55 +0000
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <20190621002518.GF9303@joy-OptiPlex-7040>
 <20190621012404.GA4173@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <67726e08-f159-7054-57a7-36b08f691756@nvidia.com>
Date: Fri, 21 Jun 2019 13:32:50 +0530
MIME-Version: 1.0
In-Reply-To: <20190621012404.GA4173@joy-OptiPlex-7040>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1561104225; bh=duqjEl0Ywt8wBMZj3smS8ZxxYgckjQQhFY9/qrnLdFc=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=HTlweUQ6E9EFu1/6BrjurUWD0TcyyGTP/rP9gn6RUL4W2y+hMjUuIscH3YrbXH9Yn
 pGyo/LDxvJQkjAEDmTrHcf4xuoPirmOFB4QEykNIAIKnLs5LrJpjI56NGwy/gS0jk4
 MNi+o3SLBF6ZIt8EFONnr6oKDsljYnVP+/sgKj80NN8IlphPhUeuHUgZnWkQKsNn8D
 1cb778/ZudEzflBtdDyrEx9nQrVR7jcwIBOMW40wWzHfm5GO5AEmkEUgVhnZUvJPd1
 PUKpqJ9K7YosXlAhf6fgG8s4dghOmXBQZGeDNGDPSUB4BGl5ufny7a//bT8Lx6db/d
 DsxdS1JDlgkMg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
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



On 6/21/2019 6:54 AM, Yan Zhao wrote:
> On Fri, Jun 21, 2019 at 08:25:18AM +0800, Yan Zhao wrote:
>> On Thu, Jun 20, 2019 at 10:37:28PM +0800, Kirti Wankhede wrote:
>>> Add migration support for VFIO device
>>>
>>> This Patch set include patches as below:
>>> - Define KABI for VFIO device for migration support.
>>> - Added save and restore functions for PCI configuration space
>>> - Generic migration functionality for VFIO device.
>>>   * This patch set adds functionality only for PCI devices, but can be
>>>     extended to other VFIO devices.
>>>   * Added all the basic functions required for pre-copy, stop-and-copy and
>>>     resume phases of migration.
>>>   * Added state change notifier and from that notifier function, VFIO
>>>     device's state changed is conveyed to VFIO device driver.
>>>   * During save setup phase and resume/load setup phase, migration region
>>>     is queried and is used to read/write VFIO device data.
>>>   * .save_live_pending and .save_live_iterate are implemented to use QEMU's
>>>     functionality of iteration during pre-copy phase.
>>>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
>>>     iteration to read data from VFIO device driver is implemented till pending
>>>     bytes returned by driver are not zero.
>>>   * Added function to get dirty pages bitmap for the pages which are used by
>>>     driver.
>>> - Add vfio_listerner_log_sync to mark dirty pages.
>>> - Make VFIO PCI device migration capable. If migration region is not provided by
>>>   driver, migration is blocked.
>>>
>>> Below is the flow of state change for live migration where states in brackets
>>> represent VM state, migration state and VFIO device state as:
>>>     (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)
>>>
>>> Live migration save path:
>>>         QEMU normal running state
>>>         (RUNNING, _NONE, _RUNNING)
>>>                         |
>>>     migrate_init spawns migration_thread.
>>>     (RUNNING, _SETUP, _RUNNING|_SAVING)
>>>     Migration thread then calls each device's .save_setup()
>>>                         |
>>>     (RUNNING, _ACTIVE, _RUNNING|_SAVING)
>>>     If device is active, get pending bytes by .save_live_pending()
>>>     if pending bytes >= threshold_size,  call save_live_iterate()
>>>     Data of VFIO device for pre-copy phase is copied.
>>>     Iterate till pending bytes converge and are less than threshold
>>>                         |
>>>     On migration completion, vCPUs stops and calls .save_live_complete_precopy
>>>     for each active device. VFIO device is then transitioned in
>>>      _SAVING state.
>>>     (FINISH_MIGRATE, _DEVICE, _SAVING)
>>>     For VFIO device, iterate in  .save_live_complete_precopy  until
>>>     pending data is 0.
>>>     (FINISH_MIGRATE, _DEVICE, _STOPPED)
>>
>> I suggest we also register to VMStateDescription, whose .pre_save
>> handler would get called after .save_live_complete_precopy in pre-copy
>> only case, and will called before .save_live_iterate in post-copy
>> enabled case.
>> In the .pre_save handler, we can save all device state which must be
>> copied after device stop in source vm and before device start in target vm.
>>
> hi
> to better describe this idea:
> 
> in pre-copy only case, the flow is
> 
> start migration --> .save_live_iterate (several round) -> stop source vm
> --> .save_live_complete_precopy --> .pre_save  -->start target vm
> -->migration complete
> 
> 
> in post-copy enabled case, the flow is
> 
> start migration --> .save_live_iterate (several round) --> start post copy --> 
> stop source vm --> .pre_save --> start target vm --> .save_live_iterate (several round) 
> -->migration complete
> 
> Therefore, we should put saving of device state in .pre_save interface
> rather than in .save_live_complete_precopy. 
> The device state includes pci config data, page tables, register state, etc.
> 
> The .save_live_iterate and .save_live_complete_precopy should only deal
> with saving dirty memory.
> 

Vendor driver can decide when to save device state depending on the VFIO
device state set by user. Vendor driver doesn't have to depend on which
callback function QEMU or user application calls. In pre-copy case,
save_live_complete_precopy sets VFIO device state to
VFIO_DEVICE_STATE_SAVING which means vCPUs are stopped and vendor driver
should save all device state.

> 
> I know current implementation does not support post-copy. but at least
> it should not require huge change when we decide to enable it in future.
> 

.has_postcopy and .save_live_complete_postcopy need to be implemented to
support post-copy. I think .save_live_complete_postcopy should be
similar to vfio_save_complete_precopy.

Thanks,
Kirti

> Thanks
> Yan
> 
>>>                         |
>>>     (FINISH_MIGRATE, _COMPLETED, STOPPED)
>>>     Migraton thread schedule cleanup bottom half and exit
>>>
>>> Live migration resume path:
>>>     Incomming migration calls .load_setup for each device
>>>     (RESTORE_VM, _ACTIVE, STOPPED)
>>>                         |
>>>     For each device, .load_state is called for that device section data
>>>                         |
>>>     At the end, called .load_cleanup for each device and vCPUs are started.
>>>                         |
>>>         (RUNNING, _NONE, _RUNNING)
>>>
>>> Note that:
>>> - Migration post copy is not supported.
>>>
>>> v3 -> v4:
>>> - Added one more bit for _RESUMING flag to be set explicitly.
>>> - data_offset field is read-only for user space application.
>>> - data_size is read for every iteration before reading data from migration, that
>>>   is removed assumption that data will be till end of migration region.
>>> - If vendor driver supports mappable sparsed region, map those region during
>>>   setup state of save/load, similarly unmap those from cleanup routines.
>>> - Handles race condition that causes data corruption in migration region during
>>>   save device state by adding mutex and serialiaing save_buffer and
>>>   get_dirty_pages routines.
>>> - Skip called get_dirty_pages routine for mapped MMIO region of device.
>>> - Added trace events.
>>> - Splitted into multiple functional patches.
>>>
>>> v2 -> v3:
>>> - Removed enum of VFIO device states. Defined VFIO device state with 2 bits.
>>> - Re-structured vfio_device_migration_info to keep it minimal and defined action
>>>   on read and write access on its members.
>>>
>>> v1 -> v2:
>>> - Defined MIGRATION region type and sub-type which should be used with region
>>>   type capability.
>>> - Re-structured vfio_device_migration_info. This structure will be placed at 0th
>>>   offset of migration region.
>>> - Replaced ioctl with read/write for trapped part of migration region.
>>> - Added both type of access support, trapped or mmapped, for data section of the
>>>   region.
>>> - Moved PCI device functions to pci file.
>>> - Added iteration to get dirty page bitmap until bitmap for all requested pages
>>>   are copied.
>>>
>>> Thanks,
>>> Kirti
>>>
>>>
>>> Kirti Wankhede (13):
>>>   vfio: KABI for migration interface
>>>   vfio: Add function to unmap VFIO region
>>>   vfio: Add save and load functions for VFIO PCI devices
>>>   vfio: Add migration region initialization and finalize function
>>>   vfio: Add VM state change handler to know state of VM
>>>   vfio: Add migration state change notifier
>>>   vfio: Register SaveVMHandlers for VFIO device
>>>   vfio: Add save state functions to SaveVMHandlers
>>>   vfio: Add load state functions to SaveVMHandlers
>>>   vfio: Add function to get dirty page list
>>>   vfio: Add vfio_listerner_log_sync to mark dirty pages
>>>   vfio: Make vfio-pci device migration capable.
>>>   vfio: Add trace events in migration code path
>>>
>>>  hw/vfio/Makefile.objs         |   2 +-
>>>  hw/vfio/common.c              |  55 +++
>>>  hw/vfio/migration.c           | 815 ++++++++++++++++++++++++++++++++++++++++++
>>>  hw/vfio/pci.c                 | 126 ++++++-
>>>  hw/vfio/pci.h                 |  29 ++
>>>  hw/vfio/trace-events          |  19 +
>>>  include/hw/vfio/vfio-common.h |  22 ++
>>>  linux-headers/linux/vfio.h    |  71 ++++
>>>  8 files changed, 1132 insertions(+), 7 deletions(-)
>>>  create mode 100644 hw/vfio/migration.c
>>>
>>> -- 
>>> 2.7.0
>>>

