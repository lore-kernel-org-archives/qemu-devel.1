Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C114C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41D120EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUPWdWLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41D120EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpEO-0004H8-PG
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp85-0001zr-8h
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp83-0007WZ-8d
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id a9so200029wmm.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=m58pknpN2eQ1zzjiR2a1sQi0/6/l0QeEv7UO1WaHIi8=;
 b=BUPWdWLj5lr4//snkkju6UGzqK510rONeVkRhpe2DGtPwqyhEU5GJ6A0+P6g4bHLc3
 3URXJjXc+x+uCzwgVKQ6xU50ArBXWtHw5o9nRl/0AOGfZrM8SgFAYMWSgYDLAR+98X+j
 HCh5cQ8YcCNKZypc5dQ8aqcPC/zKHqns9iWCYVHsKL9VJm2bx0H+6nZikrUPUonduQWP
 NDuR4HrKSulVCkLx/0HqnlN8kSl9F9bXqv1Oty1675HMpXfpW3V9GQv1i6ammEna73xZ
 IcTuFR4Bfv1J8IuEq2BdxTuQQsMjALGrXd03h2UC0VEsNIFBYBKauUIxOu9rCOSOEmvm
 qgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m58pknpN2eQ1zzjiR2a1sQi0/6/l0QeEv7UO1WaHIi8=;
 b=PU8yovmzD4ufZxbvXhgJ0psSEuEQKGnGrfBYlPqrsBfQl4sQI3sGTnKhMly9ggLjc2
 asax/RdRPLOks2KdFdOVGfeNShpOj9gWck1218M0gtGU8iXFGFb0vxcaEY5rP9ARHUz/
 EEVi1qM6aQuBTwrSOPBPsMQWDUKZKHF7VCXSIplSl89IP3cLrAuiE/Oy2zb00KT9AvqW
 ukZGyLbkycSJLweji8Bm/s3bdw6u8mnq5vM0EmsMdn9vhx6BvOkFa0oAM1K9qhb8jChV
 PvlfwL29DPgOzenEf3FgR4AQwbto2INZAFGKYNHeExf3E5a7FncFoKrUEtkjIiV50ql/
 5Oug==
X-Gm-Message-State: AOAM530FW+eqYgiSr2V+XKL7Vli34wTJJUv1/SDZsuw8rVKBpZDLb4Gi
 7uKGjglEuzH+BPyLOdt3WHix59WqM0iTbqvl
X-Google-Smtp-Source: ABdhPJydgzG3W2qROdYdxxOWcuWzc3/HHGXSGk9VdZ9n78ANM2hmi9zy8BNL0479kYSISS9BR8Zzcg==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr14850773wma.81.1600092405755; 
 Mon, 14 Sep 2020 07:06:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/36] hw/misc/a9scu: Simplify setting MemoryRegionOps::valid
 fields
Date: Mon, 14 Sep 2020 15:06:07 +0100
Message-Id: <20200914140641.21369-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Per the datasheet (DDI0407 r2p0):

  "All SCU registers are byte accessible" and are 32-bit aligned.

Set MemoryRegionOps::valid min/max fields and simplify the write()
handler.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200901144100.116742-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/a9scu.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 915f127761e..3f3dcc414fe 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -52,23 +52,8 @@ static void a9_scu_write(void *opaque, hwaddr offset,
                          uint64_t value, unsigned size)
 {
     A9SCUState *s = (A9SCUState *)opaque;
-    uint32_t mask;
+    uint32_t mask = MAKE_64BIT_MASK(0, size * 8);
     uint32_t shift;
-    switch (size) {
-    case 1:
-        mask = 0xff;
-        break;
-    case 2:
-        mask = 0xffff;
-        break;
-    case 4:
-        mask = 0xffffffff;
-        break;
-    default:
-        fprintf(stderr, "Invalid size %u in write to a9 scu register %x\n",
-                size, (unsigned)offset);
-        return;
-    }
 
     switch (offset) {
     case 0x00: /* Control */
@@ -99,6 +84,10 @@ static void a9_scu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps a9_scu_ops = {
     .read = a9_scu_read,
     .write = a9_scu_write,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.20.1


