Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E927CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DCE2053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwkhA2J1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DCE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OYR-0005pw-Ut
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4KsN-0000j7-VT; Sat, 08 Aug 2020 05:10:51 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ethan.lee.qnl@gmail.com>)
 id 1k4KsM-0000b0-CM; Sat, 08 Aug 2020 05:10:51 -0400
Received: by mail-pj1-x1044.google.com with SMTP id l60so2169996pjb.3;
 Sat, 08 Aug 2020 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MW3DZaA0cPRetzOJHOEnr2p1Qwr/h9P0QQbQ/RWFC4M=;
 b=YwkhA2J1SX43I8x94fuarPMxS/+hhO+8DOjSPyHAfraBQ76yynR3uzeQqVhbLqvEme
 E22AiSLD/Va4gCahWrwA86hxhII+NvF8mFf06kLhIGXJnYJHdFv0D387LquNaJV456gM
 tDnY/ilt9ss3kg5XS9AbLh8dXAzpkq+F9zpb9a7P0zZrKU/PKdcC9KZ2f5KmL7azd/pr
 uonm47YKgn6AW9aBr63egVz6vFORQkKxR5trs7H8IcQyGGC3+NwwO6XziRwk1uksWQkr
 v/KfyH/533szE2esGPy9rthpZUu8E0fCwzZF/vKTSR9GvHHM5nh71VaZCaFgHQqROX4m
 ToVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MW3DZaA0cPRetzOJHOEnr2p1Qwr/h9P0QQbQ/RWFC4M=;
 b=VBGGsYBgzZ/bYeQFqxOWVLZhee/vXp63txxzOTTHLCm2xJEIKhkeiZmFwmZ2HmJg9A
 yzqt3nNCwqNTzzx1Q/vix2MTWrSYn0jOH9PmSza7untgCTOVCgH02pzdPSRFOVFsb4rV
 gTQwmcvjdINxpx6Ez88CxXlb3hX5c72rrQ2lVpYqldLo8QuZODkWPr8k0e57hfgVTR+b
 Jnc/f6D4/G4fi5dbJ8H4KwJ3BRTuszMKMvw7nng1FfL9QZEKVhnSapDG27lHma2VRuYg
 +C1NtxqXny2KGncdIwFwkcyKpo6G3JwCLLSSas7lcCqAKeywbjfWUX6RBmLGO2bWExYD
 3cEA==
X-Gm-Message-State: AOAM530eP0LqQxgpoHuvYKEiJ3XUUFEO2PqZ39tjrjZXMb5sdu51wdWP
 9gEJRQrHskSkpOfmDOr+mIMnkEwLCaW3Ew==
X-Google-Smtp-Source: ABdhPJzrynnq8jldIm7Q6LT8BQy/kVoB9DH/LzIHVNqXddCjx0mP5C5+cwgixXVu7CrTMI9EJNZpHw==
X-Received: by 2002:a17:90a:d081:: with SMTP id
 k1mr17196543pju.177.1596877848631; 
 Sat, 08 Aug 2020 02:10:48 -0700 (PDT)
Received: from localhost.localdomain (183178047145.ctinets.com.
 [183.178.47.145])
 by smtp.gmail.com with ESMTPSA id i11sm13312700pjv.30.2020.08.08.02.10.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Aug 2020 02:10:48 -0700 (PDT)
From: Hongzheng-Li <ethan.lee.qnl@gmail.com>
X-Google-Original-From: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/4] Define ePMP mseccfg
Date: Sat,  8 Aug 2020 17:09:47 +0800
Message-Id: <20200808090950.13-2-Ethan.Lee.QNL@gmail.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200808090950.13-1-Ethan.Lee.QNL@gmail.com>
References: <20200808090950.13-1-Ethan.Lee.QNL@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=ethan.lee.qnl@gmail.com; helo=mail-pj1-x1044.google.com
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
X-Mailman-Approved-At: Sat, 08 Aug 2020 08:59:47 -0400
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
Cc: Hou Weiying <weiying_hou@outlook.com>, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, Hongzheng-Li <Ethan.Lee.QNL@gmail.com>,
 Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Myriad-Dreamin <camiyoru@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Weiying <weiying_hou@outlook.com>

Currently using 0x390 and 0x391 for x-epmp (experimental). This may change in the future spec.

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
---
 target/riscv/cpu_bits.h | 3 +++
 target/riscv/gdbstub.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7f64ee1174..9a8a6be534 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -214,6 +214,9 @@
 #define CSR_MTINST          0x34a
 #define CSR_MTVAL2          0x34b
 
+/* Enhanced PMP */
+#define CSR_MSECCFG         0x390
+#define CSR_MSECCFGH        0x391
 /* Physical Memory Protection */
 #define CSR_PMPCFG0         0x3a0
 #define CSR_PMPCFG1         0x3a1
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index eba12a86f2..de5551604a 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -132,6 +132,8 @@ static int csr_register_map[] = {
     CSR_MIP,
     CSR_MTINST,
     CSR_MTVAL2,
+    CSR_MSECCFG,
+    CSR_MSECCFGH,
     CSR_PMPCFG0,
     CSR_PMPCFG1,
     CSR_PMPCFG2,
-- 
2.20.1


