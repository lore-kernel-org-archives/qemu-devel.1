Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A61C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6CA2080D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Odr4MA6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6CA2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaTB5-0000xi-7Q
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 19:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaT9q-00083E-Rx
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:29:42 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaT9p-0002Pe-6r
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:29:42 -0500
Received: by mail-pg1-x542.google.com with SMTP id u4so265344pgr.9
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 16:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hSL4KANQArQ4DL0uvXRZHnrnMeo7g67FEeAIzQ7HlBM=;
 b=Odr4MA6PhwEsnmew+J4MQTT0II8r1AZdGj3/UrTBzD74aQXW+HYn97AkTSfx9OE9aT
 ZgMeovpDPp+QHaAQng8L2h4Lv4yoGWBM1g/XeqQLKPuuUR9zg3lzp0iF8RYC4nrUrdFr
 KpZwZp3apXu5pxrS1P9hR3ZTEzF63VaZ5D8OCpml0i+/PIO4FqKrapDhWPUOzfTg0rRq
 fQNokoBjemBxfEt47i+Z/qXL0t6Pk76NNcCouluzbXo1SlywuidoBMWDY7mXc9EyiSOu
 zrR7gBGu15e2Ts6xHYWnP4Hp5irzFewprqO6A76GBDu9MHQ6iuAcpoF0ZtAacE7S7tMn
 E62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hSL4KANQArQ4DL0uvXRZHnrnMeo7g67FEeAIzQ7HlBM=;
 b=F/8I6VV8mrx2qTe30mp+TNLlokgKm1Qo8IT+UpOMgoAcqEEGRFja3WKfoIbqv12DFm
 OrB3Shd/4D4LeR5dybkH9LBJCc+jHdAVJDrwPstPQeQlZbIv99lhAFCGZewh11KPnF+Y
 4hqU826OWzpxl2Gk1gDEez/+TtIHF/vZ2NzcnRZi8tm9epF0835aBVXKu8ntR0GDO505
 fCiir4W5Y6hSwxDIMvyJC6IsiuDktnuD6UTNhB1Wl78msXxsqlVDUCpOZ3GAB9MwBYox
 pfh6xSHPBrv0f/rMrtE9p3n1oH4cifY8kM4hQJwxHQ5W5qkjffgtLGgt9NWFf5rb/2dS
 KxmA==
X-Gm-Message-State: AOAM530QDY3HL9IVHQanDrTMGW45jeZOfbTz32hbc6hDZdQTm5Lymznv
 2W17ZXg/8KWSnAZ81l9i63+KuwhPyTPopA==
X-Google-Smtp-Source: ABdhPJwBJWr9WNC2RDa+LaQaFi+mBu2gPj8VwaJ89qzBPAbNGI/rqWDgQ0vdjcH/XzpAZepaaCGj0w==
X-Received: by 2002:a17:90b:118b:: with SMTP id
 gk11mr118658pjb.178.1604536179531; 
 Wed, 04 Nov 2020 16:29:39 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id z17sm3438528pga.85.2020.11.04.16.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 16:29:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.2 2/2] tcg: Revert "tcg/optimize: Flush data at labels
 not TCG_OPF_BB_END"
Date: Wed,  4 Nov 2020 16:29:35 -0800
Message-Id: <20201105002935.680486-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105002935.680486-1-richard.henderson@linaro.org>
References: <20201105002935.680486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


