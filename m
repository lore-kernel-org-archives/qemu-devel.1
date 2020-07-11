Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96961C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1966520786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNd4SAMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1966520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJ0e-00082H-2K
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyS-0003NM-8E
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyQ-0006hI-Az
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so8945832wrj.13
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OO5QET4LtmEfAVYxPO2I8IFA0YsWV4r+MxTZRfSVWs0=;
 b=UNd4SAMgmNKE4lxa3rqbPw26qbXY7peJGpfCyPDQLTQHNgydfzOD0Tl/m3JBkKOJpc
 AdPq/quto9L4pFuWf/oQ8UH43vPadSywzZSrPWLbhpy+m7GA5OeJD+Rm5hyRVSsbllYl
 On2SizG4QZl4NZRe8Y2WEYiZ0UTC+5GwuEl2vCD25yt9grK2BsJoEx7O2lF6VgX5mp7D
 PRoPAZSRw4EPkPFW3pZuyckOqAbXQRmvYWEKo1PaGKJ4sOrU/wkEanEvGXT2TmRwpgo6
 GnVmKI2roWaS05lBPZaXY4IkHqBCI4oL6erxC758i+VJKbqNemuUudAVao+lPHJ7D3N0
 ke5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OO5QET4LtmEfAVYxPO2I8IFA0YsWV4r+MxTZRfSVWs0=;
 b=e82oE2qj8c9vUogXp77P2BW+cMPCKCaUQrVNfFBkCBC088TxGi+8yiHqFvlo6s0fUC
 fjSZsGDjiJKXlKMyahddWdad8H0lp7Pka3KABrF3NVF1WYpnuNmUwef42OJ4tFJkjYei
 jbhSIRdB9IM4Hqxa6L+zknwgAfw5Lph74LQ6nwpddwR8ue3XB1PZ8Zt0OtvDirMY6T0t
 pXwnsXfcjkLHInWU6UVIFCSg0i2e1dwGFQg9h89qsABTqrMbfAvBtvt2S1lxLrtZzzzV
 nChTLVTGdIl2PgPdPOyGCmMEAAma/m6V6CbXNpuLzorLcj0Q02SDE0uSzdHq8lIvh9bq
 A3HQ==
X-Gm-Message-State: AOAM530FvCqADDgloURlsSiGqfzPVthEqz7Xm43cq7L+xsDKkPWf286P
 LeMh+gOHVYisytzMCtmOjot7aQ==
X-Google-Smtp-Source: ABdhPJyMrP0Fdtdp6MNFvl7zr2whETFWuyHh6fF+/Kw2RObkD/gHFuZ4GsuWlSy9pYro0EVDWLGEIA==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr73665988wrp.421.1594487256562; 
 Sat, 11 Jul 2020 10:07:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 65sm17571494wre.6.2020.07.11.10.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:07:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 514111FF8C;
 Sat, 11 Jul 2020 18:07:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 42/50] docs/devel: convert and update MTTCG design document
Date: Sat, 11 Jul 2020 18:07:24 +0100
Message-Id: <20200711170732.26213-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711170732.26213-1-alex.bennee@linaro.org>
References: <20200711170732.26213-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do a light conversion to .rst and clean-up some of the language at the
start now MTTCG has been merged for a while.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200709141327.14631-2-alex.bennee@linaro.org>

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index bb8238c5d6..4ecaea3643 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -23,6 +23,7 @@ Contents:
    decodetree
    secure-coding-practices
    tcg
+   multi-thread-tcg
    tcg-plugins
    bitops
    reset
diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.rst
similarity index 90%
rename from docs/devel/multi-thread-tcg.txt
rename to docs/devel/multi-thread-tcg.rst
index 3c85ac0eab..42158b77c7 100644
--- a/docs/devel/multi-thread-tcg.txt
+++ b/docs/devel/multi-thread-tcg.rst
@@ -1,15 +1,17 @@
-Copyright (c) 2015-2016 Linaro Ltd.
+..
+  Copyright (c) 2015-2020 Linaro Ltd.
 
-This work is licensed under the terms of the GNU GPL, version 2 or
-later. See the COPYING file in the top-level directory.
+  This work is licensed under the terms of the GNU GPL, version 2 or
+  later. See the COPYING file in the top-level directory.
 
 Introduction
 ============
 
-This document outlines the design for multi-threaded TCG system-mode
-emulation. The current user-mode emulation mirrors the thread
-structure of the translated executable. Some of the work will be
-applicable to both system and linux-user emulation.
+This document outlines the design for multi-threaded TCG (a.k.a MTTCG)
+system-mode emulation. user-mode emulation has always mirrored the
+thread structure of the translated executable although some of the
+changes done for MTTCG system emulation have improved the stability of
+linux-user emulation.
 
 The original system-mode TCG implementation was single threaded and
 dealt with multiple CPUs with simple round-robin scheduling. This
@@ -21,9 +23,18 @@ vCPU Scheduling
 ===============
 
 We introduce a new running mode where each vCPU will run on its own
-user-space thread. This will be enabled by default for all FE/BE
-combinations that have had the required work done to support this
-safely.
+user-space thread. This is enabled by default for all FE/BE
+combinations where the host memory model is able to accommodate the
+guest (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO is zero) and the
+guest has had the required work done to support this safely
+(TARGET_SUPPORTS_MTTCG).
+
+System emulation will fall back to the original round robin approach
+if:
+
+* forced by --accel tcg,thread=single
+* enabling --icount mode
+* 64 bit guests on 32 bit hosts (TCG_OVERSIZED_GUEST)
 
 In the general case of running translated code there should be no
 inter-vCPU dependencies and all vCPUs should be able to run at full
@@ -61,7 +72,9 @@ have their block-to-block jumps patched.
 Global TCG State
 ----------------
 
-### User-mode emulation
+User-mode emulation
+~~~~~~~~~~~~~~~~~~~
+
 We need to protect the entire code generation cycle including any post
 generation patching of the translated code. This also implies a shared
 translation buffer which contains code running on all cores. Any
@@ -78,9 +91,11 @@ patching.
 
 Code generation is serialised with mmap_lock().
 
-### !User-mode emulation
+!User-mode emulation
+~~~~~~~~~~~~~~~~~~~~
+
 Each vCPU has its own TCG context and associated TCG region, thereby
-requiring no locking.
+requiring no locking during translation.
 
 Translation Blocks
 ------------------
@@ -92,6 +107,7 @@ including:
 
   - debugging operations (breakpoint insertion/removal)
   - some CPU helper functions
+  - linux-user spawning it's first thread
 
 This is done with the async_safe_run_on_cpu() mechanism to ensure all
 vCPUs are quiescent when changes are being made to shared global
@@ -250,8 +266,10 @@ to enforce a particular ordering of memory operations from the point
 of view of external observers (e.g. another processor core). They can
 apply to any memory operations as well as just loads or stores.
 
-The Linux kernel has an excellent write-up on the various forms of
-memory barrier and the guarantees they can provide [1].
+The Linux kernel has an excellent `write-up
+<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/Documentation/memory-barriers.txt>`
+on the various forms of memory barrier and the guarantees they can
+provide.
 
 Barriers are often wrapped around synchronisation primitives to
 provide explicit memory ordering semantics. However they can be used
@@ -352,7 +370,3 @@ an exclusive lock which ensures all emulation is serialised.
 While the atomic helpers look good enough for now there may be a need
 to look at solutions that can more closely model the guest
 architectures semantics.
-
-==========
-
-[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/Documentation/memory-barriers.txt
-- 
2.20.1


