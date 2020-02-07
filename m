Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2BDC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AE420720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnlbV/Fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AE420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04qk-00024Q-8k
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hh-0008Mb-MN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hg-0002WF-CR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:57 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hg-0002Tk-4k
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:56 -0500
Received: by mail-wm1-x343.google.com with SMTP id s144so3307861wme.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=K/U+IIcELqA/8+RNhiPHTX2soklHMEv4FEE0tCKxqow=;
 b=GnlbV/FsFVsWFeLtJ9pRyZUL61gIURXtuCtqlyNNHwi4bWJm9DslWxdtLqirP/mWGN
 OenTg+uhy4Fba39G4KiTVUmmX7pQJwNDqKp9akAs3aPKUslkGcSqzR8E1O9qJTmFar0W
 XOPAE6YZnyDTU8Dmdb3izZzbpNYfsCdnpvbe/1JRaxVCDRu/at0VZF+pWh03EbBa8uby
 RSeyCApaZb4ta8SZfRcr230P4OPwKfzdB08m1WUSE1FjzhH1cWvl8BTE5CfSBqcS9CNj
 4GariruQKOclBHABpPqmnSSF1taYaaOJ41YmyJ5q+dB8lZek/Hrfgjesg/xsOkp+bHTu
 +Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K/U+IIcELqA/8+RNhiPHTX2soklHMEv4FEE0tCKxqow=;
 b=I+qYyUvb2uGoUPBF+NUeua6iaZ/a3AxIDsGd4n6/Nf7YwnJbJmaCX99KhroUp7eXWb
 iq43KZkRoS6wh41RHkjyRH2Zmj6b+99aFk6cBvG+3903qzYEAXMsVchrtKwH9VJMDRkH
 5BsDFW4Qrq9SVgsv6x39XZoSJ35AdB8ixMbLRzF6jvWjk3iotBfEvu74N93bTLWAd0sx
 yAnCESZxXX7UYTY6l67xGDahPssuApklkixlpPn6ckNGoXvGeOpCaKfgFzElRFI5aqwq
 SkwLGIiIaI6aTesGNKr/0JMJVrxfKry+g/FaZtPnywsTuL3An4cw705BtEufdcej8E+u
 9s3Q==
X-Gm-Message-State: APjAAAVvGYcyzKeBhj4+vkhIFsMYv0BnLfzAeAG4Njw+lAy3yaIDirWN
 AK2FrmkcLP4ULPlJczhJd6y7FMNGyrM=
X-Google-Smtp-Source: APXvYqzEjfEBbngQ5VbyWGry5U/LEhMMfDaXqyPqUbKo67MmeMiiC/WCE1lBLVoGWzfYMS3F0i1D1w==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr4649661wmh.52.1581086034907; 
 Fri, 07 Feb 2020 06:33:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/48] target/arm: Simplify tlb_force_broadcast alternatives
Date: Fri,  7 Feb 2020 14:33:04 +0000
Message-Id: <20200207143343.30322-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Rather than call to a separate function and re-compute any
parameters for the flush, simply use the correct flush
function directly.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 52 +++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 49da685b296..bf69935550f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -614,56 +614,54 @@ static void tlbiall_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
     /* Invalidate all (TLBIALL) */
-    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
     if (tlb_force_broadcast(env)) {
-        tlbiall_is_write(env, NULL, value);
-        return;
+        tlb_flush_all_cpus_synced(cs);
+    } else {
+        tlb_flush(cs);
     }
-
-    tlb_flush(CPU(cpu));
 }
 
 static void tlbimva_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
     /* Invalidate single TLB entry by MVA and ASID (TLBIMVA) */
-    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
+    value &= TARGET_PAGE_MASK;
     if (tlb_force_broadcast(env)) {
-        tlbimva_is_write(env, NULL, value);
-        return;
+        tlb_flush_page_all_cpus_synced(cs, value);
+    } else {
+        tlb_flush_page(cs, value);
     }
-
-    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
 }
 
 static void tlbiasid_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
     /* Invalidate by ASID (TLBIASID) */
-    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
     if (tlb_force_broadcast(env)) {
-        tlbiasid_is_write(env, NULL, value);
-        return;
+        tlb_flush_all_cpus_synced(cs);
+    } else {
+        tlb_flush(cs);
     }
-
-    tlb_flush(CPU(cpu));
 }
 
 static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
                            uint64_t value)
 {
     /* Invalidate single entry by MVA, all ASIDs (TLBIMVAA) */
-    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
 
+    value &= TARGET_PAGE_MASK;
     if (tlb_force_broadcast(env)) {
-        tlbimvaa_is_write(env, NULL, value);
-        return;
+        tlb_flush_page_all_cpus_synced(cs, value);
+    } else {
+        tlb_flush_page(cs, value);
     }
-
-    tlb_flush_page(CPU(cpu), value & TARGET_PAGE_MASK);
 }
 
 static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3965,11 +3963,10 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int mask = vae1_tlbmask(env);
 
     if (tlb_force_broadcast(env)) {
-        tlbi_aa64_vmalle1is_write(env, NULL, value);
-        return;
+        tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
+    } else {
+        tlb_flush_by_mmuidx(cs, mask);
     }
-
-    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static int alle1_tlbmask(CPUARMState *env)
@@ -4091,11 +4088,10 @@ static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
     if (tlb_force_broadcast(env)) {
-        tlbi_aa64_vae1is_write(env, NULL, value);
-        return;
+        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
+    } else {
+        tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
     }
-
-    tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
 }
 
 static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


