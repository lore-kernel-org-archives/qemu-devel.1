Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D9CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C35207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4fE8vIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C35207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaieL-0003Ns-1C
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaide-0002SP-QO
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:29:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaidd-0002S2-Eo
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:29:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id w64so166064wmg.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oqwd7xOkTr10CCzSsW3fU0ZklZqmukQsONlL8X8yYEM=;
 b=o4fE8vItFrG+xGEOTJnHI2OA/FaR9tW286cUXTASvsi8gQ04QfhF4lC2ATNAkSfvcV
 tle8nXij5l0U8IDNIBxZc8wDUodMjYl3Kc9aCRJ0lOQTtGl7dQWMlkRWl8VPJ7GqA+ly
 EDcmh2OoeovRddW1aqGiejsnzgrYS4KDFQJZRSeRxQz+oVCFokdxWhoUlgUPdLEKmgEg
 RFzOfN9Ksz9l4Hhk996ucFLFyml2gYEAaHCznR5MLylBXSw9V408FvBgzOSJtBXAlWL5
 z2TYonYOyVOetVKfi9NUaUA8Fq3EoV/UfcK2rGKT1QmZXBcUQDkcx8AFjg2EC4ibgKrs
 VAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oqwd7xOkTr10CCzSsW3fU0ZklZqmukQsONlL8X8yYEM=;
 b=Wo4G2uUfRIxs40Ic1XMhPtJ9/ilOzPfRNMY0/+7xUDK7I95eOcv0CGvJaFOdcDSoLl
 4w6zJEp01aFkgyz0Sa15Z0/+3twNmrfQfsNPk2W6SdF9Slr4/27xwocaZGHb8nu3vYAN
 XfXCjgurnThByyUgGE+k6UCmuh/0DpYsUlKutEBhkano+g004I3ujteh34q9VVQfFg12
 fWrQR8+Jq8zG2Uoj1vF0fQeRGAsYF9HYneiTMEBTMpn//852FPKbpJEQNR1q3n1DCqav
 7gkDrzWvvsf7P1pK51GHKvz2HIh216VBOh+4fccvGXszPA9ozh9rL7QBYtiq6uAH6Mab
 D2hQ==
X-Gm-Message-State: AOAM5319+onuLwizAeNI08MrrvND00MCJGwTx0EjyLNOqthK3KeCymRb
 IE2CkrGkCg0krBNik4Ux3wJZQA==
X-Google-Smtp-Source: ABdhPJw0VptM4NSwg8IXAHbmelETtIIgTqhMp/YCUdCCb8c3XOs9jyN1SMJs5GVij/J3SsKy06u2CA==
X-Received: by 2002:a1c:6706:: with SMTP id b6mr222097wmc.54.1589819351918;
 Mon, 18 May 2020 09:29:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q2sm16732400wrx.60.2020.05.18.09.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:29:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2FC291FF7E;
 Mon, 18 May 2020 17:29:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] tests/tcg: fix invocation of the memory record/replay tests
Date: Mon, 18 May 2020 17:29:03 +0100
Message-Id: <20200518162903.883-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
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
v2
  - keep the PHONY's for the benefit of output
---
 tests/tcg/aarch64/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 71f72cfbe34..1057a8ac498 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -61,7 +61,7 @@ run-memory-replay: memory-replay run-memory-record
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-EXTRA_TESTS+=memory-record memory-replay
+EXTRA_RUNS+=run-memory-replay
 
 ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
 pauth-3: CFLAGS += -march=armv8.3-a
-- 
2.20.1


