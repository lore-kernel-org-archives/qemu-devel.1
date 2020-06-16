Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C7FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F4F20644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5h4A1jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F4F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD3w-00046C-Gv
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQs-0003x6-Rt; Tue, 16 Jun 2020 10:19:22 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQr-00070e-0Q; Tue, 16 Jun 2020 10:19:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id d4so1647887otk.2;
 Tue, 16 Jun 2020 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RMIBO3jpMOms/D4uQke8brSu1T+4gHbWwgG0M1rmYeo=;
 b=L5h4A1jhSAISjOnt4/5iYKvvgYcm5d938db0dmepSl2M9/GNnDVaU0NISXALHuae0a
 bSq5wwXIjC50EaUQHGXdKkIg+QJz4a1/dX9VuluD4sprBXNGZxxkbOGyI0mMljOOcCYu
 s1QLux4RP+t1Y7SIhm30vosfD27nrBvbgB9/uEJLEUsJ8icXtZlZ6ffrrWKzZ8melFqs
 jr0yV672mX3YeNfejFCAIVnseZsbLuOYBGz1f/B0zVPU07ux1buVVtUhmk3nC3wRK3kn
 0BK6oEKdG58Bbe0kW1PKt0XwXrTGUabW5tYWWUE57XPUrEV1pJZPOATtYFeRR8iBhGy/
 VS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=RMIBO3jpMOms/D4uQke8brSu1T+4gHbWwgG0M1rmYeo=;
 b=gDZ5qR3uN0EAVbkCTVLrhLz3GofPp7R057vFoOGKXvWfAgeci1npc/SLsEZ2QmuAPQ
 hGlcktznb/zWO5pnnZ8Z0P1/EziLHYv+CKeify3PKXhi1Bjwl1TStspWy+Fhzn195AJh
 0v85jpK4waoG1JQyUUMjNm4KK3AZ13HVAVJH5olEJDCwXthTry+2y5WefUS8RHL/1VVn
 y1a7goyoebkQnfaLLi+hTeZc5Cin/Jv9TuQ0Ql3tRbQJ3j053fEUnYBRCfE4W/AbB/EW
 N4BUtZFoBVs2OkRLIoa7AayG3Nds/k8YR5Jx3BFIEvOMy87FT8UPgLwwQE703UV1aZc2
 670Q==
X-Gm-Message-State: AOAM5339meVR9erV3qZmW+XLAbOt+CVYWcI24QOPxb3DzkecIT3CwSd3
 coWvcrCtYaCYcTtAjr7vQkCwddP6
X-Google-Smtp-Source: ABdhPJwxvlKGC8ocNV8iNrhsx9Le6Q0jB4yXFgRwjDnGin0YOG743tznvtg6wWXny51WhkabSqECsQ==
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr2647644otb.262.1592317159005; 
 Tue, 16 Jun 2020 07:19:19 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c9sm4031760oov.35.2020.06.16.07.19.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:17 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 64/78] tcg/i386: Fix INDEX_op_dup2_vec
Date: Tue, 16 Jun 2020 09:15:33 -0500
Message-Id: <20200616141547.24664-65-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We were only constructing the 64-bit element, and not
replicating the 64-bit element across the rest of the vector.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit e20cb81d9c5a3d0f9c08f3642728a210a1c162c9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tcg/i386/tcg-target.inc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 9d8ed974e0..77b78c941c 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2855,9 +2855,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_simd;
 #if TCG_TARGET_REG_BITS == 32
     case INDEX_op_dup2_vec:
-        /* Constraints have already placed both 32-bit inputs in xmm regs.  */
-        insn = OPC_PUNPCKLDQ;
-        goto gen_simd;
+        /* First merge the two 32-bit inputs to a single 64-bit element. */
+        tcg_out_vex_modrm(s, OPC_PUNPCKLDQ, a0, a1, a2);
+        /* Then replicate the 64-bit elements across the rest of the vector. */
+        if (type != TCG_TYPE_V64) {
+            tcg_out_dup_vec(s, type, MO_64, a0, a0);
+        }
+        break;
 #endif
     case INDEX_op_abs_vec:
         insn = abs_insn[vece];
-- 
2.17.1


