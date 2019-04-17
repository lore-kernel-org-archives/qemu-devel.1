Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D70C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 01:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B67C21773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 01:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B67C21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGZeA-0001NF-BF
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 21:45:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hGZZo-0006U7-66
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hGZZn-0006Lg-7m
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 21:41:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:47701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hGZZk-0006GL-U5; Tue, 16 Apr 2019 21:41:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	16 Apr 2019 18:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,360,1549958400"; d="scan'208";a="338161171"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2019 18:41:17 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Wed, 17 Apr 2019 09:40:34 +0800
Message-Id: <20190417014038.26018-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190417014038.26018-1-richardw.yang@linux.intel.com>
References: <20190417014038.26018-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH v3 2/6] hw/arm/virt-acpi-build: remove
 unnecessary variable mcfg_start
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, mst@redhat.com,
	shannon.zhaosl@gmail.com,
	Wei Yang <richardw.yang@linux.intel.com>, imammedo@redhat.com,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417014034.T3rF33CGNXFdb1TJHku2aNKPTbnCc49dxqDLLjO_o-U@z>

mcfg_start points to the start of MCFG table and is used in
build_header. While this information could be derived from mcfg.

This patch removes the unnecessary variable mcfg_start.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/virt-acpi-build.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 857989362a..e09e7eff8d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -552,7 +552,6 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     const MemMapEntry *memmap = vms->memmap;
     int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
     int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
-    int mcfg_start = table_data->len;
 
     mcfg = acpi_data_push(table_data, len);
     mcfg->allocation[0].address = cpu_to_le64(memmap[ecam_id].base);
@@ -563,8 +562,7 @@ build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     mcfg->allocation[0].end_bus_number =
         PCIE_MMCFG_BUS(memmap[ecam_id].size - 1);
 
-    build_header(linker, table_data, (void *)(table_data->data + mcfg_start),
-                 "MCFG", table_data->len - mcfg_start, 1, NULL, NULL);
+    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
 }
 
 /* GTDT */
-- 
2.19.1


