Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45068C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E3F2073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E80EYpEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E3F2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Foc-00056B-6l
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgy-0004PY-Fm
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgx-0001tI-98
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:12 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgx-0001qe-0A
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id p17so7025970wma.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=m2dLEYJaJTFcXfFVK5jWIib2jbC07UmG8YI+7vEwhGE=;
 b=E80EYpEOl4feEEqsuDvsG/RpHnCEY0e/0WX9JofdCj4faAL3OFsn/WTqVOPt2Oklsd
 KkdTiSW64R/TankoFFCW6BFIUnZztL48UJZXYvbm/RPGhnfD5PLtVi9t/Ow2r+P/M9Sm
 c9DuQXzJOX7Tk68tynAN6Xphfpz3r6HhMkPlSDMm3Z0eoR9rm4FMnCmUoJe1VO4Ivj1O
 lX+aKM3K08hrCZSaBHFSD+kOY4diF647b3mZgSYRghzD9l736JSOMWZwJ1aEvioax4pM
 HJrXZ50l0bsSS/LVmmG/eZb16z7A1+brms4F+ZF2dvGNtV6od5hqgc2RH/9G35X9bO2A
 yi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m2dLEYJaJTFcXfFVK5jWIib2jbC07UmG8YI+7vEwhGE=;
 b=fr1bZBpUe4mY2FZg7QgaQfZiaClZowp1byvW1HnNcq/tElg5jg8J+cyXMpDNnP4TUV
 t5vTRi1S660tiausD0pz2GKX4oaqrXYgDC3cJLAdP0e3E29swh59zcMIP3q1uYAqBKth
 C3EecHHsBZz+Iyj86K7Jnp5TkjcyV2UPh06LZViVm+5za0Mh+SMx8NANfIF5DLVWSUqh
 8K7TtAC/uGGuA2KofhJx8N82txaqRgnkUeuS7F3qb+5MPb8NjYLeGUBesAPfBNocGmx/
 9GunPGmMFeKpkT/Fa/aPpNvAp4Mvm1kS0kSzw4wapqGuFNB8aR0NDNbIw6D7+v8Wr2iA
 A4TQ==
X-Gm-Message-State: APjAAAUSEeQWrwOyybE0PERdI3Dv0BM5QjpULjpX+y7GBEoSa/Wjt3f4
 3xkRCTA1083m91Q+QPPA9V1PgIRYLEA=
X-Google-Smtp-Source: APXvYqwS3UUCv0vMIr//1klnJCoLaNJzOMpwhdufzvVOvPLysUqGpEiF/ejsPHUiFYAuZziwUDNW1w==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr6205303wmk.172.1581604928709; 
 Thu, 13 Feb 2020 06:42:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/46] target/arm: Use aarch32_cpsr_valid_mask in
 helper_exception_return
Date: Thu, 13 Feb 2020 14:41:16 +0000
Message-Id: <20200213144145.818-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

Using ~0 as the mask on the aarch64->aarch32 exception return
was not even as correct as the CPSR_ERET_MASK that we had used
on the aarch32->aarch32 exception return.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index bf45f8a785e..0c9feba3929 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -959,7 +959,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
 {
     int cur_el = arm_current_el(env);
     unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
-    uint32_t spsr = env->banked_spsr[spsr_idx];
+    uint32_t mask, spsr = env->banked_spsr[spsr_idx];
     int new_el;
     bool return_to_aa64 = (spsr & PSTATE_nRW) == 0;
 
@@ -1014,7 +1014,8 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
          * will sort the register banks out for us, and we've already
          * caught all the bad-mode cases in el_from_spsr().
          */
-        cpsr_write(env, spsr, ~0, CPSRWriteRaw);
+        mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
+        cpsr_write(env, spsr, mask, CPSRWriteRaw);
         if (!arm_singlestep_active(env)) {
             env->uncached_cpsr &= ~PSTATE_SS;
         }
-- 
2.20.1


