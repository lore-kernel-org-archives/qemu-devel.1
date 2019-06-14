Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFDC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433B9205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iedGUINC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433B9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrC3-0002vU-Hw
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34180)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0Q-0007A0-QK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0N-00049P-DM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0M-0003up-7F
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id a15so3145584wmj.5
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M9pjVZf2vmVt0qPRpyohqMfwA1FkxEKe0Yjf3n3HoWM=;
 b=iedGUINCZYuC4fwc28TFy3USZ4JCp6y8qiISt2ZYUhcAu43siybfwyBjoaWfjfTnDN
 ifHXchm9hegUWABSf9k9xxjf86oFPJ7vNk4+23RZITagCkTLhfA9J0xbwWiJ/Vesa4lB
 taWaj01xyxOFX/7w4JXJYrMzWxjmPn6TO6EksJAlhwHbRIggla4bhcUQwlJvEtOR/tl9
 euxt8g2TwFD5YCeTvNjbukB0ocgmI+2O2aqP2xmDng1EFEbH1dgINFfbN9+hZmSb+RTh
 RjCRhyZX3slbFfZFxXSb+u4iJRVV14anSpfTYwWp6Pq0AWLiJ8irDIWmnp+QjkD692pI
 2zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M9pjVZf2vmVt0qPRpyohqMfwA1FkxEKe0Yjf3n3HoWM=;
 b=PeaJ+Xc12j1LH1mZgqohrGAjcHcoVHDrKsTVihuHwucsh0qM700HXAMJSgvJBWDLV1
 Ifh2q97IDaswQqeNU7ApY1CZOIBm6kMEE7BzbyAQPFHm7Vicieg7Z2H8D155Ee/7dfie
 wtSxijsmrsJJt18BBNQaYMdHcemeccSSgTaPhY1NPXEfhnSEkUJAUpRZOcsDVr9qWILx
 k+XRJj42v7bw2Gjx3pm8y3T5wq7dj4WfOA0l5FF0lK7OgGZ+2FB35/wXkH3t5vs3O4Ec
 +JS152pNF5HJhaGdNIpQP7hs2CMTNUGArG+Z3rTxxMjIXfupL3BskuABL/0LoBLSdo0v
 0i+A==
X-Gm-Message-State: APjAAAWtHhtsFmLBrX2HG0Q67CVcVJFMzxC/gIsI/RhSROs7vdccM+nq
 pVB6ZOR/r1+Fw6OzGyC/zjAuznTkYos=
X-Google-Smtp-Source: APXvYqyelPlKrgmQBwFBI7WLeymq9VOP+8CbOBoe3Q/SvtGzaUaP9+x+Au2xgUtRg3fXhWc5inhlzQ==
X-Received: by 2002:a05:600c:2243:: with SMTP id
 a3mr8531302wmm.83.1560533316231; 
 Fri, 14 Jun 2019 10:28:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j123sm6629837wmb.32.2019.06.14.10.28.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBD191FFAE;
 Fri, 14 Jun 2019 18:12:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:35 +0100
Message-Id: <20190614171200.21078-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH  v3 25/50] translator: add translator_ld{ub, sw,
 uw, l, q}
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/translator.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 180c51d509..33fa709ba6 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,10 @@
  */
 
 
+#include "qemu/bswap.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/plugin-gen.h"
 #include "tcg/tcg.h"
 
 
@@ -142,4 +145,29 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
 void translator_loop_temp_check(DisasContextBase *db);
 
-#endif /* EXEC__TRANSLATOR_H */
+#define GEN_TRANSLATOR_LD(fullname, name, type, swap_fn)                \
+    static inline type                                                  \
+    fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
+    {                                                                   \
+        type ret = cpu_ ## name ## _code(env, pc);                      \
+                                                                        \
+        if (do_swap) {                                                  \
+            ret = swap_fn(ret);                                         \
+        }                                                               \
+        plugin_insn_append(&ret, sizeof(ret));                          \
+        return ret;                                                     \
+    }                                                                   \
+                                                                        \
+    static inline type fullname(CPUArchState *env, abi_ptr pc)          \
+    {                                                                   \
+        return fullname ## _swap(env, pc, false);                       \
+    }
+
+GEN_TRANSLATOR_LD(translator_ldub, ldub, uint8_t, /* no swap needed */)
+GEN_TRANSLATOR_LD(translator_ldsw, ldsw, int16_t, bswap16)
+GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, bswap64)
+#undef GEN_TRANSLATOR_LD
+
+#endif  /* EXEC__TRANSLATOR_H */
-- 
2.20.1


