Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92804C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E84D2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWf4kD0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E84D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0Fh-0004js-ES
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Ao-0006Zx-Fv
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Am-00023r-BW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:22 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jK0Am-00021z-3i; Thu, 02 Apr 2020 09:46:20 -0400
Received: by mail-lj1-x242.google.com with SMTP id 19so3265853ljj.7;
 Thu, 02 Apr 2020 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TLzE2qyREnbaDqlCoLajdWkY9S6FLWSn1nRwtU02lS4=;
 b=cWf4kD0tqff1FpoKtDsdz4F13D6TjBFJCPrBpb9VYbAme1/R22JtubShlbYm1T1E90
 VcOr61DgvfL1dUNH8Zer0wFTvazpz2Bd3Ga2YpENcjDtiuPXmR9qesMiWBB/DaAY4251
 UsbMQLb1v/ARH0fmmDjiLpWwf1AAdILrwaJUphF8vZQeEhlfIBsYsuWt5BEOiQcd9+s9
 o7M10bVknTttz2fT8kxztLG3kG+GOPQ+NCAW9LFVxGOnYldYdzuqRUgjVm27dRze7noU
 vgH/kndj1+J88hyW1n27o3r8tD+y1quAiK9UppG0pGk4jTBtMfL8gVpqrIRJpFTfM78o
 S+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TLzE2qyREnbaDqlCoLajdWkY9S6FLWSn1nRwtU02lS4=;
 b=s3JhNkFMpp3W4ROoXWHHIKPGC16NT/7x9N0UcEOXlQmXIVIbZVRKMxjAfTzOvAJxuV
 mYpsOdY4SoV/0Z2tTYji+i4zOYJvtCSnSWYD0ZaNBYJmb3UJzouJfH0mkasZ47lsWeZj
 KwJw8m+LqSZWt88V1217VSu6HGs1zrlyLiezVWOCRVyPqP9e8d/aoXFNJfown23TuuzL
 F4yJcPPSKu0JGPX9RSpLN+BYxEpHgdtf3BbebXr0K/FrRnH9a5w+pCl9ci64W6g85/nu
 myab3sR3RuCu0OmReJNZGTVjTe0B5XyjF5avbjVf2g7YVytdcTgfEltj5VviVvJ/Pcvm
 K+aA==
X-Gm-Message-State: AGi0PuZzBrT6mtlyqYT+P7cvCL5Z6rtPqh55eKHrZsuLT2EQUiy2UreQ
 Pka6YR2wkuuvcNHdTMwmdf7jnC4oMrP6LA==
X-Google-Smtp-Source: APiQypIy6V97Eet4AkjNxuBYYWtbQ3d1Ukzl4J6cEj9tOz8gz3eeL2gaQ6Vk8RnFvnqj4itThdjQAA==
X-Received: by 2002:a05:651c:22e:: with SMTP id
 z14mr2017486ljn.64.1585835178613; 
 Thu, 02 Apr 2020 06:46:18 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b16sm3939517lfq.34.2020.04.02.06.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 06:46:18 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/5] dma/xlnx-zdma: Reorg to fix CUR_DSCR
Date: Thu,  2 Apr 2020 15:47:21 +0200
Message-Id: <20200402134721.27863-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402134721.27863-1-edgar.iglesias@gmail.com>
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Reorganize the descriptor handling so that CUR_DSCR always
points to the next descriptor to be processed.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/dma/xlnx-zdma.c | 47 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index e856d233f2..1c45367f3c 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -333,10 +333,28 @@ static void zdma_load_src_descriptor(XlnxZDMA *s)
     }
 }
 
+static void zdma_update_descr_addr(XlnxZDMA *s, bool type,
+                                   unsigned int basereg)
+{
+    uint64_t addr, next;
+
+    if (type == DTYPE_LINEAR) {
+        addr = zdma_get_regaddr64(s, basereg);
+        next = addr + sizeof(s->dsc_dst);
+    } else {
+        addr = zdma_get_regaddr64(s, basereg);
+        addr += sizeof(s->dsc_dst);
+        address_space_read(s->dma_as, addr, s->attr, (void *) &next, 8);
+    }
+
+    zdma_put_regaddr64(s, basereg, next);
+}
+
 static void zdma_load_dst_descriptor(XlnxZDMA *s)
 {
     uint64_t dst_addr;
     unsigned int ptype = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POINT_TYPE);
+    bool dst_type;
 
     if (ptype == PT_REG) {
         memcpy(&s->dsc_dst, &s->regs[R_ZDMA_CH_DST_DSCR_WORD0],
@@ -349,24 +367,10 @@ static void zdma_load_dst_descriptor(XlnxZDMA *s)
     if (!zdma_load_descriptor(s, dst_addr, &s->dsc_dst)) {
         ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, AXI_RD_DST_DSCR, true);
     }
-}
-
-static uint64_t zdma_update_descr_addr(XlnxZDMA *s, bool type,
-                                       unsigned int basereg)
-{
-    uint64_t addr, next;
 
-    if (type == DTYPE_LINEAR) {
-        next = zdma_get_regaddr64(s, basereg);
-        next += sizeof(s->dsc_dst);
-        zdma_put_regaddr64(s, basereg, next);
-    } else {
-        addr = zdma_get_regaddr64(s, basereg);
-        addr += sizeof(s->dsc_dst);
-        address_space_read(s->dma_as, addr, s->attr, &next, 8);
-        zdma_put_regaddr64(s, basereg, next);
-    }
-    return next;
+    /* Advance the descriptor pointer.  */
+    dst_type = FIELD_EX32(s->dsc_dst.words[3], ZDMA_CH_DST_DSCR_WORD3, TYPE);
+    zdma_update_descr_addr(s, dst_type, R_ZDMA_CH_DST_CUR_DSCR_LSB);
 }
 
 static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
@@ -387,14 +391,7 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
         dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
                               SIZE);
         if (dst_size == 0 && ptype == PT_MEM) {
-            uint64_t next;
-            bool dst_type = FIELD_EX32(s->dsc_dst.words[3],
-                                       ZDMA_CH_DST_DSCR_WORD3,
-                                       TYPE);
-
-            next = zdma_update_descr_addr(s, dst_type,
-                                          R_ZDMA_CH_DST_CUR_DSCR_LSB);
-            zdma_load_descriptor(s, next, &s->dsc_dst);
+            zdma_load_dst_descriptor(s);
             dst_size = FIELD_EX32(s->dsc_dst.words[2], ZDMA_CH_DST_DSCR_WORD2,
                                   SIZE);
         }
-- 
2.20.1


