Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E723C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE77220684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMB4zzqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE77220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHDf-0007g6-RA
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH58-0001sx-5f
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:06 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH56-0000pj-Hc
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:05 -0400
Received: by mail-pl1-x644.google.com with SMTP id z15so1591596plo.7
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5XnCVImZ5QTsJteNC1vb4alnlrpbIu8SO5P2TYSi0sE=;
 b=gMB4zzqxfrczxB2RfGO22uUZO3agZtGBD2C+AYTc4ycM3ib13mcHjs/WDQAh3f6a0/
 0iYDQ0MgkV2s7zKwQhsJGUKidym64vGz+vtM3M3dNLyOzuczAuPvx0j63XgQuaOEyj0n
 bVqGEPvNcMdSXCI6G/EMRwMgU/aIqrCVTeWPJ52IRfrpvEiiTG+KZYWB69No07owXsWi
 TYZUIqXlY1NvSn6estv4wjTIOR99lkZRxcb/ZYnrWqdh2KfPtYwX2QjJ2b0F7ScxA8BC
 3unjXZl+PaiJppK6GvLwx6HjdHTdllg8NffqJfbgRG8OM3yvwcY74iTbBeN2PCHRK+WP
 WWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5XnCVImZ5QTsJteNC1vb4alnlrpbIu8SO5P2TYSi0sE=;
 b=WT9JOp7QRUUL4apvH76HYFtpWCM/rPw1yoCB+6NX2HKkR0ugAnpsKX90hXyOGWPBDk
 2JHZzY5Vf9KtYfbjjGTdnMB6TJT1stHWKgeU/PpkwAaZ3swSbkZSO3SojQtNQvIVuMdE
 tDBktCBWAdUrAZFjqFfaOwKGGa2K5DMC5L4zD3xNLrw7yJ7Bfsg5CC9wuve/AUhrvb7R
 HMdiB2Yh4wGsVMpyqkcZgaS/DRr+XV5hJYN4uUuZbEi2SxrI9PgwVuTTVfjtYQpgmBh/
 wcrZVNFM8j6Dzkdj5n1fFi0hyOWg0Qy7PzCkV7XatnljwwcKFf48wWMrAWfrMPGuwDgc
 uQuQ==
X-Gm-Message-State: AOAM533GHlbYKzi96oOdORr1hB7NIbAhsU/oTl9eT0fdepC6MGzueejb
 C6TV6PAtlkp6MjWZN+kvJomJJHXzy/Vl3A==
X-Google-Smtp-Source: ABdhPJyBzc0JSclVDE0alKaxYxDZgB/R7XIiBRCIsj8FqUd3aqeBrfZBmrEiTLUVcGZ00IU5s2U7sA==
X-Received: by 2002:a17:90a:4ec6:: with SMTP id
 v6mr9017941pjl.12.1599246542804; 
 Fri, 04 Sep 2020 12:09:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:09:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/19] target/microblaze: Reorg MicroBlazeCPUConfig to
 minimize holes
Date: Fri,  4 Sep 2020 12:08:36 -0700
Message-Id: <20200904190842.2282109-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

Sort the elements by type and size, removing a number of holes
and reducing the size of the entire struct.

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


