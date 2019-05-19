Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B5C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B00420675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6fHeKMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B00420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52949 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSOB-0002XQ-9j
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:26:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHw-0005Zb-Rq
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHv-0007VW-Nb
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:08 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSHv-0007U9-Eh
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:07 -0400
Received: by mail-pg1-x543.google.com with SMTP id t1so4312941pgc.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=POxFIOq98+f7SlQ+Qq4/1i4zdlqYdJgB+ksVYwShoNE=;
	b=X6fHeKMuPiTfBuayn2n8h1uxIIh2MAHKNf+IDOTzogrsS7fSUfxRFCo60t02Dp+IGR
	2uGTqjHG+SmG1AWU9ij3988LS2vlCQNTvThjRm3IAABv7Go7Uzvg3oI2wWKsyr9XLPOF
	JiFM4mw6UwQXbMoozGgcL5bEqfA+L//akEaGia/NniMliiHbDdvm3ApR0+4li1NHIu+D
	jbxAveIMFxA0DPPc8S8Y3AzzizX3Tet53UmwoB8T1NLWAJ9Z+sCw51UswNVOf/Qw4biO
	Tq0ZTgJ2ii470/JkasUsQ3H1cFx+9UTcPJDQ5/USJdLXiMi8GLgmtubCnIVFdlwvhT/w
	s+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=POxFIOq98+f7SlQ+Qq4/1i4zdlqYdJgB+ksVYwShoNE=;
	b=B6juy526ERg0BTxRUaYu6pWE5pyeB49t2w8tolSI6ZEgUTiDsIACZ1aiZWNS2CcsdF
	il5LmS7hvbC6701jLNopH7kZGpr7hOh0+0XzpgxYofdTIj2Jl78zbAJeS0UCbDuQvTJg
	pxw1utZflTuBjKfoz+dYNwmM7Lpp0aJmZRkSQ9oVazCF7QV9A/AfrryL8UU2+BFc36XK
	uJCJdljd1e540ft1e/NY1biup5R4j9SioYzZ1WUombrzFGo94Fa7mQnU4qUOeYyQ8ZfI
	gMupenljUwGugmtqbgdXPbqa0hfRmGQ4/43+ElqZuQu9uQnEG3PpgINWVTltLahshk9H
	Mj/A==
X-Gm-Message-State: APjAAAW5rGWf+Wt5LWLt1Y0e0txO/3ZxbKygL1/v6SSFut1KtCIxTIkw
	zzGqwedu+55qXQeu+lOEZWjb+hV9z2g=
X-Google-Smtp-Source: APXvYqxi0omESB0dgC987/mSzbNezeqTbWDRhKm6vwOjslMpfVaWVTuV0mqKIiwiTUv/InY9bTAHFg==
X-Received: by 2002:a65:5244:: with SMTP id q4mr69698053pgp.79.1558297206298; 
	Sun, 19 May 2019 13:20:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.20.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:20:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:48 -0700
Message-Id: <20190519201953.20161-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 08/13] linux-user/sparc: Fix cpu_clone_regs
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
 linux-user/sparc/target_cpu.h | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 2c80db4889..a81f8216b7 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -22,22 +22,39 @@
 
 static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp)
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
+        /* ??? The kernel appears to copy one stack frame to the new stack. */
+        /* ??? The kernel force aligns the stack. */
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
 }
 
 static inline void cpu_clone_regs_parent(CPUSPARCState *env)
 {
+    /* Set the second return value for the parent: %o1 = 0.  */
+    env->regwptr[WREG_O1] = 0;
 }
 
 static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
-- 
2.17.1


