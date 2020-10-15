Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CF022210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jt1v3hzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CF022210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSui7-0000T6-8e
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 00:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSufa-0006Th-UD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:15:14 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSufY-0006s5-To
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:15:14 -0400
Received: by mail-pj1-x1044.google.com with SMTP id u3so1121934pjr.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Htn/B8k+1/JpRIVNx3cFS6HMpNPM26t880PCz9769ik=;
 b=jt1v3hzmh7qtX18sJtd3U6q6TydqJqpR94Fdubg03KVkWeboDwNN+ccek3O0EUSSJQ
 K8SrqSRpRPLF1YcejX96j4zkxcetrc4WGmeTaeoIQkyNqiL0gBjFBiAgkAm3P3z+Ytnk
 CXJFbd7Lg3vKUctmE7tt7fagqEotnqfTlSH1DGsBZkmAFbpazlZkzXLrB47T0fkk/CFI
 4TA5lssF4MBDFzlnQatduttUpnWT/tFoabSSqi70uzoS4BMG7B4LHF9UtSMO1Ihp8Yry
 0Rm3TesT08sVZEI/Q0KKtnirtnlzZ89jTSB7QqstCvPP4+7EhYBLGRZgeFGj+XvNcRhy
 Ts6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Htn/B8k+1/JpRIVNx3cFS6HMpNPM26t880PCz9769ik=;
 b=KIUR6qTJCGrBVcZHwA8c0i6WwOFqLG9S56DduEQeVCUxPjgjsyJUNDx+chBFZnI2i0
 efkV8n1PL1OlTJItGwREag1mr2ZhdEQ5AVANPQQuOUC+h9S69B4f4lBkIGk2JOY0JxaW
 9VLiutDMA3BJohD34L6mn+XB8ZqbHPBTUb6wkDEmXLAKNzn8haQBwFCfTrRhT+YS2QPy
 sWHS6ljbaNaXLT77NgoTC45vCfqJCcRxEhdGN2JgTteagUHx1/HMinY2taF0fxYxvjYh
 y+DxKDe4BCVM5EOor2nutMRm9GPtMSnoP2fQtqyce7IB6W14K/AWvOo79VmNJpQa7YwJ
 5XAw==
X-Gm-Message-State: AOAM532GswCHQ2lO0w5DTQ4GH5TPygaUz7YlgeU9QbsXu1Bq7xSTRPZW
 BEKsSGwk1LI5hGYFDGs/EWQ3FwggnQXypKOd
X-Google-Smtp-Source: ABdhPJxZKLyd6nBG7vk+OLdDnl7AH1knA36A4fllD6CbW9htrJRBXszIRALJerV9pj3DgQdW+vYL2g==
X-Received: by 2002:a17:90b:30d2:: with SMTP id
 hi18mr2552799pjb.86.1602735311314; 
 Wed, 14 Oct 2020 21:15:11 -0700 (PDT)
Received: from localhost.localdomain (111-241-103-134.dynamic-ip.hinet.net.
 [111.241.103.134])
 by smtp.gmail.com with ESMTPSA id gd14sm1250191pjb.31.2020.10.14.21.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 21:15:10 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v7 2/2] hw/misc/sifive_u_otp: Add backend drive support
Date: Thu, 15 Oct 2020 12:14:24 +0800
Message-Id: <20201015041424.23090-3-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015041424.23090-1-green.wan@sifive.com>
References: <20201015041424.23090-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=green.wan@sifive.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, green.wan@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add '-drive' support to OTP device. Allow users to assign a raw file
as OTP image.

test commands for 16k otp.img filled with zero:

$ dd if=/dev/zero of=./otp.img bs=1k count=16
$ ./qemu-system-riscv64 -M sifive_u -m 256M -nographic -bios none \
-kernel ../opensbi/build/platform/sifive/fu540/firmware/fw_payload.elf \
-d guest_errors -drive if=none,format=raw,file=otp.img

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/misc/sifive_u_otp.c         | 67 +++++++++++++++++++++++++++++++++-
 include/hw/misc/sifive_u_otp.h |  2 +
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 565eec082f..60066375ab 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -19,11 +19,14 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/misc/sifive_u_otp.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/block-backend.h"
 
 #define WRITTEN_BIT_ON 0x1
 
@@ -54,6 +57,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
         if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
             (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
             (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
+
+            /* read from backend */
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
@@ -137,7 +150,7 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
         if (s->pwe && !s->pas) {
             if (GET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
-                              "Error: write idx<%u>, bit<%u>\n",
+                              "write once error: idx<%u>, bit<%u>\n",
                               s->pa, s->paio);
                 break;
             }
@@ -145,6 +158,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
             /* write bit data */
             SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
 
+            /* write to backend */
+            if (s->blk) {
+                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD,
+                           &s->fuse[s->pa], SIFIVE_U_OTP_FUSE_WORD, 0);
+            }
+
             /* update written bit */
             SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
         }
@@ -168,16 +187,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
 
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
+        BlockBackend *blk;
+
+        blk = blk_by_legacy_dinfo(dinfo);
+        filesize = SIFIVE_U_OTP_NUM_FUSES * SIFIVE_U_OTP_FUSE_WORD;
+        if (blk_getlength(blk) < filesize) {
+            error_setg(errp, "OTP drive size < 16K");
+            return;
+        }
+
+        qdev_prop_set_drive_err(dev, "drive", blk, errp);
+
+        if (s->blk) {
+            perm = BLK_PERM_CONSISTENT_READ |
+                   (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
+            ret = blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
+            if (ret < 0) {
+                return;
+            }
+
+            if (blk_pread(s->blk, 0, s->fuse, filesize) != filesize) {
+                error_setg(errp, "failed to read the initial flash content");
+            }
+        }
+    }
 }
 
 static void sifive_u_otp_reset(DeviceState *dev)
@@ -191,6 +242,20 @@ static void sifive_u_otp_reset(DeviceState *dev)
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
 
+    if (s->blk) {
+        /* Put serial number to backend as well*/
+        uint32_t serial_data;
+        int index = SIFIVE_U_OTP_SERIAL_ADDR;
+
+        serial_data = s->serial;
+        blk_pwrite(s->blk, index * SIFIVE_U_OTP_FUSE_WORD,
+                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
+
+        serial_data = ~(s->serial);
+        blk_pwrite(s->blk, (index + 1) * SIFIVE_U_OTP_FUSE_WORD,
+                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
+    }
+
     /* Initialize write-once map */
     memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
 }
diff --git a/include/hw/misc/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
index ebffbc1fa5..5d0d7df455 100644
--- a/include/hw/misc/sifive_u_otp.h
+++ b/include/hw/misc/sifive_u_otp.h
@@ -46,6 +46,7 @@
 
 #define SIFIVE_U_OTP_PA_MASK        0xfff
 #define SIFIVE_U_OTP_NUM_FUSES      0x1000
+#define SIFIVE_U_OTP_FUSE_WORD      4
 #define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
 
 #define SIFIVE_U_OTP_REG_SIZE       0x1000
@@ -80,6 +81,7 @@ struct SiFiveUOTPState {
     uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
+    BlockBackend *blk;
 };
 
 #endif /* HW_SIFIVE_U_OTP_H */
-- 
2.17.1


