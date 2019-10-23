Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F2CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20E22086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEmAmX23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20E22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNK5R-0003zg-NN
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp4-0004mb-PT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp2-0005Z8-Un
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:18 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:42859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNIp1-0005R8-1L
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:15 -0400
Received: by mail-qt1-x843.google.com with SMTP id w14so32933492qto.9
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GvLqP4YBrj+nrlStAyuwbfcMGIRPPiTu+vJ+23TQgAw=;
 b=aEmAmX23InlnUT2icHg3aEvWcd49dzoz4tbuKp+wnSiTzBvcUrDLYrPrMHv9kwvBoR
 b9WlmgYjlZNXvCaej6FvgZSEcjkfVLvTg0I2djVAFWAo0wCkqt0x/I/MGRu5n0mKdczy
 EgPCoqsGfSzTt6VKsxkEkJndlPDk6k+3KNgacLCS2Ybu495vzIGN4JYK05cRLjoQZ76+
 cNKnvW5Q21wIaLH1lFYI589K+Sx2g3Eq9EJ68KivWEP/s/pI9xrm6vTjbjMKjlnm7zjK
 G/5Nh2kpQH5y7DvVUzICh0Vt4VXFkQV0U2P63J1fm3dAzE8v/SkuOHN0HXK/YHErMhkM
 vuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GvLqP4YBrj+nrlStAyuwbfcMGIRPPiTu+vJ+23TQgAw=;
 b=bsiBlAs5Cc30BerFvt6cBckN5g5tX5K61GIRRkUDZAxC4GCXk9wW+IsujyEOIkSvU/
 WfNSplOqd1SHGK5u+AxAYZvyn43sPN+Vw+dY57VCxxThbSI2o9kWc0VnZ18wIIJXTrw+
 E/y66wF4tO1NSfsL8SJmOF+BEW13bsdhgc1mc4tvsqZmm19j6QzdxUZU1XrCvu33UDiv
 nv0Va0ntohc8F2iNSq/YM2nJycx5iKmDCZ4cnGGJ2k8KHqzPVsDNQgQxLrYE2kJHLQlI
 cnPwvULRxcpHnKjinb77md85PFRnj6ST51M8V9toFHatcFT9fxORhu4RHD8vqVAl0UWT
 ltnw==
X-Gm-Message-State: APjAAAVIWCbhcTswvbxCXC/zL6hqs4Xc4fnK+iXDbAuBqNXO1x5F/ROr
 lxmPEcM6XDWjaw7d+8MnzrksswKVnZk=
X-Google-Smtp-Source: APXvYqzPMQXqII0RIFiLAvVcq6huIg3ZdYpjVAcAQydEIsP9Juw2FS79y0dcZR3YvaOHq2B9IG9zyA==
X-Received: by 2002:aed:2687:: with SMTP id q7mr9746711qtd.382.1571845512179; 
 Wed, 23 Oct 2019 08:45:12 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id o1sm2456272qtb.82.2019.10.23.08.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:45:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] exec: Use const alias for TARGET_PAGE_BITS_VARY
Date: Wed, 23 Oct 2019 11:45:02 -0400
Message-Id: <20191023154505.30521-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023154505.30521-1-richard.henderson@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using a variable that is declared "const" for this tells the
compiler that it may read the value once and assume that it
does not change across function calls.

For target_page_size, this means we have only one assert per
function, and one read of the variable.

This reduces the size of qemu-system-aarch64 by 8k.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Notice CONFIG_ATTRIBUTE_ALIAS, and work around Xcode 9 lossage.
---
 include/exec/cpu-all.h | 14 +++++++---
 exec-vary.c            | 60 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 255bb186ac..76515dc8d9 100644
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
+# if defined(CONFIG_ATTRIBUTE_ALIAS) || !defined(IN_EXEC_VARY)
+extern const TargetPageBits target_page;
+#else
+extern TargetPageBits target_page;
+# endif
+#define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 #endif
diff --git a/exec-vary.c b/exec-vary.c
index 48c0ab306c..e0befd502a 100644
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
@@ -49,9 +93,9 @@ bool set_preferred_target_page_bits(int bits)
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


