Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E82C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D75B2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZgHwgh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D75B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33pb-0004q9-7T
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Ga-0003qI-UF
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GY-0000U2-9h
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GX-0000SS-Rx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:58 -0400
Received: by mail-pf1-x444.google.com with SMTP id o70so392977pfg.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KXE4hVmZacLzuX33iQjpmlKGdB6TuKckRZ/72v9bQQk=;
 b=aZgHwgh+b1xKZZtQAGid0XF1L78eoFZxH2DTxeTOIsYWoJP2Y0opJz/1ZYDqzw78Jz
 nAEOvqRuJm+03kz1scei3OiHgYQrIYetucMk1sNcgyqsWOKSJUzdcKAsecDOXBlhnion
 ettg6m91Ugt1fPOPck2h1RPCAALyTpkEV+5cdfUFzykq2aM9bXrhn6oYUNFYHrS0MPXS
 qd6hSbuo0FFYtP6HW2ocz6pfGqpstxmvVCyOK0Hp64EBiI8c1cZm+JpWdlGUCkmGEW+S
 h8uF7Q+bgraJcDcpbhBuLzKEGCcdZPPXJMO834wUOoSRpAaLjP70uwjPe4LUw5CfpNu7
 aa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KXE4hVmZacLzuX33iQjpmlKGdB6TuKckRZ/72v9bQQk=;
 b=GiP1ZSOsGvXV9ZLd0F5JNdxiYsgss/9Ov+HlSQCn/tIcHExPT7JNjSD2B0YpsTPpTB
 Cca7/Efg3ztF+WFQFb6A8jX6iI1fkjRKTAwwUIr/YzyT7y9E1AAeeo7l9Q9USuAiTqvi
 oInkoZiypa1G6iaKzhewJsrN9p/R/L77u8tXNumJhor4iHANxEGMppQWlhrILO+SzSJF
 CInSGroV/CbQH1aWZB9g6RZ7OvjfxwKp8dwjQ5eqGuw6pmlqM2Yupn4XVr1byliEZ6Vt
 OFO0QprnEifcILCVzMS3XcyqvxzDqMOJ1yonkC2n7v+vz+bX8DKbdRAVcqZXjBacnnIy
 YaKA==
X-Gm-Message-State: APjAAAWg+44MRTwoWkQXtSbd+vx1vw4eWiaJW7Wxv5kcypb7iZrBgn0a
 Dsz8y1itoIvFnNbP5dAAyngyUXN9ci0=
X-Google-Smtp-Source: APXvYqwn1bfRjNrpkAJArOeHbpgYgvViSdiUyreUxGNpm2zdvqSG7IlxwGFSygl+NebHGRJBrq/OYg==
X-Received: by 2002:aa7:9516:: with SMTP id b22mr6494250pfp.106.1567019156208; 
 Wed, 28 Aug 2019 12:05:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:31 -0700
Message-Id: <20190828190456.30315-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 44/69] target/arm: Simplify disas_arm_insn
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fold away all of the cases that now just goto illegal_op,
because all of their internal bits are now in decodetree.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 69 ++++++++++--------------------------------
 1 file changed, 16 insertions(+), 53 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5bb1d13a3d..defbcf68db 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10341,7 +10341,7 @@ static bool trans_PLI(DisasContext *s, arg_PLD *a)
 
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
-    unsigned int cond, op1;
+    unsigned int cond = insn >> 28;
 
     /* M variants do not implement ARM mode; this must raise the INVSTATE
      * UsageFault exception.
@@ -10351,7 +10351,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                            default_exception_el(s));
         return;
     }
-    cond = insn >> 28;
 
     if (cond == 0xf) {
         /* In ARMv3 and v4 the NV condition is UNPREDICTABLE; we
@@ -10416,11 +10415,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 goto illegal_op;
             }
             return;
-        } else if ((insn & 0x0fe00000) == 0x0c400000) {
-            /* Coprocessor double register transfer.  */
-            ARCH(5TE);
-        } else if ((insn & 0x0f000010) == 0x0e000010) {
-            /* Additional coprocessor register transfer.  */
         }
         goto illegal_op;
     }
@@ -10435,55 +10429,24 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     }
     /* fall back to legacy decoder */
 
-    if ((insn & 0x0f900000) == 0x03000000) {
-        /* All done in decodetree.  Illegal ops reach here.  */
-        goto illegal_op;
-    } else if ((insn & 0x0f900000) == 0x01000000
-               && (insn & 0x00000090) != 0x00000090) {
-        /* miscellaneous instructions */
-        /* All done in decodetree.  Illegal ops reach here.  */
-        goto illegal_op;
-    } else if (((insn & 0x0e000000) == 0 &&
-                (insn & 0x00000090) != 0x90) ||
-               ((insn & 0x0e000000) == (1 << 25))) {
-        /* Data-processing (reg, reg-shift-reg, imm).  */
-        /* All done in decodetree.  Reach here for illegal ops.  */
-        goto illegal_op;
-    } else {
-        /* other instructions */
-        op1 = (insn >> 24) & 0xf;
-        switch(op1) {
-        case 0x0:
-        case 0x1:
-        case 0x4:
-        case 0x5:
-        case 0x6:
-        case 0x7:
-        case 0x08:
-        case 0x09:
-        case 0xa:
-        case 0xb:
-        case 0xf:
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
-        case 0xc:
-        case 0xd:
-        case 0xe:
-            if (((insn >> 8) & 0xe) == 10) {
-                /* VFP.  */
-                if (disas_vfp_insn(s, insn)) {
-                    goto illegal_op;
-                }
-            } else if (disas_coproc_insn(s, insn)) {
-                /* Coprocessor.  */
+    switch ((insn >> 24) & 0xf) {
+    case 0xc:
+    case 0xd:
+    case 0xe:
+        if (((insn >> 8) & 0xe) == 10) {
+            /* VFP.  */
+            if (disas_vfp_insn(s, insn)) {
                 goto illegal_op;
             }
-            break;
-        default:
-        illegal_op:
-            unallocated_encoding(s);
-            break;
+        } else if (disas_coproc_insn(s, insn)) {
+            /* Coprocessor.  */
+            goto illegal_op;
         }
+        break;
+    default:
+    illegal_op:
+        unallocated_encoding(s);
+        break;
     }
 }
 
-- 
2.17.1


