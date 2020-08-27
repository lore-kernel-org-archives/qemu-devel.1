Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D984C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C545620786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A3wvoA7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C545620786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCdU-0001nC-1p
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 03:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kBCch-0000Pk-CD
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:47:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kBCcf-0008He-En
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:47:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id t185so2840402pfd.13
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yHxl/zQGRoR/TJ33cwWpZTpLU2uichKYZlbX7/79GJE=;
 b=A3wvoA7lTk0Rr2E7yxqBBO43wfXWjbFa3BxCcs9XAdXSedgWRUKdOPDXQL2eItMe04
 RlDAWP22vBYrqo/m3wK/n3/u2QvyZ2TNl2kvNK4PyE/u0gw7Y1SgXrh19VcdVVTYtIBD
 epmb7FrU/JYyfM3PDS4QylanMzKUJwSzIQn4GwlhJKyC9slVPnV7C7OhK1wbAXL5bYO+
 72q7v33wxfzYKp4+/QAYggGo1xWS/juXbnGAVhP8keaPIXmHti6Pg7oCOqxitbpoah/X
 v65zuZpBBf5rt88v1jp4H49cvPopcH38IyLQBIRYZ/3wFWbHBxlzrUtuhbdXyslL2YJr
 j87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yHxl/zQGRoR/TJ33cwWpZTpLU2uichKYZlbX7/79GJE=;
 b=AAx7W8ZPmoNCmZOqfPCzPi5Oe7fv0/QmtFWp8QFVZyJOBDiUvKSEdCpZtvIeEl/W54
 TtzoI02BblWbigTrL6Rd1ya3VCxBkY6+uu2hKrZZN2qio4QVlIM6EU9CrpUhiUaEgpuC
 PEeorB5Pvkso7fboqWAap15HDT2SB5FdZNvni1HyZoy60Xigly2TRYMbvr38yX1V3JPY
 zFaisVsgV2ql8S3z1g0cwWfJy7q+d1t9brtTqqOq2qpdDUo1DqTX3r1kKgo3YMLk7wfl
 4NaRp/LZw5hU/8R4VUXORsbuueZvUPHKDxClKd0LfYif0coRnpRWj56wrxaq64tC82lL
 8WVA==
X-Gm-Message-State: AOAM531lT2eILwoNm+iXUTi3KNYQSqG0LN1ylLcCFZKY/DAbmo/yktoV
 TMNXkRhp41aQuIyDgtBiPUE37g==
X-Google-Smtp-Source: ABdhPJyHB5aZVXliqvd1qlpBGkbZWVxTAI5OO13xRpSIgjFCp6Ni0mQRR9aCZEiVTx0lyeC/eQtutw==
X-Received: by 2002:a17:902:b111:: with SMTP id
 q17mr15027116plr.202.1598514419743; 
 Thu, 27 Aug 2020 00:46:59 -0700 (PDT)
Received: from localhost.localdomain (111-241-121-209.dynamic-ip.hinet.net.
 [111.241.121.209])
 by smtp.gmail.com with ESMTPSA id k17sm431032pfg.99.2020.08.27.00.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 00:46:59 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v4 1/2] hw/riscv: sifive_u: Add backend drive support
Date: Thu, 27 Aug 2020 15:46:37 +0800
Message-Id: <20200827074638.21451-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827074638.21451-1-green.wan@sifive.com>
References: <20200827074638.21451-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=green.wan@sifive.com; helo=mail-pf1-x443.google.com
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
index f6ecbaa2ca..aab2220494 100644
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
index 639297564a..13d2552e43 100644
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
+    BlockBackend *blk;
 } SiFiveUOTPState;
 
 #endif /* HW_SIFIVE_U_OTP_H */
-- 
2.17.1


