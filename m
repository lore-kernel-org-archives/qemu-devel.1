Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1136C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B869D2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEKL2LMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B869D2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDFX-0001xD-Vg
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7I-0002P3-2L; Tue, 30 Jun 2020 06:03:52 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7G-0004cn-D8; Tue, 30 Jun 2020 06:03:51 -0400
Received: by mail-ej1-x643.google.com with SMTP id i14so19906888ejr.9;
 Tue, 30 Jun 2020 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i3AX6k9zJcs7ntcPjDjs5EOqKiW+/SX/Gp5bwn7hkCA=;
 b=IEKL2LMZH0/frLWh99/3r5wwdykr2VKNm1Wa0MgHcETnX10XHnjCRRenK2whSolssw
 9/LsfjZ99vJYdJ4j2n/JjD0PXoahwoljYFP0Ot9FnZVpdqIO1WkkJSZ8utwxe5hfdY1b
 jbPRxAjthFs/itv5YuyOc+by8mtqvOHhQ434+h8YduQ5wFHzFHml45cPH7DAYN4j02FS
 uNRZSmWqlB25KkLuwnXOSJv3VPnI22WV+Z0g++Ma6wOA6UJCQgNx/F5QajoNu4WmUySU
 zJh8XAOXdkCLFd22y0YL6Ce/aVbT/Heyi//Ro2BTKq6PiUM2BpoxJ+S6SRNrEKzr5b+Z
 A07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=i3AX6k9zJcs7ntcPjDjs5EOqKiW+/SX/Gp5bwn7hkCA=;
 b=ZKl+IE1gVWLShQ2v/fg5WCElI378Ia7DYgtVQ39XqeKt4EamsQvk5VI9EaWGnLyLLt
 E0bZa9TXKy6lgNnNQkpcCqYFDr9Ht/vI036LcgoQdIaqX6hBbqCj8Dol5ejDBfGJAbjM
 d4V647FM74yQ/p4PRB62/uNKEDQUbcq17WIQNzzkybPEeAKJ76nH+W2lIuaILN7tPdHX
 ES0A9lqycBTtSPPBmL6gvW9Z0ctxGjqEZqLWSE5QYjjNsGQPbvNBwZ2ph1dy9kuK8uYk
 x7xvrZzI6QpWv2vX6hXqLNdGpYKPJWKFEH0zuYBx4sl5DXLs20hl4YegC/lt+O8OVEGq
 xclQ==
X-Gm-Message-State: AOAM533gEfHU43qX4Eo0wRLQxG9Na/ukhJR2lewGMBoIM90A2i34Jrce
 RI0Wp8MZ6hRQO7ZNwikDPPQyvse6Yc4=
X-Google-Smtp-Source: ABdhPJzHnfqUeAgd+c1AOgg8ja274FnZFBqR0ujPY7o0XxBRBrtq/1+c+OFyVIzaknIIbLth/3w4cw==
X-Received: by 2002:a17:907:a92:: with SMTP id
 by18mr18590748ejc.116.1593511428544; 
 Tue, 30 Jun 2020 03:03:48 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:03:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/15] hw/sd/sdcard: Use the HWBLOCK_SIZE definition
Date: Tue, 30 Jun 2020 12:03:31 +0200
Message-Id: <20200630100342.27625-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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


