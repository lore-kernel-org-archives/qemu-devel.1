Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1843C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143AB22453
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UNeCv3KT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143AB22453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUiUN-0002P0-Uk
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 23:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kUiTB-000124-8t
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 23:37:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:33788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kUiT9-0005ri-Go
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 23:37:52 -0400
Received: by mail-pl1-x636.google.com with SMTP id b19so267324pld.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 20:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZP0P1YsDvhVLDnigTxcAr9bHNAEed+EOs9ZCHTy6oW4=;
 b=UNeCv3KTmdKm1whUsrV5w9u6rgdnSKwi6+EwtUyPfoh8j47ILXt3HMqUeXTxXHv0Zd
 jaTHnczn9oOEmCNzhkuf5jaZwkjeDPmoBJJkyMDW5eVlHikjEEqcw3+IIaQBkmMHvxnZ
 e49M8jGb/gp2FBQVhDj/T9MweqB5DCod17s4Lhy94DVhLYGJbV2vih84bVT4DCc4ktbX
 QI2XLlO0FeoC/a/INw6gkqZjEjbJSjCygPhLmg6JTAgxIB56wA/mi6nSyXZbmwiOfdpS
 jGehgujXKk8BW9QgAKacXn/p83AK8tEBWu8RwOLPEV08m8iN8uAcWxMCWUW5uXErU8zP
 PiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZP0P1YsDvhVLDnigTxcAr9bHNAEed+EOs9ZCHTy6oW4=;
 b=tG0UWNCFz7BwQJ19ScRzaafL7ZeCb650iwdinrzhHCdLD92up4LFaUsHxxHNIr25/d
 22TZocWZkDmc7d54zIzsdwOuxpbnulZMfE855d3pOGSfRjRl0KWkpgL0nRsx9BZx2fho
 erPaltNdlRRXWsiRBoAmO4wpqMTp3ssG8oW//wW/MXetGqgkXMOGTmr3STnD9ujEZs4A
 +I4yZ1nLzjEvIfcXj5keIoDfPM5oNncZ1hCZAzZyz6A9kjHhVdiY1SgTU/yVFTa3dkUB
 we63wB2zzQihiNZOHSH3bXmIjGwR/U1fnkQ7Dv0pXvb0zJwHu29ThykQ+WeEYfeBpByw
 A9lA==
X-Gm-Message-State: AOAM533Ryql8iBhetj+Y7pdxJd3IEm9S9Nz+5BYFl7vA07rSxC6QwKVD
 yRSwAAdFJ45eGuGmRlEaKHLHAhKt+G0AiA==
X-Google-Smtp-Source: ABdhPJzE+bXKiNVWDVnI6kAWlKNSVHF3eJmNoGR4UZypKQ4GUThjQWsZarP6CloXbnJQw24LrifxIA==
X-Received: by 2002:a17:902:a40a:b029:d5:a7d7:4ea0 with SMTP id
 p10-20020a170902a40ab02900d5a7d74ea0mr975262plq.9.1603165069809; 
 Mon, 19 Oct 2020 20:37:49 -0700 (PDT)
Received: from localhost.localdomain (111-243-184-51.dynamic-ip.hinet.net.
 [111.243.184.51])
 by smtp.gmail.com with ESMTPSA id gd14sm260489pjb.31.2020.10.19.20.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 20:37:49 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [PATCH v8 1/2] hw/misc/sifive_u_otp: Add write function and
 write-once protection
Date: Tue, 20 Oct 2020 11:37:31 +0800
Message-Id: <20201020033732.12921-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020033732.12921-1-green.wan@sifive.com>
References: <20201020033732.12921-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=green.wan@sifive.com; helo=mail-pl1-x636.google.com
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, green.wan@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 - Add write operation to update fuse data bit when PWE bit is on.
 - Add array, fuse_wo, to store the 'written' status for all bits
   of OTP to block the write operation.

Signed-off-by: Green Wan <green.wan@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
---
 hw/misc/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/misc/sifive_u_otp.h |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index c2f3c8e129..b9238d64cb 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -25,6 +25,14 @@
 #include "qemu/module.h"
 #include "hw/misc/sifive_u_otp.h"
 
+#define WRITTEN_BIT_ON 0x1
+
+#define SET_FUSEARRAY_BIT(map, i, off, bit)    \
+    map[i] = bit ? (map[i] | bit << off) : (map[i] & ~(0x1 << off))
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
+                              "write once error: idx<%u>, bit<%u>\n",
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


