Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E0CC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936FD2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936FD2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSdoe-0003kT-R7
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSdho-0008Uk-7J
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSdhi-0002KM-Tz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:03:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSdhh-00020I-2A
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:03:45 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA0FFC05683F
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 09:03:43 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id a186so1454903qkb.18
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 01:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ylRFjLVDCY8fqTOJCIQ7bWHs0QLr1Wa84LlSoCgYUjE=;
 b=Ehbv3KoFnOehNxUfH3D+VADDxsUEg6ryFaj2kHRHctrzSTDfg9Zvu/hqVCUt/Xv7kF
 R3lEEdFV8he9TDIOEACrrtpBXkXTmSj4aKt3abaM2xR1WTGhXiC+ZKOGDBqnqK9h1N7u
 5uBisi2y9j4cL0FI69JKoj9wZY+Wk5WOunHJhs2tqitiBF0fi2LMtXh9zWv/IllqahNQ
 OtOKTgLmV09Y6+U+B0DFdO15F+Ui++4WilCxWaegOcoD4InfS8DMirmXJEK5qMCCx27U
 sKMMYo41QQVkLqlOhk8QdX+xYX8keIgDV6S6XB8oXwOHE6jjoQQZH2+Z9/7eALw2bCf4
 V8pw==
X-Gm-Message-State: APjAAAXMpH+wMFmEHCGO+FNnVzNsdKt9RIPZ4s5iYrw1jie8Z2CQ4aX6
 h7mVcTq4/5XX/g3UAIHKrhz+xkkSnmf4dXR5HJF32HPyXOpAFvZYkQd4JCSX7XyzQNtp/dWVLte
 FGHcuN8Omf8nn9Dg=
X-Received: by 2002:a37:4e44:: with SMTP id c65mr1731634qkb.357.1573117422864; 
 Thu, 07 Nov 2019 01:03:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIspZ6NQJKN8TvrSZBar1JTbI9yZkqMPuSkHFE1nc9lzYmsAujHYr0hCo1hjqITY/Y6AKR3A==
X-Received: by 2002:a37:4e44:: with SMTP id c65mr1731605qkb.357.1573117422586; 
 Thu, 07 Nov 2019 01:03:42 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id m25sm1016606qtc.0.2019.11.07.01.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 01:03:41 -0800 (PST)
Date: Thu, 7 Nov 2019 04:03:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v15 00/12] Build ACPI Heterogeneous Memory Attribute
 Table (HMAT)
Message-ID: <20191107040314-mutt-send-email-mst@kernel.org>
References: <20191107074511.14304-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107074511.14304-1-tao3.xu@intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, jingqi.liu@intel.com, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com, jonathan.cameron@huawei.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 03:44:59PM +0800, Tao Xu wrote:
> This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
> according to the command line. The ACPI HMAT describes the memory attributes,
> such as memory side cache attributes and bandwidth and latency details,
> related to the Memory Proximity Domain.
> The software is expected to use HMAT information as hint for optimization.
> 
> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
> the platform's HMAT tables.


ok this looks good to me.
Given we are in freeze, please ping me after the release to merge this.

> The V14 patches link:
> https://patchwork.kernel.org/cover/11214887/
> 
> Changelog:
> v15:
>     - Add a new patch to refactor do_strtosz() (Eduardo)
>     - Make tests without breaking CI (Michael)
> v14:
>     - Reuse the codes of do_strtosz to build qemu_strtotime_ns
>       (Eduardo)
>     - Squash patch v13 01/12 and 02/12 together (Daniel and Eduardo)
>     - Drop time unit picosecond (Eric)
>     - Use qemu ctz64 and clz64 instead of builtin function
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
>     - Add machine oprion properties "-machine hmat=on|off" for enabling
>     or disabling HMAT in QEMU.
> 
> Liu Jingqi (5):
>   numa: Extend CLI to provide memory latency and bandwidth information
>   numa: Extend CLI to provide memory side cache information
>   hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
>   hmat acpi: Build System Locality Latency and Bandwidth Information
>     Structure(s)
>   hmat acpi: Build Memory Side Cache Information Structure(s)
> 
> Tao Xu (7):
>   util/cutils: refactor do_strtosz() to support suffixes list
>   util/cutils: Add qemu_strtotime_ns()
>   qapi: Add builtin type time
>   tests: Add test for QAPI builtin type time
>   numa: Extend CLI to provide initiator information for numa nodes
>   numa: Calculate hmat latency and bandwidth entry list
>   tests/bios-tables-test: add test cases for ACPI HMAT
> 
>  hw/acpi/Kconfig                       |   7 +-
>  hw/acpi/Makefile.objs                 |   1 +
>  hw/acpi/hmat.c                        | 263 ++++++++++++++++++++++++
>  hw/acpi/hmat.h                        |  42 ++++
>  hw/core/machine.c                     |  64 ++++++
>  hw/core/numa.c                        | 284 +++++++++++++++++++++++++-
>  hw/i386/acpi-build.c                  |   5 +
>  include/qapi/visitor-impl.h           |   4 +
>  include/qapi/visitor.h                |   8 +
>  include/qemu/cutils.h                 |   1 +
>  include/sysemu/numa.h                 | 104 ++++++++++
>  qapi/machine.json                     | 178 +++++++++++++++-
>  qapi/opts-visitor.c                   |  22 ++
>  qapi/qapi-visit-core.c                |  12 ++
>  qapi/qobject-input-visitor.c          |  18 ++
>  qapi/trace-events                     |   1 +
>  qemu-options.hx                       |  96 ++++++++-
>  scripts/qapi/schema.py                |   1 +
>  tests/bios-tables-test-allowed-diff.h |   8 +
>  tests/bios-tables-test.c              |  44 ++++
>  tests/data/acpi/pc/APIC.acpihmat      |   0
>  tests/data/acpi/pc/DSDT.acpihmat      |   0
>  tests/data/acpi/pc/HMAT.acpihmat      |   0
>  tests/data/acpi/pc/SRAT.acpihmat      |   0
>  tests/data/acpi/q35/APIC.acpihmat     |   0
>  tests/data/acpi/q35/DSDT.acpihmat     |   0
>  tests/data/acpi/q35/HMAT.acpihmat     |   0
>  tests/data/acpi/q35/SRAT.acpihmat     |   0
>  tests/test-cutils.c                   | 204 ++++++++++++++++++
>  tests/test-keyval.c                   | 122 +++++++++++
>  tests/test-qobject-input-visitor.c    |  29 +++
>  util/cutils.c                         |  86 +++++---
>  32 files changed, 1562 insertions(+), 42 deletions(-)
>  create mode 100644 hw/acpi/hmat.c
>  create mode 100644 hw/acpi/hmat.h
>  create mode 100644 tests/data/acpi/pc/APIC.acpihmat
>  create mode 100644 tests/data/acpi/pc/DSDT.acpihmat
>  create mode 100644 tests/data/acpi/pc/HMAT.acpihmat
>  create mode 100644 tests/data/acpi/pc/SRAT.acpihmat
>  create mode 100644 tests/data/acpi/q35/APIC.acpihmat
>  create mode 100644 tests/data/acpi/q35/DSDT.acpihmat
>  create mode 100644 tests/data/acpi/q35/HMAT.acpihmat
>  create mode 100644 tests/data/acpi/q35/SRAT.acpihmat
> 
> -- 
> 2.20.1

