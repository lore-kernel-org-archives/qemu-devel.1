Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A745AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7256E2468D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kC4x9yEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7256E2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7qwk-0007BL-M9
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvX-0004nI-KD
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvW-00061c-Hi
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:23 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7qvW-00060v-C9
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:22 -0500
Received: by mail-pj1-x1044.google.com with SMTP id o2so67206pjp.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mxAcyusf4U5zXXtEjloBwTbqgFt78dWHMSy3qfj6epQ=;
 b=kC4x9yELE0eX35wwUWRIifYggbo9L7N656Qz267eMcpSg3z+VZP+kzXpacnrDpqAzs
 NbpnH72gZchXusZ7NXLHwPsAF/ks4ClutNc68Mpz6LEXRETnhFHNIBU+XLJAT8QOFqZ6
 mTb/WqfrH8jaf+u9LTeeH+T5FzqYK1CtoDRBuA4DZy19ZDmJA440ood0BCrxs0jYZkVB
 cvO5Mo87wR3Ty4GjetisAnzlYTIfAygcmOhFEbB7pPsj/XqhmuLr+KHrDKC69xdceCYR
 XD+csDvBI00NXmgXbhMCx5j3rajWotb8T+UukWjj6LPx1JXkMefbvom0z/thaXyk65Nv
 WHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mxAcyusf4U5zXXtEjloBwTbqgFt78dWHMSy3qfj6epQ=;
 b=YtWl6Nm5u1RbJxX5zQVdsjnGMTMxi7/kDqP6vzCLzkuUOMs5fWV+VOApXtZCWXNzOZ
 OZAt/tA8t3V5APFTXei3o6C7SZuVEGoM+GDVqMBa8kOKJX0cEwOrWO0La2krUpHWHuKl
 xmGkXL/mwBpOs1LBBaWMkjAPbAQLacS7oCNr+gBXO6VTiISLv9i8DkDLVCwQ34Tzlfjc
 o+JzTFTPstH4guVLmlQDtInGF89udtpsuk0YMPB3/skcYoERT26hN38bGoQ35xwrWJc+
 K22W9Fm698GAjGTzHKPbvfarJ7JiTafyxjlREj7aV3bLz73a5A5cFQigVGkLmd6oCPz/
 9vhA==
X-Gm-Message-State: APjAAAVmy/sEgAnG/2MbMGCNghjzLW6KzTu/ZzQEvBpTHrV2/YzZkUEh
 RgOc2yl5cAhKlbgnoAYnuD/i4gB5PiY=
X-Google-Smtp-Source: APXvYqwpkAshVZF92eAvC29ab0gq8iFGnhR5fbwx1SmUwlAGyRUtmbwtaFpEtV4eg7WmmY4hAw2HYw==
X-Received: by 2002:a17:902:8308:: with SMTP id
 bd8mr6710737plb.210.1582939701020; 
 Fri, 28 Feb 2020 17:28:21 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm4606313pfq.126.2020.02.28.17.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 17:28:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/12] target/arm: Improve masking in arm_hcr_el2_eff
Date: Fri, 28 Feb 2020 17:28:04 -0800
Message-Id: <20200229012811.24129-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
References: <20200229012811.24129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

Update the {TGE,E2H} == '11' masking to ARMv8.6.
If EL2 is configured for aarch32, disable all of
the bits that are RES0 in aarch32 mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e68e16b85b..ef3f02d194 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5196,14 +5196,37 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
          * Since the v8.4 language applies to the entire register, and
          * appears to be backward compatible, use that.
          */
-        ret = 0;
-    } else if (ret & HCR_TGE) {
-        /* These bits are up-to-date as of ARMv8.4.  */
+        return 0;
+    }
+
+    /*
+     * For a cpu that supports both aarch64 and aarch32, we can set bits
+     * in HCR_EL2 (e.g. via EL3) that are RES0 when we enter EL2 as aa32.
+     * Ignore all of the bits in HCR+HCR2 that are not valid for aarch32.
+     */
+    if (!arm_el_is_aa64(env, 2)) {
+        uint64_t aa32_valid;
+
+        /*
+         * These bits are up-to-date as of ARMv8.6.
+         * For HCR, it's easiest to list just the 2 bits that are invalid.
+         * For HCR2, list those that are valid.
+         */
+        aa32_valid = MAKE_64BIT_MASK(0, 32) & ~(HCR_RW | HCR_TDZ);
+        aa32_valid |= (HCR_CD | HCR_ID | HCR_TERR | HCR_TEA | HCR_MIOCNCE |
+                       HCR_TID4 | HCR_TICAB | HCR_TOCU | HCR_TTLBIS);
+        ret &= aa32_valid;
+    }
+
+    if (ret & HCR_TGE) {
+        /* These bits are up-to-date as of ARMv8.6.  */
         if (ret & HCR_E2H) {
             ret &= ~(HCR_VM | HCR_FMO | HCR_IMO | HCR_AMO |
                      HCR_BSU_MASK | HCR_DC | HCR_TWI | HCR_TWE |
                      HCR_TID0 | HCR_TID2 | HCR_TPCP | HCR_TPU |
-                     HCR_TDZ | HCR_CD | HCR_ID | HCR_MIOCNCE);
+                     HCR_TDZ | HCR_CD | HCR_ID | HCR_MIOCNCE |
+                     HCR_TID4 | HCR_TICAB | HCR_TOCU | HCR_ENSCXT |
+                     HCR_TTLBIS | HCR_TTLBOS | HCR_TID5);
         } else {
             ret |= HCR_FMO | HCR_IMO | HCR_AMO;
         }
-- 
2.20.1


