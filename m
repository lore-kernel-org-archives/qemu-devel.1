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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A663C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E553C206E9
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 12:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH2pxAlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E553C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKhun-0000fw-4T
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 08:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jKhsL-0004z6-K4
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jKhsK-00075I-Ly
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 08:26:13 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:45952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jKhsK-00074W-Db; Sat, 04 Apr 2020 08:26:12 -0400
Received: by mail-lf1-x141.google.com with SMTP id f8so6658719lfe.12;
 Sat, 04 Apr 2020 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UIdgNnpIM7op2ww8CQDxqYn3C3b56loAVAluCHlbtpI=;
 b=OH2pxAlxJKC37T2qOgXtzCvuH7Zh5kcqZ4uz0l26jz0i59u2lzJ/cJsT+nsghk8QiE
 oeNiwEdtEbF0+F1GpjC79x1OxiKVAOI1/P4fVrtFG3/M+7BAnyDMMeJ9ZEUMd+rdjwi5
 aB9OSociNgxHXeENMTDiM50HzWnqQRDkhu5ir7Nw1rKYkjA8pQDf8rxYztP29BK6sz+a
 Yea9j/KMTkY9oI9oL1auGYWhL0E7xbBPmLUXasc+sy/h+ccRrx6ir6uN7AE4SArpIH08
 tDNUPgGAxQkSSjjZ+p3XMAxiFeK5SpkhsN1S/mcf2Ax3sKYkCCzrLY4KIw7dC4CI7vY3
 TXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UIdgNnpIM7op2ww8CQDxqYn3C3b56loAVAluCHlbtpI=;
 b=eoYHrgINX9NtWkEVDakmFAx8Lt+Mzp/ZW3ydZS2CfW/x8aZYJYDHT6h7NxPg1WoeNj
 IB7UJ8IepEPnjMSrbXtakG/ip+jWmf/91bRne9sP73sA33PT6qKWJKw2etEV1m1MxThE
 cEyNCywowf9Y74eGxIMSlOMeLZuUiT6c2bMWyER6FunddNJnAl6pJ4g6Kjg5Dq+1c1ux
 uIpTNKADsyJqhgdp8Egmj3Yil1F5yMvc/ohQFP80JU/8zJi9WOgK2OpuXnoBYoopQMzn
 rRxDvXK0POASUAqHy2gVstDKaVQuAx4Dd4aMBK6Tp3K+cKjNkKROF6KKAfpGiYph46ZG
 PbTg==
X-Gm-Message-State: AGi0PuaZmkB/3wz5SeN+YSxU/It3jb8ySuz07DVRebcEG+LocjQFuFjf
 59S1hrMoZtdivxFkh8jFoFhIpWDaAaB8Mg==
X-Google-Smtp-Source: APiQypJxgmGM9DAB4gVNwGv9G3DJJFgTp35z7KiJXRSk08KftWfFe84jV6/NvTeD2/a44rc4KAVijQ==
X-Received: by 2002:a19:430b:: with SMTP id q11mr1103901lfa.142.1586003171052; 
 Sat, 04 Apr 2020 05:26:11 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id i4sm7877776lfl.57.2020.04.04.05.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 05:26:10 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] dma/xlnx-zdma: Fix descriptor loading (REG) wrt
 endianness
Date: Sat,  4 Apr 2020 14:27:18 +0200
Message-Id: <20200404122718.25111-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200404122718.25111-1-edgar.iglesias@gmail.com>
References: <20200404122718.25111-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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

Fix descriptor loading from registers wrt host endianness.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/dma/xlnx-zdma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 5f4775f663..4121a1b489 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -299,6 +299,14 @@ static void zdma_put_regaddr64(XlnxZDMA *s, unsigned int basereg, uint64_t addr)
     s->regs[basereg + 1] = addr >> 32;
 }
 
+static void zdma_load_descriptor_reg(XlnxZDMA *s, unsigned int reg,
+                                     XlnxZDMADescr *descr)
+{
+    descr->addr = zdma_get_regaddr64(s, reg);
+    descr->size = s->regs[reg + 2];
+    descr->attr = s->regs[reg + 3];
+}
+
 static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr,
                                  XlnxZDMADescr *descr)
 {
@@ -324,8 +332,7 @@ static void zdma_load_src_descriptor(XlnxZDMA *s)
     unsigned int ptype = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POINT_TYPE);
 
     if (ptype == PT_REG) {
-        memcpy(&s->dsc_src, &s->regs[R_ZDMA_CH_SRC_DSCR_WORD0],
-               sizeof(s->dsc_src));
+        zdma_load_descriptor_reg(s, R_ZDMA_CH_SRC_DSCR_WORD0, &s->dsc_src);
         return;
     }
 
@@ -360,8 +367,7 @@ static void zdma_load_dst_descriptor(XlnxZDMA *s)
     bool dst_type;
 
     if (ptype == PT_REG) {
-        memcpy(&s->dsc_dst, &s->regs[R_ZDMA_CH_DST_DSCR_WORD0],
-               sizeof(s->dsc_dst));
+        zdma_load_descriptor_reg(s, R_ZDMA_CH_DST_DSCR_WORD0, &s->dsc_dst);
         return;
     }
 
-- 
2.20.1


