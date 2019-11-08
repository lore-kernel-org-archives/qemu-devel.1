Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660FEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 00:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F2321D79
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 00:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F2321D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSsbs-0002Ru-W1
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 19:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iSsb4-00022u-Cs
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 19:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iSsb1-0007dO-75
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 19:57:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:23412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iSsb0-0007Tf-Ts
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 19:57:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 16:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,279,1569308400"; d="scan'208";a="233464987"
Received: from unknown (HELO [10.239.196.160]) ([10.239.196.160])
 by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2019 16:57:42 -0800
Subject: Re: [PATCH v15 00/12] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191107074511.14304-1-tao3.xu@intel.com>
 <20191107040314-mutt-send-email-mst@kernel.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <26295a24-ed3f-375b-f1f3-9b1fb42b3192@intel.com>
Date: Fri, 8 Nov 2019 08:57:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107040314-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/2019 5:03 PM, Michael S. Tsirkin wrote:
> On Thu, Nov 07, 2019 at 03:44:59PM +0800, Tao Xu wrote:
>> This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
>> according to the command line. The ACPI HMAT describes the memory attributes,
>> such as memory side cache attributes and bandwidth and latency details,
>> related to the Memory Proximity Domain.
>> The software is expected to use HMAT information as hint for optimization.
>>
>> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
>> the platform's HMAT tables.
> 
> 
> ok this looks good to me.
> Given we are in freeze, please ping me after the release to merge this.
> 

Thank you very much!
>> The V14 patches link:
>> https://patchwork.kernel.org/cover/11214887/
>>
>> Changelog:
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
>> v12:
>>      - Fix a bug that a memory-only node without initiator setting
>>        doesn't report error. (reported by Danmei Wei)
>>      - Fix a bug that if HMAT is enabled and without hmat-lb setting,
>>        QEMU will crash. (reported by Danmei Wei)
>> v11:
>>      - Move numa option patches forward.
>>      - Add num_initiator in Numa_state to record the number of
>>      initiators.
>>      - Simplify struct HMAT_LB_Info, use uint64_t array to store data.
>>      - Drop hmat_get_base().
>>      - Calculate base in build_hmat_lb().
>> v10:
>>      - Add qemu_strtotime_ps() to convert strings with time suffixes
>>      to numbers, and add some tests for it.
>>      - Add qapi buildin type time, and add some tests for it.
>>      - Add machine oprion properties "-machine hmat=on|off" for enabling
>>      or disabling HMAT in QEMU.
>>
>> Liu Jingqi (5):
>>    numa: Extend CLI to provide memory latency and bandwidth information
>>    numa: Extend CLI to provide memory side cache information
>>    hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
>>    hmat acpi: Build System Locality Latency and Bandwidth Information
>>      Structure(s)
>>    hmat acpi: Build Memory Side Cache Information Structure(s)
>>
>> Tao Xu (7):
>>    util/cutils: refactor do_strtosz() to support suffixes list
>>    util/cutils: Add qemu_strtotime_ns()
>>    qapi: Add builtin type time
>>    tests: Add test for QAPI builtin type time
>>    numa: Extend CLI to provide initiator information for numa nodes
>>    numa: Calculate hmat latency and bandwidth entry list
>>    tests/bios-tables-test: add test cases for ACPI HMAT
>>
>>   hw/acpi/Kconfig                       |   7 +-
>>   hw/acpi/Makefile.objs                 |   1 +
>>   hw/acpi/hmat.c                        | 263 ++++++++++++++++++++++++
>>   hw/acpi/hmat.h                        |  42 ++++
>>   hw/core/machine.c                     |  64 ++++++
>>   hw/core/numa.c                        | 284 +++++++++++++++++++++++++-
>>   hw/i386/acpi-build.c                  |   5 +
>>   include/qapi/visitor-impl.h           |   4 +
>>   include/qapi/visitor.h                |   8 +
>>   include/qemu/cutils.h                 |   1 +
>>   include/sysemu/numa.h                 | 104 ++++++++++
>>   qapi/machine.json                     | 178 +++++++++++++++-
>>   qapi/opts-visitor.c                   |  22 ++
>>   qapi/qapi-visit-core.c                |  12 ++
>>   qapi/qobject-input-visitor.c          |  18 ++
>>   qapi/trace-events                     |   1 +
>>   qemu-options.hx                       |  96 ++++++++-
>>   scripts/qapi/schema.py                |   1 +
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
>>   tests/test-cutils.c                   | 204 ++++++++++++++++++
>>   tests/test-keyval.c                   | 122 +++++++++++
>>   tests/test-qobject-input-visitor.c    |  29 +++
>>   util/cutils.c                         |  86 +++++---
>>   32 files changed, 1562 insertions(+), 42 deletions(-)
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


