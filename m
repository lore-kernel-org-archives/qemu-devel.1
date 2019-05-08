Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307B6C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054A721019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054A721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOG8w-0000r8-7I
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:33:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFvp-0004wG-9W
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFvn-0008QM-Va
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:19:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:57347)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hOFvn-0008Mi-Mr
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:19:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 May 2019 23:19:52 -0700
X-ExtLoop1: 1
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.92])
	by fmsmga005.fm.intel.com with ESMTP; 07 May 2019 23:19:49 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com, mst@redhat.com, eblake@redhat.com,
	ehabkost@redhat.com, xiaoguangrong.eric@gmail.com
Date: Wed,  8 May 2019 14:17:15 +0800
Message-Id: <20190508061726.27631-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v4 00/11] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, tao3.xu@intel.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
according to the command line. The ACPI HMAT describes the memory attributes,
such as memory side cache attributes and bandwidth and latency details,
related to the System Physical Address (SPA) Memory Ranges.
The software is expected to use this information as hint for optimization.

OSPM evaluates HMAT only during system initialization. Any changes to the HMAT
state at runtime or information regarding HMAT for hot plug are communicated
using the _HMA method.

The V3 patches link:
https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg08076.html
The V2 patches link:
https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg02276.html
The V1 RESEND patches link:
https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg05368.html

Changelog:
v4:
    - send the patch of "move numa global variables into MachineState"
    together with HMAT patches.
    https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03662.html
    - spilt the 1/8 of v3 patch into two patches, 4/11 introduces
    build_mem_ranges() and 5/11 builds HMAT (Igor)
    - use build_append_int_noprefix() to build parts of ACPI table in
    all patches (Igor)
    - Split 8/8 of patch v3 into two parts, 10/11 introduces NFIT
    generalizations (build_acpi_aml_common), and use it in 11/11 to
    simplify hmat_build_aml (Igor)
    - use MachineState instead of PCMachineState to build HMAT more
    generalic (Igor)
    - move the 7/8 v3 patch into the former patches
    - update the version tag from 4.0 to 4.1
v3:
    - rebase the fixing patch into the jingqi's patches (Eric)
    - update the version tag from 3.10 to 4.0 (Eric)
v2:
  Per Igor and Eric's comments, fix some coding style and small issues:
    - update the version number in qapi/misc.json
    - including the expansion of the acronym HMAT in qapi/misc.json
    - correct spell mistakes in qapi/misc.json and qemu-options.hx
    - fix the comment syle in hw/i386/acpi-build.c
    and hw/acpi/hmat.h
   - remove some unnecessary head files in hw/acpi/hmat.c 
   - use hardcoded numbers from spec to generate
   Memory Subsystem Address Range Structure in hw/acpi/hmat.c
   - drop the struct AcpiHmat and AcpiHmatSpaRange
    in hw/acpi/hmat.h
   - rewrite NFIT code to build _HMA method

Liu Jingqi (6):
  hmat acpi: Build Memory Subsystem Address Range Structure(s) in ACPI
    HMAT
  hmat acpi: Build System Locality Latency and Bandwidth Information
    Structure(s) in ACPI HMAT
  hmat acpi: Build Memory Side Cache Information Structure(s) in ACPI
    HMAT
  numa: Extend the command-line to provide memory latency and bandwidth
    information
  numa: Extend the command-line to provide memory side cache information
  hmat acpi: Implement _HMA method to update HMAT at runtime

Tao Xu (5):
  numa: move numa global variable nb_numa_nodes into MachineState
  numa: move numa global variable have_numa_distance into MachineState
  numa: move numa global variable numa_info into MachineState
  acpi: introduce AcpiDeviceIfClass.build_mem_ranges hook
  acpi: introduce build_acpi_aml_common for NFIT generalizations

 exec.c                               |   5 +-
 hw/acpi/Kconfig                      |   5 +
 hw/acpi/Makefile.objs                |   1 +
 hw/acpi/aml-build.c                  |   9 +-
 hw/acpi/hmat.c                       | 574 +++++++++++++++++++++++++++
 hw/acpi/hmat.h                       | 179 +++++++++
 hw/acpi/nvdimm.c                     |  49 ++-
 hw/acpi/piix4.c                      |   1 +
 hw/arm/boot.c                        |   4 +-
 hw/arm/virt-acpi-build.c             |  17 +-
 hw/arm/virt.c                        |   8 +-
 hw/core/machine.c                    |  24 +-
 hw/i386/acpi-build.c                 | 125 +++---
 hw/i386/pc.c                         |  14 +-
 hw/i386/pc_piix.c                    |   4 +
 hw/i386/pc_q35.c                     |   4 +
 hw/isa/lpc_ich9.c                    |   1 +
 hw/mem/pc-dimm.c                     |   2 +
 hw/pci-bridge/pci_expander_bridge.c  |   2 +
 hw/ppc/spapr.c                       |  20 +-
 hw/ppc/spapr_pci.c                   |   2 +
 include/hw/acpi/acpi_dev_interface.h |   3 +
 include/hw/acpi/aml-build.h          |   2 +-
 include/hw/boards.h                  |  43 ++
 include/hw/i386/pc.h                 |   1 +
 include/hw/mem/nvdimm.h              |   6 +
 include/qemu/typedefs.h              |   3 +
 include/sysemu/numa.h                |  13 +-
 include/sysemu/sysemu.h              |  30 ++
 monitor.c                            |   4 +-
 numa.c                               | 282 +++++++++++--
 qapi/misc.json                       | 162 +++++++-
 qemu-options.hx                      |  28 +-
 stubs/Makefile.objs                  |   1 +
 stubs/pc_build_mem_ranges.c          |   6 +
 35 files changed, 1501 insertions(+), 133 deletions(-)
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 hw/acpi/hmat.h
 create mode 100644 stubs/pc_build_mem_ranges.c

-- 
2.17.1


