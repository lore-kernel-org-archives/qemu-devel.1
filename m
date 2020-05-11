Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A71C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E728206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKlFOUqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E728206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8r9-0001li-PG
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8a6-0002mg-AU
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8a4-0007HD-DT
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:53 -0400
Received: by mail-wm1-x334.google.com with SMTP id m24so8465520wml.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HJcUIwZpjvrR7bbXwOVeL69W3rBNs8Bm6fdH4rxWxc4=;
 b=gKlFOUqCMkSEqP4sZkRr1OJ9jiz8gI1iZOODUYhIbpBSPTMdS78iFdLUxepu83x72B
 0zi4PVB+U9HNGCIO/oM/cgnxc6D9J3Xt/DkEX5guf9LC5IXHMNCyqW9YPSzePFECABUM
 PyZpkdsVW3sLsJaxetU12qgmM2d0pFgPFf4s54807MYBPHRIxIMrdN+F+qGTePmjwETU
 C20g8f1fK/ldCFADT0ogwSYRPhkyegJldYsRAxk1KHPS+ePXK4EXvIYL+o7mrEq2wQz0
 c8K8nPbi83tOq2zoaTFRerdlcVkJVkMDOKs3XsY2Jkk/PkvbYEJ4Mf9s2rRLJeelIG9k
 U7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HJcUIwZpjvrR7bbXwOVeL69W3rBNs8Bm6fdH4rxWxc4=;
 b=LWCFuKlbezUfI5/14y48uSCyP8mp7FAgejJsfIehnBn7nuinkWnU3jwlf3bxyGJl4d
 Q5XSAGlPF7nrvhOR5JQXIkbwnpwmhzDpOzpDFFl+Xg29DNrrEU27dFn7yL9Wt+EyzOad
 DCTr7O4NotZPJQRBm+Asmd8DcnBOUMJpDavqMRvslvZGhAwzOp8gZ+8+XYyDSFy3U14E
 kpQNN3Z6H492a7700BW3RbqDP0MiFrhIAv8MIV8x4v+dGTtBf5C4yXJGcE7Kqn5FBe8g
 UvmDbXYgaVG9IfklqYMDQdfPIw9VrjalKfZY83cvV3IFfOcNOH2+35gPJURADVsOPCVI
 5Pxg==
X-Gm-Message-State: AGi0PuaSGmYDS0L2eHgji5aED4gtc/HPGYn+V/ap7wiC3WZa5NVVsYdq
 kn/+h6oJ4FKRVRmkY+uzM7356j5nxhIj5A==
X-Google-Smtp-Source: APiQypK6ZFYnwh2URAvPS7Wg4zxLlnLAypRM7+2XEew++phF5WEOhYcdZzu9WyAkGz08OgWa6bMvcA==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr31457324wmk.171.1589204090468; 
 Mon, 11 May 2020 06:34:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/34] target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed)
Date: Mon, 11 May 2020 14:34:05 +0100
Message-Id: <20200511133405.5275-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Richard Henderson <richard.henderson@linaro.org>

DUP (indexed) can duplicate 128-bit elements, so using esz
unconditionally can assert in tcg_gen_gvec_dup_imm.

Fixes: 8711e71f9cbb
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20200507172352.15418-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 8398c323624..ac7b3119e5f 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2044,7 +2044,11 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
             unsigned nofs = vec_reg_offset(s, a->rn, index, esz);
             tcg_gen_gvec_dup_mem(esz, dofs, nofs, vsz, vsz);
         } else {
-            tcg_gen_gvec_dup_imm(esz, dofs, vsz, vsz, 0);
+            /*
+             * While dup_mem handles 128-bit elements, dup_imm does not.
+             * Thankfully element size doesn't matter for splatting zero.
+             */
+            tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
         }
     }
     return true;
-- 
2.20.1


