Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6F4C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC3620661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wW/zK8OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC3620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyYC-00074h-Nz
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySN-00075J-DF
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySM-0006TB-DB
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:27 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:56270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySM-0006Rx-7b
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:26 -0500
Received: by mail-pj1-x1042.google.com with SMTP id d5so4462698pjz.5
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rwV4ZNAYmUhb3kMWrkN08M3nDN8bK4HgsQpKFnhrwoc=;
 b=wW/zK8OVMUMtda4NULAhEDzzWPnwaZPhxm+z8HDOwOuin10C1NGqOl2ZbD6A+f1ZFb
 VaW3OyynAaoZ1/RNEctsKG/0cEqQtkD1tu86i8I2pdg9NFxEsBmQFzOL/n3Sm1+is6a8
 IVd2+4UXoVURfgUTtFORSJf4utiEgYflIkqGYdNLVDFpfCMGqZmzYMAxJ4z2XGiQSdoH
 fWhZMmbRABE+UJaso74hJCiLZVp+keUqfJTztV9qXDP4jJw8JWnds+Qq0wBR2fD8i87d
 xfFPNA5vh7seALhteTPYCvma3f5DllVUuCcF+jR9mqkzT3Akm6DqN3VBFBpH8Op6u90d
 SQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rwV4ZNAYmUhb3kMWrkN08M3nDN8bK4HgsQpKFnhrwoc=;
 b=OjxutocFxA2yXa9FZw3daMVXFOTn5VfLFVK29iYqYLPD7geowb21SvsSn0PZ8/ruPk
 dCa20DN9g1QSu2bMBONONR8qEviuVbtDb0ntqL29PaDGI943+lVopgTKSrZp/cdU9JTt
 whKdRq+BHGMFqEZKJa6iqEgNXyfn7wabud9viIBZPZmCWPTKKa8sZjK9aI+7fsmFyxAM
 28ZmaJtFcwWSopU6Xzhc99JRNPFpgmPrUIqCVlCk/Nxo/ypw/SYjQsn+OWGODVO529BJ
 i0ar+StoryL2zNE8ABdEC+UKUJe2VMuMX4tfULkWVLecvXOtCsif13kxWIXNPs45FAgT
 q0HA==
X-Gm-Message-State: APjAAAUEcZxTjVQPJR7pqSE5IUM9dVLf//BcmxZ7ELIUyvNHqMIJYAqb
 9DItXiQ2BLYMDt/APaAqXodWaciYRnA=
X-Google-Smtp-Source: APXvYqz1paFPS8A+Pvv7qgRglu2dv5La2/nYhbCgV9y/jQzIVuPTUZnUIDABGkcTMVOarIo5llhiFg==
X-Received: by 2002:a17:90a:af81:: with SMTP id
 w1mr20467865pjq.14.1580585364892; 
 Sat, 01 Feb 2020 11:29:24 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/41] target/arm: Split out vae1_tlbmask
Date: Sat,  1 Feb 2020 11:28:41 -0800
Message-Id: <20200201192916.31796-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change, but unify code sequences.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index dbfdf2324b..8b3bb51dee 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3940,42 +3940,36 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
  * Page D4-1736 (DDI0487A.b)
  */
 
+static int vae1_tlbmask(CPUARMState *env)
+{
+    if (arm_is_secure_below_el3(env)) {
+        return ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
+    } else {
+        return ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
+    }
+}
+
 static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
     CPUState *cs = env_cpu(env);
-    bool sec = arm_is_secure_below_el3(env);
+    int mask = vae1_tlbmask(env);
 
-    if (sec) {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S1SE1 |
-                                            ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs,
-                                            ARMMMUIdxBit_S12NSE1 |
-                                            ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
 static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
     CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
 
     if (tlb_force_broadcast(env)) {
         tlbi_aa64_vmalle1is_write(env, NULL, value);
         return;
     }
 
-    if (arm_is_secure_below_el3(env)) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S1SE1 |
-                            ARMMMUIdxBit_S1SE0);
-    } else {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0);
-    }
+    tlb_flush_by_mmuidx(cs, mask);
 }
 
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.20.1


