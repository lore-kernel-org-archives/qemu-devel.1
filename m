Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC2C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D7220684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zex+DPqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D7220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHDe-0007dB-4c
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH56-0001oz-TC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:04 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH55-0000pK-4V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id o20so5107061pfp.11
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XwF8rh/HiJftrU6kWorHEFCZRvIfR8zgWMSMwHATuFY=;
 b=Zex+DPqrIiCBqfQzJ8cVXtYlmhJ+/4vwYa/f2ZhtfwI/5rUxho5shXuUY2rhK774H1
 DcSlHAo8o8DYsdJr7Cfnce+2TeZfp4PnAqUPuuuVhlJi2G7k3hRx+/CTOuYqh/TL8Hmm
 JoiMbjxEKyx+8CU8FQ3syWOkKI57AEv5tzmeWpYezQncO2L9puUKMkrHaktXICCYtTaF
 AxHjEWBfK8p4IDoCEr5ZvTOhVAxGHV5uT4YCT10WZVIODKVUfqLGfSp9t2ib7Bmi1/98
 KD6qB+ylQXO1yFSviIOGI97qp12i69QgaVkC8LtScVr7Kc0xedN67duuhWhF86s45lkc
 hUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XwF8rh/HiJftrU6kWorHEFCZRvIfR8zgWMSMwHATuFY=;
 b=NRhRpafqWCNOMaJQtC2D0rkujc4tpf/Mn0uL7GlM13p08ilwwLrthbqqIK5Eu0Ytyh
 PBzXSKBykBa9qW/ViUEFQM6agI2BQliZ1TsvdJIYX4ZsDV8qRKYIhLrZ6GmVh2iuuBxk
 mrOLqVmsHg+633Jc+dDt0UmkDPIgr9o3bwsCB4BgoIZ2eaCzcHDAGp0LQrLQ7wXyuSHW
 oi0v/5yt3kRJ8jzj8nH38WSQMIhv4gTnDgg1/ZPFykilBFGW/urS1GkPPcdZWRKv0oMK
 G/hG3yw5pd3vI8wIsVHYNIbLKUEAQID+c9iYD2i1xql/H7mUTMxLEwu/zGw4JIpEnUx8
 555g==
X-Gm-Message-State: AOAM532UxU3GPSAoI1x/FPrFDADhgYtDM/V4OFUxBPyyDgcP3ravzewl
 IAv/5mavROle7i9ztakmNgkaNtUhxYnHSQ==
X-Google-Smtp-Source: ABdhPJzFwCMD95ZNEVTIkCrM/YzYoamv760nsTAIUyHgsMWVtMywrwCpRWCYsV9pZey4imREt6DYuA==
X-Received: by 2002:a63:d4a:: with SMTP id 10mr1736833pgn.175.1599246541501;
 Fri, 04 Sep 2020 12:09:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:09:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/19] target/microblaze: Split out MicroBlazeCPUConfig
Date: Fri,  4 Sep 2020 12:08:35 -0700
Message-Id: <20200904190842.2282109-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This struct was previously unnamed, and defined in MicroBlazeCPU.
Pull it out to its own typedef so that we can reuse it.

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


