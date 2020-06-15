Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A8DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C5A2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2Mx2xqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C5A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkpyU-0003Lw-No
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jkpxR-0002O6-7c
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:19:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jkpxP-0004W6-DF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:19:28 -0400
Received: by mail-wm1-x32b.google.com with SMTP id o8so5395689wmh.4
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2vuTkiAEKZ/TtxdygoDdG5n+TZKhJ8ST8nk6O2rWnx0=;
 b=p2Mx2xqINjF7zGNhDfLRF1K53gLI7dbiytDZGuUa2tUgMYuKmkjRkacRJNS2vaQVpW
 lrUHdfgJH3GYx2m0kLCEZpMYO+a74H1xwatk6uphpxY/6jTysesAANM9afK89cfYIvHe
 JcY5pwbkxQbbdYA6cPgQUxR1MNcf7oy367aKDsHHatyJYp8Ofz8o8lxUP9SpVg5CSQBF
 P0VBUoiPFqoG9OSFAlImEj03ivYX4snWL6Sw5jhyya7Q4JJnIfPZzup2wd9Wh4Y703sh
 M5irDP7toAKFiuHPiltFymgTETxMIbe1+7p602vixHngMk5S2X1TT+YGwrCo+6uFBsXG
 J8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2vuTkiAEKZ/TtxdygoDdG5n+TZKhJ8ST8nk6O2rWnx0=;
 b=mgErCFZdtBp6XGbDZRW2MYe3ZcNusBx2H9hCGTmCT/vHAD3xisFH8ETTpRQYEhi0vF
 iEndwbBk9gCRh9AxEg5KHpWMvUBKgdDG48ivjdnYa/meK6J/ulLVhGC9hfVTlX5thJnn
 1UMcyH0VLmC9RJc00+Ki7Hc1eTwWcyaLpTGteLYqBoSCp/rOVaumZZ7o7brkomyiHpaU
 wiGDexOzlssVyvr4nCNk1yBOafQJz4ut2i0y0JXzGpD0eSy0/RCkUBOwLjZdwwsiSc9x
 +C9z1BLrjFlBu93uOGBsGuxYKW8tsRTw84ImSsBqbHA/l7yZW4uQZJ3po725kFEiqgrs
 NqeA==
X-Gm-Message-State: AOAM5302OSZLZVApIXB2sk2do1qoJSU5FHCS6HBaqBatRjaiamMt7z7G
 QyQdKzo6mxjEHuU/4oG3lM2lNA==
X-Google-Smtp-Source: ABdhPJzk9sgw2fhJ0G0PXRUeq9r5E/9FFs3Tp9KsSFnY2fNYjwNX+oX3hif70mVFQiPR1thWhAQc9A==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr14157790wmb.156.1592230765904; 
 Mon, 15 Jun 2020 07:19:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm27452688wrb.46.2020.06.15.07.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 07:19:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E14EA1FF87;
 Mon, 15 Jun 2020 15:19:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/2] tests/tcg: build plugin list from contents of src
 directory
Date: Mon, 15 Jun 2020 15:19:21 +0100
Message-Id: <20200615141922.18829-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200615141922.18829-1-alex.bennee@linaro.org>
References: <20200615141922.18829-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you jump back and forth between branches while developing plugins
you end up debugging failures caused by plugins left in the build
directory. Fix this by basing plugins on the source tree instead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target         | 11 ++++++-----
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/arm/Makefile.target     |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index b3cff3cad1a..2ae86776cdc 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -126,9 +126,10 @@ RUN_TESTS=$(patsubst %,run-%, $(TESTS))
 
 # If plugins exist also include those in the tests
 ifeq ($(CONFIG_PLUGIN),y)
-PLUGIN_DIR=../../plugin
-VPATH+=$(PLUGIN_DIR)
-PLUGINS=$(notdir $(wildcard $(PLUGIN_DIR)/*.so))
+PLUGIN_SRC=$(SRC_PATH)/tests/plugin
+PLUGIN_LIB=../../plugin
+VPATH+=$(PLUGIN_LIB)
+PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
@@ -152,7 +153,7 @@ run-%: %
 
 run-plugin-%:
 	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
-		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<), \
 	"$* on $(TARGET_NAME)")
@@ -168,7 +169,7 @@ run-plugin-%:
 	$(call run-test, $@, \
 	  $(QEMU) -monitor none -display none \
 		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
-	   	  -plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@) \
 	    	  -d plugin -D $*.pout \
 	   	  $(QEMU_OPTS) $(call strip-plugin,$<), \
 	  "$* on $(TARGET_NAME)")
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 312f36cde5f..6d60a2f2eed 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -31,7 +31,7 @@ run-semihosting: semihosting
 
 run-plugin-semihosting-with-%:
 	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
-		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@) \
 		 $(call strip-plugin,$<) 2> $<.err, \
 		"$< on $(TARGET_NAME) with $*")
 
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 3da09a38be7..ec951565626 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -45,7 +45,7 @@ run-semihosting-arm: semihosting-arm
 
 run-plugin-semihosting-with-%:
 	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
-		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@) \
 		 $(call strip-plugin,$<) 2> $<.err, \
 		"$< on $(TARGET_NAME) with $*")
 
-- 
2.20.1


