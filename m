Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B12DECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067CB2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSEEGCeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067CB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Qn-0000Pw-IF
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mU-0002Fd-3s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mT-0001HJ-27
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37317)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mS-0001Gw-Ru
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id f22so2539233wmc.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/83Mz82BQKC2u+/lvppbKDVj/7fy2xgMuJWt2PPj2Lg=;
 b=KSEEGCeoveMK9GkSxAEWdQjoOO2vWedfYvN3GhrUzYrBzM1ytlI73EP69E11h7QTz5
 5qNJs0Y8pj7aiiX5xjQPDXARnAZw61FPWusYEgU9wxJUocDauPFSlJOk7Rn9CA2P+lTY
 HViSsFWuji7J1nVEs/8jcGQf/IqGKdceUMkMC2G9YX15khqfhoP0KEOhcHx7Paw9nF+J
 KCsFuZsAmkfvu+3XaqykrtW+g3jjDkvyJEOcbDHk8adaswRCb67o+CJWx6IV6rtE7qcM
 2Ze2oKo8ZO+x/TzITitf9eoGxMWG07mJ6VSP+ozIo2LxPuBOs5WYLc0MPIuz8Eb083iV
 0HPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/83Mz82BQKC2u+/lvppbKDVj/7fy2xgMuJWt2PPj2Lg=;
 b=kGywaAjAkDDa72efW+QSm/1FKKbRu4c+Jc+G84GPj0w+VNMjGz0Cnh8vbYolFUys9j
 7lm98liQGAxH2sSZYQ1aD1tv05EvuUKxAUcwNS3nUdJO9prCBLZqnxyKrODI1AloSYqe
 pll14yCGnEi7gJJwATSeAqpc5tZb04sfJ61xON4wDGWM+be51uEskxMAcq1xOMulXugN
 hEFmkZW+rIXSEymEqLoG0T6ZMc2VkSngNCfwFm46uFOl5JH2ZC8Gi7+Dz7wnqY0Xpts8
 Gw54452PWljNdY9pJKoZA3adtwcRkzBrncguWh+6QRlv95YzOlV61IGqMRTUQo2U3LcI
 leAQ==
X-Gm-Message-State: APjAAAURtxps9GSzURcSZbCVgCXKdnxV30qYcSa1hotwzlUmF35DwwlA
 fH6AKVLBQfW10N2mtMzIvLYt1A==
X-Google-Smtp-Source: APXvYqxE10Dyqk2H9XEP0ESBYEdRMbsIG1yaMhJRkzHt+x3MPFcm7CCEEBAOYATse9/hRJDks2cxsQ==
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr2986942wme.101.1571318727782; 
 Thu, 17 Oct 2019 06:25:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s10sm2421829wrr.5.2019.10.17.06.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 39B191FFC4;
 Thu, 17 Oct 2019 14:16:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 46/54] tests/tcg: drop test-i386-fprem from TESTS when not
 SLOW
Date: Thu, 17 Oct 2019 14:16:07 +0100
Message-Id: <20191017131615.19660-47-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a very slow running test which we only enable explicitly.
However having it in the TESTS lists would confuse additional tests
like the plugins test which want to run on all currently enabled
tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/i386/Makefile.target | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 08c5736a4d..43ee2e181e 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -7,10 +7,8 @@ VPATH 		+= $(I386_SRC)
 
 I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
 ALL_X86_TESTS=$(I386_SRCS:.c=)
-I386_TESTS:=$(filter-out test-i386-ssse3, $(ALL_X86_TESTS))
+SKIP_I386_TESTS=test-i386-ssse3
 X86_64_TESTS:=$(filter test-i386-ssse3, $(ALL_X86_TESTS))
-# Update TESTS
-TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
 
 #
 # hello-i386 is a barebones app
@@ -36,9 +34,12 @@ run-test-i386-fprem: test-i386-fprem test-i386-fprem.ref
 	$(call run-test,test-i386-fprem, $(QEMU) $<,"$< on $(TARGET_NAME)")
 	$(call diff-out,test-i386-fprem, test-i386-fprem.ref)
 else
-run-test-i386-fprem: test-i386-fprem
-	$(call skip-test, $<, "SLOW")
+SKIP_I386_TESTS+=test-i386-fprem
 endif
 
+# Update TESTS
+I386_TESTS:=$(filter-out $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
+TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
+
 # On i386 and x86_64 Linux only supports 4k pages (large pages are a different hack)
 EXTRA_RUNS+=run-test-mmap-4096
-- 
2.20.1


