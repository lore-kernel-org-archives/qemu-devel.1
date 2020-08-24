Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC2C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B49820639
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnYaNqnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B49820639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Dr-0005qV-NZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95a-0004ur-26
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95Y-0004nO-1r
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:29 -0400
Received: by mail-wr1-x435.google.com with SMTP id f7so8030633wrw.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6kPWsc9hK5bWcqLb2sRsR3vabCpYIdyWe54DMmHZ/ow=;
 b=PnYaNqnzqSE4MqGBwRowlNMbxvyRyxRfEFCpEHYKlK5xaWaXC7AwTYyDqgLG+RzduN
 80dxp0Y3HGOfnA2oY0L04FuTl/1Khx30SJOeaRYjxmL1phbBOkUod6zni5U1rtRpJp5U
 k/G7fxnsSFhFWr9bDkrE6e7CQPu9MKWsjNkaxhu16aCp/mF4FaN8JGBU6nxKgJ97Uecg
 LZ9h2EzMJSb33kgjWka+xBYFq3QRIeqSgM2PpayMrxCQziSVM+4fH+U6gITKQYATJhY/
 8L1WQE5bxTtUHBCvOPE8PwInxhfoJEeryHTQfVLq7LZ2O+yu9G+Dl4Rtqr8jqd6AD8h9
 yL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6kPWsc9hK5bWcqLb2sRsR3vabCpYIdyWe54DMmHZ/ow=;
 b=UrZ5dkOuwVmW3DYSYav7g3aZLW+sFSakQ4sRGKhlDicS9SUamtH70SGvFz/sguqtEy
 WhhiEUkpv9wAmBPuXs0LMd382An5RMIUFmSvXS5NgF6KK3D8oPBKp+bjKM+Bbc/1NRXt
 Qr5EmFb5jatrRv2tru7CfmHD4QUmatf0s5KrVmppc843qKz4COFC9Fv+JI/WSvrPKB+H
 mno+AYYqA/X0OqSL3J9jznc7mHwDwSVcPfdVAfbEY0eTaklNvEnIJ0wwTsrkCgAPntAv
 438A39eBgpzmIcuxFzdr5nMPAwBYxoelS2Rwr/2fGfYvMxbetCYVquUiY4XEVzxDTxD1
 xnqA==
X-Gm-Message-State: AOAM531y/FABMesMXsSMZD393kVryY0FB6hMGy1jhXECYg2FQpFranDS
 5QF18ksUz5n8jD5pOEVqWAjaQnzCd8q7ujov
X-Google-Smtp-Source: ABdhPJzd9wWcGWTlAF7Mu5m2EMhL7xFpJOn7U/s2Mqv1MDcGQdiPqBE6bXH/B45zhmibMoJtsoX90g==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr4955796wro.221.1598262506471; 
 Mon, 24 Aug 2020 02:48:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/27] hw/arm/smmuv3: Support HAD and advertise SMMUv3.1 support
Date: Mon, 24 Aug 2020 10:47:55 +0100
Message-Id: <20200824094811.15439-12-peter.maydell@linaro.org>
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

HAD is a mandatory features with SMMUv3.1 if S1P is set, which is
our case. Other 3.1 mandatory features come with S2P which we don't
have.

So let's support HAD and advertise SMMUv3.1 support in AIDR.

HAD support allows the CD to disable hierarchical attributes, ie.
if the HAD0/1 bit is set, the APTable field of table descriptors
walked through TTB0/1 is ignored.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-11-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h     | 2 ++
 include/hw/arm/smmu-common.h | 1 +
 hw/arm/smmu-common.c         | 2 +-
 hw/arm/smmuv3.c              | 6 +++++-
 hw/arm/trace-events          | 2 +-
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index bd34a4f3300..9ae7d97fafd 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -54,6 +54,7 @@ REG32(IDR1,                0x4)
 
 REG32(IDR2,                0x8)
 REG32(IDR3,                0xc)
+     FIELD(IDR3, HAD,         2, 1);
 REG32(IDR4,                0x10)
 REG32(IDR5,                0x14)
      FIELD(IDR5, OAS,         0, 3);
@@ -578,6 +579,7 @@ static inline int pa_range(STE *ste)
         lo = (x)->word[(sel) * 2 + 2] & ~0xfULL;            \
         hi | lo;                                            \
     })
+#define CD_HAD(x, sel)   extract32((x)->word[(sel) * 2 + 2], 1, 1)
 
 #define CD_TSZ(x, sel)   extract32((x)->word[0], (16 * (sel)) + 0, 6)
 #define CD_TG(x, sel)    extract32((x)->word[0], (16 * (sel)) + 6, 2)
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 4f6acf634cf..880dccd7c04 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -50,6 +50,7 @@ typedef struct SMMUTransTableInfo {
     uint64_t ttb;              /* TT base address */
     uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
     uint8_t granule_sz;        /* granule page shift */
+    bool had;                  /* hierarchical attribute disable */
 } SMMUTransTableInfo;
 
 typedef struct SMMUTLBEntry {
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8d89a86699a..3838db13952 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -316,7 +316,7 @@ static int smmu_ptw_64(SMMUTransCfg *cfg,
         if (is_table_pte(pte, level)) {
             ap = PTE_APTABLE(pte);
 
-            if (is_permission_fault(ap, perm)) {
+            if (is_permission_fault(ap, perm) && !tt->had) {
                 info->type = SMMU_PTW_ERR_PERMISSION;
                 goto error;
             }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 718f28462ea..b262f0e4a74 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -254,6 +254,8 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
 
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
+
    /* 4K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
@@ -270,6 +272,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
 
     s->features = 0;
     s->sid_split = 0;
+    s->aidr = 0x1;
 }
 
 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
@@ -506,7 +509,8 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
         if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
             goto bad_cd;
         }
-        trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz);
+        tt->had = CD_HAD(cd, i);
+        trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
     }
 
     event->record_trans_faults = CD_R(cd);
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 3d905e0f7d0..c8a4d80f6bd 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -39,7 +39,7 @@ smmuv3_translate_abort(const char *n, uint16_t sid, uint64_t addr, bool is_write
 smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
 smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
 smmuv3_decode_cd(uint32_t oas) "oas=%d"
-smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d"
+smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
 smmuv3_cmdq_cfgi_ste(int streamid) "streamid =%d"
 smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
-- 
2.20.1


