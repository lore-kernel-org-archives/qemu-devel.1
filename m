Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182CBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6217207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3K2Q4y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6217207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorSo-0007Bn-VJ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP2-0000Bl-Uz; Fri, 26 Jun 2020 12:40:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP1-00063e-EE; Fri, 26 Jun 2020 12:40:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id f18so2051099wrs.0;
 Fri, 26 Jun 2020 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i3AX6k9zJcs7ntcPjDjs5EOqKiW+/SX/Gp5bwn7hkCA=;
 b=W3K2Q4y2qDU44ulfxHCRH0KyRak+lLK3bC38voxVslIUvmvNupChJmUHrLFVbjjCXY
 CyCP4ENRXOR7Lj+R0yzizDXSpreQpoeJsaO1IeNgRVa9R0tZA9Rxzxs0P6QyF0a4aIli
 Uq05UUswjyCRWXDWW7knMqHo+OjmtIqhIE6Jh4RCDiDPCW1emis16uwT3ArX3iEiU+d9
 OzalJGIZZoW109vYdJf5Z5biOxaj8w5Zr6+V1mcEINg2raAAgORHGynzjeinsbSWNVLG
 AvgzACT6xsvJ+xSvBa6pPJFdBY+jJMsaGIk9kCcCK/nLDRfjAEzXXHcksQUGPkwsDB2R
 FvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=i3AX6k9zJcs7ntcPjDjs5EOqKiW+/SX/Gp5bwn7hkCA=;
 b=kPlL9hTUe8L1A/x2dvZ8k4h4INCYKm6E8PGFDNTYV3nTJ4rhRRMaHAP7KMtfWcuVrL
 rM4PGDjQ0a5Fzn6B5OHnk0dgsEahrl1+kfRcObHCk/vjnZ5jRcuAxIRK7diIAwGFi1MM
 JenW3zUeQe6lzTa3jfzsdDSU11r+xj9xfXsuVbD4yvnv5UmzZAtpwSO9d3oRUgF567lH
 g52mUS3Edqf2p7Uq4y0GTa6e4XkEhOEVGdp5AB99K5i6bwIfTaIMN+Ya7TXrMWPOnGH6
 SIWybwmsywpmIOGuiMv6SF/4oIy8Lebif4cKZQJWvyOqlHgzTG1sKkHyoafUwe8PoTo5
 cToQ==
X-Gm-Message-State: AOAM530f9niVmyY5q9dR+7WbEmxa89E/tyEw9PRPiqAYwa6bGJ/bRrTT
 wGEIDcbCnXUFkSZ51DGn+k6byIzI
X-Google-Smtp-Source: ABdhPJzQetAz7tlH5J19bKZzCLEcB5GO2eV0SpayrGEeY4037Ye0Vx4fR+n/9WVMQWeekJBkenKfpA==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr4546743wrm.31.1593189633565; 
 Fri, 26 Jun 2020 09:40:33 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 04/15] hw/sd/sdcard: Use the HWBLOCK_SIZE definition
Date: Fri, 26 Jun 2020 18:40:15 +0200
Message-Id: <20200626164026.766-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the following different uses of the same value by
the same HWBLOCK_SIZE definition:
  - 512 (magic value)
  - 0x200 (magic value)
  - 1 << HWBLOCK_SHIFT

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4816b4a462..04451fdad2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -81,6 +81,7 @@ enum SDCardStates {
 };
 
 #define HWBLOCK_SHIFT   9                       /* 512 bytes */
+#define HWBLOCK_SIZE    (1 << HWBLOCK_SHIFT)
 #define SECTOR_SHIFT    5                       /* 16 kilobytes */
 #define WPGROUP_SHIFT   7                       /* 2 megs */
 #define CMULT_SHIFT     9                       /* 512 times HWBLOCK_SIZE */
@@ -129,7 +130,7 @@ struct SDState {
     uint32_t blk_written;
     uint64_t data_start;
     uint32_t data_offset;
-    uint8_t data[512];
+    uint8_t data[HWBLOCK_SIZE];
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
@@ -410,7 +411,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
             ((HWBLOCK_SHIFT << 6) & 0xc0);
         sd->csd[14] = 0x00;	/* File format group */
     } else {			/* SDHC */
-        size /= 512 * KiB;
+        size /= HWBLOCK_SIZE * KiB;
         size -= 1;
         sd->csd[0] = 0x40;
         sd->csd[1] = 0x0e;
@@ -574,7 +575,7 @@ static void sd_reset(DeviceState *dev)
     sd->erase_start = 0;
     sd->erase_end = 0;
     sd->size = size;
-    sd->blk_len = 0x200;
+    sd->blk_len = HWBLOCK_SIZE;
     sd->pwd_len = 0;
     sd->expecting_acmd = false;
     sd->dat_lines = 0xf;
@@ -685,7 +686,7 @@ static const VMStateDescription sd_vmstate = {
         VMSTATE_UINT32(blk_written, SDState),
         VMSTATE_UINT64(data_start, SDState),
         VMSTATE_UINT32(data_offset, SDState),
-        VMSTATE_UINT8_ARRAY(data, SDState, 512),
+        VMSTATE_UINT8_ARRAY(data, SDState, HWBLOCK_SIZE),
         VMSTATE_UNUSED_V(1, 512),
         VMSTATE_BOOL(enable, SDState),
         VMSTATE_END_OF_LIST()
@@ -754,8 +755,8 @@ static void sd_erase(SDState *sd)
 
     if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
         /* High capacity memory card: erase units are 512 byte blocks */
-        erase_start *= 512;
-        erase_end *= 512;
+        erase_start *= HWBLOCK_SIZE;
+        erase_end *= HWBLOCK_SIZE;
     }
 
     erase_start = sd_addr_to_wpnum(erase_start);
@@ -1149,7 +1150,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 16:	/* CMD16:  SET_BLOCKLEN */
         switch (sd->state) {
         case sd_transfer_state:
-            if (req.arg > (1 << HWBLOCK_SHIFT)) {
+            if (req.arg > HWBLOCK_SIZE) {
                 sd->card_status |= BLOCK_LEN_ERROR;
             } else {
                 trace_sdcard_set_blocklen(req.arg);
@@ -1961,7 +1962,7 @@ uint8_t sd_read_data(SDState *sd)
     if (sd->card_status & (ADDRESS_ERROR | WP_VIOLATION))
         return 0x00;
 
-    io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
+    io_len = (sd->ocr & (1 << 30)) ? HWBLOCK_SIZE : sd->blk_len;
 
     trace_sdcard_read_data(sd->proto_name,
                            sd_acmd_name(sd->current_cmd),
-- 
2.21.3


