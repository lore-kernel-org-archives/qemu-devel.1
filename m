Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF6C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0905122267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phtNzjuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0905122267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdj2-0008CE-Tk
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVdhH-0006Ob-4B
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:44:15 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVdhE-0007DR-Ee
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:44:14 -0400
Received: by mail-wm1-x341.google.com with SMTP id q5so3024643wmq.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MbIpHBCwt6E/zRDH/KaZ6m6xgeXJwLyukVW4piGrJ7M=;
 b=phtNzjuVaKqNQssqH6b4BhIVOE4kegLK8X3vrneF67Dmp8Nq76pJ9vVPpmuO08nJph
 IvXOKOztjBkmjSmR5I6uN65btWX4Bt2e1dZChzrLd9vKffhwQU7OHJCwaUwednJWZZ3X
 u3YKoDJ0ds11yYv2neGrHE7vyAXXrwnWNEIZpOa3G6XmL+v6STMRcvUqDdBD7fTqWQEi
 zSxZlgH2oUXC9Ee2sxxaoSEQjxZ4LGSS5PNbSp8Y04iP1g0WyhEFz2HFp+QJk4un7Y4q
 CR/Lv2nHaaL+1+4y2MYlYbL1ElKh7DVy1uv1adagJgZTqWpyg8oY9kUs7UniB7r+Xvu0
 GXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MbIpHBCwt6E/zRDH/KaZ6m6xgeXJwLyukVW4piGrJ7M=;
 b=DNN30c99NEaz6wLvBafZOlrmudMlPdSsE+y5xeR1qfk7xPWtSxyc75ndhoevg92s2d
 mE3p6Y9QBIPLYSAazgbjMnsoqFXB4fSrUMWoDcV/Qv9eKYQ/ESOcZxjZChfuWXRe/OQi
 P9DsfLXzNFny7hSgCoeJB04p1xvcyOirYpvbfXsWbYTA8MBH01rX6W3174asHzlXic2y
 CsO/kMvywY+fUrhcAhE0CUetNanom8Zwbii2SGstxR8XqmcNZULeBmWFnfWXbfZp+xoZ
 fUVHnsepi7C5N2zRugUUkELTiJlmbIGdujCx02qMDg41Q4YfEgD5XnQZIIVxcHINsgNW
 8MTg==
X-Gm-Message-State: AOAM531cCFBZYmAWMFvvWQe8vci0Hgy87z9uPhAco5B6+fHcyYKaQVhr
 Di8WPmjZsQSJF26FFmB3lf2uLQ==
X-Google-Smtp-Source: ABdhPJw4IJdyU2XdM9fkvd0oErDM2mb56ztybQISO1CmI3Myzu350X8Rqbu2jzEsRjFYGt//Iw/rXg==
X-Received: by 2002:a1c:8056:: with SMTP id b83mr3358841wmd.124.1603385050571; 
 Thu, 22 Oct 2020 09:44:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e20sm4480294wme.35.2020.10.22.09.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 09:44:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Get correct MMU index for other-security-state
Date: Thu, 22 Oct 2020 17:44:08 +0100
Message-Id: <20201022164408.13214-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In arm_v7m_mmu_idx_for_secstate() we get the 'priv' level to pass to
armv7m_mmu_idx_for_secstate_and_priv() by calling arm_current_el().
This is incorrect when the security state being queried is not the
current one, because arm_current_el() uses the current security state
to determine which of the banked CONTROL.nPRIV bits to look at.
The effect was that if (for instance) Secure state was in privileged
mode but Non-Secure was not then we would return the wrong MMU index.

The only places where we are using this function in a way that could
trigger this bug are for the stack loads during a v8M function-return
and for the instruction fetch of a v8M SG insn.

Fix the bug by expanding out the M-profile version of the
arm_current_el() logic inline so it can use the passed in secstate
rather than env->v7m.secure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/m_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 036454234c7..aad01ea0127 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -2719,7 +2719,8 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
 /* Return the MMU index for a v7M CPU in the specified security state */
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 {
-    bool priv = arm_current_el(env) != 0;
+    bool priv = arm_v7m_is_handler_mode(env) ||
+        !(env->v7m.control[secstate] & 1);
 
     return arm_v7m_mmu_idx_for_secstate_and_priv(env, secstate, priv);
 }
-- 
2.20.1


