Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441CBC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86422207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yiuQ8uNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86422207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMVk-0005ot-El
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMQC-0004K9-Od
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMQ5-0006EB-SP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id g4so6669287wrs.5
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DEVVZdY9bSpEyzZCcrt4wAUF84l4cqCakjvurZYUtQY=;
 b=yiuQ8uNZo0z4Y3bdSI9lQEBtwLxt6g1MeuVeOl/4rJQm4Rm1ixTcWozw9apgf79ybi
 BfSzEadLd9vGd3EqlVZ7lmXFxmTmV6XdgylfRMlT/vgzCi7GaewibikrIDWaTvGyjyce
 hiXVRSpe9we+0g4L/tzOHsUxx383a2CO99sWzSzJz2fK5DsoiLjj9m3uQB8KFnguB0lt
 n37Kzf3oxc5WsErIlj/M2UQX4yrmPvYR456u21K1mcS/WnKydnYMfA8dSMd5qo5lIPD4
 bLLQeqy29m+LhKURvDMUPTWdXLzX6ocDLG+f3cRlyu3Ct5akT0/mhqcS15Qf3RKY7tXE
 7NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DEVVZdY9bSpEyzZCcrt4wAUF84l4cqCakjvurZYUtQY=;
 b=oqZArA5eLL3SeBJaFcPm4X43gPW/RZyU5ohCEXXFt277O4aU6rZDBDicIaW76KCTWv
 CmJTQ2aWQVgQEJh+rCcsMC4NoPrVLXM4CI0aOUagvq3gwkVa9Nr2PEm3Uxsu+LakCzK6
 pCXSzpBauqrJKRAflfpI5e4nYRo12UWaSqR0OdD+3OvjrJ26cINRQ0bsx75nUTjn7gta
 5XUGd51b7eHDHHjaHIe4A323eh1kbL4gxgToxCKL/GhsHgE5naOv4ClWnLMWdS5SJWQm
 X0jqsDvG+9Biwx5c/8hJrCKFK8eB8+v8AN/duA+uNRDajP/mwwI+VX1G+DoO7OEzfjQK
 4idw==
X-Gm-Message-State: AOAM533T7bxsb2SjVgYHWvZMVCjDgCgekukTflDsX5IcsPy+1AjcPqsV
 /3gt8KWfzpnCqoTjsTE1FDrj0A==
X-Google-Smtp-Source: ABdhPJwvKfwDF18Kqv5bTpOqRs5FXsvIB3nE+brxCIs5XJ2dY71j/yJX3ucZBbOmeAEKvOwttwi9WQ==
X-Received: by 2002:a5d:414b:: with SMTP id c11mr2814713wrq.181.1599743719460; 
 Thu, 10 Sep 2020 06:15:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k6sm3511635wmf.30.2020.09.10.06.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:15:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1DBEC1FF96;
 Thu, 10 Sep 2020 14:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/10] tests: bump avocado version
Date: Thu, 10 Sep 2020 14:15:02 +0100
Message-Id: <20200910131504.11341-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910131504.11341-1-alex.bennee@linaro.org>
References: <20200910131504.11341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Willian Rampazzo <willianr@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

Reverse debugging test uses gdb remote client of avocado framework.
This client was fixed since the currently used version 76.
Therefore this patch bumps the version to 81 and fixes command
line version compatibility issue.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <159903462803.28509.16851113546106095750.stgit@pasha-ThinkPad-X280>
Message-Id: <20200908202352.298506-2-philmd@redhat.com>
Message-Id: <20200909112742.25730-9-alex.bennee@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f93e6112202..2baebc179e7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -127,7 +127,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
             --filter-by-tags-include-empty --filter-by-tags-include-empty-key \
             $(AVOCADO_TAGS) \
-            $(if $(GITLAB_CI),,--failfast=on) tests/acceptance, \
+            $(if $(GITLAB_CI),,--failfast) tests/acceptance, \
             "AVOCADO", "tests/acceptance")
 
 # Consolidated targets
diff --git a/tests/requirements.txt b/tests/requirements.txt
index f9c84b4ba1a..036691c9221 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,5 +1,5 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework==76.0
+avocado-framework==81.0
 pycdlib==1.9.0
-- 
2.20.1


