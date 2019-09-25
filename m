Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF73C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A899221D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qjp0JUK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A899221D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCLa-0003mc-Ae
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 14:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIa-0001j1-N9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIZ-0004Ef-Go
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:00 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:43869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIZ-0004EV-BO
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:59 -0400
Received: by mail-pl1-x633.google.com with SMTP id f21so539425plj.10
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dpjQdA7JkkGx46Rli+yrKoXDpXOevLhotnlmbVLP3mg=;
 b=Qjp0JUK4Dp2sjVrTeu15m/JGRzbnlZ6vOzaGsjOFpVbDafFjxvP/+VWwO4qCL6lMpN
 /f5LTA+VcRpqny0zfq4rV9x0+tOxnecAoVt3CtJjHnn5PAwCYHrn4jwLAmG3NRfgVXHY
 jr8ceFM59yM+QasTIOdgNkU2cquP2vwnnNIQSESr8l15nwn7T4xJ+IvxSMrnRJTUmYhE
 TQmr7aQXVHuKlYC2BWthrQkj1qgM2MFhxvMkxNsz5bNr8DWqmtQuGx3Xq4U+WPvPhHfy
 1T/G1rDE15TR8RVnqRFc3Of4cEye/gVBUB7PHK0vz+IhMWk5IdKptEdlIQoq4WmxAMQZ
 8HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dpjQdA7JkkGx46Rli+yrKoXDpXOevLhotnlmbVLP3mg=;
 b=V7gkPVapJ/tft8/l0Za7tGo94bBmcrT4PWueDWmCnXkQkkZPux4hxQS5xBxIf0EAl9
 jai16Iy8QwIwrSrrH9Qbs+f3AhLUDfLV3598jsdbLs6x1CZa/2Qr92TkOGtMQYR8bwNz
 t4MQsFUpp9YeZCOjqM8zphEF7NgkkQAoyaQfYI2RtRD2zrZM4qgb0kE5II1rJ54jHz1r
 qd1f8e00tClJ65jurES3i86LKLz83ByqXZ5hnbM7B2YaqK8k1pGvxmio1MBHK5LJqPNS
 zpbNoz+JiObC885eEneIKjX8eXn16XOUdM1FQ9MREWPzvsMIMzUoykQIn2S5heiDHAoc
 SpBw==
X-Gm-Message-State: APjAAAWrrWfPFbyj38ZGIRf/YnrI+KcxWqmZOrjN/cKSqLJTltloHOGW
 YH/DXzvpDSldEjkTYYSXJHcISUhbzWY=
X-Google-Smtp-Source: APXvYqwZ2XcvxeQ+ATkGKbsyArgQcecB9ChDUhN8ioViVvXEBYGV7iYDRzrkf/PnCwq8b1fqcQGtXg==
X-Received: by 2002:a17:902:fe86:: with SMTP id
 x6mr10925297plm.28.1569437157768; 
 Wed, 25 Sep 2019 11:45:57 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:45:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] cputlb: Split out load/store_memop
Date: Wed, 25 Sep 2019 11:45:37 -0700
Message-Id: <20190925184548.30673-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
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

We will shortly be using these more than once.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 107 +++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e31378bce3..eeba8c9847 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1281,6 +1281,29 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
                                 TCGMemOpIdx oi, uintptr_t retaddr);
 
+static inline uint64_t QEMU_ALWAYS_INLINE
+load_memop(const void *haddr, MemOp op)
+{
+    switch (op) {
+    case MO_UB:
+        return ldub_p(haddr);
+    case MO_BEUW:
+        return lduw_be_p(haddr);
+    case MO_LEUW:
+        return lduw_le_p(haddr);
+    case MO_BEUL:
+        return (uint32_t)ldl_be_p(haddr);
+    case MO_LEUL:
+        return (uint32_t)ldl_le_p(haddr);
+    case MO_BEQ:
+        return ldq_be_p(haddr);
+    case MO_LEQ:
+        return ldq_le_p(haddr);
+    default:
+        qemu_build_not_reached();
+    }
+}
+
 static inline uint64_t QEMU_ALWAYS_INLINE
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             uintptr_t retaddr, MemOp op, bool code_read,
@@ -1373,33 +1396,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-    switch (op) {
-    case MO_UB:
-        res = ldub_p(haddr);
-        break;
-    case MO_BEUW:
-        res = lduw_be_p(haddr);
-        break;
-    case MO_LEUW:
-        res = lduw_le_p(haddr);
-        break;
-    case MO_BEUL:
-        res = (uint32_t)ldl_be_p(haddr);
-        break;
-    case MO_LEUL:
-        res = (uint32_t)ldl_le_p(haddr);
-        break;
-    case MO_BEQ:
-        res = ldq_be_p(haddr);
-        break;
-    case MO_LEQ:
-        res = ldq_le_p(haddr);
-        break;
-    default:
-        qemu_build_not_reached();
-    }
-
-    return res;
+    return load_memop(haddr, op);
 }
 
 /*
@@ -1530,6 +1527,36 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
+static inline void QEMU_ALWAYS_INLINE
+store_memop(void *haddr, uint64_t val, MemOp op)
+{
+    switch (op) {
+    case MO_UB:
+        stb_p(haddr, val);
+        break;
+    case MO_BEUW:
+        stw_be_p(haddr, val);
+        break;
+    case MO_LEUW:
+        stw_le_p(haddr, val);
+        break;
+    case MO_BEUL:
+        stl_be_p(haddr, val);
+        break;
+    case MO_LEUL:
+        stl_le_p(haddr, val);
+        break;
+    case MO_BEQ:
+        stq_be_p(haddr, val);
+        break;
+    case MO_LEQ:
+        stq_le_p(haddr, val);
+        break;
+    default:
+        qemu_build_not_reached();
+    }
+}
+
 static inline void QEMU_ALWAYS_INLINE
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
              TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
@@ -1657,31 +1684,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
  do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-    switch (op) {
-    case MO_UB:
-        stb_p(haddr, val);
-        break;
-    case MO_BEUW:
-        stw_be_p(haddr, val);
-        break;
-    case MO_LEUW:
-        stw_le_p(haddr, val);
-        break;
-    case MO_BEUL:
-        stl_be_p(haddr, val);
-        break;
-    case MO_LEUL:
-        stl_le_p(haddr, val);
-        break;
-    case MO_BEQ:
-        stq_be_p(haddr, val);
-        break;
-    case MO_LEQ:
-        stq_le_p(haddr, val);
-        break;
-    default:
-        qemu_build_not_reached();
-    }
+    store_memop(haddr, val, op);
 }
 
 void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
-- 
2.17.1


