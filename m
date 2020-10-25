Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E68AC388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 15:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BB5208A9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 15:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R171lfxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BB5208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWhui-0006LU-Hq
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 11:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWhtc-0005QO-Be; Sun, 25 Oct 2020 11:25:24 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWhta-0003EO-H3; Sun, 25 Oct 2020 11:25:23 -0400
Received: by mail-pl1-x643.google.com with SMTP id j5so3461978plk.7;
 Sun, 25 Oct 2020 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8usNJ4gs+SbIMkP5J8+1/oBPgsQl+2zqQMMZj0DWgbU=;
 b=R171lfxsFspsdZaSti8i45nVNmipT+ag8soBcPSmVmmp/vRfDowsRSJMvzgUs3E01R
 WvSm4YiYeKhE6yyKZ7ITQgyug87p1/gGqsFE6/gofmiAZ6pF9nh+vNT7CC3eWg4OQEiq
 +KGlqa6Dd+QMzAheYJI8EV+j3THbfHy4/tTSSA+9hhtntC9n72xo8bskSqEdr5enYxnT
 B7yrxpslE4fZoGPqN1xptulXXaMpD2NGJxSw+Pr4MMS8KeGViogVX9XymxhGTvGmwg/b
 7f2Shk0BdIvGUmeX497gzYnpbGwKCwLrDYnrfILtM3++6TnHU6rUyt4z3aiX8TbCnido
 h6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8usNJ4gs+SbIMkP5J8+1/oBPgsQl+2zqQMMZj0DWgbU=;
 b=kq2rg2ntErMzqvHc5igKPfRRKjYUT62KcOs1YaFS0KCPtQ+mkKDfIEbr0X2/hssmW3
 8Inp4sVZszP+8jtpCgQAlyHZ5pDQdKp9wD4yWwEEG0dVwll8tMw41uBvsfqZQ1PPx54C
 I8rxL76ha+6CpVHxZNIUSNLMlB/FEc51DOWzjSHi8CIWrvMCKmpHVFU8JP3mUCqt8eQ2
 lPbLLrZ0Cz8EZMz1BOWasSLhBM3zorrHlqvSCjKKHoesc+4ro0SgxDiKA2AZRr7eZkEl
 DpoqHFJeStVFcxaH1VIr2aa78i2gBwfUFdSurq0CROUP8sHXLur72SDLOvvf3h44rw9f
 36xg==
X-Gm-Message-State: AOAM532SAZtXwziA1jaY6f45TlN4RZy7jRfWkkH3gPV0FQkaH9dO6RiN
 Gt7PvVVm3PvXO2E3UBOSLHc=
X-Google-Smtp-Source: ABdhPJxzWCn1L/HZZue5l6YaKZYxwTo9JLSMftxxWPhPMX/0/JfEBB3y1+C6/flYS02NCU8zVDJOLw==
X-Received: by 2002:a17:90a:b8f:: with SMTP id
 15mr15130827pjr.22.1603639520586; 
 Sun, 25 Oct 2020 08:25:20 -0700 (PDT)
Received: from Intel.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id 186sm9021503pff.95.2020.10.25.08.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2020 08:25:19 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/sd: Fix 2 GiB card CSD register values
Date: Sun, 25 Oct 2020 23:23:57 +0800
Message-Id: <20201025152357.11865-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Per the SD spec, to indicate a 2 GiB card, BLOCK_LEN shall be 1024
bytes, hence the READ_BL_LEN field in the CSD register shall be 10
instead of 9.

This fixes the acceptance test error for the NetBSD 9.0 test of the
Orange Pi PC that has an expanded SD card image of 2 GiB size.

Fixes: 6d2d4069c47e ("hw/sd: Correct the maximum size of a Standard Capacity SD Memory Card")
Reported-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/sd/sd.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bd10ec8fc4..732fcb5ff0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -386,10 +386,17 @@ static const uint8_t sd_csd_rw_mask[16] = {
 
 static void sd_set_csd(SDState *sd, uint64_t size)
 {
-    uint32_t csize = (size >> (CMULT_SHIFT + HWBLOCK_SHIFT)) - 1;
+    int hwblock_shift = HWBLOCK_SHIFT;
+    uint32_t csize;
     uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
     uint32_t wpsize = (1 << (WPGROUP_SHIFT + 1)) - 1;
 
+    /* To indicate 2 GiB card, BLOCK_LEN shall be 1024 bytes */
+    if (size == SDSC_MAX_CAPACITY) {
+        hwblock_shift += 1;
+    }
+    csize = (size >> (CMULT_SHIFT + hwblock_shift)) - 1;
+
     if (size <= SDSC_MAX_CAPACITY) { /* Standard Capacity SD */
         sd->csd[0] = 0x00;	/* CSD structure */
         sd->csd[1] = 0x26;	/* Data read access-time-1 */
@@ -397,7 +404,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[3] = 0x32;      /* Max. data transfer rate: 25 MHz */
         sd->csd[4] = 0x5f;	/* Card Command Classes */
         sd->csd[5] = 0x50 |	/* Max. read data block length */
-            HWBLOCK_SHIFT;
+            hwblock_shift;
         sd->csd[6] = 0xe0 |	/* Partial block for read allowed */
             ((csize >> 10) & 0x03);
         sd->csd[7] = 0x00 |	/* Device size */
@@ -411,9 +418,9 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[11] = 0x00 |	/* Write protect group size */
             ((sectsize << 7) & 0x80) | wpsize;
         sd->csd[12] = 0x90 |	/* Write speed factor */
-            (HWBLOCK_SHIFT >> 2);
+            (hwblock_shift >> 2);
         sd->csd[13] = 0x20 |	/* Max. write data block length */
-            ((HWBLOCK_SHIFT << 6) & 0xc0);
+            ((hwblock_shift << 6) & 0xc0);
         sd->csd[14] = 0x00;	/* File format group */
     } else {			/* SDHC */
         size /= 512 * KiB;
-- 
2.25.1


