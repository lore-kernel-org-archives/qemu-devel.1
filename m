Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF457C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86F62072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvI23ykY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86F62072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSgd-00031d-68
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isSbz-0006R2-Iv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isSby-00079U-FU
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:35 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isSby-00078m-9a
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:28:34 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so7627175wmj.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XSB+zAsWZUDGNHpX0mNxRRCfRkaNaQwB2Quv9BibAR4=;
 b=mvI23ykY09oyAGFo4gpvS743JZQSG2MHG6SccKDRIi9PAIpdxXMDwevv3UhTYOUGZ0
 UgmkssitzSTxdzeXnNBEofQtc9CvJ2YiHJh+wSerfQIZKK67ENg3FL606Bu8//8SPui9
 VraroxkI7e8Km60Q2s44E7Ad9Yq29UV01yhWwLRWJMlUWmvFHrRH+JUz5MJ8vsTgPRYA
 XzJw4EKDoeAkXGp7Y0oO4HXArdUToFRzEy1DMGotbRV9SVlFSxkAwRMKBpkY1m8JwHZX
 p2gbpeEe88i7Jflq8dQ/fB1agCCZEwr7tFZBh/yKcD/SPb2kUmbAPlnSJVoDI55+yMUd
 F/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XSB+zAsWZUDGNHpX0mNxRRCfRkaNaQwB2Quv9BibAR4=;
 b=cYZlXWGG/TEmZeskSB6D9J/3YkSW3ic/JGLRk6SlSm4EheTA584jah5QyrXMKMrvQP
 g8owTUNySpiQqboP6LPcF1iwEDr6d8tPwAqyVJZ6oR0Jyy0eLF3p9a61+Puo7VB3avrK
 eiohrN3DR3EOisBvy2inHd3jUkimCusgTEwSw2FGDge0f0tn9rJeEfWj25vcgVkLcjtG
 efaDDJnSiItOXEHFP/697KprXU9rgv3au0xK8gOdNYP4GcLUQhBZSNiteA00VcRuAoaC
 j5zy1phfxdQJPuesaKUthdN86/EEMB8wUMgtXp61oJ/421aAAJnMNiQqeKP2qQ7r+Vm0
 MwNA==
X-Gm-Message-State: APjAAAUFGUrTduekt41c/tpfS6Vv8kZzw+jzEN7itOlGa84Mu4wCMNk3
 e3PAmjSvO1CVYU/uMTcZDV71A3Z85b2Oqw==
X-Google-Smtp-Source: APXvYqzhZRkdaraJIIj8o7KiYwrU1ZetEVCfJJR64gm3bMb+nqYphLK39Z9gBRkT8m0qVQlEuYy2EA==
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr5049773wme.59.1579271313142; 
 Fri, 17 Jan 2020 06:28:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e18sm33811146wrw.70.2020.01.17.06.28.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:28:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] target/arm: adjust program counter for wfi exception in
 AArch32
Date: Fri, 17 Jan 2020 14:28:13 +0000
Message-Id: <20200117142816.15110-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117142816.15110-1-peter.maydell@linaro.org>
References: <20200117142816.15110-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jeff Kubascik <jeff.kubascik@dornerworks.com>

The wfi instruction can be configured to be trapped by a higher exception
level, such as the EL2 hypervisor. When the instruction is trapped, the
program counter should contain the address of the wfi instruction that
caused the exception. The program counter is adjusted for this in the wfi op
helper function.

However, this correction is done to env->pc, which only applies to AArch64
mode. For AArch32, the program counter is stored in env->regs[15]. This
adds an if-else statement to modify the correct program counter location
based on the the current CPU mode.

Signed-off-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/op_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index e5a346cb87a..27d16ad9ad9 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -295,7 +295,12 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     }
 
     if (target_el) {
-        env->pc -= insn_len;
+        if (env->aarch64) {
+            env->pc -= insn_len;
+        } else {
+            env->regs[15] -= insn_len;
+        }
+
         raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, insn_len == 2),
                         target_el);
     }
-- 
2.20.1


