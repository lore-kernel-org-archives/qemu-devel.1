Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF9C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC452077D
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOU6DMG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC452077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcoSl-0008UI-DE
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 07:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNw-0002jc-OC; Sun, 24 May 2020 07:01:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNl-0007mA-G6; Sun, 24 May 2020 07:01:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id x14so9215268wrp.2;
 Sun, 24 May 2020 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u3oadF3lY7kJ7u32IbFBnTyzgbMxnriKTUoHa0TNDIA=;
 b=UOU6DMG41oHQWHARCytBY0Wt3GE8Vi7cWKQZKArDq5OcCsbUzI+WhCZH4nZ7Xw6kvW
 ziwKs/sinqurMKNqQKSZckw7mXls2PO981JPvSpukwGtMWcGbzO/iFja/xrdlcG1YH3u
 73bOugj6kqkcR0jD4KmwVqYW447/okPCbvIqSqNhOpFb8/sOMncfxpj+e6FH3CjU1fAE
 nasy6bJGLJkyl8nCqpFJ3F4b2Tf3H6xyTbDZAQWVXsPEiRfOhzP/syY2tQ+o4zTzD0KR
 DZ70aSCB3G9xWoSV6S/wIZMjwDBk4CoY4/onPrBGb4Q2qz5+mxzg24FA0fpr2k0uEs7B
 673w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=u3oadF3lY7kJ7u32IbFBnTyzgbMxnriKTUoHa0TNDIA=;
 b=BwCPhJ3YaxHUCU/gldEgQZfQyVkuPl0q5EEsRzaE2hYnJJMSfS2QGAqAnkvoDLg/wB
 2Z0eumUOHJ6GbATUq+yawLiaGcpcaqnjAIbcAEEaR0B7Ggbl+B8WcupNNc5D4MMsdZMt
 OPy6djFFG3FeuynYqmQIIaN/pa9uAaEyKoBKVKfV9iJCfjJgkV6jpKcj+rPRvf/iY9w4
 xqR50B6HnWZLFY0xizzjiCXE0LS8xnjiV8JShvi51YIEtDC9haE2+ktRGYsKIdLiMsHj
 3+XTonAV2eXurO/ApiW5a2NcoQeyWZopnSulQ4YQxe5+D0IhbvPOReQzcrIJ454XE1et
 UZIg==
X-Gm-Message-State: AOAM530pOIIUjZmqs1a5o5ylgzrRh/Y/YMhtslrAOUDsjMJ6o7zutvmF
 xo/LgFGiCoAkw5N5rE/yAY8dloue9vY=
X-Google-Smtp-Source: ABdhPJxSzQh29EBITshxn1SvD52UlZ54NpYK1JhTfqdeb+FMMNYekzZG1XWLheb4lFToz8JA1rpDCQ==
X-Received: by 2002:adf:f205:: with SMTP id p5mr11531576wro.302.1590318087424; 
 Sun, 24 May 2020 04:01:27 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r3sm14321555wmh.48.2020.05.24.04.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 04:01:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/display/cirrus_vga: Use qemu_log_mask(ERROR) instead
 of debug printf
Date: Sun, 24 May 2020 13:01:20 +0200
Message-Id: <20200524110121.12686-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200524110121.12686-1-f4bug@amsat.org>
References: <20200524110121.12686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

Replace some debug printf() calls by qemu_log_mask(LOG_GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/cirrus_vga.c | 77 ++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index f9f837b850..76e2dc5bb6 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -978,9 +978,8 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
 	s->cirrus_blt_pixelwidth = 4;
 	break;
     default:
-#ifdef DEBUG_BITBLT
-	printf("cirrus: bitblt - pixel width is unknown\n");
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: bitblt - pixel width is unknown\n");
 	goto bitblt_ignore;
     }
     s->cirrus_blt_mode &= ~CIRRUS_BLTMODE_PIXELWIDTHMASK;
@@ -1037,7 +1036,9 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
         } else {
 	    if (s->cirrus_blt_mode & CIRRUS_BLTMODE_TRANSPARENTCOMP) {
 		if (s->cirrus_blt_pixelwidth > 2) {
-		    printf("src transparent without colorexpand must be 8bpp or 16bpp\n");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "cirrus: src transparent without colorexpand "
+                          "must be 8bpp or 16bpp\n");
 		    goto bitblt_ignore;
 		}
 		if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
@@ -1135,10 +1136,9 @@ static uint32_t cirrus_get_bpp16_depth(CirrusVGAState * s)
 	ret = 16;
 	break;			/* XGA HiColor */
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: invalid DAC value %x in 16bpp\n",
-	       (s->cirrus_hidden_dac_data & 0xf));
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: invalid DAC value 0x%x in 16bpp\n",
+                      (s->cirrus_hidden_dac_data & 0xf));
 	ret = 15;		/* XXX */
 	break;
     }
@@ -1307,11 +1307,9 @@ static int cirrus_vga_read_sr(CirrusVGAState * s)
 #endif
 	return s->vga.sr[s->vga.sr_index];
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: inport sr_index %02x\n", s->vga.sr_index);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: inport sr_index 0x%02x\n", s->vga.sr_index);
 	return 0xff;
-	break;
     }
 }
 
@@ -1400,10 +1398,9 @@ static void cirrus_vga_write_sr(CirrusVGAState * s, uint32_t val)
         cirrus_update_memory_access(s);
         break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: outport sr_index %02x, sr_value %02x\n",
-               s->vga.sr_index, val);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: outport sr_index 0x%02x, sr_value 0x%02x\n",
+                      s->vga.sr_index, val);
 	break;
     }
 }
@@ -1501,9 +1498,8 @@ static int cirrus_vga_read_gr(CirrusVGAState * s, unsigned reg_index)
     if (reg_index < 0x3a) {
 	return s->vga.gr[reg_index];
     } else {
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: inport gr_index %02x\n", reg_index);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: inport gr_index 0x%02x\n", reg_index);
 	return 0xff;
     }
 }
@@ -1590,10 +1586,9 @@ cirrus_vga_write_gr(CirrusVGAState * s, unsigned reg_index, int reg_value)
 	cirrus_write_bitblt(s, reg_value);
 	break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: outport gr_index %02x, gr_value %02x\n", reg_index,
-	       reg_value);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: outport gr_index 0x%02x, gr_value 0x%02x\n",
+                      reg_index, reg_value);
 	break;
     }
 }
@@ -1648,9 +1643,8 @@ static int cirrus_vga_read_cr(CirrusVGAState * s, unsigned reg_index)
 	return s->vga.ar_index & 0x3f;
 	break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: inport cr_index %02x\n", reg_index);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: inport cr_index 0x%02x\n", reg_index);
 	return 0xff;
     }
 }
@@ -1721,10 +1715,9 @@ static void cirrus_vga_write_cr(CirrusVGAState * s, int reg_value)
 	break;
     case 0x25:			// Part Status
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: outport cr_index %02x, cr_value %02x\n",
-               s->vga.cr_index, reg_value);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: outport cr_index 0x%02x, cr_value 0x%02x\n",
+                      s->vga.cr_index, reg_value);
 	break;
     }
 }
@@ -1834,9 +1827,8 @@ static uint8_t cirrus_mmio_blt_read(CirrusVGAState * s, unsigned address)
 	value = cirrus_vga_read_gr(s, 0x31);
 	break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: mmio read - address 0x%04x\n", address);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: mmio read - address 0x%04x\n", address);
 	break;
     }
 
@@ -1946,10 +1938,9 @@ static void cirrus_mmio_blt_write(CirrusVGAState * s, unsigned address,
 	cirrus_vga_write_gr(s, 0x31, value);
 	break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: mmio write - addr 0x%04x val 0x%02x (ignored)\n",
-	       address, value);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: mmio write - addr 0x%04x val 0x%02x (ignored)\n",
+                      address, value);
 	break;
     }
 }
@@ -2047,9 +2038,8 @@ static uint64_t cirrus_vga_mem_read(void *opaque,
 	}
     } else {
 	val = 0xff;
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: mem_readb " TARGET_FMT_plx "\n", addr);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: mem_readb 0x" TARGET_FMT_plx "\n", addr);
     }
     return val;
 }
@@ -2112,10 +2102,9 @@ static void cirrus_vga_mem_write(void *opaque,
 	    cirrus_mmio_blt_write(s, addr & 0xff, mem_value);
 	}
     } else {
-#ifdef DEBUG_CIRRUS
-        printf("cirrus: mem_writeb " TARGET_FMT_plx " value 0x%02" PRIu64 "\n", addr,
-               mem_value);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: mem_writeb 0x" TARGET_FMT_plx " "
+                      "value 0x%02" PRIu64 "\n", addr, mem_value);
     }
 }
 
-- 
2.21.3


