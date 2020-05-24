Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9546DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F30C2075F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1epSgOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F30C2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcoQq-0005bq-Gg
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 07:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNk-0002c6-DW; Sun, 24 May 2020 07:01:28 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNj-0007ld-9g; Sun, 24 May 2020 07:01:28 -0400
Received: by mail-wr1-x432.google.com with SMTP id i15so14536709wrx.10;
 Sun, 24 May 2020 04:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=41axihzEJ26JKyauJA6bDsNNxel2fB4u/PG7RrCHrg0=;
 b=A1epSgOjROfCuZPKT7yBSYOhtPMsBVi/IEKwX2m4/dMlBeBwRCLeopp7AkNDYM+wul
 uzIZqK2YaevS0HIHt/YTy5OJ5W+NrxemAI7e2/GUCsi5BCdnamQcYcz3bSsd5/0F7nb2
 NmLKCtxueJ8vQ2b3I0O+EcDARNkM9Ztz5xdpUKUNMy1wWEfyHcX8qPpNSaa5eFqP8c3E
 0FR+5h5oEelGNnxbvDTlese9BePsPmz1C3CIUabBQja6xA/NGybWhcYAQdb2yY0KywK5
 FYcwpWhUI4zcLjhIwv6u++6ieCmH+LfpOTJY4DqicuWeHzgqjB1PLhR/0SI65ageehR8
 kfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=41axihzEJ26JKyauJA6bDsNNxel2fB4u/PG7RrCHrg0=;
 b=j7pWCC8kCvomZUbJ1o+NV3EhH/CQqUyrVvuNTZE4EJxWYhhpvb/HoJpa46qXxq7/Te
 9mHzHOmGUmONjc4n1K+vIS+JygjZ7A2x44wCQh2iSfDZeBzqtlc70OJqOasUMZpMAQXu
 wNOrcOb1S5jEXQ3lWp4k2n/4hCHcOHXiQbZLO8Z0tQcpn+CzWgCHvAN4obHB1qFEmj5d
 4VKsQqxu+r+5t2U5yMfeIi/8B4wx9qplrHYf0GB4AexP3zCPO1P60w/FBD9bgcnWTMil
 GpGhKNBOzGfV76WYb7dPR0BzrFHXFZC4IyvNO9k/qGZemhs8ShweQ1wwdB1EoX3soQQb
 IbKw==
X-Gm-Message-State: AOAM532AsurFEbygPdcX5YrOGdVbq461WevmM7kjojtzolpOfFIXrdR8
 j4UIUWWOcZeB7L1ksIDK//sD2iyw8K4=
X-Google-Smtp-Source: ABdhPJw2xirs+a7lIXpjqrL6gHHqq5BciENNLT/rP347qWk892U+r7G97bidStYJsEf3DbcUW7QMNg==
X-Received: by 2002:adf:a51a:: with SMTP id i26mr10198021wrb.332.1590318084800; 
 Sun, 24 May 2020 04:01:24 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r3sm14321555wmh.48.2020.05.24.04.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 04:01:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/display/cirrus_vga: Convert debug printf() to trace
 event
Date: Sun, 24 May 2020 13:01:18 +0200
Message-Id: <20200524110121.12686-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200524110121.12686-1-f4bug@amsat.org>
References: <20200524110121.12686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
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
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/cirrus_vga.c | 4 +---
 hw/display/trace-events | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 1f29731ffe..33ccdde000 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -1512,9 +1512,7 @@ static int cirrus_vga_read_gr(CirrusVGAState * s, unsigned reg_index)
 static void
 cirrus_vga_write_gr(CirrusVGAState * s, unsigned reg_index, int reg_value)
 {
-#if defined(DEBUG_BITBLT) && 0
-    printf("gr%02x: %02x\n", reg_index, reg_value);
-#endif
+    trace_vga_cirrus_write_gr(reg_index, reg_value);
     switch (reg_index) {
     case 0x00:			// Standard VGA, BGCOLOR 0x000000ff
 	s->vga.gr[reg_index] = reg_value & gr_mask[reg_index];
diff --git a/hw/display/trace-events b/hw/display/trace-events
index e6e22bef88..96bbf600f4 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -133,6 +133,7 @@ vga_vbe_write(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
 vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_cirrus_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
+vga_cirrus_write_gr(uint8_t index, uint8_t val) "GR addr 0x%02x, val 0x%02x"
 
 # sii9022.c
 sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
-- 
2.21.3


