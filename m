Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E748EC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3093206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FxjfpQyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3093206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Xh-000670-Kp
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kD8Vd-0002GJ-8Q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:47:45 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kD8Vb-00026i-EB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:47:44 -0400
Received: by mail-pl1-x643.google.com with SMTP id y6so721964plk.10
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Dka4kGmZfMcbFE4G/5IsI7nQ8gtf9IAo5wRmBXJcgzA=;
 b=FxjfpQyHEdjUQ2UKZUinwwi/zNqDX7YQ4XSlDjIplvJteba8JM40xdPF8EHFQknvUV
 yEGL6M2T9ATkyos33QH2Fun4kdJYaBEIsH27EsJP/XGQcDiE4fj6QEE3pk7d1/LcMc4e
 29X5K/UB8VfVBgUgz2fEiOZu3fG/aOz62ugnozjCB1heA7SWA7hjYr7s7Ru3QeZgQv3s
 qRVjGID6sx3Acd/QuBVQ45fYf7/m6asuDaFS2//3QemMLLIczckME8AOEqiYNWJsKTNV
 c1SQe0KFNlFxUXZeeHDWQUn50Ds8uwIfwDts4bSbRS1CA4b9FlnrBaNymgA05aYFWWgt
 IMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Dka4kGmZfMcbFE4G/5IsI7nQ8gtf9IAo5wRmBXJcgzA=;
 b=QFDaVd7JiYHg1o1NF52lKQEAhRnwbqVls4o6cKSgHfegvboLePu/6ygLhCcWkb2VLW
 lvhwPuIoVgCBoxQ+9c5y/b/6sdt/PrQkwcsN0oyc3W7fhgsQB12LVW6qA2OKJryOHMld
 lbdZDCif5G3iD9SY0kUyzHJhYhrCHlsfUMSfsnKLcPmktcJF0U/kXgw6BOXJxc3kERMZ
 rq/P+DOwdFdSZ1yTA+QwCv9dbqBGD2ekLWJAEEJT9lAR8qf6drFJ84RwVSZsNs/jpeZr
 hae5HZqVp0DwFLxSqZvvfOvRAROboETiCSndlg5ykfO6BUqDxDZ+1Li0GwgoEuyuuWvX
 q7vg==
X-Gm-Message-State: AOAM531ao+Gp4DQK2RO+olwRptUpY0oEPWLVm8/8jPGvJbs5HqbmhO41
 8zuxN1RMQvkH7j7Okooy2ZQvLRxyFmMEFTZH
X-Google-Smtp-Source: ABdhPJwuZaYYkJSIQ7Qox7m2qFd3c6hdvqfw489NgESG+2Qau1UJoTI8STjSfRfy4hIQmsmXakp2ow==
X-Received: by 2002:a17:90b:282:: with SMTP id
 az2mr2224329pjb.66.1598975261902; 
 Tue, 01 Sep 2020 08:47:41 -0700 (PDT)
Received: from localhost.localdomain (111-241-104-82.dynamic-ip.hinet.net.
 [111.241.104.82])
 by smtp.gmail.com with ESMTPSA id e17sm2485344pfm.60.2020.09.01.08.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:47:41 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v5 2/2] hw/riscv: sifive_u: Add backend drive support
Date: Tue,  1 Sep 2020 23:47:11 +0800
Message-Id: <20200901154711.18457-3-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901154711.18457-1-green.wan@sifive.com>
References: <20200901154711.18457-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=green.wan@sifive.com; helo=mail-pl1-x643.google.com
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
index b8369e9035..477c54c7b8 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -24,6 +24,8 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/riscv/sifive_u_otp.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/block-backend.h"
 
 #define WRITTEN_BIT_ON 0x1
 
@@ -54,6 +56,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
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
@@ -145,6 +157,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
             /* write bit data */
             SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
 
+            /* write to backend */
+            if (s->blk) {
+                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
+                           SIFIVE_U_OTP_FUSE_WORD, 0);
+            }
+
             /* update written bit */
             SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
         }
@@ -168,16 +186,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
 
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
+            qemu_log_mask(LOG_GUEST_ERROR, "OTP drive size < 16K\n");
+            return;
+        }
+
+        qdev_prop_set_drive(dev, "drive", blk);
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
index 4a5a0acf48..9bc781fd4f 100644
--- a/include/hw/riscv/sifive_u_otp.h
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -45,6 +45,7 @@
 
 #define SIFIVE_U_OTP_PA_MASK        0xfff
 #define SIFIVE_U_OTP_NUM_FUSES      0x1000
+#define SIFIVE_U_OTP_FUSE_WORD      4
 #define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
 
 #define SIFIVE_U_OTP_REG_SIZE       0x1000
@@ -78,6 +79,7 @@ typedef struct SiFiveUOTPState {
     uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
+    BlockBackend *blk;
 } SiFiveUOTPState;
 
 #endif /* HW_SIFIVE_U_OTP_H */
-- 
2.17.1


