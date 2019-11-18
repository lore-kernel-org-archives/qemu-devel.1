Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7601C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F932067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0UXfX9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F932067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWd7n-0002gF-Nt
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWd79-0002Gk-OP
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWd78-00039T-6G
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:14:31 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWd77-00038l-WD
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:14:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id z26so16458652wmi.4
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 01:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=tJk3+iTUR48YALvjXNfn4QnMHtBeVqze3Y5HOPt2s4c=;
 b=s0UXfX9VCMvwMi9CVUSJgWnUfXLTNUkaQfAQCrlnDWildcyLnKZsa3cFmw+T4hdXXM
 Pc2yPzvyyQw0h6hk1x0zS6Vk26S0fXOU6BSWukfeA3QSAdGIMfNxbP8ZgbNGN2W2E16Y
 5bMkY5Lon4sJ9+C42kscV2X1MZyyvtE9u83RkZZ6sNBpCJctZGjN0z+0KQdA9QncFBe5
 LkzG5GySWDFQ+7QOVkcsN/6JoE7rcftQ3PR3pOjrwwE8+9drTWmaqykHEHfIiDztNRDn
 iNfjw6aHLlm7HdwGYX0iFyRoxGsqCdpvNgPwL1tGpfmZ3HniZGCFaNPaG8wbWtO+AT3O
 jZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=tJk3+iTUR48YALvjXNfn4QnMHtBeVqze3Y5HOPt2s4c=;
 b=CoYS0CA/ov3CNt7rgTLCyaTAn0Vi1uO/OC5sZKY7Onw42i5q1htCWhBhi1IPBWolDZ
 EZ5vH4rRVg4Hr5hIVXiheud9Alqaf6q/nUd5d+dX4X2WlR6OZ+gLnJhIlQNpym2GZXpz
 GeOv1jeDMYCrlBd3LnVEJCGiQZKsbohyV1gh8uslYD8I0kquak3etgcnDJG33qFHTQ8o
 4IpzdkdRyWQcsusaYpKOqzKtF8ZO4cze9s3aL6jArQJj+qnq1UD61WHCgOLngOzgeE/J
 8W5eIM+nYeSG1bb+/f5z9dpog+7D7ccjggCpDouWiZc1dPMaS++wCoI9NpN1fwyP2IVY
 YbZg==
X-Gm-Message-State: APjAAAVtBZInJ4XEdPyoJvVcgF2PoIMsVXnZjU4AkrAhXp5vdWzh9tbt
 t/dNeeT3HANg1zZ3xOF+EzPDgapRWb3Q0A==
X-Google-Smtp-Source: APXvYqwaLAv4htzAL4zouhywgXdxxhqHQ3XmO1i3INgbSL6L/TMQWRRjjZyHlFBH7yJ1lejR2NTcPA==
X-Received: by 2002:a1c:8086:: with SMTP id
 b128mr27492095wmd.104.1574068468287; 
 Mon, 18 Nov 2019 01:14:28 -0800 (PST)
Received: from localhost.localdomain (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id z2sm10202655wrs.89.2019.11.18.01.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 01:14:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] target/arm: Merge arm_cpu_vq_map_next_smaller into sole
 caller
Date: Mon, 18 Nov 2019 10:14:14 +0100
Message-Id: <20191118091414.19440-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity reports, in sve_zcr_get_valid_len,

"Subtract operation overflows on operands
arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"

First, the aarch32 stub version of arm_cpu_vq_map_next_smaller,
returning 0, does exactly what Coverity reports.  Remove it.

Second, the aarch64 version of arm_cpu_vq_map_next_smaller has
a set of asserts, but they don't cover the case in question.
Further, there is a fair amount of extra arithmetic needed to
convert from the 0-based zcr register, to the 1-base vq form,
to the 0-based bitmap, and back again.  This can be simplified
by leaving the value in the 0-based form.

Finally, use test_bit to simplify the common case, where the
length in the zcr registers is in fact a supported length.

Reported-by: Coverity (CID 1407217)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

v2: Merge arm_cpu_vq_map_next_smaller into sve_zcr_get_valid_len,
    as suggested by Andrew Jones.

v3: Use test_bit to make the code even more obvious; the
    current_length + 1 thing to let us find current_length in the
    bitmap seemed unnecessarily clever.  (For real this time).

---
 target/arm/cpu.h    |  3 ---
 target/arm/cpu64.c  | 15 ---------------
 target/arm/helper.c |  9 +++++++--
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e1a66a2d1c..47d24a5375 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -185,12 +185,9 @@ typedef struct {
 #ifdef TARGET_AARCH64
 # define ARM_MAX_VQ    16
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
-uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
 #else
 # define ARM_MAX_VQ    1
 static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
-static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
-{ return 0; }
 #endif
 
 typedef struct ARMVectorReg {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 68baf0482f..a39d6fcea3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -458,21 +458,6 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
     cpu->sve_max_vq = max_vq;
 }
 
-uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
-{
-    uint32_t bitnum;
-
-    /*
-     * We allow vq == ARM_MAX_VQ + 1 to be input because the caller may want
-     * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
-     * function always returns the next smaller than the input.
-     */
-    assert(vq && vq <= ARM_MAX_VQ + 1);
-
-    bitnum = find_last_bit(cpu->sve_vq_map, vq - 1);
-    return bitnum == vq - 1 ? 0 : bitnum + 1;
-}
-
 static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index be67e2c66d..a089fb5a69 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5363,9 +5363,14 @@ int sve_exception_el(CPUARMState *env, int el)
 
 static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
 {
-    uint32_t start_vq = (start_len & 0xf) + 1;
+    uint32_t end_len;
 
-    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
+    end_len = start_len &= 0xf;
+    if (!test_bit(start_len, cpu->sve_vq_map)) {
+        end_len = find_last_bit(cpu->sve_vq_map, start_len);
+        assert(end_len < start_len);
+    }
+    return end_len;
 }
 
 /*
-- 
2.17.1


