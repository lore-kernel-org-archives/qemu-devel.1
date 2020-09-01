Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BB3C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02CB204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ks019DCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02CB204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8rM-0006mS-03
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kD8Vb-0002Bz-LZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:47:43 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kD8VZ-00026R-36
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:47:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id l9so726256plt.8
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0/OBga6Pud+l6WfxON34v/AXQ0F318WR/QNf6Dv2RV0=;
 b=ks019DCLRzqaulhwBcSJ9GCTtLQ4eU9e+7whdEyDyeGwMMzphHoZGmyoI1sKxVc9va
 Rb+Mqwe2S1hRgBLvXHBJwAps1i+Cb/DsHMFAsA1WrJvkxNKfGasN5JCIwhxuFYA+DQKk
 8NsU5vjr/oaW+GzT4cEbFDUFD5XFKjuufQ5ygyWiPnU2YbzTXDgFd6uIcP7AN/9Uy8tG
 1lvPvY4r0Q15UUxjogWsmXTBJSRFuDdrEAmfTqVr9RlhU47Se43Iu6rcHFUrso/JARVj
 r1hGnGLUO2VpTOy7To72XxS+/YV4QSwNwTzyorwgwqeX357KZA86AmyZolgBEm6RyZXa
 AiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0/OBga6Pud+l6WfxON34v/AXQ0F318WR/QNf6Dv2RV0=;
 b=LPzCpyesIJmC3+eQ4cB0cQx6535pgPFp9156b4PAo/jdTPL758Jls3cERxtAumeiAE
 O7mLa1uIVCGxWdeUNTg6RDJZS330Zn3l2aDoMh7UEE6lcwncyHdFO9jtHnSNYI41UWOW
 5Bo8MamJqQZI04yWy88WVKijKjapFGFh3xbSDzpxv9pbqozIj6rEegQ6kNJ7YjpToox1
 hG4FTVNShFEFoMjUtPfD+clrz7FsgSw8mLP4yQXkZT9vzsdBAluXx3KqM/iNGe6DqJFE
 Dlhpun4zCCAwwuCf76p7HQ3nDEsUs5q8twn5ajBVkZG4N7MGCvcWq/hDF7RRXAyT156w
 d5dw==
X-Gm-Message-State: AOAM532qLACUFTPKUeGvKsC/w6SCGpCi6H6EXFql0Torp1ybIBztoNz5
 p0oxcDzZiEhYzzq4HgH2pzaAwA==
X-Google-Smtp-Source: ABdhPJxvyq1BEE9pLCJUhcLnbrHVLg4cZTaAXYJCjO+xxS5aJ0qqfhc89fGfUOOxnDvl0/kun1E0bQ==
X-Received: by 2002:a17:90a:fb52:: with SMTP id
 iq18mr2140544pjb.207.1598975259698; 
 Tue, 01 Sep 2020 08:47:39 -0700 (PDT)
Received: from localhost.localdomain (111-241-104-82.dynamic-ip.hinet.net.
 [111.241.104.82])
 by smtp.gmail.com with ESMTPSA id e17sm2485344pfm.60.2020.09.01.08.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:47:39 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v5 1/2] hw/riscv: sifive_u: Add write operation and
 write-once protection
Date: Tue,  1 Sep 2020 23:47:10 +0800
Message-Id: <20200901154711.18457-2-green.wan@sifive.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

 - Add write operation to update fuse data bit when PWE bit is on.
 - Add array, fuse_wo, to store the 'written' status for all bits
   of OTP to block the write operation.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/riscv/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/riscv/sifive_u_otp.h |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
index f6ecbaa2ca..b8369e9035 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -25,6 +25,14 @@
 #include "qemu/module.h"
 #include "hw/riscv/sifive_u_otp.h"
 
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
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
index 639297564a..4a5a0acf48 100644
--- a/include/hw/riscv/sifive_u_otp.h
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -35,6 +35,8 @@
 #define SIFIVE_U_OTP_PTRIM      0x34
 #define SIFIVE_U_OTP_PWE        0x38
 
+#define SIFIVE_U_OTP_PWE_EN     (1 << 0)
+
 #define SIFIVE_U_OTP_PCE_EN     (1 << 0)
 
 #define SIFIVE_U_OTP_PDSTB_EN   (1 << 0)
@@ -73,6 +75,7 @@ typedef struct SiFiveUOTPState {
     uint32_t ptrim;
     uint32_t pwe;
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
+    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
 } SiFiveUOTPState;
-- 
2.17.1


