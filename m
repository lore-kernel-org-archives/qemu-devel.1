Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E9FC4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D43820673
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TklwMhNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D43820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmLE-0008QS-BV
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJG-0006bF-VU
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJF-0000qZ-Tw
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:54 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:38258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJF-0000qG-OZ
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:25:53 -0400
Received: by mail-pg1-x536.google.com with SMTP id w3so2020009pgt.5
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3r9lmg0xOia6vKK6bS8vYuvXdDkpmktVvUvQAVF/QiE=;
 b=TklwMhNKWIOXn3osOx4pOB04IIOditZ6hFek+9J9LdNLzbiEsLl2VV80Q8ROL55MsP
 jaOav6dKIUxFsu9WzN9iIyGcli8tfXvlIOG9FnEGPx4SjJxX1pXwR7C0KRcFT79CTDya
 tZLpYZ+jJz0ILORzlZxXxiF1AOEgqPsDPxkBhSuKIztM5lfENzMYg+wV+/ISNLrT7+aL
 barvlBALSBX9BCQSH/cuTSKngZXRzHtxPQ24bXyYlp1NoXlN+tVdIzKDfIu07FpMXcsG
 gPQO3sAZGge1F1PWlNEL9LHfCRHXrCj0IpVP5pJghlceaPwGw+zEQYYPZqDpC60U+L2o
 97Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3r9lmg0xOia6vKK6bS8vYuvXdDkpmktVvUvQAVF/QiE=;
 b=OTxQ+9/StjcwL3hmwhhH2Mb65pK/dzqfq4QB5YP4+lJ07J6+wkPe6FtYz0LXmOZ7qn
 2aHjRb4vkRz8oBJqvgniU+qOhNaYX9GX8hrKcvanCXp/ETWKkAyP1F4pKg8dFVzUZDfM
 37m3d7D56oS014Sg+J9WfUgEs35MnWlxe8RLA3HykF5D7k+jTY4qlyaii5s6w/DNQ5Aq
 yihNW6nedC2F7RJB/tyezAuOW6JsezQn3nzmTJfiHAyb/qHWI2drJ+Ys3knJvrBRMS8M
 r/3gmIg6q80LebDAQVSvoFKyEM4KhXyRifUH5LWNUyttINSFMHyKse5ac3+b29iYrJ0x
 vx+w==
X-Gm-Message-State: APjAAAV37dfj0qhVEdFsDA5lAkQpGYtC+06XB4JaWCubS5bESJd2QWcU
 TNdHz4co7jOeTdFbkqXW2bxybEQfalA=
X-Google-Smtp-Source: APXvYqy7mwaW8NZJJST9dwdenbxQbvsFuAUmGonYZOLtLvkmNbme13LeYiphJ/cg7waHRiZHJtLN8w==
X-Received: by 2002:a65:464b:: with SMTP id k11mr11787065pgr.263.1571005552383; 
 Sun, 13 Oct 2019 15:25:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:25:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/23] tcg/ppc: Create TCGPowerISA and have_isa
Date: Sun, 13 Oct 2019 15:25:25 -0700
Message-Id: <20191013222544.3679-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::536
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce an enum to hold base < 2.06 < 3.00.  Use macros to
preserve the existing have_isa_2_06 and have_isa_3_00 predicates.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.h     | 12 ++++++++++--
 tcg/ppc/tcg-target.inc.c |  8 ++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 690fa744e1..35ba8693fa 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -58,8 +58,16 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
-extern bool have_isa_2_06;
-extern bool have_isa_3_00;
+typedef enum {
+    tcg_isa_base,
+    tcg_isa_2_06,
+    tcg_isa_3_00,
+} TCGPowerISA;
+
+extern TCGPowerISA have_isa;
+
+#define have_isa_2_06  (have_isa >= tcg_isa_2_06)
+#define have_isa_3_00  (have_isa >= tcg_isa_3_00)
 
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 4aad5d2b36..0bfaef9418 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -64,8 +64,7 @@
 
 static tcg_insn_unit *tb_ret_addr;
 
-bool have_isa_2_06;
-bool have_isa_3_00;
+TCGPowerISA have_isa;
 
 #define HAVE_ISA_2_06  have_isa_2_06
 #define HAVE_ISEL      have_isa_2_06
@@ -2787,12 +2786,13 @@ static void tcg_target_init(TCGContext *s)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
+    have_isa = tcg_isa_base;
     if (hwcap & PPC_FEATURE_ARCH_2_06) {
-        have_isa_2_06 = true;
+        have_isa = tcg_isa_2_06;
     }
 #ifdef PPC_FEATURE2_ARCH_3_00
     if (hwcap2 & PPC_FEATURE2_ARCH_3_00) {
-        have_isa_3_00 = true;
+        have_isa = tcg_isa_3_00;
     }
 #endif
 
-- 
2.17.1


