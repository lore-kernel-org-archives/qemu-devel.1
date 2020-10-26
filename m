Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD044C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D29D207F7
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/UxKwqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D29D207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXBzm-0008Su-DF
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 19:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBw0-00036a-1R
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:29:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:41657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXBvy-0000GQ-8g
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 19:29:51 -0400
Received: by mail-ed1-x52b.google.com with SMTP id l24so11566699edj.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 16:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2kYJylSUVap5cHs18MspyX6fw/+yTmDa3KK/zRKs/IU=;
 b=I/UxKwqjsp0MGWHZl4jbkzpoKAd0QGPrQ9/bMFCKa7ieiSocyeOO4aMnkEJfAWUeHV
 5rKyNz9mrOBpkVnZSGEiPPBSYuLGh/mny4MyoON9boj64sZJLLUYSi1HWqLuBYHFqRkk
 spzXqU4TdFKIMOlDmbsZNIEvBfoS4O4X/19RLfrK+UXITNpFWe5Ox/kl3ZhEdsFgyCT/
 1hjdRlwylUj2wvnVEs8VInKVPE+qgeAYxkKBK0gx2U+W0yU0lfuWfNNB8o8JjLfH9Sp/
 PGovMBtdiuZeTicJL5HsEsTmLz5GeLg+VAlKBgzW1QQJD5FCJ5+3EASWMFX0a7RyMT9V
 J+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2kYJylSUVap5cHs18MspyX6fw/+yTmDa3KK/zRKs/IU=;
 b=GLbAneYkNuDsBaafpqSAH4i7l60jNPg+h9Zux0Eti58g4YjMF6MvK9j69Px0fu2Z1D
 IGG9lNRVJ7RkDSIzuHPZkvImREtmgqlVsf+9o+lJN+cb+LNHArA4yWLRNcq7HQHVjg8w
 My6voFWqSVO//KS0U2feSMn0OlPQV1lEcs0n361JLGuH7wOzH9O3dhkSeCO7XpiQ41FW
 V99QHfRhMKjESZ+X98rwOIF9EQIcGDt0Lgklqam8zRdIxZ9KHczaJrbRPdkPsTT6iOoE
 xfrxp47KUXXsEoMz4Z248qdS/meUdBO1rU8N/07v+mDqeSlgVK/9LDTSQ9j2veCjVUz6
 A41Q==
X-Gm-Message-State: AOAM531PFCqlq2JiegkVD02qRUw62UAYC8mEoEKkGOYYZ0PrUiIHvJ2d
 nlDb5SFOjAjRJKDSYBM85aQKYv54Qq0=
X-Google-Smtp-Source: ABdhPJzli51YBxDrqx15oaQecjYaYeSkNVUgAQQsq5dCTGuDIYGa+JnK4pg046VKatbeFCb6W0eWDA==
X-Received: by 2002:a50:e705:: with SMTP id a5mr13373894edn.29.1603754988641; 
 Mon, 26 Oct 2020 16:29:48 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id ck19sm6596062ejb.99.2020.10.26.16.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 16:29:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] hw/timer/sh_timer: Coding style clean-up
Date: Tue, 27 Oct 2020 00:29:29 +0100
Message-Id: <20201026232935.92777-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026232935.92777-1-f4bug@amsat.org>
References: <20201026232935.92777-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Replace TAB characters with spaces, put code after case-statement on
separate lines and add some curly braces in related lines to keep
checkpatch.pl happy.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20201020153935.54315-2-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/sh_timer.c | 89 +++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 32 deletions(-)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index bb0e1c8ee53..b09e30f9388 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -117,35 +117,55 @@ static void sh_timer_write(void *opaque, hwaddr offset,
         case 2: freq >>= 6; break;
         case 3: freq >>= 8; break;
         case 4: freq >>= 10; break;
-	case 6:
-	case 7: if (s->feat & TIMER_FEAT_EXTCLK) break;
-	default: hw_error("sh_timer_write: Reserved TPSC value\n"); break;
+        case 6:
+        case 7:
+            if (s->feat & TIMER_FEAT_EXTCLK) {
+                break;
+            }
+        default:
+            hw_error("sh_timer_write: Reserved TPSC value\n");
+            break;
         }
         switch ((value & TIMER_TCR_CKEG) >> 3) {
-	case 0: break;
+        case 0:
+            break;
         case 1:
         case 2:
-        case 3: if (s->feat & TIMER_FEAT_EXTCLK) break;
-	default: hw_error("sh_timer_write: Reserved CKEG value\n"); break;
+        case 3:
+            if (s->feat & TIMER_FEAT_EXTCLK) {
+                break;
+            }
+        default:
+            hw_error("sh_timer_write: Reserved CKEG value\n");
+            break;
         }
         switch ((value & TIMER_TCR_ICPE) >> 6) {
-	case 0: break;
+        case 0:
+            break;
         case 2:
-        case 3: if (s->feat & TIMER_FEAT_CAPT) break;
-	default: hw_error("sh_timer_write: Reserved ICPE value\n"); break;
+        case 3:
+            if (s->feat & TIMER_FEAT_CAPT) {
+                break;
+            }
+        default:
+            hw_error("sh_timer_write: Reserved ICPE value\n");
+            break;
         }
-	if ((value & TIMER_TCR_UNF) == 0)
+        if ((value & TIMER_TCR_UNF) == 0) {
             s->int_level = 0;
+        }
 
-	value &= ~TIMER_TCR_UNF;
+        value &= ~TIMER_TCR_UNF;
 
-	if ((value & TIMER_TCR_ICPF) && (!(s->feat & TIMER_FEAT_CAPT)))
+        if ((value & TIMER_TCR_ICPF) && (!(s->feat & TIMER_FEAT_CAPT))) {
             hw_error("sh_timer_write: Reserved ICPF value\n");
+        }
 
-	value &= ~TIMER_TCR_ICPF; /* capture not supported */
+        value &= ~TIMER_TCR_ICPF; /* capture not supported */
 
-	if (value & TIMER_TCR_RESERVED)
+        if (value & TIMER_TCR_RESERVED) {
             hw_error("sh_timer_write: Reserved TCR bits set\n");
+        }
         s->tcr = value;
         ptimer_set_limit(s->timer, s->tcor, 0);
         ptimer_set_freq(s->timer, freq);
@@ -158,8 +178,8 @@ static void sh_timer_write(void *opaque, hwaddr offset,
     case OFFSET_TCPR:
         if (s->feat & TIMER_FEAT_CAPT) {
             s->tcpr = value;
-	    break;
-	}
+            break;
+        }
     default:
         hw_error("sh_timer_write: Bad offset %x\n", (int)offset);
     }
@@ -241,8 +261,9 @@ static uint64_t tmu012_read(void *opaque, hwaddr offset,
 #endif
 
     if (offset >= 0x20) {
-        if (!(s->feat & TMU012_FEAT_3CHAN))
-	    hw_error("tmu012_write: Bad channel offset %x\n", (int)offset);
+        if (!(s->feat & TMU012_FEAT_3CHAN)) {
+            hw_error("tmu012_write: Bad channel offset %x\n", (int)offset);
+        }
         return sh_timer_read(s->timer[2], offset - 0x20);
     }
 
@@ -272,33 +293,36 @@ static void tmu012_write(void *opaque, hwaddr offset,
 #endif
 
     if (offset >= 0x20) {
-        if (!(s->feat & TMU012_FEAT_3CHAN))
-	    hw_error("tmu012_write: Bad channel offset %x\n", (int)offset);
+        if (!(s->feat & TMU012_FEAT_3CHAN)) {
+            hw_error("tmu012_write: Bad channel offset %x\n", (int)offset);
+        }
         sh_timer_write(s->timer[2], offset - 0x20, value);
-	return;
+        return;
     }
 
     if (offset >= 0x14) {
         sh_timer_write(s->timer[1], offset - 0x14, value);
-	return;
+        return;
     }
 
     if (offset >= 0x08) {
         sh_timer_write(s->timer[0], offset - 0x08, value);
-	return;
+        return;
     }
 
     if (offset == 4) {
         sh_timer_start_stop(s->timer[0], value & (1 << 0));
         sh_timer_start_stop(s->timer[1], value & (1 << 1));
-        if (s->feat & TMU012_FEAT_3CHAN)
+        if (s->feat & TMU012_FEAT_3CHAN) {
             sh_timer_start_stop(s->timer[2], value & (1 << 2));
-	else
-            if (value & (1 << 2))
+        } else {
+            if (value & (1 << 2)) {
                 hw_error("tmu012_write: Bad channel\n");
+            }
+        }
 
-	s->tstr = value;
-	return;
+        s->tstr = value;
+        return;
     }
 
     if ((s->feat & TMU012_FEAT_TOCR) && offset == 0) {
@@ -314,8 +338,8 @@ static const MemoryRegionOps tmu012_ops = {
 
 void tmu012_init(MemoryRegion *sysmem, hwaddr base,
                  int feat, uint32_t freq,
-		 qemu_irq ch0_irq, qemu_irq ch1_irq,
-		 qemu_irq ch2_irq0, qemu_irq ch2_irq1)
+                 qemu_irq ch0_irq, qemu_irq ch1_irq,
+                 qemu_irq ch2_irq0, qemu_irq ch2_irq1)
 {
     tmu012_state *s;
     int timer_feat = (feat & TMU012_FEAT_EXTCLK) ? TIMER_FEAT_EXTCLK : 0;
@@ -324,9 +348,10 @@ void tmu012_init(MemoryRegion *sysmem, hwaddr base,
     s->feat = feat;
     s->timer[0] = sh_timer_init(freq, timer_feat, ch0_irq);
     s->timer[1] = sh_timer_init(freq, timer_feat, ch1_irq);
-    if (feat & TMU012_FEAT_3CHAN)
+    if (feat & TMU012_FEAT_3CHAN) {
         s->timer[2] = sh_timer_init(freq, timer_feat | TIMER_FEAT_CAPT,
-				    ch2_irq0); /* ch2_irq1 not supported */
+                                    ch2_irq0); /* ch2_irq1 not supported */
+    }
 
     memory_region_init_io(&s->iomem, NULL, &tmu012_ops, s,
                           "timer", 0x100000000ULL);
-- 
2.26.2


