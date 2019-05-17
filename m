Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F50C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 03:00:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A043205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 03:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGLRipbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A043205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40388 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRT6d-0005JA-Lg
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 23:00:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSnB-00061r-CV
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSn5-0002LK-0L
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:13 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmy-0002Df-Ao
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:05 -0400
Received: by mail-pf1-x442.google.com with SMTP id g9so2857979pfo.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jubgcMuTGNSY5TtGEwh0c6OxeP3qp5DidyhAq6jVSSw=;
	b=pGLRipbPkOXOmjEI35CoXuovLU7K9lZmA0Xeuo/WWpNHAjFi9lEc8eo49fVJXTMs2m
	plPUA3xbKdPi4eX2d5AdtzQt28MUGVRGHy8VAtAqzFQKnqaacSUA2lt2cSqCaEsDnLsn
	Cnpxcw4lTCDvcorMxeP4zyrt5Ygi2eVHvO47WA1v5HwodeyXvpE90b9qQ/bfRXRSlmf0
	2/0ZpNgf0pUW6d2dTo6YYHYN40JrX9mY542na6qRH5CeIjgZVntPi80nK/2IPOHeXjEw
	xG1qws8GD6Oui2PfGFvb/CMaE8CJ301gnGtqzMUgS5Cm7AYjcvVvqkUkmiqicsPB1n1Q
	TGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jubgcMuTGNSY5TtGEwh0c6OxeP3qp5DidyhAq6jVSSw=;
	b=VfNCXV8qpbQVHqrahmqRkha9eG0V7ReJFKOwfn6DGKOAx4xR2l0svX84SnUMOnoBWu
	7Pqzeo4l560BpKCTLYsoQuDlH+R2kgAJiZWGFsyjpMrxakKMPWjb4Nc8vSWfiJdIgI1X
	san2EpqO6Adb4PLQNGHkKVMjcCcFlFfP9RCAo5khLc2Duw0IMWC695zj9C1i4dI+LSzg
	vTU55usqqZrgiuDswZgpeAHSZks7Fm2s7DVJ0gkqBFJBs6+11Y45emMIZmubkqrow3QM
	uCpgKPm0yneUwSfzFiDlgRNl+ifcMbdRRLLH5UhL0x4GvNJ3Z9SqW7HktQl/oT3x3AJP
	hHxA==
X-Gm-Message-State: APjAAAVjeJNN6UiVqdjyVEE3DkIBY7k9errOj85SBcAHv6bptjjRvOU6
	xv/Y2cKUk2Crxd+9UzTE/ehpDwJaj6A=
X-Google-Smtp-Source: APXvYqw4F4Uu0kRyljjYoeRxjOPiwi5RGhEQonRM++/bKeeIBJ50Ns3hXxmycTQbR9fmkijBJeMxYA==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr53764456pgi.7.1558060794993;
	Thu, 16 May 2019 19:39:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:22 -0700
Message-Id: <20190517023924.1686-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v8 23/25] target/ppc: Use gen_io_start/end
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


