Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6566FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 01:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D7C2068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 01:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D7C2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZmUk-0005dW-Ba
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 20:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iZmSV-0003jk-Ao
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 20:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iZmHb-0003cc-PH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 20:38:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45350 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iZmHZ-0003VB-I2; Tue, 26 Nov 2019 20:38:18 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4F42ECA742D128B964E0;
 Wed, 27 Nov 2019 09:38:09 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 27 Nov 2019
 09:37:59 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [RESEND PATCH v21 2/6] docs: APEI GHES generation and CPER record
 description
To: Igor Mammedov <imammedo@redhat.com>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-3-zhengxiang9@huawei.com>
 <20191115104458.200a6231@redhat.com>
Message-ID: <05d2ba81-501f-bd7e-8da4-73e413169688@huawei.com>
Date: Wed, 27 Nov 2019 09:37:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191115104458.200a6231@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, wanghaibin.wang@huawei.com, mtosatti@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, gengdongjiu@huawei.com,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

Thanks for your review!
Since the series of patches are going to be merged, we will address your comments by follow up patches.

On 2019/11/15 17:44, Igor Mammedov wrote:
> On Mon, 11 Nov 2019 09:40:44 +0800
> Xiang Zheng <zhengxiang9@huawei.com> wrote:
> 
>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>
>> Add APEI/GHES detailed design document
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  docs/specs/acpi_hest_ghes.rst | 95 +++++++++++++++++++++++++++++++++++
>>  docs/specs/index.rst          |  1 +
>>  2 files changed, 96 insertions(+)
>>  create mode 100644 docs/specs/acpi_hest_ghes.rst
>>
>> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
>> new file mode 100644
>> index 0000000000..348825f9d3
>> --- /dev/null
>> +++ b/docs/specs/acpi_hest_ghes.rst
>> @@ -0,0 +1,95 @@
>> +APEI tables generating and CPER record
>> +======================================
>> +
>> +..
>> +   Copyright (c) 2019 HUAWEI TECHNOLOGIES CO., LTD.
>> +
>> +   This work is licensed under the terms of the GNU GPL, version 2 or later.
>> +   See the COPYING file in the top-level directory.
>> +
>> +Design Details
>> +--------------
>> +
>> +::
>> +
>> +         etc/acpi/tables                                 etc/hardware_errors
>> +      ====================                      ==========================================
>> +  + +--------------------------+            +-----------------------+
>> +  | | HEST                     |            |    address            |            +--------------+
>> +  | +--------------------------+            |    registers          |            | Error Status |
>> +  | | GHES1                    |            | +---------------------+            | Data Block 1 |
>> +  | +--------------------------+ +--------->| |error_block_address1 |----------->| +------------+
>> +  | | .................        | |          | +---------------------+            | |  CPER      |
>> +  | | error_status_address-----+-+ +------->| |error_block_address2 |--------+   | |  CPER      |
>> +  | | .................        |   |        | +---------------------+        |   | |  ....      |
>> +  | | read_ack_register--------+-+ |        | |    ..............   |        |   | |  CPER      |
>> +  | | read_ack_preserve        | | |        +-----------------------+        |   | +------------+
>> +  | | read_ack_write           | | | +----->| |error_block_addressN |------+ |   | Error Status |
>> +  + +--------------------------+ | | |      | +---------------------+      | |   | Data Block 2 |
>> +  | | GHES2                    | +-+-+----->| |read_ack_register1   |      | +-->| +------------+
>> +  + +--------------------------+   | |      | +---------------------+      |     | |  CPER      |
>> +  | | .................        |   | | +--->| |read_ack_register2   |      |     | |  CPER      |
>> +  | | error_status_address-----+---+ | |    | +---------------------+      |     | |  ....      |
>> +  | | .................        |     | |    | |  .............      |      |     | |  CPER      |
>> +  | | read_ack_register--------+-----+-+    | +---------------------+      |     +-+------------+
>> +  | | read_ack_preserve        |     |   +->| |read_ack_registerN   |      |     | |..........  |
>> +  | | read_ack_write           |     |   |  | +---------------------+      |     | +------------+
>> +  + +--------------------------|     |   |                                 |     | Error Status |
>> +  | | ...............          |     |   |                                 |     | Data Block N |
>> +  + +--------------------------+     |   |                                 +---->| +------------+
>> +  | | GHESN                    |     |   |                                       | |  CPER      |
>> +  + +--------------------------+     |   |                                       | |  CPER      |
>> +  | | .................        |     |   |                                       | |  ....      |
>> +  | | error_status_address-----+-----+   |                                       | |  CPER      |
>> +  | | .................        |         |                                       +-+------------+
>> +  | | read_ack_register--------+---------+
>> +  | | read_ack_preserve        |
>> +  | | read_ack_write           |
>> +  + +--------------------------+
> 
> I'd merge "Error Status Data Block" with "address registers", so it would be
> clear that "Error Status Data Block" is located after "read_ack_registerN"

Yes, this image doesn't demonstrate this point. We will make some changes on
this image.

> 
>> +
>> +(1) QEMU generates the ACPI HEST table. This table goes in the current
>> +    "etc/acpi/tables" fw_cfg blob. Each error source has different
>> +    notification types.
>> +
>> +(2) A new fw_cfg blob called "etc/hardware_errors" is introduced. QEMU
>> +    also needs to populate this blob. The "etc/hardware_errors" fw_cfg blob
>> +    contains an address registers table and an Error Status Data Block table.
>> +
>> +(3) The address registers table contains N Error Block Address entries
>> +    and N Read Ack Register entries. The size for each entry is 8-byte.
>> +    The Error Status Data Block table contains N Error Status Data Block
>> +    entries. The size for each entry is 4096(0x1000) bytes. The total size
>> +    for the "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.
>> +    N is the number of the kinds of hardware error sources.
>> +
>> +(4) QEMU generates the ACPI linker/loader script for the firmware. The
>> +    firmware pre-allocates memory for "etc/acpi/tables", "etc/hardware_errors"
>> +    and copies blob contents there.
>> +
>> +(5) QEMU generates N ADD_POINTER commands, which patch addresses in the
>> +    "error_status_address" fields of the HEST table with a pointer to the
>> +    corresponding "address registers" in the "etc/hardware_errors" blob.
>> +
>> +(6) QEMU generates N ADD_POINTER commands, which patch addresses in the
>> +    "read_ack_register" fields of the HEST table with a pointer to the
>> +    corresponding "address registers" in the "etc/hardware_errors" blob.
> 
> s/"address registers" in/"read_ack_register" within/

OK.

> 
>> +
>> +(7) QEMU generates N ADD_POINTER commands for the firmware, which patch
>> +    addresses in the "error_block_address" fields with a pointer to the
>> +    respective "Error Status Data Block" in the "etc/hardware_errors" blob.
>> +
>> +(8) QEMU defines a third and write-only fw_cfg blob which is called
>> +    "etc/hardware_errors_addr". Through that blob, the firmware can send back
>> +    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
>> +    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
>> +    for the firmware. The firmware will write back the start address of
>> +    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
>> +
> 
>> +(9) When QEMU gets a SIGBUS from the kernel, QEMU formats the CPER right into
>> +    guest memory, 
> 
> s/
> QEMU formats the CPER right into guest memory
> /
> QEMU writes CPER into corresponding "Error Status Data Block"
> /
> 

OK.

>> and then injects platform specific interrupt (in case of
>> +    arm/virt machine it's Synchronous External Abort) as a notification which
>> +    is necessary for notifying the guest.
> 
> 
>> +
>> +(10) This notification (in virtual hardware) will be handled by the guest
>> +     kernel, guest APEI driver will read the CPER which is recorded by QEMU and
>> +     do the recovery.
> Maybe better would be to say:
> "
> On receiving notification, guest APEI driver cold read the CPER error
> and take appropriate action
> "

OK.

> 
> 
> also in HEST patches there is implicit ABI, which probably should be documented here.
> More specifically kvm_arch_on_sigbus_vcpu() error injection
> uses source_id as index in "etc/hardware_errors" to find out "Error Status Data Block"
> entry corresponding to error source. So supported source_id values should be assigned
> here and not be changed afterwards to make sure that guest will write error into
> expected "Error Status Data Block" even if guest was migrated to a newer QEMU.
> 

OK, I will add the descriptions of the implicit ABI.

-- 

Thanks,
Xiang


