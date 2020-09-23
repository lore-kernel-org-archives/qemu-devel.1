Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD940C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AFB214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaQspzgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AFB214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1H4-0001mg-Eh
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kL1E7-0007Ep-OV
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:38:16 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:34456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kL1E6-0006CT-1s
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:38:15 -0400
Received: by mail-pj1-x1035.google.com with SMTP id s14so2478280pju.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 02:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GZk30ThLdHALGmw0nh8iMQ4L+TX2pxT4pTob5NEe5gc=;
 b=BaQspzgnr9JwWaK8ox9MuISQqCHfhS49dpuyfG/Jgft3AN5VVrUL0IOeh6fS4z5VAu
 /nA7mLyVOPRQEx9X/sorAVfh/D1wbSPjot3WGBKWuKoEZ/dgP18kfQmj2LF+KuyUwZVy
 n4wsZDiAm75g2XEljQO1oRi4zaio+jFPM3svyIQntSka8FulEFz4jzB+sXS/rlOlg/RR
 Oxa6ZY5wonYLfeuUydR/6/3lTp5VQZ+kYyrok9krw9na5naMODo2zDCmweWveynpTe4W
 Z3gUkmArTc+KGivtNOE2wtd4ZmlRhTrequvFLZpJ+VGwy4St1SccURwj3iX+iQKm8gf/
 KQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GZk30ThLdHALGmw0nh8iMQ4L+TX2pxT4pTob5NEe5gc=;
 b=k0ryvqadbPJsbpb1nOFYUIWDA5GhxvYyQM3+Jn4g588VfZrzaV/f2ZtYonZooEhcQG
 WWM8Qak9AvcECWhM9FXi53Vj6LH16mCtjSeFwap114+Hr+5uitbz1LebP84ENGA18z8U
 aZ24k5YpuhrGpVJ61OZlEnYVxkeWTeFbBb0WiGzkO+orCU1OfrMjc670QcduOeuh+VQH
 NeQR7NvY5pEAWBTm+zEft2eOEzcv1mbCgxe/CXHvZLy3E0Jyef6CfvSOGj2Ztx4dHjaq
 MY4ZrV5w23AUIo7eGqZ6l77td+/mcgI42WsriCVm3RHAFFV2rYweFr3CmZDOMvFYWOCg
 dUcQ==
X-Gm-Message-State: AOAM531DQ60wtIFR/BjgjMbyXik4vwgVVh+xczG8RCDPHYpAHUhDoGMg
 ywB22jO/GX9e6cHukSjA2Cak+WTfiMyOXQ==
X-Google-Smtp-Source: ABdhPJzCgmvcUphKpg/nz9MM31VrFdBa6zvwMbnAKg6FaDrVxP45FMx9WEEsGaYn5LOccueLCyas7g==
X-Received: by 2002:a17:902:8545:b029:d1:f2e3:8dd4 with SMTP id
 d5-20020a1709028545b02900d1f2e38dd4mr8825242plo.65.1600853891249; 
 Wed, 23 Sep 2020 02:38:11 -0700 (PDT)
Received: from carbon.loongson.cn ([47.91.219.17])
 by smtp.gmail.com with ESMTPSA id i8sm4431903pjv.43.2020.09.23.02.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 02:38:10 -0700 (PDT)
From: Kele Huang <kele.hwang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] accel/tcg: Fix computing of is_write for mips
Date: Wed, 23 Sep 2020 17:38:00 +0800
Message-Id: <20200923093800.9845-1-kele.hwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <503406>
References: <503406>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=kele.hwang@gmail.com; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Xu Zou <iwatchnima@gmail.com>, Kele Huang <kele.hwang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Detect mips store instructions in cpu_signal_handler for all MIPS
versions, and set is_write if encountering such store instructions.

This fixed the error while dealing with self-modifed code for MIPS.

Signed-off-by: Kele Huang <kele.hwang@gmail.com>
Signed-off-by: Xu Zou <iwatchnima@gmail.com>
---
 accel/tcg/user-exec.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index bb039eb32d..18784516e5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -710,11 +710,60 @@ int cpu_signal_handler(int host_signum, void *pinfo,
     greg_t pc = uc->uc_mcontext.pc;
     int is_write;
 
-    /* XXX: compute is_write */
     is_write = 0;
+
+    /* Detect store by reading the instruction at the program counter. */
+    uint32_t insn = *(uint32_t *)pc;
+    switch(insn>>29) {
+    case 0x5:
+        switch((insn>>26) & 0x7) {
+        case 0x0: /* SB */
+        case 0x1: /* SH */
+        case 0x2: /* SWL */
+        case 0x3: /* SW */
+        case 0x4: /* SDL */
+        case 0x5: /* SDR */
+        case 0x6: /* SWR */
+            is_write = 1;
+        }
+        break;
+    case 0x7:
+        switch((insn>>26) & 0x7) {
+        case 0x0: /* SC */
+        case 0x1: /* SWC1 */
+        case 0x4: /* SCD */
+        case 0x5: /* SDC1 */
+        case 0x7: /* SD */
+#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
+        case 0x2: /* SWC2 */
+        case 0x6: /* SDC2 */
+#endif
+            is_write = 1;
+        }
+        break;
+    }
+
+    /*
+     * Required in all versions of MIPS64 since MIPS64r1. Not available
+     * in MIPS32r1. Required by MIPS32r2 and subsequent versions of MIPS32.
+     */
+    switch ((insn >> 3) & 0x7) {
+    case 0x1:
+        switch (insn & 0x7) {
+        case 0x0: /* SWXC1 */
+        case 0x1: /* SDXC1 */
+            is_write = 1;
+        }
+        break;
+    }
+
     return handle_cpu_signal(pc, info, is_write, &uc->uc_sigmask);
 }
 
+#elif defined(__misp16) || defined(__mips_micromips)
+
+#error "Unsupported encoding"
+
 #elif defined(__riscv)
 
 int cpu_signal_handler(int host_signum, void *pinfo,
-- 
2.17.1


