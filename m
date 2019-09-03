Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C42BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B6B23774
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o91Y+kEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B6B23774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B5Q-0007SG-Me
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArQ-0002ov-7f
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArO-0005wO-Uf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArO-0005w0-ON
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id z11so17998295wrt.4
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zwgsbRC7S/9tqfeU7JxypMKTOKpf8DEKt23oGutI3as=;
 b=o91Y+kEZ9ekJhZ76S0+e42h5hPE+3kvnLpVzMB6dhI+DFwhhNUYHILeaREJX1UJzKl
 oVdSpgzLxEAdhulwoDfUTWicwSlMXkWsMT2J3OZ1oKmi2FAQsaeluiatxD5Y4+Lvyqi1
 o+7XHPB8iWqEEeefzKQpvmudreDJ0UYXfrviw+EAFct0zrOG/YgMUE39nhZ59LuxPzdu
 TSC+g8j1KOtChSr1V97Im4Q6/VH0bsaeyKkHc+Og7rYiXBy8KGEndtSfJFPZ3hZNZQWO
 Cac6bQVFLX9jwi9BkBMufl5/48Nm9zMN3P5PLzMbqSgrSfsfzUYU9Lr0GmZHEzA7Ll27
 mhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zwgsbRC7S/9tqfeU7JxypMKTOKpf8DEKt23oGutI3as=;
 b=pr77NqenQARtAYF08SKV+iOuYlFHnHYmfSwD8OpdULhQIQPBk3dARc59ZF1oyagKzl
 IoUxhIGD3E4xMC8c8e/IfOqPaZ9I9aSE+uv7FrMzCpE8PUrKKlHHtuC+H3Q9Nbxvwy8m
 Yxa0XOBXKHS0buCydCAo28ulLFjORpz+pcL79ptcBx2nj+QLpNj7AhMaDctD58FG4fxy
 w/Zh7WckMQg+1EvlRU4kTvD5uf5mnosiZfOuWFiHzFCJYaH8z1bmN+8/wBtEhC9MMSjy
 8iVpnqz7weKI5ka694nkEXgH4EugBh7PGIvrIOYL0fUVuZuq16Ft65YqNxSK86UNN8p3
 VaCQ==
X-Gm-Message-State: APjAAAV3XaOlFuu1trcJckr0Lb+CPcVmyRWJM3Lap5nv6q3PeofBlL/G
 OBHyFeu/lagQDQMIAdUeXciyWUHHF5E2AA==
X-Google-Smtp-Source: APXvYqyxfhmZVOQC6h9j4JCQgWAc0MfurL2rR1HUFR01uHr0B+cMRjQK22n2NqCkoEvzI/hStjA4tg==
X-Received: by 2002:adf:fb11:: with SMTP id c17mr1500573wrr.0.1567525005632;
 Tue, 03 Sep 2019 08:36:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:20 +0100
Message-Id: <20190903153633.6651-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 08/21] hw/arm/smmuv3: Remove spurious error
 messages on IOVA invalidations
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

An IOVA/ASID invalidation is notified to all IOMMU Memory Regions
through smmuv3_inv_notifiers_iova/smmuv3_notify_iova.

When the notification occurs it is possible that some of the
PCIe devices associated to the notified regions do not have a
valid stream table entry. In that case we output a LOG_GUEST_ERROR
message, for example:

invalid sid=<SID> (L1STD span=0)
"smmuv3_notify_iova error decoding the configuration for iommu mr=<MR>

This is unfortunate as the user gets the impression that there
are some translation decoding errors whereas there are not.

This patch adds a new field in SMMUEventInfo that tells whether
the detection of an invalid STE must lead to an error report.
invalid_ste_allowed is set before doing the invalidations and
kept unset on actual translation.

The other configuration decoding error messages are kept since if the
STE is valid then the rest of the config must be correct.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20190822172350.12008-6-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h |  1 +
 hw/arm/smmuv3.c          | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b160289cd12..d190181ef1b 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -381,6 +381,7 @@ typedef struct SMMUEventInfo {
     uint32_t sid;
     bool recorded;
     bool record_trans_faults;
+    bool inval_ste_allowed;
     union {
         struct {
             uint32_t ssid;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 31ac4b15c30..db051dcac87 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -320,7 +320,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     uint32_t config;
 
     if (!STE_VALID(ste)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "invalid STE\n");
+        if (!event->inval_ste_allowed) {
+            qemu_log_mask(LOG_GUEST_ERROR, "invalid STE\n");
+        }
         goto bad_ste;
     }
 
@@ -407,8 +409,10 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
 
         if (!span) {
             /* l2ptr is not valid */
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "invalid sid=%d (L1STD span=0)\n", sid);
+            if (!event->inval_ste_allowed) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "invalid sid=%d (L1STD span=0)\n", sid);
+            }
             event->type = SMMU_EVT_C_BAD_STREAMID;
             return -EINVAL;
         }
@@ -603,7 +607,9 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s = sdev->smmu;
     uint32_t sid = smmu_get_sid(sdev);
-    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid};
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE,
+                           .sid = sid,
+                           .inval_ste_allowed = false};
     SMMUPTWEventInfo ptw_info = {};
     SMMUTranslationStatus status;
     SMMUState *bs = ARM_SMMU(s);
@@ -796,16 +802,13 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                dma_addr_t iova)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
-    SMMUEventInfo event = {};
+    SMMUEventInfo event = {.inval_ste_allowed = true};
     SMMUTransTableInfo *tt;
     SMMUTransCfg *cfg;
     IOMMUTLBEntry entry;
 
     cfg = smmuv3_get_config(sdev, &event);
     if (!cfg) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s error decoding the configuration for iommu mr=%s\n",
-                      __func__, mr->parent_obj.name);
         return;
     }
 
-- 
2.20.1


