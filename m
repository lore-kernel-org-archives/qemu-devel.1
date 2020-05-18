Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2778EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53F920809
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdxQXuQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53F920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahkC-0001oo-48
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jahj3-0001FU-7d
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:30:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jahj1-0002RU-5c
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:30:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id w64so10955336wmg.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vCLcmE/2qrCu/RJGTSdkPN62jN38I/sXrjZE6/i1rXI=;
 b=gdxQXuQJgzSCPTd5m7GNMCKpqWVHHJHd95ZOoYiRGKea7MbuTBXOeE9QYPCTCTYjeO
 riaF5nkBhjylDlW57QXxShSodbNrNWMaqeO/MR0lXIoHqpczaNhTpkvTAHVRvq8j+bc7
 7nkZbwQqawCr+H0DWR5BAucEf95rnnfenB88uaGz6mOS7UlKkIKoC/r7RCuvWXUyN9B3
 dlVrqw7XR+Zwwl4EJ36U6IzlNY8KydesqELWdNwjvMyakWsRkiyG1fjO7CnLBFOj1ydS
 IGqyBImwj/p+F3FJyYO/Ry0RGGQA/fAudSsg2gnbtNP+Vp/7Iioo63sTaWCTNe0Jlop1
 9j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vCLcmE/2qrCu/RJGTSdkPN62jN38I/sXrjZE6/i1rXI=;
 b=eyNPyb9Mvo5bjKLpJueHob3vgsGk/5D0PDc+x657fHwKp62M637Lu9ORWIF3L+Zu0J
 6EkPTbt8SSQjxuRGoPOenzHVB+oOuzGnHLTZFoL3QJbiRp+2OCdSiWlXVD6WhMoIlrY0
 fAxXiD6QZG2CSzVpUuRrVpCJt3B7LFCuhNbUUAKkiv09DxxYcZe8tK1GBObCoywYx4bk
 HZDM2bxdU0EnKudYzrvqk6Yg/Ir1NChbvBGfGVLGDHwI9CUCh1PxBTIlXPmdfNsHVYHh
 QV7355Cu1jiMSXmsjYG4nQ+k9LVTi7gTZkqMZz/6g99Hu4en80KzZyxLtZOwyiSNiDsR
 Adbw==
X-Gm-Message-State: AOAM532Dnz9zya7NjTzmQYBpWQPFitYzqTCymNburFH6+tZOR+amQrEM
 GSZ15QT47Fftz4+RzYEFRJQTcQ==
X-Google-Smtp-Source: ABdhPJzdD09bJBXio+7jncerHNqNQj66bZOXBiEq1LlL8RIb1ooqC3G+K+zk+gUA+GKGG9tigcOgoA==
X-Received: by 2002:a1c:307:: with SMTP id 7mr9415619wmd.104.1589815839387;
 Mon, 18 May 2020 08:30:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c17sm17237837wrn.59.2020.05.18.08.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:30:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF21E1FF7E;
 Mon, 18 May 2020 16:30:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/tcg: fix invocation of the memory record/replay tests
Date: Mon, 18 May 2020 16:30:25 +0100
Message-Id: <20200518153025.13576-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not sure when this broke but we should use EXTRA_RUNS for
"virtual" tests which are not generated from the binary names.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 71f72cfbe34..efc642139c6 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -43,8 +43,7 @@ run-plugin-semiconsole-with-%: semiconsole
 	$(call skip-test, $<, "MANUAL ONLY")
 
 # Simple Record/Replay Test
-.PHONY: memory-record
-run-memory-record: memory-record memory
+run-memory-record: memory
 	$(call run-test, $<, \
 	  $(QEMU) -monitor none -display none \
 		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
@@ -52,8 +51,7 @@ run-memory-record: memory-record memory
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-.PHONY: memory-replay
-run-memory-replay: memory-replay run-memory-record
+run-memory-replay: memory run-memory-record
 	$(call run-test, $<, \
 	  $(QEMU) -monitor none -display none \
 		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
@@ -61,7 +59,7 @@ run-memory-replay: memory-replay run-memory-record
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-EXTRA_TESTS+=memory-record memory-replay
+EXTRA_RUNS+=run-memory-replay
 
 ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
 pauth-3: CFLAGS += -march=armv8.3-a
-- 
2.20.1


