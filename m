Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55A0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6DD2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGxQVAui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6DD2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYp8-0002oF-Ng
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkL-0004Cq-UY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:33 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkK-0007Xh-WC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:33 -0400
Received: by mail-wr1-x42b.google.com with SMTP id p5so20045211wrw.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9a9rBXB8KD2CXSqoopyENJkbJU2VWTQAQ5EXFbh1LNA=;
 b=YGxQVAuiXdbwv6EeStmq/ck0IrzGmKhrLXGTjX4NSrLG9ggiBo/wUGQpDFZfoHZ8Lj
 cplbrJCHMyk60j3WPI22pbSRkAyKDdnxv1UIU+IGr9noeqaQ/vSvU9e45j2sh6INImLF
 v04KRjgoJNOL2AKrSnICCvT3uiGBqhfpracS5jugZHFwLUSgurwwmSzaULP0Qzskv54+
 +4PK41yVNjy/a9gCPz2mMdVzvbJCRAsUMl1zX8xBitMCv+d+iGnz7nl1H/XhCu4B3Zvv
 rP49OJBV3te4gCe8BCLLEFYW35uXYrP6cdsEyLfsAaqAD8zWR8on1ffdEMAfutON76CU
 5BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9a9rBXB8KD2CXSqoopyENJkbJU2VWTQAQ5EXFbh1LNA=;
 b=GVLxawLNGMtK0mzDoiQPk2HwJoZJpqO+mYbuOYGnihd3ofklmXXMF1B0ne0JP0uuY2
 1di5pe2bKgp9rqmYncyPy6fqb5b2n+DVCWmjF0Bf6PRQBehtkfOakuOu1RKcUUnKniuk
 Y7c0JMCsqzmiF3fEXYAczfjtXLu9sPRhkN+wYd1GkhZnz08BBZfsnqdaVoZzqcIO3tMt
 FKj28bLRriNmU1PQTlmfmq2wIQb+NluXABaOcbVPlxjpRGNgIjdyVIQLB88NR1hPqtVf
 1wZCuq4bkARq9O4OHgfDNVI0zqREaZroXUxoCBaHrUM9VcHYWB5rmfvHgzz9Rap74DEu
 197g==
X-Gm-Message-State: AOAM531YrqXPhHkEfh0PQaOf/Pga03NfTMkHAHB+apyHKYBO8N83jR4B
 BF06psSo/lIKfEc6oyAYVQ2UGw/d
X-Google-Smtp-Source: ABdhPJxMHLkrxcsKH3bmqZgBNXfsMl++/2EONiMbAe3UgadSbv5d/xaO97cK9ri64yKMG70km4LOmA==
X-Received: by 2002:adf:e749:: with SMTP id c9mr3114054wrn.25.1591687951237;
 Tue, 09 Jun 2020 00:32:31 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] hw/misc/grlib_ahb_apb_pnp: Add trace events on read
 accesses
Date: Tue,  9 Jun 2020 09:32:11 +0200
Message-Id: <20200609073214.14079-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20200331105048.27989-5-f4bug@amsat.org>
---
 hw/misc/grlib_ahb_apb_pnp.c | 13 +++++++++++--
 hw/misc/trace-events        |  4 ++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index d22ed00206..43e001c3c7 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "hw/misc/grlib_ahb_apb_pnp.h"
+#include "trace.h"
 
 #define GRLIB_PNP_VENDOR_SHIFT (24)
 #define GRLIB_PNP_VENDOR_SIZE   (8)
@@ -132,8 +133,12 @@ void grlib_ahb_pnp_add_entry(AHBPnp *dev, uint32_t address, uint32_t mask,
 static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsigned size)
 {
     AHBPnp *ahb_pnp = GRLIB_AHB_PNP(opaque);
+    uint32_t val;
 
-    return ahb_pnp->regs[offset >> 2];
+    val = ahb_pnp->regs[offset >> 2];
+    trace_grlib_ahb_pnp_read(offset, val);
+
+    return val;
 }
 
 static void grlib_ahb_pnp_write(void *opaque, hwaddr addr,
@@ -239,8 +244,12 @@ void grlib_apb_pnp_add_entry(APBPnp *dev, uint32_t address, uint32_t mask,
 static uint64_t grlib_apb_pnp_read(void *opaque, hwaddr offset, unsigned size)
 {
     APBPnp *apb_pnp = GRLIB_APB_PNP(opaque);
+    uint32_t val;
 
-    return apb_pnp->regs[offset >> 2];
+    val = apb_pnp->regs[offset >> 2];
+    trace_grlib_apb_pnp_read(offset, val);
+
+    return val;
 }
 
 static void grlib_apb_pnp_write(void *opaque, hwaddr addr,
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0cb4c64ae7..5561746866 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -202,3 +202,7 @@ via1_rtc_cmd_pram_read(int addr, int value) "addr=%u value=0x%02x"
 via1_rtc_cmd_pram_write(int addr, int value) "addr=%u value=0x%02x"
 via1_rtc_cmd_pram_sect_read(int sector, int offset, int addr, int value) "sector=%u offset=%u addr=%d value=0x%02x"
 via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "sector=%u offset=%u addr=%d value=0x%02x"
+
+# grlib_ahb_apb_pnp.c
+grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
+grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
-- 
2.21.3


