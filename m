Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C66FC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C07206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvxlcxWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C07206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j22KK-0005cb-28
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 19:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j22I7-0002Vz-7L
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j22I5-0005Wp-V4
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:23:39 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:39191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j22I5-0005Vr-PE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 19:23:37 -0500
Received: by mail-pj1-x102f.google.com with SMTP id e9so1592521pjr.4
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 16:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B4yrJjvGv9DkVGdrXIq6dZpfj43fltGdT2dNbPVV5FA=;
 b=KvxlcxWEkAO2ybOp4+zTLHKIeYTgrMRDBQqPqV20utOHBXJ7Pry/sHo21qJM17tahh
 iKK5Vv8GQ2w8qBbJzKiw1+cguvcl89jt6V731oR9vFVoaLBeMpHI42C38aXr/NN/tLnE
 gtZgfGk5KoeGw85oyGBan9qYYvjreJUBtAHun+JnAxWa986Gc2bbHSxniNvzxUHVSYD2
 1IQ4o+VzEIIuBmd+rGC2vFfh4U7qyOi+Kgk7pdpcbmsLWiN2cP899icCEKFzLzyyS+eH
 n6oXdPVz1ao+zhv9PLHMpQqmL3RR468xv50yO3GUlCusA0AvAIX6UtmW/0K6/Ttnc0kr
 w3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B4yrJjvGv9DkVGdrXIq6dZpfj43fltGdT2dNbPVV5FA=;
 b=kEISq2n3a7vsqlFncryNhXo/oExtAgz6z/Utl3AzKaqvGDJYOUrs/hVDTFe7iEeLHk
 ZbToVS9gIxGnSF7N1BcwqSesLKpUhuzU6uIrENzKwLlDOE/WxVgCHKjcH3I2bHKFXfrG
 8NE1bA8by+6cWCnzInc9tjl/Ockd/JHena7ufZPSDVsRo/LmgdH2g3nUWZLWSCUb7UIq
 2NKI/14WX6iOX1At0Tq3N6fsc8j5cFNT4cr3R/6kJcsKt9D5TBFlNmomP4sYMrIlU69T
 InOO72U+jRfQgJ4mj+CFBKYqFy0q4j6sKN9bTBrbyzLwnPinVagPmP48ODrNNjRAg7UV
 d9/w==
X-Gm-Message-State: APjAAAWm+qq+pTarADPwhAau+NmdYt4n0VEjC3tVgBg/7JNzOPGZgK2A
 jll0cnsNGCQYiDY4G21JakhUiHSkd0o=
X-Google-Smtp-Source: APXvYqy6VeePBRtYD7HiypABpV1aLnLSWRqLl+5yl1Z6phGtOE/iBZ647ob5sV0323ocXxZtRJFKSA==
X-Received: by 2002:a17:90a:a10c:: with SMTP id
 s12mr1893008pjp.47.1581553416399; 
 Wed, 12 Feb 2020 16:23:36 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id j4sm365277pfh.152.2020.02.12.16.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 16:23:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] tcg: Add support for a helper with 7 arguments
Date: Wed, 12 Feb 2020 16:23:31 -0800
Message-Id: <20200213002332.31821-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213002332.31821-1-richard.henderson@linaro.org>
References: <20200213002332.31821-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102f
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
Cc: peter.maydell@linaro.org, Taylor Simpson <tsimpson@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Taylor Simpson <tsimpson@quicinc.com>

Currently, helpers can only take up to 6 arguments.  This patch adds the
capability for up to 7 arguments.  I have tested it with the Hexagon port
that I am preparing for submission.

Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-gen.h   | 13 +++++++++++++
 include/exec/helper-head.h  |  2 ++
 include/exec/helper-proto.h |  6 ++++++
 include/exec/helper-tcg.h   |  7 +++++++
 4 files changed, 28 insertions(+)

diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 236ff40524..29c02f85dc 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -66,6 +66,18 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
   tcg_gen_callN(HELPER(name), dh_retvar(ret), 6, args);                 \
 }
 
+#define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
+static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
+    dh_arg_decl(t1, 1),  dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),        \
+    dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
+    dh_arg_decl(t7, 7))                                                 \
+{                                                                       \
+  TCGTemp *args[7] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),     \
+                     dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),       \
+                     dh_arg(t7, 7) };                                   \
+  tcg_gen_callN(HELPER(name), dh_retvar(ret), 7, args);                 \
+}
+
 #include "helper.h"
 #include "trace/generated-helpers.h"
 #include "trace/generated-helpers-wrappers.h"
@@ -79,6 +91,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 #undef DEF_HELPER_FLAGS_4
 #undef DEF_HELPER_FLAGS_5
 #undef DEF_HELPER_FLAGS_6
+#undef DEF_HELPER_FLAGS_7
 #undef GEN_HELPER
 
 #endif /* HELPER_GEN_H */
diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index f2519c9741..3094c7946d 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -148,6 +148,8 @@
     DEF_HELPER_FLAGS_5(name, 0, ret, t1, t2, t3, t4, t5)
 #define DEF_HELPER_6(name, ret, t1, t2, t3, t4, t5, t6) \
     DEF_HELPER_FLAGS_6(name, 0, ret, t1, t2, t3, t4, t5, t6)
+#define DEF_HELPER_7(name, ret, t1, t2, t3, t4, t5, t6, t7) \
+    DEF_HELPER_FLAGS_7(name, 0, ret, t1, t2, t3, t4, t5, t6, t7)
 
 /* MAX_OPC_PARAM_IARGS must be set to n if last entry is DEF_HELPER_FLAGS_n. */
 
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 1c4ba9bc78..a0a8d9aa46 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -30,6 +30,11 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
 dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
                             dh_ctype(t4), dh_ctype(t5), dh_ctype(t6));
 
+#define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7) \
+dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
+                            dh_ctype(t4), dh_ctype(t5), dh_ctype(t6), \
+                            dh_ctype(t7));
+
 #include "helper.h"
 #include "trace/generated-helpers.h"
 #include "tcg-runtime.h"
@@ -42,5 +47,6 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
 #undef DEF_HELPER_FLAGS_4
 #undef DEF_HELPER_FLAGS_5
 #undef DEF_HELPER_FLAGS_6
+#undef DEF_HELPER_FLAGS_7
 
 #endif /* HELPER_PROTO_H */
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index 573c2ce2e9..27870509a2 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -52,6 +52,12 @@
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) \
     | dh_sizemask(t5, 5) | dh_sizemask(t6, 6) },
 
+#define DEF_HELPER_FLAGS_7(NAME, FLAGS, ret, t1, t2, t3, t4, t5, t6, t7) \
+  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
+    .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
+    | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) \
+    | dh_sizemask(t5, 5) | dh_sizemask(t6, 6) | dh_sizemask(t7, 7) },
+
 #include "helper.h"
 #include "trace/generated-helpers.h"
 #include "tcg-runtime.h"
@@ -65,5 +71,6 @@
 #undef DEF_HELPER_FLAGS_4
 #undef DEF_HELPER_FLAGS_5
 #undef DEF_HELPER_FLAGS_6
+#undef DEF_HELPER_FLAGS_7
 
 #endif /* HELPER_TCG_H */
-- 
2.20.1


