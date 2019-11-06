Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAE8C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7942084D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7942084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGrY-0003ne-5e
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iSGqv-0003Om-W3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iSGqt-0005FV-TI
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:39:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:45450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iSGqt-0005As-KH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:39:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 00:39:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="205257817"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.154])
 ([10.239.196.154])
 by orsmga003.jf.intel.com with ESMTP; 06 Nov 2019 00:39:32 -0800
Subject: Re: [PATCH v14 00/11] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
To: "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
References: <20191028075220.25673-1-tao3.xu@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <c1fb5330-aa56-a8fe-aeaf-58fd6d575dd9@intel.com>
Date: Wed, 6 Nov 2019 16:39:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028075220.25673-1-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for comments:)

On 10/28/2019 3:52 PM, Xu, Tao3 wrote:
> This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
> according to the command line. The ACPI HMAT describes the memory attributes,
> such as memory side cache attributes and bandwidth and latency details,
> related to the Memory Proximity Domain.
> The software is expected to use HMAT information as hint for optimization.
> 
> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
> the platform's HMAT tables.
> 
> The V13 patches link:
> https://patchwork.kernel.org/cover/11200909/
> 
> Changelog:
> v14:
>      - Reuse the codes of do_strtosz to build qemu_strtotime_ns
>        (Eduardo)
>      - Squash patch v13 01/12 and 02/12 together (Daniel and Eduardo)
>      - Drop time unit picosecond (Eric)
>      - Use qemu ctz64 and clz64 instead of builtin function
> v13:
>      - Modify some text description
>      - Drop "initiator_valid" field in struct NodeInfo
>      - Reuse Garray to store the raw bandwidth and bandwidth data
>      - Calculate common base unit using range bitmap
>      - Add a patch to alculate hmat latency and bandwidth entry list
>      - Drop the total_levels option and use readable cache size
>      - Remove the unnecessary head file
>      - Use decimal notation with appropriate suffix for cache size
> v12:
>      - Fix a bug that a memory-only node without initiator setting
>        doesn't report error. (reported by Danmei Wei)
>      - Fix a bug that if HMAT is enabled and without hmat-lb setting,
>        QEMU will crash. (reported by Danmei Wei)
> v11:
>      - Move numa option patches forward.
>      - Add num_initiator in Numa_state to record the number of
>      initiators.
>      - Simplify struct HMAT_LB_Info, use uint64_t array to store data.
>      - Drop hmat_get_base().
>      - Calculate base in build_hmat_lb().
> v10:
>      - Add qemu_strtotime_ps() to convert strings with time suffixes
>      to numbers, and add some tests for it.
>      - Add qapi buildin type time, and add some tests for it.
>      - Add machine oprion properties "-machine hmat=on|off" for
> 	  enabling or disabling HMAT in QEMU.
> 
> Liu Jingqi (5):
>    numa: Extend CLI to provide memory latency and bandwidth information
>    numa: Extend CLI to provide memory side cache information
>    hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
>    hmat acpi: Build System Locality Latency and Bandwidth Information
>      Structure(s)
>    hmat acpi: Build Memory Side Cache Information Structure(s)
> 
> Tao Xu (6):
>    util/cutils: Add qemu_strtotime_ns()
>    qapi: Add builtin type time
>    tests: Add test for QAPI builtin type time
>    numa: Extend CLI to provide initiator information for numa nodes
>    numa: Calculate hmat latency and bandwidth entry list
>    tests/bios-tables-test: add test cases for ACPI HMAT
> 
>   hw/acpi/Kconfig                    |   7 +-
>   hw/acpi/Makefile.objs              |   1 +
>   hw/acpi/hmat.c                     | 263 ++++++++++++++++++++++++++
>   hw/acpi/hmat.h                     |  42 +++++
>   hw/core/machine.c                  |  64 +++++++
>   hw/core/numa.c                     | 284 ++++++++++++++++++++++++++++-
>   hw/i386/acpi-build.c               |   5 +
>   include/qapi/visitor-impl.h        |   4 +
>   include/qapi/visitor.h             |   8 +
>   include/qemu/cutils.h              |   1 +
>   include/sysemu/numa.h              | 104 +++++++++++
>   qapi/machine.json                  | 178 +++++++++++++++++-
>   qapi/opts-visitor.c                |  22 +++
>   qapi/qapi-visit-core.c             |  12 ++
>   qapi/qobject-input-visitor.c       |  18 ++
>   qapi/trace-events                  |   1 +
>   qemu-options.hx                    |  96 +++++++++-
>   scripts/qapi/schema.py             |   1 +
>   tests/bios-tables-test.c           |  44 +++++
>   tests/test-cutils.c                | 204 +++++++++++++++++++++
>   tests/test-keyval.c                | 122 +++++++++++++
>   tests/test-qobject-input-visitor.c |  29 +++
>   util/cutils.c                      |  89 +++++----
>   23 files changed, 1555 insertions(+), 44 deletions(-)
>   create mode 100644 hw/acpi/hmat.c
>   create mode 100644 hw/acpi/hmat.h
> 


