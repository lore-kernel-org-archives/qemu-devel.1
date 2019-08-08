Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B06C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2225021881
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB8rBUr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2225021881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvlXt-0002Q7-EM
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 12:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTk-0004Ta-7L
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTi-0007e2-7t
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvlTh-0007aQ-Im
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id k2so9730848wrq.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cJ7b4qbxHqVbTw2rsvioZwlEmWolzTmmuvqu1NwPYKI=;
 b=UB8rBUr8ukI8R6l4C6lBKbeHFZ4hGmWH95TQrChszpTCHJWnIkPLFSD+DQmzJBIwNe
 v9pIueEK6FpFToRnuxPnEBeSRpP1DQ/Dk5fF5lIFVg+2nORMtIN+SwW8zQgAICEPvOzj
 P5+dWrBB9tFAhVtfKRhO0PkjdSoe9+I73RRchQyd2XBMKXKDC56rJoJKT0jWKvI3HF4I
 sEMCV1oDl5Z5KLbBtMdX+fm0SGEZd3F8S6Qpukb9S8KBumwBK7oMIdGaXXiECiADfCzF
 AUOxxYID9FbyijuHp0eroBKMlpCJQbvn6Be+I6/R/nY2EmKu5Fpp4tJa0FtxnkvQWtmL
 RwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cJ7b4qbxHqVbTw2rsvioZwlEmWolzTmmuvqu1NwPYKI=;
 b=YD8IGmyj1p08R/vWnEidaLlcAVjk5Q+rswtBTA+wKGgxrFEmio2VUuI5dkkAomj0Cz
 5ylo+TSI1X1dsRSPDHdorv2aqlYmVQ5bs/HnwgyWksvdRJQ2mHzu6WfjVMa4j9gkqqHg
 3bfV35KBi+ICG9vxzjbSxQUKhjNBYpNk4YbtmGcPiLXVLBexXZNBdCNEwLSPohaUXFNG
 BmEAHHXzBN6Fo628s3kTdOL6W2MpMqK3tyRe+dOPNbLLRezj2CtY+9xwox1tL5HW+VQI
 UihLMwSlQqs1DfOaUqOQmIocdsBWKITy9fGKvACn71gE7589lpQGrNKi85gY00T/KWpv
 q8+Q==
X-Gm-Message-State: APjAAAVtI8m1lh+7KSS579lptpqD89WIQFVgn0jyUiNAbWRYTTlN7ZfD
 IzDcPnG0yvltXTgg+LR0ZsifTw==
X-Google-Smtp-Source: APXvYqyL+VCFjSPpRggH8CjP4pPGzFzU5GCf43Qj/YCwM+greLywkxEEGmbsyDQz6H7TUUaL46MPiQ==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr17623099wrm.12.1565282483812; 
 Thu, 08 Aug 2019 09:41:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 66sm17049115wrc.83.2019.08.08.09.41.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 09:41:21 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4A4661FF87;
 Thu,  8 Aug 2019 17:41:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 17:41:17 +0100
Message-Id: <20190808164117.23348-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808164117.23348-1-alex.bennee@linaro.org>
References: <20190808164117.23348-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v1 7/7] targets (various): use
 softfloat-helpers.h where we can
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
Cc: David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, armbru@redhat.com,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generally the cpu and non-FP helper files just want to manipulate the
softfloat flags. For this they can just use the -helpers.h include
which brings in a minimal number of inline helpers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/alpha/helper.c   | 2 +-
 target/microblaze/cpu.c | 2 +-
 target/s390x/cpu.c      | 2 +-
 target/sh4/cpu.c        | 3 +--
 target/tricore/helper.c | 2 +-
 target/unicore32/cpu.c  | 1 -
 6 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 93b8e788b18..c6998348df4 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -21,7 +21,7 @@
 
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-types.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0bec54b2f8a..9cfd7445e7d 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -28,7 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-helpers.h"
 
 static const struct {
     const char *name;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 736a7903e22..5db016672bb 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -42,7 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #endif
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-helpers.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 816d6d7f311..d0a7707991f 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -25,8 +25,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
-
+#include "fpu/softfloat-helpers.h"
 
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index a6803368506..d5db7b2c03f 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -19,7 +19,7 @@
 
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-helpers.h"
 #include "qemu/qemu-print.h"
 
 enum {
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 802e2f1eba5..b27fb9689ff 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -17,7 +17,6 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
 
 static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.20.1


