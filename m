Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0460FC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A5620658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdE5fkFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A5620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3kW-0002zs-0H
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gw-0003Z2-Ro
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gv-000224-Sm
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:50 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3gv-00020c-N3
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:49 -0500
Received: by mail-pg1-x542.google.com with SMTP id 4so5734811pgd.6
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vm99WKNsbIgWAw0gtT4tkIR4+ETnRFNvmZH5RsHuOfI=;
 b=PdE5fkFrg8A8UJiG/TF69h1FFceh69fibJBHeJjz8ZgMVAQMgQw5EBSLyi9SqGEDX4
 e6Bdinb9ZZMAeJUQIJaQiC457uZSzj8myDjAdQWT7BMh26rPrp+1JX1f1NZS7WgRgyd7
 C9cM4s8y/iZmc+Sb2EwXxJb/Ztl+w4lmripTiZkou+hHYLWfQI8PI5OZeZkJnAaMJJtF
 xHVFnl5Nq+16YGRPcmh7GoJKLy7tjgBAXa1S+hPMDa3G3Wsd2qLwpfSn4ASnvZPcEm6E
 Vn3SDxXVArdr8gGEy9P3HaG2TqxNLjfN4Pyvs8y9034Vk/BospJPuiUNLtDQz1BJRyGs
 2RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vm99WKNsbIgWAw0gtT4tkIR4+ETnRFNvmZH5RsHuOfI=;
 b=Om3epyU4TS/As2PBcjB4kpG26duUTAL8L/nPn/SvllwWOeQdWhm0gqy2I7kCMaIL8c
 UF8cJI0LTA3snK2yov98FKfN2B12n13NipoTCWIaBHWwvJ5JnlHvrFCxqn0j8iVNVuwL
 ri8D6artIkM92sHaYZ5N8EOS991+eSdUfJJOamNH6q9JxYAlFILUTp8yNJC9B7V8bDb8
 mcHS/JiBWZx6iLtEnYG4QlLLtztDWHBmf+tWRMYG6WwNHv9RGFvEL4N3pz2pYkuNYhjT
 V6Fi1awef0iM3JyAja7/VMM+jLxXLEoooOGAliyL7FEW7qsDpRY8Udds9gD9gQkAOfhd
 0lkg==
X-Gm-Message-State: APjAAAUKucxKsUlKBLkrGnP9Vrkr36r4vZqdjufzDEmvHDYasuMhv8tl
 Z2h8ANmp3ESRVu0njdPiKCN+cSlDw8U=
X-Google-Smtp-Source: APXvYqw0XqwXY8swZZaxxc2zioeMhKT6UH91gvgw7kRRrx8rAC85rBTWLLDmclIBVh4NnMr/80KDWA==
X-Received: by 2002:a63:ba43:: with SMTP id l3mr3402636pgu.120.1580605488451; 
 Sat, 01 Feb 2020 17:04:48 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/14] target/arm: Update arm_mmu_idx_el for PAN
Date: Sat,  1 Feb 2020 17:04:31 -0800
Message-Id: <20200202010439.6410-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Examine the PAN bit for EL1, EL2, and Secure EL1 to
determine if it applies.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 90a22921dc..638abe6af0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11904,13 +11904,22 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
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


