Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C29C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D2E207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbPs+X2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D2E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGI2-00017i-Uh
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:44:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8G-0000yV-HS
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8F-00046T-KU
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8F-00045x-Fe
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:07 -0400
Received: by mail-ot1-x342.google.com with SMTP id d17so6677929oth.5
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=9aukZSJTtaEX+E6TYMtemh6Y/79Nrv8IxJ0VQThpXlk=;
	b=JbPs+X2MMT/f49HY2N+lxgxvEwKiCxhfb+t7JeSZ2reShq8ly+M/bzNWvbtLTEQ4FK
	Qh0UMWaBFq0GWCv4dC/vkSHtZWe5/V1ofH/bwB8B1mOAgrRA8SpPvuAH7Pc3xAvrcS4N
	ZoNOZkVgPyqw8Clr2vd1lPXvh3enyGEL6OHOGmLiL6CWRLARPeQeetqt3wOYRiyK6w9Y
	2FEN38qiyC3as9vPWIZbufQbIyp0WXpYUUe+7SK6qnk4bizC2lkC/fEnjpcX/XmqghuM
	g03kOgYSTH8SvP4X9Ih9drcgzn4jOrIMidinHKatN/9JLaMtJ8b629NFSlUp8BxasFGG
	C5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=9aukZSJTtaEX+E6TYMtemh6Y/79Nrv8IxJ0VQThpXlk=;
	b=kAtPyDWwF0TsM/2WS3BsVFvAJBDdm9zjYFQnuFJleliLAz3gWuuyJsv58DzfadB5Ha
	2yJL2b8nnMnX4lHQt8Dar+Fa09xtiZ/LO6fQItjxVI9Z1eoNEr/YCEWJmJMZSq8soTLZ
	mYNa1a1f+4D9BpmHJbClDd33beg0ESrcTcscQSj1EwdJIfMSI0yoMpoqV1wEvya4Qbxp
	xJOeYwbFlwnZvF8pqTNI6TbRiVY4Bgt6fgFQEi+SzZZfYn0vkuZjKNU5fHrFfPG1RfWQ
	2IasN20BUWiHEZ9kKqK8Ce8u33XuMdY5Vb8z2tvQX+9WlnJaiBtONJm5yuY0ApQU5idt
	ZraQ==
X-Gm-Message-State: APjAAAXBwCGDAJcyf6ImjTbi+fx1A3sprJhPQGRXtbYkhJ6apiDPpE/K
	Xu+/oG4WFTFFROpZeyv1GmiT1qyW65VUww==
X-Google-Smtp-Source: APXvYqzxFcZ5+HzMLMCjRs2nOz2anTjtWqnUFybw2rMwxfrcqqCpM/R1RolTCbCvcLIxB+nPHbxUbQ==
X-Received: by 2002:a9d:32c2:: with SMTP id u60mr6298514otb.70.1559680446550; 
	Tue, 04 Jun 2019 13:34:06 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.05
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:19 -0500
Message-Id: <20190604203351.27778-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [PATCH v4 07/39] cpu: Introduce env_archcpu
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


