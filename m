Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C7AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AD22074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJcECKwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AD22074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXK4-0001tt-8Y
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIu-0000Ch-7T
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIs-0001KG-Aw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:35 -0400
Received: by mail-wm1-x343.google.com with SMTP id 17so1983484wmo.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vdk5UoE5LdEgYcDXZFPkkMaZLzAjEGlDyIOfyPLg77o=;
 b=OJcECKwXnq81b0jF+fH3+ni/W67kLpbHqjcPt4c+4pyD/TXUXvYeoRcW7akC+77oto
 y64ntRhuctGj9X0JBtU4OSJ6vPE3daLQVQ9+QnDF8kLEYIGJHQh0no/x/nOReAePILtA
 iQL4Gus9xPyU+pamzEHh+6gyeuf/q/4MDU3i7kir126Dk598txaCxo4EPXj2LnERaRTL
 hI/l3isJ/Rp5AOIj0neTu4Xyx78GUrRMk1oR9CH/bixnssdGaIIITAQ2bjwt7crCDeEd
 GcAydwWV/eCHHMtQW++kC/4VvaJpF8Ef22SaqGG11rhjOe8kaf4Cj9LlRtYv60oDNkTa
 /3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vdk5UoE5LdEgYcDXZFPkkMaZLzAjEGlDyIOfyPLg77o=;
 b=FIYjlhLq9CvbR0/+sKjhEGvX72aq6TPaO1oP24IFjWd0zbmp+pFqBEO5lUgyCHdRsp
 pzNjIwgkxGVhHCGGHwpLxHPcOJRFITug64PT2+/YOtdgOGOPc302Tufjm3y+WBenhCTR
 s2wLOZQXxP/YXsz4QrSYLHlaAxJUHWqfXePzncTTBJj3afEJ4N0Cm4c2qbN9Fzre8r0i
 usgs9VibZHu4t3cRjw+Xda1b+WH0POvVGrPepVeeZmYBr9SdeL05hHJpUTacdypr+9Jf
 Hh5UeEkTyLbjjD9lSG5iPB8PStKBEpKSP9uJuqUt+DLUIEswai4Q8jENTgm1OCkm7ogk
 ncEg==
X-Gm-Message-State: AOAM532HL4uIP80fPPnsQsr7a6jXMk/RipNmwLSbYChuV2WDvAL7ujHT
 3JDVWqnJAu1VJnNRWeML5LQbFg==
X-Google-Smtp-Source: ABdhPJxnZEK7HahvA4VA0uep2m8TvwGVchXXiNfgkO+o8ZE23LrRuwmT4ENgS1AVz6H0cUjNbChlyA==
X-Received: by 2002:a1c:2982:: with SMTP id p124mr274753wmp.26.1594304012896; 
 Thu, 09 Jul 2020 07:13:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm5166387wmf.3.2020.07.09.07.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 77ABC1FF87;
 Thu,  9 Jul 2020 15:13:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 01/13] docs/devel: convert and update MTTCG design document
Date: Thu,  9 Jul 2020 15:13:15 +0100
Message-Id: <20200709141327.14631-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709141327.14631-1-alex.bennee@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do a light conversion to .rst and clean-up some of the language at the
start now MTTCG has been merged for a while.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/index.rst                          |  1 +
 ...ti-thread-tcg.txt => multi-thread-tcg.rst} | 52 ++++++++++++-------
 2 files changed, 34 insertions(+), 19 deletions(-)
 rename docs/devel/{multi-thread-tcg.txt => multi-thread-tcg.rst} (90%)

diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index bb8238c5d6de..4ecaea3643fb 100644
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
index 3c85ac0eab9b..42158b77c707 100644
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


