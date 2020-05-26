Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469F1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E90C20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/BzUBI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E90C20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdT30-0004st-7z
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzP-0006ZI-0n; Tue, 26 May 2020 02:23:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzN-0002T7-Od; Tue, 26 May 2020 02:23:02 -0400
Received: by mail-wr1-x429.google.com with SMTP id e1so19198930wrt.5;
 Mon, 25 May 2020 23:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wkKhAaWq4292dGYRwNihmCpk892PHTGHkeHdvgsEOXc=;
 b=Y/BzUBI0pXPrfpQ4pNuHxejxnQ7W/pmfMbFp3Or+UqGU1NiT1ue8DEKAw0F5CUB73Y
 kInIXshIjcUmisrVkUgVd83NFPCCZjp7O+xQV+gIY3RoMb7moRfMMvYNr/XOjU9rF7Ge
 lD76UB3ERWNZX+ajImYvaCdlpE5xifsLChiuQ+eynWdcU/mAIEIxH16UL2iF26HyRE9M
 Rjj489hXXZnLKKOOPAMQPTV9tthR20JdFaEqmmvGVXGGDISBQLr2xb4bp24Q4v06cqgk
 od5SgCbtKHY2Sup4/AyUynfO8fPSaCwJKuWgd4A4u+qYSwam2VLzkx9s9AMyXXG9ORsy
 ovzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wkKhAaWq4292dGYRwNihmCpk892PHTGHkeHdvgsEOXc=;
 b=C+IwM5z2qISmNGaUopwYsNWTbFBPScuXD1h8p79muYGhsE3pgPyLiBe7xJmdQczhe4
 e92jD8Pc/T76IQgyxjdO2duqVlhwm89j5ZAquOieTPFJH5uRTYXcJeQe6ZZcM7TLaULP
 YjIWhYoZZoAuNp2rlI8uNBR6T+OyShi+bCTyFyOeUjvsJRg1RIDYILg59adRu1o+1RVb
 rSGJEbC0fCGC1X7LcwjlT1pHxCmvkROM71muPXtBDTYyNgPzMUfkTnUWs5dskgvpSsQT
 mSWikPMYUKxW8o0j/CoHo5hDUIcREhb40iQOA4CV+ElbwvMnEm0D8c1I7XHBVGgP7N9d
 3+NA==
X-Gm-Message-State: AOAM5321mgTMg3hbLVnXOQCR+DiuCpFRra1KwA9+qhciAoufZzdpqUvF
 vHJlWObR4vdELT1XbSET5rk=
X-Google-Smtp-Source: ABdhPJz94s+hSVEICWkSGsXRmGxXwfSRDfRZ7o32VS6WTEXjll5OSMvXyuXAQDUlrqQRWRvUFYyM9Q==
X-Received: by 2002:adf:a399:: with SMTP id l25mr17972154wrb.212.1590474179702; 
 Mon, 25 May 2020 23:22:59 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:22:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 03/14] hw/display/cirrus_vga: Convert debug printf() to trace
 event
Date: Tue, 26 May 2020 08:22:41 +0200
Message-Id: <20200526062252.19852-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
References: <20200526062252.19852-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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
index 47b2b168ae..c3043e4ced 100644
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


