Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4D9C4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993A120756
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aboCT2Ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993A120756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqAL-0005lA-ND
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kMq8c-0003dv-Hg
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:12:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kMq8Y-0001RX-Fr
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:12:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id s31so436163pga.7
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nN8OUO8G/I5uJu9MqGsHVSz2gMnkdh9PLBBCTFybCKs=;
 b=aboCT2ArQYYDhf782qD0kk00pyozozQtQ2IR0olfKL4JReuQDZ5ntreBB8IFxArOEO
 xq2IhLlpTLCN92TP9cAzK1DCHCKrnsH+N42lqgKBjeaSzdTP3XoGLNflxcD6gx2fka57
 3Z6Igdj9sWAZE+BN1KC++V+a0hoTtZjrlS9Ms4TsJVxnRKW3g7P9d0PXvMKG5AN0eigg
 xN6Hs/sIW/asTHGHgeIUNtCF9bXzbqr9QDVJ81eGt3fssClwyp4bGWZxdL8J7igUpFdK
 LENFXn9NRgI/u1tq6bbZvHtF1FZDG5CLRvPRjTpMBDyPp8FT9G+J0Cd4RWUPv1xwyBs5
 3JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nN8OUO8G/I5uJu9MqGsHVSz2gMnkdh9PLBBCTFybCKs=;
 b=DGKmiN4i0iVhHtPnBP3GqPAqRXMhtJs9jVfJTGOzCxtRjoaHSWX7LLTor+kcVYQrkp
 d4x2EMIXqyoYM+vs79cvI4EFyM7Ikr+9IpwpemP/2JJz2BnOADApXZbwCiqMuHZTMgVy
 6nvBFC8MFSZzicw+A4xEEj9LwKkzV0Y9Zb4aKBWJZOuSw+7O0zSJVegrDv66aRQbeLfM
 zxqJAvbzKqqa0vDjYBbbO7Wehe4miGN4Lt7zht4rzl8O0CWFD7qnyAXGznqdy+1TAd+a
 xRT6knw6IyGWK9uBnwzcao+B5hHFqCoilewMR7AMul/igKv8NJHKq8AjNrF2Nyf8a28G
 MVTw==
X-Gm-Message-State: AOAM533HUAN09UMN+YBA6/sF3hRvZ/3gQ6/00TC+mziyrjKzfgmjj255
 HYF9rwgLeUhDAFTq5+0+TwDYD+I5knGKuw==
X-Google-Smtp-Source: ABdhPJz+VEMYAFr2ORSEiTPliIuseVDH3qacbT7EQWzjsw6BB6tDucwMcj2OGrTHzNo6S8vwF/2iVQ==
X-Received: by 2002:a17:902:c394:b029:d2:4ca:2e22 with SMTP id
 g20-20020a170902c394b02900d204ca2e22mr883726plg.77.1601287920409; 
 Mon, 28 Sep 2020 03:12:00 -0700 (PDT)
Received: from localhost.localdomain (111-241-115-7.dynamic-ip.hinet.net.
 [111.241.115.7])
 by smtp.gmail.com with ESMTPSA id u2sm814747pji.50.2020.09.28.03.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 03:12:00 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v6 1/2] hw/misc/sifive_u_otp: Add write function and
 write-once protection
Date: Mon, 28 Sep 2020 18:11:45 +0800
Message-Id: <20200928101146.12786-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928101146.12786-1-green.wan@sifive.com>
References: <20200928101146.12786-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=green.wan@sifive.com; helo=mail-pg1-x541.google.com
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
 qemu-devel@nongnu.org, Green Wan <green.wan@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 - Add write operation to update fuse data bit when PWE bit is on.
 - Add array, fuse_wo, to store the 'written' status for all bits
   of OTP to block the write operation.

Signed-off-by: Green Wan <green.wan@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/misc/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/misc/sifive_u_otp.h |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index c2f3c8e129..685c1f8e07 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -25,6 +25,14 @@
 #include "qemu/module.h"
 #include "hw/misc/sifive_u_otp.h"
 
+#define WRITTEN_BIT_ON 0x1
+
+#define SET_FUSEARRAY_BIT(map, i, off, bit)    \
+    map[i] = bit ? (map[i] | bit << off) : (map[i] & ~(bit << off))
+
+#define GET_FUSEARRAY_BIT(map, i, off)    \
+    ((map[i] >> off) & 0x1)
+
 static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
 {
     SiFiveUOTPState *s = opaque;
@@ -123,7 +131,24 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
         s->ptrim = val32;
         break;
     case SIFIVE_U_OTP_PWE:
-        s->pwe = val32;
+        s->pwe = val32 & SIFIVE_U_OTP_PWE_EN;
+
+        /* PWE is enabled. Ignore PAS=1 (no redundancy cell) */
+        if (s->pwe && !s->pas) {
+            if (GET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Error: write idx<%u>, bit<%u>\n",
+                              s->pa, s->paio);
+                break;
+            }
+
+            /* write bit data */
+            SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
+
+            /* update written bit */
+            SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
+        }
+
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%" HWADDR_PRIx
@@ -165,6 +190,9 @@ static void sifive_u_otp_reset(DeviceState *dev)
     /* Make a valid content of serial number */
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+
+    /* Initialize write-once map */
+    memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
 }
 
 static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/misc/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
index 82c9176c8f..ebffbc1fa5 100644
--- a/include/hw/misc/sifive_u_otp.h
+++ b/include/hw/misc/sifive_u_otp.h
@@ -36,6 +36,8 @@
 #define SIFIVE_U_OTP_PTRIM      0x34
 #define SIFIVE_U_OTP_PWE        0x38
 
+#define SIFIVE_U_OTP_PWE_EN     (1 << 0)
+
 #define SIFIVE_U_OTP_PCE_EN     (1 << 0)
 
 #define SIFIVE_U_OTP_PDSTB_EN   (1 << 0)
@@ -75,6 +77,7 @@ struct SiFiveUOTPState {
     uint32_t ptrim;
     uint32_t pwe;
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
+    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
 };
-- 
2.17.1


