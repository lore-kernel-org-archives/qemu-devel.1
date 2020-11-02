Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4911AC4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C343122265
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E57Tchre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C343122265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZda8-0003Ov-QV
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLy-00018B-P1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:46 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLw-0006cf-N2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id k18so10219272wmj.5
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jMjtfOiFG10GNhNUO0WFVBSDgvdA1bWEPrli5zIV9Do=;
 b=E57Tchret6x8g43AVWfwJNw6B8wgtPFmoT827ztHr+ZExQGGpFq4rDRoCwGzBqtvl8
 mig708t098yaB9tJxgDgRBfZjfsj5TxZVfAf787KZpP15xGt7B5MJUXKOqi9n2XxXVWd
 /Ihj1uYjWkHxek/Mr4UnQaNRJvo17lCDN5bfm/ECKTKvqqX7a5GG6ZyQqr2WmlgC/ga8
 aMbShkIx9XwtKXD9nblZYhGGqqJiHeZP8qFQq4LKXWv5UzTi1zIPNVkSP4jtPiKFiLIr
 KMkE/nr4UCIRhcVfJkVYT44je0hEdiswT+L2axzT7qu1l+X4/9MVS2AtwH2tD429EJbG
 p3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jMjtfOiFG10GNhNUO0WFVBSDgvdA1bWEPrli5zIV9Do=;
 b=m1eXC42jZm7C8DP4WxfDIq+EojePT73NQYgrrloYd+Z/uH+J3jwjDl7i1NzIsUz5hT
 P2vXV4ul/hV3SVxPAHRFv4Qsy3Nt6SqO+QNcgd09DeDX2t7xV7OK/12xQAZKrSFHCeFg
 R9QdiHXh6S6kH89WHBKPiqlCRVnhhd+7J0S0ACNhhMLdUi68gid0r78AtevN49RFfdbZ
 LKS8HQs8yIj8LQYFVKpkiSh8rcuYis8Uuj83pbV9w2WLiD5AHDBF3p344AOQ8QmTw5Ma
 8oT3+UBpUmjwim7tdvOHc/MJ1cglN7OqnywLyu89qy6Wa18Nv+pe9so+j29qJQ5JTTAo
 4uQQ==
X-Gm-Message-State: AOAM531P6kSNgW2XFcfMqhxTHo+ES9TQTbdnkwjmt572sDW0hROgJXYo
 5XdP4W70OAacRXp+nri36oFQ3Mr9rVvT0Q==
X-Google-Smtp-Source: ABdhPJwJ8K8QXAsBK3OA2S61bd+4Pu71MnXooat+Wjn8JRecktN1Sy/jQoiMhsCGteqZzx5fa1F/xA==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr18234987wmq.28.1604337042332; 
 Mon, 02 Nov 2020 09:10:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/26] target/arm: Get correct MMU index for
 other-security-state
Date: Mon,  2 Nov 2020 17:10:00 +0000
Message-Id: <20201102171005.30690-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201022164408.13214-1-peter.maydell@linaro.org
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


