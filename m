Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB78C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 01:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB99206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 01:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB99206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igeoi-0001pr-OX
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 20:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1igenm-0000wp-Su
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 20:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1igenl-0005v4-Gm
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 20:03:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:41870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1igenl-0005r8-6v
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 20:03:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Dec 2019 17:03:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,319,1571727600"; d="scan'208";a="414917235"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.238])
 ([10.239.196.238])
 by fmsmga005.fm.intel.com with ESMTP; 15 Dec 2019 17:03:52 -0800
Subject: Re: [PATCH RESEND v20 0/8] Build ACPI Heterogeneous Memory Attribute
 Table (HMAT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191213011929.2520-1-tao3.xu@intel.com>
 <20191213050619-mutt-send-email-mst@kernel.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <8a124d3c-8249-40dc-700d-dfee1724d888@intel.com>
Date: Mon, 16 Dec 2019 09:03:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191213050619-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "Du, Fan" <fan.du@intel.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sw@weilnetz.de" <sw@weilnetz.de>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/13/2019 6:06 PM, Michael S. Tsirkin wrote:
> On Fri, Dec 13, 2019 at 09:19:21AM +0800, Tao Xu wrote:
>> This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
>> according to the command line. The ACPI HMAT describes the memory attributes,
>> such as memory side cache attributes and bandwidth and latency details,
>> related to the Memory Proximity Domain.
>> The software is expected to use HMAT information as hint for optimization.
>>
>> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
>> the platform's HMAT tables.
>>
>> The V19 patches link:
>> https://patchwork.kernel.org/cover/11265525/
> 
> Looks good to me, I'll queue it for merge after the release. If possible
> please ping me after the release to help make sure it didn't get
> dropped.
> 

Thank you!
> 
> 
>> Changelog:
>> v20:
>>      - Resend to fix the wrong target in pc_hmat_erange_cfg()
>>      - Use g_assert_true and g_assert_false to replace g_assert
>>        (Thomas and Markus)
>>      - Rename assoc as associativity, update the QAPI description (Markus)
>>      - Disable cache level 0 in hmat-cache option (Igor)
>>      - Keep base and bitmap unchanged when latency or bandwidth
>>        out of range
>>      - Fix the broken CI case when user input latency or bandwidth
>>        less than required.
>> v19:
>>      - Add description about the machine property 'hmat' in commit
>>        message (Markus)
>>      - Update the QAPI comments
>>      - Add a check for no memory side cache
>>      - Add some fail cases for hmat-cache when level=0
>> v18:
>>      - Defer patches 01/14~06/14 of V17, use qapi type uint64 and
>>        only nanosecond for latency (Markus)
>>      - Rewrite the lines over 80 characters(Igor)
>> v17:
>>      - Add check when user input latency or bandwidth 0, the
>>        lb_info_provided should also be 0. Because in ACPI 6.3 5.2.27.4,
>>        0 means the corresponding latency or bandwidth information is
>>        not provided.
>>      - Fix the infinite loop when node->latency is 0.
>>      - Use NumaHmatCacheOptions to replace HMAT_Cache_Info (Igor)
>>      - Add check for unordered cache level input (Igor)
>>      - Add some fail test cases (Igor)
>> v16:
>>      - Add and use qemu_strtold_finite to parse size, support full
>>        64bit precision, modify related test cases (Eduardo and Markus)
>>      - Simplify struct HMAT_LB_Info and related code, unify latency
>>        and bandwidth (Igor)
>>      - Add cross check with hmat_lb data (Igor)
>>      - Fields in Cache Attributes are promoted to uint32_t before
>>        shifting (Igor)
>>      - Add case for QMP build HMAT (Igor)
>> v15:
>>      - Add a new patch to refactor do_strtosz() (Eduardo)
>>      - Make tests without breaking CI (Michael)
>> v14:
>>      - Reuse the codes of do_strtosz to build qemu_strtotime_ns
>>        (Eduardo)
>>      - Squash patch v13 01/12 and 02/12 together (Daniel and Eduardo)
>>      - Drop time unit picosecond (Eric)
>>      - Use qemu ctz64 and clz64 instead of builtin function
>> v13:
>>      - Modify some text description
>>      - Drop "initiator_valid" field in struct NodeInfo
>>      - Reuse Garray to store the raw bandwidth and bandwidth data
>>      - Calculate common base unit using range bitmap
>>      - Add a patch to alculate hmat latency and bandwidth entry list
>>      - Drop the total_levels option and use readable cache size
>>      - Remove the unnecessary head file
>>      - Use decimal notation with appropriate suffix for cache size
>>
>> Liu Jingqi (5):
>>    numa: Extend CLI to provide memory latency and bandwidth information
>>    numa: Extend CLI to provide memory side cache information
>>    hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
>>    hmat acpi: Build System Locality Latency and Bandwidth Information
>>      Structure(s)
>>    hmat acpi: Build Memory Side Cache Information Structure(s)
>>
>> Tao Xu (3):
>>    numa: Extend CLI to provide initiator information for numa nodes
>>    tests/numa: Add case for QMP build HMAT
>>    tests/bios-tables-test: add test cases for ACPI HMAT
>>
>>   hw/acpi/Kconfig                       |   7 +-
>>   hw/acpi/Makefile.objs                 |   1 +
>>   hw/acpi/hmat.c                        | 268 +++++++++++++++++++++++
>>   hw/acpi/hmat.h                        |  42 ++++
>>   hw/core/machine.c                     |  64 ++++++
>>   hw/core/numa.c                        | 297 ++++++++++++++++++++++++++
>>   hw/i386/acpi-build.c                  |   5 +
>>   include/sysemu/numa.h                 |  63 ++++++
>>   qapi/machine.json                     | 180 +++++++++++++++-
>>   qemu-options.hx                       |  95 +++++++-
>>   tests/bios-tables-test-allowed-diff.h |   8 +
>>   tests/bios-tables-test.c              |  44 ++++
>>   tests/data/acpi/pc/APIC.acpihmat      |   0
>>   tests/data/acpi/pc/DSDT.acpihmat      |   0
>>   tests/data/acpi/pc/HMAT.acpihmat      |   0
>>   tests/data/acpi/pc/SRAT.acpihmat      |   0
>>   tests/data/acpi/q35/APIC.acpihmat     |   0
>>   tests/data/acpi/q35/DSDT.acpihmat     |   0
>>   tests/data/acpi/q35/HMAT.acpihmat     |   0
>>   tests/data/acpi/q35/SRAT.acpihmat     |   0
>>   tests/numa-test.c                     | 213 ++++++++++++++++++
>>   21 files changed, 1276 insertions(+), 11 deletions(-)
>>   create mode 100644 hw/acpi/hmat.c
>>   create mode 100644 hw/acpi/hmat.h
>>   create mode 100644 tests/data/acpi/pc/APIC.acpihmat
>>   create mode 100644 tests/data/acpi/pc/DSDT.acpihmat
>>   create mode 100644 tests/data/acpi/pc/HMAT.acpihmat
>>   create mode 100644 tests/data/acpi/pc/SRAT.acpihmat
>>   create mode 100644 tests/data/acpi/q35/APIC.acpihmat
>>   create mode 100644 tests/data/acpi/q35/DSDT.acpihmat
>>   create mode 100644 tests/data/acpi/q35/HMAT.acpihmat
>>   create mode 100644 tests/data/acpi/q35/SRAT.acpihmat
>>
>> -- 
>> 2.20.1
> 


