Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC05C352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719DD21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBZmPKYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719DD21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeqy-0000CS-JD
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoD-0002ol-6W
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoC-0006NE-2y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:57 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoB-0006IW-RS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:56 -0500
Received: by mail-wr1-x443.google.com with SMTP id w12so6597936wrt.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3h+vvIpNiWBS/Au+5wzfQugJDUo8XfEjM+O/Ow8Yjuc=;
 b=tBZmPKYmGMiRxdxRZ7Df749CNMeOds8v8Bzvt4ONPvDQfcWemhnuulWEetFtv/1hV5
 mlOC++awqMurw+ZuUhpAw2n1QGndhz9pmhWqZ3CuxFhCMrscjW9UPWH9ihnvJLyu7Oxh
 6nOkOfZAETpoLf5ZoYd1ZDh0rsRdNf8cnaTVLd/8+DUkzbtt8yq4/ERDsQdCSGN/xC2E
 MQ6z8vNG+agytmjueQ7n2IIwXwb1FLu6xrNGiUprxB6u9hqCefVZXmbR2VYXoGpMQeYv
 v8W1IqbXtHRAqmhVErqolmei5LRGF0J6p5Heh6dson4AsAiwWJiw7KSVVN8tLSXAwQ9M
 HiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3h+vvIpNiWBS/Au+5wzfQugJDUo8XfEjM+O/Ow8Yjuc=;
 b=izGEXfJc+25j+JwA0InSlaeqTRryl2wAv6JQ0KldGwVvQmJz8m4XRdxFFSCZo2NhFL
 ZpwqRqoHkBKdPEr6LyV5LjZ9A4ZqN15vkf42DbetSwxwr7z6tqY/F9FknJ0B+HyU+jwd
 FKWBpt5989IjPTaFlO2tfAD7UBnnxaYMbxdzKguRdD8TlF+cVSevmYuXBnocheu9Gmzn
 a2bPsw3RAGkP5PmbPtw0xHw+CXVH4eOZEHOKocRfxuocY7/DApytAZcVyM2Q+5t76Ig1
 KLYXv9ium07Tg7TeOaTBLKdGc/AeF6uSpNf47NJ3g6JJz9AUFvmCcU52Sfl9XXeLPDFp
 xAaA==
X-Gm-Message-State: APjAAAUiFDLvginP0HX3zShSI6gMgsZ4eunzuV4n3+xHwZWqnRF3kOpp
 LKntKwAEHEyxQgCb0/bVpORMfDCshRoonw==
X-Google-Smtp-Source: APXvYqzBoiFD8ML5jFObBH9xfe6ldCCNidMWfiuOmVuLB0iOHXYAuZbM0GEWWLZ+uwInSkufC+QASw==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr3439538wrv.198.1580986494606; 
 Thu, 06 Feb 2020 02:54:54 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:54:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/41] target/arm: Split out vae1_tlbmask
Date: Thu,  6 Feb 2020 10:54:13 +0000
Message-Id: <20200206105448.4726-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change, but unify code sequences.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
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


