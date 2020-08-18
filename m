Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724DCC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330232067C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Xjejeyls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330232067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k857q-0007Vl-9K
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 13:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k856t-0006Zm-K2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:09:19 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k856r-0002zh-Fu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 13:09:19 -0400
Received: by mail-pj1-x1044.google.com with SMTP id i92so9627268pje.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0T4Wtrmv4d/iFWaZyNVtP1A4DrIkBJVNCMFjoDI7cYI=;
 b=XjejeylsdTUAlE1633RECHlDYZsg2GFUS+NX04B+9sWrOjMfbGCtRKL6vIptpvFdzU
 bCefoU/R4bF5nL5aYi2y/WxFxPs1clmLFOrNMOsuRdJ1+UDymuzXmxzK8HDy7VFAVxXp
 WNvlHMkwWxMtVRF6sTrlqtbG+XuHMvILYpkp/UXqfZtl7aASL+++1+lU/5XT+VqMOB5I
 ghHtacive3wO5PRFUdIcKwCL4Bn4Wifl7RsdShxsBc2yf1hv2EKSSqraoc5ay5hVvRqP
 SmQPO3qIaW61+S73QpvGOAh+LUmLpOYyIcdqXuZleBosNUUtgK7FutRlQxoQg7KFa4BM
 x9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0T4Wtrmv4d/iFWaZyNVtP1A4DrIkBJVNCMFjoDI7cYI=;
 b=hyZXTlofxCM24UBXLOwuwnsrmJeEWyVAnDRglRAPHKVLYqdpNL1SoI59dYPrXIXfT9
 TT2/tHQJgy/mCvwsd1ynkNjXTDb+mzijENm2/xehOSJHSPSssA5A9rQc5HDd3XY7PsS0
 F3BMhZt906z6OMfKgEpGd61yu5Tyl1u9CZhkSIZG+1LJxAqvFy+gh+ndjhU+39iakhWc
 orqO0CBC9oClE8ycE3Na8MwxV5Fg78VD3s9gNjMkPQXkyn3y21zV2ztX1DTb3yqjDptP
 ZkYgBI3XhfMM05nL96D4KdknIT3FhkrQ3nVn5hZqJRgvxDpm+AKhBwLQ7THS9g9mjj+Z
 tE5w==
X-Gm-Message-State: AOAM532TouPD/nJlIUZhOSTTOJJXdh3HbDBmvszMLWTZwr8yzuXRCO1K
 874rjHEpWXsBqIKTHkrndZ7HZw==
X-Google-Smtp-Source: ABdhPJwhtd0on1GGrlhdH/IbP58QxHcXhDvxCNBsNgoANaOUCGfj672+ejTUDv5o/w+TFN5LOQhpEw==
X-Received: by 2002:a17:902:c382:: with SMTP id
 g2mr15087368plg.120.1597770555713; 
 Tue, 18 Aug 2020 10:09:15 -0700 (PDT)
Received: from localhost.localdomain (114-47-163-2.dynamic-ip.hinet.net.
 [114.47.163.2])
 by smtp.gmail.com with ESMTPSA id m3sm460043pjs.22.2020.08.18.10.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 10:09:15 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v3 1/2] hw/riscv: sifive_u: Add backend drive support
Date: Wed, 19 Aug 2020 01:08:38 +0800
Message-Id: <20200818170839.20258-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818170839.20258-1-green.wan@sifive.com>
References: <20200818170839.20258-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=green.wan@sifive.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Green Wan <green.wan@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add '-drive' support to OTP device. Allow users to assign a raw file
as OTP image.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/riscv/sifive_u_otp.c         | 50 +++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u_otp.h |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
index f6ecbaa2ca..4552b2409e 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -24,6 +24,8 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/riscv/sifive_u_otp.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/block-backend.h"
 
 static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -46,6 +48,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
         if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
             (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
             (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
+
+            /* read from backend*/
+            if (s->blk) {
+                int32_t buf;
+
+                blk_pread(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &buf,
+                          SIFIVE_U_OTP_FUSE_WORD);
+                return buf;
+            }
+
             return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
         } else {
             return 0xff;
@@ -123,6 +135,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
         s->ptrim = val32;
         break;
     case SIFIVE_U_OTP_PWE:
+        /* write to backend */
+        if (s->blk) {
+            blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
+                       SIFIVE_U_OTP_FUSE_WORD, 0);
+        }
+
         s->pwe = val32;
         break;
     default:
@@ -143,16 +161,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
 
 static Property sifive_u_otp_properties[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
+    DEFINE_PROP_DRIVE("drive", SiFiveUOTPState, blk),
     DEFINE_PROP_END_OF_LIST(),
 };
 
 static void sifive_u_otp_realize(DeviceState *dev, Error **errp)
 {
     SiFiveUOTPState *s = SIFIVE_U_OTP(dev);
+    DriveInfo *dinfo;
 
     memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_u_otp_ops, s,
                           TYPE_SIFIVE_U_OTP, SIFIVE_U_OTP_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    dinfo = drive_get_next(IF_NONE);
+    if (dinfo) {
+        int ret;
+        uint64_t perm;
+        int filesize;
+        BlockBackend   *blk;
+
+        blk = blk_by_legacy_dinfo(dinfo);
+        filesize = SIFIVE_U_OTP_NUM_FUSES * SIFIVE_U_OTP_FUSE_WORD;
+        if (blk_getlength(blk) < filesize) {
+            qemu_log_mask(LOG_GUEST_ERROR, "OTP drive size < 16K\n");
+            return;
+        }
+
+        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
+
+        perm = BLK_PERM_CONSISTENT_READ |
+                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
+        ret = blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR, "set perm error.");
+        }
+
+        if (blk_pread(s->blk, 0, s->fuse, filesize) != filesize) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "failed to read the initial flash content");
+            return;
+        }
+    }
 }
 
 static void sifive_u_otp_reset(DeviceState *dev)
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
index 639297564a..dea1df6f6c 100644
--- a/include/hw/riscv/sifive_u_otp.h
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -43,6 +43,7 @@
 
 #define SIFIVE_U_OTP_PA_MASK        0xfff
 #define SIFIVE_U_OTP_NUM_FUSES      0x1000
+#define SIFIVE_U_OTP_FUSE_WORD      4
 #define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
 
 #define SIFIVE_U_OTP_REG_SIZE       0x1000
@@ -75,6 +76,7 @@ typedef struct SiFiveUOTPState {
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
+    BlockBackend   *blk;
 } SiFiveUOTPState;
 
 #endif /* HW_SIFIVE_U_OTP_H */
-- 
2.17.1


