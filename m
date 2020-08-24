Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B836C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1558C2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsUbUznF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1558C2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA97k-0001Ev-9O
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95V-0004hc-Fq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:25 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:45966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95T-0004mj-La
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:25 -0400
Received: by mail-wr1-x435.google.com with SMTP id h15so1253552wrt.12
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2GcBUZfUY5fhS5QEBbnbqWMBrEShvuavXlhO/jcgc7I=;
 b=GsUbUznFibTeSNfKWSwQZ7jXLC4An6bX/40YMYlmH5slAYAOs7dHtbCTdwBv/qUGFc
 6Ls5/8N8qZFGmU/1h9RADN32obHxu/GypM5KdDvOuyveuLnGAO1VCriTbwcy0e1JCUR8
 0am74xVzap1x5dcvvKQfnoOK/vvxF8dFXYkeFTn9CPzuK7VO2lKnB1Mm2xSqfkDQmrmi
 OXbhh9UZ6XezJ65JbwHNF6TGWpLwkzs+7z4eFi2YV2jvegs97SsBjYAiRKJVzzCCp+aV
 EGCJcaikkdFkQSJLQEB+SJuIfhls2b8oqkaOEy43B64trYoz6lQRyWiYrtl/svCG4FXU
 /zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2GcBUZfUY5fhS5QEBbnbqWMBrEShvuavXlhO/jcgc7I=;
 b=JSSkosdEUZHDl9g4Iw5G0TdC2/Sujuz+J1NuEOA/0UFIkPj6IH8Q5V87Q1CCNN18QH
 3cNtMgjKtmHiclq4OZT4JojBcrjFdhnQsKvckqAjYVywTtelgOVW7OOmqi5tOX2xUhT6
 6sCGCGqfAM8LO3XiyZPTXCq/ET3ZtP0EVua19pMVm/6zsxrY1tMUtLKHA2mOKQTsgkHX
 BM0HkYtvBDETb97ovx4kgB6H2aS1dsz8hFYIUD6dgG4syjt96nudw8lmayECYdxmwFj/
 rKCmerHTKWX9DFXj6fTGVyIMNh/LF0dnHLIrvM2NWOuGn2Z8ER6ww86ziV2rXvBS75i3
 OZBQ==
X-Gm-Message-State: AOAM5322wpQ/vdwXKXDDk5wD5wu9/gtpr1kp8Y2PI62xoRo5VAEZOMJE
 qg3SMQp/eg4yVe2cPHloex8LRvitH4xIujme
X-Google-Smtp-Source: ABdhPJxFl3AAApigWCe47yR6zXlIRzOg62eP1MtHzabxkkX3SDxoiE5DahRAWOzaWLfaMiKKfol/zQ==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr5204638wro.239.1598262502002; 
 Mon, 24 Aug 2020 02:48:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/27] hw/arm/smmuv3: Introduce smmuv3_s1_range_inval() helper
Date: Mon, 24 Aug 2020 10:47:51 +0100
Message-Id: <20200824094811.15439-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Let's introduce an helper for S1 IOVA range invalidation.
This will be used for NH_VA and NH_VAA commands. It decodes
the same fields, trace, calls the UNMAP notifiers and
invalidate the corresponding IOTLB entries.

At the moment, we do not support 3.2 range invalidation yet.
So it reduces to a single IOVA invalidation.

Note the leaf bit now is also decoded for the CMD_TLBI_NH_VAA
command. At the moment it is only used for tracing.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-7-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c     | 36 +++++++++++++++++-------------------
 hw/arm/trace-events |  3 +--
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b717bde8320..e4a2cea7adc 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -836,6 +836,22 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
     }
 }
 
+static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
+{
+    dma_addr_t addr = CMD_ADDR(cmd);
+    uint8_t type = CMD_TYPE(cmd);
+    uint16_t vmid = CMD_VMID(cmd);
+    bool leaf = CMD_LEAF(cmd);
+    int asid = -1;
+
+    if (type == SMMU_CMD_TLBI_NH_VA) {
+        asid = CMD_ASID(cmd);
+    }
+    trace_smmuv3_s1_range_inval(vmid, asid, addr, leaf);
+    smmuv3_inv_notifiers_iova(s, asid, addr);
+    smmu_iotlb_inv_iova(s, asid, addr);
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -966,27 +982,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             smmu_iotlb_inv_all(bs);
             break;
         case SMMU_CMD_TLBI_NH_VAA:
-        {
-            dma_addr_t addr = CMD_ADDR(&cmd);
-            uint16_t vmid = CMD_VMID(&cmd);
-
-            trace_smmuv3_cmdq_tlbi_nh_vaa(vmid, addr);
-            smmuv3_inv_notifiers_iova(bs, -1, addr);
-            smmu_iotlb_inv_iova(bs, -1, addr);
-            break;
-        }
         case SMMU_CMD_TLBI_NH_VA:
-        {
-            uint16_t asid = CMD_ASID(&cmd);
-            uint16_t vmid = CMD_VMID(&cmd);
-            dma_addr_t addr = CMD_ADDR(&cmd);
-            bool leaf = CMD_LEAF(&cmd);
-
-            trace_smmuv3_cmdq_tlbi_nh_va(vmid, asid, addr, leaf);
-            smmuv3_inv_notifiers_iova(bs, asid, addr);
-            smmu_iotlb_inv_iova(bs, asid, addr);
+            smmuv3_s1_range_inval(bs, &cmd);
             break;
-        }
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
         case SMMU_CMD_TLBI_EL2_ALL:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f74d3e920f1..c219fe9e828 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -45,8 +45,7 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%d)"
-smmuv3_cmdq_tlbi_nh_va(int vmid, int asid, uint64_t addr, bool leaf) "vmid =%d asid =%d addr=0x%"PRIx64" leaf=%d"
-smmuv3_cmdq_tlbi_nh_vaa(int vmid, uint64_t addr) "vmid =%d addr=0x%"PRIx64
+smmuv3_s1_range_inval(int vmid, int asid, uint64_t addr, bool leaf) "vmid =%d asid =%d addr=0x%"PRIx64" leaf=%d"
 smmuv3_cmdq_tlbi_nh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid %d"
-- 
2.20.1


