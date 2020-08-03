Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635FFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDA620719
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnNtqdEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDA620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YVP-0004qn-V7
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUa-0003h1-Vf
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:18:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2YUZ-0004s2-4p
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:18:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id c80so13985255wme.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/neSeNxwoki6I3Nz+WJ6z9QBWGfcGKIdgejdhynD3JY=;
 b=nnNtqdEvagU3M94UKB7O0AlcjUn6f382ygY/Gg4IVF4k6TqQkCLqVGp3ssTzrGgbtp
 l4OMMKRYEj1wxbrDL8Yl18i1HBlbBKavpGmvVloUpGsHJB08eoBlSQctu6zRdKwgZ0hU
 8c4kEdDhRS3hnwMj43r8+OQU5l8+gclQExE2mfJ5JxapnuKUwQWZ53rsoX1+zLSJr/X3
 jCN5QxtgbKgTojBQlJ8MQGXS3c7hFXJ4vuqWfjIIZ6y0dJkoO1ECI8kKJQudCNBSV2Er
 Zr0yNoJJV6S/36QWpEKHJ/fqnZ8dekQ7lAY0wtzPR5hIAG43NQdsYMxsMdoXDmxxT+1I
 f+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/neSeNxwoki6I3Nz+WJ6z9QBWGfcGKIdgejdhynD3JY=;
 b=mq54AnXnk0lZDProULItsdw/yVTXUjo+sQrGGnf5nkSIIMlOCKVKTXiONCFy/xJ3FW
 mm3jQLs9oR4ojAFZVJqkBcYnbP9KeqE1AHEf0VoVP4DE/hCjNa7ri9hrqcpxN3Xbtw7c
 QOjntymWDTS1kgDRy+E66qbbkGb/QusW85JHXwn0XTZRn6pIDHPBGkyJhHawp7g01Pgp
 ckmj5s4RQmSSaVmOFXG/ALnY//FHNXOTM4379vpoCQ6nIH95Eqk/H0qiNNY9CZQQBadU
 kE1wIzml9s0ZUS0qYS8HBd3NfZ7FRjWLu/AMUPtJXeYmSw6qEs7nGtyL/kMoeLvR2XWf
 tBTQ==
X-Gm-Message-State: AOAM531iOl7PVovBK2VN/KO5FeJoskUZ6Hm+oYYd7bMZLn+Ax3z/u82t
 +k3XHcaj5G4FBPj7ZxE8TJoRzg==
X-Google-Smtp-Source: ABdhPJzy6t2SylL51B8XyWY/J2f4HGEtgMowe0iMvxm5hsdEjn+bWFe5Nqr+8tPAIrlh8mQ7umq+5w==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr14860688wmk.86.1596453533557; 
 Mon, 03 Aug 2020 04:18:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g3sm28013170wrb.59.2020.08.03.04.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 04:18:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/7] target/arm: Pull handling of XScale insns out of
 disas_coproc_insn()
Date: Mon,  3 Aug 2020 12:18:43 +0100
Message-Id: <20200803111849.13368-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803111849.13368-1-peter.maydell@linaro.org>
References: <20200803111849.13368-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the moment we check for XScale/iwMMXt insns inside
disas_coproc_insn(): for CPUs with ARM_FEATURE_XSCALE all copro insns
with cp 0 or 1 are handled specially.  This works, but is an odd
place for this check, because disas_coproc_insn() is called from both
the Arm and Thumb decoders but the XScale case never applies for
Thumb (all the XScale CPUs were ARMv5, which has only Thumb1, not
Thumb2 with the 32-bit coprocessor insn encodings).  It also makes it
awkward to convert the real copro access insns to decodetree.

Move the identification of XScale out to its own function
which is only called from disas_arm_insn().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 44 ++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c39a929b938..a2765fc60b2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4551,20 +4551,6 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 
     cpnum = (insn >> 8) & 0xf;
 
-    /* First check for coprocessor space used for XScale/iwMMXt insns */
-    if (arm_dc_feature(s, ARM_FEATURE_XSCALE) && (cpnum < 2)) {
-        if (extract32(s->c15_cpar, cpnum, 1) == 0) {
-            return 1;
-        }
-        if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
-            return disas_iwmmxt_insn(s, insn);
-        } else if (arm_dc_feature(s, ARM_FEATURE_XSCALE)) {
-            return disas_dsp_insn(s, insn);
-        }
-        return 1;
-    }
-
-    /* Otherwise treat as a generic register access */
     is64 = (insn & (1 << 25)) == 0;
     if (!is64 && ((insn & (1 << 4)) == 0)) {
         /* cdp */
@@ -4823,6 +4809,23 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
     return 1;
 }
 
+/* Decode XScale DSP or iWMMXt insn (in the copro space, cp=0 or 1) */
+static void disas_xscale_insn(DisasContext *s, uint32_t insn)
+{
+    int cpnum = (insn >> 8) & 0xf;
+
+    if (extract32(s->c15_cpar, cpnum, 1) == 0) {
+        unallocated_encoding(s);
+    } else if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
+        if (disas_iwmmxt_insn(s, insn)) {
+            unallocated_encoding(s);
+        }
+    } else if (arm_dc_feature(s, ARM_FEATURE_XSCALE)) {
+        if (disas_dsp_insn(s, insn)) {
+            unallocated_encoding(s);
+        }
+    }
+}
 
 /* Store a 64-bit value to a register pair.  Clobbers val.  */
 static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
@@ -8270,15 +8273,26 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     case 0xc:
     case 0xd:
     case 0xe:
-        if (((insn >> 8) & 0xe) == 10) {
+    {
+        /* First check for coprocessor space used for XScale/iwMMXt insns */
+        int cpnum = (insn >> 8) & 0xf;
+
+        if (arm_dc_feature(s, ARM_FEATURE_XSCALE) && (cpnum < 2)) {
+            disas_xscale_insn(s, insn);
+            break;
+        }
+
+        if ((cpnum & 0xe) == 10) {
             /* VFP, but failed disas_vfp.  */
             goto illegal_op;
         }
+
         if (disas_coproc_insn(s, insn)) {
             /* Coprocessor.  */
             goto illegal_op;
         }
         break;
+    }
     default:
     illegal_op:
         unallocated_encoding(s);
-- 
2.20.1


