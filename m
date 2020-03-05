Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16607C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F9F20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfP+TOaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F9F20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tWp-0000v4-21
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOw-0003H4-Uu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOv-00027G-Ph
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:10 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tOv-00026v-HK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:09 -0500
Received: by mail-wr1-x429.google.com with SMTP id t11so7799183wrw.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=x0koMjvwGuOCpGMER2fTln7XCO/uLklg3+AuMRzjjUc=;
 b=HfP+TOaRbmzoddCCUeVcHhPnJGYncpTcKZ10Un3bvQC/rBuQwAHWlqU5XwTEAPXImg
 Gm7Ywjuaw9qpf5RgfIsUJRBbU4HQX5/jiZvMl+elTIvcVz+eQbrS+cApGu+ETP71MXnx
 mU7Bzfns/YjJtw+HyAN1YlojqIpmEglD8HMykLXUhnwYsgWjVCIma+f3M+UJIaGhFG6R
 mLFUOs+E5bw33RnGBWRLGQ0SUUb2Z3TKhyFA24bm1NDb5W0rEI2h3HWUpP9PUOsqH2xe
 QDaDrbTpy/y2VcWzAkN2DZ0U25Ymie7h1gdzKCpV7chPZXDzWJVdtKZgQKvvsJnT+lxR
 igbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x0koMjvwGuOCpGMER2fTln7XCO/uLklg3+AuMRzjjUc=;
 b=OXNXCT1Td5iB5ooO95N0Ej0UJUIuQPlCyUlZ5SL92JEfKl/xqDSH8i0aYEw5o4+vno
 rNUFLNwr9c9AZitXSL6zjqU9F2+flC9RYh6oRhIdXAFD6zwa3nja75ELHvgM04XY/FjC
 XQTOkGJMFUIwvweVIjoEPaRUBHQr7a4LohpH15nRdrGzuMmRovM1yMXQsoZ+Enz3aff0
 vgsgBHwwXHUrhG0zF+ekMiiZwgdWOrcxjEmfGCg6MBjH2A3rhspqOhesfrmQyGFmPXqe
 2FjoafNlEZq7w60ComD+xRUU4IW0SQ7fHLDC16BROVuIELgnCj+HoSHxyQmCj5Pr7Pai
 Neog==
X-Gm-Message-State: ANhLgQ1jt5fwcvO743T9ex7dYcJIX5q+5HDr5NF6NW6JKXRQBuYxXi/a
 uKyoojDvU7dxEQj2z3XBWJ2nX4FsRyMe2A==
X-Google-Smtp-Source: ADFU+vtKEN049k1wqgfk2M71v5nr12+CTIgJ9F/ruXRIGc4rcIrJ2aYkdiwA0b8RB9yuzq3vGlLV2g==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr11020968wrt.102.1583425868214; 
 Thu, 05 Mar 2020 08:31:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/37] hw/arm/smmu-common: Simplify smmu_find_smmu_pcibus()
 logic
Date: Thu,  5 Mar 2020 16:30:28 +0000
Message-Id: <20200305163100.22912-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The smmu_find_smmu_pcibus() function was introduced (in commit
cac994ef43b) in a code format that could return an incorrect
pointer, which was then fixed by the previous commit.
We could have avoided this by writing the if() statement
differently. Do it now, in case this function is re-used.
The code is easier to review (harder to miss bugs).

Acked-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-common.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 67d7b2d0fd9..e13a5f4a7cb 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -290,20 +290,21 @@ inline int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
 {
     SMMUPciBus *smmu_pci_bus = s->smmu_pcibus_by_bus_num[bus_num];
+    GHashTableIter iter;
 
-    if (!smmu_pci_bus) {
-        GHashTableIter iter;
-
-        g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
-        while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
-            if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
-                s->smmu_pcibus_by_bus_num[bus_num] = smmu_pci_bus;
-                return smmu_pci_bus;
-            }
-        }
-        smmu_pci_bus = NULL;
+    if (smmu_pci_bus) {
+        return smmu_pci_bus;
     }
-    return smmu_pci_bus;
+
+    g_hash_table_iter_init(&iter, s->smmu_pcibus_by_busptr);
+    while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
+        if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
+            s->smmu_pcibus_by_bus_num[bus_num] = smmu_pci_bus;
+            return smmu_pci_bus;
+        }
+    }
+
+    return NULL;
 }
 
 static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
-- 
2.20.1


