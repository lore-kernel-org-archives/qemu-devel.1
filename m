Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FD1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B308320748
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv1KVqjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B308320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jysGl-0000Dh-1L
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jysEv-0006Up-W7
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:35:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jysEu-0007iu-Gu
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:35:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id 88so7372752wrh.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 00:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7cMvOSWjQxG4l/hFTBITd2GgwV3T+QNXvLQiMS0D5/w=;
 b=Bv1KVqjdke+HgjClA6GsmwjCxFJ73Amu/nIf51e/IkET5Z4iq4dgfTOmKLUOHezaTf
 AVZBBMm1D70gGon5lbnRl7Qvq7MXAH8f0pj1McJo2lNbmVgYb2acJbOBPxU4weyGIOpM
 vKegew2ICkRaUgiIqkEE3PDM0IDl3FNIOXCOCLw5/saX6xDPpJ58P1p8FLcjf3GawD/z
 rL4nLErtqF1mbnxROaK5kPJNCKBDjuq7fLtN05tGGW7MwTfSvt7EXB5SHrfl0fw23V4P
 6e8oE5y89+JE0LxVGaYzz9C0kfy7zLLk9UzM/FtlWUOVME5sXEK6c5RW97QHikCbuAD4
 YtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7cMvOSWjQxG4l/hFTBITd2GgwV3T+QNXvLQiMS0D5/w=;
 b=MIjf1QwikTzk39OxmAT0Yb4fppWq/NZcK/QEBAwePNEQ7JEvipPTHvq7E0h3PbWayN
 SDKCw/HZftTMKDzZlHuPptKGpBvQyTkvpvZ/CxofoUjQChAjxw/mzJHONazwKp27XBwM
 yCE5tyAEB6rTCmwUCRg6/S+KsaHxDhZut8N/f+URslI4PE1VsXMp0Tu9A5Q/bZfV+Mf7
 LnB2RaDYxEnapXsYBiXUKVoI7ozg1HVFcykiLZ6FdOAvFfgyp0S+S8nFLufZq0JFizpe
 o6ZQl8vd7jFtiJ5og8p9KTlryfmu8m9u2lvIfRxigLpOcCvWXAN7jq11Gd2nhhmzI99i
 x5cg==
X-Gm-Message-State: AOAM530jL38BlWYe0OsMvHvoDBZnxhnB6EKaiVMqCRfXMS30IBkGEF6v
 VztkTznQFPkSpx/ZiRbH3Om+W4hNPEA=
X-Google-Smtp-Source: ABdhPJzTqPEzeH6IlT1krQuZC0KOlr2bN1QoVAqU/eXfxTVM5X45C7YuLFZZSnzza9VBfnnLUA4ljQ==
X-Received: by 2002:adf:a195:: with SMTP id u21mr7804146wru.296.1595576127822; 
 Fri, 24 Jul 2020 00:35:27 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y189sm7319431wmd.27.2020.07.24.00.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 00:35:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests: Add 'fetch-acceptance' rule
Date: Fri, 24 Jul 2020 09:35:23 +0200
Message-Id: <20200724073524.26589-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200724073524.26589-1-f4bug@amsat.org>
References: <20200724073524.26589-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <willianr@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a rule to fetch acceptance test assets.

This is particularly useful in a CI context, when a single job
can fetch and save the cache so other jobs reuse it directly.

It is also useful to measure the time spent downloading the
assets versus the time spent running the tests.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/Makefile.include | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c7e4646ded..238974d8da 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -944,6 +944,15 @@ get-vm-image-fedora-31-%: check-venv
 # download all vm images, according to defined targets
 get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_31_DOWNLOAD))
 
+# fetch acceptance test assets
+fetch-acceptance: check-venv
+	$(call quiet-command, \
+            $(TESTS_VENV_DIR)/bin/python -m avocado \
+            $(if $(V),--show=$(AVOCADO_SHOW)) \
+            assets fetch \
+            $(wildcard tests/acceptance/*.py), \
+            "AVOCADO", "tests/acceptance")
+
 check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 	$(call quiet-command, \
             $(TESTS_VENV_DIR)/bin/python -m avocado \
-- 
2.21.3


