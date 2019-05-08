Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4E3C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3463C205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQm/FaLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3463C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOATM-0002Ls-Eg
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:30:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7K-0007nW-T7
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA7I-0007XI-W9
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:26 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA7H-0007Ft-2o
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:24 -0400
Received: by mail-pf1-x442.google.com with SMTP id l132so1138pfc.8
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=oAoyrYKzSYqMV8L8feOy4E2tXuYIVICXlQ/6UykqD8c=;
	b=BQm/FaLGC95f79CODrRTw189Z/cCMkIGiRdn130r3dvcS1lPtFLbuoUbfYZj/nmtKo
	+nV36W9B9g9iKTML2MtpUUVW4sYCM25AKd6LHMi3DFDtXt/SXD0PzecHdG8ePDex2Zox
	XAt9QGOKIIkWQi70TyROaxbgqZ+8uGeirNnPWVjyjLCEtW8AOy/HVAHaWkyT7eTzb07r
	kDOOERT9FNrowNAisd15wk9yqf1octTLqkuvLgwCUq7urCRZ2v+387qDCyWTyWiCTx8m
	PVqCWRGkJQqlS8rHNoY+kX7C+HXrZw6T1QrhAMlHvSCaImhp/ZI+VO70p36t/+7GZfc3
	uI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=oAoyrYKzSYqMV8L8feOy4E2tXuYIVICXlQ/6UykqD8c=;
	b=aEgMT2PdYjlBD/zCMdKVwoji+aSWjYTKgh1tFP54iJmugeLJH35fEXj+Dg/oD+cNzr
	gLBHnTJRgM5oAbpka+0CQU72koZ0Sal7qmXz4Ijt/itiRgEmv0fBitVIXE5hcBkAtlCl
	hk2sqB/WuO0gRR8pGllXJPPvT/2KDl/1QyejDRSipXVcNWJtcm95twnBk+rIWQsRjBl8
	NNxIz4tO0vRS0JzyNS8IQ/oZMC6WVXyhRdOQj2HxIh9foRf2ajXXH7F4ggmepis3F88B
	s/akDaRaE3C19RsTHFVERiU9rYV6E36BmvU/ecOnlgMBJLoCQxq6V+5NmqODv687Lh1x
	/ONQ==
X-Gm-Message-State: APjAAAWERc7W/9usdm1DfvX4GQsKRUuWfWIZAFY6fITWfWKDGfo1lq5x
	FxjcQFZwTTivwVZv/Th9DLRsB29o9xg=
X-Google-Smtp-Source: APXvYqyJvburaHSZV0AmUOqNTlrLWewOV/+5dGTe3iGEaH71eOv0shPpr9wouHc7Y3ubgIE8mSimZg==
X-Received: by 2002:a65:64da:: with SMTP id t26mr43403471pgv.322.1557274038163;
	Tue, 07 May 2019 17:07:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:29 -0700
Message-Id: <20190508000641.19090-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 27/39] target/tilegx: Use env_cpu
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
 target/tilegx/cpu.h          | 5 -----
 linux-user/tilegx/cpu_loop.c | 2 +-
 target/tilegx/helper.c       | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 135df63523..7f8fe7c513 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -138,11 +138,6 @@ typedef struct TileGXCPU {
     CPUTLGState env;
 } TileGXCPU;
 
-static inline TileGXCPU *tilegx_env_get_cpu(CPUTLGState *env)
-{
-    return container_of(env, TileGXCPU, env);
-}
-
 #define ENV_OFFSET offsetof(TileGXCPU, env)
 
 /* TILE-Gx memory attributes */
diff --git a/linux-user/tilegx/cpu_loop.c b/linux-user/tilegx/cpu_loop.c
index 4f39eb9ad3..d4abe29dcd 100644
--- a/linux-user/tilegx/cpu_loop.c
+++ b/linux-user/tilegx/cpu_loop.c
@@ -206,7 +206,7 @@ static void do_fetch(CPUTLGState *env, int trapnr, bool quad)
 
 void cpu_loop(CPUTLGState *env)
 {
-    CPUState *cs = CPU(tilegx_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
 
     while (1) {
diff --git a/target/tilegx/helper.c b/target/tilegx/helper.c
index 4964bb9111..a57a679825 100644
--- a/target/tilegx/helper.c
+++ b/target/tilegx/helper.c
@@ -28,7 +28,7 @@
 
 void helper_exception(CPUTLGState *env, uint32_t excp)
 {
-    CPUState *cs = CPU(tilegx_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     cpu_loop_exit(cs);
-- 
2.17.1


