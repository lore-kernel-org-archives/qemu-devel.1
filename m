Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D391FC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3B8206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/+hOrOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3B8206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5sC-0004VG-PH
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qQ-0001IV-SU; Tue, 01 Sep 2020 08:57:02 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:41864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qP-0002mI-7Z; Tue, 01 Sep 2020 08:57:02 -0400
Received: by mail-qk1-x741.google.com with SMTP id g72so766990qke.8;
 Tue, 01 Sep 2020 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rPSJXCdnCjZN031MOhXLn7MojgWPIyyf26HWbCzojXM=;
 b=E/+hOrORxVytuOCfJt2Z1p8yBu98n5NvWpdrgWYvpzrQtpiXiEdAe5RdiNjuNqn7Np
 tz9dUDDx0naGD9K9qKwRrUlQakiUu1/qhLHXPV/FWXNx4AkROXatDju1K2q1GiTXVH/i
 QTFZ5iei2BobqQxuiSG1846AuCZYRQKOfuzOxmeqvYsGIrnGJ1rW80QeIwozYA90rFjy
 IqhO4q1HGu1tT83JnMz74gSaXN/d2CcSi7Bky6ydX35vbS5zMuHvns/vmxN8kL2+rFOe
 UepEPOC41vfM8Hk+2su/QbiOcsFy5vzzA5FVpcvYf9d/vUa/Mbb0tur6qKdRYlixTXRV
 9gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rPSJXCdnCjZN031MOhXLn7MojgWPIyyf26HWbCzojXM=;
 b=LFzsT2oMlpQf24JTbkjRaHnnarL7WaH/N1Lw6w1yeHeKtXCn8fcCfec+fpcAMepauq
 1Q7JwCv2EY5e4FTarjAU9nvf/dpzUhU/ipVLuFJiewJVHA60usNPDlbKhA6ooJxm9qYe
 7RLadJYt4NOQ22TfYn+H7OXuakQkUF7rIbzmHrqyYoyN0AHLwM3prYsbgQNiMj7VgU24
 sB7JvT/c9x8C5Byx3MIam28r3SxzM/lfgDmKOatPx1BbrEXhSLjL0W2S8n7pXZ8BnOef
 oREOLBYCC4lxPYXLQVXIc5LNzqu921U2IzH9TBObz3OXxbdXaDSx1mQZlr5pDU3E9m60
 cP4w==
X-Gm-Message-State: AOAM532+h9yv1IrE3bdJcbxbS0cujORnORCesVdkQgqy/C7gM6x8V2xi
 iFZKs456Hl7ahZrDhMmcCbDbRfBtqbSZ+Q==
X-Google-Smtp-Source: ABdhPJzcSm67GpOXYeZNx5fVkC3vwNnRLHb2jeMTY+hwZjaVno30YCHnxDOwuA5790AW9voIgX//FQ==
X-Received: by 2002:a05:620a:a0b:: with SMTP id
 i11mr1787558qka.65.1598965017767; 
 Tue, 01 Sep 2020 05:56:57 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:6be:f6e3:c671:cefe:b943])
 by smtp.gmail.com with ESMTPSA id q7sm1430164qkf.35.2020.09.01.05.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 05:56:57 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] ppc/spapr_nvdimm: turn spapr_dt_nvdimm() static
Date: Tue,  1 Sep 2020 09:56:40 -0300
Message-Id: <20200901125645.118026-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901125645.118026-1-danielhb413@gmail.com>
References: <20200901125645.118026-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function is only used inside spapr_nvdimm.c.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
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


