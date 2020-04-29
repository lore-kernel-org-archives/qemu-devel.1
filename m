Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADA1C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3A32073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3A32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlF4-0004Lc-3D
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1jTlEO-0003ou-0c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1jTlEM-000154-6O
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:50:23 -0400
Received: from david.siemens.de ([192.35.17.14]:36679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1jTlEL-00010I-GQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:50:21 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 03TBoE5u020816
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2020 13:50:14 +0200
Received: from [167.87.241.229] ([167.87.241.229])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 03TBoCiB030993;
 Wed, 29 Apr 2020 13:50:13 +0200
Subject: Re: [RFC][PATCH v2 0/3] IVSHMEM version 2 device for QEMU
To: Liang Yan <lyan@suse.com>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1578407802.git.jan.kiszka@siemens.com>
 <04fc6cb7-b02d-d8c1-1fdf-6b3c8c211284@suse.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <feedf097-094e-c8db-61e8-8725c6046b9c@siemens.com>
Date: Wed, 29 Apr 2020 13:50:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <04fc6cb7-b02d-d8c1-1fdf-6b3c8c211284@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.35.17.14; envelope-from=jan.kiszka@siemens.com;
 helo=david.siemens.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 07:50:16
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 192.35.17.14
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29.04.20 06:15, Liang Yan wrote:
> Hi, All,
> 
> Did a test for these patches, all looked fine.
> 
> Test environment:
> Host: opensuse tumbleweed + latest upstream qemu  + these three patches
> Guest: opensuse tumbleweed root fs + custom kernel(5.5) + related
> uio-ivshmem driver + ivshmem-console/ivshmem-block tools
> 
> 
> 1. lspci show
> 
> 00:04.0 Unassigned class [ff80]: Siemens AG Device 4106 (prog-if 02)
> Subsystem: Red Hat, Inc. Device 1100
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Region 0: Memory at fea56000 (32-bit, non-prefetchable) [size=4K]
> Region 1: Memory at fea57000 (32-bit, non-prefetchable) [size=4K]
> Region 2: Memory at fd800000 (64-bit, prefetchable) [size=1M]
> Capabilities: [4c] Vendor Specific Information: Len=18 <?>
> Capabilities: [40] MSI-X: Enable+ Count=2 Masked-
> Vector table: BAR=1 offset=00000000
> PBA: BAR=1 offset=00000800
> Kernel driver in use: virtio-ivshmem
> 
> 
> 2. virtio-ivshmem-console test
> 2.1 ivshmem2-server(host)
> 
> airey:~/ivshmem/qemu/:[0]# ./ivshmem2-server -F -l 64K -n 2 -V 3 -P 0x8003
> *** Example code, do not use in production ***
> 
> 2.2 guest vm backend(test-01)
> localhost:~ # echo "110a 4106 1af4 1100 ffc003 ffffff" >
> /sys/bus/pci/drivers/uio_ivshmem/new_id
> [  185.831277] uio_ivshmem 0000:00:04.0: state_table at
> 0x00000000fd800000, size 0x0000000000001000
> [  185.835129] uio_ivshmem 0000:00:04.0: rw_section at
> 0x00000000fd801000, size 0x0000000000007000
> 
> localhost:~ # virtio/virtio-ivshmem-console /dev/uio0
> Waiting for peer to be ready...
> 
> 2.3 guest vm frontend(test-02)
> need to boot or reboot after backend is done
> 
> 2.4 backend will serial output of frontend
> 
> localhost:~ # virtio/virtio-ivshmem-console /dev/uio0
> Waiting for peer to be ready...
> 
> localhost:~/virtio # ./virtio-ivshmem-console /dev/uio0
> Waiting for peer to be ready...
> Starting virtio device
> device_status: 0x0
> device_status: 0x1
> device_status: 0x3
> device_features_sel: 1
> device_features_sel: 0
> driver_features_sel: 1
> driver_features[1]: 0x13
> driver_features_sel: 0
> driver_features[0]: 0x1
> device_status: 0xb
> queue_sel: 0
> queue size: 8
> queue driver vector: 1
> queue desc: 0x200
> queue driver: 0x280
> queue device: 0x2c0
> queue enable: 1
> queue_sel: 1
> queue size: 8
> queue driver vector: 2
> queue desc: 0x400
> queue driver: 0x480
> queue device: 0x4c0
> queue enable: 1
> device_status: 0xf
> 
> Welcome to openSUSE Tumbleweed 20200326 - Kernel 5.5.0-rc5-1-default+
> (hvc0).
> 
> enp0s3:
> 
> 
> localhost login:
> 
> 2.5 close backend and frontend will show
> localhost:~ # [  185.685041] virtio-ivshmem 0000:00:04.0: backend failed!
> 
> 3. virtio-ivshmem-block test
> 
> 3.1 ivshmem2-server(host)
> airey:~/ivshmem/qemu/:[0]# ./ivshmem2-server -F -l 1M -n 2 -V 2 -P 0x8002
> *** Example code, do not use in production ***
> 
> 3.2 guest vm backend(test-01)
> 
> localhost:~ # echo "110a 4106 1af4 1100 ffc002 ffffff" >
> /sys/bus/pci/drivers/uio_ivshmem/new_id
> [   77.701462] uio_ivshmem 0000:00:04.0: state_table at
> 0x00000000fd800000, size 0x0000000000001000
> [   77.705231] uio_ivshmem 0000:00:04.0: rw_section at
> 0x00000000fd801000, size 0x00000000000ff000
> 
> localhost:~ # virtio/virtio-ivshmem-block /dev/uio0 /root/disk.img
> Waiting for peer to be ready...
> 
> 3.3 guest vm frontend(test-02)
> need to boot or reboot after backend is done
> 
> 3.4 guest vm backend(test-01)
> localhost:~ # virtio/virtio-ivshmem-block /dev/uio0 /root/disk.img
> Waiting for peer to be ready...
> Starting virtio device
> device_status: 0x0
> device_status: 0x1
> device_status: 0x3
> device_features_sel: 1
> device_features_sel: 0
> driver_features_sel: 1
> driver_features[1]: 0x13
> driver_features_sel: 0
> driver_features[0]: 0x206
> device_status: 0xb
> queue_sel: 0
> queue size: 8
> queue driver vector: 1
> queue desc: 0x200
> queue driver: 0x280
> queue device: 0x2c0
> queue enable: 1
> device_status: 0xf
> 
> 3.5 guest vm frontend(test-02), a new disk is attached:
> 
> fdisk /dev/vdb
> 
> Disk /dev/vdb: 192 KiB, 196608 bytes, 384 sectors
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> 
> 3.6 close backend and frontend will show
> localhost:~ # [ 1312.284301] virtio-ivshmem 0000:00:04.0: backend failed!
> 
> 
> 
> Tested-by: Liang Yan <lyan@suse.com>
> 

Thanks for testing this! I'll look into your patch findings.

Jan

> On 1/7/20 9:36 AM, Jan Kiszka wrote:
>> Overdue update of the ivshmem 2.0 device model as presented at [1].
>>
>> Changes in v2:
>>   - changed PCI device ID to Siemens-granted one,
>>     adjusted PCI device revision to 0
>>   - removed unused feature register from device
>>   - addressed feedback on specification document
>>   - rebased over master
>>
>> This version is now fully in sync with the implementation for Jailhouse
>> that is currently under review [2][3], UIO and virtio-ivshmem drivers
>> are shared. Jailhouse will very likely pick up this revision of the
>> device in order to move forward with stressing it.
>>
>> More details on the usage with QEMU were in the original cover letter
>> (with adjustements to the new device ID):
>>
>> If you want to play with this, the basic setup of the shared memory
>> device is described in patch 1 and 3. UIO driver and also the
>> virtio-ivshmem prototype can be found at
>>
>>      http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/queues/ivshmem2
>>
>> Accessing the device via UIO is trivial enough. If you want to use it
>> for virtio, this is additionally to the description in patch 3 needed on
>> the virtio console backend side:
>>
>>      modprobe uio_ivshmem
>>      echo "110a 4106 1af4 1100 ffc003 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
>>      linux/tools/virtio/virtio-ivshmem-console /dev/uio0
>>
>> And for virtio block:
>>
>>      echo "110a 4106 1af4 1100 ffc002 ffffff" > /sys/bus/pci/drivers/uio_ivshmem/new_id
>>      linux/tools/virtio/virtio-ivshmem-console /dev/uio0 /path/to/disk.img
>>
>> After that, you can start the QEMU frontend instance with the
>> virtio-ivshmem driver installed which can use the new /dev/hvc* or
>> /dev/vda* as usual.
>>
>> Any feedback welcome!
>>
>> Jan
>>
>> PS: Let me know if I missed someone potentially interested in this topic
>> on CC - or if you would like to be dropped from the list.
>>
>> [1] https://kvmforum2019.sched.com/event/TmxI
>> [2] https://groups.google.com/forum/#!topic/jailhouse-dev/ffnCcRh8LOs
>> [3] https://groups.google.com/forum/#!topic/jailhouse-dev/HX-0AGF1cjg
>>
>> Jan Kiszka (3):
>>    hw/misc: Add implementation of ivshmem revision 2 device
>>    docs/specs: Add specification of ivshmem device revision 2
>>    contrib: Add server for ivshmem revision 2
>>
>>   Makefile                                  |    3 +
>>   Makefile.objs                             |    1 +
>>   configure                                 |    1 +
>>   contrib/ivshmem2-server/Makefile.objs     |    1 +
>>   contrib/ivshmem2-server/ivshmem2-server.c |  462 ++++++++++++
>>   contrib/ivshmem2-server/ivshmem2-server.h |  158 +++++
>>   contrib/ivshmem2-server/main.c            |  313 +++++++++
>>   docs/specs/ivshmem-2-device-spec.md       |  376 ++++++++++
>>   hw/misc/Makefile.objs                     |    2 +-
>>   hw/misc/ivshmem2.c                        | 1085 +++++++++++++++++++++++++++++
>>   include/hw/misc/ivshmem2.h                |   48 ++
>>   include/hw/pci/pci_ids.h                  |    2 +
>>   12 files changed, 2451 insertions(+), 1 deletion(-)
>>   create mode 100644 contrib/ivshmem2-server/Makefile.objs
>>   create mode 100644 contrib/ivshmem2-server/ivshmem2-server.c
>>   create mode 100644 contrib/ivshmem2-server/ivshmem2-server.h
>>   create mode 100644 contrib/ivshmem2-server/main.c
>>   create mode 100644 docs/specs/ivshmem-2-device-spec.md
>>   create mode 100644 hw/misc/ivshmem2.c
>>   create mode 100644 include/hw/misc/ivshmem2.h
>>

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

