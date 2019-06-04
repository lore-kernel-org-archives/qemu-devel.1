Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF53C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B62C2075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 21:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JArYRBxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B62C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58011 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGY1-0006W0-Hv
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 17:00:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8n-0001T7-Ed
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8m-0004eE-IT
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:41 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8m-0004dZ-DT
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:40 -0400
Received: by mail-oi1-x241.google.com with SMTP id u64so16636042oib.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=YQXS0805f11aCOQVinsy2uv+bSnryD5T76PFwhCiklU=;
	b=JArYRBxPghL/cDE81vV0ce+oU6C7ziwidFxFgG/YURtzBE3XRmsUOh7qO3GcAFHt9D
	pVNoJgzrlyHR+PrEfMkLZSf3XrZhIH4EAAbsCmaZcAqKXgrhhYUInYMuit8MfxaXFEh4
	UPd+Nckq07zMAK4ic8lkNiSGvPJUpS3Vx+vqO8MIM+GMKiKHhVeeClJdgpMTs8ta0wbs
	gzChzFOmLCtwqiA78Os9zKuh5QWaz3wsWjIC+BWVB09DuJktboHpbG9HDEUMyeTYUFuX
	nja/ADes7qPZjBP0o6HF7Mm1KuVTjA5CiKJ9XS70FI6Dcy++9+Q14PgtvOpD7ojuWhK/
	HF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=YQXS0805f11aCOQVinsy2uv+bSnryD5T76PFwhCiklU=;
	b=mFLoKnMW6qn4J4sZTI1bmHxrDB3Ce1TsZ5W84D+3HD8e6UySTfTqJajIqLlGeJ1y/V
	SAJivEXRm4l9ls2BvxD6cyXrzugu7ut9lQP1n6KeHuLM1JTPKkExs72k3fQBp677Xmli
	TYelKui9ykfJZzO+ciidyLlojbLunoI2dZX4eDJ0tBsGKUzEabMLKpY8If1JGHLTVJR5
	PFYF3e5pdgjAvHQTo4XrA+KUaphHEnbTHCVcrW+R+JiEeGVA0sKs61oX6xgtrSamPu1m
	O7CTbSCe0CfwwE5wl6FGyIrBCdCc8ULfSThuhaisc9Z8yFNSvFML4moI7Sizz1m6J9qs
	ec3A==
X-Gm-Message-State: APjAAAWVmXt+Cd6FhPrgeAgMGXP3trAeH1IURL47bPOGHrLPqD/oIup1
	qLzfzY/iKqKlmP6EwtFcdooNAtjBoSrcsg==
X-Google-Smtp-Source: APXvYqx/dIbehgKOYZKcpGO86DAYvgUSsUNPMXpZLPhBuv7o0hXIE3xCTpyUxCqkxJc5cwCM2+uk4g==
X-Received: by 2002:aca:ac4d:: with SMTP id v74mr3417597oie.66.1559680479344; 
	Tue, 04 Jun 2019 13:34:39 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.38
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:40 -0500
Message-Id: <20190604203351.27778-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: [Qemu-devel] [PATCH v4 28/39] target/tricore: Use env_cpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace tricore_env_get_cpu with env_archcpu.  The combination
CPU(tricore_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/cpu.h       | 5 -----
 target/tricore/op_helper.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 4a2a955cc5..6a40d37362 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -208,11 +208,6 @@ struct TriCoreCPU {
     CPUTriCoreState env;
 };
 
-static inline TriCoreCPU *tricore_env_get_cpu(CPUTriCoreState *env)
-{
-    return TRICORE_CPU(container_of(env, TriCoreCPU, env));
-}
-
 #define ENV_OFFSET offsetof(TriCoreCPU, env)
 
 hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 601e92f92a..9476d10d00 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -29,7 +29,7 @@ static void QEMU_NORETURN
 raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin,
                               uintptr_t pc, uint32_t fcd_pc)
 {
-    CPUState *cs = CPU(tricore_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     /* in case we come from a helper-call we need to restore the PC */
     cpu_restore_state(cs, pc, true);
 
-- 
2.17.1


