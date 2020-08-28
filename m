Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26022C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6C620639
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtuKips1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6C620639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfRF-0008S3-0o
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEg-0000iC-Vm
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEe-00057Z-8Z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id c142so665981pfb.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vRHfeWYe4t2JOdjOnGDnZu1tFFPEQawCvJ5AdLU8/XA=;
 b=rtuKips1AicN7F+yu6Abird5Dw9NJ+XNSA6KmwmrE+vIxCpsLTksrjjv9CimaqhzeY
 pvMxWeA1jpIFogWa+/6sRqLmtuG1lFYXKfEOP7WxpZALHz1/EQwsC/epWwflNsQRqq49
 C5CeIH6nP9fAwrQmVwWQaWczXI3FCx9tl+2U2UXVhhQ5Xba88KvdaHJ/Pu1xuyMKpPNR
 9GdudkB1+FgkI+Yc++LTvN9Ph5Ajq4YbMpkFbYVvDIPK53mgczvWZclLvOrn+dYAe6DJ
 VXCqwQY/dMiW5k9XXrs1QTBDFaaU4z/9XvpH+HgzaXhD+ma7YjKqE3k932qz0SUtl5wT
 hQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vRHfeWYe4t2JOdjOnGDnZu1tFFPEQawCvJ5AdLU8/XA=;
 b=V86YnEaS9bJ0tPi5NCkaNRhclxXOP1jCdVBjUUBqUb+eSajuVHtzk13Z4iEHVdFI5T
 3RPRVjNiqXRoB5FMfT1cfOef2o8VGyaSvwPdh6Evm99HZ5vwgUI67yT9fOMVyzFeuV6V
 xwFnjjwxBImy5HdcDAkJT2dM+2PMGSuYLcWxD8n59D1CFYeJMbqyyeAbBkGhUtLp4kru
 9PTTygykbHFct3reu5YqMBra/G8hFY1VjaKDz2ueSXHOE02f4CyPiQPyqNSdishLnh9n
 5eTvKvHTjcJaCsE9ivrOlTtE6WgxuUekYQl/PnOzkbNxL3vWNtxMWpLWTpzioeH/Is+v
 CQuQ==
X-Gm-Message-State: AOAM530wdGFh+pCPWJ9h7R4NFStNjVfXGrPEpqZXgOt5SL1dtw7akAZO
 dBVm3/8kDFuWLeLXk6vFXDT244jg2rEMyA==
X-Google-Smtp-Source: ABdhPJw4uB6nN+UTFge1kWs45VQWaAjzkaEbFQghms6w6T2yG+7bzl4QkMajibj+tPXXTCkoPo5iZA==
X-Received: by 2002:aa7:810f:: with SMTP id b15mr1424581pfi.293.1598624406682; 
 Fri, 28 Aug 2020 07:20:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/76] target/microblaze: Check singlestep_enabled in
 gen_goto_tb
Date: Fri, 28 Aug 2020 07:18:40 -0700
Message-Id: <20200828141929.77854-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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

Do not use goto_tb if we're single-stepping.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 53ca0bfb38..7d5b96c38b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -140,7 +140,12 @@ static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
 
 static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 {
-    if (use_goto_tb(dc, dest)) {
+    if (dc->singlestep_enabled) {
+        TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
+        tcg_gen_movi_i64(cpu_SR[SR_PC], dest);
+        gen_helper_raise_exception(cpu_env, tmp);
+        tcg_temp_free_i32(tmp);
+    } else if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(cpu_pc, dest);
         tcg_gen_exit_tb(dc->tb, n);
-- 
2.25.1


