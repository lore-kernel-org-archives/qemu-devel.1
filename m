Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866F7C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD4F20675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1X0wkAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD4F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56395 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOA8n-0000Jb-FD
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:08:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6q-0007D2-Fo
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6p-00068F-Lj
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:56 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA6p-00062x-Fm
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id t87so8916895pfa.2
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=A6Z3eRt9kjtdgrun+ExeQKOLr1ytY3aH2RtVK8s7SBw=;
	b=s1X0wkAV2PzJIqNVsbHrNcUx4tTT5teQ3b8nck+ZQWV44jaQ1X1McPJ8zONtMZuntW
	+AgqF9o6fQiqCgkgZ00AQp6kSPCMQFV+RQceN9GhxN6zyue5gu35FnD4isrYy8YAcorn
	/nyaT4Nq2gD69D/ON1nTnV7SqLgquD+CmwDMZjC7dWRY0RavPVXidywX17hjHphtJV1i
	BQzjYvFZarLRIjbXzUTc+HYDSf7fRPHWYuZU5IVSdBOpvXNzNdIeauzlb5LIhvqiXnN+
	S4w4s8kLtDCpUHlR7Ko2df5ukShkmPy7WUBm8n72UAvzcm89V+FWSzuzGIXwBs72DE8F
	b/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=A6Z3eRt9kjtdgrun+ExeQKOLr1ytY3aH2RtVK8s7SBw=;
	b=nhomPbBwfONwG42HKNBp6Q1my/MlnA1H22eFS6WedlYRVRiDDlF1dsEw8jT2lrcBIW
	3RPV6Ny6uS52cYztyQVr6Pi81uVEQaDNIwudQCYupfCQpIzTCxvmZNLCHN3Ihc79tQ6v
	+wWMrEoRGurzLVXM42L9SlBvyl9UyHwDP6Rls20llpV764tsitA6+nBa45npOimBXqvd
	QyNdRqacPTwPhH2xJN4wiHouUE2DsgLDLJZogUjm59XSWuPHeBbDZdhhusyOqaiIhg9M
	4lf6djnnS8mUOwD7pTVzuOBkpUcouBnw7ies8LDQdzO/PFBYEAhcUFpJpNbf1Ues3Bs/
	ZmPA==
X-Gm-Message-State: APjAAAUgK+6+GQwR1ZzWiSwgtUGymCi1Xqi+rmPPm6YVlnfctz7xsTvL
	IpFejxNa8Y4hEogUQp+6DPafpbBTelc=
X-Google-Smtp-Source: APXvYqwAGKlnLViPY6CrlHYD10dXHj4V4Mn9AGavp7/tdFghbm94e7TeQ1YeZu51RA4Y2ukdHTkylw==
X-Received: by 2002:a63:360e:: with SMTP id d14mr43527522pga.188.1557274012878;
	Tue, 07 May 2019 17:06:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.06.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:06:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:09 -0700
Message-Id: <20190508000641.19090-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 07/39] cpu: Introduce env_archcpu
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

This will replace foo_env_get_cpu with a generic definition.
No changes to the target specific code so far.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 454f6d663f..c62f07b354 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -371,6 +371,17 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
 
 int cpu_exec(CPUState *cpu);
 
+/**
+ * env_archcpu(env)
+ * @env: The architecture environment
+ *
+ * Return the ArchCPU associated with the environment.
+ */
+static inline ArchCPU *env_archcpu(CPUArchState *env)
+{
+    return container_of(env, ArchCPU, env);
+}
+
 /**
  * env_cpu(env)
  * @env: The architecture environment
@@ -379,8 +390,7 @@ int cpu_exec(CPUState *cpu);
  */
 static inline CPUState *env_cpu(CPUArchState *env)
 {
-    ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
-    return &arch_cpu->parent_obj;
+    return &env_archcpu(env)->parent_obj;
 }
 
 #endif /* CPU_ALL_H */
-- 
2.17.1


