Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9245C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12DA20738
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQB1Zif9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12DA20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLWn-0005JX-LI
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVw-0003pl-Pr
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:12 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:33943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVu-0002Nb-0r
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:12 -0400
Received: by mail-pj1-x1036.google.com with SMTP id n3so7668781pjq.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lPpTfq2djWv2KtE9u88NEsXW+rPg4wV1NrdmvmqhTMc=;
 b=BQB1Zif9FmmzTXKs59VNVu1nTiedajD+cffLaACTdrZ0H86wsjIHTg4esL2/7q5SBG
 r7UhPVBzsSyq6WY9FqhuHTEaDo11Ab0mwiK0nawE5VUSdCaWQeUqZT2d3dS4zJHQPmCV
 JD5pj7ZxaMZwMBoib3Qc2QeJUr7iTaxTG3Adu80I7sx16kRJMGHfgAz5DMMML7PKtZkD
 u/u1gWHof39GAMQX56RCb15o/fkbtKqxE/38OCMmhkpjfh5+PPHLHBfpER3ZFc8yxJnJ
 96UgODrpcKJYk8Zu8qDlEYeuKQ3SlQi3QMjg336m2GpioonIRl3+es46jdTQw96wnnzN
 xLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lPpTfq2djWv2KtE9u88NEsXW+rPg4wV1NrdmvmqhTMc=;
 b=eXL7yeqB3v1sTyanvfVHA9aNy7urNm7cFPgnngYjPWUfyccuGiIJWrmOdqLkbpP1en
 SaP0NBn7o/h8QoKpziNCIebeAUJdKb5m6EtIA7ZFUsjz0JYv3Hp+5PXHh8focHPvrEJH
 Kat09FB2P6unIxIhuxkFSSNsgoL29kJlOH/FJnBg/y2uO/tvhH3EbCg98BIA7OlHx/tK
 6qIeRNuthGnYgs7RjptWRm9jA7sgLCFkpar3k+Z2Wjt9tUOf7OjsRpxTbZq77KbzmUzD
 guosHNeTjsp3O90Vvz+GYfZJLm2hlQvdZWoaZ0RTvW7v2QhzGgjjbDRNVsoQTDGk+qWq
 QS1g==
X-Gm-Message-State: AOAM532doL+tnPONdt9LCxy22z7NA57Fm2uUjRCqqDYbQakh/eJ/qzCt
 SYkpvDr4js0Xu/cFmVuzDu+BoiZALyRKrw==
X-Google-Smtp-Source: ABdhPJzCLPCvswwIWo8qjyz2amjOY518IS9+jGNQxO08jrJpuRgk9+9zIkJ04C++Ll/HYhiN0u3ikg==
X-Received: by 2002:a17:90a:e64e:: with SMTP id
 ep14mr413620pjb.173.1599501905234; 
 Mon, 07 Sep 2020 11:05:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm11367768pfi.38.2020.09.07.11.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 11:05:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] target/microblaze: Reorg MicroBlazeCPUConfig to minimize
 holes
Date: Mon,  7 Sep 2020 11:04:53 -0700
Message-Id: <20200907180459.29025-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907180459.29025-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
 <20200907180459.29025-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Sort the elements by type and size, removing a number of holes
and reducing the size of the entire struct.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 59d2a079c4..4d53345f23 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -293,13 +293,22 @@ struct CPUMBState {
 
 /*
  * Microblaze Configuration Settings
+ *
+ * Note that the structure is sorted by type and size to minimize holes.
  */
 typedef struct {
-    bool stackprot;
+    char *version;
+
     uint32_t base_vectors;
+    uint32_t pvr_user2;
+
     uint8_t addr_size;
     uint8_t use_fpu;
     uint8_t use_hw_mul;
+    uint8_t pvr_user1;
+    uint8_t pvr;
+
+    bool stackprot;
     bool use_barrel;
     bool use_div;
     bool use_msr_instr;
@@ -313,10 +322,6 @@ typedef struct {
     bool opcode_0_illegal;
     bool div_zero_exception;
     bool unaligned_exceptions;
-    uint8_t pvr_user1;
-    uint32_t pvr_user2;
-    char *version;
-    uint8_t pvr;
 } MicroBlazeCPUConfig;
 
 /**
-- 
2.25.1


