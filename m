Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F05C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E232084A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qy0i2Erq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E232084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOwGJ-00072n-7I
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:31:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBs-0002xn-Ax
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBr-0001RR-FR
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:20 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOwBr-0001Qh-A5
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:19 -0400
Received: by mail-pg1-x544.google.com with SMTP id d31so2270413pgl.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 20:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=k6JHJxPH4SUjOY+2AFOQmSeRVHdVtcQpQvqTv9tIMgY=;
	b=qy0i2ErqsZmVU4FeGmusySdXgZApMG8P7vPdmyhVVVbwMiLPsZcCYSG8L54/gcG1SY
	QMxagzZ6nWUSbaI5u8FMKEU1JkoUV1bNEfiSbW0gcobxqYZym17ysMcvZxZWobbCS0ln
	pAKqB8qVF8vRx5GtIUbrKELrqaV4DFrYRs1oa7RbNZke4wYf4++QFTABTAHzCff6bR+1
	FZFamuSIp/o78Q6oKpwQSv8Hz1wPJZIAa/Z/MGYltiN0fH9DIg1UHTFRcekD+zSBnm+G
	c2bf0/GEcZuUkHwEN7gzaFubBELbggJuJyzBNUoNt3n6sTgUIfNG435kp6pSXCo0UF4L
	pJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=k6JHJxPH4SUjOY+2AFOQmSeRVHdVtcQpQvqTv9tIMgY=;
	b=OS7ZOK4UrEsX+hBWcJiTAVzfY2NaC+l267a0GY2GKUNSTWaGeiUld78L5Ggjpto6wK
	faVWaPzlKsZzy6uSoaRGmpz467bhNyftosUQoFjU8jsFQWOBYGS+HP+eq1AALS15lFOV
	l8Uvq8Dr6nRcibzhStsu7D+56iBOUnigpmVgX7o93Tdir6amw52b1F/7guHdN9wqpGO/
	29GHOK6gbtuBs+8Yz30Hj+4ZbmssJ7c1lHzvR5UaAqLHUpNKIAfx/3JorjhrAEjQspyK
	eINeIESQ7rmV6O/+iwag8UHdNXzO6+MQf5kt4r3PbhJHzclfp5rWKrye+g1UvD8kek8u
	qEpg==
X-Gm-Message-State: APjAAAVVmvmGBwkdd2ds1FytYmdHsZ4utw4+kgfL1tX0EEsdf8MkgA1d
	t5/LiTNT/X5gsllt1Khq2d9NlkTcE58=
X-Google-Smtp-Source: APXvYqzlzM2QphKzoQxKlRKN5Jqzl7swgU+hLInPJHAaszF3+U6eah4dB9FBrgWcCCc/snseAtVSdQ==
X-Received: by 2002:a63:cf:: with SMTP id 198mr10410723pga.228.1557458838080; 
	Thu, 09 May 2019 20:27:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	t26sm6259695pgk.62.2019.05.09.20.27.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 20:27:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 20:27:06 -0700
Message-Id: <20190510032710.23910-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510032710.23910-1-richard.henderson@linaro.org>
References: <20190510032710.23910-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v2 4/8] linux-user/sparc: Use WREG constants in
 sparc/target_cpu.h
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes a naming bug wherein we used "UREG_FP" to access the
stack pointer.  OTOH, the "UREG_FP" constant was also defined
incorrectly such that it *did* reference the stack pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_cpu.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index a92748cae3..567351d564 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -42,15 +42,9 @@ static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
     env->gregs[7] = newtls;
 }
 
-#ifndef UREG_I6
-#define UREG_I6        6
-#endif
-#ifndef UREG_FP
-#define UREG_FP        UREG_I6
-#endif
-
 static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
 {
-    return state->regwptr[UREG_FP];
+    return state->regwptr[WREG_SP];
 }
+
 #endif
-- 
2.17.1


