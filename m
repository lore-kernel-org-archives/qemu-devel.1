Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBDAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1886B2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dxuey9eq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1886B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugTc-0001In-Mb
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRV-00008A-5Y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueRT-0003bv-U8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:48 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueRT-0003aW-N8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:30:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id t2so3585205wrr.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qrKLsGzcwT4O0/FyrfhzQShN36qKk5yXw+x77PWIwL4=;
 b=Dxuey9eqU8BNgN/rfOhMxwNOy+mhRShS/6av3JmBN7I0XtFWi8rmPENPxeW1heDf67
 dAUF2KAOs6Yy7Al92WyrudPdDNX116xnOUwGxLinRw+5LUCjNkdJfmGhMQ8pW1igrFxj
 eTgw98xdOmwgRy3C3GPNxasnv7B4W3AEnJkK45xYedpjgfJmvUX2XTL3MU5nA74/el/M
 51Flc6EiGJxK6/qFv7s6y+IhLgA4xe827TicpmGMy2DkC1bIF8lGcgcjsGkI3pIr7DQT
 cKOo9m5UkOZzDO2/34luOluLNELHwpeiqjSLC53LIo82tJk5yZxQj/T2CdoqZJFzuyX7
 myCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qrKLsGzcwT4O0/FyrfhzQShN36qKk5yXw+x77PWIwL4=;
 b=PFvAPRjFS4xeETI/7Zo0ClyarU3b8xl43+BNOZnacjjHDjpJRWBZPRR4hssEWY+0Iv
 iG42sneD4VU+G5B3hiFP2ZjV6f6hr/ONj9xTf/DkkSMvpvb0ItMK7dqzp5/WeK/QrVhG
 kt+teqts9XQ3PdF++ZaP/qrEmFYgKtIsfflDpKkGnnfczt70uunLrJeZm8yXEpA4NVta
 J0OxtrLUttLhGy3iK+AxUL3WD+8J2wxFrgGq8YtE4RgO/BG+9PCxBnRmAN9UXo3E4LLS
 gdJa72IXZPt7KQgyEtHTDW6ZcNF4DMZ7z/BU32dEEsevrXmmBLgEQLWa+3D+JoBawP10
 aPgg==
X-Gm-Message-State: APjAAAU5/voGLwI69uqUy1yA8IUh1ccRq7iDAgC+xpEVISxm7ddBRoNS
 peP/OpqDgKsWl1HEASHxOZBhYoK2ocnWsg==
X-Google-Smtp-Source: APXvYqzNz8I5w691LIQCjsdmO74oknmC2nn/EI/xXyWMgPWfQP2ha1i+1VZnS6qtHV+R0mXd3jE7FA==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr17349763wrp.378.1579793446506; 
 Thu, 23 Jan 2020 07:30:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm2903592wme.35.2020.01.23.07.30.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 07:30:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] tests/tcg/aarch64: Fix compilation parameters for pauth-%
Date: Thu, 23 Jan 2020 15:30:24 +0000
Message-Id: <20200123153041.4248-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153041.4248-1-peter.maydell@linaro.org>
References: <20200123153041.4248-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We were incorrectly requiring ARMv8.4 support for the pauth
tests, but Pointer Authentication is an ARMv8.3 extension.
Further, hiding the required architecture within asm() is
not correct.

Correct the architecture version requested, and specify it
in the cflags of the (cross-) compiler rather than in the asm.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200116230809.19078-3-richard.henderson@linaro.org
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target | 1 +
 tests/tcg/aarch64/pauth-1.c       | 2 --
 tests/tcg/aarch64/pauth-2.c       | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index df3fe8032c3..374c8d6830f 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -20,6 +20,7 @@ run-fcvt: fcvt
 # Pauth Tests
 AARCH64_TESTS += pauth-1 pauth-2
 run-pauth-%: QEMU_OPTS += -cpu max
+pauth-%: CFLAGS += -march=armv8.3-a
 
 # Semihosting smoke test for linux-user
 AARCH64_TESTS += semihosting
diff --git a/tests/tcg/aarch64/pauth-1.c b/tests/tcg/aarch64/pauth-1.c
index a3c1443cd07..ea0984ea823 100644
--- a/tests/tcg/aarch64/pauth-1.c
+++ b/tests/tcg/aarch64/pauth-1.c
@@ -2,8 +2,6 @@
 #include <sys/prctl.h>
 #include <stdio.h>
 
-asm(".arch armv8.4-a");
-
 #ifndef PR_PAC_RESET_KEYS
 #define PR_PAC_RESET_KEYS  54
 #define PR_PAC_APDAKEY     (1 << 2)
diff --git a/tests/tcg/aarch64/pauth-2.c b/tests/tcg/aarch64/pauth-2.c
index 2fe030ba3da..9bba0beb639 100644
--- a/tests/tcg/aarch64/pauth-2.c
+++ b/tests/tcg/aarch64/pauth-2.c
@@ -1,8 +1,6 @@
 #include <stdint.h>
 #include <assert.h>
 
-asm(".arch armv8.4-a");
-
 void do_test(uint64_t value)
 {
     uint64_t salt1, salt2;
-- 
2.20.1


