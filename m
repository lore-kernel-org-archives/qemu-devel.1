Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26609C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D74120878
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zqt6IuwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D74120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzJa-0006zy-BI
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyzJ-0004Sz-E0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:28:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyzH-0001Xq-Ab
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466895; x=1635002895;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QxxpnjE6UQxURuz1kdJyV9BtXyZ2wTvZTkGBbbGNMKY=;
 b=Zqt6IuwKojPMZPl3pvwgJ3l4CyTDq2N7HATvMVTSBZcurYPAzsGBfsB3
 L1v3KSKST06/LgyNxSWC9aT5Weqfs1CbqIfQ2ubVUrG1EaI6Wt8ZHP4AQ
 0Q+LcToHzyMMUp/DJFpN9Zh2DiWuJOPvB3wb4W3RBebb+rDoX42qOK8HF
 QGtbcyOQX6T1As/nL5EiRjuo288Pd4EsUHUwFHW4YjliyD/qAUhzEjjkX
 3GDfeplLKoeEE6iZ3QfXK5P9n9muFNwusWmEg1ts4RSWfOy5FWvlOuxrZ
 dAxkvKIvI8d2OwLSIWWsLvnmdUgI2HOf61u6/3XSO/A2akKH3YCR/XDw8 Q==;
IronPort-SDR: oa1M1JXn57Qf4HpNXCaJGM3rgraeZbgc9PZXQ34JLQpRZQZh7FrVztlxPwBF80deuNymc/kesi
 ivKiErKHpMYHuHA8KNP4PWLxlA+IsnGcgY2oZm6QE6zoZ7FdPeUnfanD60uqltwPufhMErAa0E
 Nas+HxtqQ1pXmc3W0V2mbZr5HEBUg4ORYlTg5JIuggiEqagJVAezFkykWBNc/GKz2FAyQF8CH8
 a0BSuwv0fjf0wpPkboQVPCc1pl+vjnOgVTkhbEiZfTwxYjyFPo61a0lpxOEURar8qiWyN7Xlrs
 VoE=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652330"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:45 +0800
IronPort-SDR: Fa/cjtGHo43eFfNiqYEic6UAiaeeEOdb1rhWqYhqLjYH/NL9ELsigTl7sso5iiX+5IC1QRhbPZ
 jYFnHXCTRUsOg4WUVKe2ghN5qNQ1/yJ1GS1R1L2aA0vlGi1pBMhqLZ+GeZwWeOGp8jqAcSjfen
 bCZ9jn+AF0poRiWuRdkqiRVcpK3Y380ZrzYffiDuQ7uhZ8uAWmMEp2vRJ6nLIVIHcInmQXOQAi
 X9FeeIKfaQycFPpb1w/CNkKCzsWbB5+TeevTPcq86BZ/3pnSQP0NoZR+q25ojt7nAp8z3MTQyi
 co2yEyCBoHi6E9QQO+A5TnPG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:13:01 -0700
IronPort-SDR: LgBbZms+w/jj63DzoKDHz6v4NK21A9CVFshITOAe/hN4co52YZk3PW6sHM2HhgP+Bs2wZ/25ki
 wF4rqjK+s0G8Nj5iuor8cJjaqwYunyrpYhcH55HR0Kn1x2CU7deVAG1hpAT/9uLaGbJlxaq61B
 kYFzQB8pPsxjuddX4SDuRNNV70JqCyfwBEZgI0O84s1dKjlG72uTm7mKuH8FEXFX0Bl/Q4zRP/
 QRkHVDfCHYENcOUo6ZeyhN3nCyoUVtOJJRiEKQ6ysLuy+D+efz3HCamdLifqDU5/CiWOEZfaX4
 p/0=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 12/12] hw/misc/sifive_u_otp: Add backend drive support
Date: Fri, 23 Oct 2020 08:16:19 -0700
Message-Id: <20201023151619.3175155-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>, Green Wan <green.wan@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Green Wan <green.wan@sifive.com>

Add '-drive' support to OTP device. Allow users to assign a raw file
as OTP image.

test commands for 16k otp.img filled with zero:

$ dd if=/dev/zero of=./otp.img bs=1k count=16
$ ./qemu-system-riscv64 -M sifive_u -m 256M -nographic -bios none \
-kernel ../opensbi/build/platform/sifive/fu540/firmware/fw_payload.elf \
-d guest_errors -drive if=none,format=raw,file=otp.img

Signed-off-by: Green Wan <green.wan@sifive.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201020033732.12921-3-green.wan@sifive.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/sifive_u_otp.h |  2 ++
 hw/misc/sifive_u_otp.c         | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

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
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index b9238d64cb..60066375ab 100644
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
-- 
2.28.0


