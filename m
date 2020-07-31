Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B215FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 02:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4BB2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 02:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="O3VtvxF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4BB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1L6E-0002LP-QA
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 22:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k1L5V-0001QZ-R7
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 22:48:01 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1k1L5T-0003sB-VS
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 22:48:01 -0400
Received: by mail-pl1-x642.google.com with SMTP id o1so16048818plk.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 19:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1JnB4YudV1m077cp66xzMnx1Junj30UO75iLbZUf12Y=;
 b=O3VtvxF2kxDrdqYV/12D8cnKeQ1yEDEwKTFLium7I6T2GURjMtrhihwq9xjepTDQwj
 Frgvsp+XMw6EANBKjCR6X5M5unY9Jti39+mRmo+UtKG/Wb0dc5uSapzBnRh5QjQXTT6T
 yKwghLzb6c0m4eaj6EfUuRQaRt3VOSYUcUmChUiY/HkPCEkqX92lGfq9CiXnFKEt++bd
 LdcHHGNmdx35TzpUt13NcGZI3s3FYLRl3S0NCLhnUyM9n06Mq7FN/+lN5ptB5vMNKace
 rY9OGYMYJjy6MhPLwCoGcOk6UUWwSxRHAioOHkBhgby8lx9rEl/XkEmleOvvz4mkn8Hh
 cKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1JnB4YudV1m077cp66xzMnx1Junj30UO75iLbZUf12Y=;
 b=s1l/whvTiTGRBcr3XyOYe5tdEYJYnrjpcauSweVE4brJVUK+kETM5hVZZy+oaUUNzW
 W8WmXebU4a2BJKZMaUAPKhjn1XnUh99ot8CqmsvUMWLEO4IhRk62fPwd4amnk3ac5/83
 OvIOhlBhEF9vrPju0aJF4/GEiLnMLNN+fJQrE955xKIqLXEQbmZkhBlFGIXINQY4AQo7
 xDylMX0yy3H818XEz3RT9b63/bpkpbSjoBglUBZ+YBG3cdRKKGu45AqIx6OnkTezVXRA
 MX4g62oImmPwZ39/2yNHCzMx3C8VbMqUt5wMKlN7s3MYJefZqttaKF6c89wV9wYrNW42
 agmg==
X-Gm-Message-State: AOAM531HWWD6nfSF8TrCNWcU3TwIfwDyoV3vQ9k7Ot0gbfncgHX8qDK3
 gEMcFMhNxGEjz06P1gd/MRkcYA==
X-Google-Smtp-Source: ABdhPJzxLVssuc0Cm1KqNN+d3BB94LMk9TxwvkPxAGuUUSdXO6Bnk1ft08yLVGq90bruwIqNuV+uog==
X-Received: by 2002:a17:90a:22a3:: with SMTP id
 s32mr2027720pjc.49.1596163678573; 
 Thu, 30 Jul 2020 19:47:58 -0700 (PDT)
Received: from localhost.localdomain (111-243-189-249.dynamic-ip.hinet.net.
 [111.243.189.249])
 by smtp.gmail.com with ESMTPSA id c27sm7578483pfj.163.2020.07.30.19.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 19:47:58 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v2 2/2] hw/riscv: sifive_u: Add write-once protection.
Date: Fri, 31 Jul 2020 10:47:08 +0800
Message-Id: <20200731024708.32725-3-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731024708.32725-1-green.wan@sifive.com>
References: <20200731024708.32725-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=green.wan@sifive.com; helo=mail-pl1-x642.google.com
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

Add array to store the 'written' status for all bit of OTP to block
the write operation to the same bit. Ignore the control register
offset from 0x0 to 0x38 of OTP memory mapping.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/riscv/sifive_u_otp.c         | 20 ++++++++++++++++++++
 include/hw/riscv/sifive_u_otp.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
index e359f30fdb..a793093d47 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -35,6 +35,11 @@
 
 #define TRACE_PREFIX            "FU540_OTP: "
 #define SIFIVE_FU540_OTP_SIZE   (SIFIVE_U_OTP_NUM_FUSES * 4)
+#define SET_WRITTEN_BIT(map, idx, bit)    \
+    (map[idx] |= (0x1 << bit))
+
+#define GET_WRITTEN_BIT(map, idx, bit)    \
+    ((map[idx] >> bit) & 0x1)
 
 static int32_t sifive_u_otp_backed_open(const char *filename, int32_t *fd,
                                         uint32_t **map)
@@ -195,6 +200,18 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
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
         /* open and mmap OTP image file */
         if (0 == sifive_u_otp_backed_open(s->otp_file, &fd, &map)) {
             /* store value */
@@ -248,6 +265,9 @@ static void sifive_u_otp_reset(DeviceState *dev)
     /* Make a valid content of serial number */
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+
+    /* Initialize write-once map */
+    memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
 }
 
 static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
index f3d71ce82d..4c6ac2e75e 100644
--- a/include/hw/riscv/sifive_u_otp.h
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -73,6 +73,7 @@ typedef struct SiFiveUOTPState {
     uint32_t ptrim;
     uint32_t pwe;
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
+    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
     char *otp_file;
-- 
2.17.1


