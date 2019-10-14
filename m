Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0546C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C5220673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xCi5jrcc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C5220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyMB-0001Op-DL
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvV-0007ZK-JC
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvU-0006JN-Fi
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvU-0006IC-9u
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id 5so16761870wmg.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7/acujaq0f8VIuYkCq8x2pbN5arCr0y/77PvQd1T9zw=;
 b=xCi5jrcctHYt6cJ8cWOqCxcCYDafzYCmO/vdDUoHooCaZraUHYgKJgmSvRchLli1XI
 C1ZrilPAq9oeh6Mu6RjWZomMJwbyrT+gz97iB9MT6NZD++9bXvhc9HjRHtSZNtF63cEZ
 PkFGKZuqS2Dp52Q9LecVVB6j+YoYxIH+2zQHFW0c/RpQxNUZWUbjvqukwwBYE0y9ajC8
 3j/yNDm1ZxX2RomVlRywlJ5Phn+zkN+YE3WnKzi+yvikloGCiTizL8ZW7kZb9XDqZO6m
 FmII10g+MpCSOukglXD57XQiEvaFlbs7q/QcWcqpX4URxqQ0Acm2o7U+Hf2gsfK+ZJZh
 tzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7/acujaq0f8VIuYkCq8x2pbN5arCr0y/77PvQd1T9zw=;
 b=DCOGh7b1wsntMNsxLNcOO3W9NwwS3wGD/b06Dw60CQWC17iKl2DarXNabHn2zJvwSu
 /N45Yg/KeZe0gH7nZX+2cFEiLza9YhN0ZOmGjHFAQ9ihKIcbSmhdT4VKCe1SbkX/MQ1r
 CWUa3dxXLyUYs690tanQoNPvgpI2CWGrkOgxqxakSOn73ZZ3dvaTeR2BRX2rsP7yS6Pk
 VuRZyWpUv2kCI8w8xYMyk/Hc1rLxTyhfEqmnOst/czT69KCLLSlNO02eRwn2nzkHBWT7
 4fowLP3mT1KnMAfEPkbTAoIgJKXnLlJJ8jtHlarssFYjvXRc7EDHHSveTV0jTjDaHymn
 64cQ==
X-Gm-Message-State: APjAAAXemIQFyg9PfbdeZfu+JDKCHcETdoAuRb538/bpcD2fIcvpYlHb
 DwIiokx08nIhlxJ0u+Mo05LU0g==
X-Google-Smtp-Source: APXvYqx9PQRKtSGe/rt3j+w1O6ITR+S1eu0iIkT3BmD13KTOKswiGYgZk4ZSbUlo3ZvotKtrduQsZQ==
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr13486037wmh.148.1571050207289; 
 Mon, 14 Oct 2019 03:50:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y186sm37048985wmd.26.2019.10.14.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:50:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8AB501FFCD;
 Mon, 14 Oct 2019 11:49:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 43/55] tests/tcg: drop test-i386-fprem from TESTS when not
 SLOW
Date: Mon, 14 Oct 2019 11:49:36 +0100
Message-Id: <20191014104948.4291-44-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
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


