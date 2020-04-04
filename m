Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC68C2BA1A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89740206E9
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9y1c2U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89740206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKhtc-0006Jl-Nw
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 08:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jKhsK-0004yT-Me
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jKhsJ-00074Q-J4
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:26:12 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jKhsJ-00073b-AV; Sat, 04 Apr 2020 08:26:11 -0400
Received: by mail-lj1-x244.google.com with SMTP id r7so9667738ljg.13;
 Sat, 04 Apr 2020 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/mVbxU5HIlyJ3CPwMR0UvPTLcyJH/YT6yvZCH4lqhNk=;
 b=t9y1c2U94OSeGNtvpnNyR4+ma+fLYxtmBXI25c/bBBIAX5Kc94BYu/MRlYO0iqlkyT
 RJT/hkkURtERPM8GO/4jhVv1CJO88MXLuUWiH19/S2mLVJL+axwnBvb4xn1SWufoOcIr
 vDwiZ/7K//wlrf5ygOWVdBKKic063CaEFhvAxoSuJpE9xuoBFl4sKd50LALtASvLlEyO
 z2sKGndFBWAnccBgdaN1G9Fg4uWMyTehF8lGZEmEk+MBylQ/rb0EikGniu+qupoEEPMV
 0gncU1uyHv1734Pw+yy33erhrw+qvo2NyqDoK+vWjB73C/7KcuUs26YZqlbfsAMJLvaq
 pmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/mVbxU5HIlyJ3CPwMR0UvPTLcyJH/YT6yvZCH4lqhNk=;
 b=qeYBLZppy1nnrnUWAOKW6ZDXnQpiKaioDX3PZd9wSHgwXck9Tb7otp1xZScgX0Qo0a
 l13jnEVMUDXOwwGkTLDKfa/3RhLUeueFIK/DtjRPiHIxQb6S58wTWigwJ/I/2h2pls5v
 qAnTJfH53WACV4/t8boIlNtznJyq2FgRIo8fO/mnNGy1P+8DoiIBgzHNadTtDzfmDeNG
 LNKNSUUeahqxuXAMoSnM3iyqZ8OWkkQNXMX1h2Nzin6GXwtzf6V+KA3g2y1kSflXKpwy
 mwixSzNPMvidK5Y84xkbg9waYRWiyYBbInw0RYsfqPpFeev1/nTjc3wvhuNEXTfDTkw4
 izGQ==
X-Gm-Message-State: AGi0PubGNijsv1xfdrVZBhh2tdikBce1PqACbDAl0weeeDc26nAbogCC
 78/pS8KIR1fYP79IrQfO4nkhY29HemF0YA==
X-Google-Smtp-Source: APiQypIRbcQhscanCFiX8xJXTdHWHtvSNwL8c5NTvwo30Q1SIMNgXIskEpmxpSixg5iBEV/EGZ4DQA==
X-Received: by 2002:a2e:b24c:: with SMTP id n12mr7838498ljm.7.1586003169880;
 Sat, 04 Apr 2020 05:26:09 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id z9sm4359591lfd.9.2020.04.04.05.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 05:26:09 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/2] dma/xlnx-zdma: Fix descriptor loading (MEM) wrt
 endianness
Date: Sat,  4 Apr 2020 14:27:17 +0200
Message-Id: <20200404122718.25111-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200404122718.25111-1-edgar.iglesias@gmail.com>
References: <20200404122718.25111-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

Fix descriptor loading from memory wrt host endianness.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/dma/xlnx-zdma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 1c45367f3c..5f4775f663 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -299,19 +299,22 @@ static void zdma_put_regaddr64(XlnxZDMA *s, unsigned int basereg, uint64_t addr)
     s->regs[basereg + 1] = addr >> 32;
 }
 
-static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr, void *buf)
+static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr,
+                                 XlnxZDMADescr *descr)
 {
     /* ZDMA descriptors must be aligned to their own size.  */
     if (addr % sizeof(XlnxZDMADescr)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "zdma: unaligned descriptor at %" PRIx64,
                       addr);
-        memset(buf, 0x0, sizeof(XlnxZDMADescr));
+        memset(descr, 0x0, sizeof(XlnxZDMADescr));
         s->error = true;
         return false;
     }
 
-    address_space_read(s->dma_as, addr, s->attr, buf, sizeof(XlnxZDMADescr));
+    descr->addr = address_space_ldq_le(s->dma_as, addr, s->attr, NULL);
+    descr->size = address_space_ldl_le(s->dma_as, addr + 8, s->attr, NULL);
+    descr->attr = address_space_ldl_le(s->dma_as, addr + 12, s->attr, NULL);
     return true;
 }
 
@@ -344,7 +347,7 @@ static void zdma_update_descr_addr(XlnxZDMA *s, bool type,
     } else {
         addr = zdma_get_regaddr64(s, basereg);
         addr += sizeof(s->dsc_dst);
-        address_space_read(s->dma_as, addr, s->attr, (void *) &next, 8);
+        next = address_space_ldq_le(s->dma_as, addr, s->attr, NULL);
     }
 
     zdma_put_regaddr64(s, basereg, next);
-- 
2.20.1


