Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C311EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D507206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vmWzpQzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D507206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izezU-0007Ar-Nq
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoV-0003K4-Px
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoQ-0007SN-RG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:15 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoP-0007Ib-MH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:10 -0500
Received: by mail-wm1-x342.google.com with SMTP id s10so5791653wmh.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uZ8VWygo9dsWEZ5jS2slY9YSpukJBdVo3/nVvY6vbgE=;
 b=vmWzpQzbP9UpcVatOfaxWuebNzqKmLucoXfKbGNKX1O0eASXsZS2zRE8+13Nms1pWj
 Hiwz0bOJFBpKxvnqxiLEeIVob9WgiHI5lIny/Kbfk8co4WD3ZN6lmqlM14sb0LdvukIw
 9ANK8vrH7OulyAWjKeDfFb6ehnVDvT9M0KOeyANiKqcL6jwTQJG36omU2/+7jtZ5ztAp
 Uuxp7CHL5FIhdyXluNDZuKJTsybpzOcG/Zn4gUXBt79iGJPCJAQJAZYga+hD1AGnLHsx
 yu7AR73dRBavbhJffY9lt/BQl49RIUY0lmfdOXjTpXu3VpY7m0//xvCeCFJrzUfbGhSP
 nbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uZ8VWygo9dsWEZ5jS2slY9YSpukJBdVo3/nVvY6vbgE=;
 b=pWmFn00FGjT/k2JgKaS7GL8KVUagk2mDYp6yCuPoaMf8Tb8OhxKhplgdXHb5jDQok0
 I2LCD//wsEJNJrwVvi2gxpkaYbm0zS7D3KkFoYxknXnrU31U2kgbNgNHLmZpPM0kqGsy
 bsEyg2saBzr3SFZKI1NdnAz/O1Zrv8QfFfNUBhCHsrOxlThNvn4/c+IjomQzmrTaoGca
 yD0KNpBsHWLALfyMFgQCOUR7+WediKAJa/si0I8a3Cikc86v5ai1UpBNXa1ZMz6d70R8
 hmWbhEm/UFQ4d0i1HJab9Lt3i/GLv9ROSiT9h6t8cqRx3eC/EThGVs7YO74whYH4fiRt
 YVUw==
X-Gm-Message-State: APjAAAVWT6GwYjb0qKhsU2pxO7tJ6Dkx9c0VWQOTJnm5jaJkt8jvDTvN
 A72YdXBJeWrwxb2BMjrh1JfT/qkddaIlLw==
X-Google-Smtp-Source: APXvYqyt1cpdXlYQnWaJNfYvF30dF7Q6T8/Ypy6GClvGITL53THvoxb4gw0xCv8WLCNS20ivHgm3Lw==
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr3935010wml.55.1580986507845; 
 Thu, 06 Feb 2020 02:55:07 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 21/41] target/arm: Update arm_mmu_idx for VHE
Date: Thu,  6 Feb 2020 10:54:28 +0000
Message-Id: <20200206105448.4726-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Return the indexes for the EL2&0 regime when the appropriate bits
are set within HCR_EL2.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v4: Consistently check E2H & TGE & ELUsingAArch32(EL2).
    Do not apply TGE at EL2.
---
 target/arm/helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f7bc7f1a8d..9f8d7ca1f3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11318,12 +11318,16 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
+    /* See ARM pseudo-function ELIsInHost.  */
     switch (el) {
     case 0:
-        /* TODO: ARMv8.1-VHE */
         if (arm_is_secure_below_el3(env)) {
             return ARMMMUIdx_SE10_0;
         }
+        if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)
+            && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_E20_0;
+        }
         return ARMMMUIdx_E10_0;
     case 1:
         if (arm_is_secure_below_el3(env)) {
@@ -11331,8 +11335,11 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         }
         return ARMMMUIdx_E10_1;
     case 2:
-        /* TODO: ARMv8.1-VHE */
         /* TODO: ARMv8.4-SecEL2 */
+        /* Note that TGE does not apply at EL2.  */
+        if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_E20_2;
+        }
         return ARMMMUIdx_E2;
     case 3:
         return ARMMMUIdx_SE3;
-- 
2.20.1


