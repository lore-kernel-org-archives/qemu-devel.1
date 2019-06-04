Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA2C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0672075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FP/D1Y1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0672075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGVv-0004rn-Ct
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:58:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8m-0001Rm-6I
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8l-0004c8-36
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:40 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8k-0004bE-UQ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:39 -0400
Received: by mail-oi1-x242.google.com with SMTP id w196so7111883oie.7
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=ZuP9P/y2awmw4izu8Ta8VFFIgoiKI0vJso4eBOFOhZo=;
	b=FP/D1Y1iqgpLQtySYV9nBgT4e6P62H7u/gFtlA4N3isoDkmlvj52z2xgYOwPw8/RPX
	IrZPcjYubpbF1F7myI6q36APDhfqehV+liNy56LewCL9CBk7i7Ku74KwCUljFHN7Ym1D
	LxvrSgZS8Ura8njbR1Oz5lafu4wfxoXFDynpvu5sgjqYBDhjwWLbxie/Kj3HpfmaVtxY
	8RZlYkVNHlFDnAiiVOmAyq+mRIiZH4uq3W+Rznm/HdKxpYe/v/C3Bpb1N+Lq44XyTerY
	rbxhgEO/uKYicL3ZHrE4ng/e4DkOiYUL02X7ikejrsTlxM4PELe9DVwthZntXz7XSPIX
	adhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=ZuP9P/y2awmw4izu8Ta8VFFIgoiKI0vJso4eBOFOhZo=;
	b=Ukc+1UlBJkq0pUt3Svvtvmn7NjCeGjbeL0AnZKzn+21clFXcaMuHgAMs8DKexUJ1JY
	ggFzqfMEXZ6t4FZlo4OCy+ZI5vweX88qaKNvUvcgEse5CuPyFi2MbbhC668TH2a8KNpl
	XSnTV0uDV6q49U1DRPO+xv9v2zsWTKHGIvAeen9TIVd7Dt6z+UVycM2XOmwRB669yOpc
	sNd8Yohijt/p6bvi9I48+F3BQslbMpNG06xL81oP2zXdBFc1D6Inf8pP54CmL/uLzyp3
	rtVo7t49ZJEGewSvcaoqGiGp/XLhGbnF16GSZGp+O45Mb8LTkaHBjZvN//bjkgSPVG3b
	UDdQ==
X-Gm-Message-State: APjAAAWusvlmZrXIVC45acVIsEVU8QWgxbz25Q9o/APJxlHpWFzQjRYA
	7OWIvNn6tLesaNvSgpabpdr4falzdRXz4A==
X-Google-Smtp-Source: APXvYqzeprpiStjU6Tcb2WXnZ5vwAX+F5SacMa7H1nyiykhsqrCfw4UTLTQ5hRHpj9okg/aVKHYDZw==
X-Received: by 2002:aca:c786:: with SMTP id x128mr5295534oif.146.1559680477950;
	Tue, 04 Jun 2019 13:34:37 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.36
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:39 -0500
Message-Id: <20190604203351.27778-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: [Qemu-devel] [PATCH v4 27/39] target/tilegx: Use env_cpu
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
Replace tilegx_env_get_cpu with env_archcpu.  The combination
CPU(tilegx_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


