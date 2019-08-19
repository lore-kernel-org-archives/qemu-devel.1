Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401C5C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C10214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPb1t8l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C10214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpf3-0001cM-TX
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpM4-0001eB-FI
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpM2-0006A0-Sb
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:20 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpM2-00069R-Mc
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:18 -0400
Received: by mail-pg1-x541.google.com with SMTP id x15so1926604pgg.8
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zZYWccT7CCrzOlrmxHsfHjAEIVHw6UJ7WILoC7VO3SU=;
 b=PPb1t8l9YP39KVfPVkg+miZTF3Jpd18TujsLmnHArLFTCMt3WmDDzdA6EsoAqoVjBP
 9XYQLpHfU9Dtg03+e7F8WObuM9K8a2qXgNojBce1Z1WW/ZzX1fM+drr23SPgMr5L/Lg/
 pBHY+l6/RwDzHbfz+YCpWwPW7yyg4eL1AlnDU1zL4XIEuXEYRqaazEB3ysP1ATZPiARm
 d3/nToby9TXFpQWg+doyEX24e3ugljUBAreYveJSuvwY0EV7OZ38V70yZTrxdG3ihNtm
 NwAS3XSVFmisUOZJqoA8KAx4gPTDYllXP1sO7uPKaMWbIvZJtKqLKxv+uk+XMEIpRftJ
 4Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zZYWccT7CCrzOlrmxHsfHjAEIVHw6UJ7WILoC7VO3SU=;
 b=bJJ1wfDH0849zny+DL2W6qLlFhwmYWkAtvmAmPXOiHcFpxaBCMI9KiOpOtYwUZ74F8
 mcyW/JE6nkGw3ZrsYAI/hF8wd9EcsExVaTKFdHAV/BrhNe86mNmMdyFYfA/pjH9OTDa/
 BsPultStD8ClOS6fFyhRQarK4OunRZLwViDoYPStcVXw5Hpc9oz5T0/v3/FSrbvINXa6
 SFo2rfGICwVj5gQTk1l1xm6MWGRtp+8Ng1oASD5/+PGs4rWqnwg9rplh86SwZYDSrFP5
 7qywwx6QbiyY/1Y2U+PFlKwP+dvHIwrNTt1jyW/jof5Cyvza4hRPTuzPZKAGruD1yBwl
 SSqQ==
X-Gm-Message-State: APjAAAWi+Xa8ywQSmdaMWb4ORBo9kMOpvDwtOmIysXdQ62qeoYJnDzf1
 sem+T0b2KguSwpKa2s6vrZxm1B1ZA+A=
X-Google-Smtp-Source: APXvYqzDroV08IYwhlvi7ngTP+2jkDNYwf9Pzr2ACQjTPqbmJInnqhAi1ZRHYOnXbrcVMzyCnEs3TA==
X-Received: by 2002:a63:1f03:: with SMTP id f3mr21523509pgf.249.1566250697329; 
 Mon, 19 Aug 2019 14:38:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:03 -0700
Message-Id: <20190819213755.26175-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 16/68] target/arm: Convert CLZ
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

Document our choice about the T32 CONSTRAINED UNPREDICTABLE behaviour.
This matches the undocumented choice made by the legacy decoder.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 31 +++++++++++++++----------------
 target/arm/a32.decode  |  4 ++++
 target/arm/t32.decode  |  5 +++++
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ef26ed7b57..f0fa5253b6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8461,6 +8461,19 @@ static bool trans_BLX_r(DisasContext *s, arg_BLX_r *a)
     return true;
 }
 
+static bool trans_CLZ(DisasContext *s, arg_CLZ *a)
+{
+    TCGv_i32 tmp;
+
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    tmp = load_reg(s, a->rm);
+    tcg_gen_clzi_i32(tmp, tmp, 32);
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8749,18 +8762,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* MSR/MRS (banked/register) */
             /* All done in decodetree.  Illegal ops already signalled.  */
             g_assert_not_reached();
-        case 0x1:
-            if (op1 == 3) {
-                /* clz */
-                ARCH(5);
-                rd = (insn >> 12) & 0xf;
-                tmp = load_reg(s, rm);
-                tcg_gen_clzi_i32(tmp, tmp, 32);
-                store_reg(s, rd, tmp);
-            } else {
-                goto illegal_op;
-            }
-            break;
+        case 0x1: /* bx, clz */
         case 0x2: /* bxj */
         case 0x3: /* blx */
         case 0x4: /* crc32 */
@@ -10201,13 +10203,13 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 case 0x08: /* rev */
                 case 0x09: /* rev16 */
                 case 0x0b: /* revsh */
-                case 0x18: /* clz */
                     break;
                 case 0x10: /* sel */
                     if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
                         goto illegal_op;
                     }
                     break;
+                case 0x18: /* clz, in decodetree */
                 case 0x20: /* crc32/crc32c, in decodetree */
                 case 0x21:
                 case 0x22:
@@ -10240,9 +10242,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     tcg_temp_free_i32(tmp3);
                     tcg_temp_free_i32(tmp2);
                     break;
-                case 0x18: /* clz */
-                    tcg_gen_clzi_i32(tmp, tmp, 32);
-                    break;
                 default:
                     g_assert_not_reached();
                 }
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 6cb9c16e2f..182f2b6725 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -29,6 +29,7 @@
 &s_rrrr          s rd rn rm ra
 &rrrr            rd rn rm ra
 &rrr             rd rn rm
+&rr              rd rm
 &r               rm
 &msr_reg         rn r mask
 &mrs_reg         rd r
@@ -197,6 +198,7 @@ CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
 %sysm            8:1 16:4
 
 @rm              ---- .... .... .... .... .... .... rm:4      &r
+@rdm             ---- .... .... .... rd:4 .... .... rm:4      &rr
 
 MRS_bank         ---- 0001 0 r:1 00 .... rd:4 001. 0000 0000  &mrs_bank %sysm
 MSR_bank         ---- 0001 0 r:1 10 .... 1111 001. 0000 rn:4  &msr_bank %sysm
@@ -207,3 +209,5 @@ MSR_reg          ---- 0001 0 r:1 10 mask:4 1111 0000 0000 rn:4  &msr_reg
 BX               .... 0001 0010 1111 1111 1111 0001 ....      @rm
 BXJ              .... 0001 0010 1111 1111 1111 0010 ....      @rm
 BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm
+
+CLZ              .... 0001 0110 1111 .... 1111 0001 ....      @rdm
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 337706ebbe..67724efe4b 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -26,6 +26,7 @@
 &s_rrrr          !extern s rd rn rm ra
 &rrrr            !extern rd rn rm ra
 &rrr             !extern rd rn rm
+&rr              !extern rd rm
 &r               !extern rm
 &msr_reg         !extern rn r mask
 &mrs_reg         !extern rd r
@@ -126,6 +127,7 @@ RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
 @rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
 @rn0dm           .... .... .... rn:4 .... rd:4 .... rm:4      &rrrr ra=0
 @rndm            .... .... .... rn:4 .... rd:4 .... rm:4      &rrr
+@rdm             .... .... .... .... .... rd:4 .... rm:4      &rr
 
 {
   MUL            1111 1011 0000 .... 1111 .... 0000 ....      @s0_rn0dm
@@ -180,6 +182,9 @@ CRC32CB          1111 1010 1101 .... 1111 .... 1000 ....      @rndm
 CRC32CH          1111 1010 1101 .... 1111 .... 1001 ....      @rndm
 CRC32CW          1111 1010 1101 .... 1111 .... 1010 ....      @rndm
 
+# Note rn != rm is CONSTRAINED UNPREDICTABLE; we choose to ignore rn.
+CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
+
 # Branches and miscellaneous control
 
 %msr_sysm        4:1 8:4
-- 
2.17.1


