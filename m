Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC52C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331C221D81
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIblobIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331C221D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFd0N-0003Sk-2I
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczF-00022i-8L
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:37 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:39959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczB-0001Kv-OD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:36 -0400
Received: by mail-ej1-x642.google.com with SMTP id z22so22284412ejl.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1g3oKVzWdmlYD9vf8mBq95tsayfNUOlsZ6AfVzlFnBs=;
 b=WIblobIg+Wntj+LTWy2KgvgEoSFlCs3ED5hya5YdRYfT9uiIWpih36w89axSL/aonw
 I1jw6uDeJAh7sNHv+g0wVkYf4t+t7/n8CbXH70ChGceO4WxTE0csItRUl3R6ujNRymft
 19Y+myvrzIJzFHtJFcsIROvIV6wU0vwmTKT+etNpv0pvqRBGM+SAKkk+ask4MfGfRd53
 ka0x+L2ydrk62q6ZniCg9+2rSMTjF0QYyeopvdjy/XHRx0d3tduF8wyIPzSQ5ZNTkxeO
 ewv9lH6E8whzy37hNuU2XJexIAXPc5rpV5Kwf0FPSEQIRD7qW5F+uTV7nsgdazl/pj6F
 cTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1g3oKVzWdmlYD9vf8mBq95tsayfNUOlsZ6AfVzlFnBs=;
 b=B3MbshDEM04/O+XpLQc/1jDXIRykINHLapxSpMbwJTELwmNK7V/UksZNZkL3V0C22F
 M/tskQsLWlu2PQFtOP4ZX3GWI6qSSw08nNCmCJshazwvawcwsqSriG6TFxEYU1j2xq4B
 yL4Ds6sd4f6AjIpFGzC5NcWjnFxAggwbxPTQBEUBfthB3qByf17fQfP3t+uIraCDDVzL
 oLiuMSuY1arcMNQJto+2/+82HNB74eSF89SEYQqbhWfARg99rhsyj+jNJlJE6ROB9KV4
 ZSzaOhECIOC5SHtcHbysPsvO25eJqUQXjqUKlpLOMxOEAqkf0CIBJciau81HE3T9Ktng
 vOlg==
X-Gm-Message-State: AOAM531TV6gtFiV9orzmPtbxv9WNxdiEU8dex4CClql6nBo+4NQCD8X1
 UudLYtFRoS3D6lY3vh6Rl/+2G7fIx3U=
X-Google-Smtp-Source: ABdhPJwe5C6KnNEjcc+ReesoAED3qsCqc/SykIjdbXlh5EmLKMDBtxVTrpGdAlwGvU0RgVhzugTGmA==
X-Received: by 2002:a17:906:454e:: with SMTP id
 s14mr26412130ejq.137.1599569072107; 
 Tue, 08 Sep 2020 05:44:32 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u23sm4396604ejc.108.2020.09.08.05.44.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Sep 2020 05:44:31 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] target/mips: Demacro helpers for <ABS|CHS>.<D|S|PS>
Date: Tue,  8 Sep 2020 14:44:25 +0200
Message-Id: <1599569068-9855-2-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599569068-9855-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1599569068-9855-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove function definitions via macros to achieve better code clarity.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 61 ++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 7a3a61cab3..f89213947f 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -983,27 +983,46 @@ uint32_t helper_float_floor_2008_w_s(CPUMIPSState *env, uint32_t fst0)
 }
 
 /* unary operations, not modifying fp status  */
-#define FLOAT_UNOP(name)                                       \
-uint64_t helper_float_ ## name ## _d(uint64_t fdt0)                \
-{                                                              \
-    return float64_ ## name(fdt0);                             \
-}                                                              \
-uint32_t helper_float_ ## name ## _s(uint32_t fst0)                \
-{                                                              \
-    return float32_ ## name(fst0);                             \
-}                                                              \
-uint64_t helper_float_ ## name ## _ps(uint64_t fdt0)               \
-{                                                              \
-    uint32_t wt0;                                              \
-    uint32_t wth0;                                             \
-                                                               \
-    wt0 = float32_ ## name(fdt0 & 0XFFFFFFFF);                 \
-    wth0 = float32_ ## name(fdt0 >> 32);                       \
-    return ((uint64_t)wth0 << 32) | wt0;                       \
-}
-FLOAT_UNOP(abs)
-FLOAT_UNOP(chs)
-#undef FLOAT_UNOP
+
+uint64_t helper_float_abs_d(uint64_t fdt0)
+{
+   return float64_abs(fdt0);
+}
+
+uint32_t helper_float_abs_s(uint32_t fst0)
+{
+    return float32_abs(fst0);
+}
+
+uint64_t helper_float_abs_ps(uint64_t fdt0)
+{
+    uint32_t wt0;
+    uint32_t wth0;
+
+    wt0 = float32_abs(fdt0 & 0XFFFFFFFF);
+    wth0 = float32_abs(fdt0 >> 32);
+    return ((uint64_t)wth0 << 32) | wt0;
+}
+
+uint64_t helper_float_chs_d(uint64_t fdt0)
+{
+   return float64_chs(fdt0);
+}
+
+uint32_t helper_float_chs_s(uint32_t fst0)
+{
+    return float32_chs(fst0);
+}
+
+uint64_t helper_float_chs_ps(uint64_t fdt0)
+{
+    uint32_t wt0;
+    uint32_t wth0;
+
+    wt0 = float32_chs(fdt0 & 0XFFFFFFFF);
+    wth0 = float32_chs(fdt0 >> 32);
+    return ((uint64_t)wth0 << 32) | wt0;
+}
 
 /* MIPS specific unary operations */
 uint64_t helper_float_recip_d(CPUMIPSState *env, uint64_t fdt0)
-- 
2.20.1


