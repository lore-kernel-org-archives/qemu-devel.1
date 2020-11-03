Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF9EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E6620756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgM223eB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E6620756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka41f-0002Ne-2v
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka414-0001x1-Jc
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:38:58 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka412-0008Iq-Qt
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:38:58 -0500
Received: by mail-pf1-x442.google.com with SMTP id w65so15476533pfd.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YJ3V8KbxGN6RBeWaE+SPwkJaD53Y43pW9cLqSeG0Hf4=;
 b=tgM223eBo67n1mRrQ1uUgPELGdBm9Q+XKkLygkCQjF9kX9Y33wl+VWmy16636w8Zjc
 3sRVlZqn+/VWsF5TTrpR3W7uE1oBKOxl36FVbzdYgTKsGeeeSRgC3guATIElB5Raeges
 fHvsfL3dWUd9BkWQubQHaQ6MAzVvuHfvAt2rJYMNs5aYzv9BI032ys2Xb/phAyW2DHlB
 nVwlW0jomImSF7lJt0POGo+quukZNqT9pKx4g1W5NCiEAXrH43q0V7Fxk0hUJJPY9ax6
 6kcSzOaZRhpES2dl9MssrglIv/R1MdSK7xLGGorWm//eYsmChUGDQ/jJUeLqmtmbmnJ3
 RIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YJ3V8KbxGN6RBeWaE+SPwkJaD53Y43pW9cLqSeG0Hf4=;
 b=fL23jF76apBLKbCREdW07p124HrO4bznx1s07i+OAEgCc9ujRN00NmyNpUp6YOOA61
 mDZCttpgflOfMefpnMfc305D27pHIl4OR0Kyy8weClhC0J5asb6gRS5O0Y1zl/Diw6g9
 lUTUC3pHqTyPpm9FjrZNsjcS33TNm71IG+pBD90CrxE/tY9HD79sumpditBnouOOFPKZ
 332AET4Wqt2hmNhr7YWd/qpFMJOSlfOxYG245cLRyqCMrNot4iwbnczkaXgVo8yv5o6W
 0E0MO2KhdA1aVv+F+DH/HgSIiiKBD4wT0kIQIT9yYohLjILapDl/XCBlDVCFDyApFSS4
 c9dQ==
X-Gm-Message-State: AOAM5302ZF9TkbLkyk8bXPVqfFd6otzFcmJw+OJAyKG5oE6FY4aPOFNk
 f1WkQkFQG1Zdl5vgEbSwtCwk86ALgRP5ng==
X-Google-Smtp-Source: ABdhPJy2R3LNt4bsLfHcW07kWsaTwhIeo+TcegygHwxMPOtg6C5KIg/rJeMkCMYQZ7oE681IKD4huQ==
X-Received: by 2002:a17:90a:7c0c:: with SMTP id
 v12mr1192103pjf.71.1604439534657; 
 Tue, 03 Nov 2020 13:38:54 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id j19sm65213pfn.107.2020.11.03.13.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 13:38:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg: Revert "tcg/optimize: Flush data at labels not
 TCG_OPF_BB_END"
Date: Tue,  3 Nov 2020 13:38:52 -0800
Message-Id: <20201103213852.253793-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org, qemu@igor2.repo.hu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit cd0372c515c4732d8bd3777cdd995c139c7ed7ea.

The patch is incorrect in that it retains copies between globals and
non-local temps, and non-local temps still die at the end of the BB.

Failing test case for hppa:

	.globl	_start
_start:
	cmpiclr,=	0x24,%r19,%r0
	cmpiclr,<>	0x2f,%r19,%r19

 ---- 00010057 0001005b
 movi_i32 tmp0,$0x24
 sub_i32 tmp1,tmp0,r19
 mov_i32 tmp2,tmp0
 mov_i32 tmp3,r19
 movi_i32 tmp1,$0x0

 ---- 0001005b 0001005f
 brcond_i32 tmp2,tmp3,eq,$L1
 movi_i32 tmp0,$0x2f
 sub_i32 tmp1,tmp0,r19
 mov_i32 tmp2,tmp0
 mov_i32 tmp3,r19
 movi_i32 tmp1,$0x0
 mov_i32 r19,tmp1
 setcond_i32 psw_n,tmp2,tmp3,ne
 set_label $L1

In this case, both copies of "mov_i32 tmp3,r19" are removed.  The
second because opt thought it was redundant.  The first is removed
later by liveness because tmp3 is known to be dead.  This leaves
the setcond_i32 with an uninitialized input.

Revert the entire patch for 5.2, and a proper optimization across
the branch may be considered for the next development cycle.

Reported-by: qemu@igor2.repo.hu
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9952c28bdc..220f4601d5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1484,30 +1484,29 @@ void tcg_optimize(TCGContext *s)
                     }
                 }
             }
-            /* fall through */
+            goto do_reset_output;
 
         default:
         do_default:
-            /*
-             * Default case: we know nothing about operation (or were unable
-             * to compute the operation result) so no propagation is done.
-             */
-            for (i = 0; i < nb_oargs; i++) {
-                reset_temp(op->args[i]);
-                /*
-                 * Save the corresponding known-zero bits mask for the
-                 * first output argument (only one supported so far).
-                 */
-                if (i == 0) {
-                    arg_info(op->args[i])->mask = mask;
+            /* Default case: we know nothing about operation (or were unable
+               to compute the operation result) so no propagation is done.
+               We trash everything if the operation is the end of a basic
+               block, otherwise we only trash the output args.  "mask" is
+               the non-zero bits mask for the first output arg.  */
+            if (def->flags & TCG_OPF_BB_END) {
+                bitmap_zero(temps_used.l, nb_temps);
+            } else {
+        do_reset_output:
+                for (i = 0; i < nb_oargs; i++) {
+                    reset_temp(op->args[i]);
+                    /* Save the corresponding known-zero bits mask for the
+                       first output argument (only one supported so far). */
+                    if (i == 0) {
+                        arg_info(op->args[i])->mask = mask;
+                    }
                 }
             }
             break;
-
-        case INDEX_op_set_label:
-            /* Trash everything at the start of a new extended bb. */
-            bitmap_zero(temps_used.l, nb_temps);
-            break;
         }
 
         /* Eliminate duplicate and redundant fence instructions.  */
-- 
2.25.1


