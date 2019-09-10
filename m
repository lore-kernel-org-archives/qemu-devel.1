Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269E1C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E881D2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTpQxAdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E881D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lwJ-0002o3-KW
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lu1-0000vG-Kn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lu0-0006jh-9Q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:13 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:33750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7lu0-0006j7-1X
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id u16so21922418wrr.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5XyzKPTEVeMZHoyBnFttJunUqWTPcDprpKPpXz8/JuA=;
 b=vTpQxAdJ9xknXNw4aCUYvm+cIC5kA4DL2Qc14EeUWTGi+OAlGOtBRh95WXWVH94Jg3
 z28cpsdaComFtDOjngozTVfzXRtK2mFlUskHi+4aRV+z0PIozhy9SEBtjjmDJC8fksVv
 kFAxNjyTlNTrrcp5n1vL/RAAqRyEpPLJf+OW3jWdDBTyFADBwHXpDi6u0iQNEM3kDom0
 joq2XD/LHtZveyctgCqqWX258ApFKG7vY9rLaOVAeBqKmiJwVcuKk6UcyNIogbkHF4N1
 B2xcuQglqulqMic/nGsTKQYdCmUMa1UrjcPbUd1xZYu7Dwp2jSCG8bPssL2xkILzlPea
 /CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5XyzKPTEVeMZHoyBnFttJunUqWTPcDprpKPpXz8/JuA=;
 b=QgAmif/8OhwaRfKj6sXF5q7Jy6Rvb94AACgs8YG56zKGS8f6Zt3kF8UsjB36IGwzYJ
 F95cf/1gZJ15OeL21Jv7S431zVYa/8KljVvudipxfElr1hmx8E39ZGx1p60aq1xjQj8D
 WrlzH1sxPOxJOsNUBzQgsJnSasT9mb6TyBncsKQ1LUrGDhJoRo4Wqyw/RlOz6aQpjmfL
 2oBgkUdLl2hQ7U8DRENPqHr0J885OShMyZk7jVRTGAwsLcSrw2PD8t4CizO8+nOuyzu3
 l0aXN0xvDmMM59njiDYZ78pC4XKrJk2tBDCVT/ZyJjGuoTBjuEhGJxWSc8w+KczfxAwl
 otUw==
X-Gm-Message-State: APjAAAVGBbx6jirXqGjUkLWkLErqDjCiS6c9/9NHyOkRZ1y2pGiDaWev
 SIG4NMUDBqlNczd44Vj96k12Mw==
X-Google-Smtp-Source: APXvYqyCEDBd91xxb7wScgd6BO98tutxGsl8NiCoFSUi+jkVtPIhQG/gFY/KPz5APtxc3I94ACew/Q==
X-Received: by 2002:adf:dc43:: with SMTP id m3mr28062078wrj.118.1568144050368; 
 Tue, 10 Sep 2019 12:34:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l5sm491162wmj.4.2019.09.10.12.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 12:34:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BC91C1FF8C;
 Tue, 10 Sep 2019 20:34:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 20:34:05 +0100
Message-Id: <20190910193408.28917-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910193408.28917-1-alex.bennee@linaro.org>
References: <20190910193408.28917-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PATCH v1 1/4] target/ppc: fix signal delivery for
 ppc64abi32
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were incorrectly setting NIP resulting in a segfault. This fixes
linux-test for this ABI.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/ppc/signal.c             | 4 +++-
 tests/tcg/configure.sh              | 1 +
 tests/tcg/multiarch/Makefile.target | 5 -----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 619a56950df..5b82af6cb62 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -501,7 +501,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i, err = 0;
 #if defined(TARGET_PPC64)
     struct target_sigcontext *sc = 0;
+#if !defined(TARGET_ABI32)
     struct image_info *image = ((TaskState *)thread_cpu->opaque)->info;
+#endif
 #endif
 
     rt_sf_addr = get_sigframe(ka, env, sizeof(*rt_sf));
@@ -557,7 +559,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->gpr[5] = (target_ulong) h2g(&rt_sf->uc);
     env->gpr[6] = (target_ulong) h2g(rt_sf);
 
-#if defined(TARGET_PPC64)
+#if defined(TARGET_PPC64) && !defined(TARGET_ABI32)
     if (get_ppc64_abi(image) < 2) {
         /* ELFv1 PPC64 function pointers are pointers to OPD entries. */
         struct target_func_ptr *handler =
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 6c4a471aeae..e8a1a1495fc 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -54,6 +54,7 @@ fi
 : ${cross_cc_cflags_ppc="-m32"}
 : ${cross_cc_ppc64="powerpc-linux-gnu-gcc"}
 : ${cross_cc_cflags_ppc64="-m64"}
+: ${cross_cc_cflags_ppc64abi32="-mcpu=power8"}
 : ${cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"}
 : ${cross_cc_cflags_s390x="-m64"}
 : ${cross_cc_cflags_sparc="-m32 -mv8plus -mcpu=ultrasparc"}
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 6b1e30e2fec..e6893b2e283 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -12,11 +12,6 @@ VPATH 		+= $(MULTIARCH_SRC)
 MULTIARCH_SRCS   =$(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
 MULTIARCH_TESTS  =$(MULTIARCH_SRCS:.c=)
 
-# FIXME: ppc64abi32 linux-test seems to have issues but the other basic tests work
-ifeq ($(TARGET_NAME),ppc64abi32)
-BROKEN_TESTS = linux-test
-endif
-
 # Update TESTS
 TESTS		+= $(filter-out $(BROKEN_TESTS), $(MULTIARCH_TESTS))
 
-- 
2.20.1


