Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDEEC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB8F20786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="B41J3jCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB8F20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCdV-0001q7-5m
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 03:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kBCci-0000SP-U2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:47:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kBCch-0008IX-8D
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 03:47:04 -0400
Received: by mail-pf1-x444.google.com with SMTP id u20so2867892pfn.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c2pBcp/mbPtnLHyvPGQngbikpywJkc4V5//cOK1jHUU=;
 b=B41J3jCjLolFLLB8OysyMPhtaZUxNKijGltGIm1kNGbQbrBgcuLeSHhKIDZXmyElQ/
 ggVn1+ca2POnsK3rnlsrrnspF0CKVvM0DF9T48hSe6LJ+S0JjQKzY+L3NnbYa9VYj6B7
 VXZrRvo+BxzuoEB4DE+3aK0HmFyrF2ECOKzO9M4R1A1HAixOtsSg2GVAQkXSH+MNx49x
 XQTGkH2a5IGI8zMr/3vobseKhNczB3rKIm5eCYWL/W6F+gDQTePfpyzYXMLcJ7MV7pU3
 HmBDNEgyeikFsG/doLDBj8OAjUsQxinqzwzf1lsZjgw6tBviFuBo3CBxa+ZoOBQrLKBn
 /8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c2pBcp/mbPtnLHyvPGQngbikpywJkc4V5//cOK1jHUU=;
 b=WqN1S2D9SAQspUyJy3sBnFfz4pUNGsg19DJfkLdGg5RcldOMA4O/9BH/IuxvDLaqzr
 UW91smP5YAbVqZOjdieoGHtaC3NSgjv0065y5Cc0k2qrM/F5IDSA4LhAC9J8NDvsqJZ/
 UsuTyjX5YL/86GjXFB0i0updP+7mvw1OStYSic3Vnz7NE4JkTtJtJ7Kf9TPgxElADKeF
 UTkpSNa4ACxmwKJZ//nEt+Cac3GbWAxPSvN8nllroHgaCXI/s+Ksw4y6UhyZRh/3jwsu
 qGhNKf5a/OBjiiQom0EcrbhgNKojMq78CDHzdAW3dXErHep2NFkVoCJ0a34GwzPSUosz
 cTqA==
X-Gm-Message-State: AOAM532x+5V+lVLTmrWvzQYaOH9+USVJ8VwqEcU6ejf+9q31SbXUhHwn
 Z3VuRJoZm+EnVUHS/HmUyDozgQ==
X-Google-Smtp-Source: ABdhPJxuUOqhfyXURZWLXW9IXqc+OgpTUFD6kalyDP5WnrGHnjQcs4yBxRa5WhDTifwR2hiwjIwLNA==
X-Received: by 2002:a17:902:a412:: with SMTP id
 p18mr15192445plq.3.1598514421952; 
 Thu, 27 Aug 2020 00:47:01 -0700 (PDT)
Received: from localhost.localdomain (111-241-121-209.dynamic-ip.hinet.net.
 [111.241.121.209])
 by smtp.gmail.com with ESMTPSA id k17sm431032pfg.99.2020.08.27.00.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 00:47:01 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v4 2/2] hw/riscv: sifive_u: Add write-once protection
Date: Thu, 27 Aug 2020 15:46:38 +0800
Message-Id: <20200827074638.21451-3-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827074638.21451-1-green.wan@sifive.com>
References: <20200827074638.21451-1-green.wan@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=green.wan@sifive.com; helo=mail-pf1-x444.google.com
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

Add array to store the 'written' status for all bit of OTP to block
the write operation to the same bit. Ignore the control register
offset from 0x0 to 0x38 of OTP memory mapping.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 hw/riscv/sifive_u_otp.c         | 21 +++++++++++++++++++++
 include/hw/riscv/sifive_u_otp.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
index aab2220494..e9605b9ae9 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/riscv/sifive_u_otp.c
@@ -27,6 +27,12 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
 
+#define SET_WRITTEN_BIT(map, idx, bit)    \
+    (map[idx] |= (0x1 << bit))
+
+#define GET_WRITTEN_BIT(map, idx, bit)    \
+    ((map[idx] >> bit) & 0x1)
+
 static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
 {
     SiFiveUOTPState *s = opaque;
@@ -135,6 +141,18 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
         s->ptrim = val32;
         break;
     case SIFIVE_U_OTP_PWE:
+        /* Keep written state for data only and PWE is enabled. Ignore PAS=1 */
+        if ((s->pa > SIFIVE_U_OTP_PWE) && (val32 & 0x1) && !s->pas) {
+            if (GET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Error: write idx<%u>, bit<%u>\n",
+                              s->pa, s->paio);
+                break;
+            }
+
+            SET_WRITTEN_BIT(s->fuse_wo, s->pa, s->paio);
+        }
+
         /* write to backend */
         if (s->blk) {
             blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &val32,
@@ -215,6 +233,9 @@ static void sifive_u_otp_reset(DeviceState *dev)
     /* Make a valid content of serial number */
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
     s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+
+    /* Initialize write-once map */
+    memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
 }
 
 static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
index 13d2552e43..49d40a6430 100644
--- a/include/hw/riscv/sifive_u_otp.h
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -74,6 +74,7 @@ typedef struct SiFiveUOTPState {
     uint32_t ptrim;
     uint32_t pwe;
     uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
+    uint32_t fuse_wo[SIFIVE_U_OTP_NUM_FUSES];
     /* config */
     uint32_t serial;
     BlockBackend *blk;
-- 
2.17.1


