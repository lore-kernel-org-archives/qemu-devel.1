Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA666C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0150620720
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="P4AvVftF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0150620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYByV-0007bh-Gi
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kYBvU-0005VG-2L
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:41:30 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kYBvQ-0006cL-HD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:41:27 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f9afecc0002>; Thu, 29 Oct 2020 10:41:32 -0700
Received: from [10.40.102.184] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 17:41:19 +0000
Subject: Re: [PATCH v1] docs/devel: Add VFIO device migration documentation
To: Cornelia Huck <cohuck@redhat.com>
References: <1603950791-27236-1-git-send-email-kwankhede@nvidia.com>
 <20201029125221.69352b48.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <9479dffd-e434-e336-6ed8-07fc2edd2453@nvidia.com>
Date: Thu, 29 Oct 2020 23:11:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201029125221.69352b48.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603993292; bh=vUCIrj22o3O2TmQbTard6mRFWoVV0z8SGplf2jrYKTg=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=P4AvVftF+4syStMu9ZINadsEbC3Pks7JksPRYX0vol93i42hHzxT3sveYQXPED1Ao
 jlMD7KH9f6F0GfTdWnx3eeMnOTsxm/xCnvsJ2C0MvlSKz87QnJviW6/l5XKV0PLKr5
 FNpbPpJ/gWcJaQQH+LmxOKU3lQjMQ8ev05UAIH4z3FzFD75o1x7oVbntylQwBJbkh7
 7ZTOlTCVgF1zIe1nky/2ENiE44Y72UlgA3l/aj9a65lR20VyBOEDgti1V0JSx2jMZv
 nVnvv9/AgVk8k0DZL7Xc6aIRM4Kt9iN+yP+FSM5rYe2n7g/Z1MR/Q7Lapws45/4g7s
 YvZwsYsdJHk4w==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 13:41:22
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: mcrossley@nvidia.com, cjia@nvidia.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, dnigam@nvidia.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for corrections Cornelia. I had done the corrections you 
suggested I had not replied, see my comments on couple of places where I 
disagree.


On 10/29/2020 5:22 PM, Cornelia Huck wrote:
> On Thu, 29 Oct 2020 11:23:11 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Document interfaces used for VFIO device migration. Added flow of state
>> changes during live migration with VFIO device.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> ---
>>   MAINTAINERS                   |   1 +
>>   docs/devel/vfio-migration.rst | 119 ++++++++++++++++++++++++++++++++++++++++++
> 
> You probably want to include this into the Developer's Guide via
> index.rst.
> 

Ok.

>>   2 files changed, 120 insertions(+)
>>   create mode 100644 docs/devel/vfio-migration.rst
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6a197bd358d6..6f3fcffc6b3d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1728,6 +1728,7 @@ M: Alex Williamson <alex.williamson@redhat.com>
>>   S: Supported
>>   F: hw/vfio/*
>>   F: include/hw/vfio/
>> +F: docs/devel/vfio-migration.rst
>>   
>>   vfio-ccw
>>   M: Cornelia Huck <cohuck@redhat.com>
>> diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
>> new file mode 100644
>> index 000000000000..dab9127825e4
>> --- /dev/null
>> +++ b/docs/devel/vfio-migration.rst
>> @@ -0,0 +1,119 @@
>> +=====================
>> +VFIO device Migration
>> +=====================
>> +
>> +VFIO devices use iterative approach for migration because certain VFIO devices
> 
> s/use/use an/ ?
> 
>> +(e.g. GPU) have large amount of data to be transfered. The iterative pre-copy
>> +phase of migration allows for the guest to continue whilst the VFIO device state
>> +is transferred to destination, this helps to reduce the total downtime of the
> 
> s/to destination,/to the destination;/
> 
>> +VM. VFIO devices can choose to skip the pre-copy phase of migration by returning
>> +pending_bytes as zero during pre-copy phase.
> 
> s/during/during the/
> 
>> +
>> +Detailed description of UAPI for VFIO device for migration is in the comment
>> +above ``vfio_device_migration_info`` structure definition in header file
>> +linux-headers/linux/vfio.h.
> 
> I think I'd copy that to this file. If I'm looking at the
> documentation, I'd rather not go hunting for source code to find out
> what structure you are talking about. Plus, as it's UAPI, I don't
> expect it to change much, so it should be easy to keep the definitions
> in sync (famous last words).
> 

I feel its duplication of documentation. I would like to know others 
views as well.

>> +
>> +VFIO device hooks for iterative approach:
>> +-  A ``save_setup`` function that setup migration region, sets _SAVING flag in
> 
> s/setup/sets up the/
> s/in/in the/
> 
>> +VFIO device state and inform VFIO IOMMU module to start dirty page tracking.
> 
> s/inform/informs the/
> 
>> +
>> +- A ``load_setup`` function that setup migration region on the destination and
> 
> s/setup/sets up the/
> 
>> +sets _RESUMING flag in VFIO device state.
> 
> s/in/in the/
> 
>> +
>> +- A ``save_live_pending`` function that reads pending_bytes from vendor driver
>> +that indicate how much more data the vendor driver yet to save for the VFIO
>> +device.
> 
> "A ``save_live_pending`` function that reads pending_bytes from the
> vendor driver, which indicates the amount of data that the vendor
> driver has yet to save for the VFIO device." ?
> 
>> +
>> +- A ``save_live_iterate`` function that reads VFIO device's data from vendor
> 
> s/reads/reads the/
> s/from/from the/
> 
>> +driver through migration region during iterative phase.
> 
> s/through/through the/
> 
>> +
>> +- A ``save_live_complete_precopy`` function that resets _RUNNING flag from VFIO
> 
> s/from/from the/
> 
>> +device state, saves device config space, if any, and iteratively copies
> 
> s/saves/saves the/
> 
>> +remaining data for VFIO device till pending_bytes returned by vendor driver
>> +is zero.
> 
> "...and interactively copies the remaining data for the VFIO device
> until the vendor driver indicates that no data remains (pending_bytes
> is zero)." ?
> 
>> +
>> +- A ``load_state`` function loads config section and data sections generated by
>> +above save functions.
> 
> "A ``load_state`` function that loads the config section and the data
> sections that are generated by the save functions above." ?
> 
>> +
>> +- ``cleanup`` functions for both save and load that unmap migration region.
> 
> ..."that perform any migration-related cleanup, including unmapping the
> migration region." ?
> 
>> +
>> +VM state change handler is registered to change VFIO device state based on VM
>> +state change.
> 
> "A VM state change handler is registered to change the VFIO device
> state when the VM state changes." ?
> 
>> +
>> +Similarly, a migration state change notifier is added to get a notification on
> 
> s/added/registered/ ?
> 
>> +migration state change. These states are translated to VFIO device state and
>> +conveyed to vendor driver.
>> +
>> +System memory dirty pages tracking
>> +----------------------------------
>> +
>> +A ``log_sync`` memory listener callback is added to mark system memory pages
> 
> s/is added to mark/marks those/
> 
>> +as dirty which are used for DMA by VFIO device. Dirty pages bitmap is queried
> 
> s/by/by the/
> s/Dirty/The dirty/
> 
>> +per container. All pages pinned by vendor driver through vfio_pin_pages()
> 
> s/by/by the/
> 
>> +external API have to be marked as dirty during migration. When there are CPU
>> +writes, CPU dirty page tracking can identify dirtied pages, but any page pinned
>> +by vendor driver can also be written by device. There is currently no device
> 
> s/by/by the/ (x2)
> 
>> +which has hardware support for dirty page tracking. So all pages which are
>> +pinned by vendor driver are considered as dirty.
>> +Dirty pages are tracked when device is in stop-and-copy phase because if pages
>> +are marked dirty during pre-copy phase and content is transfered from source to
>> +destination, there is no way to know newly dirtied pages from the point they
>> +were copied earlier until device stops. To avoid repeated copy of same content,
>> +pinned pages are marked dirty only during stop-and-copy phase.
> 
> Let me take a quick stab at rewriting this paragraph (not sure if I
> understood it correctly):
> 
> "Dirty pages are tracked when the device is in the stop-and-copy phase.
> During the pre-copy phase, it is not possible to distinguish a dirty
> page that has been transferred from the source to the destination from
> newly dirtied pages, which would lead to repeated copying of the same
> content. Therefore, pinned pages are only marked dirty during the
> stop-and-copy phase." ?
> 

I think above rephrase only talks about repeated copying in pre-copy 
phase. Used "copied earlier until device stops" to indicate both 
pre-copy and stop-and-copy till device stops.

Thanks,
Kirti

>> +
>> +System memory dirty pages tracking when vIOMMU is enabled
>> +---------------------------------------------------------
>> +With vIOMMU, IO virtual address range can get unmapped while in pre-copy phase
> 
> s/IO/an I/O/
> 
>> +of migration. In that case, unmap ioctl returns pages pinned in that range and
> 
> s/unmap ioctl returns pages pinned/the unmap ioctl returns any pinned pages/ ?
> 
>> +QEMU reports corresponding guest physical pages dirty.
>> +During stop-and-copy phase, an IOMMU notifier is used to get a callback for
>> +mapped pages and then dirty pages bitmap is fetched from VFIO IOMMU modules for
>> +those mapped ranges.
>> +
>> +Flow of state changes during Live migration
>> +===========================================
>> +Below is the flow of state change during live migration where states in brackets
>> +represent VM state, migration state and VFIO device state as:
>> +                (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)
> 
> "The values in the brackets represent the VM state, the migration
> state, and the VFIO device state, respectively." ?
> 
>> +
>> +Live migration save path
>> +------------------------
>> +                        QEMU normal running state
>> +                        (RUNNING, _NONE, _RUNNING)
>> +                                    |
>> +                       migrate_init spawns migration_thread
>> +                Migration thread then calls each device's .save_setup()
>> +                        (RUNNING, _SETUP, _RUNNING|_SAVING)
>> +                                    |
>> +                        (RUNNING, _ACTIVE, _RUNNING|_SAVING)
>> +            If device is active, get pending_bytes by .save_live_pending()
>> +         if total pending_bytes >= threshold_size, call .save_live_iterate()
>> +                  Data of VFIO device for pre-copy phase is copied
>> +     Iterate till total pending bytes converge and are less than threshold
>> +                                    |
>> +   On migration completion, vCPUs stops and calls .save_live_complete_precopy
> 
> s/vCPUs/vCPU/ ?
> 
>> +   for each active device. VFIO device is then transitioned in _SAVING state
> 
> s/VFIO device/The VFIO device/
> 
> s/in/into/
> 
>> +                    (FINISH_MIGRATE, _DEVICE, _SAVING)
>> +                                    |
>> +For VFIO device, iterate in .save_live_complete_precopy until pending data is 0
> 
> s/For/For the/
> 
>> +                    (FINISH_MIGRATE, _DEVICE, _STOPPED)
>> +                                    |
>> +                    (FINISH_MIGRATE, _COMPLETED, _STOPPED)
>> +                Migraton thread schedule cleanup bottom half and exit
> 
> s/schedule/schedules/
> s/exit/exits/
> 
>> +
>> +Live migration resume path
>> +--------------------------
>> +
>> +             Incoming migration calls .load_setup for each device
>> +                        (RESTORE_VM, _ACTIVE, _STOPPED)
>> +                                    |
>> +    For each device, .load_state is called for that device section data
>> +                        (RESTORE_VM, _ACTIVE, _RESUMING)
>> +                                    |
>> +    At the end, called .load_cleanup for each device and vCPUs are started                        |
> 
> Stray '|', probably should go on the next line?
> 
> s/called .load_cleanup/.load_cleanup is called/
> 
> 
>> +                        (RUNNING, _NONE, _RUNNING)
>> +
>> +
>> +Postcopy
>> +========
>> +Postcopy migration is not supported for VFIO devices.
> 
> s/not/not yet/, I think? (Disregarding any time frame here.)
> 
> Generally, I think this is useful information to have in the docs.
> 

