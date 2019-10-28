Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6897DCA9EC3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BE4222C5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJCCJ2oT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BE4222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6hQ-0006ZT-Kl
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uo-0007XA-QB
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Um-00044l-Td
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:50 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Uj-00043h-T9
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:47 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n15so10199980wrw.13
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xrU7w4s7KSKnwqBpSI+WZTUaBsgqmQLo3umhoYb3GT8=;
 b=WJCCJ2oTpp+tWKf6mXQ/dvcaQaxrUpqCWL4VFs3Jb22hfO9D9a5isRA4YPGMDZNLN9
 fAL8fDy9gFonH/bW+UAvXJCeHfLOsO1va9R6wVno/Hh2dJqKj6/WpdKCXKG0D+13h+3S
 kJbc7o/l1E42XwNEIIrhTigTjjTBkA/g9irNBgU8R2S+cPjzOhFpGdsBOnmw6sNGDovK
 Wj0c/ZdPoRDwo1LnFxHLEGCQwU1QYxSO2zJb2f+pb8MZVwkrwDBpPL9A6D8aWyfc34p1
 v1ONbRJCD3VAsXmlwLdXW79cPCm0NdTEr8p3ctxddNxCJGaxngpvL1uXZ1yVJLx5TZFz
 JRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xrU7w4s7KSKnwqBpSI+WZTUaBsgqmQLo3umhoYb3GT8=;
 b=AZYFCDOMI9tKBlQOUfcbnF3lZWhIPwDY0IGVngnYC6d7d0wePJ62b3VJr2odku2/vF
 FuwGZJJtyRuwpz2l//wIP6eRjVghUjpFq7Z3KZlbQfxXqIwJJSBe2j4ecjaHFRVwqWMo
 24P/vXPwIEIMsZUmjHj5UI5ycysOwPLi/hU2s7zYjYWmtfwn5mkGjRafO1CWWzdiVEVR
 Usd74WANziOxEZNqNSVUzAPOGkMk2MxkXP0dwWdQNe9F0homZBqMmMT79YLve6iSvPoF
 uFwLo+z9LtXIoY7y6gkAwFaPAypx9a/ip17QqBs4bxq+zImwD+D4bRknkCTm2028v921
 jIjA==
X-Gm-Message-State: APjAAAXUVp3mPxSap6sACs90oIwdMgWkvzuxYudEbl/JSfkJRy+VXUJO
 j3NbK9ZhO25LW/r5OIiFkHRmw0WS1vn0aA==
X-Google-Smtp-Source: APXvYqyuLysnOgizh4jiAve6pX33fbanxvixoYNJUhWzr/RJgyIKLSaUYvPkCcQRkPzVvwiAVIN6Uw==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr15714161wru.184.1572274784547; 
 Mon, 28 Oct 2019 07:59:44 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/12] exec: Use const alias for TARGET_PAGE_BITS_VARY
Date: Mon, 28 Oct 2019 15:59:31 +0100
Message-Id: <20191028145937.10914-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

Using a variable that is declared "const" for this tells the
compiler that it may read the value once and assume that it
does not change across function calls.

For target_page_size, this means we have only one assert per
function, and one read of the variable.

This reduces the size of qemu-system-aarch64 by 8k.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 14 ++++++---
 exec-vary.c            | 66 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 255bb186ac..0b449b98ba 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -210,10 +210,16 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
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
+#if defined(CONFIG_ATTRIBUTE_ALIAS) || !defined(IN_EXEC_VARY)
+extern const TargetPageBits target_page;
+#else
+extern TargetPageBits target_page;
+#endif
+#define TARGET_PAGE_BITS   ({ assert(target_page.decided); target_page.bits; })
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 #endif
diff --git a/exec-vary.c b/exec-vary.c
index 48c0ab306c..8725fd0285 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -19,11 +19,55 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+
+#define IN_EXEC_VARY 1
+
 #include "exec/exec-all.h"
 
 #ifdef TARGET_PAGE_BITS_VARY
-int target_page_bits;
-bool target_page_bits_decided;
+# ifdef CONFIG_ATTRIBUTE_ALIAS
+/*
+ * We want to declare the "target_page" variable as const, which tells
+ * the compiler that it can cache any value that it reads across calls.
+ * This avoids multiple assertions and multiple reads within any one user.
+ *
+ * This works because we finish initializing the data before we ever read
+ * from the "target_page" symbol.
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
+#  pragma GCC diagnostic push
+#  pragma GCC diagnostic ignored "-Wredundant-decls"
+
+extern const TargetPageBits target_page
+    __attribute__((alias("init_target_page")));
+
+#  pragma GCC diagnostic pop
+# else
+/*
+ * When aliases are not supported then we force two different declarations,
+ * by way of suppressing the header declaration with IN_EXEC_VARY.
+ * We assume that on such an old compiler, LTO cannot be used, and so the
+ * compiler cannot not detect the mismatched declarations, and all is well.
+ */
+TargetPageBits target_page;
+#  define init_target_page target_page
+# endif
 #endif
 
 bool set_preferred_target_page_bits(int bits)
@@ -36,11 +80,11 @@ bool set_preferred_target_page_bits(int bits)
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
@@ -49,9 +93,15 @@ bool set_preferred_target_page_bits(int bits)
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
+
+    /*
+     * For the benefit of an -flto build, prevent the compiler from
+     * hoisting a read from target_page before we finish initializing.
+     */
+    barrier();
 #endif
 }
-- 
2.17.1


