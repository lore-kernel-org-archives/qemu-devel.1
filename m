Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F1BC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F9920637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SvYRjwQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F9920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ta6-0005c1-U6
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPB-0003b6-Mh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPA-0002QG-IX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPA-0002Ou-CH
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:24 -0500
Received: by mail-wm1-x32d.google.com with SMTP id a132so7056873wme.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MW1rCYSxw/00/8UqyAWlM8p39wC7z3ywPKWBwwkAIIw=;
 b=SvYRjwQMuJ7YMXKczNzyHuM+VA7OdTkL91JrLcRkXS/lCvBDTd7m+ybrETAWX+imX1
 v3pMa/VH64zjfvAMNOvmzCd13buRAghiYowP09cTX3f/nBbUTOAexaQlyq1X9NLkNcZ8
 a2rIdSukSIbrUJUlHnwdE3QwLI3YBDG+JI3YrLA84QqPxa3g9HhxJNxT2K321ob1z/dv
 qqkL5FlWPvpNv1O+WdRaJXyDeYT+rLOx4V/K/r/Yn6BNINUCK4Z4u2m2iXYN8EYBSPzp
 szjE/PmxHtCRHtasnF7syoVMciLcN8F/JT5RaDhATLjIlZfTmBmCuHY2iBalFWThFlsc
 luuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MW1rCYSxw/00/8UqyAWlM8p39wC7z3ywPKWBwwkAIIw=;
 b=HuUp+HDSfQi+4uMPWHcLeuYe4ZPQjYpHsiqjcbKTNKo/Lq91372smQ690rYeBWjZOO
 KBBf/yZ4DzgHEAkajQVNeIJxpJ85b3HALuMA4QCaigIfMTNPjYfBHO8jHrlxlo+kHaTp
 6VDGmVg7YgP+gqTtlnU4BN5eK3Ck+tUomMr2fBfhGHkDMDSXbv18k9WeU++0mOnmdRJe
 4yHGtyw5YH77NxOhxP+d9Mf7Fvx3SU6pS4cDlzHrknNP8Q1VJ0x8o4dskADtMVp/ymeC
 Xc8GaeZTP0QfwKL2LRcSbl3coPdNrjcP1BCecMqGtA8i1XrTuby8RspVs0Jguj19JW3l
 hZPw==
X-Gm-Message-State: ANhLgQ0yqAcFPT4iBq6Uvb7FYEA14aUVr305251UXAqX93BGy0fCH6xC
 t5+6/OQa5qdrWuIlmrx/O3Hfa/Jg8fVCqw==
X-Google-Smtp-Source: ADFU+vtKQcHQbnwWhTvZ2FIMsmPD5od9K+iwwIxWf8j9nXh7dozc6vWOamgKEEDFm+UpfCHkwZiBFQ==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr10710328wma.4.1583425882945; 
 Thu, 05 Mar 2020 08:31:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/37] target/arm: Improve masking in arm_hcr_el2_eff
Date: Thu,  5 Mar 2020 16:30:42 +0000
Message-Id: <20200305163100.22912-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

Update the {TGE,E2H} == '11' masking to ARMv8.6.
If EL2 is configured for aarch32, disable all of
the bits that are RES0 in aarch32 mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200229012811.24129-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19a8be84938..4ddb9443fbc 100644
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


