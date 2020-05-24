Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F3C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C462077D
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkO6Ujx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C462077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcoRO-00061B-Dn
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 07:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNo-0002iN-5F; Sun, 24 May 2020 07:01:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNn-0007mL-3W; Sun, 24 May 2020 07:01:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so7148339wmj.0;
 Sun, 24 May 2020 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=plkhAnUXiFwBad9mwWbwN/wJIwOw8aPJV1mi75fwVbY=;
 b=EkO6Ujx9gljaDSm7NHH7ni6gMS8Bf6TS7kABBNCViXaDkDjC5k0xBvD5VZ9oBfiW4m
 995FWyd1Oo6Nlt6yxObOBDGGV7dgeVPwGKDOrikps8PKCasL2A+70MAwBeKmMRGfI61W
 8auVSDWH7dOzFf8h+UMg0kA82y4DaPD3Dj6jkb/IJ0dN2IqlibtWbxU3SjDOZWZI1cOE
 9tFw84B+XyPAnsDPwwCORAk4huXYHT2TowW63iloTgNLFJy4qcAGcMrCcTEz4FVZgmS+
 g/2I0FFt2NExh/IlIBhPgMycxhygWpl5jnWuoXSjR+5U2iLZyEHPn3ZaBnEEanUp9JCZ
 fhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=plkhAnUXiFwBad9mwWbwN/wJIwOw8aPJV1mi75fwVbY=;
 b=Gry//7WiD4G8Wj+S+ENkcVU1kb2FnKYpWtG3e/T5Mlvk7BkDK4MVNx1adon1N/UrHS
 xKNajbJR+WWHUTg4A/IzO4GqH85/zEYORcmo/Q6He2NwW42bn1G2LrSTsvL3F8p4SbnD
 SDJYetQ644LuptQ94iTUmD5XjunlK8DE2Xg7c2kHiDAL1B3tDlrJZABRIA/2GcAP4uRY
 rK9+n+E5dLvE7e65RGoZqO1qn2n4RPQ6AfQkP5XTLe6HYKWICm+086HJPfY1l83aFHDz
 KI3k6q55+h1WXxsTCBI05qtMPOHZ9wDZJTcKNwgXYYHowgZ6naL7PHa4XzNB8BJIODlY
 mCjQ==
X-Gm-Message-State: AOAM531vCJcun0uMTHcDQNgwZK2360Y1UmAR//hV4GKLmgfswioWM726
 CzlFZ1WvI8JOkctd7SsYQJtOuK87eV8=
X-Google-Smtp-Source: ABdhPJwCR5o9Vbm4g2PadiG0M/QH2XWp9grEDf37ANt2ptSGdRhiKK+HdpbFPPAT4ethddQJIyZ11A==
X-Received: by 2002:a05:600c:2146:: with SMTP id
 v6mr21602864wml.142.1590318088845; 
 Sun, 24 May 2020 04:01:28 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r3sm14321555wmh.48.2020.05.24.04.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 04:01:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/display/cirrus_vga: Convert debug printf() to trace
 event
Date: Sun, 24 May 2020 13:01:21 +0200
Message-Id: <20200524110121.12686-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200524110121.12686-1-f4bug@amsat.org>
References: <20200524110121.12686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

Convert the final bit of DEBUG_BITBLT to a tracepoint.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/cirrus_vga.c | 24 ++++++++++--------------
 hw/display/trace-events |  1 +
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 76e2dc5bb6..92c197cdde 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -53,7 +53,6 @@
  */
 
 //#define DEBUG_CIRRUS
-//#define DEBUG_BITBLT
 
 /***************************************
  *
@@ -950,19 +949,16 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
     s->cirrus_blt_dstaddr &= s->cirrus_addr_mask;
     s->cirrus_blt_srcaddr &= s->cirrus_addr_mask;
 
-#ifdef DEBUG_BITBLT
-    printf("rop=0x%02x mode=0x%02x modeext=0x%02x w=%d h=%d dpitch=%d spitch=%d daddr=0x%08x saddr=0x%08x writemask=0x%02x\n",
-           blt_rop,
-           s->cirrus_blt_mode,
-           s->cirrus_blt_modeext,
-           s->cirrus_blt_width,
-           s->cirrus_blt_height,
-           s->cirrus_blt_dstpitch,
-           s->cirrus_blt_srcpitch,
-           s->cirrus_blt_dstaddr,
-           s->cirrus_blt_srcaddr,
-           s->vga.gr[0x2f]);
-#endif
+    trace_vga_cirrus_bitblt_start(blt_rop,
+                                  s->cirrus_blt_mode,
+                                  s->cirrus_blt_modeext,
+                                  s->cirrus_blt_width,
+                                  s->cirrus_blt_height,
+                                  s->cirrus_blt_dstpitch,
+                                  s->cirrus_blt_srcpitch,
+                                  s->cirrus_blt_dstaddr,
+                                  s->cirrus_blt_srcaddr,
+                                  s->vga.gr[0x2f]);
 
     switch (s->cirrus_blt_mode & CIRRUS_BLTMODE_PIXELWIDTHMASK) {
     case CIRRUS_BLTMODE_PIXELWIDTH8:
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 96bbf600f4..6bfc53973f 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -134,6 +134,7 @@ vga_cirrus_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_cirrus_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
 vga_cirrus_write_blt(uint32_t offset, uint32_t val) "offset 0x%x, val 0x%x"
 vga_cirrus_write_gr(uint8_t index, uint8_t val) "GR addr 0x%02x, val 0x%02x"
+vga_cirrus_bitblt_start(uint8_t blt_rop, uint8_t blt_mode, uint8_t blt_modeext, int blt_width, int blt_height, int blt_dstpitch, int blt_srcpitch, uint32_t blt_dstaddr, uint32_t blt_srcaddr, uint8_t gr_val) "rop=0x%02x mode=0x%02x modeext=0x%02x w=%d h=%d dpitch=%d spitch=%d daddr=0x%08"PRIx32" saddr=0x%08"PRIx32" writemask=0x%02x"
 
 # sii9022.c
 sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
-- 
2.21.3


