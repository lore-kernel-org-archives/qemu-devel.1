Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00FCC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96B320873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USq6jzxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96B320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53006 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd3A-0000Yp-QU
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:25:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvd-0002o8-1y
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvZ-0007D5-AD
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:31 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvX-0007A2-CC
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:28 -0400
Received: by mail-pf1-x443.google.com with SMTP id s11so9613058pfm.12
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jubgcMuTGNSY5TtGEwh0c6OxeP3qp5DidyhAq6jVSSw=;
	b=USq6jzxMgaDUaG3WM5mv/86HAk8ydS51FPFNqcritjxxEKAosVlp5suwP9i/dIjTav
	g3btabJUyGGeeUvdNCD2n006RMXNCr8HJhUowRVkirYEJYCPKg9lQ6o4cngo6OfoIX4v
	MT7Re2niSRdtLT1amhr69tPvfXiDoIUR0uPMDi/lK8ct3Vt82XMHRyaBCSkVHLb/deF4
	e/j4j/qLRCHr011Kwqi9WQI7UJuNQ+CpBx19x8Wxum7R+BRTWJashGP4hr+8/fzKityc
	Q/ZJVDSyAo8B5Gc+6BO30SzXT6Bb9PFKi2dyPOIHU8YVho64enIFGigrCDePbVICpiej
	xFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jubgcMuTGNSY5TtGEwh0c6OxeP3qp5DidyhAq6jVSSw=;
	b=AgmFE9o9fkqVZ2cgrp1acYf60mAfhAFXXw/HDQvzawl7bLVzQIpEj/hbJVawZz8odU
	slrGFrIYuGsK73BB1I3HvHhsQPsFtK+Ga91GRyH7a0R5yjy3vlEIB/h5NKveEbYX4pD3
	RGeLCBcW9Q2GKWdUZvHn3GH4yVm++2niC81pjyh9IQ9uZK/jkjw7zRH+JscfBlba/ykG
	AcscsychIByBnQZbBIQzXwoZCIS2AXalFo738TlGdNO0Cc6BAmhpdp2EERLSI9QiIcBg
	OjgLH4gNwEXld3AKBwiy4VfpmUkYvr8+T2n747felCFvt5UQu9QAGIqI0D/DDysgWFbv
	XxdQ==
X-Gm-Message-State: APjAAAUY+//co7YGcBLJkAzvAXf7B3/Q12aKNJwPNzd3lkY3SqXaZ8js
	q/5eT2pP7iGJQ9QC9bxejAYgTmSHSKQ=
X-Google-Smtp-Source: APXvYqwN/XIu5YDFP20JIHiUC2To3EhR3h5sdDctRk+h4VOrAcg6pXgoK2DkJf9XGWtWTVvLATLj3w==
X-Received: by 2002:a62:2687:: with SMTP id
	m129mr43682012pfm.204.1557861445759; 
	Tue, 14 May 2019 12:17:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:52 -0700
Message-Id: <20190514191653.31488-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 23/24] target/ppc: Use gen_io_start/end
 around DARN
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
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generating a random number counts as I/O, as it cannot be
replayed and produce the same results.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b5217f632f..4a5de28036 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1847,13 +1847,22 @@ static void gen_darn(DisasContext *ctx)
 {
     int l = L(ctx->opcode);
 
-    if (l == 0) {
-        gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
-    } else if (l <= 2) {
-        /* Return 64-bit random for both CRN and RRN */
-        gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
-    } else {
+    if (l > 2) {
         tcg_gen_movi_i64(cpu_gpr[rD(ctx->opcode)], -1);
+    } else {
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
+        if (l == 0) {
+            gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
+        } else {
+            /* Return 64-bit random for both CRN and RRN */
+            gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
+        }
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_end();
+            gen_stop_exception(ctx);
+        }
     }
 }
 #endif
-- 
2.17.1


