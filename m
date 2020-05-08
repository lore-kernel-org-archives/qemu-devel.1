Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7C9C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAAF216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O24MOHpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAAF216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5aQ-0002L4-R0
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5No-0000Rl-LI
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:57:52 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Nn-0008Ln-Ox
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:57:52 -0400
Received: by mail-pl1-x642.google.com with SMTP id x10so918493plr.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6vhGh9XtmB1p78XgXCc3Kr/K2kEi/74lOsVOL6OroQc=;
 b=O24MOHpHx0p/YP80bpGOSA4YV4mmpeVL5CzJHAq6mP9FLR9lghE0ZwxvyQTDhu/MNv
 YNwiUimeeu4C54t5PajhNRZzx/WzSXu2Osx8zE2pyUkZmcz6pZy2bjXuGAUDLMvDFbiW
 6I2iIBAUBgyLEN0/+2qepI6UBKizBQ+NoQROOmBpjg5i7f2qTPudt91KOGBsx7iPq9Jx
 a2TJQnX+kjf0fcbJMM5K698AQmBpf6HQlZygJREu8FJrR6i2PBjkIxSTOF2Jq7IUVHXt
 edhuRsPNCK2Rdsy8leHad63kitiL/gRYqBbDgFlXY3sm7/8WrJdQc5iJIdbTHUxl97Kn
 TgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6vhGh9XtmB1p78XgXCc3Kr/K2kEi/74lOsVOL6OroQc=;
 b=XWvjJU4LbaSkCgvvLy+2rK6vpfCFDQjFK9Ubg9dmcS4uoq/psTmOyephiDjOfgu24i
 ycUANKFro2h6kqQFIBdKJxRL6du9gSsqmewrKncUpgzDnmZZjmSe1rBGajjG4qFEFwSl
 RfxnYPe9pTHV19YtvBRHyhYwa44kVUkEWyJx+bL99dtd4WL2F453+ACytLJOOwvt3AOC
 LBxa7Wy+EPrgkHaFhbN1AfvFO/v7ORm3jLCZ+YIVohZiETiUHYNt8Dzhl5AvLXGDvHLB
 GqzXNujvd2G3LbJBdLqhKGXyzGnvxwaL1opJkhEkWiPFStVZUSAPaTAg9Ga+fj0P4V8M
 E8sw==
X-Gm-Message-State: AGi0PubY/lMEkDLi0G+rHuEOrHR1pVQnLiFPenOpIs6EjWc+aVl07y4r
 QuxhXhWYysYYR53CMWJ1GxmWnGk2shE=
X-Google-Smtp-Source: APiQypLOkJzxmLJOSrx4pH45aZ4lMZuMulUzB/6CqFk7QMCZOVPOnLlPkYWPvsnLaf8IuU5lg0eCPA==
X-Received: by 2002:a17:90b:3843:: with SMTP id
 nl3mr7004143pjb.72.1588953469961; 
 Fri, 08 May 2020 08:57:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id z7sm2141601pff.47.2020.05.08.08.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:57:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] tcg/s390: Merge TCG_AREG0 and TCG_REG_CALL_STACK into
 TCGReg
Date: Fri,  8 May 2020 08:57:44 -0700
Message-Id: <20200508155745.8223-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508155745.8223-1-richard.henderson@linaro.org>
References: <20200508155745.8223-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They are rightly values in the same enumeration.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390/tcg-target.h | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 7ca48457ff..1e67c90ed2 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -29,22 +29,13 @@
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
 
 typedef enum TCGReg {
-    TCG_REG_R0 = 0,
-    TCG_REG_R1,
-    TCG_REG_R2,
-    TCG_REG_R3,
-    TCG_REG_R4,
-    TCG_REG_R5,
-    TCG_REG_R6,
-    TCG_REG_R7,
-    TCG_REG_R8,
-    TCG_REG_R9,
-    TCG_REG_R10,
-    TCG_REG_R11,
-    TCG_REG_R12,
-    TCG_REG_R13,
-    TCG_REG_R14,
-    TCG_REG_R15
+    TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
+    TCG_REG_R4,  TCG_REG_R5,  TCG_REG_R6,  TCG_REG_R7,
+    TCG_REG_R8,  TCG_REG_R9,  TCG_REG_R10, TCG_REG_R11,
+    TCG_REG_R12, TCG_REG_R13, TCG_REG_R14, TCG_REG_R15,
+
+    TCG_AREG0 = TCG_REG_R10,
+    TCG_REG_CALL_STACK = TCG_REG_R15
 } TCGReg;
 
 #define TCG_TARGET_NB_REGS 16
@@ -135,7 +126,6 @@ extern uint64_t s390_facilities[1];
 #define TCG_TARGET_HAS_mulsh_i64      0
 
 /* used for function call generation */
-#define TCG_REG_CALL_STACK		TCG_REG_R15
 #define TCG_TARGET_STACK_ALIGN		8
 #define TCG_TARGET_CALL_STACK_OFFSET	160
 
@@ -144,10 +134,6 @@ extern uint64_t s390_facilities[1];
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
-enum {
-    TCG_AREG0 = TCG_REG_R10,
-};
-
 static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
 }
-- 
2.20.1


