Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADE1C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B9320656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ad6+1B98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B9320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAW7-00056B-3q
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:33:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7L-0007ow-TB
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7I-0007X1-TW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7G-0007JA-So
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:23 -0400
Received: by mail-pf1-x444.google.com with SMTP id y13so9480791pfm.11
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=BFtz5URzR/E+vzG71O/h8BWE9C65m1gz1E6Zde9gnDc=;
	b=Ad6+1B98HeUJs/WMd6q+BNYLk1PN9bgyvsM6NUt05RLRmTks0RLMlPF1X6hHMSk5R0
	g7V2DShAlwnATqeEvvsDQ20FG+UMKoBSI7ZysFiRKx6UFs3RvWJxdOKqxCnUcDHeTbM3
	18qv7wDuYC91N0C6GHtNYiUXNLcGcN1pcpCOVQvyZ+/ZkdeFk2XGUjxJW7hL8+MQOTKV
	E4Zj/C21/6C3rjaxn14uMdKe9iiFFPAj7aGnvyYdRXRHA5KQtMaEr5ePETg+wA6IBSw0
	LyjGYa2nXIDTQYmiIgSnX2PPRX0kizzcJMjdsEAwJMvU+OpU9qiZJeT1IJeUa7Zt1cHe
	DRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=BFtz5URzR/E+vzG71O/h8BWE9C65m1gz1E6Zde9gnDc=;
	b=CijOrPNbOVDiB7i6m7WOZRzt+WqJi0uhmOuM+cOZN7+9aCWh1TM7Tkz+9Hqg74j7WH
	MubKDzYnEzQxSE4ev5E7gagatAlwWVKEzb58oJoAOljowvdxAYz6/9zraMbyLZhU5u4A
	kb1BCOWOlgG4IRSMNQx7ydm9jsqpONFzZay0TJ/j/MQ4UkGefoHeo6XuB4S9CEQC6FiG
	udoF+eTqm6pvQPtnyOkPB/Z+OU6Y+n520TonKxOohTapknIchQZBM26f3Kk3iHCfTxlo
	WJ0HgBMO8SlLWmOfiIf+avyo01JgeQIUuBJO3eitFIIkW64CjcBuZ6fl16voIz+oRQMx
	bPhg==
X-Gm-Message-State: APjAAAXj7c+Md4IZQ8LQ8WFQm4yl7Ef+ICA1HRNEDq3nE3yjP+MeAW7k
	ij2ZGggkhcGtCnQV11AywoA5u9qj34Q=
X-Google-Smtp-Source: APXvYqxF0P1Ruv+v/hqg24RMpkQGpf3CjJ2N0ewhbwJ6y+ehNt5MCeIOT6d95cliLHG0Pw+1wAP0qw==
X-Received: by 2002:a63:246:: with SMTP id 67mr12167448pgc.145.1557274039289; 
	Tue, 07 May 2019 17:07:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.18 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:30 -0700
Message-Id: <20190508000641.19090-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 28/39] target/tricore: Use env_cpu
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/cpu.h       | 5 -----
 target/tricore/op_helper.c | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 4c997b6d30..fc3328fdf5 100644
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
index ed9dc0c83e..ba2f21a6c3 100644
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
 
@@ -2800,7 +2800,7 @@ static inline void QEMU_NORETURN do_raise_exception_err(CPUTriCoreState *env,
                                                         int error_code,
                                                         uintptr_t pc)
 {
-    CPUState *cs = CPU(tricore_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     cs->exception_index = exception;
     env->error_code = error_code;
     /* now we have a real cpu fault */
-- 
2.17.1


