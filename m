Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E10C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809C32082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQ3/GAFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809C32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fr1-0000MF-Md
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh2-0004VJ-0Z
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh0-0001ym-2h
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:14 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgz-0001xg-SI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:14 -0500
Received: by mail-wr1-x42b.google.com with SMTP id y11so6976090wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qjwWfe9cc7402cXgQDxYUA1cz+Es7+efoVSmoqlcaks=;
 b=QQ3/GAFeqqr6YBNd+ZQDNi0UD0i/VEEck4t75hXZVtlrtNO/HgrjsnA9wP6/zH0nwe
 WOi2NhH9xnYozBMvf7lpMm6pHS0LmzU+BIIaF7jovEdJghoKRzA8VtUBZxuc8MdHxDoa
 r09nYJiy7uRdxGh/ylcTWrTjnsDdkWa2OaFOkUF7QyspLXNVqvK3w5vhuvEBuutlH0Lj
 +GqgwPT/nj8kPPhQRNSqtw39PLC9mdurib+a6gdOhCkaL88GjgcvmK5NcVueQHIfY0Fq
 +qygWymlnH/Vb/ZiNcn6NnZ8Atxfd5a4JPSpw/hBe12rPVSoBCSK7RoRvgyHnawlnZfm
 rbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qjwWfe9cc7402cXgQDxYUA1cz+Es7+efoVSmoqlcaks=;
 b=FsGa6zQd3a60CG/TYHGAFHvPSnfIRpqhrtl0hd8VYW3PP6aAbTkkEgYz/EDdTUPqPN
 m+vBfxIiYeRRnHeK3BarL8BqEvD3lfBc4wQAaKPV25d3f0sr4pMrSdFk/z2+DiFRUcVQ
 MAKNg5j3k4C9v6vH8EK2XMT8x70XgP7CnMTv9BhoRZo2sO8KQ0bS6mKg382TLNXkcas3
 1SyBauUcfg8Ng4vms43zmLUfHFHPaDaNpxnK1BdS6h1XqgLPYVCtoQyP+Ia6ViijLKEJ
 1cL9pyJmPyjfEyT9ucOHHAyy1IKX3H8ZahlKvlC5i33S6PEmz+sbVprvt0Hd2DrU8f06
 jmwA==
X-Gm-Message-State: APjAAAUarrGIg+NOo8TS0Duo0CBR5LK6XF/V88S2mnTfBVJWA5x/rTpu
 oKSIXBB065PYAO+crRqM53yung7e8Do=
X-Google-Smtp-Source: APXvYqwUm6aYLwgxxgNVWuiDtEPENAgaOXCceN9JRt3veGqHfFbPjN0wtJ0+k+qj7tIeBA5+nNL3iA==
X-Received: by 2002:adf:e610:: with SMTP id p16mr23566942wrm.81.1581604932703; 
 Thu, 13 Feb 2020 06:42:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/46] target/arm: Update arm_mmu_idx_el for PAN
Date: Thu, 13 Feb 2020 14:41:20 +0000
Message-Id: <20200213144145.818-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

Examine the PAN bit for EL1, EL2, and Secure EL1 to
determine if it applies.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 058fb239592..f6a600aa004 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11895,13 +11895,22 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         return ARMMMUIdx_E10_0;
     case 1:
         if (arm_is_secure_below_el3(env)) {
+            if (env->pstate & PSTATE_PAN) {
+                return ARMMMUIdx_SE10_1_PAN;
+            }
             return ARMMMUIdx_SE10_1;
         }
+        if (env->pstate & PSTATE_PAN) {
+            return ARMMMUIdx_E10_1_PAN;
+        }
         return ARMMMUIdx_E10_1;
     case 2:
         /* TODO: ARMv8.4-SecEL2 */
         /* Note that TGE does not apply at EL2.  */
         if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
+            if (env->pstate & PSTATE_PAN) {
+                return ARMMMUIdx_E20_2_PAN;
+            }
             return ARMMMUIdx_E20_2;
         }
         return ARMMMUIdx_E2;
-- 
2.20.1


