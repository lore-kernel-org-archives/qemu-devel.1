Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0478BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA26207FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA26207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsUY-0002eH-0U
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@pond.sub.org>) id 1iMsFf-0002WT-J6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@pond.sub.org>) id 1iMsFe-0000sZ-3E
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:22:59 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3]:46688)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@pond.sub.org>) id 1iMsFd-0000py-Pe
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:22:58 -0400
Received: from blackfin.pond.sub.org
 (p200300D36F484800DACB8AFFFEE0C842.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f48:4800:dacb:8aff:fee0:c842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id E0AAE4A9F4;
 Tue, 22 Oct 2019 13:22:52 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3203B1138619; Tue, 22 Oct 2019 13:22:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v13 00/12] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
References: <20191020111125.27659-1-tao3.xu@intel.com>
Date: Tue, 22 Oct 2019 13:22:50 +0200
Message-ID: <87v9sh10tx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:13b:3ad0:1::3
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just stumbled over this series.  It touches the QAPI visitors and even
the generator, without cc'ing its maintainers.  Such changes require
review.  There's precious little time until the soft freeze now.  I'll
try, but no promises.

Please cc me and Michael Roth <mdroth@linux.vnet.ibm.com> on future
revisions.

In general, peruse output of scripts/get_maintainer.pl to find relevant
maintainers.

Tao Xu <tao3.xu@intel.com> writes:

> This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
> according to the command line. The ACPI HMAT describes the memory attributes,
> such as memory side cache attributes and bandwidth and latency details,
> related to the Memory Proximity Domain.
> The software is expected to use HMAT information as hint for optimization.
>
> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
> the platform's HMAT tables.
>
> The V12 patches link:
> https://patchwork.kernel.org/cover/11153861/
>
> Changelog:
> v13:
>     - Modify some text description
>     - Drop "initiator_valid" field in struct NodeInfo
>     - Reuse Garray to store the raw bandwidth and bandwidth data
>     - Calculate common base unit using range bitmap
>     - Add a patch to alculate hmat latency and bandwidth entry list
>     - Drop the total_levels option and use readable cache size
>     - Remove the unnecessary head file
>     - Use decimal notation with appropriate suffix for cache size
> v12:
>     - Fix a bug that a memory-only node without initiator setting
>       doesn't report error. (reported by Danmei Wei)
>     - Fix a bug that if HMAT is enabled and without hmat-lb setting,
>       QEMU will crash. (reported by Danmei Wei)
> v11:
>     - Move numa option patches forward.
>     - Add num_initiator in Numa_state to record the number of
>     initiators.
>     - Simplify struct HMAT_LB_Info, use uint64_t array to store data.
>     - Drop hmat_get_base().
>     - Calculate base in build_hmat_lb().
> v10:
>     - Add qemu_strtotime_ps() to convert strings with time suffixes
>     to numbers, and add some tests for it.
>     - Add qapi buildin type time, and add some tests for it.
>     - Add machine oprion properties "-machine hmat=on|off" for
> 	  enabling or disabling HMAT in QEMU.

I guess this is where you started messing with QAPI.  Seven weeks ago.
The time crunch is of your own making, I'm afraid.

> v9:
>     - change the CLI input way, make it more user firendly (Daniel Black)
>     use latency=NUM[p|n|u]s and bandwidth=NUM[M|G|P](B/s) as input and drop
>     the base-lat and base-bw input.
> Liu Jingqi (5):
>   numa: Extend CLI to provide memory latency and bandwidth information
>   numa: Extend CLI to provide memory side cache information
>   hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
>   hmat acpi: Build System Locality Latency and Bandwidth Information
>     Structure(s)
>   hmat acpi: Build Memory Side Cache Information Structure(s)
>
> Tao Xu (7):
>   util/cutils: Add qemu_strtotime_ps()
>   tests/cutils: Add test for qemu_strtotime_ps()
>   qapi: Add builtin type time
>   tests: Add test for QAPI builtin type time
>   numa: Extend CLI to provide initiator information for numa nodes
>   numa: Calculate hmat latency and bandwidth entry list
>   tests/bios-tables-test: add test cases for ACPI HMAT
>
>  hw/acpi/Kconfig                    |   7 +-
>  hw/acpi/Makefile.objs              |   1 +
>  hw/acpi/hmat.c                     | 263 +++++++++++++++++++++++++++
>  hw/acpi/hmat.h                     |  42 +++++
>  hw/core/machine.c                  |  70 ++++++++
>  hw/core/numa.c                     | 273 ++++++++++++++++++++++++++++-
>  hw/i386/acpi-build.c               |   5 +
>  include/qapi/visitor-impl.h        |   4 +
>  include/qapi/visitor.h             |   9 +
>  include/qemu/cutils.h              |   1 +
>  include/sysemu/numa.h              | 104 +++++++++++
>  qapi/machine.json                  | 179 ++++++++++++++++++-
>  qapi/opts-visitor.c                |  22 +++
>  qapi/qapi-visit-core.c             |  12 ++
>  qapi/qobject-input-visitor.c       |  18 ++
>  qapi/trace-events                  |   1 +
>  qemu-options.hx                    |  96 +++++++++-
>  scripts/qapi/common.py             |   1 +
>  tests/bios-tables-test.c           |  44 +++++
>  tests/test-cutils.c                | 199 +++++++++++++++++++++
>  tests/test-keyval.c                | 125 +++++++++++++
>  tests/test-qobject-input-visitor.c |  29 +++
>  util/cutils.c                      |  82 +++++++++
>  23 files changed, 1575 insertions(+), 12 deletions(-)
>  create mode 100644 hw/acpi/hmat.c
>  create mode 100644 hw/acpi/hmat.h

