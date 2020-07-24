Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6946C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B124020656
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BHe5duqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B124020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyBE-0006cU-Ur
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1jyuMr-00051X-Ci
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:51:53 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1jyuMp-0002qW-07
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:51:53 -0400
Received: by mail-pl1-x641.google.com with SMTP id 72so4167677ple.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RtXwts8UAKZ/GyfPJVf+JplfZufhV8mc3N6j35EEXAE=;
 b=BHe5duqpDrCmFoSkfz3ZlkAUyWMf6iQ2M98LUet0vrR2zvcZiLh3lHt2YnyiNDfVvK
 c/apETkTwXUIIL37iKWqelOGkgHYoqMFdpZKVLLMrniVJ8VpaAeZc+GhMN0/CvIp3pDX
 a31arhl/f4qMENfga3AjggTGrgigcYXap+uuHKKTHpuZ+iNfJEjQKKz6zyXJlYVU1U9f
 HzzWygqFBxeoSNh8b5uOgE9PSbeko0MS4MdCgdKY8Ek5JmL3N9JxQgJXK5ZnAFrVWQF/
 dIQwiak1SKkzEczo08/aFOIt3XQ5kX1IEQgI46zl2WkRlS59caCHmiNxwI+SLwiBO3vN
 r37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RtXwts8UAKZ/GyfPJVf+JplfZufhV8mc3N6j35EEXAE=;
 b=izKypeXZKLUGnYyLqjZSIIEmGmHpSiTsSwcKkWyFkVTSAaeFbErKX3dylBLFrKVQpy
 Sht0TCIljXoXXuDU5iEWYNrhx1dAbTCMLdyX7YjCLRYRY2UOX/78awJ+ZlIqmSOEw5Yj
 nVGOifluDqpHLPj2DuA48lqrFzNMvo42N5pUu7H2KEb4IACW0tmq5Pyv1cjKjE1m50Hr
 WmqDEomL+6bdm5SoTfswK/SboGaRNhtPZHvUFaZiYDUQOGenhdfvvGN7wiz9VYEaEGrC
 EYjHSI5c8E2WouJsjiQg4QiHY012NQw8w9LnuVmz+ShY8+HFYiGhYxOOYtduYMeeI9sE
 qfqw==
X-Gm-Message-State: AOAM5310Y93qNSTpLZ/vapugLsx55m1x1lYdr3iTt3XkVlD7HP/KqWfZ
 qKaJLbwturl4VTKqOiIcQkja5g==
X-Google-Smtp-Source: ABdhPJxsKjg3RDtbq9NBEFjjd8OLruNmjXg6/BikQNUKP/f1FHOO+DHNNm5S/Zdpi7te8VXdhFsT5w==
X-Received: by 2002:a17:90a:dd44:: with SMTP id
 u4mr4285690pjv.203.1595584309656; 
 Fri, 24 Jul 2020 02:51:49 -0700 (PDT)
Received: from localhost.localdomain (111-243-186-54.dynamic-ip.hinet.net.
 [111.243.186.54])
 by smtp.gmail.com with ESMTPSA id x23sm5581636pfn.4.2020.07.24.02.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 02:51:49 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH 2/2] hw/riscv: sifive_u: Add write-once protection.
Date: Fri, 24 Jul 2020 17:51:12 +0800
Message-Id: <20200724095112.2615-3-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724095112.2615-1-green.wan@sifive.com>
References: <20200724095112.2615-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=green.wan@sifive.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2020 09:54:21 -0400
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Green Wan <green.wan@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add array to store the 'written' status for all bit of OTP to block
the write operation to the same bit. Ignore the control register
offset from 0x0 to 0x38 of OTP memory mapping.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/riscv/sifive_u_otp.c         | 34 ++++++++++++++++++++++++++++++---
 include/hw/riscv/sifive_u_otp.h |  1 +
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
index 26e1965821..e0f85dee22 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -36,6 +36,12 @@
 #define TRACE_PREFIX            "FU540_OTP: "
 #define SIFIVE_FU540_OTP_SIZE   (SIFIVE_U_OTP_NUM_FUSES * 4)
 
+#define SET_WRITTEN_BIT(map, idx, bit)    \
+    (map[idx] |= (0x1 << bit))
+
+#define GET_WRITTEN_BIT(map, idx, bit)    \
+    ((map[idx] >> bit) & 0x1)
+
 static int otp_backed_fd;
 static unsigned int *otp_mmap;
 
@@ -199,6 +205,18 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
         s->ptrim = val32;
         break;
     case SIFIVE_U_OTP_PWE:
+        /* Keep written state for data only and PWE is enabled. Ignore PAS=1 */
+        if ((s->pa > SIFIVE_U_OTP_PWE) && (val32 & 0x1) && !s->pas) {
+            if (GET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              TRACE_PREFIX "Error: write idx<%u>, bit<%u>\n",
+                              s->pa, s->paio);
+                break;
+            } else {
+                SET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio);
+            }
+        }
+
         if (otp_file) {
             sifive_u_otp_backed_load(otp_file);
             sifive_u_otp_backed_write(s->pa, s->paio, s->pdin);
@@ -244,9 +262,19 @@ static void sifive_u_otp_reset(DeviceState *dev)
     /* Initialize all fuses' initial value to 0xFFs */
     memset(s->fuse, 0xff, sizeof(s->fuse));
 
-    /* Make a valid content of serial number */
-    s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
-    s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+    /* Initialize write-once map */
+    memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
+
+    /* if otp file is used, not over write these value. */
+    if (!otp_file) {
+        /* Make a valid content of serial number */
+        s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
+        s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+
+        /* set status to 'written' */
+        s->fuse_wo[SIFIVE_U_OTP_SERIAL_ADDR] = 0xffff;
+        s->fuse_wo[SIFIVE_U_OTP_SERIAL_ADDR + 1] = 0xffff;
+    }
 
     /* Initialize file mmap and descriptor. */
     otp_mmap = NULL;
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
index 1342bd7342..9c9c57f39e 100644
--- a/include/hw/riscv/sifive_u_otp.h
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -77,6 +77,7 @@ typedef struct SiFiveUOTPState {
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
+    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
 } SiFiveUOTPState;
 
 #endif /* HW_SIFIVE_U_OTP_H */
-- 
2.17.1


