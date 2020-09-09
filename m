Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2391CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2B7206B5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3ylNEe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2B7206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnvZ-0001ua-NK
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnr-0000dx-HP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:35 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:34059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnp-0002Ju-Iz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:35 -0400
Received: by mail-pj1-x102e.google.com with SMTP id n3so471097pjq.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CeNByq4xJzQ0NQWVpC7UobWtIj47eNKfcOoWhkzYyh0=;
 b=O3ylNEe1Caq/KsHJZOKy5eBk8NP1kzYrWXNDxCXiA4glzGsRPpI6g7tX/xEjPwiACh
 3UIt2zn/xZPr1gye0c+dqqduk7bYiAsZJBWI8HL3Bq704OCpKo5kWeG3I6kV3PnAg4ud
 HlZ2S+Su7PGfH77N1KxMXpMSntfQJT6mC1gtfTcm3sKNw+GoiLnS431QuimYV3zB0+nR
 9UP6RgGE5UV6YinbwzXn0W/VaGDJ2VgjXir1qQ2UChkbEU+cPbuImonjlS24b1zWrclP
 LvEVFOak4mKle/efTvOBY1JsJrLCzUlznNuWnSA/Alfxiihdj0YDV+QOSmHLN0fn0UYy
 iEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CeNByq4xJzQ0NQWVpC7UobWtIj47eNKfcOoWhkzYyh0=;
 b=Kl5voGHqgnZwyuwwZqNe1GBa3UdSwL5P1tqx6q+WfSq5HnoST8iq4RmZiLIH4IfZ9r
 LujpoYB9CsGvEOT/8S0TDpOv0nkC5vdwllShFmCUbMWBEjK48pWCwdnLL+e3ZZDtmp3M
 tyf6PI/YI3XRvceDIzRRoiqTuYnOXNSH8yQT/kqSQ98cRDE6qIq0iEQp6d4asH6Jiead
 47Gc3J/tqt9uz76ScAA1fgWrbGnI2P4Amk7DLAHvI0MANavkstx2LCxMNNzlOz+zAe/r
 FMOhE0a5zpPGT/9puJpcDkQtYFrOhw5PkKf9niCgQnCLKgZrizOIuEVI/Ue98sqdVy5n
 S2YQ==
X-Gm-Message-State: AOAM5329LyWdTcPyuG/mecazkgjIJ4a+zNzqJ8TRc4D4AmcDi0XD+gEr
 sVmDBc6b/7JA4vNeotgFjjFy3eBBVnRduA==
X-Google-Smtp-Source: ABdhPJykR4qnm3fmrOfWevcUMN1YVDJB2VTrUB0i+I68CJoXi6d7QWR5BDa/lq6aPWwE5QeY/jjB7g==
X-Received: by 2002:a17:90a:e609:: with SMTP id
 j9mr1108258pjy.129.1599610651826; 
 Tue, 08 Sep 2020 17:17:31 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/43] tcg: Add tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:38 -0700
Message-Id: <20200909001647.532249-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Begin conversion of constraints to pre-validated, read-only entities.
To begin, create a simple method by which sets of TCGTargetOpDef
structures may be declared and used.  This simplifies each host's
tcg_target_op_def function and ensures that we have a collected
set of constraints.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-constr.c.inc | 108 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 tcg/tcg-constr.c.inc

diff --git a/tcg/tcg-constr.c.inc b/tcg/tcg-constr.c.inc
new file mode 100644
index 0000000000..f7490a096e
--- /dev/null
+++ b/tcg/tcg-constr.c.inc
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * TCG backend data: operand constaints.
+ * Copyright (c) 2020 Linaro
+ */
+
+/*
+ * Define structures for each set of constraints.
+ */
+
+#define C_PFX1(P, A)                 P##A
+#define C_PFX2(P, A, B)              P##A##_##B
+#define C_PFX3(P, A, B, C)           P##A##_##B##_##C
+#define C_PFX4(P, A, B, C, D)        P##A##_##B##_##C##_##D
+#define C_PFX5(P, A, B, C, D, E)     P##A##_##B##_##C##_##D##_##E
+#define C_PFX6(P, A, B, C, D, E, F)  P##A##_##B##_##C##_##D##_##E##_##F
+
+#define C_O0_I1(I1) \
+    static const TCGTargetOpDef C_PFX1(c_o0_i1_, I1) \
+      = { .args_ct_str = { #I1 } };
+
+#define C_O0_I2(I1, I2) \
+    static const TCGTargetOpDef C_PFX2(c_o0_i2_, I1, I2) \
+      = { .args_ct_str = { #I1, #I2 } };
+
+#define C_O0_I3(I1, I2, I3) \
+    static const TCGTargetOpDef C_PFX3(c_o0_i3_, I1, I2, I3) \
+      = { .args_ct_str = { #I1, #I2, #I3 } };
+
+#define C_O0_I4(I1, I2, I3, I4) \
+    static const TCGTargetOpDef C_PFX4(c_o0_i4_, I1, I2, I3, I4) \
+      = { .args_ct_str = { #I1, #I2, #I3, #I4 } };
+
+#define C_O1_I1(O1, I1) \
+    static const TCGTargetOpDef C_PFX2(c_o1_i1_, O1, I1) \
+      = { .args_ct_str = { #O1, #I1 } };
+
+#define C_O1_I2(O1, I1, I2) \
+    static const TCGTargetOpDef C_PFX3(c_o1_i2_, O1, I1, I2) \
+      = { .args_ct_str = { #O1, #I1, #I2 } };
+
+#define C_O1_I3(O1, I1, I2, I3) \
+    static const TCGTargetOpDef C_PFX4(c_o1_i3_, O1, I1, I2, I3) \
+      = { .args_ct_str = { #O1, #I1, #I2, #I3 } };
+
+#define C_O1_I4(O1, I1, I2, I3, I4) \
+    static const TCGTargetOpDef C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4) \
+      = { .args_ct_str = { #O1, #I1, #I2, #I3, #I4 } };
+
+#define C_N1_I2(O1, I1, I2) \
+    static const TCGTargetOpDef C_PFX3(c_n1_i2_, O1, I1, I2) \
+      = { .args_ct_str = { "&" #O1, #I1, #I2 } };
+
+#define C_O2_I1(O1, O2, I1) \
+    static const TCGTargetOpDef C_PFX3(c_o2_i1_, O1, O2, I1) \
+      = { .args_ct_str = { #O1, #O2, #I1 } };
+
+#define C_O2_I2(O1, O2, I1, I2) \
+    static const TCGTargetOpDef C_PFX4(c_o2_i2_, O1, O2, I1, I2) \
+      = { .args_ct_str = { #O1, #O2, #I1, #I2 } };
+
+#define C_O2_I3(O1, O2, I1, I2, I3) \
+    static const TCGTargetOpDef C_PFX5(c_o2_i3_, O1, O2, I1, I2, I3) \
+      = { .args_ct_str = { #O1, #O2, #I1, #I2, #I3 } };
+
+#define C_O2_I4(O1, O2, I1, I2, I3, I4) \
+    static const TCGTargetOpDef C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4) \
+      = { .args_ct_str = { #O1, #O2, #I1, #I2, #I3, #I4 } };
+
+#include "tcg-target-constr.h"
+
+
+/*
+ * Redefine the macros so that they now reference those structures.
+ * These values should be returned from tcg_target_op_def().
+ */
+
+#undef C_O0_I1
+#undef C_O0_I2
+#undef C_O0_I3
+#undef C_O0_I4
+#undef C_O1_I1
+#undef C_O1_I2
+#undef C_O1_I3
+#undef C_O1_I4
+#undef C_N1_I2
+#undef C_O2_I1
+#undef C_O2_I2
+#undef C_O2_I3
+#undef C_O2_I4
+
+#define C_O0_I1(I1)                     &C_PFX1(c_o0_i1_, I1)
+#define C_O0_I2(I1, I2)                 &C_PFX2(c_o0_i2_, I1, I2)
+#define C_O0_I3(I1, I2, I3)             &C_PFX3(c_o0_i3_, I1, I2, I3)
+#define C_O0_I4(I1, I2, I3, I4)         &C_PFX4(c_o0_i4_, I1, I2, I3, I4)
+
+#define C_O1_I1(O1, I1)                 &C_PFX2(c_o1_i1_, O1, I1)
+#define C_O1_I2(O1, I1, I2)             &C_PFX3(c_o1_i2_, O1, I1, I2)
+#define C_O1_I3(O1, I1, I2, I3)         &C_PFX4(c_o1_i3_, O1, I1, I2, I3)
+#define C_O1_I4(O1, I1, I2, I3, I4)     &C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4)
+
+#define C_N1_I2(O1, I1, I2)             &C_PFX3(c_n1_i2_, O1, I1, I2)
+
+#define C_O2_I1(O1, O2, I1)             &C_PFX3(c_o2_i1_, O1, O2, I1)
+#define C_O2_I2(O1, O2, I1, I2)         &C_PFX4(c_o2_i2_, O1, O2, I1, I2)
+#define C_O2_I3(O1, O2, I1, I2, I3)     &C_PFX5(c_o2_i3_, O1, O2, I1, I2, I3)
+#define C_O2_I4(O1, O2, I1, I2, I3, I4) \
+    &C_PFX6(c_o2_i4_, O1, O2, I1, I2, I3, I4)
-- 
2.25.1


