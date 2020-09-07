Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8DC2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F08206B5
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXN95DMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F08206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLYe-0008IU-Rq
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVu-0003kr-Bn
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:36271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVp-0002NP-O5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id k13so2794087plk.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BV7UzgSMM3A3H8QtCGnB/gl3FBbCJtYPNUPwgrX+UHQ=;
 b=sXN95DMJNz/SuqFVAmT0QvAY8b1QhUoEQyTSScvyvZOrbOg2BxiM8cyHrDtiwezM9O
 /aiVDDcHsjNzIBjHo7h4lcOCMYk2r03aZk+oTYLEZtjeesItby7qdtOwsP+XuHi5tYc2
 OUlhEno8mpkKLvBmZ1/bSnS20SLw65QYyJMUzJ/KsIXJ/DpKEr5JJmskJKtqLDkkmwvx
 dDrVUY9xzx+aaFyyulCGcdckTzXB1JtG3oZwLxLBa9w+dLR8ltsBMoIKdqdzq3GofDQW
 XF2VKEnboJVX11HBXDuPyAjYk3F7qANsyBrKgQPuB1XSFWtBnq8RWEwzasEvQZXEe2BJ
 npBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BV7UzgSMM3A3H8QtCGnB/gl3FBbCJtYPNUPwgrX+UHQ=;
 b=NqylOlHTZoGiLnaxZ3KZV8IbhK/q1a9X53bcjSEWb2NGMSZcJyMFFgaVfK+1qJtSwf
 FHeQXACSPXuvgqYfkNm+r0HEr2uN01uFGgCplMo7SujIDFryP+fXJMkSw5PDFwwSi/4B
 JFJojXqJBFg4337SVoCdI+gVgE5AEuToCVQFcIk1hopikZc2J7mTpHt/Ev7EHRDC3LMr
 7woJHM2YTy0TbV4aWYMoFXkQSlk/kflawoUgK8zgUvz92qDH9m3W+qlFtbkmnfPFex7r
 OAaNultAfjKenMnMoqEVsv0+Q/EFkCkKulyr5QPIg66jY9WByfe68idS3/ajTMnkHPwn
 7MSA==
X-Gm-Message-State: AOAM533yMRxTmtdQqpv3Ea+Y3qpZPAvU9CHpabHuhIsU4m+2JlqQkvLq
 2LbCoESlJgRoI36UzHB0tKPlD9xN7J7zxQ==
X-Google-Smtp-Source: ABdhPJwavj8eNmRDTI44lGjzX74kssBWPrdxH9jGbO2ZS5B/phOGsd7Eyn81hzkpsEM7m69a71nMKA==
X-Received: by 2002:a17:90a:930e:: with SMTP id
 p14mr421362pjo.49.1599501903898; 
 Mon, 07 Sep 2020 11:05:03 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm11367768pfi.38.2020.09.07.11.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 11:05:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] target/microblaze: Split out MicroBlazeCPUConfig
Date: Mon,  7 Sep 2020 11:04:52 -0700
Message-Id: <20200907180459.29025-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907180459.29025-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
 <20200907180459.29025-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This struct was previously unnamed, and defined in MicroBlazeCPU.
Pull it out to its own typedef so that we can reuse it.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 55 ++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 20c2979396..59d2a079c4 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -291,6 +291,34 @@ struct CPUMBState {
     } pvr;
 };
 
+/*
+ * Microblaze Configuration Settings
+ */
+typedef struct {
+    bool stackprot;
+    uint32_t base_vectors;
+    uint8_t addr_size;
+    uint8_t use_fpu;
+    uint8_t use_hw_mul;
+    bool use_barrel;
+    bool use_div;
+    bool use_msr_instr;
+    bool use_pcmp_instr;
+    bool use_mmu;
+    bool dcache_writeback;
+    bool endi;
+    bool dopb_bus_exception;
+    bool iopb_bus_exception;
+    bool illegal_opcode_exception;
+    bool opcode_0_illegal;
+    bool div_zero_exception;
+    bool unaligned_exceptions;
+    uint8_t pvr_user1;
+    uint32_t pvr_user2;
+    char *version;
+    uint8_t pvr;
+} MicroBlazeCPUConfig;
+
 /**
  * MicroBlazeCPU:
  * @env: #CPUMBState
@@ -305,32 +333,7 @@ struct MicroBlazeCPU {
 
     CPUNegativeOffsetState neg;
     CPUMBState env;
-
-    /* Microblaze Configuration Settings */
-    struct {
-        bool stackprot;
-        uint32_t base_vectors;
-        uint8_t addr_size;
-        uint8_t use_fpu;
-        uint8_t use_hw_mul;
-        bool use_barrel;
-        bool use_div;
-        bool use_msr_instr;
-        bool use_pcmp_instr;
-        bool use_mmu;
-        bool dcache_writeback;
-        bool endi;
-        bool dopb_bus_exception;
-        bool iopb_bus_exception;
-        bool illegal_opcode_exception;
-        bool opcode_0_illegal;
-        bool div_zero_exception;
-        bool unaligned_exceptions;
-        uint8_t pvr_user1;
-        uint32_t pvr_user2;
-        char *version;
-        uint8_t pvr;
-    } cfg;
+    MicroBlazeCPUConfig cfg;
 };
 
 
-- 
2.25.1


