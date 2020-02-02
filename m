Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FD9C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF4E20658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUh6Ca+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF4E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3kY-00036R-LJ
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gy-0003dM-5A
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gx-00024I-4Z
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:52 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3gw-00022w-UJ
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:51 -0500
Received: by mail-pg1-x541.google.com with SMTP id j4so5748889pgi.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U1CXib6JNYX6xUt67ormhDS8FAN7+A7WszdUWC4DAwU=;
 b=vUh6Ca+UaYzIBPj9QmdQoAB8fVRDMeiEbBjr2APcdq7JQqfuPmI9PTFQ+RC9bsO/EY
 5ZRe7Gvaj6aaqiNahLoreV19WaDePDKbprA5FqvCDyrUkhWmGsIyvRDzBeK8sM9XnTbn
 oqBW7fHxQtliiQc0DgkgbGvEU5dTockkbpu9E+pXe3XfjyxYVDaYfMO4JY3Ue9Lx9/E+
 zLMgeTFB0sv6Tz+72aac3uVmi8zmDgkSpxrZEDYIiXG9cTkN/6VtSsGRWdhA0AvDDcAX
 1HqVnmbldnQoF+C445l4X31ymyY2/Gs980N1klyOhpW+1LWfkjdPr+xL9+A5+rmQYl5P
 GJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U1CXib6JNYX6xUt67ormhDS8FAN7+A7WszdUWC4DAwU=;
 b=D98GqwXqEGjVED2sU39Qlq/CHnbq7+adR3yqEMomujgjDQTJEr7vmggERryKwi4bp9
 pMWmHh97Hmencjwwhn2CqdYZ/kuZujU2KdM0jI1cVDgWuYxv+aPrt4JXIQQpPE8xHG3W
 Se0aGHeoZ9fUqBsYCep56yhEQVz6cUuJCLhtr0dD0lNaZIV8x9RC57IVYwq1cN984VbP
 1Z15KgDxDvSrmwpGHjxLuj4X00h2y60v2q7DU+sbpUwuX6SzMcnxc0yuwIYeYkRutXg7
 jfsowZfVbS+pogKPpRIXKIOvMjCEHcecJKqczmgEUgDUQb2/7fOZmV6bn9F3BbDWMpN5
 JMOQ==
X-Gm-Message-State: APjAAAVuWgtHLInmpLpsWmj7SdKroY1k8miaw39aHSNX7k7oaodKpZ/7
 8EHtMf/ah7TeklPIja6dbZmdy0W6LAg=
X-Google-Smtp-Source: APXvYqx31egw9nUshmCihxP2bBcOIAkgU0CVLuRPU/pc5yXIDcYpVKYhzanTHZyct80QGVJ05p4WfA==
X-Received: by 2002:aa7:947b:: with SMTP id t27mr18395390pfq.212.1580605489713; 
 Sat, 01 Feb 2020 17:04:49 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/14] target/arm: Enforce PAN semantics in get_S1prot
Date: Sat,  1 Feb 2020 17:04:32 -0800
Message-Id: <20200202010439.6410-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

If we have a PAN-enforcing mmu_idx, set prot == 0 if user_rw != 0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 13 +++++++++++++
 target/arm/helper.c    |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6be8b2d1a9..819de9037f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -893,6 +893,19 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_E10_1_PAN:
+    case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_SE10_1_PAN:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /* Return the FSR value for a debug exception (watchpoint, hardware
  * breakpoint or BKPT insn) targeting the specified exception level.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 638abe6af0..18e4cbb63c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9578,6 +9578,9 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     if (is_user) {
         prot_rw = user_rw;
     } else {
+        if (user_rw && regime_is_pan(env, mmu_idx)) {
+            return 0;
+        }
         prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
     }
 
-- 
2.20.1


