Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB37C3A5A6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 01:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5440720C01
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 01:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5440720C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB80a-000879-Er
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 21:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1iB7zl-00078Y-0H
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 21:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1iB7zj-0008MH-Fa
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 21:46:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46516 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1iB7zf-0008HI-ID; Thu, 19 Sep 2019 21:45:56 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 171465FE99D9A574D1B7;
 Fri, 20 Sep 2019 09:45:47 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 09:45:36 +0800
Subject: Re: [PATCH v18 2/6] docs: APEI GHES generation and CPER record
 description
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
 <20190906083152.25716-3-zhengxiang9@huawei.com>
 <CAFEAcA_MGiatTVCEbnoy5D7S_j9H1DyPkqWMb8uBKL_oycyVDg@mail.gmail.com>
From: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <8235139e-0b72-1e9c-23d0-2d87afcce5a0@huawei.com>
Date: Fri, 20 Sep 2019 09:45:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_MGiatTVCEbnoy5D7S_j9H1DyPkqWMb8uBKL_oycyVDg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>, QEMU
 Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter, thanks for your review!

On 2019/9/19 21:25, Peter Maydell wrote:
> On Fri, 6 Sep 2019 at 09:33, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>>
>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>
>> Add APEI/GHES detailed design document
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>>  docs/specs/acpi_hest_ghes.txt | 88 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 88 insertions(+)
>>  create mode 100644 docs/specs/acpi_hest_ghes.txt
> 
> Hi; new documentation in docs/specs should be in rst format and
> listed in the contents page for the manual at docs/specs/index.rst,
> please. Conversion from plain text should hopefully be fairly
> straightforward.
> 

Got it!

> 
> I've also provided some minor typo/grammar fixes below.
> 
Thanks, I will fix them soon.

> 
>> diff --git a/docs/specs/acpi_hest_ghes.txt b/docs/specs/acpi_hest_ghes.txt
>> new file mode 100644
>> index 0000000000..690d4b2bd0
>> --- /dev/null
>> +++ b/docs/specs/acpi_hest_ghes.txt
>> @@ -0,0 +1,88 @@
>> +APEI tables generating and CPER record
>> +=============================
>> +
>> +Copyright (C) 2019 Huawei Corporation.
>> +
>> +Design Details:
>> +-------------------
>> +
>> +       etc/acpi/tables                                 etc/hardware_errors
>> +    ====================                      ==========================================
>> ++ +--------------------------+            +-----------------------+
>> +| | HEST                     |            |    address            |            +--------------+
>> +| +--------------------------+            |    registers          |            | Error Status |
>> +| | GHES1                    |            | +---------------------+            | Data Block 1 |
>> +| +--------------------------+ +--------->| |error_block_address1 |----------->| +------------+
>> +| | .................        | |          | +---------------------+            | |  CPER      |
>> +| | error_status_address-----+-+ +------->| |error_block_address2 |--------+   | |  CPER      |
>> +| | .................        |   |        | +---------------------+        |   | |  ....      |
>> +| | read_ack_register--------+-+ |        | |    ..............   |        |   | |  CPER      |
>> +| | read_ack_preserve        | | |        +-----------------------+        |   | +------------+
>> +| | read_ack_write           | | | +----->| |error_block_addressN |------+ |   | Error Status |
>> ++ +--------------------------+ | | |      | +---------------------+      | |   | Data Block 2 |
>> +| | GHES2                    | +-+-+----->| |read_ack_register1   |      | +-->| +------------+
>> ++ +--------------------------+   | |      | +---------------------+      |     | |  CPER      |
>> +| | .................        |   | | +--->| |read_ack_register2   |      |     | |  CPER      |
>> +| | error_status_address-----+---+ | |    | +---------------------+      |     | |  ....      |
>> +| | .................        |     | |    | |  .............      |      |     | |  CPER      |
>> +| | read_ack_register--------+-----+-+    | +---------------------+      |     +-+------------+
>> +| | read_ack_preserve        |     |   +->| |read_ack_registerN   |      |     | |..........  |
>> +| | read_ack_write           |     |   |  | +---------------------+      |     | +------------+
>> ++ +--------------------------|     |   |                                 |     | Error Status |
>> +| | ...............          |     |   |                                 |     | Data Block N |
>> ++ +--------------------------+     |   |                                 +---->| +------------+
>> +| | GHESN                    |     |   |                                       | |  CPER      |
>> ++ +--------------------------+     |   |                                       | |  CPER      |
>> +| | .................        |     |   |                                       | |  ....      |
>> +| | error_status_address-----+-----+   |                                       | |  CPER      |
>> +| | .................        |         |                                       +-+------------+
>> +| | read_ack_register--------+---------+
>> +| | read_ack_preserve        |
>> +| | read_ack_write           |
>> ++ +--------------------------+
>> +
>> +(1) QEMU generates the ACPI HEST table. This table goes in the current
>> +    "etc/acpi/tables" fw_cfg blob. Each error source has different
>> +    notification types.
>> +
>> +(2) A new fw_cfg blob called "etc/hardware_errors" is introduced. QEMU
>> +    also need to populate this blob. The "etc/hardwre_errors" fw_cfg blob
> 
> "needs". "hardware_errors".
> 
>> +    contains an address registers table and an Error Status Data Block table.
>> +
>> +(3) The address registers table contains N Error Block Address entries
>> +    and N Read Ack Register entries, the size for each entry is 8-byte.
> 
> ". The size".
> 
>> +    The Error Status Data Block table contains N Error Status Data Block
>> +    entries, the size for each entry is 4096(0x1000) bytes. The total size
> 
> 
> ". The size"
> 
>> +    for "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.
> 
> "for the"
> 
>> +    N is the kinds of hardware error sources.
> 
> Not sure what you had in mind here. Possibly either "N is the number of kinds of
> hardware error sources" or "N is the number of hardware error sources" ?

Yes, I mean "N is the number of kinds of hardware error sources".

> 
>> +
>> +(4) QEMU generates the ACPI linker/loader script for the firmware, the
> 
> ". The"
> 
>> +    firmware pre-allocates memory for "etc/acpi/tables", "etc/hardware_errors"
>> +    and copies blobs content there.
> 
> "blob contents"
> 
>> +
>> +(5) QEMU generates N ADD_POINTER commands, which patch address in the
> 
> "addresses"
> 
>> +    "error_status_address" fields of the HEST table with a pointer to the
>> +    corresponding "address registers" in "etc/hardware_errors" blob.
> 
> "in the"
> 
>> +
>> +(6) QEMU generates N ADD_POINTER commands, which patch address in the
> 
> "addresses"
> 
>> +    "read_ack_register" fields of the HEST table with a pointer to the
>> +    corresponding "address registers" in "etc/hardware_errors" blob.
> 
> "in the"
> 
>> +
>> +(7) QEMU generates N ADD_POINTER commands for the firmware, which patch
>> +    address in the " error_block_address" fields with a pointer to the
> 
> "addresses". Stray extra space after open-quote.
> 
>> +    respective "Error Status Data Block" in "etc/hardware_errors" blob.
> 
> "in the"
> 
>> +
>> +(8) QEMU defines a third and write-only fw_cfg blob which is called
>> +    "etc/hardware_errors_addr". Through that blob, the firmware can send back
>> +    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
>> +    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER commands
> 
> "command"
> 
>> +    for the firmware, the firmware will write back the start address of
> 
> ". The"
> 
>> +    "etc/hardware_errors" blob to fw_cfg file "etc/hardware_errors_addr".
> 
> "to the fw_cfg file"
> 
>> +
>> +(9) When QEMU gets SIGBUS from the kernel, QEMU formats the CPER right into
> 
> "a SIGBUS"
> 
>> +    guest memory, and then injects whatever interrupt (or assert whatever GPIO
> 
> "or asserts"
> 
>> +    line) as a notification which is necessary for notifying the guest.
>> +
>> +(10) This notification (in virtual hardware) will be handled by guest kernel,
> 
> "the guest kernel"
> 
>> +    guest APEI driver will read the CPER which is recorded by QEMU and do the
> 
> "and the guest APEI driver"
> 
>> +    recovery.
> 
> thanks
> -- PMM
> 
> .
> 

-- 

Thanks,
Xiang


