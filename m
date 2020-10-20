Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78310C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE80522247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5alIm20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE80522247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtlQ-0008LK-Kl
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUtjm-0006di-Cb
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUtjk-0001QN-IU
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603208383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=UBOl59CC6PSV0y+gfj/cKx84JPBfLEjyiObAXqSlGr4=;
 b=R5alIm209h7eL3pZYdMY990m0aSOmxbOrnJuhZPNO36IY6kbIN5lSMF7FDLDRI7cE7FPP1
 pHuXgzJOVqZeW9MT2weNt2K+mdAS3ga/CPtO+C7xzn0qiCDc8oolAZmx52QFd7hM7iA4TI
 /iA+4XGtAmlxqE8PYTBYyncpzauunjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-dvCEExDBMC2XYO8esT529Q-1; Tue, 20 Oct 2020 11:39:40 -0400
X-MC-Unique: dvCEExDBMC2XYO8esT529Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 029B518A8224;
 Tue, 20 Oct 2020 15:39:39 +0000 (UTC)
Received: from thuth.com (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 170925B4B3;
 Tue, 20 Oct 2020 15:39:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/timer/sh_timer: Coding style clean-up
Date: Tue, 20 Oct 2020 17:39:33 +0200
Message-Id: <20201020153935.54315-2-thuth@redhat.com>
In-Reply-To: <20201020153935.54315-1-thuth@redhat.com>
References: <20201020153935.54315-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace TAB characters with spaces, put code after case-statement on
separate lines and add some curly braces in related lines to keep
checkpatch.pl happy.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/timer/sh_timer.c | 89 +++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 32 deletions(-)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index bb0e1c8ee5..b09e30f938 100644
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
2.18.2


