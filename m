Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A49C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A77A21929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbiWDEeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A77A21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0Gy-0000M3-Nx
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB06q-0008Kv-I2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iB05o-0000Ph-3V
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iB05n-0000PM-TO
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id p7so5558484wmp.4
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nw6PVinSAUrcIMGIAvVonphLXCK81yYui4fSQKYKk34=;
 b=kbiWDEeS8bEU+aWmEmLOdnmHVuNBhnaxbs48ebsvfYr5M/v6445NXOB9Ny3pkbAN+u
 eHjmnwLfYokPcl10SoOPq+DNfYHmYABY2elBuHcUlVT0tup0jZDkS61FTxswbzxXuIzK
 cAyjdw0I+Upo3Ufz90VBZGDR3X/+5f5skAaMs6wVunkE8gT48rro4G21DlTIAJdpEiJS
 Ze6AQqbUQVgWQJENv82ehEw8Uu9yhXUIFIdyRk8Oxu/JneUp7PHGoESwF90JjUITIb8L
 0PkUHfiiwjpfkt/nN+ilhHBCjVePCNDG98xqiLejgsWg8YBDbBR3GisGg/fQ/Hpy2YWd
 7Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nw6PVinSAUrcIMGIAvVonphLXCK81yYui4fSQKYKk34=;
 b=MhZjBfaqucrbskc5WSIVTUFpI2+gol7Q1YHG4TGjgdpZUpzoONL0ozD/7syJ1s17z8
 m4qz6PiW7lXDcQ+sIN9YC66ZskCVe++HyF8ytfS2nQtqGp6isvG+EnpUy4hvss3R15i7
 SMRPX3PU1XY5kAoGefz9WH9d5OU7rJVeW+UAZR6wYoGXCB87eM+7dt0shrbgmJKswEq4
 LmxF+ZtaCKgSKyovqDn7g7r1XO/gFdgpmG893bWT1qZl5EV5Z9npWIqCXMYKR6R79hAk
 NNqEsjuaDMOQiDanWmaT3hD4T2SNbpAaznYdKI7d3ibi/5eZV6Pcd+YfrT7z1y3/qzn0
 zl9g==
X-Gm-Message-State: APjAAAUKzIBgd/CIP08FdGtFz3DbyiY2bolio29r3hn9ubNUW6HRouHN
 MD4nGi/nkP7G4vPkE7ZFOKgE2A==
X-Google-Smtp-Source: APXvYqyl6u0J/I2jj3MAeQOmvKolQpw+46bO4Jks5FvsXaQ7u/GOb8UythoN0rPq1n3++B3yJ4MEAA==
X-Received: by 2002:a1c:99cd:: with SMTP id b196mr3629822wme.83.1568913582855; 
 Thu, 19 Sep 2019 10:19:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm17485610wrg.55.2019.09.19.10.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:19:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C9EBF1FF9B;
 Thu, 19 Sep 2019 18:10:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/16] tests/tcg: add simple record/replay smoke test for
 aarch64
Date: Thu, 19 Sep 2019 18:10:10 +0100
Message-Id: <20190919171015.12681-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds two new tests that re-use the memory test to check basic
record replay functionality is still working. We have to define our
own runners rather than using the default pattern as we want to change
the test name but re-use the memory binary.

We declare the test binaries as PHONY as they don't rely exist.

[AJB: A better test would output some sort of timer value or other
otherwise variable value so we could compare the record and replay
outputs and ensure they match]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 4c4aaf61dd3..b4b39579634 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -32,3 +32,24 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
 # Running
 QEMU_OPTS+=-M virt -cpu max -display none -semihosting-config enable=on,target=native,chardev=output -kernel
+
+# Simple Record/Replay Test
+.PHONY: memory-record
+run-memory-record: memory-record memory
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
+	   	  $(QEMU_OPTS) memory, \
+	  "$< on $(TARGET_NAME)")
+
+.PHONY: memory-replay
+run-memory-replay: memory-replay run-memory-record
+	$(call run-test, $<, \
+	  $(QEMU) -monitor none -display none \
+		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
+		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
+	   	  $(QEMU_OPTS) memory, \
+	  "$< on $(TARGET_NAME)")
+
+TESTS+=memory-record memory-replay
-- 
2.20.1


