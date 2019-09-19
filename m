Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D7AC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3363E218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMvS4pRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3363E218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB5yX-0004pG-UZ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 19:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5s9-0006J1-4K
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5s7-0000kJ-NG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iB5s7-0000k1-He
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:29:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id g3so1153945pgs.11
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XQ1156VivyWb3zatoNFGmDs6MfFq3iJU57HLLRy6mmI=;
 b=XMvS4pRhRkue0uZW/ETU4StFmtshij19PuHQKMaK87fD7r2pUwNzldXtxeV/GVLprc
 zSUCDd8XorUxBWNtaJ38oePPKMY9MrEOJAaF2LPGIsoRtq2b7S0yD1dKqgMxKseV8ymH
 eOdZPMAQYol3hRMIgTbta1i6K4ijODABNr6aD14wGxDemyLQLEO3R2LHJBLjCoZOnCq1
 Xkp3G4fqkHc/TuwhGIHPd2VSM+UMF6DRjCRjJKhLZBe9d7RvhGseK3l0t3nw757cbvuU
 bpfvsjWkj2sj9wPzp/8CKVY2USMg1AkPoeb35r1p5j6z1q4thU8MM9bo3lnVHOQoPYp5
 QCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XQ1156VivyWb3zatoNFGmDs6MfFq3iJU57HLLRy6mmI=;
 b=PuBkJWXMGeXct6Mob0dBanL5OSpEvoPt0IqkTco/p1ZJ81c0EmFskB2S4ynzaYLT3O
 5FGycEZ+3CYD/D07gfMgASs+Uq8fco6+hudLJIiaVMLVgCF+clPiXzcJ8nSATD/BRhzI
 Avaauc9HTFeMt9LK1/MSdIgnVOIIbEJWEzFtdlOnlI9ec1318lsIuwavKwuEhne2Ee3X
 Vqrb5z0k7FlGX9+vnjjRLlJQp7YmEXDEIYRshRwYnj/xKiHjSatfoXp/lPfzeNWHh1ps
 crXeFWqCqnaMZScMmn3r8/w/IsyotLPHxdFkBu7hSn1l62QFb59igDh8p8Dpxv4+TG8R
 lVhw==
X-Gm-Message-State: APjAAAU9t2L6xFH/6ccDuaZmZuPEpszprqPpbU1fMnIhupTA859MlFUt
 opgrrAQkRH3oAtH8LUN5Acsnm3NRfkI=
X-Google-Smtp-Source: APXvYqyiFiFiNGaSbPcCqB7c1AJS1+DlC5TEK1BAPKv1iD3w2Tw8AF6IjIh6bSGN1Wb6lHr5sC1mlA==
X-Received: by 2002:a63:1950:: with SMTP id 16mr9701321pgz.213.1568935798155; 
 Thu, 19 Sep 2019 16:29:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h8sm103340pfo.64.2019.09.19.16.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 16:29:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] exec: Use const alias for TARGET_PAGE_BITS_VARY
Date: Thu, 19 Sep 2019 16:29:48 -0700
Message-Id: <20190919232952.6382-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919232952.6382-1-richard.henderson@linaro.org>
References: <20190919232952.6382-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using a variable that is declared "const" for this tells the
compiler that it may read the value once and assume that it
does not change across function calls.

For target_page_size, this means we have only one assert per
function, and one read of the variable.

This reduces the size of qemu-system-aarch64 by 8k.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 10 +++++----
 exec-vary.c            | 46 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e0c8dc540c..a53b761b48 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -210,10 +210,12 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 /* page related stuff */
 
 #ifdef TARGET_PAGE_BITS_VARY
-extern bool target_page_bits_decided;
-extern int target_page_bits;
-#define TARGET_PAGE_BITS ({ assert(target_page_bits_decided); \
-                            target_page_bits; })
+typedef struct {
+    bool decided;
+    int bits;
+} TargetPageBits;
+extern const TargetPageBits target_page;
+#define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 #endif
diff --git a/exec-vary.c b/exec-vary.c
index 48c0ab306c..67cdf57a9c 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -22,8 +22,38 @@
 #include "exec/exec-all.h"
 
 #ifdef TARGET_PAGE_BITS_VARY
-int target_page_bits;
-bool target_page_bits_decided;
+/*
+ * We want to declare the "target_page" variable as const, which tells
+ * the compiler that it can cache any value that it reads across calls.
+ * This avoids multiple assertions and multiple reads within any one user.
+ *
+ * This works because we initialize the target_page data very early, in a
+ * location far removed from the functions that require the final results.
+ *
+ * This also requires that we have a non-constant symbol by which we can
+ * perform the actual initialization, and which forces the data to be
+ * allocated within writable memory.  Thus "init_target_page", and we use
+ * that symbol exclusively in the two functions that initialize this value.
+ *
+ * The "target_page" symbol is created as an alias of "init_target_page".
+ */
+static TargetPageBits init_target_page;
+
+/*
+ * Note that this is *not* a redundant decl, this is the definition of
+ * the "target_page" symbol.  The syntax for this definition requires
+ * the use of the extern keyword.  This seems to be a GCC bug in
+ * either the syntax for the alias attribute or in -Wredundant-decls.
+ *
+ * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91765
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wredundant-decls"
+
+extern const TargetPageBits target_page
+    __attribute__((alias("init_target_page")));
+
+#pragma GCC diagnostic pop
 #endif
 
 bool set_preferred_target_page_bits(int bits)
@@ -36,11 +66,11 @@ bool set_preferred_target_page_bits(int bits)
      */
 #ifdef TARGET_PAGE_BITS_VARY
     assert(bits >= TARGET_PAGE_BITS_MIN);
-    if (target_page_bits == 0 || target_page_bits > bits) {
-        if (target_page_bits_decided) {
+    if (init_target_page.bits == 0 || init_target_page.bits > bits) {
+        if (init_target_page.decided) {
             return false;
         }
-        target_page_bits = bits;
+        init_target_page.bits = bits;
     }
 #endif
     return true;
@@ -49,9 +79,9 @@ bool set_preferred_target_page_bits(int bits)
 void finalize_target_page_bits(void)
 {
 #ifdef TARGET_PAGE_BITS_VARY
-    if (target_page_bits == 0) {
-        target_page_bits = TARGET_PAGE_BITS_MIN;
+    if (init_target_page.bits == 0) {
+        init_target_page.bits = TARGET_PAGE_BITS_MIN;
     }
-    target_page_bits_decided = true;
+    init_target_page.decided = true;
 #endif
 }
-- 
2.17.1


