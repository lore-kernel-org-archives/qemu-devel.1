Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D68CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EC52070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIH2oiEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EC52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuKb-0003Rg-0e
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWh-0003iM-Bb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWf-0007pc-Uc
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWf-0007pE-O8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id l10so983894wrb.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IM9AIEWFnWYr+dGlYuXtMUTbYXcPB6llDCtSge/S8fc=;
 b=VIH2oiEp/wy3YZ5wZoh04MAH5xmvvzMudRNOAUaHimtCDcx0llxOTL/5HpwTAtRRHD
 idTArzv+gOiRqJ2xR08d+WHnhO7rTKinSPe2jQdsTCyc2zTzqzx5USw5cTxKxpwzXA/C
 uXyVD1xLDJk0+hmZCGDM1pFVKNPchBhxD4ds7UPXWAZb3f6Wv18BXa9h6lukoZJm5hqy
 vRruZgf/AuTwpm6vzq1oRfNW+9GwrmKxZrah9WsT1Dw5OB1mc/qCXBHAGbjHs/oVGECD
 ZXpl+B4Q/0/62YbTPK0mRmdmpywzTE5tKsZ/03+5fcMqUsyxfiPchDCZ4SCbZnnhtBKd
 mPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IM9AIEWFnWYr+dGlYuXtMUTbYXcPB6llDCtSge/S8fc=;
 b=HgMh2oeaRrxv5PgPazM57qp/ZR4frYMuLMfCHjIvlaC0S0fWQZMMxcPOXxidqdZMPk
 tcUGUQScvRwCuY9lyMKkyMuTfxl10GIIM5Ut16X7nX+y6tl9UzEEc2afWAL6uJFgI0x7
 xe6qE/vVMaG14sZBq9wTbzJ2VljS98ttgeZkjriII8MVnaawEoNBPfYdHu4heb9SBoZY
 FmINOGGWetB/jbKLo0szED3YeJJkCHj4poYk1+8kLI7nxJsKMwY1HBh/CzbWdoaHdsUl
 BFcsXGta651vLBSKNVmnMD393J/gaX9+zDwmtianqLVfe8gpuwUoPqxIwAsG9ML22zTE
 b0Eg==
X-Gm-Message-State: APjAAAWC9mEHfyN9a0bDyhYQFIP8dSmpUL2B8dWSTxRs6RYxr2/IAEfw
 Q7+RxBjfQsWe0M/hlAVo/LqfWw==
X-Google-Smtp-Source: APXvYqzOXOfUK+KXKICZ0IFhZOVLwkGhpzkJG5Avl6vcgX3s1hAg5J7jNxtI5RbDhLJTkuShPaGrYg==
X-Received: by 2002:adf:e882:: with SMTP id d2mr1405825wrm.132.1571986604620; 
 Thu, 24 Oct 2019 23:56:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d202sm1278016wmd.47.2019.10.24.23.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A663A1FF93;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 63/73] tests/tcg: drop test-i386-fprem from TESTS when not
 SLOW
Date: Fri, 25 Oct 2019 07:37:03 +0100
Message-Id: <20191025063713.23374-64-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
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

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 08c5736a4d4..43ee2e181e2 100644
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


