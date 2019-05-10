Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C35C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B40A2084A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3jv+bsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B40A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOwDo-0004Bl-G7
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:29:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBu-00030H-QU
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBt-0001Sd-SW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:22 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOwBt-0001SI-NE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:21 -0400
Received: by mail-pl1-x641.google.com with SMTP id g5so2133963plt.2
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 20:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dB9naD8XYt7AtlbN9T/W2D2B/j/Ax2scb9z0hcM/3hI=;
	b=m3jv+bsahW28jCHcbKpzohUtOdPkYK7q8eZnPVQW7aSDBZTwJXydlhMlSuGAvbeTck
	wJV28h8VS0IHTiDiVXVwWV+/dPZzZwn3fuySms7kdUJP2ay635//MNzuaC4MV9HZNs+2
	/j/7pYo7FdkLstxY2yX3U9TUpCju3XPKSDJbqyi8L6dfgw2pzp+x6it5QRFTwgn9HNOB
	XF4OMIbbJZIZ3pVPK53yJ1B6SPfVQ/3PNGWRFFPrAXlUC+PsVgm9B/gUnJ6aTkThYcK+
	RgtF4b7alkCTPik6QsqdKUzcm8YgEa5LVoeF70OaIdqBC8JGbPuo7vgB183aigzOTtDj
	WNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=dB9naD8XYt7AtlbN9T/W2D2B/j/Ax2scb9z0hcM/3hI=;
	b=J0k3w4lugu15hKiLTxC+bW39RQ2y1AiE0PFKVLfIO8xr4OXx2cBrG1KOVhaCx8E7bw
	LTfRMnpBny483DIl6bpqZl8RLLXVA3Two1dhJa4zNDLG1Pnew4C1f0as5whKnQtQo6/c
	gY5noggOiXa2VnYXAVXvyG8k64qzZ6QHuE3NipJVcX3ImQTXGhetyFwl189xuKldOXn8
	g+vs/FDBHK6r0363RO+T5bjwoQ4BWAzWmLB2rCSz2guwe8+fQp7G6KQx38eg80aKKvzO
	gRff3QR6vsDNch8wtigrn8omSSsRkrj1s69TPAHi+MzIq51hGd+qg8cuFsJONe8m3V/q
	O33w==
X-Gm-Message-State: APjAAAXSbsCTOqkUICfIdUsont9nHEp67oxlVr+/cR0cOGm6g/fvh+PJ
	SxBkp4EULsEnEV09FBA3SBzmw0AK07s=
X-Google-Smtp-Source: APXvYqxYeWfXMHxI6n/tRxUmTiYLic6CDqqKbz1m0kpBUBd+zkZDUjqH09xIUjOo2y/XXnkdf+kxuQ==
X-Received: by 2002:a17:902:be09:: with SMTP id
	r9mr10113624pls.215.1557458840529; 
	Thu, 09 May 2019 20:27:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	t26sm6259695pgk.62.2019.05.09.20.27.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 20:27:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 20:27:08 -0700
Message-Id: <20190510032710.23910-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510032710.23910-1-richard.henderson@linaro.org>
References: <20190510032710.23910-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2 6/8] linux-user/sparc: Fix cpu_clone_regs
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

We failed to set the secondary return value in %o1
we failed to advance the PC past the syscall,
we failed to adjust regwptr into the new structure,
we stored the stack pointer into the wrong register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_cpu.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 567351d564..bbcb3a92ed 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -23,18 +23,34 @@
 static inline void cpu_clone_regs(CPUSPARCState *env, CPUSPARCState *old_env,
                                   target_ulong newsp)
 {
-    if (newsp) {
-        env->regwptr[22] = newsp;
-    }
-    /* syscall return for clone child: 0, and clear CF since
-     * this counts as a success return value.
+    /*
+     * After cpu_copy, env->regwptr is pointing into old_env.
+     * Update the new cpu to use its own register window.
      */
-    env->regwptr[0] = 0;
+    env->regwptr = env->regbase + (env->cwp * 16);
+
+    /* Set a new stack, if requested.  */
+    if (newsp) {
+        env->regwptr[WREG_SP] = newsp;
+    }
+
+    /*
+     * Syscall return for clone child: %o0 = 0 and clear CF since
+     * this counts as a success return value.  %o1 = 1 to indicate
+     * this is the child.  Advance the PC past the syscall.
+     */
+    env->regwptr[WREG_O0] = 0;
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
     env->xcc &= ~PSR_CARRY;
 #else
     env->psr &= ~PSR_CARRY;
 #endif
+    env->regwptr[WREG_O1] = 1;
+    env->pc = env->npc;
+    env->npc = env->npc + 4;
+
+    /* Set the second return value for the parent: %o1 = 0.  */
+    old_env->regwptr[WREG_O1] = 0;
 }
 
 static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
-- 
2.17.1


