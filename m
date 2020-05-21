Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50EDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF8C20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="o/1ye476"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF8C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbpW5-0008UU-Iw
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 14:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbpUl-0007xH-V3
 for qemu-devel@nongnu.org; Thu, 21 May 2020 14:00:39 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbpUk-00050N-2E
 for qemu-devel@nongnu.org; Thu, 21 May 2020 14:00:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ec6c1b60001>; Thu, 21 May 2020 11:00:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 21 May 2020 11:00:34 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 21 May 2020 11:00:34 -0700
Received: from [10.40.102.2] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 May
 2020 18:00:24 +0000
Subject: Re: [PATCH QEMU v23 08/18] vfio: Register SaveVMHandlers for VFIO
 device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-9-git-send-email-kwankhede@nvidia.com>
 <20200521141805.GG2752@work-vm>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <5a5b54d1-e026-c16f-68ad-78d7300e0ba3@nvidia.com>
Date: Thu, 21 May 2020 23:30:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521141805.GG2752@work-vm>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590084022; bh=V2FjNIi+WYL2Wl2Gzf85aVjX7kICK3kmCQXeEmhl+Yw=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=o/1ye4762Ssid369SiDI24kaHryye799MwXVhtTAo8xzBu6cSnCk4e0d7wIppa+J8
 hiR8+ks5cNiPEdbFoczsxpT+dfsvzes6X+kRDgyjjOlGMLBdJeL4qTRpoSzQhYJMAM
 R/FiPehICL31MhOLb5AybtLLPbkDt5Jp1bP71Wjjb1dls2HFwbsocPBPdcNhas8eOf
 1lqJzb7VLT7KHpUSmAkAro+CMK6f9H7zd+7OjiI67yXo5ip5UdcMTqH0nRV4z3i9tQ
 pGorCJKqHVODOS24smQdMZy83GhiEacnErZdhVzfiJEKN3qg8DECfK5sUj2LgyWEUN
 a+xAKpfZU5N2g==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 14:00:35
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 quintela@redhat.com, zhi.a.wang@intel.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/21/2020 7:48 PM, Dr. David Alan Gilbert wrote:
> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
>> Define flags to be used as delimeter in migration file stream.
>> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
>> region from these functions at source during saving or pre-copy phase.
>> Set VFIO device state depending on VM's state. During live migration, VM is
>> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
>> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   hw/vfio/migration.c  | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events |  2 ++
>>   2 files changed, 75 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index c2f5564b51c3..773c8d16b1c1 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -8,12 +8,14 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/main-loop.h"
>>   #include <linux/vfio.h>
>>   
>>   #include "sysemu/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>>   #include "cpu.h"
>>   #include "migration/migration.h"
>> +#include "migration/vmstate.h"
>>   #include "migration/qemu-file.h"
>>   #include "migration/register.h"
>>   #include "migration/blocker.h"
>> @@ -24,6 +26,17 @@
>>   #include "pci.h"
>>   #include "trace.h"
>>   
>> +/*
>> + * Flags used as delimiter:
>> + * 0xffffffff => MSB 32-bit all 1s
>> + * 0xef10     => emulated (virtual) function IO
>> + * 0x0000     => 16-bits reserved for flags
>> + */
>> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
>> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
>> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>> +
>>   static void vfio_migration_region_exit(VFIODevice *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>> @@ -126,6 +139,64 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>>       return 0;
>>   }
>>   
>> +/* ---------------------------------------------------------------------- */
>> +
>> +static int vfio_save_setup(QEMUFile *f, void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    int ret;
>> +
>> +    trace_vfio_save_setup(vbasedev->name);
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>> +
>> +    if (migration->region.mmaps) {
>> +        qemu_mutex_lock_iothread();
>> +        ret = vfio_region_mmap(&migration->region);
>> +        qemu_mutex_unlock_iothread();
>> +        if (ret) {
>> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
>> +                         vbasedev->name, migration->region.index,
>> +                         strerror(-ret));
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    ret = vfio_migration_set_state(vbasedev, ~0, VFIO_DEVICE_STATE_SAVING);
>> +    if (ret) {
>> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
>> +        return ret;
>> +    }
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>> +
>> +    ret = qemu_file_get_error(f);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void vfio_save_cleanup(void *opaque)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    if (migration->region.mmaps) {
>> +        vfio_region_unmap(&migration->region);
>> +    }
>> +    trace_vfio_save_cleanup(vbasedev->name);
>> +}
>> +
>> +static SaveVMHandlers savevm_vfio_handlers = {
>> +    .save_setup = vfio_save_setup,
>> +    .save_cleanup = vfio_save_cleanup,
>> +};
>> +
>> +/* ---------------------------------------------------------------------- */
>> +
>>   static void vfio_vmstate_change(void *opaque, int running, RunState state)
>>   {
>>       VFIODevice *vbasedev = opaque;
>> @@ -192,6 +263,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>>           return ret;
>>       }
>>   
>> +    register_savevm_live("vfio", VMSTATE_INSTANCE_ID_ANY, 1,
>> +                         &savevm_vfio_handlers, vbasedev);
> 
> Hi,
>    This is still the only bit which worries me, and I saw your note
> saying you'd tested it; to calm my nerves, can you run with the
> 'qemu_loadvm_state_section_startfull' trace enabled with 2 devices
> and show me the output and qemu command line?
> I'm trying to figure out how they end up represented in the stream.
> 

Created mtty devices for source VM:
echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1233" > 
/sys/class/mdev_bus/mtty/mdev_supported_types/mtty-2/create
echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1234" > 
/sys/class/mdev_bus/mtty/mdev_supported_types/mtty-2/create

for destination VM:
echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1235" > 
/sys/class/mdev_bus/mtty/mdev_supported_types/mtty-2/create
echo "83b8f4f2-509f-382f-3c1e-e6bfe0fa1236" > 
/sys/class/mdev_bus/mtty/mdev_supported_types/mtty-2/create

Source qemu-cmdline:
/usr/libexec/qemu-kvm \
  -name guest=rhel75-mig,debug-threads=on \
  -machine pc-i440fx-3.1,accel=kvm,usb=off,dump-guest-core=off \
  -cpu SandyBridge,vme=on,hypervisor=on,arat=on,xsaveopt=on \
  -m 2048 -realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 \
  -uuid eefb718c-137c-d416-e573-dd74ecd3490d \
  -drive 
file=/home/vm/rhel-75.qcow2,format=qcow2,if=none,id=drive-ide0-0-0,cache=none 
\
  -device 
ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1,write-cache=on 
\
  -vnc 127.0.0.1:0 \
  -device rtl8139,netdev=net0,mac=52:54:b2:88:86:2a,bus=pci.0,addr=0x3 
-netdev tap,id=net0,script=/root/qemu-ifup,downscript=no \
  -device 
vfio-pci,sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1233 
\
  -device 
vfio-pci,sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1234 
\
  --trace events=/root/vfio_events \
  -monitor unix:/tmp/qmp_socket1,server,nowait \
  -serial stdio \
  -msg timestamp=on

Destination qemu-cmdline:
/usr/libexec/qemu-kvm \
  -name guest=rhel75-mig,debug-threads=on \
  -machine pc-i440fx-3.1,accel=kvm,usb=off,dump-guest-core=off \
  -cpu SandyBridge,vme=on,hypervisor=on,arat=on,xsaveopt=on \
  -m 2048 -realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 \
  -uuid eefb718c-137c-d416-e573-dd74ecd3490d \
  -drive 
file=/home/vm/rhel-75.qcow2,format=qcow2,if=none,id=drive-ide0-0-0,cache=none 
\
  -device 
ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1,write-cache=on 
\
  -vnc 127.0.0.1:1 \
  -device rtl8139,netdev=net0,mac=52:54:b2:88:86:2a,bus=pci.0,addr=0x3 
-netdev tap,id=net0,script=/root/qemu-ifup,downscript=no \
  -device 
vfio-pci,sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1235 
\
  -device 
vfio-pci,sysfsdev=/sys/bus/mdev/devices/83b8f4f2-509f-382f-3c1e-e6bfe0fa1236 
\
  -incoming unix:/tmp/mig_socket \
  --trace events=/root/vfio_events \
  -monitor unix:/tmp/qmp_socket2,server,nowait \
  -serial stdio \
  -msg timestamp=on

Migrate:
echo "migrate_set_speed 0" | sudo nc -U /tmp/qmp_socket1
echo "migrate -d unix:/tmp/mig_socket" | sudo nc -U $/tmp/qmp_socket1

After migration, 'qemu_loadvm_state_section_startfull' traces:

qemu_loadvm_state_section_startfull 0.000 pid=1457 section_id=0x2 
idstr=b'ram' instance_id=0x0 version_id=0x4
qemu_loadvm_state_section_startfull 515.606 pid=1457 section_id=0x2e 
idstr=b'vfio' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 10.661 pid=1457 section_id=0x2f 
idstr=b'vfio' instance_id=0x1 version_id=0x1
qemu_loadvm_state_section_startfull 1120000.237 pid=1457 section_id=0x0 
idstr=b'timer' instance_id=0x0 version_id=0x2
qemu_loadvm_state_section_startfull 9.058 pid=1457 section_id=0x4 
idstr=b'cpu_common' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 26.453 pid=1457 section_id=0x5 
idstr=b'cpu' instance_id=0x0 version_id=0xc
qemu_loadvm_state_section_startfull 105.173 pid=1457 section_id=0x6 
idstr=b'kvm-tpr-opt' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 940.028 pid=1457 section_id=0x7 
idstr=b'apic' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 69.939 pid=1457 section_id=0x8 
idstr=b'cpu_common' instance_id=0x1 version_id=0x1
qemu_loadvm_state_section_startfull 14.319 pid=1457 section_id=0x9 
idstr=b'cpu' instance_id=0x1 version_id=0xc
qemu_loadvm_state_section_startfull 102.986 pid=1457 section_id=0xa 
idstr=b'apic' instance_id=0x1 version_id=0x3
qemu_loadvm_state_section_startfull 107.910 pid=1457 section_id=0xb 
idstr=b'kvmclock' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 8.349 pid=1457 section_id=0xc 
idstr=b'fw_cfg' instance_id=0x0 version_id=0x2
qemu_loadvm_state_section_startfull 8.603 pid=1457 section_id=0xd 
idstr=b'PCIBUS' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 6.557 pid=1457 section_id=0xe 
idstr=b'0000:00:00.0/I440FX' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 633.727 pid=1457 section_id=0xf 
idstr=b'0000:00:01.0/PIIX3' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 14.907 pid=1457 section_id=0x10 
idstr=b'i8259' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 11.465 pid=1457 section_id=0x11 
idstr=b'i8259' instance_id=0x1 version_id=0x1
qemu_loadvm_state_section_startfull 5.663 pid=1457 section_id=0x12 
idstr=b'ioapic' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 11.787 pid=1457 section_id=0x13 
idstr=b'0000:00:02.0/vga' instance_id=0x0 version_id=0x2
qemu_loadvm_state_section_startfull 1718.618 pid=1457 section_id=0x14 
idstr=b'hpet' instance_id=0x0 version_id=0x2
qemu_loadvm_state_section_startfull 16.212 pid=1457 section_id=0x15 
idstr=b'mc146818rtc' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 9.946 pid=1457 section_id=0x16 
idstr=b'i8254' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 12.879 pid=1457 section_id=0x17 
idstr=b'pcspk' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 3.115 pid=1457 section_id=0x18 
idstr=b'dma' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 10.432 pid=1457 section_id=0x19 
idstr=b'dma' instance_id=0x1 version_id=0x1
qemu_loadvm_state_section_startfull 12.263 pid=1457 section_id=0x1a 
idstr=b'serial' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 7.299 pid=1457 section_id=0x1b 
idstr=b'parallel_isa' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 3.399 pid=1457 section_id=0x1c 
idstr=b'fdc' instance_id=0x0 version_id=0x2
qemu_loadvm_state_section_startfull 33.307 pid=1457 section_id=0x1d 
idstr=b'ps2kbd' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 6.961 pid=1457 section_id=0x1e 
idstr=b'ps2mouse' instance_id=0x0 version_id=0x2
qemu_loadvm_state_section_startfull 5.485 pid=1457 section_id=0x1f 
idstr=b'pckbd' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 3.984 pid=1457 section_id=0x20 
idstr=b'vmmouse' instance_id=0x0 version_id=0x0
qemu_loadvm_state_section_startfull 105.948 pid=1457 section_id=0x21 
idstr=b'port92' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 2.443 pid=1457 section_id=0x22 
idstr=b'0000:00:01.1/ide' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 1094.861 pid=1457 section_id=0x23 
idstr=b'i2c_bus' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 3.416 pid=1457 section_id=0x24 
idstr=b'0000:00:01.3/piix4_pm' instance_id=0x0 version_id=0x3
qemu_loadvm_state_section_startfull 2266.518 pid=1457 section_id=0x2d 
idstr=b'0000:00:03.0/rtl8139' instance_id=0x0 version_id=0x5
qemu_loadvm_state_section_startfull 1619.840 pid=1457 section_id=0x30 
idstr=b'acpi_build' instance_id=0x0 version_id=0x1
qemu_loadvm_state_section_startfull 4.200 pid=1457 section_id=0x31 
idstr=b'globalstate' instance_id=0x0 version_id=0x1

Thanks,
Kirti

