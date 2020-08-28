Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB185C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877DD2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEvb7744"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877DD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfI7-0007zH-Rz
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfE9-0007pO-OR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:37 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfE8-00051p-Ao
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:37 -0400
Received: by mail-pg1-x541.google.com with SMTP id p37so532242pgl.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4/yFPag8qdnd69lG7PXq/hNxrp/qSy4kCl2N10yso4g=;
 b=dEvb7744QiX0jYi3LW2PeIb24gLmK98aD/jOZEaUvsYDgiSJd+DE7LNiDEtSzsw0OT
 TLcoCtVqxPTXzyggpo8Tm4pKY5OwNKGQgbwiBD36fK3v2/zVpCMF5iO8CbiBQfsBstv9
 iUcD8wcxzr7j/68ubvICK/uCP/msDES7DcTaftFRuhWBav+qasz75owl5Ud3kiUQqGla
 8tkLIpeXzyLMsBHdMivvy2b+2V994NkqGwy9IxCn7obW6iODzXm1wr6Zwpr0OjP8l2Du
 0cvS3Xk1V0up+ThE/4O5/PeS3IuKAtcQYutBVuh72z4VRIwH3RRbCdmCau1HOkNYnNvE
 Do4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4/yFPag8qdnd69lG7PXq/hNxrp/qSy4kCl2N10yso4g=;
 b=FG8CdySAqKjTiN2HWmZY4Qz2+nvBmrjWYNcY6EcVyCeVup4CoPJaTd538xdSQ2hKWZ
 NBnvyRXoOw48+ERjn39Lax1wFPkWHQpunSNSt0qVemd3qGiL1ZytFp5IQsclWEw9pFBf
 TLIP7t2me8vThmt+L+Sbgsqd4AocTEOBeJSbB0GOMNg/RF0/WQccEOa+lRbtObYobeJv
 38eHYUNH+Wy4OywdMWxHdZD2rM7E36pmdupYJhRJH2tMY4z1FdE3nF9tF+GQqsTcco8S
 H/2ziF71G2owEZEhC9uG++uaccrfFqlJs9n7GpFMCCFuGgmrO16qFpZKoBynLyhtnp7x
 6g6Q==
X-Gm-Message-State: AOAM532R7EeJ5bkYMg0UPCGNjWDYLNEPLy70PmnvKu+nCY9B22PDOnUv
 fTKZ4NOEScRoqep3cqntrfm7U14hcfFUIg==
X-Google-Smtp-Source: ABdhPJxRYsZRzIO5ZipD5XpDRyUdu2S5S0ZdU7HOzZvn2a80DoMsX4NmAyZDrwAkfa1jfaewWZ5XgQ==
X-Received: by 2002:a63:4a1d:: with SMTP id x29mr1452626pga.317.1598624374751; 
 Fri, 28 Aug 2020 07:19:34 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/76] tests/tcg: Do not require FE_* exception bits
Date: Fri, 28 Aug 2020 07:18:16 -0700
Message-Id: <20200828141929.77854-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define anything that is missing as 0, so that flags & FE_FOO
is false for any missing FOO.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/float_helpers.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/tcg/multiarch/float_helpers.h b/tests/tcg/multiarch/float_helpers.h
index 6337bc66c1..309f3f4bf1 100644
--- a/tests/tcg/multiarch/float_helpers.h
+++ b/tests/tcg/multiarch/float_helpers.h
@@ -8,6 +8,23 @@
 
 #include <inttypes.h>
 
+/* Some hosts do not have support for all of these; not required by ISO C. */
+#ifndef FE_OVERFLOW
+#define FE_OVERFLOW 0
+#endif
+#ifndef FE_UNDERFLOW
+#define FE_UNDERFLOW 0
+#endif
+#ifndef FE_DIVBYZERO
+#define FE_DIVBYZERO 0
+#endif
+#ifndef FE_INEXACT
+#define FE_INEXACT 0
+#endif
+#ifndef FE_INVALID
+#define FE_INVALID 0
+#endif
+
 /* Number of constants in each table */
 int get_num_f16(void);
 int get_num_f32(void);
-- 
2.25.1


