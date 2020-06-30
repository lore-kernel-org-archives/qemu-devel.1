Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86513C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526AF20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5tK4TLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526AF20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGXW-0007HZ-Iz
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTp-00010m-IN; Tue, 30 Jun 2020 09:39:21 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTo-0006IM-2S; Tue, 30 Jun 2020 09:39:21 -0400
Received: by mail-ed1-x542.google.com with SMTP id d16so9594107edz.12;
 Tue, 30 Jun 2020 06:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i3AX6k9zJcs7ntcPjDjs5EOqKiW+/SX/Gp5bwn7hkCA=;
 b=G5tK4TLjUXy/6OdiMLeBcI82VCrGi2aWIt4P7LB6EG6ihgTle21nQr58Q/nNBJ3Ehg
 X4z0Aq5mDo0d6VC5pMxCZLYFpZxfG4XCBPoNdhUxuOS2iCsbRb+jI3Pz4Mr+VKhlC3BD
 69fvSKB7OR6hUANJ1pRQJxSJg3BlmV/JxRVMtPceeTWxSBDgRNvE/PXCdzLGERi/US/5
 EuFVcOR/BazQvOWm+pUsUS+TX1eRhZuyTZpvp4Pv+wi2ABj6CizK1x+bsDwAO0N7JYY5
 Fxl3DKKvsehrxyG7puZ2bNRqSu4SQQKIqZGAnWIXgBay8Y/k1xsuuyX5uZDf98t8NksW
 OuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=i3AX6k9zJcs7ntcPjDjs5EOqKiW+/SX/Gp5bwn7hkCA=;
 b=CdMtmWqTZDOfFXXXLusaszDsb1Jip8Ddn8Tpgz4J25BZJaBO3KD5WvIJ/u0hCKmEdK
 TBpX6s4Hezkuo3wAJGBDhjflyg0s7Xy1vj9QCDA967l+AmAOQ3kD9KfIZj734/XAGqtZ
 ktP0anK5YLPeNSm4pBbPyc9IAL+LJbz86S/01/GuxjkiKy+9Ptze6c9Gs3oDvkaOC9ni
 mf5JdunsEN3/V+iuyHusU1HHq4nRDfbhMrA9RDY27jc4ViR4ERngOtbiQT5RcPawofBF
 4jDu4tYRk8qGkrolc+Q3rujQ4NKydZ7AIlD80WE9FaAtKlEaItgrMIpZbdQ1+3NvfIkY
 TV9w==
X-Gm-Message-State: AOAM531Osg7ThY5Q2UZ7W+NSCnMdO+ObGkGRix6chDCTGyWoEQfdGKUx
 2ebMOWOCz+5YoSTXsZM9IgOW0zY+ycs=
X-Google-Smtp-Source: ABdhPJzXNdpvEdMno8aAobnvdP0TBwsu6gwsmsxv+lwBNlmn2aKa3AwrUTBmKBGh71YQvprD7PnHkQ==
X-Received: by 2002:a50:cd1a:: with SMTP id z26mr23903371edi.120.1593524358353; 
 Tue, 30 Jun 2020 06:39:18 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/17] hw/sd/sdcard: Use the HWBLOCK_SIZE definition
Date: Tue, 30 Jun 2020 15:38:58 +0200
Message-Id: <20200630133912.9428-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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


