Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3F5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B12E20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elpUDqDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B12E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBEx-00017K-GB
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBDa-00080d-2q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:01:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBDY-0001bN-79
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:01:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id d128so2982213wmc.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fwzjDn90p+WbCyuUAz8JCmbSQbTpCjIg7lbls5LaIbw=;
 b=elpUDqDQP+voxX3qspI04niTK8yFVE1dggAHRwQTKX0A5/Vrbk99B94YXO9IzSDLOx
 esSt6/dIJYn89k2v3r35kSovlCRii7Ey6lVvlWEbUde2k1XfCA3Pa6usn6p0HH736aKS
 othSH7klSyZCwpyey+zcwef9JNQQxJFbz1LIXHW9+ed3CamFJ+5h7Rgigt1hSkbUm9IT
 6ppjVS6FUygyBe3RuUh1zZYQHtbNWRrEUzkYbkhCCuV/S0D718WEjSZf0Vb2E2W3/Wus
 V7x1pklaLB+CMNuZbkyvZQlr1zzaDi90m9cQ/zCSouysfTwTCKmhNROIkUSNOJ9Rvf1a
 RYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fwzjDn90p+WbCyuUAz8JCmbSQbTpCjIg7lbls5LaIbw=;
 b=pJzz12fPsDLrzxXjCjYErY0OLsr8J34Q4FQOFAYgtXDhV+7u8YGw9/WHJeDs/ANyFU
 YrmmEDifEAvQZr+tn3UPAgo0SijPKyQJbzh8CU1S5f0qq7McxASJC26DVLcrilzYP7BX
 R2A4Cp7fZupY5kh7ZgrbPgLnu9rOVqxObs8px/SVozLXjci2/aIhK/V81P289OOF88d1
 aUJm8PP5rs8aa3m1ILJoV5PZ8lgkGHIlNh44JEmW/6irQJGZEBxy3Ce3v500e+ZQQsoE
 DSfxAcEUlANTS3WqkJX92GGPZRP1UhyiVjxIFjIreQz3a4CyVBrnyvuwyWQ3k4+ryZx5
 uRFg==
X-Gm-Message-State: AOAM530Z778+k5R1YU+/hxh9+qkDBvQNiTd909gLnv6dlQ9Mv+KJaeZr
 XXb/xsjNm5gYRFdX8tcXKAWk3A==
X-Google-Smtp-Source: ABdhPJzU/VUzxEro/Rimu4LqD/mWd9yzL1TLgLR+QtBaEmBalVLuBE1ISU+gz3GmHQuLRb3aLjioGg==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr3105322wmg.63.1592312490172;
 Tue, 16 Jun 2020 06:01:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v6sm30963902wrf.61.2020.06.16.06.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 06:01:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 168C61FFA6;
 Tue, 16 Jun 2020 13:53:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 19/21] tests/tcg: build plugin list from contents of src
 directory
Date: Tue, 16 Jun 2020 13:53:22 +0100
Message-Id: <20200616125324.19045-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you jump back and forth between branches while developing plugins
you end up debugging failures caused by plugins left in the build
directory. Fix this by basing plugins on the source tree instead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200615141922.18829-2-alex.bennee@linaro.org>

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


