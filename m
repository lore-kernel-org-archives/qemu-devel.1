Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8D8C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA6D206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IaTwK/2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA6D206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE2wG-0003w2-9Y
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 00:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2i2-0003cr-5Q; Thu, 03 Sep 2020 23:48:18 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kE2hz-0004ys-9G; Thu, 03 Sep 2020 23:48:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BjNst3q4bz9sWD; Fri,  4 Sep 2020 13:47:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599191250;
 bh=lcJl+18AADR+U6YFsMe0OcdCykc44CX/5zvHrK7DkR0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IaTwK/2lf+K8SbwjkDC7n+PAv5ydgR9R6wKLt06S/cQHFRQWoOVLFGm018f+W5scz
 Dwx0CFpNZrR9zpxovrORNMjazzivuxJ48cEXo9xeySZN5YAPr9qOatw2QkVTrwdDds
 MOD6bXwDhOJFrUsGk0N9MH1ZNNfmAIZ7GUrcDy+s=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 26/30] ppc/spapr_nvdimm: turn spapr_dt_nvdimm() static
Date: Fri,  4 Sep 2020 13:47:15 +1000
Message-Id: <20200904034719.673626-27-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904034719.673626-1-david@gibson.dropbear.id.au>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

This function is only used inside spapr_nvdimm.c.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200901125645.118026-3-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_nvdimm.c         | 22 +++++++++++-----------
 include/hw/ppc/spapr_nvdimm.h |  1 -
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 95cbc30528..5188e2f503 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -106,16 +106,6 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp)
     }
 }
 
-int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
-                           void *fdt, int *fdt_start_offset, Error **errp)
-{
-    NVDIMMDevice *nvdimm = NVDIMM(drc->dev);
-
-    *fdt_start_offset = spapr_dt_nvdimm(fdt, 0, nvdimm);
-
-    return 0;
-}
-
 void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
@@ -127,7 +117,7 @@ void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
 }
 
 
-int spapr_dt_nvdimm(void *fdt, int parent_offset,
+static int spapr_dt_nvdimm(void *fdt, int parent_offset,
                            NVDIMMDevice *nvdimm)
 {
     int child_offset;
@@ -184,6 +174,16 @@ int spapr_dt_nvdimm(void *fdt, int parent_offset,
     return child_offset;
 }
 
+int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(drc->dev);
+
+    *fdt_start_offset = spapr_dt_nvdimm(fdt, 0, nvdimm);
+
+    return 0;
+}
+
 void spapr_dt_persistent_memory(void *fdt)
 {
     int offset = fdt_subnode_offset(fdt, 0, "persistent-memory");
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index fd1736634c..10a6d9dbbc 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -27,7 +27,6 @@ QEMU_BUILD_BUG_ON(SPAPR_MINIMUM_SCM_BLOCK_SIZE % SPAPR_MEMORY_BLOCK_SIZE);
 
 int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **errp);
-int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm);
 void spapr_dt_persistent_memory(void *fdt);
 void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp);
-- 
2.26.2


